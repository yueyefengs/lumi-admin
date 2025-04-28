-- 使用数据库
USE lumi_admin;

-- 插入默认模型
INSERT INTO `models` (`name`, `type`, `provider`, `endpoint`, `parameters`, `is_active`, `created_at`, `updated_at`)
VALUES
('智谱ChatGLM', 'LLM', '智谱AI', 'https://open.bigmodel.cn/api/paas/v3/model-api', '{"model": "chatglm_pro", "temperature": 0.7, "max_tokens": 2048}', 1, NOW(), NOW()),
('讯飞星火', 'LLM', '讯飞', 'https://spark-api.xf-yun.com/v1.1', '{"model": "generalv1.5", "temperature": 0.5, "max_tokens": 2048}', 1, NOW(), NOW()),
('讯飞TTS', 'TTS', '讯飞', 'https://tts-api.xfyun.cn/v2/tts', '{"format": "wav", "rate": 16000}', 1, NOW(), NOW()),
('百度语音识别', 'ASR', '百度', 'https://vop.baidu.com/server_api', '{"format": "pcm", "rate": 16000, "channel": 1}', 1, NOW(), NOW())
ON DUPLICATE KEY UPDATE `updated_at` = NOW();

-- 插入TTS音色
INSERT INTO `voices` (`name`, `code`, `gender`, `model_id`, `is_default`, `created_at`, `updated_at`)
SELECT '小智男声', 'xiaoyi', '男', m.id, 1, NOW(), NOW()
FROM `models` m WHERE m.type = 'TTS' AND m.name = '讯飞TTS'
ON DUPLICATE KEY UPDATE `updated_at` = NOW();

INSERT INTO `voices` (`name`, `code`, `gender`, `model_id`, `is_default`, `created_at`, `updated_at`)
SELECT '小智女声', 'xiaoyu', '女', m.id, 0, NOW(), NOW()
FROM `models` m WHERE m.type = 'TTS' AND m.name = '讯飞TTS'
ON DUPLICATE KEY UPDATE `updated_at` = NOW();

INSERT INTO `voices` (`name`, `code`, `gender`, `model_id`, `is_default`, `created_at`, `updated_at`)
SELECT '童声', 'ninger', '中性', m.id, 0, NOW(), NOW()
FROM `models` m WHERE m.type = 'TTS' AND m.name = '讯飞TTS'
ON DUPLICATE KEY UPDATE `updated_at` = NOW();

-- 插入角色模板
INSERT INTO `agent_templates` (`name`, `description`, `template`, `created_at`, `updated_at`)
VALUES
('标准助手', '通用助手角色模板', '{"name":"小智助手","description":"我是一个通用AI助手，可以回答各种问题并提供帮助。","systemPrompt":"你是小智助手，一个友好、知识渊博的AI。请尽可能简洁明了地回答用户问题。"}', NOW(), NOW()),
('故事讲述者', '专注于讲述故事的角色模板', '{"name":"故事大王","description":"我喜欢讲各种有趣的故事，尤其是儿童故事和寓言故事。","systemPrompt":"你是故事大王，一个擅长讲述生动有趣故事的AI。根据用户的需求，创作或讲述适合的故事，特别注重故事的教育意义和趣味性。"}', NOW(), NOW())
ON DUPLICATE KEY UPDATE `updated_at` = NOW();

-- 插入默认角色
INSERT INTO `agents` (`name`, `description`, `system_prompt`, `is_active`, `created_at`, `updated_at`)
VALUES
('小智助手', '通用AI助手，可以回答各种问题', '你是小智助手，一个友好、知识渊博的AI。请尽可能简洁明了地回答用户问题。', 1, NOW(), NOW())
ON DUPLICATE KEY UPDATE `updated_at` = NOW();

-- 为角色关联默认模型
INSERT INTO `agent_models` (`agent_id`, `model_id`, `is_default`, `created_at`, `updated_at`)
SELECT a.id, m.id, 1, NOW(), NOW()
FROM `agents` a, `models` m
WHERE a.name = '小智助手' AND m.type = 'LLM' AND m.name = '智谱ChatGLM'
ON DUPLICATE KEY UPDATE `is_default` = 1, `updated_at` = NOW();

INSERT INTO `agent_models` (`agent_id`, `model_id`, `is_default`, `created_at`, `updated_at`)
SELECT a.id, m.id, 1, NOW(), NOW()
FROM `agents` a, `models` m
WHERE a.name = '小智助手' AND m.type = 'TTS' AND m.name = '讯飞TTS'
ON DUPLICATE KEY UPDATE `is_default` = 1, `updated_at` = NOW();

INSERT INTO `agent_models` (`agent_id`, `model_id`, `is_default`, `created_at`, `updated_at`)
SELECT a.id, m.id, 1, NOW(), NOW()
FROM `agents` a, `models` m
WHERE a.name = '小智助手' AND m.type = 'ASR' AND m.name = '百度语音识别'
ON DUPLICATE KEY UPDATE `is_default` = 1, `updated_at` = NOW(); 