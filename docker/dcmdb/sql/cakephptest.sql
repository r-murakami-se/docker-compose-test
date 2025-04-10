CREATE DATABASE IF NOT EXISTS cakephptest CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE cakephptest;

CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  email VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO users (name, email) VALUES
('テスト太郎', 'test@example.com');
