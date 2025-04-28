FROM node:20-alpine AS base

# 构建阶段
FROM base AS builder
WORKDIR /app

# 安装依赖
COPY package.json ./
RUN npm install

# 复制源代码
COPY . .

# 安装开发依赖
RUN npm install --save-dev @types/node @types/bcryptjs typescript prisma ts-node

# 生成Prisma客户端
RUN npx prisma generate

# 构建应用
ENV NEXT_TELEMETRY_DISABLED=1
RUN npm run build

# 运行阶段
FROM base AS runner
WORKDIR /app

ENV NODE_ENV=production
ENV PORT=8002
ENV NEXT_TELEMETRY_DISABLED=1

# 创建非root用户
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

# 复制构建产物和依赖
COPY --from=builder /app/public ./public
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./ 
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static
COPY --from=builder /app/node_modules ./node_modules 
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/prisma ./prisma

USER nextjs

EXPOSE 8002

# 启动应用
CMD ["node", "server.js"] 