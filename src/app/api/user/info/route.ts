import { NextRequest, NextResponse } from 'next/server'
import { db } from '@/lib/db'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'
import * as bcrypt from 'bcryptjs'

// GET /api/user/info - 获取当前用户信息
export async function GET() {
  try {
    const session = await getServerSession(authOptions)
    if (!session || !session.user) {
      return NextResponse.json(
        { code: 401, msg: '未登录' },
        { status: 401 }
      )
    }

    const userId = parseInt(session.user.id)
    const user = await db.user.findUnique({
      where: { id: userId },
      select: {
        id: true,
        username: true,
        email: true,
        role: true,
        status: true,
        createdAt: true,
        updatedAt: true
      }
    })

    if (!user) {
      return NextResponse.json(
        { code: 404, msg: '用户不存在' },
        { status: 404 }
      )
    }

    // 检查用户状态
    if (user.status !== 1) {
      return NextResponse.json(
        { code: 403, msg: '用户已被禁用' },
        { status: 403 }
      )
    }

    return NextResponse.json({
      code: 0,
      data: user,
      msg: '获取成功'
    })
  } catch (error) {
    console.error('获取用户信息失败:', error)
    return NextResponse.json(
      { code: 500, msg: '获取用户信息失败', error: (error as Error).message },
      { status: 500 }
    )
  }
}

// PUT /api/user/info - 更新当前用户信息
export async function PUT(req: NextRequest) {
  try {
    const session = await getServerSession(authOptions)
    if (!session || !session.user) {
      return NextResponse.json(
        { code: 401, msg: '未登录' },
        { status: 401 }
      )
    }

    const userId = parseInt(session.user.id)
    const user = await db.user.findUnique({
      where: { id: userId }
    })

    if (!user) {
      return NextResponse.json(
        { code: 404, msg: '用户不存在' },
        { status: 404 }
      )
    }

    const body = await req.json()
    const updateData: any = {}

    // 可更新的字段
    if (body.email !== undefined) {
      updateData.email = body.email
    }

    // 如果要更新密码，需要验证旧密码
    if (body.oldPassword && body.newPassword) {
      const isValidPassword = await bcrypt.compare(body.oldPassword, user.password)
      if (!isValidPassword) {
        return NextResponse.json(
          { code: 400, msg: '旧密码错误' },
          { status: 400 }
        )
      }

      // 验证新密码长度
      if (body.newPassword.length < 6) {
        return NextResponse.json(
          { code: 400, msg: '新密码至少6个字符' },
          { status: 400 }
        )
      }

      updateData.password = await bcrypt.hash(body.newPassword, 10)
    }

    // 如果没有要更新的内容
    if (Object.keys(updateData).length === 0) {
      return NextResponse.json(
        { code: 400, msg: '没有要更新的内容' },
        { status: 400 }
      )
    }

    // 更新用户信息
    const updatedUser = await db.user.update({
      where: { id: userId },
      data: updateData,
      select: {
        id: true,
        username: true,
        email: true,
        role: true,
        status: true,
        updatedAt: true
      }
    })

    return NextResponse.json({
      code: 0,
      data: updatedUser,
      msg: '更新成功'
    })
  } catch (error) {
    console.error('更新用户信息失败:', error)
    return NextResponse.json(
      { code: 500, msg: '更新用户信息失败', error: (error as Error).message },
      { status: 500 }
    )
  }
} 