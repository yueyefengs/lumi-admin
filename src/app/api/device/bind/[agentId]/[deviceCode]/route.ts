import { NextRequest, NextResponse } from 'next/server'
import { db } from '@/lib/db'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'

// GET /api/device/bind/{agentId}/{deviceCode} - 绑定设备
export async function GET(
  req: NextRequest,
  { params }: { params: { agentId: string; deviceCode: string } }
) {
  try {
    const session = await getServerSession(authOptions)
    if (!session) {
      return NextResponse.json({ error: '未授权访问' }, { status: 401 })
    }

    const agentId = parseInt(params.agentId)
    const deviceCode = params.deviceCode

    if (isNaN(agentId) || !deviceCode) {
      return NextResponse.json({ error: '参数错误' }, { status: 400 })
    }

    // 验证角色存在
    const agent = await db.agent.findUnique({
      where: { id: agentId }
    })

    if (!agent) {
      return NextResponse.json({ error: '角色不存在' }, { status: 404 })
    }

    // 验证设备存在
    const device = await db.device.findUnique({
      where: { deviceId: deviceCode }
    })

    if (!device) {
      return NextResponse.json({ error: '设备不存在或未注册' }, { status: 404 })
    }

    // 更新设备绑定的角色
    const updatedDevice = await db.device.update({
      where: { deviceId: deviceCode },
      data: {
        agentId: agentId
      }
    })

    return NextResponse.json({
      code: 0,
      data: updatedDevice,
      msg: '设备绑定成功'
    })
  } catch (error) {
    console.error('设备绑定失败:', error)
    return NextResponse.json(
      { code: 500, msg: '设备绑定失败', error: (error as Error).message },
      { status: 500 }
    )
  }
} 