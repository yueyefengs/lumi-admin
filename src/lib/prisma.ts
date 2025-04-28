import { PrismaClient } from '@prisma/client'

// 添加全局声明以防止热重载时创建多个连接
declare global {
  var prisma: PrismaClient | undefined
}

const prisma = global.prisma || new PrismaClient()

if (process.env.NODE_ENV !== 'production') global.prisma = prisma

export default prisma 