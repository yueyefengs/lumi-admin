import { NextResponse } from 'next/server'
import { db } from '@/lib/db'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'

// GET /api/agent/all - 获取所有角色（不分页）
export async function GET() {
  try {
    const session = await getServerSession(authOptions)
    if (!session) {
      return NextResponse.json({ error: '未授权访问' }, { status: 401 })
    }

    // 查询所有激活的角色
    const agents = await db.agent.findMany({
      where: {
        isActive: true
      },
      select: {
        id: true,
        name: true,
        avatar: true,
        description: true
      },
      orderBy: {
        id: 'asc'
      }
    })

    return NextResponse.json({
      code: 0,
      data: agents,
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