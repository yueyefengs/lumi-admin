# 使用多平台基础镜像
FROM --platform=$BUILDPLATFORM node:20-slim AS base

# 安装依赖
RUN apt-get update && apt-get install -y --no-install-recommends \
    openssl \
    && rm -rf /var/lib/apt/lists/*

# 工作目录
WORKDIR /app

# 依赖安装阶段
FROM base AS deps
COPY package.json package-lock.json* ./
RUN npm ci

# 构建阶段
FROM base AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
# 构建阶段
ENV PRISMA_SKIP_DATABASE_CONNECTIVITY_CHECK=true

# 设置环境变量，禁止Prisma尝试连接数据库
ENV NODE_ENV=production
ENV PRISMA_SKIP_DATABASE_CONNECTIVITY_CHECK=true
ENV DATABASE_URL="mysql://placeholder:placeholder@localhost:3306/placeholder_db"
ENV NEXTAUTH_URL="http://localhost:8002"
#ENV NEXTAUTH_SECRET="build-time-secret-for-nextauth"

# 进行构建
RUN npm run build

# 生产阶段
FROM base AS runner
WORKDIR /app

ENV NODE_ENV=production
ENV NEXTAUTH_URL="http://localhost:8002"

# 复制必要文件
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/prisma ./prisma

# 需要暴露的端口
# 生产环境变量（由 docker-compose 覆盖）
ENV NODE_ENV=production
ENV PORT=8002  
EXPOSE 8002

# 启动命令
CMD ["node", "server.js"]