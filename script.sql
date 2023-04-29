USE [master]
GO
/****** Object:  Database [BookStore]    Script Date: 4/29/2023 9:52:10 AM ******/
CREATE DATABASE [BookStore]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BookStore', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.CHIEN\MSSQL\DATA\BookStore.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BookStore_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.CHIEN\MSSQL\DATA\BookStore_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [BookStore] SET COMPATIBILITY_LEVEL = 150
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
ALTER DATABASE [BookStore] SET RECOVERY FULL 
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
EXEC sys.sp_db_vardecimal_storage_format N'BookStore', N'ON'
GO
ALTER DATABASE [BookStore] SET QUERY_STORE = OFF
GO
USE [BookStore]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 4/29/2023 9:52:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[username] [nvarchar](20) NOT NULL,
	[password] [nvarchar](max) NOT NULL,
	[entropy] [nvarchar](50) NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Account_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BOOK]    Script Date: 4/29/2023 9:52:10 AM ******/
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
	[quantity] [nvarchar](50) NULL,
 CONSTRAINT [PK_BOOK] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CATEGORY]    Script Date: 4/29/2023 9:52:10 AM ******/
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
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 4/29/2023 9:52:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[orderId] [int] NOT NULL,
	[bookId] [int] NOT NULL,
	[quantity] [int] NULL,
	[price] [int] NULL,
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[orderId] ASC,
	[bookId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 4/29/2023 9:52:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[id] [int] NOT NULL,
	[date] [date] NULL,
	[totalPrice] [int] NULL,
	[username] [nvarchar](50) NULL,
	[status] [int] NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Status]    Script Date: 4/29/2023 9:52:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Status](
	[id] [int] NOT NULL,
	[statusName] [nchar](50) NULL,
 CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Account] ON 

