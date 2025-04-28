import { NextRequest, NextResponse } from 'next/server'
import { db } from '@/lib/db'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'

// GET /api/agent/list - 获取角色列表
export async function GET(req: NextRequest) {
  try {
    const session = await getServerSession(authOptions)
    if (!session) {
      return NextResponse.json({ error: '未授权访问' }, { status: 401 })
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
    const total = await db.agent.count({ where })
    
    // 查询数据
    const agents = await db.agent.findMany({
      where,
      select: {
        id: true,
        name: true,
        avatar: true,
        description: true,
        isActive: true,
        createdAt: true,
        updatedAt: true,
        _count: {
          select: { 
            devices: true,
            agentModels: true
          }
        }
      },
      orderBy: {
        updatedAt: 'desc'
      },
      skip,
      take: pageSize
    })

    return NextResponse.json({
      code: 0,
      data: {
        list: agents,
        pagination: {
          current: page,
          pageSize,
          total
        }
      },
      msg: '获取成功'
    })
  } catch (error) {
    console.error('获取角色列表失败:', error)
    return NextResponse.json(
      { code: 500, msg: '获取角色列表失败', error: (error as Error).message },
      { status: 500 }
    )
  }
} 