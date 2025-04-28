import { NextRequest, NextResponse } from 'next/server'
import { db } from '@/lib/db'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'

// GET /api/models/{id} - 获取模型详情
export async function GET(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const session = await getServerSession(authOptions)
    if (!session) {
      return NextResponse.json({ error: '未授权访问' }, { status: 401 })
    }

    const id = parseInt(params.id)
    if (isNaN(id)) {
      return NextResponse.json({ error: '无效的ID' }, { status: 400 })
    }

    const model = await db.model.findUnique({
      where: { id },
      include: {
        voices: true
      }
    })

    if (!model) {
      return NextResponse.json({ error: '模型不存在' }, { status: 404 })
    }

    return NextResponse.json({
      code: 0,
      data: model,
      msg: '获取成功'
    })
  } catch (error) {
    console.error('获取模型详情失败:', error)
    return NextResponse.json(
      { code: 500, msg: '获取模型详情失败', error: (error as Error).message },
      { status: 500 }
    )
  }
}

// PUT /api/models/{id} - 更新模型信息
export async function PUT(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const session = await getServerSession(authOptions)
    if (!session) {
      return NextResponse.json({ error: '未授权访问' }, { status: 401 })
    }

    if (session.user.role !== 'admin') {
      return NextResponse.json({ error: '权限不足' }, { status: 403 })
    }

    const id = parseInt(params.id)
    if (isNaN(id)) {
      return NextResponse.json({ error: '无效的ID' }, { status: 400 })
    }

    const body = await req.json()

    // 基本验证
    if (!body.name || !body.type || !body.provider) {
      return NextResponse.json({ error: '缺少必要字段' }, { status: 400 })
    }

    // 检查模型是否存在
    const existingModel = await db.model.findUnique({
      where: { id }
    })

    if (!existingModel) {
      return NextResponse.json({ error: '模型不存在' }, { status: 404 })
    }

    // 更新模型
    const updatedModel = await db.model.update({
      where: { id },
      data: {
        name: body.name,
        type: body.type,
        provider: body.provider,
        endpoint: body.endpoint,
        apiKey: body.apiKey,
        parameters: body.parameters,
        isActive: body.isActive !== undefined ? body.isActive : true
      }
    })

    return NextResponse.json({
      code: 0,
      data: updatedModel,
      msg: '更新成功'
    })
  } catch (error) {
    console.error('更新模型失败:', error)
    return NextResponse.json(
      { code: 500, msg: '更新模型失败', error: (error as Error).message },
      { status: 500 }
    )
  }
}

// DELETE /api/models/{id} - 删除模型
export async function DELETE(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const session = await getServerSession(authOptions)
    if (!session) {
      return NextResponse.json({ error: '未授权访问' }, { status: 401 })
    }

    if (session.user.role !== 'admin') {
      return NextResponse.json({ error: '权限不足' }, { status: 403 })
    }

    const id = parseInt(params.id)
    if (isNaN(id)) {
      return NextResponse.json({ error: '无效的ID' }, { status: 400 })
    }

    // 检查是否有关联的Agent
    const usedByAgents = await db.agentModel.findFirst({
      where: { modelId: id }
    })

    if (usedByAgents) {
      return NextResponse.json(
        { error: '该模型已被角色使用，无法删除' },
        { status: 400 }
      )
    }

    // 删除关联的音色
    await db.voice.deleteMany({
      where: { modelId: id }
    })

    // 删除模型
    await db.model.delete({
      where: { id }
    })

    return NextResponse.json({
      code: 0,
      msg: '删除成功'
    })
  } catch (error) {
    console.error('删除模型失败:', error)
    return NextResponse.json(
      { code: 500, msg: '删除模型失败', error: (error as Error).message },
      { status: 500 }
    )
  }
} 