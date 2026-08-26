CREATE DATABASE IF NOT EXISTS ServletCRUDMVC
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE ServletCRUDMVC;

CREATE TABLE IF NOT EXISTS `User` (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    username VARCHAR(100) NOT NULL UNIQUE,
    fullname VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    avatar VARCHAR(255) NULL,
    roleid INT NOT NULL DEFAULT 5,
    phone VARCHAR(30) NULL UNIQUE,
    createdDate DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS Category (
    cate_id INT AUTO_INCREMENT PRIMARY KEY,
    cate_name VARCHAR(255) NOT NULL,
    icons VARCHAR(255) NULL
);

INSERT INTO `User` (email, username, fullname, password, avatar, roleid, phone, createdDate)
SELECT 'admin@example.com', 'admin', 'Administrator', '123456', NULL, 1, '0900000001', CURRENT_DATE
WHERE NOT EXISTS (SELECT 1 FROM `User` WHERE username='admin');

INSERT INTO `User` (email, username, fullname, password, avatar, roleid, phone, createdDate)
SELECT 'manager@example.com', 'manager', 'Manager', '123456', NULL, 2, '0900000002', CURRENT_DATE
WHERE NOT EXISTS (SELECT 1 FROM `User` WHERE username='manager');

INSERT INTO Category(cate_name, icons)
SELECT 'Điện thoại', NULL
WHERE NOT EXISTS (SELECT 1 FROM Category WHERE cate_name='Điện thoại');

INSERT INTO Category(cate_name, icons)
SELECT 'Laptop', NULL
WHERE NOT EXISTS (SELECT 1 FROM Category WHERE cate_name='Laptop');
