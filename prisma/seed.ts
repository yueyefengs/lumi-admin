import { PrismaClient } from '@prisma/client'
import * as bcrypt from 'bcryptjs'

const prisma = new PrismaClient()

async function main() {
  // 检查是否已存在管理员账户
  const adminExists = await prisma.user.findUnique({
    where: { username: 'admin' }
  })

  if (!adminExists) {
    // 创建默认管理员账户
    const hashedPassword = await bcrypt.hash('admin123', 10)
    await prisma.user.create({
      data: {
        username: 'admin',
        password: hashedPassword,
        email: 'admin@xiaozhi.com',
        role: 'admin',
        status: 1,
      }
    })
    console.log('创建管理员账户成功: admin / admin123')
  } else {
    console.log('管理员账户已存在，跳过创建')
  }

  // 添加一些默认配置
  const configItems = [
    { name: 'site_name', value: '小智管理系统', type: 'string', desc: '站点名称' },
    { name: 'server_url', value: 'ws://localhost:8000/xiaozhi/v1/', type: 'string', desc: 'WebSocket服务地址' },
    { name: 'server_secret', value: 'xiaozhi-server-secret', type: 'string', desc: '服务器密钥' },
    { name: 'enable_log', value: 'true', type: 'boolean', desc: '是否启用操作日志记录' },
    { name: 'default_llm', value: '1', type: 'number', desc: '默认大语言模型ID' },
    { name: 'default_tts', value: '2', type: 'number', desc: '默认TTS模型ID' },
    { name: 'default_asr', value: '3', type: 'number', desc: '默认ASR模型ID' },
  ]

  for (const item of configItems) {
    const exists = await prisma.config.findUnique({
      where: { name: item.name }
    })

    if (!exists) {
      await prisma.config.create({ data: item })
      console.log(`创建配置项成功: ${item.name}`)
    }
  }

  // 添加默认AI模型
  const defaultModels = [
    { 
      name: '智谱ChatGLM',
      type: 'LLM',
      provider: '智谱AI',
      endpoint: 'https://open.bigmodel.cn/api/paas/v3/model-api',
      parameters: JSON.stringify({
        model: 'chatglm_pro',
        temperature: 0.7,
        max_tokens: 2048
      }),
      isActive: true
    },
    { 
      name: '讯飞星火',
      type: 'LLM',
      provider: '讯飞',
      endpoint: 'https://spark-api.xf-yun.com/v1.1',
      parameters: JSON.stringify({
        model: 'generalv1.5',
        temperature: 0.5,
        max_tokens: 2048
      }),
      isActive: true
    },
    { 
      name: '讯飞TTS',
      type: 'TTS',
      provider: '讯飞',
      endpoint: 'https://tts-api.xfyun.cn/v2/tts',
      parameters: JSON.stringify({
        format: 'wav',
        rate: 16000
      }),
      isActive: true
    },
    { 
      name: '百度语音识别',
      type: 'ASR',
      provider: '百度',
      endpoint: 'https://vop.baidu.com/server_api',
      parameters: JSON.stringify({
        format: 'pcm',
        rate: 16000,
        channel: 1
      }),
      isActive: true
    }
  ]

  for (const modelData of defaultModels) {
    const exists = await prisma.model.findFirst({
      where: {
        name: modelData.name,
        type: modelData.type
      }
    })

    if (!exists) {
      await prisma.model.create({ data: modelData })
      console.log(`创建模型成功: ${modelData.name}`)
    }
  }

  // 为TTS模型添加音色
  const ttsModel = await prisma.model.findFirst({
    where: { type: 'TTS' }
  })

  if (ttsModel) {
    const defaultVoices = [
      { name: '小智男声', code: 'xiaoyi', gender: '男', modelId: ttsModel.id, isDefault: true },
      { name: '小智女声', code: 'xiaoyu', gender: '女', modelId: ttsModel.id, isDefault: false },
      { name: '童声', code: 'ninger', gender: '中性', modelId: ttsModel.id, isDefault: false }
    ]

    for (const voiceData of defaultVoices) {
      const exists = await prisma.voice.findFirst({
        where: {
          code: voiceData.code,
          modelId: ttsModel.id
        }
      })

      if (!exists) {
        await prisma.voice.create({ data: voiceData })
        console.log(`创建音色成功: ${voiceData.name}`)
      }
    }
  }

  // 添加默认角色模板
  const defaultTemplates = [
    {
      name: '标准助手',
      description: '通用助手角色模板',
      template: JSON.stringify({
        name: '小智助手',
        description: '我是一个通用AI助手，可以回答各种问题并提供帮助。',
        systemPrompt: '你是小智助手，一个友好、知识渊博的AI。请尽可能简洁明了地回答用户问题。'
      })
    },
    {
      name: '故事讲述者',
      description: '专注于讲述故事的角色模板',
      template: JSON.stringify({
        name: '故事大王',
        description: '我喜欢讲各种有趣的故事，尤其是儿童故事和寓言故事。',
        systemPrompt: '你是故事大王，一个擅长讲述生动有趣故事的AI。根据用户的需求，创作或讲述适合的故事，特别注重故事的教育意义和趣味性。'
      })
    }
  ]

  for (const templateData of defaultTemplates) {
    const exists = await prisma.agentTemplate.findFirst({
      where: { name: templateData.name }
    })

    if (!exists) {
      await prisma.agentTemplate.create({ data: templateData })
      console.log(`创建角色模板成功: ${templateData.name}`)
    }
  }

  // 添加默认角色
  const defaultAgents = [
    {
      name: '小智助手',
      description: '通用AI助手，可以回答各种问题',
      systemPrompt: '你是小智助手，一个友好、知识渊博的AI。请尽可能简洁明了地回答用户问题。',
      isActive: true
    }
  ]

  for (const agentData of defaultAgents) {
    const exists = await prisma.agent.findFirst({
      where: { name: agentData.name }
    })

    if (!exists) {
      const agent = await prisma.agent.create({ data: agentData })
      console.log(`创建角色成功: ${agentData.name}`)

      // 为角色关联默认模型
      const llmModel = await prisma.model.findFirst({ where: { type: 'LLM' } })
      const ttsModel = await prisma.model.findFirst({ where: { type: 'TTS' } })
      const asrModel = await prisma.model.findFirst({ where: { type: 'ASR' } })

      if (llmModel) {
        await prisma.agentModel.create({
          data: {
            agentId: agent.id,
            modelId: llmModel.id,
            isDefault: true
          }
        })
      }

      if (ttsModel) {
        await prisma.agentModel.create({
          data: {
            agentId: agent.id,
            modelId: ttsModel.id,
            isDefault: true
          }
        })
      }

      if (asrModel) {
        await prisma.agentModel.create({
          data: {
            agentId: agent.id,
            modelId: asrModel.id,
            isDefault: true
          }
        })
      }
    }
  }
}

main()
  .then(async () => {
    await prisma.$disconnect()
  })
  .catch(async (e) => {
    console.error(e)
    await prisma.$disconnect()
    process.exit(1)
  }) 