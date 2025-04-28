import { NextResponse } from 'next/server';
import { getAuthSession } from '@/lib/auth';
import prisma from '@/lib/prisma';

// 获取固件版本信息
export async function GET(request: Request) {
  const { searchParams } = new URL(request.url);
  const deviceId = searchParams.get('deviceId');
  
  try {
    // 如果有设备ID查询参数，返回适合该设备的最新固件
    if (deviceId) {
      // 获取设备信息
      const device = await prisma.device.findUnique({
        where: { deviceId: deviceId as string },
      });
      
      if (!device) {
        return NextResponse.json(
          { error: '设备不存在' },
          { status: 404 }
        );
      }
      
      // 获取当前激活的最新固件
      const latestFirmware = await prisma.firmware.findFirst({
        where: { isActive: true },
        orderBy: { createdAt: 'desc' },
      });
      
      if (!latestFirmware) {
        return NextResponse.json(
          { error: '未找到可用固件' },
          { status: 404 }
        );
      }
      
      // 更新设备表中的固件版本
      await prisma.device.update({
        where: { id: device.id },
        data: { 
          lastOnline: new Date(),
          version: latestFirmware.version
        },
      });
      
      // 返回固件信息
      return NextResponse.json({
        version: latestFirmware.version,
        url: latestFirmware.url,
        notes: latestFirmware.notes,
      });
    } 
    // 否则返回所有固件列表
    else {
      const session = await getAuthSession();
      
      if (!session) {
        return NextResponse.json(
          { error: '未授权访问' },
          { status: 401 }
        );
      }
      
      const firmwares = await prisma.firmware.findMany({
        orderBy: { createdAt: 'desc' },
      });
      
      return NextResponse.json(firmwares);
    }
  } catch (error) {
    console.error('获取固件信息失败:', error);
    return NextResponse.json(
      { error: '获取固件信息失败' },
      { status: 500 }
    );
  }
}

// 上传新固件
export async function POST(request: Request) {
  try {
    const session = await getAuthSession();
    
    if (!session) {
      return NextResponse.json(
        { error: '未授权访问' },
        { status: 401 }
      );
    }
    
    const { version, url, notes } = await request.json();
    
    if (!version || !url) {
      return NextResponse.json(
        { error: '固件版本和下载地址是必须的' },
        { status: 400 }
      );
    }
    
    // 检查版本是否已存在
    const existingFirmware = await prisma.firmware.findUnique({
      where: { version },
    });
    
    if (existingFirmware) {
      return NextResponse.json(
        { error: '该固件版本已存在' },
        { status: 400 }
      );
    }
    
    const firmware = await prisma.firmware.create({
      data: {
        version,
        url,
        notes,
        isActive: false, // 默认不激活，需要管理员手动激活
      },
    });
    
    return NextResponse.json(firmware, { status: 201 });
  } catch (error) {
    console.error('上传固件失败:', error);
    return NextResponse.json(
      { error: '上传固件失败' },
      { status: 500 }
    );
  }
} 