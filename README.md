# 小智管理系统 (lumi-admin)

使用Next.js 14全栈框架重构的小智ESP32管理系统，整合了原有的manager-web和manager-api功能。

## 技术栈

- **前端**: React 18 + Ant Design + TailwindCSS
- **后端**: Next.js API Routes
- **数据库**: MySQL (Prisma ORM)
- **缓存**: Redis
- **认证**: NextAuth.js
- **部署**: Docker

## 功能特性

- 用户认证与权限管理
- 设备管理与监控
- 模型配置(LLM、TTS)
- 固件OTA升级
- 系统配置管理

## 快速开始

### 开发环境

1. 克隆仓库
   ```bash
   git clone https://github.com/yourusername/lumi-admin.git
   cd lumi-admin
   ```

2. 安装依赖
   ```bash
   npm install
   ```

3. 配置环境变量
   复制`.env.example`为`.env.local`，并配置必要的环境变量

4. 启动开发服务器
   ```bash
   npm run dev
   ```

### 使用Docker部署

1. 构建Docker镜像并启动服务
   ```bash
   docker-compose up -d
   ```

2. 初始化数据库
   ```bash
   docker-compose exec lumi-admin npx prisma migrate deploy
   ```

3. 访问管理系统
   http://localhost:8002/xiaozhi

## 项目结构

```
lumi-admin/
├── app/                # Next.js App Router
│   ├── (auth)/         # 认证相关页面
│   ├── (dashboard)/    # 仪表盘页面
│   ├── api/            # API路由
│   └── ...
├── components/         # 可复用组件
├── lib/                # 工具库
├── prisma/             # Prisma配置和迁移
└── public/             # 静态资源
```

## API文档

启动后访问：http://localhost:8002/xiaozhi/api-docs

## 接口路径

与原有系统保持一致，所有页面和API访问路径均带有`/xiaozhi`前缀，如：
- 管理界面: http://localhost:8002/xiaozhi
- API接口: http://localhost:8002/xiaozhi/api/...

## 许可证

MIT
