import { NextRequest, NextResponse } from 'next/server'
import { db } from '@/lib/db'
import * as bcrypt from 'bcryptjs'
import { z } from 'zod'
import { verifyCaptcha } from '@/lib/captchaUtils'
import { SignJWT } from 'jose'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'

// 登录表单验证schema
const loginSchema = z.object({
  username: z.string().min(1, '用户名不能为空'),
  password: z.string().min(1, '密码不能为空'),
  captchaId: z.string().optional(),
  captchaCode: z.string().optional()
})

// POST /api/user/login - 用户登录
export async function POST(req: NextRequest) {
  try {
    const body = await req.json()

    // 验证表单数据
    const result = loginSchema.safeParse(body)
    if (!result.success) {
      const errors = result.error.errors.map(error => `${error.path}: ${error.message}`).join(', ')
      return NextResponse.json(
        { code: 400, msg: '数据验证失败', errors },
        { status: 400 }
      )
    }

    const { username, password, captchaId, captchaCode } = result.data

    // 如果提供了验证码，则验证
    if (captchaId && captchaCode) {
      const isCaptchaValid = verifyCaptcha(captchaId, captchaCode)
      if (!isCaptchaValid) {
        return NextResponse.json(
          { code: 400, msg: '验证码错误或已过期' },
          { status: 400 }
        )
      }
    }

    // 查找用户
    const user = await db.user.findUnique({
      where: { username }
    })

    if (!user) {
      return NextResponse.json(
        { code: 401, msg: '用户名或密码错误' },
        { status: 401 }
      )
    }

    // 检查用户状态
    if (user.status !== 1) {
      return NextResponse.json(
        { code: 403, msg: '用户已被禁用' },
        { status: 403 }
      )
    }

    // 验证密码
    const isValidPassword = await bcrypt.compare(password, user.password)
    if (!isValidPassword) {
      return NextResponse.json(
        { code: 401, msg: '用户名或密码错误' },
        { status: 401 }
      )
    }

    // 创建用户会话 (通过NextAuth，实际会话创建在登录页面完成)
    const userData = {
      id: user.id,
      username: user.username,
      email: user.email,
      role: user.role
    }

    return NextResponse.json({
      code: 0,
      data: userData,
      msg: '登录成功'
    })
  } catch (error) {
    console.error('登录失败:', error)
    return NextResponse.json(
      { code: 500, msg: '登录失败', error: (error as Error).message },
      { status: 500 }
    )
  }
}

// GET /api/user/login - 检查登录状态
export async function GET() {
  try {
    const session = await getServerSession(authOptions)
    if (!session || !session.user) {
      return NextResponse.json(
        { code: 401, msg: '未登录', data: null },
        { status: 401 }
      )
    }

    const user = await db.user.findUnique({
      where: { id: parseInt(session.user.id) },
      select: {
        id: true,
        username: true,
        email: true,
        role: true,
        status: true
      }
    })

    if (!user || user.status !== 1) {
      return NextResponse.json(
        { code: 403, msg: '用户已被禁用', data: null },
        { status: 403 }
      )
    }

    return NextResponse.json({
      code: 0,
      data: {
        id: user.id,
        username: user.username,
        email: user.email,
        role: user.role
      },
      msg: '已登录'
    })
  } catch (error) {
    console.error('获取登录状态失败:', error)
    return NextResponse.json(
      { code: 500, msg: '获取登录状态失败', error: (error as Error).message },
      { status: 500 }
    )
  }
} 