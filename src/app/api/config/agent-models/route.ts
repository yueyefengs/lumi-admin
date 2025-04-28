import { NextResponse } from 'next/server'
import { db } from '@/lib/db'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'

// GET /api/config/agent-models - 获取Agent模型配置
export async function GET() {
  try {
    const session = await getServerSession(authOptions)
    if (!session) {
      return NextResponse.json({ error: '未授权访问' }, { status: 401 })
    }

    // 获取默认模型配置项
    const defaultConfigs = await db.config.findMany({
      where: {
        name: {
          in: ['default_llm', 'default_tts', 'default_asr']
        }
      }
    })

    // 获取所有激活的模型
    const models = await db.model.findMany({
      where: { isActive: true },
      include: {
        voices: {
          where: { isDefault: true }
        }
      }
    })

    // 构建模型配置数据
    const modelsByType: Record<string, any[]> = {
      LLM: [],
      TTS: [],
      ASR: []
    }

    models.forEach(model => {
      const { id, name, type, provider, endpoint, parameters } = model
      
      const modelData = {
        id,
        name,
        provider,
        endpoint,
        parameters: parameters ? JSON.parse(parameters) : {}
      }
      
      if (type in modelsByType) {
        modelsByType[type].push(modelData)
      }
    })

    // 构建默认配置
    const defaults: Record<string, number> = {}
    
    defaultConfigs.forEach(config => {
      const key = config.name.replace('default_', '')
      defaults[key] = parseInt(config.value)
    })

    return NextResponse.json({
      code: 0,
      data: {
        models: modelsByType,
        defaults
      },
      msg: '获取成功'
    })
  } catch (error) {
    console.error('获取Agent模型配置失败:', error)
    return NextResponse.json(
      { code: 500, msg: '获取Agent模型配置失败', error: (error as Error).message },
      { status: 500 }
    )
  }
} 