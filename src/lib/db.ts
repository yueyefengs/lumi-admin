import { PrismaClient } from '@prisma/client'

// 防止开发环境下创建多个实例
const globalForPrisma = globalThis as unknown as {
  prisma: PrismaClient | undefined
}

// 创建 Prisma 客户端实例
export const db = globalForPrisma.prisma ?? 
  new PrismaClient({
    log: process.env.NODE_ENV === 'development' ? ['query', 'error', 'warn'] : ['error'],
  })

// 在非生产环境下将客户端挂载到全局对象上
if (process.env.NODE_ENV !== 'production') {
  globalForPrisma.prisma = db
} 