INSERT [dbo].[Account] ([username], [password], [entropy], [id]) VALUES (N'20127007', N'AQAAANCMnd8BFdERjHoAwE/Cl+sBAAAAJ4NIA/9zPUKJ+UeNRNGENAAAAAACAAAAAAAQZgAAAAEAACAAAABN1lkvMRY59j1KzjzYP56YAl0+W7e2R9ip9BiQqDQaqQAAAAAOgAAAAAIAACAAAAA7mplKmOFyQ2yvbUin+j7DIGaxfMO7CfGoz+AGNMO+uxAAAADH/F+8twcXwJp3XgDe/aOIQAAAAMRd3VDyS3WIXW2B7S4Spruk+NxhUct6OtUHd9U0ojTBczXfS9vHbakDdo+yXyEQqsM1e8n6hKVHGmkg2g3tFSo=', N'keL1qo1fmJhUscEkGHchRvygs4s=', 1)
INSERT [dbo].[Account] ([username], [password], [entropy], [id]) VALUES (N'20127045', N'AQAAANCMnd8BFdERjHoAwE/Cl+sBAAAAJ4NIA/9zPUKJ+UeNRNGENAAAAAACAAAAAAAQZgAAAAEAACAAAABcG9M0Yh8PrFMHkwGqpJxXsecpE0p3MM3OtYR3g/0f2QAAAAAOgAAAAAIAACAAAADtGlGRRDhly0m5qcUcx4ORGi/2XwqDE1aUEVFhfOAiwRAAAAA0JhTFG5Uo4iZ85RtLyMnuQAAAACNVfTTTxTf+yXzi+SyEHQgPo0lZoeTHTFWAj0p+6pOF1G+U52Lp2A8wAO5SfZdBs6xJ2QLusNQ7Mmz/Nkmvr10=', N'JKd8B+3HNYfJs7wQJBxnGMIwtnI=', 2)
INSERT [dbo].[Account] ([username], [password], [entropy], [id]) VALUES (N'20127131', N'AQAAANCMnd8BFdERjHoAwE/Cl+sBAAAAJ4NIA/9zPUKJ+UeNRNGENAAAAAACAAAAAAAQZgAAAAEAACAAAAAXP5TShesAaWBBVtk4lKgDRnop56Cy8+AWpVYNU+g7hgAAAAAOgAAAAAIAACAAAAARwR9rcBMzb1y9BdF34QMRSyVar1GcdbAfKR68DISWcRAAAADihYcoXixaIdZtMWlqAto9QAAAAE9TJ/fQ/Nx1fciQyIkRM1YSl9dkLKl+/DykKqPcQ8xDz5gVeN0HD1hfws/DXHHAC2rpw5kbjfI+23EkVKZXgGA=', N'IqssiCnXvj8vm5OZo9obky7UNNU=', 3)
INSERT [dbo].[Account] ([username], [password], [entropy], [id]) VALUES (N'20127282', N'AQAAANCMnd8BFdERjHoAwE/Cl+sBAAAAJ4NIA/9zPUKJ+UeNRNGENAAAAAACAAAAAAAQZgAAAAEAACAAAAAvCjo7by+6cMtozGboXq6Ko2XfOqYtn0JGChZ71TCPoAAAAAAOgAAAAAIAACAAAAA3Nmys3g1Mha+sWU1WAklPOU9CuzBH/+tlpjWUOeaEPRAAAADsRYAD4bTLXNivYkM4eHNJQAAAAPtnsr/Ht/u1NcCr5LLeBZd3XY/hzKTjEfpyTiAPTOX+Y7IFoezGvunQk5EX3R/6K7eDw7hvrfzlI8W8/Z7ZENE=', N'c6dIZTSsuoU4zqkjvjNsAA4q+Rs=', 4)
INSERT [dbo].[Account] ([username], [password], [entropy], [id]) VALUES (N'admin1', N'AQAAANCMnd8BFdERjHoAwE/Cl+sBAAAABbahkCNfOEOwawZ5Of7f9QAAAAACAAAAAAAQZgAAAAEAACAAAACQqYjwMxrMsiMNVAXnQofDt6AsJWqNr2ZprvVgH9PXXQAAAAAOgAAAAAIAACAAAABc+PzTHcQWqil5gB2D1yZ48hG15GoAlnxXcqVv8jPq1BAAAAB8OTXc2ce7ZdyPUw3vmWZWQAAAABU7uSSlHpOkYWPdpx09OKrti56Pu/eo93IUyHG8ASu/3ARQRj2Q4hXeYlYiZtZtT5BpaXH2IUB+2uA3DhB4kXI=', N'1hk/AlY2fYQZCe9hniqw4C3I1u4=', 5)
SET IDENTITY_INSERT [dbo].[Account] OFF
GO
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice], [quantity]) VALUES (1, N'A Court of Mist and Fury', N'Images/1.jpg', N'2023', N'Sarah J. Maas', 1, N'900000', N'720000', N'5')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice], [quantity]) VALUES (2, N'Figaro here, Figaro there', N'Images/2.jpg', N'2022', N'F. M. Stockdale', 1, N'5000000', N'4000000', N'8')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice], [quantity]) VALUES (3, N'Not Really the Prisoner of Zenda', N'Images/3.jpg', N'2022', N'Joel Rosenberg', 1, N'600000', N'480000', N'9')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice], [quantity]) VALUES (4, N'Le roi n''a pas sommeil', N'Images/4.jpg', N'2014', N'Cécile Coulon', 2, N'60000', N'48000', N'4')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice], [quantity]) VALUES (5, N'At the mercy of Tiberius', N'Images/5.jpg', N'2022', N'Augusta J. Evans', 1, N'2000000', N'1600000', N'12')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice], [quantity]) VALUES (6, N'Bealby', N'Images/6.jpg', N'2011', N'H. G. Wells', 3, N'10000000', N'8000000', N'13')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice], [quantity]) VALUES (7, N'The strategy of success', N'Images/7.jpg', N'2017', N'Auren Uris', 4, N'700000', N'560000', N'10')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice], [quantity]) VALUES (8, N'Scotland''s castles and great houses', N'Images/8.jpg', N'2010', N'Magnus Magnusson', 2, N'100000', N'80000', N'7')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice], [quantity]) VALUES (9, N'The greenlander', N'Images/9.jpg', N'2022', N'Mark Adlard', 3, N'70000', N'56000', N'9')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice], [quantity]) VALUES (10, N'The Brown, Boggs Company Limited', N'Images/10.jpg', N'2022', N'Brown Boggs Company', 1, N'3000000', N'2400000', N'2')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice], [quantity]) VALUES (11, N'Determinanten', N'Images/11.jpg', N'2022', N'Paul B. Fischer', 1, N'200000', N'160000', N'4')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice], [quantity]) VALUES (12, N'The greatest of these', N'Images/12.jpg', N'2012', N'Francis MacManus', 2, N'4000000', N'3200000', N'1')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice], [quantity]) VALUES (13, N'What we hear in music', N'Images/13.jpg', N'2020', N'Anne Shaw Faulkner', 3, N'60000', N'48000', N'8')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice], [quantity]) VALUES (14, N'Prophecy', N'Images/14.jpg', N'2023', N'John F. Walvoord', 2, N'200000', N'160000', N'6')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice], [quantity]) VALUES (15, N'Baba Yaga''s Assistant', N'Images/15.jpg', N'2023', N'Marika McCoola', 1, N'20000', N'16000', N'3')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice], [quantity]) VALUES (16, N'Crimson mountain', N'Images/16.jpg', N'2022', N'Grace Livingston Hill', 3, N'80000', N'64000', N'3')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice], [quantity]) VALUES (17, N'Sitting Bull', N'Images/17.jpg', N'2010', N'Jane Fleischer', 3, N'10000', N'8000', N'7')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice], [quantity]) VALUES (18, N'Lập trình Window', N'Images/18.jpg', N'2002', N'Phạm Thi Vương', 5, N'1000000', N'800000', N'15')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice], [quantity]) VALUES (19, N'Lập trình hướng đối tượng', N'Images/19.jpg', N'2010', N'Đinh Bá Tiến', 5, N'100000', N'80000', N'11')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice], [quantity]) VALUES (20, N'Lập trình C++', N'Images/20.jpg', N'2008', N'Lê Trường Thông', 5, N'30000', N'24000', N'5')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice], [quantity]) VALUES (21, N'Kỹ thuật lập trình', N'Images/21.jpg', N'2001', N'Lê Trường Thông', 5, N'200000', N'160000', N'4')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice], [quantity]) VALUES (22, N'Quà tặng cuộc sống', N'Images/22.jpg', N'2012', N'Dr. Bernie S. Siegel', 4, N'60000', N'48000', N'3')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice], [quantity]) VALUES (23, N'Tuổi trẻ đáng giá bao nhiêu', N'Images/23.jpg', N'2020', N'Nguyễn Đắc Nhân', 4, N'1000000', N'800000', N'8')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice], [quantity]) VALUES (24, N'Thực chiến cờ vua', N'Images/24.jpg', N'2020', N'Huỳnh Minh Chiến', 5, N'200000', N'160000', N'9')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice], [quantity]) VALUES (25, N'Đắc nhân tâm', N'Images/25.jpg', N'2019', N'Dale Carnegie', 4, N'70000', N'56000', N'7')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice], [quantity]) VALUES (26, N'Hạt giống tâm hồn', N'Images/26.jpg', N'2017', N'William Wilson', 4, N'40000', N'32000', N'4')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice], [quantity]) VALUES (27, N'Đừng lựa chọn an nhàn khi còn trẻ', N'Images/27.jpg', N'2008', N'Cảnh Thiên', 4, N'6000000', N'4800000', N'3')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice], [quantity]) VALUES (28, N'Hành trình về phương đông', N'Images/28.jpg', N'2010', N'Baird T. Spalding', 1, N'1000000', N'800000', N'2')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice], [quantity]) VALUES (29, N'Dám thất bại', N'Images/29.jpg', N'2021', N'Billi P.S. Lim', 4, N'100000', N'80000', N'1')
INSERT [dbo].[BOOK] ([id], [name], [image], [publish], [author], [categoryid], [price], [rawprice], [quantity]) VALUES (35, N'Nhà giả kim', N'Images/30.jpg', N'1988', N'Paulo Coelho', 5, N'60000', N'48000', N'1')
GO
INSERT [dbo].[CATEGORY] ([id], [type]) VALUES (1, N'Novel')
INSERT [dbo].[CATEGORY] ([id], [type]) VALUES (2, N'Literature')
INSERT [dbo].[CATEGORY] ([id], [type]) VALUES (3, N'Short Story')
INSERT [dbo].[CATEGORY] ([id], [type]) VALUES (4, N'Orientation')
INSERT [dbo].[CATEGORY] ([id], [type]) VALUES (5, N'Academic')
GO
INSERT [dbo].[OrderDetail] ([orderId], [bookId], [quantity], [price]) VALUES (3, 1, 1, 900000)
INSERT [dbo].[OrderDetail] ([orderId], [bookId], [quantity], [price]) VALUES (3, 2, 1, 5000000)
INSERT [dbo].[OrderDetail] ([orderId], [bookId], [quantity], [price]) VALUES (3, 3, 1, 600000)
INSERT [dbo].[OrderDetail] ([orderId], [bookId], [quantity], [price]) VALUES (5, 1, 1, 900000)
INSERT [dbo].[OrderDetail] ([orderId], [bookId], [quantity], [price]) VALUES (6, 1, 1, 900000)
INSERT [dbo].[OrderDetail] ([orderId], [bookId], [quantity], [price]) VALUES (6, 2, 1, 5000000)
INSERT [dbo].[OrderDetail] ([orderId], [bookId], [quantity], [price]) VALUES (7, 1, 1, 900000)
INSERT [dbo].[OrderDetail] ([orderId], [bookId], [quantity], [price]) VALUES (8, 19, 1, 100000)
GO
INSERT [dbo].[Orders] ([id], [date], [totalPrice], [username], [status]) VALUES (3, CAST(N'2023-04-27' AS Date), 6500000, N'PonPon', 1)
INSERT [dbo].[Orders] ([id], [date], [totalPrice], [username], [status]) VALUES (5, CAST(N'2023-04-10' AS Date), 900000, N'Nguyen Pal', 1)
INSERT [dbo].[Orders] ([id], [date], [totalPrice], [username], [status]) VALUES (6, CAST(N'2023-05-03' AS Date), 5900000, N'Pal', 2)
INSERT [dbo].[Orders] ([id], [date], [totalPrice], [username], [status]) VALUES (7, CAST(N'2023-05-02' AS Date), 900000, N'Tesst', 3)
INSERT [dbo].[Orders] ([id], [date], [totalPrice], [username], [status]) VALUES (8, CAST(N'2023-04-26' AS Date), 100000, N'Dinh Ba Tien', 4)
INSERT [dbo].[Orders] ([id], [date], [totalPrice], [username], [status]) VALUES (9, CAST(N'2023-04-30' AS Date), 150000, N'Truong Hoang ', 1)
GO
INSERT [dbo].[Status] ([id], [statusName]) VALUES (1, N'All                                               ')
INSERT [dbo].[Status] ([id], [statusName]) VALUES (2, N'New                                               ')
INSERT [dbo].[Status] ([id], [statusName]) VALUES (3, N'Completed                                         ')
INSERT [dbo].[Status] ([id], [statusName]) VALUES (4, N'Cancelled                                         ')
INSERT [dbo].[Status] ([id], [statusName]) VALUES (5, N'Shipping                                          ')
GO
ALTER TABLE [dbo].[BOOK]  WITH CHECK ADD  CONSTRAINT [FK_BOOK_CATEGORY] FOREIGN KEY([categoryid])
REFERENCES [dbo].[CATEGORY] ([id])
GO
ALTER TABLE [dbo].[BOOK] CHECK CONSTRAINT [FK_BOOK_CATEGORY]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_BOOK] FOREIGN KEY([bookId])
REFERENCES [dbo].[BOOK] ([id])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_BOOK]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Orders] FOREIGN KEY([orderId])
REFERENCES [dbo].[Orders] ([id])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Orders]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Status] FOREIGN KEY([status])
REFERENCES [dbo].[Status] ([id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Status]
GO
USE [master]
GO
ALTER DATABASE [BookStore] SET  READ_WRITE 
GO
