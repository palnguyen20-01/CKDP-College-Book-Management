USE [BookStore]
GO
/****** Object:  Table [dbo].[ACCOUNT]    Script Date: 3/31/2023 12:28:36 PM ******/
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
/****** Object:  Table [dbo].[BOOK]    Script Date: 3/31/2023 12:28:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BOOK](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[image] [nvarchar](max) NULL,
	[author] [nvarchar](50) NULL,
	[publish] [nvarchar](50) NULL,
 CONSTRAINT [PK_book] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO/* password = username */
INSERT [dbo].[ACCOUNT] ([username], [password], [entropy]) VALUES (N'20127007', N'AQAAANCMnd8BFdERjHoAwE/Cl+sBAAAAJ4NIA/9zPUKJ+UeNRNGENAAAAAACAAAAAAAQZgAAAAEAACAAAABN1lkvMRY59j1KzjzYP56YAl0+W7e2R9ip9BiQqDQaqQAAAAAOgAAAAAIAACAAAAA7mplKmOFyQ2yvbUin+j7DIGaxfMO7CfGoz+AGNMO+uxAAAADH/F+8twcXwJp3XgDe/aOIQAAAAMRd3VDyS3WIXW2B7S4Spruk+NxhUct6OtUHd9U0ojTBczXfS9vHbakDdo+yXyEQqsM1e8n6hKVHGmkg2g3tFSo=', N'keL1qo1fmJhUscEkGHchRvygs4s=')
INSERT [dbo].[ACCOUNT] ([username], [password], [entropy]) VALUES (N'20127045', N'AQAAANCMnd8BFdERjHoAwE/Cl+sBAAAAJ4NIA/9zPUKJ+UeNRNGENAAAAAACAAAAAAAQZgAAAAEAACAAAABcG9M0Yh8PrFMHkwGqpJxXsecpE0p3MM3OtYR3g/0f2QAAAAAOgAAAAAIAACAAAADtGlGRRDhly0m5qcUcx4ORGi/2XwqDE1aUEVFhfOAiwRAAAAA0JhTFG5Uo4iZ85RtLyMnuQAAAACNVfTTTxTf+yXzi+SyEHQgPo0lZoeTHTFWAj0p+6pOF1G+U52Lp2A8wAO5SfZdBs6xJ2QLusNQ7Mmz/Nkmvr10=', N'JKd8B+3HNYfJs7wQJBxnGMIwtnI=')
INSERT [dbo].[ACCOUNT] ([username], [password], [entropy]) VALUES (N'20127131', N'AQAAANCMnd8BFdERjHoAwE/Cl+sBAAAAJ4NIA/9zPUKJ+UeNRNGENAAAAAACAAAAAAAQZgAAAAEAACAAAAAXP5TShesAaWBBVtk4lKgDRnop56Cy8+AWpVYNU+g7hgAAAAAOgAAAAAIAACAAAAARwR9rcBMzb1y9BdF34QMRSyVar1GcdbAfKR68DISWcRAAAADihYcoXixaIdZtMWlqAto9QAAAAE9TJ/fQ/Nx1fciQyIkRM1YSl9dkLKl+/DykKqPcQ8xDz5gVeN0HD1hfws/DXHHAC2rpw5kbjfI+23EkVKZXgGA=', N'IqssiCnXvj8vm5OZo9obky7UNNU=')
INSERT [dbo].[ACCOUNT] ([username], [password], [entropy]) VALUES (N'20127282', N'AQAAANCMnd8BFdERjHoAwE/Cl+sBAAAAJ4NIA/9zPUKJ+UeNRNGENAAAAAACAAAAAAAQZgAAAAEAACAAAAAvCjo7by+6cMtozGboXq6Ko2XfOqYtn0JGChZ71TCPoAAAAAAOgAAAAAIAACAAAAA3Nmys3g1Mha+sWU1WAklPOU9CuzBH/+tlpjWUOeaEPRAAAADsRYAD4bTLXNivYkM4eHNJQAAAAPtnsr/Ht/u1NcCr5LLeBZd3XY/hzKTjEfpyTiAPTOX+Y7IFoezGvunQk5EX3R/6K7eDw7hvrfzlI8W8/Z7ZENE=', N'c6dIZTSsuoU4zqkjvjNsAA4q+Rs=')
GO
SET IDENTITY_INSERT [dbo].[BOOK] ON 

