import NextAuth, { DefaultSession } from "next-auth"
import { JWT } from "next-auth/jwt"

declare module "next-auth" {
  /**
   * 扩展默认的Session类型
   */
  interface Session {
    user: {
      id: string
      role: string
    } & DefaultSession["user"]
  }

  /**
   * 扩展默认的User类型
   */
  interface User {
    role?: string
    status?: number
  }
}

declare module "next-auth/jwt" {
  /**
   * 扩展JWT类型
   */
  interface JWT {
    id?: string
    role?: string
  }
} 