import { NextResponse } from 'next/server';
import { getAuthSession } from '@/lib/auth';
import prisma from '@/lib/prisma';

// 获取所有设备
export async function GET() {
  try {
    const session = await getAuthSession();
    if (!session) {
      return NextResponse.json(
        { error: '未授权访问' },
        { status: 401 }
      );
    }

    const devices = await prisma.device.findMany({
      orderBy: {
        updatedAt: 'desc',
      },
    });

    return NextResponse.json(devices);
  } catch (error) {
    console.error('获取设备列表失败:', error);
    return NextResponse.json(
      { error: '获取设备列表失败' },
      { status: 500 }
    );
  }
}

// 添加新设备
export async function POST(request: Request) {
  try {
    const session = await getAuthSession();
    if (!session) {
      return NextResponse.json(
        { error: '未授权访问' },
        { status: 401 }
      );
    }

    const body = await request.json();
    const { deviceId, name } = body;

    if (!deviceId) {
      return NextResponse.json(
        { error: '设备ID是必须的' },
        { status: 400 }
      );
    }

    // 检查设备ID是否已存在
    const existingDevice = await prisma.device.findUnique({
      where: { deviceId },
    });

    if (existingDevice) {
      return NextResponse.json(
        { error: '设备ID已存在' },
        { status: 400 }
      );
    }

    const device = await prisma.device.create({
      data: {
        deviceId,
        name,
        status: 0, // 默认离线
      },
    });

    return NextResponse.json(device, { status: 201 });
  } catch (error) {
    console.error('创建设备失败:', error);
    return NextResponse.json(
      { error: '创建设备失败' },
      { status: 500 }
    );
  }
} 