import { NextRequest, NextResponse } from 'next/server'
import { db } from '@/lib/db'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'

// GET /api/models/{id}/voices - 获取模型音色
export async function GET(
  req: NextRequest,
  { params }: { params: { id: string } } // 修改: modelId -> id
) {
  try {
    const session = await getServerSession(authOptions)
    if (!session) {
      return NextResponse.json({ error: '未授权访问' }, { status: 401 })
    }

    const modelId = parseInt(params.id) // 修改: params.modelId -> params.id
    if (isNaN(modelId)) {
      return NextResponse.json({ error: '无效的模型ID' }, { status: 400 })
    }

    // 验证模型存在性
    const model = await db.model.findUnique({
      where: { id: modelId }
    })

    if (!model) {
      return NextResponse.json({ error: '模型不存在' }, { status: 404 })
    }

    // 检查模型类型是否为TTS
    if (model.type !== 'TTS') {
      return NextResponse.json({ error: '该模型不支持音色' }, { status: 400 })
    }

    // 获取音色列表
    const voices = await db.voice.findMany({
      where: { modelId }
    })

    return NextResponse.json({
      code: 0,
      data: voices,
      msg: '获取成功'
    })
  } catch (error) {
    console.error('获取音色列表失败:', error)
    return NextResponse.json(
      { code: 500, msg: '获取音色列表失败', error: (error as Error).message },
      { status: 500 }
    )
  }
}

// POST /api/models/{id}/voices - 添加音色
export async function POST(
  req: NextRequest,
  { params }: { params: { id: string } } // 修改: modelId -> id
) {
  try {
    const session = await getServerSession(authOptions)
    if (!session) {
      return NextResponse.json({ error: '未授权访问' }, { status: 401 })
    }

    if (session.user.role !== 'admin') {
      return NextResponse.json({ error: '权限不足' }, { status: 403 })
    }

    const modelId = parseInt(params.id) // 修改: params.modelId -> params.id
    if (isNaN(modelId)) {
      return NextResponse.json({ error: '无效的模型ID' }, { status: 400 })
    }

    // 验证模型存在性和类型
    const model = await db.model.findUnique({
      where: { id: modelId }
    })

    if (!model) {
      return NextResponse.json({ error: '模型不存在' }, { status: 404 })
    }

    if (model.type !== 'TTS') {
      return NextResponse.json({ error: '该模型不支持音色' }, { status: 400 })
    }

    const body = await req.json()

    // 验证必要字段
    if (!body.name || !body.code) {
      return NextResponse.json({ error: '缺少必要字段' }, { status: 400 })
    }

    // 检查音色代码是否已存在
    const existingVoice = await db.voice.findFirst({
      where: {
        modelId,
        code: body.code
      }
    })

    if (existingVoice) {
      return NextResponse.json({ error: '音色代码已存在' }, { status: 400 })
    }

    // 创建音色
    const newVoice = await db.voice.create({
      data: {
        name: body.name,
        code: body.code,
        gender: body.gender,
        isDefault: body.isDefault === true,
        modelId
      }
    })

    // 如果设为默认，更新其他音色
    if (newVoice.isDefault) {
      await db.voice.updateMany({
        where: {
          modelId,
          id: {
            not: newVoice.id
          }
        },
        data: {
          isDefault: false
        }
      })
    }

    return NextResponse.json({
      code: 0,
      data: newVoice,
      msg: '添加成功'
    })
  } catch (error) {
    console.error('添加音色失败:', error)
    return NextResponse.json(
      { code: 500, msg: '添加音色失败', error: (error as Error).message },
      { status: 500 }
    )
  }
} 