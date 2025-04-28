-- 创建数据库（如果不存在）
CREATE DATABASE IF NOT EXISTS lumi_admin DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 使用数据库
USE lumi_admin;

-- 用户表
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(191) NOT NULL,
  `password` varchar(191) NOT NULL,
  `email` varchar(191) DEFAULT NULL,
  `role` varchar(191) NOT NULL DEFAULT 'user',
  `status` int NOT NULL DEFAULT '1',
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_username_key` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 配置表
CREATE TABLE IF NOT EXISTS `configs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `value` text NOT NULL,
  `type` varchar(191) NOT NULL DEFAULT 'string',
  `desc` varchar(191) DEFAULT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `configs_name_key` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 设备表
CREATE TABLE IF NOT EXISTS `devices` (
  `id` int NOT NULL AUTO_INCREMENT,
  `device_id` varchar(191) NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1',
  `version` varchar(191) DEFAULT NULL,
  `last_online` datetime(3) DEFAULT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  `agent_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `devices_device_id_key` (`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 固件表
CREATE TABLE IF NOT EXISTS `firmwares` (
  `id` int NOT NULL AUTO_INCREMENT,
  `version` varchar(191) NOT NULL,
  `url` varchar(191) NOT NULL,
  `notes` text,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `firmwares_version_key` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 操作日志表
CREATE TABLE IF NOT EXISTS `operation_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `operation` varchar(191) NOT NULL,
  `ip` varchar(191) DEFAULT NULL,
  `detail` text,
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 模型表
CREATE TABLE IF NOT EXISTS `models` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `type` varchar(191) NOT NULL,
  `provider` varchar(191) NOT NULL,
  `api_key` varchar(191) DEFAULT NULL,
  `endpoint` varchar(191) DEFAULT NULL,
  `parameters` text,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 音色表
CREATE TABLE IF NOT EXISTS `voices` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `code` varchar(191) NOT NULL,
  `gender` varchar(191) DEFAULT NULL,
  `model_id` int NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `voices_model_id_fkey` (`model_id`),
  CONSTRAINT `voices_model_id_fkey` FOREIGN KEY (`model_id`) REFERENCES `models` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 角色表
CREATE TABLE IF NOT EXISTS `agents` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `avatar` varchar(191) DEFAULT NULL,
  `description` text,
  `system_prompt` text,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 角色模型关联表
CREATE TABLE IF NOT EXISTS `agent_models` (
  `id` int NOT NULL AUTO_INCREMENT,
  `agent_id` int NOT NULL,
  `model_id` int NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `agent_models_agent_id_model_id_key` (`agent_id`,`model_id`),
  KEY `agent_models_model_id_fkey` (`model_id`),
  CONSTRAINT `agent_models_agent_id_fkey` FOREIGN KEY (`agent_id`) REFERENCES `agents` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `agent_models_model_id_fkey` FOREIGN KEY (`model_id`) REFERENCES `models` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 角色模板表
CREATE TABLE IF NOT EXISTS `agent_templates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `description` text,
  `template` text NOT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 添加外键关系
ALTER TABLE `devices` ADD CONSTRAINT `devices_agent_id_fkey` FOREIGN KEY (`agent_id`) REFERENCES `agents` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- 插入默认管理员账户（密码：admin123）
INSERT INTO `users` (`username`, `password`, `email`, `role`, `status`, `created_at`, `updated_at`)
VALUES
('admin', '$2a$10$XLGQtpUUXS/Fn09Xg/MpAuLCEKpcr7gkWN3jO5VxZNZCDzL5M3xui', 'admin@xiaozhi.com', 'admin', 1, NOW(), NOW())
ON DUPLICATE KEY UPDATE `updated_at` = NOW();

-- 插入默认配置
INSERT INTO `configs` (`name`, `value`, `type`, `desc`, `created_at`, `updated_at`)
VALUES 
('site_name', '小智管理系统', 'string', '站点名称', NOW(), NOW()),
('server_url', 'ws://localhost:8000/xiaozhi/v1/', 'string', 'WebSocket服务地址', NOW(), NOW()),
('server_secret', 'xiaozhi-server-secret', 'string', '服务器密钥', NOW(), NOW()),
('enable_log', 'true', 'boolean', '是否启用操作日志记录', NOW(), NOW()),
('default_llm', '1', 'number', '默认大语言模型ID', NOW(), NOW()),
('default_tts', '2', 'number', '默认TTS模型ID', NOW(), NOW()),
('default_asr', '3', 'number', '默认ASR模型ID', NOW(), NOW())
ON DUPLICATE KEY UPDATE `updated_at` = NOW(); 