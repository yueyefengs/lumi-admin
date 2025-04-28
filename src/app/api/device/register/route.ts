import { NextRequest, NextResponse } from 'next/server'
import { db } from '@/lib/db'

// POST /api/device/register - 设备注册
export async function POST(req: NextRequest) {
  try {
    const body = await req.json()
    
    // 验证必要字段
    if (!body.deviceId) {
      return NextResponse.json({ error: '缺少设备ID' }, { status: 400 })
    }

    // 检查设备是否已经注册
    const existingDevice = await db.device.findUnique({
      where: { deviceId: body.deviceId }
    })

    if (existingDevice) {
      // 已注册，更新设备状态
      const updatedDevice = await db.device.update({
        where: { deviceId: body.deviceId },
        data: {
          status: 1, // 在线
          lastOnline: new Date(),
          version: body.version || existingDevice.version
        }
      })

      return NextResponse.json({
        code: 0,
        data: updatedDevice,
        msg: '设备已更新状态'
      })
    }

    // 创建新设备
    const newDevice = await db.device.create({
      data: {
        deviceId: body.deviceId,
        name: body.name || `设备-${body.deviceId.substring(0, 8)}`,
        version: body.version,
        status: 1, // 在线
        lastOnline: new Date()
      }
    })

    return NextResponse.json({
      code: 0,
      data: newDevice,
      msg: '设备注册成功'
    })
  } catch (error) {
    console.error('设备注册失败:', error)
    return NextResponse.json(
      { code: 500, msg: '设备注册失败', error: (error as Error).message },
      { status: 500 }
    )
  }
} 