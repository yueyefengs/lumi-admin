import { NextRequest, NextResponse } from 'next/server'
import { db } from '@/lib/db'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'

// GET /api/agent/template - 获取角色模板列表
export async function GET(req: NextRequest) {
  try {
    const session = await getServerSession(authOptions)
    if (!session) {
      return NextResponse.json({ error: '未授权访问' }, { status: 401 })
    }

    const searchParams = req.nextUrl.searchParams
    const id = searchParams.get('id')

    // 如果指定了ID，返回单个模板详情
    if (id) {
      const templateId = parseInt(id)
      if (isNaN(templateId)) {
        return NextResponse.json({ error: '无效的ID' }, { status: 400 })
      }

      const template = await db.agentTemplate.findUnique({
        where: { id: templateId }
      })

      if (!template) {
        return NextResponse.json({ error: '模板不存在' }, { status: 404 })
      }

      return NextResponse.json({
        code: 0,
        data: template,
        msg: '获取成功'
      })
    }

    // 否则返回所有模板
    const templates = await db.agentTemplate.findMany({
      orderBy: {
        updatedAt: 'desc'
      }
    })

    return NextResponse.json({
      code: 0,
      data: templates,
      msg: '获取成功'
    })
  } catch (error) {
    console.error('获取角色模板失败:', error)
    return NextResponse.json(
      { code: 500, msg: '获取角色模板失败', error: (error as Error).message },
      { status: 500 }
    )
  }
}

// POST /api/agent/template - 创建角色模板
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
    if (!body.name || !body.template) {
      return NextResponse.json({ error: '缺少必要字段' }, { status: 400 })
    }

    // 检查是否存在同名模板
    const existingTemplate = await db.agentTemplate.findFirst({
      where: { name: body.name }
    })

    if (existingTemplate) {
      return NextResponse.json({ error: '模板名称已存在' }, { status: 400 })
    }

    // 创建新模板
    let template = body.template
    if (typeof template === 'object') {
      template = JSON.stringify(template)
    }

    const newTemplate = await db.agentTemplate.create({
      data: {
        name: body.name,
        description: body.description,
        template: template
      }
    })

    return NextResponse.json({
      code: 0,
      data: newTemplate,
      msg: '创建成功'
    })
  } catch (error) {
    console.error('创建角色模板失败:', error)
    return NextResponse.json(
      { code: 500, msg: '创建角色模板失败', error: (error as Error).message },
      { status: 500 }
    )
  }
} 