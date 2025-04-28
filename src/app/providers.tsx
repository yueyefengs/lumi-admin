'use client';

import { SessionProvider } from 'next-auth/react';
import { ConfigProvider } from 'antd';
import zhCN from 'antd/locale/zh_CN';
import { StyleProvider } from '@ant-design/cssinjs';

export function Providers({ children }: { children: React.ReactNode }) {
  return (
    <SessionProvider>
      <StyleProvider hashPriority="high">
        <ConfigProvider
          locale={zhCN}
          theme={{
            token: {
              colorPrimary: '#1677ff',
            },
          }}
        >
          {children}
        </ConfigProvider>
      </StyleProvider>
    </SessionProvider>
  );
} 