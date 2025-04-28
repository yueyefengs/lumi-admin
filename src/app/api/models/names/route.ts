import { NextResponse } from 'next/server'
import { db } from '@/lib/db'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'

// GET /api/models/names - 获取模型名称列表
export async function GET() {
  try {
    const session = await getServerSession(authOptions)
    if (!session) {
      return NextResponse.json({ error: '未授权访问' }, { status: 401 })
    }

    const models = await db.model.findMany({
      where: { isActive: true },
      select: {
        id: true,
        name: true,
        type: true,
        provider: true
      },
      orderBy: {
        type: 'asc'
      }
    })

    // 按照类型进行分组
    const groupedModels = models.reduce((acc, model) => {
      const { type } = model
      if (!acc[type]) {
        acc[type] = []
      }
      acc[type].push(model)
      return acc
    }, {} as Record<string, typeof models>)

    return NextResponse.json({
      code: 0,
      data: groupedModels,
      msg: '获取成功'
    })
  } catch (error) {
    console.error('获取模型名称失败:', error)
    return NextResponse.json(
      { code: 500, msg: '获取模型名称失败', error: (error as Error).message },
      { status: 500 }
    )
  }
} 