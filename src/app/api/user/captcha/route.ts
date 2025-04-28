import { NextResponse } from 'next/server'
import {
  generateCaptchaWithId
} from '@/lib/captchaUtils'

// GET /api/user/captcha - 获取验证码
export async function GET() {
  try {
    // 使用新的无状态验证码生成方法
    const { captchaId, captchaCode } = generateCaptchaWithId()
    
    console.log(`Generated Captcha: ID=${captchaId}, Code=${captchaCode}`)

    return NextResponse.json({
      code: 0,
      data: {
        captchaId: captchaId,
        // 测试环境可以返回验证码，生产环境改为图片形式
        captchaCode: captchaCode, 
        // 图片形式示例
        captchaImage: `data:image/svg+xml;base64,${Buffer.from(generateCaptchaSvg(captchaCode)).toString('base64')}`
      },
      msg: '获取验证码成功'
    })
  } catch (error) {
    console.error('获取验证码失败:', error)
    return NextResponse.json(
      { code: 500, msg: '获取验证码失败', error: (error as Error).message },
      { status: 500 }
    )
  }
}

// 简单的 SVG 验证码生成函数 (仅内部使用，不导出)
function generateCaptchaSvg(code: string): string {
  // 增加随机干扰线和噪点
  let svg = `<svg xmlns="http://www.w3.org/2000/svg" width="120" height="40" viewBox="0 0 120 40">
    <rect width="100%" height="100%" fill="#f0f0f0"/>
    <text x="50%" y="50%" dominant-baseline="middle" text-anchor="middle" font-size="24" font-family="Arial, sans-serif" fill="#333">
      ${code}
    </text>
    <line x1="${Math.random() * 20}" y1="${Math.random() * 40}" x2="${100 + Math.random() * 20}" y2="${Math.random() * 40}" stroke="#bbb" stroke-width="1"/>
    <line x1="${Math.random() * 20}" y1="${Math.random() * 40}" x2="${100 + Math.random() * 20}" y2="${Math.random() * 40}" stroke="#ccc" stroke-width="1"/>
  `;
  // 添加噪点
  for (let i = 0; i < 50; i++) {
    const x = Math.random() * 120;
    const y = Math.random() * 40;
    const color = `rgb(${Math.floor(Math.random() * 150)}, ${Math.floor(Math.random() * 150)}, ${Math.floor(Math.random() * 150)})`;
    svg += `<circle cx="${x}" cy="${y}" r="1" fill="${color}"/>`;
  }
  svg += `</svg>`;
  return svg;
} 