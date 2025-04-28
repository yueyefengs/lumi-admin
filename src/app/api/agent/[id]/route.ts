import { NextRequest, NextResponse } from 'next/server'
import { db } from '@/lib/db'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'

// GET /api/agent/{id} - 获取角色详情
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

    const agent = await db.agent.findUnique({
      where: { id },
      include: {
        agentModels: {
          include: {
            model: true
          }
        }
      }
    })

    if (!agent) {
      return NextResponse.json({ error: '角色不存在' }, { status: 404 })
    }

    return NextResponse.json({
      code: 0,
      data: agent,
      msg: '获取成功'
    })
  } catch (error) {
    console.error('获取角色详情失败:', error)
    return NextResponse.json(
      { code: 500, msg: '获取角色详情失败', error: (error as Error).message },
      { status: 500 }
    )
  }
}

// PUT /api/agent/{id} - 更新角色信息
export async function PUT(
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

    const body = await req.json()

    // 基本验证
    if (!body.name) {
      return NextResponse.json({ error: '缺少必要字段' }, { status: 400 })
    }

    // 检查角色是否存在
    const existingAgent = await db.agent.findUnique({
      where: { id }
    })

    if (!existingAgent) {
      return NextResponse.json({ error: '角色不存在' }, { status: 404 })
    }

    // 更新角色基本信息
    const updatedAgent = await db.agent.update({
      where: { id },
      data: {
        name: body.name,
        description: body.description,
        avatar: body.avatar,
        systemPrompt: body.systemPrompt,
        isActive: body.isActive !== undefined ? body.isActive : true
      }
    })

    // 如果提供了模型配置，更新关联的模型
    if (body.models && Array.isArray(body.models)) {
      // 先删除现有的关联
      await db.agentModel.deleteMany({
        where: { agentId: id }
      })

      // 创建新的关联
      for (const modelConfig of body.models) {
        if (modelConfig.modelId) {
          await db.agentModel.create({
            data: {
              agentId: id,
              modelId: modelConfig.modelId,
              isDefault: modelConfig.isDefault === true
            }
          })
        }
      }
    }

    return NextResponse.json({
      code: 0,
      data: updatedAgent,
      msg: '更新成功'
    })
  } catch (error) {
    console.error('更新角色失败:', error)
    return NextResponse.json(
      { code: 500, msg: '更新角色失败', error: (error as Error).message },
      { status: 500 }
    )
  }
}

// DELETE /api/agent/{id} - 删除角色
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

    // 检查是否有绑定的设备
    const boundDevices = await db.device.findFirst({
      where: { agentId: id }
    })

    if (boundDevices) {
      return NextResponse.json(
        { error: '该角色已被设备使用，请先解绑相关设备' },
        { status: 400 }
      )
    }

    // 删除关联的模型
    await db.agentModel.deleteMany({
      where: { agentId: id }
    })

    // 删除角色
    await db.agent.delete({
      where: { id }
    })

    return NextResponse.json({
      code: 0,
      msg: '删除成功'
    })
  } catch (error) {
    console.error('删除角色失败:', error)
    return NextResponse.json(
      { code: 500, msg: '删除角色失败', error: (error as Error).message },
      { status: 500 }
    )
  }
} 