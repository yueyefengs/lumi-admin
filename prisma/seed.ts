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