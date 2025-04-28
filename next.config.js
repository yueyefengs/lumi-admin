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
    serverComponentsExternalPackages: ['@prisma/client']
  },
}

module.exports = nextConfig 