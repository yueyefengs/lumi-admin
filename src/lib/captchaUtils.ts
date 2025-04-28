import crypto from 'crypto'

// 生成简单的验证码（4位数字）
export function generateCaptcha(): string {
  return Math.floor(1000 + Math.random() * 9000).toString()
}

// 生成唯一标识码
export function generateUuid(): string {
  return crypto.randomUUID()
}

// 存储验证码 - 使用加密的验证码ID代替内存存储
// 这是一个临时解决方案，生产环境应使用Redis等持久化存储
const CAPTCHA_SECRET = process.env.CAPTCHA_SECRET || 'default-secret-key-for-captcha-please-change-in-production'

// 创建加密的验证码ID（包含验证码和过期时间）
export function createEncryptedCaptchaId(code: string): string {
  const expiry = Date.now() + 5 * 60 * 1000 // 5分钟有效期
  const data = JSON.stringify({ code, expiry })
  
  // 使用简单加密 - 生成随机IV
  const iv = crypto.randomBytes(16)
  const key = crypto.createHash('sha256').update(CAPTCHA_SECRET).digest().subarray(0, 32)
  
  // 创建加密器
  const cipher = crypto.createCipheriv('aes-256-cbc', key, iv)
  
  // 加密数据
  let encrypted = cipher.update(data, 'utf8', 'base64')
  encrypted += cipher.final('base64')
  
  // 返回 IV + 加密数据 作为验证码ID (base64编码)
  return Buffer.from(iv).toString('base64') + '.' + encrypted
}

// 验证验证码
export function verifyCaptcha(encryptedId: string, userCode: string): boolean {
  try {
    const [ivBase64, encryptedData] = encryptedId.split('.')
    if (!ivBase64 || !encryptedData) return false
    
    // 解析IV和加密数据
    const iv = Buffer.from(ivBase64, 'base64')
    const key = crypto.createHash('sha256').update(CAPTCHA_SECRET).digest().subarray(0, 32)
    
    // 创建解密器
    const decipher = crypto.createDecipheriv('aes-256-cbc', key, iv)
    
    // 解密数据
    let decrypted = decipher.update(encryptedData, 'base64', 'utf8')
    decrypted += decipher.final('utf8')
    
    // 解析验证码数据
    const { code, expiry } = JSON.parse(decrypted)
    
    // 检查是否过期
    if (expiry < Date.now()) {
      console.log(`Captcha verification failed: expired.`)
      return false
    }
    
    const isValid = code === userCode
    console.log(`Captcha verification: Valid: ${isValid}`)
    return isValid
  } catch (error) {
    console.error('验证码验证失败:', error)
    return false
  }
}

// 以下函数不再需要，因为我们不再使用内存存储

// 生成验证码并返回加密的ID
export function generateCaptchaWithId(): { captchaId: string, captchaCode: string } {
  const code = generateCaptcha()
  const captchaId = createEncryptedCaptchaId(code)
  return { captchaId, captchaCode: code }
}

// 清理过期验证码 - 不再需要，但保留函数签名以兼容现有代码
export function cleanupExpiredCaptchas() {
  // 无状态实现不需要清理
}

// 限制存储大小 - 不再需要，但保留函数签名以兼容现有代码
export function limitCaptchaStoreSize() {
  // 无状态实现不需要限制大小
} 