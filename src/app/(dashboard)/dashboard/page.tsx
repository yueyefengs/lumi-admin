export const dynamic = 'force-dynamic';

import { Card, Col, Row, Statistic } from 'antd';
import {
  ApiOutlined,
  CloudOutlined,
  RobotOutlined,
  SettingOutlined,
} from '@ant-design/icons';
import prisma from '@/lib/prisma';

async function getStatistics() {
  try { 
    const deviceCount = await prisma.device.count();
    const onlineDeviceCount = await prisma.device.count({
      where: { status: 1 }
    });
    const configCount = await prisma.config.count();
    const firmwareCount = await prisma.firmware.count();

    return {
      deviceCount,
      onlineDeviceCount,
      configCount,
      firmwareCount
    };
  }catch (error) {
    console.error('获取统计数据失败:', error);
    // 构建时数据库不可用则返回默认值
    return { props: { count: 0 } };
  }
    
}

export default async function DashboardPage() {
  const { deviceCount, onlineDeviceCount, configCount, firmwareCount } = await getStatistics();

  return (
    <div>
      <h1 className="text-2xl font-bold mb-6">系统概览</h1>

      <Row gutter={16}>
        <Col span={6}>
          <Card>
            <Statistic
              title="设备总数"
              value={deviceCount}
              prefix={<ApiOutlined />}
            />
          </Card>
        </Col>
        <Col span={6}>
          <Card>
            <Statistic
              title="在线设备"
              value={onlineDeviceCount}
              prefix={<CloudOutlined />}
              valueStyle={{ color: '#3f8600' }}
            />
          </Card>
        </Col>
        <Col span={6}>
          <Card>
            <Statistic
              title="系统配置"
              value={configCount}
              prefix={<SettingOutlined />}
            />
          </Card>
        </Col>
        <Col span={6}>
          <Card>
            <Statistic
              title="固件版本"
              value={firmwareCount}
              prefix={<RobotOutlined />}
            />
          </Card>
        </Col>
      </Row>

      <div className="mt-8">
        <h2 className="text-xl font-bold mb-4">快速入口</h2>
        <Row gutter={16}>
          <Col span={8}>
            <Card title="设备管理" bordered>
              <p>查看和管理所有连接的设备</p>
              <a href="/dashboard/devices" className="text-blue-500 mt-2 inline-block">进入设备管理 →</a>
            </Card>
          </Col>
          <Col span={8}>
            <Card title="模型配置" bordered>
              <p>配置LLM和TTS模型参数</p>
              <a href="/dashboard/models/llm" className="text-blue-500 mt-2 inline-block">进入模型配置 →</a>
            </Card>
          </Col>
          <Col span={8}>
            <Card title="固件更新" bordered>
              <p>管理设备固件版本和更新</p>
              <a href="/dashboard/devices/ota" className="text-blue-500 mt-2 inline-block">进入固件管理 →</a>
            </Card>
          </Col>
        </Row>
      </div>
    </div>
  );
} 