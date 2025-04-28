import { NextAuthOptions } from "next-auth"
import CredentialsProvider from "next-auth/providers/credentials"
import { db } from "@/lib/db"
import * as bcrypt from "bcryptjs"
import { getServerSession } from "next-auth"

export const authOptions: NextAuthOptions = {
  providers: [
    CredentialsProvider({
      name: "Credentials",
      credentials: {
        username: { label: "用户名", type: "text" },
        password: { label: "密码", type: "password" }
      },
      async authorize(credentials) {
        console.log("Attempting authorization for username:", credentials?.username);

        if (!credentials?.username || !credentials?.password) {
          console.log("Authorization failed: Missing username or password.");
          return null
        }

        console.log(`Looking up user: ${credentials.username}`);
        const user = await db.user.findUnique({
          where: { username: credentials.username }
        })

        if (!user) {
          console.log(`Authorization failed: User '${credentials.username}' not found.`);
          return null
        }
        console.log(`User '${credentials.username}' found.`);

        if (!user.password) {
          console.log(`Authorization failed: User '${credentials.username}' has no password set.`);
          return null
        }

        console.log(`Checking status for user '${credentials.username}'. Status: ${user.status}`);
        if (user.status !== 1) {
          console.log(`Authorization failed: User '${credentials.username}' is disabled (status: ${user.status}).`);
          // Throwing error will redirect to the error page with a generic message
          // Or you can return null for a generic failure
          throw new Error("用户已被禁用")
        }
        console.log(`User '${credentials.username}' is active.`);

        console.log(`Comparing password for user '${credentials.username}'.`);
        const isPasswordValid = await bcrypt.compare(
          credentials.password,
          user.password
        )

        if (!isPasswordValid) {
          console.log(`Authorization failed: Invalid password for user '${credentials.username}'.`);
          return null
        }

        console.log(`Password validation successful for user '${credentials.username}'.`);
        return {
          id: user.id.toString(),
          name: user.username,
          email: user.email,
          role: user.role
        }
      }
    })
  ],
  session: {
    strategy: "jwt",
    maxAge: 24 * 60 * 60 // 24小时
  },
  callbacks: {
    async jwt({ token, user }) {
      if (user) {
        token.id = user.id
        token.role = user.role
      }
      return token
    },
    async session({ session, token }) {
      if (token && session.user) {
        session.user.id = token.id as string
        session.user.role = token.role as string
      }
      return session
    }
  },
  pages: {
    signIn: "/login"
  }
}

export async function getAuthSession() {
  const session = await getServerSession(authOptions)
  
  if (!session || !session.user) {
    return null
  }
  
  return session
}

export async function getCurrentUser() {
  const session = await getAuthSession();
  
  if (!session?.user?.id) {
    return null;
  }
  
  const user = await db.user.findUnique({
    where: { id: parseInt(session.user.id) }
  });
  
  return user;
} 