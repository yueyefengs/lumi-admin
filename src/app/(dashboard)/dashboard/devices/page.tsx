export const dynamic = 'force-dynamic';

import { Suspense } from 'react';
import { Table, Tag, Card, Button } from 'antd';
import { PlusOutlined, ReloadOutlined } from '@ant-design/icons';
import prisma from '@/lib/prisma';

async function getDevices() {
  const devices = await prisma.device.findMany({
    orderBy: {
      updatedAt: 'desc',
    },
  });
  
  return devices.map(device => ({
    ...device,
    key: device.id,
    lastOnline: device.lastOnline ? device.lastOnline.toISOString() : null,
    createdAt: device.createdAt.toISOString(),
    updatedAt: device.updatedAt.toISOString(),
  }));
}

function TableSkeleton() {
  return (
    <div className="animate-pulse">
      <div className="h-10 bg-gray-200 rounded mb-4"></div>
      <div className="h-80 bg-gray-200 rounded"></div>
    </div>
  );
}

function DevicesTable({ devices }: { devices: any[] }) {
  const columns = [
    {
      title: '设备ID',
      dataIndex: 'deviceId',
      key: 'deviceId',
      ellipsis: true,
    },
    {
      title: '名称',
      dataIndex: 'name',
      key: 'name',
      render: (text: string) => text || '-',
    },
    {
      title: '状态',
      dataIndex: 'status',
      key: 'status',
      render: (status: number) => (
        <Tag color={status === 1 ? 'green' : 'gray'}>
          {status === 1 ? '在线' : '离线'}
        </Tag>
      ),
    },
    {
      title: '固件版本',
      dataIndex: 'version',
      key: 'version',
      render: (text: string) => text || '-',
    },
    {
      title: '最后在线时间',
      dataIndex: 'lastOnline',
      key: 'lastOnline',
      render: (date: string) => date ? new Date(date).toLocaleString() : '-',
    },
    {
      title: '注册时间',
      dataIndex: 'createdAt',
      key: 'createdAt',
      render: (date: string) => new Date(date).toLocaleString(),
    },
    {
      title: '操作',
      key: 'action',
      render: () => (
        <span className="flex gap-2">
          <Button type="link">编辑</Button>
          <Button type="link" danger>删除</Button>
        </span>
      ),
    },
  ];

  return (
    <Table 
      columns={columns} 
      dataSource={devices} 
      pagination={{ pageSize: 10 }}
      scroll={{ x: 1000 }}
    />
  );
}

export default async function DevicesPage() {
  const devices = await getDevices();

  return (
    <div>
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-2xl font-bold">设备管理</h1>
        <div className="flex gap-2">
          <Button type="primary" icon={<PlusOutlined />}>
            添加设备
          </Button>
          <Button icon={<ReloadOutlined />}>
            刷新
          </Button>
        </div>
      </div>

      <Card>
        <Suspense fallback={<TableSkeleton />}>
          <DevicesTable devices={devices} />
        </Suspense>
      </Card>
    </div>
  );
} 