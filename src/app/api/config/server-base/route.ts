import { NextResponse } from 'next/server'
import { db } from '@/lib/db'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'

// GET /api/config/server-base - 获取服务器基础配置
export async function GET() {
  try {
    const session = await getServerSession(authOptions)
    if (!session) {
      return NextResponse.json({ error: '未授权访问' }, { status: 401 })
    }

    // 获取基础配置项
    const configs = await db.config.findMany({
      where: {
        name: {
          in: ['site_name', 'server_url', 'server_secret']
        }
      }
    })

    // 转换为键值对对象
    const configObj = configs.reduce((acc, item) => {
      let value: string | number | boolean | object = item.value
      
      // 根据类型转换值
      if (item.type === 'number') {
        value = parseFloat(value as string)
      } else if (item.type === 'boolean') {
        value = (value as string).toLowerCase() === 'true'
      } else if (item.type === 'json') {
        try {
          value = JSON.parse(value as string)
        } catch (e) {
          console.error(`解析JSON配置失败: ${item.name}`, e)
        }
      }
      
      acc[item.name] = value
      return acc
    }, {} as Record<string, any>)

    return NextResponse.json({
      code: 0,
      data: configObj,
      msg: '获取成功'
    })
  } catch (error) {
    console.error('获取服务器基础配置失败:', error)
    return NextResponse.json(
      { code: 500, msg: '获取服务器基础配置失败', error: (error as Error).message },
      { status: 500 }
    )
  }
} 