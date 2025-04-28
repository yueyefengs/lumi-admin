import { NextRequest, NextResponse } from 'next/server'
import { db } from '@/lib/db'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'
import * as bcrypt from 'bcryptjs'

// GET /api/admin/users - 获取用户列表
export async function GET(req: NextRequest) {
  try {
    const session = await getServerSession(authOptions)
    if (!session) {
      return NextResponse.json({ error: '未授权访问' }, { status: 401 })
    }

    if (session.user.role !== 'admin') {
      return NextResponse.json({ error: '权限不足' }, { status: 403 })
    }

    const searchParams = req.nextUrl.searchParams
    const page = parseInt(searchParams.get('page') || '1')
    const pageSize = parseInt(searchParams.get('pageSize') || '10')
    const username = searchParams.get('username') || undefined

    const skip = (page - 1) * pageSize

    // 构建查询条件
    const where: any = {}
    
    if (username) {
      where.username = {
        contains: username
      }
    }

    // 获取总数
    const total = await db.user.count({ where })
    
    // 查询数据
    const users = await db.user.findMany({
      where,
      select: {
        id: true,
        username: true,
        email: true,
        role: true,
        status: true,
        createdAt: true,
        updatedAt: true
      },
      orderBy: {
        id: 'asc'
      },
      skip,
      take: pageSize
    })

    return NextResponse.json({
      code: 0,
      data: {
        list: users,
        pagination: {
          current: page,
          pageSize,
          total
        }
      },
      msg: '获取成功'
    })
  } catch (error) {
    console.error('获取用户列表失败:', error)
    return NextResponse.json(
      { code: 500, msg: '获取用户列表失败', error: (error as Error).message },
      { status: 500 }
    )
  }
}

// POST /api/admin/users - 添加或更新用户
export async function POST(req: NextRequest) {
  try {
    const session = await getServerSession(authOptions)
    if (!session) {
      return NextResponse.json({ error: '未授权访问' }, { status: 401 })
    }

    if (session.user.role !== 'admin') {
      return NextResponse.json({ error: '权限不足' }, { status: 403 })
    }

    const body = await req.json()

    // 验证必要字段
    if (!body.username) {
      return NextResponse.json({ error: '缺少必要字段' }, { status: 400 })
    }

    // 如果是更新用户
    if (body.id) {
      const id = parseInt(body.id)
      
      // 检查用户是否存在
      const existingUser = await db.user.findUnique({
        where: { id }
      })

      if (!existingUser) {
        return NextResponse.json({ error: '用户不存在' }, { status: 404 })
      }

      const updateData: any = {
        username: body.username,
        email: body.email,
        role: body.role,
        status: body.status !== undefined ? body.status : existingUser.status
      }

      // 如果提供了新密码，则更新密码
      if (body.password) {
        updateData.password = await bcrypt.hash(body.password, 10)
      }

      const updatedUser = await db.user.update({
        where: { id },
        data: updateData,
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

      return NextResponse.json({
        code: 0,
        data: updatedUser,
        msg: '更新成功'
      })
    } 
    // 创建新用户
    else {
      // 验证必要字段
      if (!body.password) {
        return NextResponse.json({ error: '缺少密码' }, { status: 400 })
      }

      // 检查用户名是否已存在
      const existingUser = await db.user.findUnique({
        where: { username: body.username }
      })

      if (existingUser) {
        return NextResponse.json({ error: '用户名已存在' }, { status: 400 })
      }

      const hashedPassword = await bcrypt.hash(body.password, 10)

      const newUser = await db.user.create({
        data: {
          username: body.username,
          password: hashedPassword,
          email: body.email,
          role: body.role || 'user',
          status: body.status !== undefined ? body.status : 1
        },
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

      return NextResponse.json({
        code: 0,
        data: newUser,
        msg: '创建成功'
      })
    }
  } catch (error) {
    console.error('操作用户失败:', error)
    return NextResponse.json(
      { code: 500, msg: '操作用户失败', error: (error as Error).message },
      { status: 500 }
    )
  }
} 