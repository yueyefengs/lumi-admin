export const dynamic = 'force-dynamic';

import { Suspense } from 'react';
import { Table, Card, Button, Badge, Input, Form, Upload, Space, message } from 'antd';
import { UploadOutlined, CloudUploadOutlined, SearchOutlined } from '@ant-design/icons';
import prisma from '@/lib/prisma';

async function getFirmwares() {
  const firmwares = await prisma.firmware.findMany({
    orderBy: {
      createdAt: 'desc',
    },
  });
  
  return firmwares.map(firmware => ({
    ...firmware,
    key: firmware.id,
    createdAt: firmware.createdAt.toISOString(),
    updatedAt: firmware.updatedAt.toISOString(),
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

function UploadFirmwareForm() {
  return (
    <Card title="上传新固件" className="mb-8">
      <Form layout="vertical">
        <Form.Item
          name="version"
          label="固件版本"
          rules={[{ required: true, message: '请输入固件版本号' }]}
        >
          <Input placeholder="例如: v1.0.0" />
        </Form.Item>

        <Form.Item
          name="file"
          label="固件文件"
          rules={[{ required: true, message: '请上传固件文件' }]}
        >
          <Upload maxCount={1} action="/api/upload">
            <Button icon={<UploadOutlined />}>选择文件</Button>
          </Upload>
        </Form.Item>

        <Form.Item
          name="notes"
          label="更新说明"
        >
          <Input.TextArea rows={4} placeholder="描述此版本的更新内容" />
        </Form.Item>

        <Form.Item>
          <Button type="primary" icon={<CloudUploadOutlined />}>
            上传固件
          </Button>
        </Form.Item>
      </Form>
    </Card>
  );
}

function FirmwaresTable({ firmwares }) {
  const columns = [
    {
      title: '版本号',
      dataIndex: 'version',
      key: 'version',
    },
    {
      title: '状态',
      dataIndex: 'isActive',
      key: 'isActive',
      render: (isActive) => (
        <Badge 
          status={isActive ? 'success' : 'default'} 
          text={isActive ? '激活' : '未激活'} 
        />
      ),
    },
    {
      title: '下载地址',
      dataIndex: 'url',
      key: 'url',
      ellipsis: true,
      render: (url) => (
        <a href={url} target="_blank" rel="noopener noreferrer">
          {url}
        </a>
      ),
    },
    {
      title: '更新说明',
      dataIndex: 'notes',
      key: 'notes',
      ellipsis: true,
      render: (notes) => notes || '-',
    },
    {
      title: '上传时间',
      dataIndex: 'createdAt',
      key: 'createdAt',
      render: (date) => new Date(date).toLocaleString(),
    },
    {
      title: '操作',
      key: 'action',
      render: (_, record) => (
        <Space>
          {!record.isActive && (
            <Button type="link">激活</Button>
          )}
          <Button type="link" danger>删除</Button>
        </Space>
      ),
    },
  ];

  return (
    <Table 
      columns={columns} 
      dataSource={firmwares} 
      pagination={{ pageSize: 5 }}
    />
  );
}

export default async function OTAPage() {
  const firmwares = await getFirmwares();

  return (
    <div>
      <div className="mb-6">
        <h1 className="text-2xl font-bold">固件升级管理</h1>
        <p className="text-gray-500">管理ESP32设备的固件版本和升级</p>
      </div>

      <UploadFirmwareForm />

      <Card title="固件列表">
        <div className="mb-4 flex justify-end">
          <Input 
            prefix={<SearchOutlined />} 
            placeholder="搜索固件版本" 
            style={{ width: 250 }} 
          />
        </div>
        <Suspense fallback={<TableSkeleton />}>
          <FirmwaresTable firmwares={firmwares} />
        </Suspense>
      </Card>
    </div>
  );
} 