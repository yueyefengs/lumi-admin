-- 使用数据库
USE `xiaozhi`;

-- 插入默认管理员账户
-- 密码是: admin123 的 bcrypt 哈希
INSERT INTO `users` (`username`, `password`, `email`, `role`, `status`, `created_at`, `updated_at`)
VALUES 
('admin', '$2a$10$x5J/L8kxHMdw/0FWTwZSXO2GcPK9VfkH3CYSgUsYeP.sNxZBi0WNG', 'admin@xiaozhi.com', 'admin', 1, NOW(), NOW())
ON DUPLICATE KEY UPDATE `updated_at` = NOW();

-- 插入基本系统配置
INSERT INTO `configs` (`name`, `value`, `type`, `desc`, `created_at`, `updated_at`)
VALUES 
('site_name', '小智管理系统', 'string', '站点名称', NOW(), NOW()),
('server_url', 'ws://localhost:8000/xiaozhi/v1/', 'string', 'WebSocket服务地址', NOW(), NOW()),
('ota_version_url', 'http://localhost:8002/xiaozhi/api/ota', 'string', 'OTA更新地址', NOW(), NOW()),
('websocket_url', 'ws://localhost:8000/xiaozhi/v1/', 'string', 'WebSocket通信地址', NOW(), NOW())
ON DUPLICATE KEY UPDATE `updated_at` = NOW();

-- 如果有原始数据，可以在此处导入
-- 例如，导入已知设备
-- INSERT INTO `devices` ...

-- 如果有原始固件数据，可以在此处导入
-- INSERT INTO `firmwares` ... 