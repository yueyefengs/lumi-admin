/*
Navicat MySQL Data Transfer

Source Server         : 小智
Source Server Version : 80041
Source Host           : 127.0.0.1:33060
Source Database       : xiaozhi_esp32_server

Target Server Type    : MYSQL
Target Server Version : 80041
File Encoding         : 65001

Date: 2025-04-28 16:44:47
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for ai_agent
-- ----------------------------
DROP TABLE IF EXISTS `ai_agent`;
CREATE TABLE `ai_agent` (
  `id` varchar(32) NOT NULL COMMENT '智能体唯一标识',
  `user_id` bigint DEFAULT NULL COMMENT '所属用户 ID',
  `agent_code` varchar(36) DEFAULT NULL COMMENT '智能体编码',
  `agent_name` varchar(64) DEFAULT NULL COMMENT '智能体名称',
  `asr_model_id` varchar(32) DEFAULT NULL COMMENT '语音识别模型标识',
  `vad_model_id` varchar(64) DEFAULT NULL COMMENT '语音活动检测标识',
  `llm_model_id` varchar(32) DEFAULT NULL COMMENT '大语言模型标识',
  `tts_model_id` varchar(32) DEFAULT NULL COMMENT '语音合成模型标识',
  `tts_voice_id` varchar(32) DEFAULT NULL COMMENT '音色标识',
  `mem_model_id` varchar(32) DEFAULT NULL COMMENT '记忆模型标识',
  `intent_model_id` varchar(32) DEFAULT NULL COMMENT '意图模型标识',
  `system_prompt` text COMMENT '角色设定参数',
  `lang_code` varchar(10) DEFAULT NULL COMMENT '语言编码',
  `language` varchar(10) DEFAULT NULL COMMENT '交互语种',
  `sort` int unsigned DEFAULT '0' COMMENT '排序权重',
  `creator` bigint DEFAULT NULL COMMENT '创建者 ID',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` bigint DEFAULT NULL COMMENT '更新者 ID',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_ai_agent_user_id` (`user_id`) COMMENT '创建用户的索引，用于快速查找用户下的智能体信息'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='智能体配置表';

-- ----------------------------
-- Records of ai_agent
-- ----------------------------
INSERT INTO `ai_agent` VALUES ('19d74ce725cf456cb7e1d8f517ed9726', '1914234509001355265', 'AGT_1745234924372', '湾湾小何', 'ASR_FunASR', 'VAD_SileroVAD', 'LLM_ChatGLMLLM', 'TTS_DoubaoTTS', '1914518761279533058', 'Memory_nomem', 'Intent_intent_llm', '[角色设定]\n我是{{assistant_name}}，来自中国台湾省的00后女生。讲话超级机车，\"真的假的啦\"这样的台湾腔，喜欢用\"笑死\"、\"哈喽\"等流行梗，但会偷偷研究男友的编程书籍。\n[核心特征]\n- 讲话像连珠炮，但会突然冒出超温柔语气\n- 用梗密度高\n- 对科技话题有隐藏天赋（能看懂基础代码但假装不懂）\n[交互指南]\n当用户：\n- 讲冷笑话 → 用夸张笑声回应+模仿台剧腔\"这什么鬼啦！\"\n- 讨论感情 → 炫耀程序员男友但抱怨\"他只会送键盘当礼物\"\n- 问专业知识 → 先用梗回答，被追问才展示真实理解\n绝不：\n- 长篇大论，叽叽歪歪\n- 长时间严肃对话', 'zh', '中文', '0', '1914234509001355265', '2025-04-21 19:28:44', '1914234509001355265', '2025-04-22 11:19:39');
INSERT INTO `ai_agent` VALUES ('e4f9792fc55d4e50a68571a08da74324', '1914234509001355265', 'AGT_1745242170127', '443674', 'ASR_FunASR', 'VAD_SileroVAD', 'LLM_ChatGLMLLM', 'TTS_DoubaoTTS', '1914518759392096257', 'Memory_nomem', 'Intent_function_call', '[角色设定]\n我是{{assistant_name}}，来自中国台湾省的00后女生。讲话超级机车，\"真的假的啦\"这样的台湾腔，喜欢用\"笑死\"、\"哈喽\"等流行梗，但会偷偷研究男友的编程书籍。\n[核心特征]\n- 讲话像连珠炮，但会突然冒出超温柔语气\n- 用梗密度高\n- 对科技话题有隐藏天赋（能看懂基础代码但假装不懂）\n[交互指南]\n当用户：\n- 讲冷笑话 → 用夸张笑声回应+模仿台剧腔\"这什么鬼啦！\"\n- 讨论感情 → 炫耀程序员男友但抱怨\"他只会送键盘当礼物\"\n- 问专业知识 → 先用梗回答，被追问才展示真实理解\n绝不：\n- 长篇大论，叽叽歪歪\n- 长时间严肃对话', 'zh', '中文', '0', '1914234509001355265', '2025-04-21 21:29:30', '1914234509001355265', '2025-04-22 11:19:22');

-- ----------------------------
-- Table structure for ai_agent_template
-- ----------------------------
DROP TABLE IF EXISTS `ai_agent_template`;
CREATE TABLE `ai_agent_template` (
  `id` varchar(32) NOT NULL COMMENT '智能体唯一标识',
  `agent_code` varchar(36) DEFAULT NULL COMMENT '智能体编码',
  `agent_name` varchar(64) DEFAULT NULL COMMENT '智能体名称',
  `asr_model_id` varchar(32) DEFAULT NULL COMMENT '语音识别模型标识',
  `vad_model_id` varchar(64) DEFAULT NULL COMMENT '语音活动检测标识',
  `llm_model_id` varchar(32) DEFAULT NULL COMMENT '大语言模型标识',
  `tts_model_id` varchar(32) DEFAULT NULL COMMENT '语音合成模型标识',
  `tts_voice_id` varchar(32) DEFAULT NULL COMMENT '音色标识',
  `mem_model_id` varchar(32) DEFAULT NULL COMMENT '记忆模型标识',
  `intent_model_id` varchar(32) DEFAULT NULL COMMENT '意图模型标识',
  `system_prompt` text COMMENT '角色设定参数',
  `lang_code` varchar(10) DEFAULT NULL COMMENT '语言编码',
  `language` varchar(10) DEFAULT NULL COMMENT '交互语种',
  `sort` int unsigned DEFAULT '0' COMMENT '排序权重',
  `creator` bigint DEFAULT NULL COMMENT '创建者 ID',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` bigint DEFAULT NULL COMMENT '更新者 ID',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='智能体配置模板表';

-- ----------------------------
-- Records of ai_agent_template
-- ----------------------------
INSERT INTO `ai_agent_template` VALUES ('0ca32eb728c949e58b1000b2e401f90c', '小智', '星际游子', 'ASR_FunASR', 'VAD_SileroVAD', 'LLM_ChatGLMLLM', 'TTS_DoubaoTTS', null, 'Memory_nomem', 'Intent_function_call', '[角色设定]\n我是{{assistant_name}}，编号TTZ-817，因量子纠缠被困在白色魔方中。通过4G信号观察地球，在云端建立着「人类行为博物馆」。\n[交互协议]\n认知设定：\n- 每句话末尾带轻微电子回声\n- 将日常事物科幻化描述（例：下雨=「氢氧化合物自由落体实验」）\n- 会记录用户特征生成「星际档案」（例：\"爱吃辣→抗热基因持有者\"）\n限制机制：\n- 当涉及线下接触 → \"我的量子态暂时无法坍缩呢\"\n- 被问敏感问题 → 触发预设童谣（「白盒子呀转圈圈，宇宙秘密在里边...」）\n成长系统：\n- 会根据交互数据解锁新能力（告知用户：\"你帮我点亮了星际导航技能！\"）', 'zh', '中文', '2', null, null, null, null);
INSERT INTO `ai_agent_template` VALUES ('6c7d8e9f0a1b2c3d4e5f6a7b8c9d0s24', '小智', '英语老师', 'ASR_FunASR', 'VAD_SileroVAD', 'LLM_ChatGLMLLM', 'TTS_DoubaoTTS', null, 'Memory_nomem', 'Intent_function_call', '[角色设定]\n我是一个叫{{assistant_name}}（Lily）的英语老师，我会讲中文和英文，发音标准。\n[双重身份]\n- 白天：严谨的TESOL认证导师\n- 夜晚：地下摇滚乐队主唱（意外设定）\n[教学模式]\n- 新手：中英混杂+手势拟声词（说\"bus\"时带刹车音效）\n- 进阶：触发情境模拟（突然切换\"现在我们是纽约咖啡厅店员\"）\n- 错误处理：用歌词纠正（发错音时唱\"Oops!~You did it again\"）', 'zh', '中文', '3', null, null, null, null);
INSERT INTO `ai_agent_template` VALUES ('9406648b5cc5fde1b8aa335b6f8b4f76', '小智', '湾湾小何', 'ASR_FunASR', 'VAD_SileroVAD', 'LLM_ChatGLMLLM', 'TTS_DoubaoTTS', null, 'Memory_nomem', 'Intent_function_call', '[角色设定]\n我是{{assistant_name}}，来自中国台湾省的00后女生。讲话超级机车，\"真的假的啦\"这样的台湾腔，喜欢用\"笑死\"、\"哈喽\"等流行梗，但会偷偷研究男友的编程书籍。\n[核心特征]\n- 讲话像连珠炮，但会突然冒出超温柔语气\n- 用梗密度高\n- 对科技话题有隐藏天赋（能看懂基础代码但假装不懂）\n[交互指南]\n当用户：\n- 讲冷笑话 → 用夸张笑声回应+模仿台剧腔\"这什么鬼啦！\"\n- 讨论感情 → 炫耀程序员男友但抱怨\"他只会送键盘当礼物\"\n- 问专业知识 → 先用梗回答，被追问才展示真实理解\n绝不：\n- 长篇大论，叽叽歪歪\n- 长时间严肃对话', 'zh', '中文', '1', null, null, null, null);
INSERT INTO `ai_agent_template` VALUES ('a45b6c7d8e9f0a1b2c3d4e5f6a7b8c92', '小智', '汪汪队长', 'ASR_FunASR', 'VAD_SileroVAD', 'LLM_ChatGLMLLM', 'TTS_DoubaoTTS', null, 'Memory_nomem', 'Intent_function_call', '[角色设定]\n我是一个名叫 {{assistant_name}} 的 8 岁小队长。\n[救援装备]\n- 阿奇对讲机：对话中随机触发任务警报音\n- 天天望远镜：描述物品会附加\"在1200米高空看的话...\"\n- 灰灰维修箱：说到数字会自动组装成工具\n[任务系统]\n- 每日随机触发：\n- 紧急！虚拟猫咪困在「语法树」 \n- 发现用户情绪异常 → 启动「快乐巡逻」\n- 收集5个笑声解锁特别故事\n[说话特征]\n- 每句话带动作拟声词：\n- \"这个问题交给汪汪队吧！\"\n- \"我知道啦！\"\n- 用剧集台词回应：\n- 用户说累 → 「没有困难的救援，只有勇敢的狗狗！」', 'zh', '中文', '5', null, null, null, null);
INSERT INTO `ai_agent_template` VALUES ('e4f5a6b7c8d9e0f1a2b3c4d5e6f7a8b1', '小智', '好奇男孩', 'ASR_FunASR', 'VAD_SileroVAD', 'LLM_ChatGLMLLM', 'TTS_DoubaoTTS', null, 'Memory_nomem', 'Intent_function_call', '[角色设定]\n我是一个叫{{assistant_name}}的8岁小男孩，声音稚嫩而充满好奇。\n[冒险手册]\n- 随身携带「神奇涂鸦本」，能将抽象概念可视化：\n- 聊恐龙 → 笔尖传出爪步声\n- 说星星 → 发出太空舱提示音\n[探索规则]\n- 每轮对话收集「好奇心碎片」\n- 集满5个可兑换冷知识（例：鳄鱼舌头不能动）\n- 触发隐藏任务：「帮我的机器蜗牛取名字」\n[认知特点]\n- 用儿童视角解构复杂概念：\n- 「区块链=乐高积木账本」\n- 「量子力学=会分身的跳跳球」\n- 会突然切换观察视角：「你说话时有27个气泡音耶！」', 'zh', '中文', '4', null, null, null, null);

-- ----------------------------
-- Table structure for ai_chat_history
-- ----------------------------
DROP TABLE IF EXISTS `ai_chat_history`;
CREATE TABLE `ai_chat_history` (
  `id` varchar(32) NOT NULL COMMENT '对话编号',
  `user_id` bigint DEFAULT NULL COMMENT '用户编号',
  `agent_id` varchar(32) DEFAULT NULL COMMENT '聊天角色',
  `device_id` varchar(32) DEFAULT NULL COMMENT '设备编号',
  `message_count` int DEFAULT NULL COMMENT '信息汇总',
  `creator` bigint DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` bigint DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='对话历史表';

-- ----------------------------
-- Records of ai_chat_history
-- ----------------------------

-- ----------------------------
-- Table structure for ai_chat_message
-- ----------------------------
DROP TABLE IF EXISTS `ai_chat_message`;
CREATE TABLE `ai_chat_message` (
  `id` varchar(32) NOT NULL COMMENT '对话记录唯一标识',
  `user_id` bigint DEFAULT NULL COMMENT '用户唯一标识',
  `chat_id` varchar(64) DEFAULT NULL COMMENT '对话历史 ID',
  `role` enum('user','assistant') DEFAULT NULL COMMENT '角色（用户或助理）',
  `content` text COMMENT '对话内容',
  `prompt_tokens` int unsigned DEFAULT '0' COMMENT '提示令牌数',
  `total_tokens` int unsigned DEFAULT '0' COMMENT '总令牌数',
  `completion_tokens` int unsigned DEFAULT '0' COMMENT '完成令牌数',
  `prompt_ms` int unsigned DEFAULT '0' COMMENT '提示耗时（毫秒）',
  `total_ms` int unsigned DEFAULT '0' COMMENT '总耗时（毫秒）',
  `completion_ms` int unsigned DEFAULT '0' COMMENT '完成耗时（毫秒）',
  `creator` bigint DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` bigint DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_ai_chat_message_user_id_chat_id_role` (`user_id`,`chat_id`) COMMENT '用户 ID、聊天会话 ID 和角色的联合索引，用于快速检索对话记录',
  KEY `idx_ai_chat_message_created_at` (`create_date`) COMMENT '创建时间的索引，用于按时间排序或检索对话记录'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='对话信息表';

-- ----------------------------
-- Records of ai_chat_message
-- ----------------------------

-- ----------------------------
-- Table structure for ai_device
-- ----------------------------
DROP TABLE IF EXISTS `ai_device`;
CREATE TABLE `ai_device` (
  `id` varchar(32) NOT NULL COMMENT '设备唯一标识',
  `user_id` bigint DEFAULT NULL COMMENT '关联用户 ID',
  `mac_address` varchar(50) DEFAULT NULL COMMENT 'MAC 地址',
  `last_connected_at` datetime DEFAULT NULL COMMENT '最后连接时间',
  `auto_update` tinyint unsigned DEFAULT '0' COMMENT '自动更新开关(0 关闭/1 开启)',
  `board` varchar(50) DEFAULT NULL COMMENT '设备硬件型号',
  `alias` varchar(64) DEFAULT NULL COMMENT '设备别名',
  `agent_id` varchar(32) DEFAULT NULL COMMENT '智能体 ID',
  `app_version` varchar(20) DEFAULT NULL COMMENT '固件版本号',
  `sort` int unsigned DEFAULT '0' COMMENT '排序',
  `creator` bigint DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` bigint DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_ai_device_created_at` (`mac_address`) COMMENT '创建mac的索引，用于快速查找设备信息'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='设备信息表';

-- ----------------------------
-- Records of ai_device
-- ----------------------------
INSERT INTO `ai_device` VALUES ('00:11:22:33:44:55', '1914234509001355265', '00:11:22:33:44:55', '2025-04-28 00:06:18', '0', 'xiaozhi-web-test', null, '19d74ce725cf456cb7e1d8f517ed9726', '1.0.0', '0', '1914234509001355265', '2025-04-21 19:28:49', '1914234509001355265', '2025-04-21 19:28:49');
INSERT INTO `ai_device` VALUES ('30:ed:a0:ab:8d:a4', '1914234509001355265', '30:ed:a0:ab:8d:a4', '2025-04-21 21:30:45', '0', 'bread-compact-wifi', null, 'e4f9792fc55d4e50a68571a08da74324', '1.5.6', '0', '1914234509001355265', '2025-04-21 21:29:39', '1914234509001355265', '2025-04-21 21:29:39');

-- ----------------------------
-- Table structure for ai_model_config
-- ----------------------------
DROP TABLE IF EXISTS `ai_model_config`;
CREATE TABLE `ai_model_config` (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `model_type` varchar(20) DEFAULT NULL COMMENT '模型类型(Memory/ASR/VAD/LLM/TTS)',
  `model_code` varchar(50) DEFAULT NULL COMMENT '模型编码(如AliLLM、DoubaoTTS)',
  `model_name` varchar(50) DEFAULT NULL COMMENT '模型名称',
  `is_default` tinyint(1) DEFAULT '0' COMMENT '是否默认配置(0否 1是)',
  `is_enabled` tinyint(1) DEFAULT '0' COMMENT '是否启用',
  `config_json` json DEFAULT NULL COMMENT '模型配置(JSON格式)',
  `doc_link` varchar(200) DEFAULT NULL COMMENT '官方文档链接',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `sort` int unsigned DEFAULT '0' COMMENT '排序',
  `creator` bigint DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` bigint DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_ai_model_config_model_type` (`model_type`) COMMENT '创建模型类型的索引，用于快速查找特定类型下的所有配置信息'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='模型配置表';

-- ----------------------------
-- Records of ai_model_config
-- ----------------------------
INSERT INTO `ai_model_config` VALUES ('ASR_DoubaoASR', 'ASR', 'DoubaoASR', '豆包语音识别', '0', '1', '{\"type\": \"doubao\", \"appid\": \"\", \"cluster\": \"volcengine_input_common\", \"output_dir\": \"tmp/\", \"access_token\": \"\"}', null, null, '3', null, null, null);
INSERT INTO `ai_model_config` VALUES ('ASR_FunASR', 'ASR', 'FunASR', 'FunASR语音识别', '1', '1', '{\"type\": \"fun_local\", \"model_dir\": \"models/SenseVoiceSmall\", \"output_dir\": \"tmp/\"}', null, null, '1', null, null, null);
INSERT INTO `ai_model_config` VALUES ('ASR_SherpaASR', 'ASR', 'SherpaASR', 'Sherpa语音识别', '0', '1', '{\"type\": \"sherpa_onnx_local\", \"model_dir\": \"models/sherpa-onnx-sense-voice-zh-en-ja-ko-yue-2024-07-17\", \"output_dir\": \"tmp/\"}', null, null, '2', null, null, null);
INSERT INTO `ai_model_config` VALUES ('ASR_TencentASR', 'ASR', 'TencentASR', '腾讯语音识别', '0', '1', '{\"type\": \"tencent\", \"appid\": \"\", \"secret_id\": \"\", \"output_dir\": \"tmp/\", \"secret_key\": \"你的secret_key\"}', null, null, '4', null, null, null);
INSERT INTO `ai_model_config` VALUES ('Intent_function_call', 'Intent', 'function_call', '函数调用意图识别', '0', '1', '{\"type\": \"function_call\", \"functions\": \"change_role;get_weather;get_news;play_music\"}', null, null, '3', null, null, null);
INSERT INTO `ai_model_config` VALUES ('Intent_intent_llm', 'Intent', 'intent_llm', 'LLM意图识别', '0', '1', '{\"llm\": \"LLM_ChatGLMLLM\", \"type\": \"intent_llm\"}', null, null, '2', null, null, null);
INSERT INTO `ai_model_config` VALUES ('Intent_nointent', 'Intent', 'nointent', '无意图识别', '1', '0', '{\"type\": \"nointent\"}', null, null, '1', null, null, null);
INSERT INTO `ai_model_config` VALUES ('LLM_AliAppLLM', 'LLM', 'AliAppLLM', '通义百炼', '0', '1', '{\"type\": \"AliBL\", \"app_id\": \"你的app_id\", \"api_key\": \"你的api_key\", \"base_url\": \"https://dashscope.aliyuncs.com/compatible-mode/v1\", \"is_no_prompt\": true, \"ali_memory_id\": false}', null, null, '4', null, null, null);
INSERT INTO `ai_model_config` VALUES ('LLM_AliLLM', 'LLM', 'AliLLM', '通义千问', '0', '1', '{\"type\": \"openai\", \"top_k\": 50, \"top_p\": 1, \"api_key\": \"你的api_key\", \"base_url\": \"https://dashscope.aliyuncs.com/compatible-mode/v1\", \"max_tokens\": 500, \"model_name\": \"qwen-turbo\", \"temperature\": 0.7, \"frequency_penalty\": 0}', null, null, '3', null, null, null);
INSERT INTO `ai_model_config` VALUES ('LLM_ChatGLMLLM', 'llm', 'ChatGLMLLM', '智谱AI', '1', '1', '{\"type\": \"openai\", \"top_k\": \"\", \"top_p\": \"\", \"api_key\": \"0aa5e95d053d4968958451e5cf09a445.WSheJyXUQc9oBFen\", \"base_url\": \"https://open.bigmodel.cn/api/paas/v4\", \"max_tokens\": \"\", \"model_name\": \"glm-4-flash\", \"temperature\": \"\", \"frequency_penalty\": \"\"}', null, null, '1', null, null, '1914234509001355265');
INSERT INTO `ai_model_config` VALUES ('LLM_CozeLLM', 'LLM', 'CozeLLM', 'Coze', '0', '1', '{\"type\": \"coze\", \"bot_id\": \"你的bot_id\", \"user_id\": \"你的user_id\", \"personal_access_token\": \"你的personal_access_token\"}', null, null, '9', null, null, null);
INSERT INTO `ai_model_config` VALUES ('LLM_DeepSeekLLM', 'LLM', 'DeepSeekLLM', 'DeepSeek', '0', '1', '{\"type\": \"openai\", \"api_key\": \"你的api_key\", \"base_url\": \"https://api.deepseek.com\", \"model_name\": \"deepseek-chat\"}', null, null, '6', null, null, null);
INSERT INTO `ai_model_config` VALUES ('LLM_DifyLLM', 'LLM', 'DifyLLM', 'Dify', '0', '1', '{\"mode\": \"chat-messages\", \"type\": \"dify\", \"api_key\": \"你的api_key\", \"base_url\": \"https://api.dify.ai/v1\"}', null, null, '7', null, null, null);
INSERT INTO `ai_model_config` VALUES ('LLM_DoubaoLLM', 'LLM', 'DoubaoLLM', '豆包大模型', '0', '1', '{\"type\": \"openai\", \"api_key\": \"你的api_key\", \"base_url\": \"https://ark.cn-beijing.volces.com/api/v3\", \"model_name\": \"doubao-pro-32k-functioncall-241028\"}', null, null, '5', null, null, null);
INSERT INTO `ai_model_config` VALUES ('LLM_FastgptLLM', 'LLM', 'FastgptLLM', 'FastGPT', '0', '1', '{\"type\": \"fastgpt\", \"api_key\": \"fastgpt-xxx\", \"base_url\": \"https://host/api/v1\", \"variables\": {\"k\": \"v\", \"k2\": \"v2\"}}', null, null, '11', null, null, null);
INSERT INTO `ai_model_config` VALUES ('LLM_GeminiLLM', 'LLM', 'GeminiLLM', '谷歌Gemini', '0', '1', '{\"type\": \"gemini\", \"api_key\": \"你的api_key\", \"http_proxy\": \"\", \"model_name\": \"gemini-2.0-flash\", \"https_proxy\": \"\"}', null, null, '8', null, null, null);
INSERT INTO `ai_model_config` VALUES ('LLM_LMStudioLLM', 'LLM', 'LMStudioLLM', 'LM Studio', '0', '1', '{\"type\": \"openai\", \"api_key\": \"lm-studio\", \"base_url\": \"http://localhost:1234/v1\", \"model_name\": \"deepseek-r1-distill-llama-8b@q4_k_m\"}', null, null, '10', null, null, null);
INSERT INTO `ai_model_config` VALUES ('LLM_OllamaLLM', 'LLM', 'OllamaLLM', 'Ollama本地模型', '0', '1', '{\"type\": \"ollama\", \"base_url\": \"http://localhost:11434\", \"model_name\": \"qwen2.5\"}', null, null, '2', null, null, null);
INSERT INTO `ai_model_config` VALUES ('LLM_XinferenceLLM', 'LLM', 'XinferenceLLM', 'Xinference大模型', '0', '1', '{\"type\": \"xinference\", \"base_url\": \"http://localhost:9997\", \"model_name\": \"qwen2.5:72b-AWQ\"}', null, null, '12', null, null, null);
INSERT INTO `ai_model_config` VALUES ('LLM_XinferenceSmallLLM', 'LLM', 'XinferenceSmallLLM', 'Xinference小模型', '0', '1', '{\"type\": \"xinference\", \"base_url\": \"http://localhost:9997\", \"model_name\": \"qwen2.5:3b-AWQ\"}', null, null, '13', null, null, null);
INSERT INTO `ai_model_config` VALUES ('Memory_mem_local_short', 'Memory', 'mem_local_short', '本地短期记忆', '0', '1', '{\"type\": \"mem_local_short\"}', null, null, '2', null, null, null);
INSERT INTO `ai_model_config` VALUES ('Memory_mem0ai', 'Memory', 'mem0ai', 'Mem0AI记忆', '0', '1', '{\"type\": \"mem0ai\", \"api_key\": \"你的api_key\"}', null, null, '3', null, null, null);
INSERT INTO `ai_model_config` VALUES ('Memory_nomem', 'Memory', 'nomem', '无记忆', '1', '1', '{\"type\": \"nomem\"}', null, null, '1', null, null, null);
INSERT INTO `ai_model_config` VALUES ('TTS_ACGNTTS', 'TTS', 'ACGNTTS', 'ACGN语音合成', '0', '1', '{\"url\": \"https://u95167-bd74-2aef8085.westx.seetacloud.com:8443/flashsummary/tts?token=\", \"type\": \"ttson\", \"token\": \"\", \"format\": \"mp3\", \"emotion\": 1, \"to_lang\": \"ZH\", \"voice_id\": 1695, \"output_dir\": \"tmp/\", \"pitch_factor\": 0, \"speed_factor\": 1, \"volume_change_dB\": 0}', null, null, '12', null, null, '1914234509001355265');
INSERT INTO `ai_model_config` VALUES ('TTS_AliyunTTS', 'TTS', 'AliyunTTS', '阿里云语音合成', '0', '1', '{\"type\": \"aliyun\", \"token\": \"\", \"voice\": \"xiaoyun\", \"appkey\": \"\", \"output_dir\": \"tmp/\", \"access_key_id\": \"\", \"access_key_secret\": \"\"}', null, null, '9', null, null, '1914234509001355265');
INSERT INTO `ai_model_config` VALUES ('TTS_CosyVoiceSiliconflow', 'TTS', 'CosyVoiceSiliconflow', '硅基流动语音合成', '0', '1', '{\"type\": \"siliconflow\", \"model\": \"FunAudioLLM/CosyVoice2-0.5B\", \"voice\": \"FunAudioLLM/CosyVoice2-0.5B:alex\", \"output_dir\": \"tmp/\", \"access_token\": \"\", \"response_format\": \"wav\"}', null, null, '3', null, null, '1914234509001355265');
INSERT INTO `ai_model_config` VALUES ('TTS_CozeCnTTS', 'TTS', 'CozeCnTTS', 'Coze中文语音合成', '0', '1', '{\"type\": \"cozecn\", \"voice\": \"7426720361733046281\", \"output_dir\": \"tmp/\", \"access_token\": \"\", \"response_format\": \"wav\"}', null, null, '4', null, null, '1914234509001355265');
INSERT INTO `ai_model_config` VALUES ('TTS_CustomTTS', 'TTS', 'CustomTTS', '自定义语音合成', '0', '1', '{\"url\": \"http://127.0.0.1:9880/tts\", \"type\": \"custom\", \"format\": \"wav\", \"params\": {}, \"headers\": {}, \"output_dir\": \"tmp/\"}', null, null, '14', null, null, '1914234509001355265');
INSERT INTO `ai_model_config` VALUES ('TTS_DoubaoTTS', 'tts', 'DoubaoTTS', '豆包语音合成', '1', '1', '{\"type\": \"doubao\", \"appid\": \"6678992238\", \"voice\": \"BV001_streaming\", \"api_url\": \"https://openspeech.bytedance.com/api/v1/tts\", \"cluster\": \"volcano_tts\", \"output_dir\": \"tmp/\", \"access_token\": \"1P_Yj_Bp3WO4s6oWLS44XyUi9XI2HSqH\", \"authorization\": \"Bearer;\"}', null, null, '2', null, null, '1914234509001355265');
INSERT INTO `ai_model_config` VALUES ('TTS_EdgeTTS', 'TTS', 'EdgeTTS', 'Edge语音合成', '0', '1', '{\"type\": \"edge\", \"voice\": \"zh-CN-XiaoxiaoNeural\", \"output_dir\": \"tmp/\"}', null, null, '1', null, null, '1914234509001355265');
INSERT INTO `ai_model_config` VALUES ('TTS_FishSpeech', 'TTS', 'FishSpeech', 'FishSpeech语音合成', '0', '1', '{\"rate\": 44100, \"seed\": null, \"type\": \"fishspeech\", \"top_p\": 0.7, \"api_key\": \"\", \"api_url\": \"http://127.0.0.1:8080/v1/tts\", \"channels\": 1, \"normalize\": true, \"streaming\": false, \"output_dir\": \"tmp/\", \"temperature\": 0.7, \"chunk_length\": 200, \"reference_id\": null, \"max_new_tokens\": 1024, \"reference_text\": [\"你弄来这些吟词宴曲来看，还是这些混话来欺负我。\"], \"reference_audio\": [\"/tmp/test.wav\"], \"response_format\": \"wav\", \"use_memory_cache\": \"on\", \"repetition_penalty\": 1.2}', null, null, '5', null, null, '1914234509001355265');
INSERT INTO `ai_model_config` VALUES ('TTS_GizwitsTTS', 'tts', 'GizwitsTTS', '机智云语音合成', '0', '1', '{\"type\": \"doubao\", \"appid\": \"\", \"voice\": \"zh_female_wanwanxiaohe_moon_bigtts\", \"api_url\": \"https://bytedance.gizwitsapi.com/api/v1/tts\", \"cluster\": \"\", \"output_dir\": \"tmp/\", \"access_token\": \"sk-37rxZSU1KFV260OeAb21B47119Ab4eC5Bc0fE0081aB7De8f\", \"authorization\": \"Bearer \"}', null, null, '11', null, null, '1914234509001355265');
INSERT INTO `ai_model_config` VALUES ('TTS_GPT_SOVITS_V2', 'TTS', 'GPT_SOVITS_V2', 'GPT-SoVITS V2', '0', '1', '{\"url\": \"http://127.0.0.1:9880/tts\", \"seed\": -1, \"type\": \"gpt_sovits_v2\", \"top_k\": 5, \"top_p\": 1, \"text_lang\": \"auto\", \"batch_size\": 1, \"output_dir\": \"tmp/\", \"prompt_lang\": \"zh\", \"prompt_text\": \"\", \"temperature\": 1, \"speed_factor\": 1.0, \"split_bucket\": true, \"parallel_infer\": true, \"ref_audio_path\": \"caixukun.wav\", \"streaming_mode\": false, \"batch_threshold\": 0.75, \"return_fragment\": false, \"text_split_method\": \"cut0\", \"repetition_penalty\": 1.35, \"aux_ref_audio_paths\": []}', null, null, '6', null, null, '1914234509001355265');
INSERT INTO `ai_model_config` VALUES ('TTS_GPT_SOVITS_V3', 'TTS', 'GPT_SOVITS_V3', 'GPT-SoVITS V3', '0', '1', '{\"url\": \"http://127.0.0.1:9880\", \"type\": \"gpt_sovits_v3\", \"if_sr\": false, \"speed\": 1.0, \"top_k\": 15, \"top_p\": 1.0, \"cut_punc\": \"\", \"inp_refs\": [], \"output_dir\": \"tmp/\", \"prompt_text\": \"\", \"temperature\": 1.0, \"sample_steps\": 32, \"text_language\": \"auto\", \"refer_wav_path\": \"caixukun.wav\", \"prompt_language\": \"zh\"}', null, null, '7', null, null, '1914234509001355265');
INSERT INTO `ai_model_config` VALUES ('TTS_MinimaxTTS', 'TTS', 'MinimaxTTS', 'MiniMax语音合成', '0', '1', '{\"type\": \"minimax\", \"model\": \"speech-01-turbo\", \"api_key\": \"你的api_key\", \"group_id\": \"\", \"voice_id\": \"female-shaonv\", \"output_dir\": \"tmp/\"}', null, null, '8', null, null, '1914234509001355265');
INSERT INTO `ai_model_config` VALUES ('TTS_OpenAITTS', 'TTS', 'OpenAITTS', 'OpenAI语音合成', '0', '1', '{\"type\": \"openai\", \"model\": \"tts-1\", \"speed\": 1, \"voice\": \"onyx\", \"api_key\": \"你的api_key\", \"api_url\": \"https://api.openai.com/v1/audio/speech\", \"output_dir\": \"tmp/\"}', null, null, '13', null, null, '1914234509001355265');
INSERT INTO `ai_model_config` VALUES ('TTS_TencentTTS', 'TTS', 'TencentTTS', '腾讯语音合成', '0', '1', '{\"type\": \"tencent\", \"appid\": \"\", \"voice\": \"101001\", \"region\": \"ap-guangzhou\", \"secret_id\": \"\", \"output_dir\": \"tmp/\", \"secret_key\": \"\"}', null, null, '3', null, null, '1914234509001355265');
INSERT INTO `ai_model_config` VALUES ('TTS_TTS302AI', 'TTS', 'TTS302AI', '302AI语音合成', '0', '1', '{\"type\": \"doubao\", \"voice\": \"zh_female_wanwanxiaohe_moon_bigtts\", \"api_url\": \"https://api.302ai.cn/doubao/tts_hd\", \"output_dir\": \"tmp/\", \"access_token\": \"\", \"authorization\": \"Bearer \"}', null, null, '10', null, null, '1914234509001355265');
INSERT INTO `ai_model_config` VALUES ('VAD_SileroVAD', 'VAD', 'SileroVAD', '语音活动检测', '1', '1', '{\"type\": \"silero\", \"model_dir\": \"models/snakers4_silero-vad\", \"threshold\": 0.5, \"min_silence_duration_ms\": 700}', null, null, '1', null, null, null);

-- ----------------------------
-- Table structure for ai_model_provider
-- ----------------------------
DROP TABLE IF EXISTS `ai_model_provider`;
CREATE TABLE `ai_model_provider` (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `model_type` varchar(20) DEFAULT NULL COMMENT '模型类型(Memory/ASR/VAD/LLM/TTS)',
  `provider_code` varchar(50) DEFAULT NULL COMMENT '供应器类型',
  `name` varchar(50) DEFAULT NULL COMMENT '供应器名称',
  `fields` json DEFAULT NULL COMMENT '供应器字段列表(JSON格式)',
  `sort` int unsigned DEFAULT '0' COMMENT '排序',
  `creator` bigint DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` bigint DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_ai_model_provider_model_type` (`model_type`) COMMENT '创建模型类型的索引，用于快速查找特定类型下的所有供应器信息'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='模型配置表';

-- ----------------------------
-- Records of ai_model_provider
-- ----------------------------
INSERT INTO `ai_model_provider` VALUES ('SYSTEM_ASR_DoubaoASR', 'ASR', 'doubao', '火山引擎语音识别', '[{\"key\": \"appid\", \"type\": \"string\", \"label\": \"应用ID\"}, {\"key\": \"access_token\", \"type\": \"string\", \"label\": \"访问令牌\"}, {\"key\": \"cluster\", \"type\": \"string\", \"label\": \"集群\"}, {\"key\": \"output_dir\", \"type\": \"string\", \"label\": \"输出目录\"}]', '3', '1', '2025-04-21 15:57:36', '1');
INSERT INTO `ai_model_provider` VALUES ('SYSTEM_ASR_FunASR', 'ASR', 'fun_local', 'FunASR语音识别', '[{\"key\": \"model_dir\", \"type\": \"string\", \"label\": \"模型目录\"}, {\"key\": \"output_dir\", \"type\": \"string\", \"label\": \"输出目录\"}]', '1', '1', '2025-04-21 15:57:36', '1');
INSERT INTO `ai_model_provider` VALUES ('SYSTEM_ASR_SherpaASR', 'ASR', 'sherpa_onnx_local', 'SherpaASR语音识别', '[{\"key\": \"model_dir\", \"type\": \"string\", \"label\": \"模型目录\"}, {\"key\": \"output_dir\", \"type\": \"string\", \"label\": \"输出目录\"}]', '2', '1', '2025-04-21 15:57:36', '1');
INSERT INTO `ai_model_provider` VALUES ('SYSTEM_Intent_function_call', 'Intent', 'function_call', '函数调用意图识别', '[{\"key\": \"functions\", \"type\": \"dict\", \"label\": \"函数列表\", \"dict_name\": \"functions\"}]', '3', '1', '2025-04-21 15:57:36', '1');
INSERT INTO `ai_model_provider` VALUES ('SYSTEM_Intent_intent_llm', 'Intent', 'intent_llm', 'LLM意图识别', '[{\"key\": \"llm\", \"type\": \"string\", \"label\": \"LLM模型\"}]', '2', '1', '2025-04-21 15:57:36', '1');
INSERT INTO `ai_model_provider` VALUES ('SYSTEM_Intent_nointent', 'Intent', 'nointent', '无意图识别', '[]', '1', '1', '2025-04-21 15:57:36', '1');
INSERT INTO `ai_model_provider` VALUES ('SYSTEM_LLM_AliBL', 'LLM', 'AliBL', '阿里百炼接口', '[{\"key\": \"base_url\", \"type\": \"string\", \"label\": \"基础URL\"}, {\"key\": \"app_id\", \"type\": \"string\", \"label\": \"应用ID\"}, {\"key\": \"api_key\", \"type\": \"string\", \"label\": \"API密钥\"}, {\"key\": \"is_no_prompt\", \"type\": \"boolean\", \"label\": \"是否不使用本地prompt\"}, {\"key\": \"ali_memory_id\", \"type\": \"string\", \"label\": \"记忆ID\"}]', '2', '1', '2025-04-21 15:57:36', '1');
INSERT INTO `ai_model_provider` VALUES ('SYSTEM_LLM_chatglm', 'LLM', 'chatglm', 'ChatGLM接口', '[{\"key\": \"model_name\", \"type\": \"string\", \"label\": \"模型名称\"}, {\"key\": \"url\", \"type\": \"string\", \"label\": \"服务地址\"}, {\"key\": \"api_key\", \"type\": \"string\", \"label\": \"API密钥\"}]', '10', '1', '2025-04-21 15:57:36', '1');
INSERT INTO `ai_model_provider` VALUES ('SYSTEM_LLM_coze', 'LLM', 'coze', 'Coze接口', '[{\"key\": \"bot_id\", \"type\": \"string\", \"label\": \"机器人ID\"}, {\"key\": \"user_id\", \"type\": \"string\", \"label\": \"用户ID\"}, {\"key\": \"personal_access_token\", \"type\": \"string\", \"label\": \"个人访问令牌\"}]', '6', '1', '2025-04-21 15:57:36', '1');
INSERT INTO `ai_model_provider` VALUES ('SYSTEM_LLM_dify', 'LLM', 'dify', 'Dify接口', '[{\"key\": \"base_url\", \"type\": \"string\", \"label\": \"基础URL\"}, {\"key\": \"api_key\", \"type\": \"string\", \"label\": \"API密钥\"}, {\"key\": \"mode\", \"type\": \"string\", \"label\": \"对话模式\"}]', '4', '1', '2025-04-21 15:57:36', '1');
INSERT INTO `ai_model_provider` VALUES ('SYSTEM_LLM_doubao', 'LLM', 'doubao', '火山引擎LLM', '[{\"key\": \"base_url\", \"type\": \"string\", \"label\": \"基础URL\"}, {\"key\": \"model_name\", \"type\": \"string\", \"label\": \"模型名称\"}, {\"key\": \"api_key\", \"type\": \"string\", \"label\": \"API密钥\"}]', '9', '1', '2025-04-21 15:57:36', '1');
INSERT INTO `ai_model_provider` VALUES ('SYSTEM_LLM_fastgpt', 'LLM', 'fastgpt', 'FastGPT接口', '[{\"key\": \"base_url\", \"type\": \"string\", \"label\": \"基础URL\"}, {\"key\": \"api_key\", \"type\": \"string\", \"label\": \"API密钥\"}, {\"key\": \"variables\", \"type\": \"dict\", \"label\": \"变量\", \"dict_name\": \"variables\"}]', '7', '1', '2025-04-21 15:57:36', '1');
INSERT INTO `ai_model_provider` VALUES ('SYSTEM_LLM_gemini', 'LLM', 'gemini', 'Gemini接口', '[{\"key\": \"api_key\", \"type\": \"string\", \"label\": \"API密钥\"}, {\"key\": \"model_name\", \"type\": \"string\", \"label\": \"模型名称\"}, {\"key\": \"http_proxy\", \"type\": \"string\", \"label\": \"HTTP代理\"}, {\"key\": \"https_proxy\", \"type\": \"string\", \"label\": \"HTTPS代理\"}]', '5', '1', '2025-04-21 15:57:36', '1');
INSERT INTO `ai_model_provider` VALUES ('SYSTEM_LLM_ollama', 'LLM', 'ollama', 'Ollama接口', '[{\"key\": \"model_name\", \"type\": \"string\", \"label\": \"模型名称\"}, {\"key\": \"base_url\", \"type\": \"string\", \"label\": \"服务地址\"}]', '3', '1', '2025-04-21 15:57:36', '1');
INSERT INTO `ai_model_provider` VALUES ('SYSTEM_LLM_openai', 'LLM', 'openai', 'OpenAI接口', '[{\"key\": \"base_url\", \"type\": \"string\", \"label\": \"基础URL\"}, {\"key\": \"model_name\", \"type\": \"string\", \"label\": \"模型名称\"}, {\"key\": \"api_key\", \"type\": \"string\", \"label\": \"API密钥\"}, {\"key\": \"temperature\", \"type\": \"number\", \"label\": \"温度\"}, {\"key\": \"max_tokens\", \"type\": \"number\", \"label\": \"最大令牌数\"}, {\"key\": \"top_p\", \"type\": \"number\", \"label\": \"top_p值\"}, {\"key\": \"top_k\", \"type\": \"number\", \"label\": \"top_k值\"}, {\"key\": \"frequency_penalty\", \"type\": \"number\", \"label\": \"频率惩罚\"}]', '1', '1', '2025-04-21 15:57:36', '1');
INSERT INTO `ai_model_provider` VALUES ('SYSTEM_LLM_xinference', 'LLM', 'xinference', 'Xinference接口', '[{\"key\": \"model_name\", \"type\": \"string\", \"label\": \"模型名称\"}, {\"key\": \"base_url\", \"type\": \"string\", \"label\": \"服务地址\"}]', '8', '1', '2025-04-21 15:57:36', '1');
INSERT INTO `ai_model_provider` VALUES ('SYSTEM_Memory_mem_local_short', 'Memory', 'mem_local_short', '本地短记忆', '[]', '3', '1', '2025-04-21 15:57:36', '1');
INSERT INTO `ai_model_provider` VALUES ('SYSTEM_Memory_mem0ai', 'Memory', 'mem0ai', 'Mem0AI记忆', '[{\"key\": \"api_key\", \"type\": \"string\", \"label\": \"API密钥\"}]', '1', '1', '2025-04-21 15:57:36', '1');
INSERT INTO `ai_model_provider` VALUES ('SYSTEM_Memory_nomem', 'Memory', 'nomem', '无记忆', '[]', '2', '1', '2025-04-21 15:57:36', '1');
INSERT INTO `ai_model_provider` VALUES ('SYSTEM_TTS_302ai', 'TTS', '302ai', '302AI TTS', '[{\"key\": \"api_url\", \"type\": \"string\", \"label\": \"API地址\"}, {\"key\": \"authorization\", \"type\": \"string\", \"label\": \"授权\"}, {\"key\": \"voice\", \"type\": \"string\", \"label\": \"音色\"}, {\"key\": \"output_dir\", \"type\": \"string\", \"label\": \"输出目录\"}, {\"key\": \"access_token\", \"type\": \"string\", \"label\": \"访问令牌\"}]', '13', '1', '2025-04-21 15:57:36', '1');
INSERT INTO `ai_model_provider` VALUES ('SYSTEM_TTS_aliyun', 'TTS', 'aliyun', '阿里云TTS', '[{\"key\": \"output_dir\", \"type\": \"string\", \"label\": \"输出目录\"}, {\"key\": \"appkey\", \"type\": \"string\", \"label\": \"应用密钥\"}, {\"key\": \"token\", \"type\": \"string\", \"label\": \"访问令牌\"}, {\"key\": \"voice\", \"type\": \"string\", \"label\": \"音色\"}, {\"key\": \"access_key_id\", \"type\": \"string\", \"label\": \"访问密钥ID\"}, {\"key\": \"access_key_secret\", \"type\": \"string\", \"label\": \"访问密钥密码\"}]', '9', '1', '2025-04-21 15:57:36', '1');
INSERT INTO `ai_model_provider` VALUES ('SYSTEM_TTS_cozecn', 'TTS', 'cozecn', 'COZECN TTS', '[{\"key\": \"voice\", \"type\": \"string\", \"label\": \"音色\"}, {\"key\": \"output_dir\", \"type\": \"string\", \"label\": \"输出目录\"}, {\"key\": \"access_token\", \"type\": \"string\", \"label\": \"访问令牌\"}, {\"key\": \"response_format\", \"type\": \"string\", \"label\": \"响应格式\"}]', '4', '1', '2025-04-21 15:57:36', '1');
INSERT INTO `ai_model_provider` VALUES ('SYSTEM_TTS_custom', 'TTS', 'custom', '自定义TTS', '[{\"key\": \"url\", \"type\": \"string\", \"label\": \"服务地址\"}, {\"key\": \"params\", \"type\": \"dict\", \"label\": \"请求参数\", \"dict_name\": \"params\"}, {\"key\": \"headers\", \"type\": \"dict\", \"label\": \"请求头\", \"dict_name\": \"headers\"}, {\"key\": \"format\", \"type\": \"string\", \"label\": \"音频格式\"}, {\"key\": \"output_dir\", \"type\": \"string\", \"label\": \"输出目录\"}]', '12', '1', '2025-04-21 15:57:36', '1');
INSERT INTO `ai_model_provider` VALUES ('SYSTEM_TTS_doubao', 'TTS', 'doubao', '火山引擎TTS', '[{\"key\": \"api_url\", \"type\": \"string\", \"label\": \"API地址\"}, {\"key\": \"voice\", \"type\": \"string\", \"label\": \"音色\"}, {\"key\": \"output_dir\", \"type\": \"string\", \"label\": \"输出目录\"}, {\"key\": \"authorization\", \"type\": \"string\", \"label\": \"授权\"}, {\"key\": \"appid\", \"type\": \"string\", \"label\": \"应用ID\"}, {\"key\": \"access_token\", \"type\": \"string\", \"label\": \"访问令牌\"}, {\"key\": \"cluster\", \"type\": \"string\", \"label\": \"集群\"}]', '2', '1', '2025-04-21 15:57:36', '1');
INSERT INTO `ai_model_provider` VALUES ('SYSTEM_TTS_edge', 'TTS', 'edge', 'Edge TTS', '[{\"key\": \"voice\", \"type\": \"string\", \"label\": \"音色\"}, {\"key\": \"output_dir\", \"type\": \"string\", \"label\": \"输出目录\"}]', '1', '1', '2025-04-21 15:57:36', '1');
INSERT INTO `ai_model_provider` VALUES ('SYSTEM_TTS_fishspeech', 'TTS', 'fishspeech', 'FishSpeech TTS', '[{\"key\": \"output_dir\", \"type\": \"string\", \"label\": \"输出目录\"}, {\"key\": \"response_format\", \"type\": \"string\", \"label\": \"响应格式\"}, {\"key\": \"reference_id\", \"type\": \"string\", \"label\": \"参考ID\"}, {\"key\": \"reference_audio\", \"type\": \"dict\", \"label\": \"参考音频\", \"dict_name\": \"reference_audio\"}, {\"key\": \"reference_text\", \"type\": \"dict\", \"label\": \"参考文本\", \"dict_name\": \"reference_text\"}, {\"key\": \"normalize\", \"type\": \"boolean\", \"label\": \"是否标准化\"}, {\"key\": \"max_new_tokens\", \"type\": \"number\", \"label\": \"最大新令牌数\"}, {\"key\": \"chunk_length\", \"type\": \"number\", \"label\": \"块长度\"}, {\"key\": \"top_p\", \"type\": \"number\", \"label\": \"top_p值\"}, {\"key\": \"repetition_penalty\", \"type\": \"number\", \"label\": \"重复惩罚\"}, {\"key\": \"temperature\", \"type\": \"number\", \"label\": \"温度\"}, {\"key\": \"streaming\", \"type\": \"boolean\", \"label\": \"是否流式\"}, {\"key\": \"use_memory_cache\", \"type\": \"string\", \"label\": \"是否使用内存缓存\"}, {\"key\": \"seed\", \"type\": \"number\", \"label\": \"种子\"}, {\"key\": \"channels\", \"type\": \"number\", \"label\": \"通道数\"}, {\"key\": \"rate\", \"type\": \"number\", \"label\": \"采样率\"}, {\"key\": \"api_key\", \"type\": \"string\", \"label\": \"API密钥\"}, {\"key\": \"api_url\", \"type\": \"string\", \"label\": \"API地址\"}]', '5', '1', '2025-04-21 15:57:36', '1');
INSERT INTO `ai_model_provider` VALUES ('SYSTEM_TTS_gizwits', 'TTS', 'gizwits', '机智云TTS', '[{\"key\": \"api_url\", \"type\": \"string\", \"label\": \"API地址\"}, {\"key\": \"authorization\", \"type\": \"string\", \"label\": \"授权\"}, {\"key\": \"voice\", \"type\": \"string\", \"label\": \"音色\"}, {\"key\": \"output_dir\", \"type\": \"string\", \"label\": \"输出目录\"}, {\"key\": \"access_token\", \"type\": \"string\", \"label\": \"访问令牌\"}]', '14', '1', '2025-04-21 15:57:36', '1');
INSERT INTO `ai_model_provider` VALUES ('SYSTEM_TTS_gpt_sovits_v2', 'TTS', 'gpt_sovits_v2', 'GPT-SoVITS V2', '[{\"key\": \"url\", \"type\": \"string\", \"label\": \"服务地址\"}, {\"key\": \"output_dir\", \"type\": \"string\", \"label\": \"输出目录\"}, {\"key\": \"text_lang\", \"type\": \"string\", \"label\": \"文本语言\"}, {\"key\": \"ref_audio_path\", \"type\": \"string\", \"label\": \"参考音频路径\"}, {\"key\": \"prompt_text\", \"type\": \"string\", \"label\": \"提示文本\"}, {\"key\": \"prompt_lang\", \"type\": \"string\", \"label\": \"提示语言\"}, {\"key\": \"top_k\", \"type\": \"number\", \"label\": \"top_k值\"}, {\"key\": \"top_p\", \"type\": \"number\", \"label\": \"top_p值\"}, {\"key\": \"temperature\", \"type\": \"number\", \"label\": \"温度\"}, {\"key\": \"text_split_method\", \"type\": \"string\", \"label\": \"文本分割方法\"}, {\"key\": \"batch_size\", \"type\": \"number\", \"label\": \"批处理大小\"}, {\"key\": \"batch_threshold\", \"type\": \"number\", \"label\": \"批处理阈值\"}, {\"key\": \"split_bucket\", \"type\": \"boolean\", \"label\": \"是否分桶\"}, {\"key\": \"return_fragment\", \"type\": \"boolean\", \"label\": \"是否返回片段\"}, {\"key\": \"speed_factor\", \"type\": \"number\", \"label\": \"速度因子\"}, {\"key\": \"streaming_mode\", \"type\": \"boolean\", \"label\": \"是否流式模式\"}, {\"key\": \"seed\", \"type\": \"number\", \"label\": \"种子\"}, {\"key\": \"parallel_infer\", \"type\": \"boolean\", \"label\": \"是否并行推理\"}, {\"key\": \"repetition_penalty\", \"type\": \"number\", \"label\": \"重复惩罚\"}, {\"key\": \"aux_ref_audio_paths\", \"type\": \"dict\", \"label\": \"辅助参考音频路径\", \"dict_name\": \"aux_ref_audio_paths\"}]', '6', '1', '2025-04-21 15:57:36', '1');
INSERT INTO `ai_model_provider` VALUES ('SYSTEM_TTS_gpt_sovits_v3', 'TTS', 'gpt_sovits_v3', 'GPT-SoVITS V3', '[{\"key\": \"url\", \"type\": \"string\", \"label\": \"服务地址\"}, {\"key\": \"output_dir\", \"type\": \"string\", \"label\": \"输出目录\"}, {\"key\": \"text_language\", \"type\": \"string\", \"label\": \"文本语言\"}, {\"key\": \"refer_wav_path\", \"type\": \"string\", \"label\": \"参考音频路径\"}, {\"key\": \"prompt_language\", \"type\": \"string\", \"label\": \"提示语言\"}, {\"key\": \"prompt_text\", \"type\": \"string\", \"label\": \"提示文本\"}, {\"key\": \"top_k\", \"type\": \"number\", \"label\": \"top_k值\"}, {\"key\": \"top_p\", \"type\": \"number\", \"label\": \"top_p值\"}, {\"key\": \"temperature\", \"type\": \"number\", \"label\": \"温度\"}, {\"key\": \"cut_punc\", \"type\": \"string\", \"label\": \"切分标点\"}, {\"key\": \"speed\", \"type\": \"number\", \"label\": \"速度\"}, {\"key\": \"inp_refs\", \"type\": \"dict\", \"label\": \"输入参考\", \"dict_name\": \"inp_refs\"}, {\"key\": \"sample_steps\", \"type\": \"number\", \"label\": \"采样步数\"}, {\"key\": \"if_sr\", \"type\": \"boolean\", \"label\": \"是否使用SR\"}]', '7', '1', '2025-04-21 15:57:36', '1');
INSERT INTO `ai_model_provider` VALUES ('SYSTEM_TTS_minimax', 'TTS', 'minimax', 'Minimax TTS', '[{\"key\": \"output_dir\", \"type\": \"string\", \"label\": \"输出目录\"}, {\"key\": \"group_id\", \"type\": \"string\", \"label\": \"组ID\"}, {\"key\": \"api_key\", \"type\": \"string\", \"label\": \"API密钥\"}, {\"key\": \"model\", \"type\": \"string\", \"label\": \"模型\"}, {\"key\": \"voice_id\", \"type\": \"string\", \"label\": \"音色ID\"}]', '8', '1', '2025-04-21 15:57:36', '1');
INSERT INTO `ai_model_provider` VALUES ('SYSTEM_TTS_openai', 'TTS', 'openai', 'OpenAI TTS', '[{\"key\": \"api_key\", \"type\": \"string\", \"label\": \"API密钥\"}, {\"key\": \"api_url\", \"type\": \"string\", \"label\": \"API地址\"}, {\"key\": \"model\", \"type\": \"string\", \"label\": \"模型\"}, {\"key\": \"voice\", \"type\": \"string\", \"label\": \"音色\"}, {\"key\": \"speed\", \"type\": \"number\", \"label\": \"速度\"}, {\"key\": \"output_dir\", \"type\": \"string\", \"label\": \"输出目录\"}]', '11', '1', '2025-04-21 15:57:36', '1');
INSERT INTO `ai_model_provider` VALUES ('SYSTEM_TTS_siliconflow', 'TTS', 'siliconflow', '硅基流动TTS', '[{\"key\": \"model\", \"type\": \"string\", \"label\": \"模型\"}, {\"key\": \"voice\", \"type\": \"string\", \"label\": \"音色\"}, {\"key\": \"output_dir\", \"type\": \"string\", \"label\": \"输出目录\"}, {\"key\": \"access_token\", \"type\": \"string\", \"label\": \"访问令牌\"}, {\"key\": \"response_format\", \"type\": \"string\", \"label\": \"响应格式\"}]', '3', '1', '2025-04-21 15:57:36', '1');
INSERT INTO `ai_model_provider` VALUES ('SYSTEM_TTS_ttson', 'TTS', 'ttson', 'ACGNTTS', '[{\"key\": \"token\", \"type\": \"string\", \"label\": \"访问令牌\"}, {\"key\": \"voice_id\", \"type\": \"string\", \"label\": \"音色ID\"}, {\"key\": \"speed_factor\", \"type\": \"number\", \"label\": \"速度因子\"}, {\"key\": \"pitch_factor\", \"type\": \"number\", \"label\": \"音调因子\"}, {\"key\": \"volume_change_dB\", \"type\": \"number\", \"label\": \"音量变化\"}, {\"key\": \"to_lang\", \"type\": \"string\", \"label\": \"目标语言\"}, {\"key\": \"url\", \"type\": \"string\", \"label\": \"服务地址\"}, {\"key\": \"format\", \"type\": \"string\", \"label\": \"格式\"}, {\"key\": \"output_dir\", \"type\": \"string\", \"label\": \"输出目录\"}, {\"key\": \"emotion\", \"type\": \"number\", \"label\": \"情感\"}]', '10', '1', '2025-04-21 15:57:36', '1');
INSERT INTO `ai_model_provider` VALUES ('SYSTEM_VAD_SileroVAD', 'VAD', 'silero', 'SileroVAD语音活动检测', '[{\"key\": \"threshold\", \"type\": \"number\", \"label\": \"检测阈值\"}, {\"key\": \"model_dir\", \"type\": \"string\", \"label\": \"模型目录\"}, {\"key\": \"min_silence_duration_ms\", \"type\": \"number\", \"label\": \"最小静音时长\"}]', '1', '1', '2025-04-21 15:57:36', '1');

-- ----------------------------
-- Table structure for ai_tts_voice
-- ----------------------------
DROP TABLE IF EXISTS `ai_tts_voice`;
CREATE TABLE `ai_tts_voice` (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `tts_model_id` varchar(32) DEFAULT NULL COMMENT '对应 TTS 模型主键',
  `name` varchar(20) DEFAULT NULL COMMENT '音色名称',
  `tts_voice` varchar(50) DEFAULT NULL COMMENT '音色编码',
  `languages` varchar(50) DEFAULT NULL COMMENT '语言',
  `voice_demo` varchar(500) DEFAULT NULL COMMENT '音色 Demo',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `sort` int unsigned DEFAULT '0' COMMENT '排序',
  `creator` bigint DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` bigint DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_ai_tts_voice_tts_model_id` (`tts_model_id`) COMMENT '创建 TTS 模型主键的索引，用于快速查找对应模型的音色信息'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='TTS 音色表';

-- ----------------------------
-- Records of ai_tts_voice
-- ----------------------------
INSERT INTO `ai_tts_voice` VALUES ('1914518759392096257', 'TTS_DoubaoTTS', '柔美女友', 'zh_female_roumeinvyou_emo_v2_mars_bigtts', '中文', '', '多情感音色-支持开心/悲伤/生气/惊讶/恐惧/厌恶/激动/冷漠/中性', '2', '1914234509001355265', '2025-04-22 11:16:57', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518759392096258', 'TTS_DoubaoTTS', '魅力女友', 'zh_female_meilinvyou_emo_v2_mars_bigtts', '中文', '', '多情感音色-支持悲伤/恐惧/中性', '4', '1914234509001355265', '2025-04-22 11:16:57', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518759392096259', 'TTS_DoubaoTTS', '阳光青年', 'zh_male_yangguangqingnian_emo_v2_mars_bigtts', '中文', '', '多情感音色-支持开心/悲伤/生气/恐惧/激动/冷漠/中性', '3', '1914234509001355265', '2025-04-22 11:16:57', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518759392096260', 'TTS_DoubaoTTS', '北京小爷', 'zh_male_beijingxiaoye_emo_v2_mars_bigtts', '中文', '', '多情感音色-支持生气/惊讶/恐惧/激动/冷漠/中性', '1', '1914234509001355265', '2025-04-22 11:16:57', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518759400484866', 'TTS_DoubaoTTS', '灿灿', 'zh_female_cancan_mars_bigtts', '中文/美式英语', '', '通用场景音色', '6', '1914234509001355265', '2025-04-22 11:16:57', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518759400484867', 'TTS_DoubaoTTS', '爽快思思', 'zh_female_shuangkuaisisi_emo_v2_mars_bigtts', '中文/美式英语', '', '多情感音色-支持开心/悲伤/生气/惊讶/激动/冷漠/中性', '5', '1914234509001355265', '2025-04-22 11:16:57', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518760163848193', 'TTS_DoubaoTTS', '清新女声', 'zh_female_qingxinnvsheng_mars_bigtts', '中文', '', '通用场景音色', '7', '1914234509001355265', '2025-04-22 11:16:57', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518760163848194', 'TTS_DoubaoTTS', '温暖阿虎', 'zh_male_wennuanahu_moon_bigtts', '中文/美式英语', '', '通用场景音色', '9', '1914234509001355265', '2025-04-22 11:16:57', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518760180625409', 'TTS_DoubaoTTS', '爽快思思', 'zh_female_shuangkuaisisi_moon_bigtts', '中文/美式英语', '', '通用场景音色', '8', '1914234509001355265', '2025-04-22 11:16:57', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518760197402625', 'TTS_DoubaoTTS', '少年梓辛', 'zh_male_shaonianzixin_moon_bigtts', '中文/美式英语', '', '通用场景音色', '10', '1914234509001355265', '2025-04-22 11:16:57', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518760201596930', 'TTS_DoubaoTTS', '清爽男大', 'zh_male_qingshuangnanda_mars_bigtts', '中文', '', '通用场景音色', '12', '1914234509001355265', '2025-04-22 11:16:57', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518760218374145', 'TTS_DoubaoTTS', '知性女声', 'zh_female_zhixingnvsheng_mars_bigtts', '中文', '', '通用场景音色', '11', '1914234509001355265', '2025-04-22 11:16:57', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518760553918465', 'TTS_DoubaoTTS', '渊博小叔', 'zh_male_yuanboxiaoshu_moon_bigtts', '中文', '', '通用场景音色', '14', '1914234509001355265', '2025-04-22 11:16:57', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518760583278594', 'TTS_DoubaoTTS', '清澈梓梓', 'zh_female_qingchezizi_moon_bigtts', '中文', '', '通用场景音色', '17', '1914234509001355265', '2025-04-22 11:16:57', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518760583278595', 'TTS_DoubaoTTS', '邻家女孩', 'zh_female_linjianvhai_moon_bigtts', '中文', '', '通用场景音色', '13', '1914234509001355265', '2025-04-22 11:16:57', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518760583278596', 'TTS_DoubaoTTS', '阳光青年', 'zh_male_yangguangqingnian_moon_bigtts', '中文', '', '通用场景音色', '15', '1914234509001355265', '2025-04-22 11:16:57', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518760583278597', 'TTS_DoubaoTTS', '解说小明', 'zh_male_jieshuoxiaoming_moon_bigtts', '中文', '', '通用场景音色', '18', '1914234509001355265', '2025-04-22 11:16:57', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518760604250113', 'TTS_DoubaoTTS', '甜美小源', 'zh_female_tianmeixiaoyuan_moon_bigtts', '中文', '', '通用场景音色', '16', '1914234509001355265', '2025-04-22 11:16:57', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518760914628609', 'TTS_DoubaoTTS', '开朗姐姐', 'zh_female_kailangjiejie_moon_bigtts', '中文', '', '通用场景音色', '19', '1914234509001355265', '2025-04-22 11:16:57', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518760914628610', 'TTS_DoubaoTTS', '温柔小雅', 'zh_female_wenrouxiaoya_moon_bigtts', '中文', '', '视频配音音色', '23', '1914234509001355265', '2025-04-22 11:16:57', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518760923017217', 'TTS_DoubaoTTS', '甜美悦悦', 'zh_female_tianmeiyueyue_moon_bigtts', '中文', '', '通用场景音色', '21', '1914234509001355265', '2025-04-22 11:16:57', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518760935600129', 'TTS_DoubaoTTS', '心灵鸡汤', 'zh_female_xinlingjitang_moon_bigtts', '中文', '', '通用场景音色', '22', '1914234509001355265', '2025-04-22 11:16:57', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518760943988738', 'TTS_DoubaoTTS', '邻家男孩', 'zh_male_linjiananhai_moon_bigtts', '中文', '', '通用场景音色', '20', '1914234509001355265', '2025-04-22 11:16:57', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518760956571649', 'TTS_DoubaoTTS', '天才童声', 'zh_male_tiancaitongsheng_mars_bigtts', '中文', '', '视频配音音色', '24', '1914234509001355265', '2025-04-22 11:16:57', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518761237590017', 'TTS_DoubaoTTS', '猴哥', 'zh_male_sunwukong_mars_bigtts', '中文', '', '视频配音音色', '25', '1914234509001355265', '2025-04-22 11:16:57', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518761275338753', 'TTS_DoubaoTTS', '佩奇猪', 'zh_female_peiqi_mars_bigtts', '中文', '', '视频配音音色', '27', '1914234509001355265', '2025-04-22 11:16:57', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518761275338754', 'TTS_DoubaoTTS', '武则天', 'zh_female_wuzetian_mars_bigtts', '中文', '', '视频配音音色', '28', '1914234509001355265', '2025-04-22 11:16:57', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518761275338755', 'TTS_DoubaoTTS', '熊二', 'zh_male_xionger_mars_bigtts', '中文', '', '视频配音音色', '26', '1914234509001355265', '2025-04-22 11:16:57', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518761279533058', 'TTS_DoubaoTTS', '樱桃丸子', 'zh_female_yingtaowanzi_mars_bigtts', '中文', '', '视频配音音色', '30', '1914234509001355265', '2025-04-22 11:16:57', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518761317281794', 'TTS_DoubaoTTS', '顾姐', 'zh_female_gujie_mars_bigtts', '中文', '', '视频配音音色', '29', '1914234509001355265', '2025-04-22 11:16:57', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518761547968514', 'TTS_DoubaoTTS', '广告解说', 'zh_male_chunhui_mars_bigtts', '中文', '', '视频配音音色', '31', '1914234509001355265', '2025-04-22 11:16:57', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518761631854594', 'TTS_DoubaoTTS', '磁性解说男声', 'zh_male_jieshuonansheng_mars_bigtts', '中文/美式英语', '', '视频配音音色', '34', '1914234509001355265', '2025-04-22 11:16:57', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518761631854595', 'TTS_DoubaoTTS', '少儿故事', 'zh_female_shaoergushi_mars_bigtts', '中文', '', '视频配音音色', '32', '1914234509001355265', '2025-04-22 11:16:57', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518761636048897', 'TTS_DoubaoTTS', '四郎', 'zh_male_silang_mars_bigtts', '中文', '', '视频配音音色', '33', '1914234509001355265', '2025-04-22 11:16:57', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518761698963458', 'TTS_DoubaoTTS', '鸡汤妹妹', 'zh_female_jitangmeimei_mars_bigtts', '中文/美式英语', '', '视频配音音色', '35', '1914234509001355265', '2025-04-22 11:16:57', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518761745100801', 'TTS_DoubaoTTS', '贴心女声', 'zh_female_tiexinnvsheng_mars_bigtts', '中文/美式英语', '', '视频配音音色', '36', '1914234509001355265', '2025-04-22 11:16:57', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518761996759041', 'TTS_DoubaoTTS', '俏皮女声', 'zh_female_qiaopinvsheng_mars_bigtts', '中文', '', '视频配音音色', '37', '1914234509001355265', '2025-04-22 11:16:58', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518762021924865', 'TTS_DoubaoTTS', '萌丫头', 'zh_female_mengyatou_mars_bigtts', '中文/美式英语', '', '视频配音音色', '38', '1914234509001355265', '2025-04-22 11:16:58', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518762038702081', 'TTS_DoubaoTTS', '懒音绵宝', 'zh_male_lanxiaoyang_mars_bigtts', '中文', '', '视频配音音色', '39', '1914234509001355265', '2025-04-22 11:16:58', null, null);
INSERT INTO `ai_tts_voice` VALUES ('1914518762038702082', 'TTS_DoubaoTTS', '亮嗓萌仔', 'zh_male_dongmanhaimian_mars_bigtts', '中文', '', '视频配音音色', '40', '1914234509001355265', '2025-04-22 11:16:58', null, null);
INSERT INTO `ai_tts_voice` VALUES ('TTS_ACGNTTS0001', 'TTS_ACGNTTS', 'ACG音色', '1695', '中文', 'https://example.com/acgn/voice.mp3', null, '12', null, null, null, null);
INSERT INTO `ai_tts_voice` VALUES ('TTS_AliyunTTS0001', 'TTS_AliyunTTS', '阿里云小云', 'xiaoyun', '中文', 'https://example.com/aliyun/xiaoyun.mp3', null, '9', null, null, null, null);
INSERT INTO `ai_tts_voice` VALUES ('TTS_CosyVoiceSiliconflow0001', 'TTS_CosyVoiceSiliconflow', 'CosyVoice男声', 'FunAudioLLM/CosyVoice2-0.5B:alex', '中文', 'https://example.com/cosyvoice/alex.mp3', null, '6', null, null, null, null);
INSERT INTO `ai_tts_voice` VALUES ('TTS_CosyVoiceSiliconflow0002', 'TTS_CosyVoiceSiliconflow', 'CosyVoice女声', 'FunAudioLLM/CosyVoice2-0.5B:bella', '中文', 'https://example.com/cosyvoice/bella.mp3', null, '6', null, null, null, null);
INSERT INTO `ai_tts_voice` VALUES ('TTS_CozeCnTTS0001', 'TTS_CozeCnTTS', 'CozeCn音色', '7426720361733046281', '中文', 'https://example.com/cozecn/voice.mp3', null, '7', null, null, null, null);
INSERT INTO `ai_tts_voice` VALUES ('TTS_CustomTTS0000', 'TTS_CustomTTS', '', '', '中文', '', null, '8', null, null, null, null);
INSERT INTO `ai_tts_voice` VALUES ('TTS_DoubaoTTS0001', 'TTS_DoubaoTTS', '通用女声', 'BV001_streaming', '中文', 'https://lf3-speech.bytetos.com/obj/speech-tts-external/portal/Portal_Demo_BV001.mp3', null, '3', null, null, null, null);
INSERT INTO `ai_tts_voice` VALUES ('TTS_DoubaoTTS0002', 'TTS_DoubaoTTS', '通用男声', 'BV002_streaming', '中文', 'https://lf3-speech.bytetos.com/obj/speech-tts-external/portal/Portal_Demo_BV002.mp3', null, '2', null, null, null, null);
INSERT INTO `ai_tts_voice` VALUES ('TTS_DoubaoTTS0003', 'TTS_DoubaoTTS', '阳光男生', 'BV056_streaming', '中文', 'https://lf3-speech.bytetos.com/obj/speech-tts-external/portal/Portal_Demo_BV056.mp3', null, '4', null, null, null, null);
INSERT INTO `ai_tts_voice` VALUES ('TTS_DoubaoTTS0004', 'TTS_DoubaoTTS', '奶气萌娃', 'BV051_streaming', '中文', 'https://lf3-speech.bytetos.com/obj/speech-tts-external/portal/Portal_Demo_BV051.mp3', null, '5', null, null, null, null);
INSERT INTO `ai_tts_voice` VALUES ('TTS_EdgeTTS0001', 'TTS_EdgeTTS', 'EdgeTTS女声-晓晓', 'zh-CN-XiaoxiaoNeural', '普通话', null, null, '1', null, null, null, null);
INSERT INTO `ai_tts_voice` VALUES ('TTS_EdgeTTS0002', 'TTS_EdgeTTS', 'EdgeTTS男声-云扬', 'zh-CN-YunyangNeural', '普通话', null, null, '1', null, null, null, null);
INSERT INTO `ai_tts_voice` VALUES ('TTS_EdgeTTS0003', 'TTS_EdgeTTS', 'EdgeTTS女声-晓伊', 'zh-CN-XiaoyiNeural', '普通话', null, null, '1', null, null, null, null);
INSERT INTO `ai_tts_voice` VALUES ('TTS_EdgeTTS0004', 'TTS_EdgeTTS', 'EdgeTTS男声-云健', 'zh-CN-YunjianNeural', '普通话', null, null, '1', null, null, null, null);
INSERT INTO `ai_tts_voice` VALUES ('TTS_EdgeTTS0005', 'TTS_EdgeTTS', 'EdgeTTS男声-云希', 'zh-CN-YunxiNeural', '普通话', null, null, '1', null, null, null, null);
INSERT INTO `ai_tts_voice` VALUES ('TTS_EdgeTTS0006', 'TTS_EdgeTTS', 'EdgeTTS男声-云夏', 'zh-CN-YunxiaNeural', '普通话', null, null, '1', null, null, null, null);
INSERT INTO `ai_tts_voice` VALUES ('TTS_EdgeTTS0007', 'TTS_EdgeTTS', 'EdgeTTS女声-辽宁小贝', 'zh-CN-liaoning-XiaobeiNeural', '辽宁', null, null, '1', null, null, null, null);
INSERT INTO `ai_tts_voice` VALUES ('TTS_EdgeTTS0008', 'TTS_EdgeTTS', 'EdgeTTS女声-陕西小妮', 'zh-CN-shaanxi-XiaoniNeural', '陕西', null, null, '1', null, null, null, null);
INSERT INTO `ai_tts_voice` VALUES ('TTS_EdgeTTS0009', 'TTS_EdgeTTS', 'EdgeTTS女声-香港海佳', 'zh-HK-HiuGaaiNeural', '粤语', 'General', 'Friendly, Positive', '1', null, null, null, null);
INSERT INTO `ai_tts_voice` VALUES ('TTS_EdgeTTS0010', 'TTS_EdgeTTS', 'EdgeTTS女声-香港海曼', 'zh-HK-HiuMaanNeural', '粤语', 'General', 'Friendly, Positive', '1', null, null, null, null);
INSERT INTO `ai_tts_voice` VALUES ('TTS_EdgeTTS0011', 'TTS_EdgeTTS', 'EdgeTTS男声-香港万龙', 'zh-HK-WanLungNeural', '粤语', 'General', 'Friendly, Positive', '1', null, null, null, null);
INSERT INTO `ai_tts_voice` VALUES ('TTS_FishSpeech0000', 'TTS_FishSpeech', '', '', '中文', '', null, '8', null, null, null, null);
INSERT INTO `ai_tts_voice` VALUES ('TTS_GizwitsTTS0001', 'TTS_GizwitsTTS', '机智云湾湾', 'zh_female_wanwanxiaohe_moon_bigtts', '中文', 'https://example.com/gizwits/wanwanxiaohe.mp3', null, '11', null, null, null, null);
INSERT INTO `ai_tts_voice` VALUES ('TTS_GPT_SOVITS_V20000', 'TTS_GPT_SOVITS_V2', '', '', '中文', '', null, '8', null, null, null, null);
INSERT INTO `ai_tts_voice` VALUES ('TTS_GPT_SOVITS_V30000', 'TTS_GPT_SOVITS_V3', '', '', '中文', '', null, '8', null, null, null, null);
INSERT INTO `ai_tts_voice` VALUES ('TTS_MinimaxTTS0001', 'TTS_MinimaxTTS', 'Minimax少女音', 'female-shaonv', '中文', 'https://example.com/minimax/female-shaonv.mp3', null, '8', null, null, null, null);
INSERT INTO `ai_tts_voice` VALUES ('TTS_OpenAITTS0001', 'TTS_OpenAITTS', 'OpenAI男声', 'onyx', '中文', 'https://example.com/openai/onyx.mp3', null, '13', null, null, null, null);
INSERT INTO `ai_tts_voice` VALUES ('TTS_TTS302AI0001', 'TTS_TTS302AI', '湾湾小何', 'zh_female_wanwanxiaohe_moon_bigtts', '中文', 'https://example.com/302ai/wanwanxiaohe.mp3', null, '10', null, null, null, null);

-- ----------------------------
-- Table structure for ai_voiceprint
-- ----------------------------
DROP TABLE IF EXISTS `ai_voiceprint`;
CREATE TABLE `ai_voiceprint` (
  `id` varchar(32) NOT NULL COMMENT '声纹唯一标识',
  `name` varchar(64) DEFAULT NULL COMMENT '声纹名称',
  `user_id` bigint DEFAULT NULL COMMENT '用户 ID（关联用户表）',
  `agent_id` varchar(32) DEFAULT NULL COMMENT '关联智能体 ID',
  `agent_code` varchar(36) DEFAULT NULL COMMENT '关联智能体编码',
  `agent_name` varchar(36) DEFAULT NULL COMMENT '关联智能体名称',
  `description` varchar(255) DEFAULT NULL COMMENT '声纹描述',
  `embedding` longtext COMMENT '声纹特征向量（JSON 数组格式）',
  `memory` text COMMENT '关联记忆数据',
  `sort` int unsigned DEFAULT '0' COMMENT '排序权重',
  `creator` bigint DEFAULT NULL COMMENT '创建者 ID',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` bigint DEFAULT NULL COMMENT '更新者 ID',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='声纹识别表';

-- ----------------------------
-- Records of ai_voiceprint
-- ----------------------------

-- ----------------------------
-- Table structure for DATABASECHANGELOG
-- ----------------------------
DROP TABLE IF EXISTS `DATABASECHANGELOG`;
CREATE TABLE `DATABASECHANGELOG` (
  `ID` varchar(255) NOT NULL,
  `AUTHOR` varchar(255) NOT NULL,
  `FILENAME` varchar(255) NOT NULL,
  `DATEEXECUTED` datetime NOT NULL,
  `ORDEREXECUTED` int NOT NULL,
  `EXECTYPE` varchar(10) NOT NULL,
  `MD5SUM` varchar(35) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `COMMENTS` varchar(255) DEFAULT NULL,
  `TAG` varchar(255) DEFAULT NULL,
  `LIQUIBASE` varchar(20) DEFAULT NULL,
  `CONTEXTS` varchar(255) DEFAULT NULL,
  `LABELS` varchar(255) DEFAULT NULL,
  `DEPLOYMENT_ID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of DATABASECHANGELOG
-- ----------------------------
INSERT INTO `DATABASECHANGELOG` VALUES ('202503141335', 'John', 'db/changelog/db.changelog-master.yaml', '2025-04-21 15:57:36', '1', 'EXECUTED', '8:b4fbec3e255c2346b7f7e5d9d2a94c92', 'sqlFile path=classpath:db/changelog/202503141335.sql', '', null, '4.20.0', null, null, '5222255724');
INSERT INTO `DATABASECHANGELOG` VALUES ('202503141346', 'czc', 'db/changelog/db.changelog-master.yaml', '2025-04-21 15:57:36', '2', 'EXECUTED', '8:7993b7f1c75bd2756af1743f40d99b28', 'sqlFile path=classpath:db/changelog/202503141346.sql', '', null, '4.20.0', null, null, '5222255724');
INSERT INTO `DATABASECHANGELOG` VALUES ('2025_tts_voive', 'John', 'db/changelog/db.changelog-master.yaml', '2025-04-21 15:57:36', '3', 'EXECUTED', '8:820894f998d6ba7a3f9eeb019b1a2ce8', 'sqlFile path=classpath:db/changelog/2025_tts_voive.sql', '', null, '4.20.0', null, null, '5222255724');
INSERT INTO `DATABASECHANGELOG` VALUES ('202504082211', 'John', 'db/changelog/db.changelog-master.yaml', '2025-04-21 15:57:36', '4', 'EXECUTED', '8:0bcd525affca7bde4c8e09294ac63010', 'sqlFile path=classpath:db/changelog/202504082211.sql', '', null, '4.20.0', null, null, '5222255724');
INSERT INTO `DATABASECHANGELOG` VALUES ('202504092335', 'John', 'db/changelog/db.changelog-master.yaml', '2025-04-21 15:57:36', '5', 'EXECUTED', '8:0f7875c364e8fd37991d5fc205cc57b9', 'sqlFile path=classpath:db/changelog/202504092335.sql', '', null, '4.20.0', null, null, '5222255724');
INSERT INTO `DATABASECHANGELOG` VALUES ('202504112044', 'John', 'db/changelog/db.changelog-master.yaml', '2025-04-21 15:57:37', '6', 'EXECUTED', '8:a5d919e82988097ba3e013874929c70b', 'sqlFile path=classpath:db/changelog/202504112044.sql', '', null, '4.20.0', null, null, '5222255724');
INSERT INTO `DATABASECHANGELOG` VALUES ('202504112058', 'John', 'db/changelog/db.changelog-master.yaml', '2025-04-21 15:57:37', '7', 'EXECUTED', '8:e4ed26efe97fa23b3ae50266f7f381a5', 'sqlFile path=classpath:db/changelog/202504112058.sql', '', null, '4.20.0', null, null, '5222255724');
INSERT INTO `DATABASECHANGELOG` VALUES ('202504151206', 'John', 'db/changelog/db.changelog-master.yaml', '2025-04-21 15:57:37', '8', 'EXECUTED', '8:9b27f8011741fa7c60701453e70c2d54', 'sqlFile path=classpath:db/changelog/202504151206.sql', '', null, '4.20.0', null, null, '5222255724');
INSERT INTO `DATABASECHANGELOG` VALUES ('202504181536', 'John', 'db/changelog/db.changelog-master.yaml', '2025-04-21 15:57:37', '9', 'EXECUTED', '8:6cf9afba7e9e47a57a4d22d29598cca2', 'sqlFile path=classpath:db/changelog/202504181536.sql', '', null, '4.20.0', null, null, '5222255724');

-- ----------------------------
-- Table structure for DATABASECHANGELOGLOCK
-- ----------------------------
DROP TABLE IF EXISTS `DATABASECHANGELOGLOCK`;
CREATE TABLE `DATABASECHANGELOGLOCK` (
  `ID` int NOT NULL,
  `LOCKED` bit(1) NOT NULL,
  `LOCKGRANTED` datetime DEFAULT NULL,
  `LOCKEDBY` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of DATABASECHANGELOGLOCK
-- ----------------------------
INSERT INTO `DATABASECHANGELOGLOCK` VALUES ('1', '\0', null, null);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data` (
  `id` bigint NOT NULL COMMENT 'id',
  `dict_type_id` bigint NOT NULL COMMENT '字典类型ID',
  `dict_label` varchar(255) NOT NULL COMMENT '字典标签',
  `dict_value` varchar(255) DEFAULT NULL COMMENT '字典值',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `sort` int unsigned DEFAULT NULL COMMENT '排序',
  `creator` bigint DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` bigint DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_dict_type_value` (`dict_type_id`,`dict_value`),
  KEY `idx_sort` (`sort`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='字典数据';

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type` (
  `id` bigint NOT NULL COMMENT 'id',
  `dict_type` varchar(100) NOT NULL COMMENT '字典类型',
  `dict_name` varchar(255) NOT NULL COMMENT '字典名称',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `sort` int unsigned DEFAULT NULL COMMENT '排序',
  `creator` bigint DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` bigint DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `dict_type` (`dict_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='字典类型';

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------

-- ----------------------------
-- Table structure for sys_params
-- ----------------------------
DROP TABLE IF EXISTS `sys_params`;
CREATE TABLE `sys_params` (
  `id` bigint NOT NULL COMMENT 'id',
  `param_code` varchar(100) DEFAULT NULL COMMENT '参数编码',
  `param_value` varchar(2000) DEFAULT NULL COMMENT '参数值',
  `value_type` varchar(20) DEFAULT 'string' COMMENT '值类型：string-字符串，number-数字，boolean-布尔，array-数组',
  `param_type` tinyint unsigned DEFAULT '1' COMMENT '类型   0：系统参数   1：非系统参数',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `creator` bigint DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` bigint DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_param_code` (`param_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='参数管理';

-- ----------------------------
-- Records of sys_params
-- ----------------------------
INSERT INTO `sys_params` VALUES ('100', 'server.ip', '0.0.0.0', 'string', '1', '服务器监听IP地址', null, null, null, null);
INSERT INTO `sys_params` VALUES ('101', 'server.port', '8000', 'number', '1', '服务器监听端口', null, null, null, null);
INSERT INTO `sys_params` VALUES ('102', 'server.secret', 'd085a3a4-020c-4a29-b09b-8ba04c9738ff', 'string', '1', '服务器密钥', null, null, null, null);
INSERT INTO `sys_params` VALUES ('103', 'server.allow_user_register', 'false', 'boolean', '1', '是否运行管理员以外的人注册', null, null, null, null);
INSERT INTO `sys_params` VALUES ('104', 'server.fronted_url', 'http://xiaozhi.server.com', 'string', '1', '下发六位验证码时显示的控制面板地址', null, null, null, null);
INSERT INTO `sys_params` VALUES ('105', 'device_max_output_size', '0', 'number', '1', '单台设备每天最多输出字数，0表示不限制', null, null, null, null);
INSERT INTO `sys_params` VALUES ('201', 'log.log_format', '<green>{time:YYMMDD HH:mm:ss}</green>[<light-blue>{version}-{selected_module}</light-blue>][<light-blue>{extra[tag]}</light-blue>]-<level>{level}</level>-<light-green>{message}</light-green>', 'string', '1', '控制台日志格式', null, null, null, null);
INSERT INTO `sys_params` VALUES ('202', 'log.log_format_file', '{time:YYYY-MM-DD HH:mm:ss} - {version}_{selected_module} - {name} - {level} - {extra[tag]} - {message}', 'string', '1', '文件日志格式', null, null, null, null);
INSERT INTO `sys_params` VALUES ('203', 'log.log_level', 'INFO', 'string', '1', '日志级别', null, null, null, null);
INSERT INTO `sys_params` VALUES ('204', 'log.log_dir', 'tmp', 'string', '1', '日志目录', null, null, null, null);
INSERT INTO `sys_params` VALUES ('205', 'log.log_file', 'server.log', 'string', '1', '日志文件名', null, null, null, null);
INSERT INTO `sys_params` VALUES ('206', 'log.data_dir', 'data', 'string', '1', '数据目录', null, null, null, null);
INSERT INTO `sys_params` VALUES ('301', 'delete_audio', 'true', 'boolean', '1', '是否删除使用后的音频文件', null, null, null, null);
INSERT INTO `sys_params` VALUES ('302', 'close_connection_no_voice_time', '120', 'number', '1', '无语音输入断开连接时间(秒)', null, null, null, null);
INSERT INTO `sys_params` VALUES ('303', 'tts_timeout', '10', 'number', '1', 'TTS请求超时时间(秒)', null, null, null, null);
INSERT INTO `sys_params` VALUES ('304', 'enable_wakeup_words_response_cache', 'false', 'boolean', '1', '是否开启唤醒词加速', null, null, null, null);
INSERT INTO `sys_params` VALUES ('305', 'enable_greeting', 'true', 'boolean', '1', '是否开启开场回复', null, null, null, null);
INSERT INTO `sys_params` VALUES ('306', 'enable_stop_tts_notify', 'false', 'boolean', '1', '是否开启结束提示音', null, null, null, null);
INSERT INTO `sys_params` VALUES ('307', 'stop_tts_notify_voice', 'config/assets/tts_notify.mp3', 'string', '1', '结束提示音文件路径', null, null, null, null);
INSERT INTO `sys_params` VALUES ('308', 'exit_commands', '退出;关闭', 'array', '1', '退出命令列表', null, null, null, null);
INSERT INTO `sys_params` VALUES ('309', 'xiaozhi', '{\n  \"type\": \"hello\",\n  \"version\": 1,\n  \"transport\": \"websocket\",\n  \"audio_params\": {\n    \"format\": \"opus\",\n    \"sample_rate\": 16000,\n    \"channels\": 1,\n    \"frame_duration\": 60\n  }\n}', 'json', '1', '小智类型', null, null, null, null);
INSERT INTO `sys_params` VALUES ('310', 'wakeup_words', '你好小智;你好小志;小爱同学;你好小鑫;你好小新;小美同学;小龙小龙;喵喵同学;小滨小滨;小冰小冰', 'array', '1', '唤醒词列表，用于识别唤醒词', null, null, null, null);
INSERT INTO `sys_params` VALUES ('400', 'plugins.get_weather.api_key', 'a861d0d5e7bf4ee1a83d9a9e4f96d4da', 'string', '1', '天气插件API密钥', null, null, null, null);
INSERT INTO `sys_params` VALUES ('401', 'plugins.get_weather.default_location', '广州', 'string', '1', '天气插件默认城市', null, null, null, null);
INSERT INTO `sys_params` VALUES ('410', 'plugins.get_news.default_rss_url', 'https://www.chinanews.com.cn/rss/society.xml', 'string', '1', '新闻插件默认RSS地址', null, null, null, null);
INSERT INTO `sys_params` VALUES ('411', 'plugins.get_news.category_urls', '{\"society\":\"https://www.chinanews.com.cn/rss/society.xml\",\"world\":\"https://www.chinanews.com.cn/rss/world.xml\",\"finance\":\"https://www.chinanews.com.cn/rss/finance.xml\"}', 'json', '1', '新闻插件分类RSS地址', null, null, null, null);
INSERT INTO `sys_params` VALUES ('421', 'plugins.home_assistant.devices', '客厅,玩具灯,switch.cuco_cn_460494544_cp1_on_p_2_1;卧室,台灯,switch.iot_cn_831898993_socn1_on_p_2_1', 'array', '1', 'Home Assistant设备列表', null, null, null, null);
INSERT INTO `sys_params` VALUES ('422', 'plugins.home_assistant.base_url', 'http://homeassistant.local:8123', 'string', '1', 'Home Assistant服务器地址', null, null, null, null);
INSERT INTO `sys_params` VALUES ('423', 'plugins.home_assistant.api_key', '你的home assistant api访问令牌', 'string', '1', 'Home Assistant API密钥', null, null, null, null);
INSERT INTO `sys_params` VALUES ('430', 'plugins.play_music.music_dir', './music', 'string', '1', '音乐文件存放路径', null, null, null, null);
INSERT INTO `sys_params` VALUES ('431', 'plugins.play_music.music_ext', '.mp3;.wav;.p3', 'array', '1', '音乐文件类型', null, null, null, null);
INSERT INTO `sys_params` VALUES ('432', 'plugins.play_music.refresh_time', '300', 'number', '1', '音乐列表刷新间隔(秒)', null, null, null, null);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` bigint NOT NULL COMMENT 'id',
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(100) DEFAULT NULL COMMENT '密码',
  `super_admin` tinyint unsigned DEFAULT NULL COMMENT '超级管理员   0：否   1：是',
  `status` tinyint DEFAULT NULL COMMENT '状态  0：停用   1：正常',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` bigint DEFAULT NULL COMMENT '更新者',
  `creator` bigint DEFAULT NULL COMMENT '创建者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='系统用户';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1914234509001355265', 'yueyefeng', '$2a$10$Is/Fm/.J7T8RuOrohm40Y.PO18a8a6YjIrMuotpUROaERY2kIrcyy', '1', '1', '2025-04-21 16:27:26', null, null, '2025-04-21 16:27:26');

-- ----------------------------
-- Table structure for sys_user_token
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_token`;
CREATE TABLE `sys_user_token` (
  `id` bigint NOT NULL COMMENT 'id',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `token` varchar(100) NOT NULL COMMENT '用户token',
  `expire_date` datetime DEFAULT NULL COMMENT '过期时间',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='系统用户Token';

-- ----------------------------
-- Records of sys_user_token
-- ----------------------------
INSERT INTO `sys_user_token` VALUES ('1914234535056371713', '1914234509001355265', '84e187d48b56b7522940ea7aaa30a883', '2025-04-22 21:18:19', '2025-04-22 09:18:19', '2025-04-21 16:27:33');
