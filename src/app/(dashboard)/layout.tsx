'use client';

import { useState } from 'react';
import { Layout, Menu, Button, theme, Avatar, Dropdown } from 'antd';
import { 
  MenuFoldOutlined, 
  MenuUnfoldOutlined,
  DashboardOutlined,
  SettingOutlined,
  ApiOutlined,
  RobotOutlined,
  UserOutlined,
  LogoutOutlined
} from '@ant-design/icons';
import Link from 'next/link';
import { usePathname, useRouter } from 'next/navigation';
import { signOut, useSession } from 'next-auth/react';

const { Header, Sider, Content } = Layout;

export default function DashboardLayout({ children }: { children: React.ReactNode }) {
  const [collapsed, setCollapsed] = useState(false);
  const { token } = theme.useToken();
  const pathname = usePathname();
  const router = useRouter();
  const { data: session } = useSession({
    required: true,
    onUnauthenticated() {
      router.push('/login');
    },
  });

  const menuItems = [
    {
      key: '/dashboard',
      icon: <DashboardOutlined />,
      label: <Link href="/dashboard">仪表盘</Link>,
    },
    {
      key: 'models',
      icon: <RobotOutlined />,
      label: '模型管理',
      children: [
        {
          key: '/dashboard/models/llm',
          label: <Link href="/dashboard/models/llm">LLM模型</Link>,
        },
        {
          key: '/dashboard/models/tts',
          label: <Link href="/dashboard/models/tts">TTS引擎</Link>,
        }
      ]
    },
    {
      key: 'devices',
      icon: <ApiOutlined />,
      label: '设备管理',
      children: [
        {
          key: '/dashboard/devices',
          label: <Link href="/dashboard/devices">设备列表</Link>,
        },
        {
          key: '/dashboard/devices/ota',
          label: <Link href="/dashboard/devices/ota">固件升级</Link>,
        }
      ]
    },
    {
      key: '/dashboard/settings',
      icon: <SettingOutlined />,
      label: <Link href="/dashboard/settings">系统设置</Link>,
    }
  ];

  // 查找当前路径对应的选中菜单项
  const findSelectedKeys = () => {
    const foundKey = Object.values(menuItems)
      .flatMap(item => 'children' in item ? item.children : [item])
      .find(item => pathname === item.key)?.key;
    return foundKey ? [foundKey] : ['/dashboard'];
  };

  // 用户菜单
  const userMenu = {
    items: [
      {
        key: 'profile',
        icon: <UserOutlined />,
        label: '个人信息',
      },
      {
        key: 'logout',
        icon: <LogoutOutlined />,
        label: '退出登录',
      },
    ],
    onClick: ({ key }: { key: string }) => {
      if (key === 'logout') {
        signOut({ redirect: true, callbackUrl: '/login' });
      }
    },
  };

  return (
    <Layout style={{ minHeight: '100vh' }}>
      <Sider trigger={null} collapsible collapsed={collapsed} width={250}>
        <div className="flex h-16 items-center justify-center bg-primary/10 text-xl font-bold text-white">
          {!collapsed && <span>小智管理系统</span>}
        </div>
        <Menu
          theme="dark"
          mode="inline"
          selectedKeys={findSelectedKeys()}
          defaultOpenKeys={['models', 'devices']}
          items={menuItems}
        />
      </Sider>
      <Layout>
        <Header style={{ padding: 0, background: token.colorBgContainer, display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
          <Button
            type="text"
            icon={collapsed ? <MenuUnfoldOutlined /> : <MenuFoldOutlined />}
            onClick={() => setCollapsed(!collapsed)}
            style={{ fontSize: '16px', width: 64, height: 64 }}
          />
          <div className="mr-6">
            <Dropdown menu={userMenu} placement="bottomRight">
              <div className="flex items-center cursor-pointer">
                <Avatar icon={<UserOutlined />} />
                <span className="ml-2">{session?.user?.name || '管理员'}</span>
              </div>
            </Dropdown>
          </div>
        </Header>
        <Content style={{ margin: '24px 16px', padding: 24, background: token.colorBgContainer, overflow: 'auto' }}>
          {children}
        </Content>
      </Layout>
    </Layout>
  );
} 