INSERT [dbo].[BOOK] ([id], [name], [image], [author], [publish]) VALUES (1, N'A Court of Mist and Fury', N'Images/1.jpg', N'Sarah J. Maas', N'2023')
INSERT [dbo].[BOOK] ([id], [name], [image], [author], [publish]) VALUES (2, N'Figaro here, Figaro there', N'Images/1.jpg', N'F. M. Stockdale', N'December 7, 2022')
INSERT [dbo].[BOOK] ([id], [name], [image], [author], [publish]) VALUES (3, N'Not Really the Prisoner of Zenda', N'Images/1.jpg', N'Joel Rosenberg', N'April 5, 2014')
INSERT [dbo].[BOOK] ([id], [name], [image], [author], [publish]) VALUES (4, N'Le roi n''a pas sommeil', N'Images/1.jpg', N'Cécile Coulon', N'December 12, 2022')
INSERT [dbo].[BOOK] ([id], [name], [image], [author], [publish]) VALUES (5, N'At the mercy of Tiberius', N'Images/1.jpg', N'Augusta J. Evans', N'October 7, 2017')
INSERT [dbo].[BOOK] ([id], [name], [image], [author], [publish]) VALUES (6, N'Bealby', N'Images/1.jpg', N'H. G. Wells', N'August 18, 2010')
INSERT [dbo].[BOOK] ([id], [name], [image], [author], [publish]) VALUES (7, N'The strategy of success', N'Images/1.jpg', N'Auren Uris', N'November 16, 2022')
INSERT [dbo].[BOOK] ([id], [name], [image], [author], [publish]) VALUES (8, N'Scotland''s castles and great houses', N'Images/1.jpg', N'Magnus Magnusson', N'December 9, 2022')
INSERT [dbo].[BOOK] ([id], [name], [image], [author], [publish]) VALUES (9, N'The greenlander', N'Images/1.jpg', N'Mark Adlard', N'December 18, 2022')
INSERT [dbo].[BOOK] ([id], [name], [image], [author], [publish]) VALUES (10, N'The Brown, Boggs Company Limited', N'Images/1.jpg', N'Brown Boggs Company', N'August 2, 2012')
INSERT [dbo].[BOOK] ([id], [name], [image], [author], [publish]) VALUES (11, N'Determinanten', N'Images/1.jpg', N'Paul B. Fischer', N'September 11, 2020')
INSERT [dbo].[BOOK] ([id], [name], [image], [author], [publish]) VALUES (12, N'The greatest of these', N'Images/1.jpg', N'Francis MacManus', N'January 15, 2023')
INSERT [dbo].[BOOK] ([id], [name], [image], [author], [publish]) VALUES (13, N'What we hear in music', N'Images/1.jpg', N'Anne Shaw Faulkner', N'March 4, 2020')
INSERT [dbo].[BOOK] ([id], [name], [image], [author], [publish]) VALUES (14, N'Prophecy', N'Images/1.jpg', N'John F. Walvoord', N'September 17, 2022')
INSERT [dbo].[BOOK] ([id], [name], [image], [author], [publish]) VALUES (15, N'Baba Yaga''s Assistant', N'Images/1.jpg', N'Marika McCoola', N'January 14, 2023')
INSERT [dbo].[BOOK] ([id], [name], [image], [author], [publish]) VALUES (16, N'Crimson mountain', N'Images/1.jpg', N'Grace Livingston Hill', N'August 22, 2022')
INSERT [dbo].[BOOK] ([id], [name], [image], [author], [publish]) VALUES (17, N'Sitting Bull', N'Images/1.jpg', N'Jane Fleischer', N'February 11, 2023')
INSERT [dbo].[BOOK] ([id], [name], [image], [author], [publish]) VALUES (18, N'Lập trình Window', N'Images/1.jpg', N'Phạm Thi Vương', N'2002')
INSERT [dbo].[BOOK] ([id], [name], [image], [author], [publish]) VALUES (19, N'Lập trình hướng đối tượng', N'Images/1.jpg', N'Đinh Bá Tiến', N'2010')
INSERT [dbo].[BOOK] ([id], [name], [image], [author], [publish]) VALUES (20, N'Lập trình C++', N'Images/1.jpg', N'Lê Trường Thông', N'2008')
INSERT [dbo].[BOOK] ([id], [name], [image], [author], [publish]) VALUES (21, N'Kỹ thuật lập trình', N'Images/1.jpg', N'Lê Trường Thông', N'2001')
INSERT [dbo].[BOOK] ([id], [name], [image], [author], [publish]) VALUES (22, N'Quà tặng cuộc sống', N'Images/1.jpg', N'Dr. Bernie S. Siegel', N'2012 ')
INSERT [dbo].[BOOK] ([id], [name], [image], [author], [publish]) VALUES (23, N'Tuổi trẻ đáng giá bao nhiêu', N'Images/1.jpg', N'Nguyễn Đắc Nhân', N'2020')
INSERT [dbo].[BOOK] ([id], [name], [image], [author], [publish]) VALUES (24, N'Thực chiến cờ vua', N'Images/1.jpg', N'Huỳnh Minh Chiến', N'2020')
INSERT [dbo].[BOOK] ([id], [name], [image], [author], [publish]) VALUES (25, N'Đắc nhân tâm', N'Images/1.jpg', N'Dale Carnegie', N'2019')
INSERT [dbo].[BOOK] ([id], [name], [image], [author], [publish]) VALUES (26, N'Hạt giống tâm hồn', N'Images/1.jpg', N'William Wilson', N'2017')
INSERT [dbo].[BOOK] ([id], [name], [image], [author], [publish]) VALUES (27, N'Đừng lựa chọn an nhàn khi còn trẻ', N'Images/1.jpg', N'Cảnh Thiên', N'2008')
INSERT [dbo].[BOOK] ([id], [name], [image], [author], [publish]) VALUES (28, N'Hành trình về phương đông', N'Images/1.jpg', N'Baird T. Spalding', N'2010')
INSERT [dbo].[BOOK] ([id], [name], [image], [author], [publish]) VALUES (29, N'Dám thất bại', N'Images/1.jpg', N'Dám thất bại', N'2021')
INSERT [dbo].[BOOK] ([id], [name], [image], [author], [publish]) VALUES (35, N'Cach ket noi database', N'Images/Shopee_24.png', N'Tran Duy Quang', N'2023')
SET IDENTITY_INSERT [dbo].[BOOK] OFF
GO
