import { NextRequest, NextResponse } from 'next/server'
import { db } from '@/lib/db'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'

// GET /api/admin/params/page - 获取系统参数列表
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
    const name = searchParams.get('name') || undefined

    const skip = (page - 1) * pageSize

    // 构建查询条件
    const where: any = {}
    
    if (name) {
      where.name = {
        contains: name
      }
    }

    // 获取总数
    const total = await db.config.count({ where })
    
    // 查询数据
    const configs = await db.config.findMany({
      where,
      select: {
        id: true,
        name: true,
        value: true,
        type: true,
        desc: true,
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
        list: configs,
        pagination: {
          current: page,
          pageSize,
          total
        }
      },
      msg: '获取成功'
    })
  } catch (error) {
    console.error('获取系统参数列表失败:', error)
    return NextResponse.json(
      { code: 500, msg: '获取系统参数列表失败', error: (error as Error).message },
      { status: 500 }
    )
  }
}

// POST /api/admin/params/page - 添加或更新系统参数
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
    if (!body.name || body.value === undefined) {
      return NextResponse.json({ error: '缺少必要字段' }, { status: 400 })
    }

    // 检查是否已存在
    const existingConfig = await db.config.findUnique({
      where: { name: body.name }
    })

    let result

    if (existingConfig) {
      // 更新参数
      result = await db.config.update({
        where: { name: body.name },
        data: {
          value: body.value.toString(),
          type: body.type || existingConfig.type,
          desc: body.desc
        }
      })
    } else {
      // 创建新参数
      result = await db.config.create({
        data: {
          name: body.name,
          value: body.value.toString(),
          type: body.type || 'string',
          desc: body.desc
        }
      })
    }

    return NextResponse.json({
      code: 0,
      data: result,
      msg: existingConfig ? '更新成功' : '创建成功'
    })
  } catch (error) {
    console.error('操作系统参数失败:', error)
    return NextResponse.json(
      { code: 500, msg: '操作系统参数失败', error: (error as Error).message },
      { status: 500 }
    )
  }
} 