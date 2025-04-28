import { NextRequest, NextResponse } from 'next/server'
import { db } from '@/lib/db'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'

// POST /api/device/unbind - 解绑设备
export async function POST(req: NextRequest) {
  try {
    const session = await getServerSession(authOptions)
    if (!session) {
      return NextResponse.json({ error: '未授权访问' }, { status: 401 })
    }

    const body = await req.json()
    
    // 验证必要字段
    if (!body.deviceId) {
      return NextResponse.json({ error: '缺少设备ID' }, { status: 400 })
    }

    // 验证设备存在
    const device = await db.device.findUnique({
      where: { deviceId: body.deviceId }
    })

    if (!device) {
      return NextResponse.json({ error: '设备不存在' }, { status: 404 })
    }

    // 检查设备是否已绑定角色
    if (!device.agentId) {
      return NextResponse.json({ error: '该设备未绑定角色' }, { status: 400 })
    }

    // 解除绑定
    const updatedDevice = await db.device.update({
      where: { deviceId: body.deviceId },
      data: {
        agentId: null
      }
    })

    return NextResponse.json({
      code: 0,
      data: updatedDevice,
      msg: '设备解绑成功'
    })
  } catch (error) {
    console.error('设备解绑失败:', error)
    return NextResponse.json(
      { code: 500, msg: '设备解绑失败', error: (error as Error).message },
      { status: 500 }
    )
  }
} 