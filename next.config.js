/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'standalone',
  basePath: '/xiaozhi',
  async rewrites() {
    return [
      {
        source: '/xiaozhi/api/:path*',
        destination: '/api/:path*',
      },
    ];
  },
  experimental: {
    serverComponentsExternalPackages: ['@prisma/client', 'bcryptjs'],
  },
  env: {
    DATABASE_URL: 'mysql://root:password@localhost:3306/lumi_admin',
    NEXTAUTH_URL: 'http://localhost:8002',
    NEXTAUTH_SECRET: 'build-time-secret-for-nextauth'
  },
  staticPageGenerationTimeout: 1000,
  poweredByHeader: false,
}

module.exports = () => {
  if (process.env.NODE_ENV === 'production') {
    process.env.PRISMA_SKIP_DATABASE_CONNECTIVITY_CHECK = 'true';
  }
  return nextConfig;
} 