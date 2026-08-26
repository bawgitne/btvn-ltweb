IF DB_ID('ServletCRUDMVC') IS NULL
BEGIN
    CREATE DATABASE ServletCRUDMVC;
END
GO
USE ServletCRUDMVC;
GO

IF OBJECT_ID(N'[dbo].[User]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[User](
        [id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        [email] NVARCHAR(255) NOT NULL UNIQUE,
        [username] NVARCHAR(100) NOT NULL UNIQUE,
        [fullname] NVARCHAR(255) NOT NULL,
        [password] NVARCHAR(255) NOT NULL,
        [avatar] NVARCHAR(255) NULL,
        [roleid] INT NOT NULL DEFAULT 5,
        [phone] NVARCHAR(30) NULL UNIQUE,
        [createdDate] DATE NOT NULL
    );
END
GO

IF OBJECT_ID(N'[dbo].[Category]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Category](
        [cate_id] INT IDENTITY(1,1) NOT NULL,
        [cate_name] NVARCHAR(255) NOT NULL,
        [icons] NVARCHAR(255) NULL,
        CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED ([cate_id] ASC)
    );
END
GO

IF NOT EXISTS (SELECT 1 FROM [dbo].[User] WHERE username = 'admin')
INSERT INTO [dbo].[User](email, username, fullname, password, avatar, roleid, phone, createdDate)
VALUES ('admin@example.com', 'admin', N'Administrator', '123456', NULL, 1, '0900000001', CAST(GETDATE() AS date));
GO

IF NOT EXISTS (SELECT 1 FROM [dbo].[User] WHERE username = 'manager')
INSERT INTO [dbo].[User](email, username, fullname, password, avatar, roleid, phone, createdDate)
VALUES ('manager@example.com', 'manager', N'Manager', '123456', NULL, 2, '0900000002', CAST(GETDATE() AS date));
GO

IF NOT EXISTS (SELECT 1 FROM Category WHERE cate_name=N'Điện thoại')
INSERT INTO Category(cate_name, icons) VALUES (N'Điện thoại', NULL);
IF NOT EXISTS (SELECT 1 FROM Category WHERE cate_name=N'Laptop')
INSERT INTO Category(cate_name, icons) VALUES (N'Laptop', NULL);
GO
