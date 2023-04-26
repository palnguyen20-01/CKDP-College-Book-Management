USE [master]
GO
/****** Object:  Database [BookStore]    Script Date: 4/26/2023 1:53:21 PM ******/
CREATE DATABASE [BookStore]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BookStore', FILENAME = N'D:\University\3rd\HK2\LTWD\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\BookStore.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BookStore_log', FILENAME = N'D:\University\3rd\HK2\LTWD\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\BookStore_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [BookStore] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BookStore].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BookStore] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BookStore] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BookStore] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BookStore] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BookStore] SET ARITHABORT OFF 
GO
ALTER DATABASE [BookStore] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BookStore] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BookStore] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BookStore] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BookStore] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BookStore] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BookStore] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BookStore] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BookStore] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BookStore] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BookStore] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BookStore] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BookStore] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BookStore] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BookStore] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BookStore] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BookStore] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BookStore] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BookStore] SET  MULTI_USER 
GO
ALTER DATABASE [BookStore] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BookStore] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BookStore] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BookStore] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BookStore] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BookStore] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [BookStore] SET QUERY_STORE = ON
GO
ALTER DATABASE [BookStore] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [BookStore]
GO
/****** Object:  Table [dbo].[ACCOUNT]    Script Date: 4/26/2023 1:53:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACCOUNT](
	[username] [nvarchar](20) NOT NULL,
	[password] [nvarchar](max) NULL,
	[entropy] [nvarchar](50) NULL,
 CONSTRAINT [PK_ACCOUNT] PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BOOK]    Script Date: 4/26/2023 1:53:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BOOK](
	[id] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[image] [nvarchar](50) NULL,
	[publish] [nvarchar](50) NULL,
	[author] [nvarchar](50) NULL,
	[categoryid] [int] NOT NULL,
	[price] [nvarchar](50) NULL,
	[rawprice] [nvarchar](50) NULL,
 CONSTRAINT [PK_BOOK] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CATEGORY]    Script Date: 4/26/2023 1:53:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CATEGORY](
	[id] [int] NOT NULL,
	[type] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_CATEGORY] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[ACCOUNT] ([username], [password], [entropy]) VALUES (N'20127007', N'AQAAANCMnd8BFdERjHoAwE/Cl+sBAAAAJ4NIA/9zPUKJ+UeNRNGENAAAAAACAAAAAAAQZgAAAAEAACAAAABN1lkvMRY59j1KzjzYP56YAl0+W7e2R9ip9BiQqDQaqQAAAAAOgAAAAAIAACAAAAA7mplKmOFyQ2yvbUin+j7DIGaxfMO7Cf z+AGNMO+uxAAAADH/F+8twcXwJp3XgDe/aOIQAAAAMRd3VDyS3WIXW2B7S4Spruk+NxhUct6OtUHd9U0ojTBczXfS9vHbakDdo+yXyEQqsM1e8n6hKVHGmkg2g3tFSo=', N'keL1qo1fmJhUscEkGHchRvygs4s=')
INSERT [dbo].[ACCOUNT] ([username], [password], [entropy]) VALUES (N'20127045', N'AQAAANCMnd8BFdERjHoAwE/Cl+sBAAAAJ4NIA/9zPUKJ+UeNRNGENAAAAAACAAAAAAAQZgAAAAEAACAAAABcG9M0Yh8PrFMHkwGqpJxXsecpE0p3MM3OtYR3g/0f2QAAAAAOgAAAAAIAACAAAADtGlGRRDhly0m5qcUcx4ORGi/2XwqDE1aUEVFhfOAiwRAAAAA0JhTFG5Uo4iZ85RtLyMnuQAAAACNVfTTTxTf+yXzi+SyEHQgPo0lZoeTHTFWAj0p+6pOF1G+U52Lp2A8wAO5SfZdBs6xJ2QLusNQ7Mmz/Nkmvr10=', N'JKd8B+3HNYfJs7wQJBxnGMIwtnI=')
INSERT [dbo].[ACCOUNT] ([username], [password], [entropy]) VALUES (N'20127131', N'AQAAANCMnd8BFdERjHoAwE/Cl+sBAAAAJ4NIA/9zPUKJ+UeNRNGENAAAAAACAAAAAAAQZgAAAAEAACAAAAAXP5TShesAaWBBVtk4lKgDRnop56Cy8+AWpVYNU+g7hgAAAAAOgAAAAAIAACAAAAARwR9rcBMzb1y9BdF34QMRSyVar1GcdbAfKR68DISWcRAAAADihYcoXixaIdZtMWlqAto9QAAAAE9TJ/fQ/Nx1fciQyIkRM1YSl9dkLKl+/DykKqPcQ8xDz5gVeN0HD1hfws/DXHHAC2rpw5kbjfI+23EkVKZXgGA=', N'IqssiCnXvj8vm5OZo9obky7UNNU=')
INSERT [dbo].[ACCOUNT] ([username], [password], [entropy]) VALUES (N'20127282', N'AQAAANCMnd8BFdERjHoAwE/Cl+sBAAAAJ4NIA/9zPUKJ+UeNRNGENAAAAAACAAAAAAAQZgAAAAEAACAAAAAvCjo7by+6cMtozGboXq6Ko2XfOqYtn0JGChZ71TCPoAAAAAAOgAAAAAIAACAAAAA3Nmys3g1Mha+sWU1WAklPOU9CuzBH/+tlpjWUOeaEPRAAAADsRYAD4bTLXNivYkM4eHNJQAAAAPtnsr/Ht/u1NcCr5LLeBZd3XY/hzKTjEfpyTiAPTOX+Y7IFoezGvunQk5EX3R/6K7eDw7hvrfzlI8W8/Z7ZENE=', N'c6dIZTSsuoU4zqkjvjNsAA4q+Rs=')
GO
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice]) VALUES (1, N'A Court of Mist and Fury', N'Images/1.jpg', N'2023', N'Sarah J. Maas', 1, N'900000', N'720000')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice]) VALUES (2, N'Figaro here, Figaro there', N'Images/1.jpg', N'2022', N'F. M. Stockdale', 1, N'5000000', N'4000000')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice]) VALUES (3, N'Not Really the Prisoner of Zenda', N'Images/1.jpg', N'2022', N'Joel Rosenberg', 1, N'600000', N'480000')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice]) VALUES (4, N'Le roi n''a pas sommeil', N'Images/1.jpg', N'2014', N'Cécile Coulon', 2, N'60000', N'48000')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice]) VALUES (5, N'At the mercy of Tiberius', N'Images/1.jpg', N'2022', N'Augusta J. Evans', 1, N'2000000', N'1600000')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice]) VALUES (6, N'Bealby', N'Images/1.jpg', N'2011', N'H. G. Wells', 3, N'10000000', N'8000000')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice]) VALUES (7, N'The strategy of success', N'Images/1.jpg', N'2017', N'Auren Uris', 4, N'700000', N'560000')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice]) VALUES (8, N'Scotland''s castles and great houses', N'Images/1.jpg', N'2010', N'Magnus Magnusson', 2, N'100000', N'80000')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice]) VALUES (9, N'The greenlander', N'Images/1.jpg', N'2022', N'Mark Adlard', 3, N'70000', N'56000')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice]) VALUES (10, N'The Brown, Boggs Company Limited', N'Images/1.jpg', N'2022', N'Brown Boggs Company', 1, N'3000000', N'2400000')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice]) VALUES (11, N'Determinanten', N'Images/1.jpg', N'2022', N'Paul B. Fischer', 1, N'200000', N'160000')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice]) VALUES (12, N'The greatest of these', N'Images/1.jpg', N'2012', N'Francis MacManus', 2, N'4000000', N'3200000')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice]) VALUES (13, N'What we hear in music', N'Images/1.jpg', N'2020', N'Anne Shaw Faulkner', 3, N'60000', N'48000')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice]) VALUES (14, N'Prophecy', N'Images/1.jpg', N'2023', N'John F. Walvoord', 2, N'200000', N'160000')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice]) VALUES (15, N'Baba Yaga''s Assistant', N'Images/1.jpg', N'2023', N'Marika McCoola', 1, N'20000', N'16000')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice]) VALUES (16, N'Crimson mountain', N'Images/1.jpg', N'2022', N'Grace Livingston Hill', 3, N'80000', N'64000')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice]) VALUES (17, N'Sitting Bull', N'Images/1.jpg', N'2010', N'Jane Fleischer', 3, N'10000', N'8000')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice]) VALUES (18, N'Lập trình Window', N'Images/1.jpg', N'2002', N'Phạm Thi Vương', 5, N'1000000', N'800000')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice]) VALUES (19, N'Lập trình hướng đối tượng', N'Images/1.jpg', N'2010', N'Đinh Bá Tiến', 5, N'100000', N'80000')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice]) VALUES (20, N'Lập trình C++', N'Images/1.jpg', N'2008', N'Lê Trường Thông', 5, N'30000', N'24000')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice]) VALUES (21, N'Kỹ thuật lập trình', N'Images/1.jpg', N'2001', N'Lê Trường Thông', 5, N'200000', N'160000')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice]) VALUES (22, N'Quà tặng cuộc sống', N'Images/1.jpg', N'2012', N'Dr. Bernie S. Siegel', 4, N'60000', N'48000')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice]) VALUES (23, N'Tuổi trẻ đáng giá bao nhiêu', N'Images/1.jpg', N'2020', N'Nguyễn Đắc Nhân', 4, N'1000000', N'800000')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice]) VALUES (24, N'Thực chiến cờ vua', N'Images/1.jpg', N'2020', N'Huỳnh Minh Chiến', 5, N'200000', N'160000')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice]) VALUES (25, N'Đắc nhân tâm', N'Images/1.jpg', N'2019', N'Dale Carnegie', 4, N'70000', N'56000')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice]) VALUES (26, N'Hạt giống tâm hồn', N'Images/1.jpg', N'2017', N'William Wilson', 4, N'40000', N'32000')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice]) VALUES (27, N'Đừng lựa chọn an nhàn khi còn trẻ', N'Images/1.jpg', N'2008', N'Cảnh Thiên', 4, N'6000000', N'4800000')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice]) VALUES (28, N'Hành trình về phương đông', N'Images/1.jpg', N'2010', N'Baird T. Spalding', 1, N'1000000', N'800000')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice]) VALUES (29, N'Dám thất bại', N'Images/1.jpg', N'2021', N'Dám thất bại', 4, N'100000', N'80000')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice]) VALUES (35, N'Cach ket noi database', N'Images/1.jpg', N'2023', N'Tran Duy Quang', 5, N'60000', N'48000')
GO
INSERT [dbo].[CATEGORY] ([id], [type]) VALUES (1, N'Novel')
INSERT [dbo].[CATEGORY] ([id], [type]) VALUES (2, N'Literature')
INSERT [dbo].[CATEGORY] ([id], [type]) VALUES (3, N'Short Story')
INSERT [dbo].[CATEGORY] ([id], [type]) VALUES (4, N'Orientation')
INSERT [dbo].[CATEGORY] ([id], [type]) VALUES (5, N'Academic')
GO
ALTER TABLE [dbo].[BOOK]  WITH CHECK ADD  CONSTRAINT [FK_BOOK_CATEGORY] FOREIGN KEY([categoryid])
REFERENCES [dbo].[CATEGORY] ([id])
GO
ALTER TABLE [dbo].[BOOK] CHECK CONSTRAINT [FK_BOOK_CATEGORY]
GO
USE [master]
GO
ALTER DATABASE [BookStore] SET  READ_WRITE 
GO
