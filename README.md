# 小智管理系统 (Lumi Admin)

基于Next.js重构的小智管理系统，提供了模型管理、角色配置、设备管理等功能。

## 功能特性

- 用户认证与管理
- 模型配置管理 (LLM、TTS、ASR等)
- 角色配置管理
- 设备管理
- 系统参数管理
- 音色管理

## 技术栈

- **前端**: Next.js 14, React 18, Ant Design 5
- **后端**: Next.js API Routes
- **数据库**: MySQL 8
- **缓存**: Redis
- **部署**: Docker, Docker Compose

## 开发环境搭建

### 前提条件

- Node.js 18+
- npm 或 yarn
- MySQL 8
- Redis (可选，用于会话存储)

### 安装步骤

1. 克隆仓库

```bash
git clone https://github.com/yourusername/lumi-admin.git
cd lumi-admin
```

2. 安装依赖

```bash
npm install
# 或
yarn install
```

3. 配置环境变量

创建`.env.local`文件，添加必要的环境变量：

```
# 数据库配置
DATABASE_URL="mysql://username:password@localhost:3306/lumi_admin"

# NextAuth配置
NEXTAUTH_URL=http://localhost:8002
NEXTAUTH_SECRET=your-nextauth-secret-key-change-me

# Redis配置 (可选)
REDIS_URL=redis://localhost:6379
```

4. 初始化数据库

```bash
npx prisma db push
npx prisma generate
npm run prisma:seed
```

5. 启动开发服务器

```bash
npm run dev
```

服务器将在 http://localhost:8002 启动。

## 使用Docker部署

1. 构建和启动容器

```bash
docker-compose up -d
```

系统将在 http://localhost:8002 可用。

2. 查看日志

```bash
docker-compose logs -f
```

3. 停止服务

```bash
docker-compose down
```

## API接口

系统提供以下主要API接口：

### 用户相关

- `GET/POST /api/user/captcha` - 获取验证码
- `GET/POST /api/user/login` - 用户登录
- `POST /api/user/register` - 用户注册
- `GET/PUT /api/user/info` - 获取/更新用户信息

### 模型相关

- `GET /api/models/names` - 获取模型名称列表
- `GET /api/models/list` - 获取模型列表
- `GET/PUT/DELETE /api/models/{id}` - 获取/更新/删除模型详情
- `GET/POST /api/models/{modelId}/voices` - 获取/添加模型音色

### 角色相关

- `GET /api/agent/list` - 获取角色列表
- `GET /api/agent/all` - 获取所有角色
- `GET/PUT/DELETE /api/agent/{id}` - 获取/更新/删除角色详情
- `GET/POST /api/agent/template` - 获取/创建角色模板

### 设备相关

- `POST /api/device/register` - 设备注册
- `GET /api/device/bind/{agentId}/{deviceCode}` - 绑定设备
- `POST /api/device/unbind` - 解绑设备

### 系统管理

- `GET/POST /api/admin/params/page` - 获取/更新参数列表
- `GET/POST /api/admin/users` - 获取/更新用户列表

### 配置相关

- `GET /api/config/server-base` - 服务器基础配置
- `GET /api/config/agent-models` - 获取Agent模型配置

## 账户信息

默认管理员账户：
- 用户名：admin
- 密码：admin123

## 许可证

[MIT](LICENSE)
