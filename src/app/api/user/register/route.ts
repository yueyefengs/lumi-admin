import { NextRequest, NextResponse } from 'next/server'
import { db } from '@/lib/db'
import * as bcrypt from 'bcryptjs'
import { z } from 'zod'

// 注册表单验证schema
const registerSchema = z.object({
  username: z.string().min(3, '用户名至少3个字符').max(50, '用户名最多50个字符'),
  password: z.string().min(6, '密码至少6个字符'),
  email: z.string().email('无效的邮箱格式').optional().nullable()
})

// POST /api/user/register - 用户注册
export async function POST(req: NextRequest) {
  try {
    const body = await req.json()

    // 验证表单数据
    const result = registerSchema.safeParse(body)
    if (!result.success) {
      const errors = result.error.errors.map(error => `${error.path}: ${error.message}`).join(', ')
      return NextResponse.json(
        { code: 400, msg: '数据验证失败', errors },
        { status: 400 }
      )
    }

    const { username, password, email } = result.data

    // 检查用户名是否已存在
    const existingUser = await db.user.findUnique({
      where: { username }
    })

    if (existingUser) {
      return NextResponse.json(
        { code: 400, msg: '用户名已存在' },
        { status: 400 }
      )
    }

    // 加密密码
    const hashedPassword = await bcrypt.hash(password, 10)

    // 创建用户
    const user = await db.user.create({
      data: {
        username,
        password: hashedPassword,
        email,
        role: 'user', // 默认角色
        status: 1 // 启用状态
      },
      select: {
        id: true,
        username: true,
        email: true,
        role: true,
        status: true,
        createdAt: true
      }
    })

    return NextResponse.json({
      code: 0,
      data: user,
      msg: '注册成功'
    })
  } catch (error) {
    console.error('注册失败:', error)
    return NextResponse.json(
      { code: 500, msg: '注册失败', error: (error as Error).message },
      { status: 500 }
    )
  }
} 