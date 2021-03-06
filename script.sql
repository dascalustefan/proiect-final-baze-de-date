USE [garajauto]
GO
/****** Object:  Table [dbo].[proprietar]    Script Date: 1/12/2018 1:59:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[proprietar](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nume] [nchar](80) NOT NULL,
	[prenume] [nchar](80) NOT NULL,
	[telefon] [nchar](30) NOT NULL,
	[nrcard] [nchar](20) NULL,
 CONSTRAINT [PK_proprietar] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[masina]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[masina](
	[vin] [varchar](50) NOT NULL,
	[culoare] [nchar](30) NULL,
	[fk_tip] [int] NOT NULL,
	[fk_brand] [int] NOT NULL,
	[fk_proprietar] [int] NOT NULL,
 CONSTRAINT [PK_masina] PRIMARY KEY CLUSTERED 
(
	[vin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[fabricant]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[fabricant](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nume] [nchar](20) NOT NULL,
	[nr_telefon] [nchar](10) NULL,
 CONSTRAINT [PK_fabricant] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tip]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tip](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nume] [nchar](30) NOT NULL,
 CONSTRAINT [PK_tip] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[mecanic_view]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select * from mecanic
CREATE VIEW [dbo].[mecanic_view] AS
SELECT masina.vin,tip.nume as 'tip',masina.culoare,fabricant.nume as 'brand',proprietar.nume,proprietar.telefon
FROM masina inner join proprietar on fk_proprietar=proprietar.id
inner join tip on fk_tip=tip.id
inner join fabricant on fk_brand=fabricant.id

GO
/****** Object:  Table [dbo].[reparatie]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[reparatie](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fk_masina] [varchar](50) NOT NULL,
	[descriere] [nchar](80) NULL,
 CONSTRAINT [PK_reparatie] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[mecanic_nereparate]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[mecanic_nereparate] AS
SELECT masina.vin,tip.nume as 'tip',masina.culoare,fabricant.nume as 'brand',proprietar.nume,proprietar.telefon
FROM masina inner join proprietar on fk_proprietar=proprietar.id
inner join tip on fk_tip=tip.id
inner join fabricant on fk_brand=fabricant.id
where vin not in (select fk_masina from reparatie)
GO
/****** Object:  Table [dbo].[brevet_dispozitiv]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[brevet_dispozitiv](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fk_mecanic] [int] NOT NULL,
	[tipbrevet] [int] NOT NULL,
 CONSTRAINT [PK_brevet_dispozitiv] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[director_tehnic]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[director_tehnic](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nume] [nchar](130) NOT NULL,
	[prenume] [nchar](130) NOT NULL,
	[salariu] [int] NOT NULL,
	[data_angajarii] [date] NOT NULL,
	[password] [nchar](40) NULL,
 CONSTRAINT [PK_director_tehnic] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dispozitiv]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dispozitiv](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[brevet_necesar] [int] NULL,
	[nume] [nchar](50) NOT NULL,
 CONSTRAINT [PK_dispozitiv] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mecanic]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mecanic](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nume] [nchar](30) NOT NULL,
	[prenume] [nchar](30) NOT NULL,
	[telefon] [nchar](13) NOT NULL,
	[data_angajare] [date] NOT NULL,
	[fk_director] [int] NULL,
	[password] [nchar](40) NULL,
 CONSTRAINT [PK_mecanic] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[operatie]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[operatie](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fk_reparatie] [int] NOT NULL,
	[fk_mecanic] [int] NOT NULL,
	[descriere] [nchar](40) NULL,
	[fk_piesa] [nchar](90) NULL,
	[fk_supplier] [int] NULL,
 CONSTRAINT [PK_operatie] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[piesa]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[piesa](
	[nume] [nchar](90) NOT NULL,
	[cantitate] [int] NOT NULL,
	[fk_supplier] [int] NOT NULL,
 CONSTRAINT [PK_piesa_1] PRIMARY KEY CLUSTERED 
(
	[nume] ASC,
	[fk_supplier] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[supplier]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[supplier](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nume] [nchar](40) NULL,
	[telefon] [nchar](40) NULL,
 CONSTRAINT [PK_supplier] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tip_brevet]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tip_brevet](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tip] [nchar](30) NULL,
 CONSTRAINT [PK_tip_brevet] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[utilizare_dispozitiv]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[utilizare_dispozitiv](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fk_mecanic] [int] NOT NULL,
	[fk_dispozitiv] [int] NOT NULL,
	[data] [date] NOT NULL,
 CONSTRAINT [PK_utilizare_dispozitiv] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vanzare]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vanzare](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fk_angajat] [int] NOT NULL,
	[fk_proprietar] [int] NOT NULL,
	[fk_nume_piesa] [nchar](90) NOT NULL,
	[amount] [int] NOT NULL,
	[fk_supplier_piesa] [int] NOT NULL,
 CONSTRAINT [PK_vanzare] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vanzator]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vanzator](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nume] [nchar](30) NOT NULL,
	[prenume] [nchar](30) NOT NULL,
	[data_angajarii] [date] NOT NULL,
	[salariu] [money] NOT NULL,
	[fk_director_tehnic] [int] NULL,
	[parola] [nchar](40) NULL,
 CONSTRAINT [PK_vanzator] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[brevet_dispozitiv] ON 

INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (201, 6, 4)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (202, 22, 3)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (203, 4, 5)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (204, 55, 6)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (205, 99, 6)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (206, 20, 1)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (207, 89, 3)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (208, 87, 1)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (209, 68, 1)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (210, 66, 2)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (211, 4, 3)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (212, 6, 2)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (213, 30, 5)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (214, 20, 3)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (215, 74, 4)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (216, 18, 2)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (217, 46, 1)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (218, 37, 2)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (219, 31, 2)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (220, 23, 3)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (221, 52, 6)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (222, 99, 1)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (223, 71, 4)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (224, 66, 3)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (225, 60, 3)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (226, 27, 6)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (227, 52, 3)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (228, 35, 6)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (229, 82, 6)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (230, 72, 4)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (231, 99, 3)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (232, 6, 1)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (233, 21, 3)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (234, 64, 4)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (235, 77, 5)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (236, 28, 5)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (237, 91, 3)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (238, 29, 5)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (239, 45, 5)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (240, 15, 5)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (241, 23, 2)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (242, 48, 5)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (243, 88, 6)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (244, 74, 4)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (245, 96, 4)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (246, 56, 4)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (247, 57, 1)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (248, 2, 1)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (249, 97, 6)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (250, 60, 5)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (251, 32, 3)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (252, 31, 5)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (253, 67, 6)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (254, 60, 2)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (255, 73, 2)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (256, 19, 1)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (257, 72, 4)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (258, 70, 3)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (259, 19, 4)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (260, 55, 2)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (261, 71, 6)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (262, 57, 1)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (263, 78, 1)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (264, 42, 1)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (265, 60, 2)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (266, 46, 1)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (267, 17, 4)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (268, 24, 4)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (269, 47, 1)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (270, 62, 6)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (271, 95, 3)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (272, 57, 1)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (273, 55, 3)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (274, 40, 6)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (275, 61, 2)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (276, 59, 2)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (277, 33, 4)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (278, 55, 4)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (279, 85, 6)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (280, 43, 6)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (281, 73, 4)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (282, 61, 3)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (283, 41, 1)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (284, 69, 6)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (285, 15, 3)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (286, 84, 4)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (287, 45, 3)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (288, 65, 2)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (289, 58, 4)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (290, 95, 6)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (291, 25, 6)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (292, 90, 2)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (293, 5, 1)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (294, 7, 4)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (295, 49, 5)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (296, 61, 2)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (297, 31, 6)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (298, 9, 1)
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (299, 59, 2)
GO
INSERT [dbo].[brevet_dispozitiv] ([id], [fk_mecanic], [tipbrevet]) VALUES (300, 13, 4)
SET IDENTITY_INSERT [dbo].[brevet_dispozitiv] OFF
SET IDENTITY_INSERT [dbo].[director_tehnic] ON 

INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (3, N'Paki                                                                                                                              ', N'Berger                                                                                                                            ', 4347, CAST(N'2002-10-18' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (4, N'Kyra                                                                                                                              ', N'Rowland                                                                                                                           ', 3884, CAST(N'2007-01-21' AS Date), N'123                                     ')
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (5, N'Grace                                                                                                                             ', N'Fitzpatrick                                                                                                                       ', 3016, CAST(N'2002-02-23' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (6, N'Blair                                                                                                                             ', N'Flynn                                                                                                                             ', 3033, CAST(N'2012-01-12' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (7, N'Nehru                                                                                                                             ', N'Mason                                                                                                                             ', 4372, CAST(N'2009-03-16' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (8, N'Selma                                                                                                                             ', N'Sykes                                                                                                                             ', 3771, CAST(N'2015-01-18' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (9, N'Riley                                                                                                                             ', N'Wheeler                                                                                                                           ', 3373, CAST(N'2011-10-22' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (10, N'Leonard                                                                                                                           ', N'Giles                                                                                                                             ', 4648, CAST(N'2004-11-06' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (11, N'Nolan                                                                                                                             ', N'Buckner                                                                                                                           ', 3440, CAST(N'2009-04-29' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (12, N'Zia                                                                                                                               ', N'Bryant                                                                                                                            ', 3436, CAST(N'2007-04-04' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (13, N'Lesley                                                                                                                            ', N'Sears                                                                                                                             ', 4228, CAST(N'2007-11-23' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (14, N'Ivory                                                                                                                             ', N'Wilkinson                                                                                                                         ', 4387, CAST(N'2002-12-27' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (15, N'Piper                                                                                                                             ', N'Carson                                                                                                                            ', 3801, CAST(N'2014-11-29' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (16, N'Xaviera                                                                                                                           ', N'Branch                                                                                                                            ', 3789, CAST(N'2013-01-13' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (17, N'Marah                                                                                                                             ', N'Valdez                                                                                                                            ', 4688, CAST(N'2013-07-22' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (18, N'Kevin                                                                                                                             ', N'Henry                                                                                                                             ', 3397, CAST(N'2007-04-17' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (19, N'Quintessa                                                                                                                         ', N'Day                                                                                                                               ', 4511, CAST(N'2009-09-10' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (20, N'Cherokee                                                                                                                          ', N'Mercado                                                                                                                           ', 4901, CAST(N'2002-11-09' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (21, N'Carissa                                                                                                                           ', N'Elliott                                                                                                                           ', 3358, CAST(N'2015-10-22' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (22, N'Maxine                                                                                                                            ', N'Robertson                                                                                                                         ', 4453, CAST(N'2009-10-18' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (23, N'Montana                                                                                                                           ', N'Evans                                                                                                                             ', 3084, CAST(N'2003-04-25' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (24, N'Emi                                                                                                                               ', N'Diaz                                                                                                                              ', 4593, CAST(N'2002-11-22' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (25, N'Lacy                                                                                                                              ', N'Waters                                                                                                                            ', 4811, CAST(N'2015-11-03' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (26, N'Kimberley                                                                                                                         ', N'Valencia                                                                                                                          ', 3289, CAST(N'2008-11-09' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (27, N'Carolyn                                                                                                                           ', N'Rodriquez                                                                                                                         ', 4993, CAST(N'2002-01-23' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (28, N'Hoyt                                                                                                                              ', N'Stokes                                                                                                                            ', 3418, CAST(N'2013-05-09' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (29, N'Hasad                                                                                                                             ', N'Knight                                                                                                                            ', 3851, CAST(N'2015-09-30' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (30, N'Hasad                                                                                                                             ', N'Moreno                                                                                                                            ', 4109, CAST(N'2005-05-30' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (31, N'Davis                                                                                                                             ', N'Mason                                                                                                                             ', 4266, CAST(N'2015-05-14' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (32, N'Nicole                                                                                                                            ', N'Erickson                                                                                                                          ', 4443, CAST(N'2010-09-02' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (33, N'Teegan                                                                                                                            ', N'Stark                                                                                                                             ', 4889, CAST(N'2012-11-26' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (34, N'Garrison                                                                                                                          ', N'Lowe                                                                                                                              ', 4650, CAST(N'2008-02-10' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (35, N'Kitra                                                                                                                             ', N'Wallace                                                                                                                           ', 3602, CAST(N'2003-07-15' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (36, N'Sean                                                                                                                              ', N'Brooks                                                                                                                            ', 4650, CAST(N'2006-05-12' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (37, N'Jelani                                                                                                                            ', N'Dorsey                                                                                                                            ', 3270, CAST(N'2013-12-20' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (38, N'Tyrone                                                                                                                            ', N'Osborn                                                                                                                            ', 4749, CAST(N'2004-06-15' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (39, N'Karina                                                                                                                            ', N'Fleming                                                                                                                           ', 4043, CAST(N'2006-06-19' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (40, N'Selma                                                                                                                             ', N'Rich                                                                                                                              ', 4680, CAST(N'2007-05-08' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (41, N'Alexa                                                                                                                             ', N'Cross                                                                                                                             ', 3034, CAST(N'2005-12-02' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (42, N'Inga                                                                                                                              ', N'Hooper                                                                                                                            ', 4981, CAST(N'2005-01-18' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (43, N'Akeem                                                                                                                             ', N'Gardner                                                                                                                           ', 4208, CAST(N'2006-11-07' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (44, N'Alma                                                                                                                              ', N'Snider                                                                                                                            ', 3951, CAST(N'2012-08-10' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (45, N'Vernon                                                                                                                            ', N'Smith                                                                                                                             ', 4155, CAST(N'2013-10-28' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (46, N'Dalton                                                                                                                            ', N'Sampson                                                                                                                           ', 3434, CAST(N'2003-12-24' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (47, N'Cooper                                                                                                                            ', N'Sellers                                                                                                                           ', 3568, CAST(N'2015-09-07' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (48, N'Alisa                                                                                                                             ', N'Whitehead                                                                                                                         ', 4446, CAST(N'2012-10-07' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (49, N'Duncan                                                                                                                            ', N'Morton                                                                                                                            ', 4885, CAST(N'2013-11-26' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (50, N'Abraham                                                                                                                           ', N'Buck                                                                                                                              ', 3039, CAST(N'2009-04-09' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (51, N'Dante                                                                                                                             ', N'Hull                                                                                                                              ', 3975, CAST(N'2006-10-11' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (52, N'Hamilton                                                                                                                          ', N'White                                                                                                                             ', 4824, CAST(N'2008-04-22' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (53, N'Kenneth                                                                                                                           ', N'Wagner                                                                                                                            ', 4445, CAST(N'2007-11-14' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (54, N'Zorita                                                                                                                            ', N'Barlow                                                                                                                            ', 4915, CAST(N'2014-11-30' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (55, N'Harlan                                                                                                                            ', N'Ellison                                                                                                                           ', 3685, CAST(N'2014-08-16' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (56, N'Simone                                                                                                                            ', N'Justice                                                                                                                           ', 3159, CAST(N'2013-02-22' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (57, N'Charity                                                                                                                           ', N'Fry                                                                                                                               ', 3944, CAST(N'2005-12-26' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (58, N'Quinlan                                                                                                                           ', N'Kirkland                                                                                                                          ', 4590, CAST(N'2003-08-08' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (59, N'Steven                                                                                                                            ', N'Maddox                                                                                                                            ', 3438, CAST(N'2006-04-24' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (60, N'Sharon                                                                                                                            ', N'Wise                                                                                                                              ', 4190, CAST(N'2014-02-13' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (61, N'Yvonne                                                                                                                            ', N'Hubbard                                                                                                                           ', 4206, CAST(N'2010-09-24' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (62, N'Craig                                                                                                                             ', N'Duke                                                                                                                              ', 3488, CAST(N'2007-10-29' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (63, N'Willa                                                                                                                             ', N'Compton                                                                                                                           ', 3681, CAST(N'2009-10-10' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (64, N'Galena                                                                                                                            ', N'Alford                                                                                                                            ', 3829, CAST(N'2010-01-10' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (65, N'Virginia                                                                                                                          ', N'Lambert                                                                                                                           ', 3314, CAST(N'2008-04-20' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (66, N'Ava                                                                                                                               ', N'Chase                                                                                                                             ', 4079, CAST(N'2015-04-23' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (67, N'Blake                                                                                                                             ', N'Malone                                                                                                                            ', 3835, CAST(N'2007-10-13' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (68, N'Oscar                                                                                                                             ', N'Finch                                                                                                                             ', 4353, CAST(N'2012-12-04' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (69, N'Rahim                                                                                                                             ', N'Valenzuela                                                                                                                        ', 3210, CAST(N'2007-09-12' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (70, N'Shelly                                                                                                                            ', N'Dean                                                                                                                              ', 3141, CAST(N'2009-03-22' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (71, N'Helen                                                                                                                             ', N'Molina                                                                                                                            ', 4328, CAST(N'2005-11-28' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (72, N'Emerald                                                                                                                           ', N'Miles                                                                                                                             ', 4819, CAST(N'2013-05-18' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (73, N'Mikayla                                                                                                                           ', N'Pena                                                                                                                              ', 3988, CAST(N'2004-04-22' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (74, N'Eden                                                                                                                              ', N'Harrison                                                                                                                          ', 4638, CAST(N'2010-07-25' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (75, N'Ramona                                                                                                                            ', N'Bradley                                                                                                                           ', 3159, CAST(N'2015-09-26' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (76, N'Sawyer                                                                                                                            ', N'Livingston                                                                                                                        ', 4631, CAST(N'2013-10-29' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (77, N'Keane                                                                                                                             ', N'Page                                                                                                                              ', 3964, CAST(N'2015-12-10' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (78, N'Jasmine                                                                                                                           ', N'Oliver                                                                                                                            ', 3107, CAST(N'2013-04-01' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (79, N'Hashim                                                                                                                            ', N'Glover                                                                                                                            ', 3496, CAST(N'2011-03-09' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (80, N'Tanek                                                                                                                             ', N'Christensen                                                                                                                       ', 4116, CAST(N'2013-07-22' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (81, N'Noel                                                                                                                              ', N'Hutchinson                                                                                                                        ', 3288, CAST(N'2013-03-25' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (82, N'Vincent                                                                                                                           ', N'Church                                                                                                                            ', 3324, CAST(N'2011-08-12' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (83, N'Xanthus                                                                                                                           ', N'Welch                                                                                                                             ', 4242, CAST(N'2008-01-13' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (84, N'Cathleen                                                                                                                          ', N'Le                                                                                                                                ', 4788, CAST(N'2012-06-21' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (85, N'Keely                                                                                                                             ', N'David                                                                                                                             ', 3626, CAST(N'2006-10-12' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (86, N'Malik                                                                                                                             ', N'Tate                                                                                                                              ', 3862, CAST(N'2007-07-01' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (87, N'Valentine                                                                                                                         ', N'Walton                                                                                                                            ', 4257, CAST(N'2010-09-29' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (88, N'Zachary                                                                                                                           ', N'Beck                                                                                                                              ', 3444, CAST(N'2007-07-18' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (89, N'Jaden                                                                                                                             ', N'Justice                                                                                                                           ', 3222, CAST(N'2012-11-04' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (90, N'Callum                                                                                                                            ', N'Cleveland                                                                                                                         ', 4618, CAST(N'2010-09-29' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (91, N'Xenos                                                                                                                             ', N'Beasley                                                                                                                           ', 3256, CAST(N'2015-05-23' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (92, N'Cody                                                                                                                              ', N'Medina                                                                                                                            ', 3469, CAST(N'2010-04-04' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (93, N'Amir                                                                                                                              ', N'Spears                                                                                                                            ', 4181, CAST(N'2003-08-16' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (94, N'Maggie                                                                                                                            ', N'Donovan                                                                                                                           ', 4378, CAST(N'2006-11-03' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (95, N'Amy                                                                                                                               ', N'Ramirez                                                                                                                           ', 4380, CAST(N'2013-09-26' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (96, N'Callie                                                                                                                            ', N'Booker                                                                                                                            ', 3834, CAST(N'2003-08-10' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (97, N'Danielle                                                                                                                          ', N'Bernard                                                                                                                           ', 4447, CAST(N'2009-08-30' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (98, N'Gillian                                                                                                                           ', N'Hurley                                                                                                                            ', 4635, CAST(N'2005-06-27' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (99, N'Slade                                                                                                                             ', N'Malone                                                                                                                            ', 3356, CAST(N'2012-07-20' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (100, N'Oren                                                                                                                              ', N'Miller                                                                                                                            ', 3661, CAST(N'2007-11-22' AS Date), NULL)
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (101, N'Lila                                                                                                                              ', N'Reilly                                                                                                                            ', 4133, CAST(N'2013-04-23' AS Date), NULL)
GO
INSERT [dbo].[director_tehnic] ([id], [nume], [prenume], [salariu], [data_angajarii], [password]) VALUES (102, N'Claire                                                                                                                            ', N'Reid                                                                                                                              ', 3204, CAST(N'2005-06-22' AS Date), NULL)
SET IDENTITY_INSERT [dbo].[director_tehnic] OFF
SET IDENTITY_INSERT [dbo].[dispozitiv] ON 

INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (211, 2, N'viverra.                                          ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (212, 6, N'congue a, aliquet                                 ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (213, 5, N'conubia nostra, per                               ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (214, 1, N'vel                                               ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (215, 3, N'eu                                                ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (216, 6, N'augue. Sed molestie.                              ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (217, 6, N'in aliquet lobortis,                              ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (218, 2, N'urna                                              ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (219, 4, N'dui nec                                           ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (220, 5, N'Etiam                                             ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (221, 2, N'justo sit amet                                    ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (222, 2, N'rutrum. Fusce dolor                               ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (223, 4, N'Nam                                               ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (224, 3, N'purus, in molestie                                ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (225, 2, N'sodales purus, in                                 ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (226, 6, N'Suspendisse tristique neque                       ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (227, 6, N'purus gravida                                     ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (228, 4, N'accumsan                                          ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (229, 1, N'Morbi accumsan                                    ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (230, 2, N'magna tellus faucibus                             ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (231, 4, N'nulla ante,                                       ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (232, 6, N'adipiscing elit.                                  ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (233, 1, N'commodo                                           ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (234, 5, N'aliquam eros                                      ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (235, 3, N'placerat                                          ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (236, 6, N'diam                                              ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (237, 4, N'Sed auctor                                        ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (238, 6, N'sem, consequat nec,                               ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (239, 6, N'nulla. Integer urna.                              ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (240, 6, N'euismod                                           ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (241, 2, N'sodales. Mauris blandit                           ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (242, 2, N'lacus. Cras                                       ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (243, 1, N'vitae erat                                        ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (244, 6, N'felis. Donec tempor,                              ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (245, 1, N'sed                                               ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (246, 1, N'dolor, tempus                                     ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (247, 4, N'Donec at arcu.                                    ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (248, 6, N'nulla.                                            ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (249, 1, N'id                                                ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (250, 3, N'velit. Cras lorem                                 ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (251, 5, N'tincidunt. Donec                                  ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (252, 5, N'Donec fringilla.                                  ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (253, 5, N'pretium aliquet,                                  ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (254, 4, N'hendrerit id, ante.                               ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (255, 1, N'ultrices                                          ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (256, 5, N'pede nec                                          ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (257, 2, N'nec, malesuada                                    ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (258, 3, N'egestas nunc sed                                  ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (259, 3, N'et magnis dis                                     ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (260, 2, N'odio. Aliquam                                     ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (261, 1, N'Duis cursus,                                      ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (262, 6, N'libero nec ligula                                 ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (263, 3, N'et                                                ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (264, 2, N'eu sem.                                           ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (265, 1, N'euismod                                           ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (266, 4, N'orci lobortis augue                               ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (267, 2, N'aliquam                                           ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (268, 3, N'tellus                                            ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (269, 5, N'et nunc.                                          ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (270, 5, N'ligula.                                           ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (271, 1, N'Donec tempus,                                     ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (272, 4, N'felis ullamcorper viverra.                        ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (273, 5, N'amet massa.                                       ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (274, 3, N'Nullam                                            ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (275, 3, N'Sed neque. Sed                                    ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (276, 6, N'vulputate mauris sagittis                         ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (277, 1, N'sem                                               ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (278, 2, N'habitant morbi                                    ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (279, 6, N'amet risus.                                       ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (280, 4, N'amet diam                                         ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (281, 3, N'aliquet. Phasellus fermentum                      ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (282, 6, N'dolor,                                            ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (283, 5, N'Etiam gravida molestie                            ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (284, 5, N'ut,                                               ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (285, 6, N'nisl.                                             ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (286, 1, N'Phasellus in                                      ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (287, 4, N'Suspendisse tristique                             ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (288, 1, N'et                                                ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (289, 2, N'dolor. Donec fringilla.                           ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (290, 1, N'vitae nibh.                                       ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (291, 2, N'aliquet.                                          ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (292, 4, N'lacus.                                            ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (293, 4, N'Duis volutpat                                     ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (294, 1, N'eu tempor                                         ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (295, 3, N'euismod urna. Nullam                              ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (296, 1, N'a, scelerisque sed,                               ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (297, 4, N'nisl. Quisque fringilla                           ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (298, 2, N'nunc id enim.                                     ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (299, 3, N'Curabitur                                         ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (300, 3, N'odio. Aliquam                                     ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (301, 6, N'gravida                                           ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (302, 3, N'mauris elit,                                      ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (303, 2, N'lorem,                                            ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (304, 3, N'Suspendisse                                       ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (305, 6, N'eget                                              ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (306, 4, N'luctus lobortis.                                  ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (307, 3, N'Suspendisse ac                                    ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (308, 6, N'ipsum leo elementum                               ')
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (309, 4, N'magna.                                            ')
GO
INSERT [dbo].[dispozitiv] ([id], [brevet_necesar], [nume]) VALUES (310, 3, N'auctor non,                                       ')
SET IDENTITY_INSERT [dbo].[dispozitiv] OFF
SET IDENTITY_INSERT [dbo].[fabricant] ON 

INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (1, N'Higgins             ', N'0792698176')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (2, N'Odonnell            ', N'0778810550')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (3, N'Wiley               ', N'0774214026')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (4, N'Doyle               ', N'0789261875')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (5, N'Chapman             ', N'0784317955')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (6, N'Pittman             ', N'0740560933')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (7, N'Perry               ', N'0728910636')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (8, N'Craig               ', N'0718365772')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (9, N'Potts               ', N'0700271545')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (10, N'Lara                ', N'0794984879')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (11, N'Gardner             ', N'0777569917')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (12, N'Lane                ', N'0719838284')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (13, N'Callahan            ', N'0767741347')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (14, N'Sloan               ', N'0776804900')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (15, N'Underwood           ', N'0752085350')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (16, N'Wilkins             ', N'0765038726')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (17, N'Mcconnell           ', N'0734237581')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (18, N'Melton              ', N'0745878542')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (19, N'Vang                ', N'0752419162')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (20, N'Lara                ', N'0701350740')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (21, N'Jordan              ', N'0758424056')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (22, N'Howell              ', N'0721504283')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (23, N'Paul                ', N'0716442021')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (24, N'Fletcher            ', N'0742956090')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (25, N'Joseph              ', N'0741379315')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (26, N'Hicks               ', N'0711841526')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (27, N'Hicks               ', N'0705956978')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (28, N'Shepherd            ', N'0706826965')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (29, N'Pope                ', N'0772580349')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (30, N'Marshall            ', N'0741805252')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (31, N'Rojas               ', N'0780211558')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (32, N'Benjamin            ', N'0790083369')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (33, N'Simpson             ', N'0793291031')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (34, N'Sparks              ', N'0779526348')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (35, N'Tyler               ', N'0706537209')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (36, N'Wilkinson           ', N'0766696183')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (37, N'Wolfe               ', N'0708614306')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (38, N'Rocha               ', N'0754424639')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (39, N'Mayer               ', N'0777573470')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (40, N'Dejesus             ', N'0792227367')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (41, N'Raymond             ', N'0751355196')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (42, N'Small               ', N'0714392499')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (43, N'Levy                ', N'0737545950')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (44, N'Dale                ', N'0750963344')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (45, N'Wilkerson           ', N'0761617998')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (46, N'Watkins             ', N'0724356682')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (47, N'Gross               ', N'0729132359')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (48, N'Torres              ', N'0762822192')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (49, N'Cobb                ', N'0747250408')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (50, N'Crosby              ', N'0728910985')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (51, N'Mcfadden            ', N'0742291286')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (52, N'Harvey              ', N'0751928276')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (53, N'Hughes              ', N'0785515366')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (54, N'Meyer               ', N'0754315245')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (55, N'Delacruz            ', N'0745295531')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (56, N'Mccormick           ', N'0741235105')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (57, N'Conley              ', N'0783810706')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (58, N'Kinney              ', N'0709726546')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (59, N'Bradford            ', N'0712894618')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (60, N'Tanner              ', N'0796364930')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (61, N'Luna                ', N'0732692369')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (62, N'Walton              ', N'0747579959')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (63, N'Reese               ', N'0769264396')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (64, N'Figueroa            ', N'0737295712')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (65, N'Webster             ', N'0719918842')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (66, N'Stanley             ', N'0768064153')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (67, N'Glass               ', N'0742842159')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (68, N'French              ', N'0754626358')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (69, N'Sykes               ', N'0715612780')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (70, N'Maddox              ', N'0751950041')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (71, N'Hayes               ', N'0718611413')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (72, N'Boyd                ', N'0774640282')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (73, N'Yang                ', N'0754214064')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (74, N'Dyer                ', N'0755475471')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (75, N'Joyce               ', N'0748831487')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (76, N'Simon               ', N'0771230687')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (77, N'Austin              ', N'0736318464')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (78, N'Miller              ', N'0744172287')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (79, N'Hunt                ', N'0740673157')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (80, N'Pena                ', N'0707187858')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (81, N'Rocha               ', N'0741170650')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (82, N'Sweeney             ', N'0788957827')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (83, N'Gordon              ', N'0793527992')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (84, N'Wilder              ', N'0755034494')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (85, N'Rice                ', N'0727573256')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (86, N'Bruce               ', N'0711705476')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (87, N'Berger              ', N'0715788589')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (88, N'Farrell             ', N'0711548640')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (89, N'Roberts             ', N'0702453745')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (90, N'Daugherty           ', N'0712019094')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (91, N'Jarvis              ', N'0795215004')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (92, N'Blankenship         ', N'0793242454')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (93, N'Abbott              ', N'0737387058')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (94, N'Nunez               ', N'0719478165')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (95, N'Head                ', N'0707054173')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (96, N'Gallagher           ', N'0782641592')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (97, N'Suarez              ', N'0743442863')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (98, N'Bass                ', N'0786380088')
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (99, N'Diaz                ', N'0748407969')
GO
INSERT [dbo].[fabricant] ([id], [nume], [nr_telefon]) VALUES (100, N'Odonnell            ', N'0724269196')
SET IDENTITY_INSERT [dbo].[fabricant] OFF
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1600082897639', N'blue                          ', 2, 1, 33)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1600082897699', N'parturient                    ', 6, 28, 75)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1601092629799', N'arcu.                         ', 2, 90, 55)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1601101500099', N'id                            ', 4, 81, 96)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1601111046399', N'vel                           ', 3, 76, 26)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1602020993899', N'eget                          ', 2, 44, 43)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1602093042299', N'a                             ', 7, 8, 19)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1603022285499', N'mauris                        ', 2, 9, 58)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1603050668699', N'non                           ', 9, 46, 100)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1604030889799', N'et                            ', 6, 52, 5)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1606062221699', N'nec                           ', 8, 48, 69)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1607071490299', N'eu,                           ', 6, 21, 49)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1607072825099', N'amet,                         ', 2, 3, 66)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1608030379799', N'enim.                         ', 4, 43, 23)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1609050603899', N'purus                         ', 6, 51, 40)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1609060127499', N'Sed                           ', 1, 90, 47)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1610051044499', N'Proin                         ', 1, 94, 42)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1610052555999', N'conubia                       ', 9, 37, 70)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1611102128799', N'Integer                       ', 3, 55, 66)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1612011181899', N'ante.                         ', 4, 85, 91)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1613042971899', N'id,                           ', 9, 60, 35)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1616011302899', N'et,                           ', 1, 33, 3)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1617031716299', N'rutrum.                       ', 6, 48, 12)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1617040784299', N'sem.                          ', 4, 57, 99)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1617121079499', N'ante.                         ', 8, 48, 46)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1617122928999', N'lacinia.                      ', 5, 81, 35)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1618042806099', N'augue                         ', 4, 97, 95)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1620020668799', N'Aliquam                       ', 4, 72, 99)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1627020364999', N'a                             ', 5, 2, 88)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1627111713799', N'vestibulum                    ', 4, 35, 23)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1628051014099', N'Donec                         ', 4, 84, 37)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1629122793099', N'lectus                        ', 8, 48, 1)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1630121244499', N'non                           ', 9, 6, 77)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1631061203499', N'cursus                        ', 3, 16, 36)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1631070159999', N'semper.                       ', 2, 27, 83)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1632040103699', N'ut,                           ', 3, 31, 4)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1632080795399', N'Aliquam                       ', 9, 8, 80)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1633080710499', N'dignissim.                    ', 8, 79, 10)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1636061220699', N'diam.                         ', 7, 17, 35)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1636110331499', N'sem                           ', 5, 38, 19)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1636110484599', N'Maecenas                      ', 7, 9, 1)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1637032090799', N'Aliquam                       ', 9, 34, 57)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1637080897599', N'accumsan                      ', 7, 63, 21)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1638031028399', N'sit                           ', 8, 73, 58)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1638110347199', N'Aliquam                       ', 8, 1, 63)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1639091173899', N'nunc.                         ', 5, 43, 70)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1644092451399', N'nisl.                         ', 8, 98, 9)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1645072498499', N'ac                            ', 6, 34, 65)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1646060972699', N'mattis.                       ', 3, 31, 73)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1647092175999', N'gravida                       ', 2, 15, 25)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1647101798999', N'arcu.                         ', 9, 55, 60)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1648090968999', N'dictum                        ', 8, 3, 72)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1649020875299', N'eu                            ', 3, 52, 18)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1650051140899', N'natoque                       ', 3, 74, 15)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1650062169299', N'quis                          ', 9, 74, 84)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1650070814399', N'felis                         ', 1, 29, 42)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1650083011399', N'tortor.                       ', 1, 77, 28)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1653071567599', N'Proin                         ', 5, 65, 2)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1654090664099', N'libero                        ', 2, 84, 60)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1656020480599', N'elit                          ', 1, 20, 57)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1656043082899', N'dolor,                        ', 2, 21, 93)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1657070532199', N'malesuada                     ', 9, 8, 54)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1657071002999', N'egestas.                      ', 3, 27, 93)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1657080379499', N'posuere                       ', 2, 50, 94)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1660080537899', N'Curabitur                     ', 9, 52, 15)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1662060249499', N'vestibulum                    ', 6, 90, 16)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1663051430299', N'risus.                        ', 7, 41, 11)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1664090259499', N'rutrum                        ', 5, 27, 10)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1667053038599', N'non                           ', 4, 58, 28)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1667092553099', N'Phasellus                     ', 1, 60, 5)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1668072060599', N'eu                            ', 6, 81, 73)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1668101976899', N'sodales.                      ', 5, 23, 82)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1669031055999', N'gravida.                      ', 9, 77, 78)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1669110410599', N'Donec                         ', 1, 62, 20)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1669111913899', N'Integer                       ', 1, 54, 15)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1670040748999', N'rutrum.                       ', 6, 84, 33)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1670040924999', N'Vivamus                       ', 8, 68, 20)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1670102484199', N'molestie                      ', 4, 79, 40)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1671110709599', N'dui.                          ', 8, 1, 61)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1672092341599', N'Donec                         ', 4, 50, 57)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1675073027999', N'ut,                           ', 1, 7, 47)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1676030225199', N'In                            ', 5, 21, 23)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1676032738799', N'mauris                        ', 8, 49, 96)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1678072584899', N'In                            ', 3, 1, 91)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1678091439899', N'dis                           ', 1, 61, 91)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1679010296499', N'tempus                        ', 1, 39, 64)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1679020470599', N'consequat                     ', 5, 45, 43)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1679090429499', N'ipsum                         ', 1, 48, 33)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1681020350599', N'ut                            ', 5, 37, 7)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1685081892299', N'pharetra,                     ', 4, 3, 32)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1686022165199', N'metus                         ', 8, 76, 14)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1686062233299', N'Curae;                        ', 1, 58, 71)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1688051379199', N'mattis.                       ', 3, 98, 25)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1688072425099', N'Nunc                          ', 4, 67, 83)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1689081859199', N'ultricies                     ', 3, 11, 9)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1690053076799', N'posuere                       ', 6, 89, 8)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1690112644999', N'orci,                         ', 6, 65, 89)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1693122997399', N'sagittis                      ', 6, 28, 30)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1695042079799', N'sem,                          ', 3, 86, 67)
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1697103020299', N'facilisis,                    ', 2, 44, 3)
GO
INSERT [dbo].[masina] ([vin], [culoare], [fk_tip], [fk_brand], [fk_proprietar]) VALUES (N'1698093013599', N'amet                          ', 9, 65, 67)
SET IDENTITY_INSERT [dbo].[mecanic] ON 

INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (1, N'Emerson                       ', N'Snow                          ', N'0708964226   ', CAST(N'2008-02-19' AS Date), 49, N'123                                     ')
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (2, N'Ulla                          ', N'Mcdaniel                      ', N'0782654446   ', CAST(N'2011-12-09' AS Date), 82, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (3, N'Stacy                         ', N'Clayton                       ', N'0781141388   ', CAST(N'2007-02-13' AS Date), 3, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (4, N'Macon                         ', N'Bridges                       ', N'0705011051   ', CAST(N'2014-01-11' AS Date), 61, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (5, N'Germane                       ', N'Trujillo                      ', N'0732686639   ', CAST(N'2015-01-04' AS Date), 68, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (6, N'Marcia                        ', N'Clark                         ', N'0733731056   ', CAST(N'2013-11-20' AS Date), 26, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (7, N'Quentin                       ', N'Lowery                        ', N'0770200527   ', CAST(N'2005-03-10' AS Date), 22, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (8, N'Jamalia                       ', N'Buckley                       ', N'0708466319   ', CAST(N'2016-12-12' AS Date), 59, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (9, N'Vaughan                       ', N'Downs                         ', N'0762485135   ', CAST(N'2014-07-08' AS Date), 61, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (10, N'Logan                         ', N'Cox                           ', N'0715848250   ', CAST(N'2001-12-23' AS Date), 8, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (11, N'Xantha                        ', N'Calderon                      ', N'0787242822   ', CAST(N'2011-01-25' AS Date), 52, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (12, N'Alma                          ', N'Doyle                         ', N'0737191369   ', CAST(N'2013-09-13' AS Date), 44, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (13, N'Owen                          ', N'Love                          ', N'0739291084   ', CAST(N'2011-03-12' AS Date), 63, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (14, N'Christian                     ', N'Rose                          ', N'0700739651   ', CAST(N'2008-09-30' AS Date), 6, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (15, N'Harrison                      ', N'Shepherd                      ', N'0762504294   ', CAST(N'2011-10-03' AS Date), 81, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (16, N'Acton                         ', N'Conway                        ', N'0709681231   ', CAST(N'2012-03-25' AS Date), 31, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (17, N'Vance                         ', N'Bender                        ', N'0742057407   ', CAST(N'2006-01-18' AS Date), 74, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (18, N'Cole                          ', N'Mayer                         ', N'0754499746   ', CAST(N'2009-10-30' AS Date), 34, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (19, N'Alden                         ', N'Blevins                       ', N'0752274453   ', CAST(N'2011-06-22' AS Date), 17, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (20, N'Avye                          ', N'Cervantes                     ', N'0796935372   ', CAST(N'2002-03-15' AS Date), 65, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (21, N'Amanda                        ', N'Koch                          ', N'0765859883   ', CAST(N'2012-05-20' AS Date), 52, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (22, N'Ginger                        ', N'Spears                        ', N'0739876534   ', CAST(N'2011-09-05' AS Date), 66, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (23, N'Patricia                      ', N'Stout                         ', N'0794317203   ', CAST(N'2013-01-03' AS Date), 89, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (24, N'Keefe                         ', N'Glenn                         ', N'0703525632   ', CAST(N'2014-08-28' AS Date), 63, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (25, N'Yeo                           ', N'Shelton                       ', N'0780167151   ', CAST(N'2006-08-14' AS Date), 49, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (26, N'Cole                          ', N'Oneil                         ', N'0725911654   ', CAST(N'2008-10-24' AS Date), 27, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (27, N'Phelan                        ', N'Baird                         ', N'0714433755   ', CAST(N'2008-06-27' AS Date), 61, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (28, N'Nigel                         ', N'Burns                         ', N'0779664323   ', CAST(N'2015-09-07' AS Date), 24, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (29, N'Dylan                         ', N'Wall                          ', N'0757118940   ', CAST(N'2003-10-21' AS Date), 60, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (30, N'Amir                          ', N'Fox                           ', N'0754456119   ', CAST(N'2006-05-25' AS Date), 50, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (31, N'Ruth                          ', N'Waller                        ', N'0794799579   ', CAST(N'2006-02-19' AS Date), 22, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (32, N'Rogan                         ', N'Sosa                          ', N'0724920506   ', CAST(N'2003-08-01' AS Date), 15, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (33, N'Whoopi                        ', N'Beck                          ', N'0747257686   ', CAST(N'2005-02-05' AS Date), 58, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (34, N'Jasper                        ', N'Nieves                        ', N'0711052320   ', CAST(N'2005-04-25' AS Date), 48, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (35, N'Talon                         ', N'Frye                          ', N'0763778243   ', CAST(N'2012-06-17' AS Date), 3, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (36, N'Hope                          ', N'Mcgee                         ', N'0738434762   ', CAST(N'2002-02-03' AS Date), 84, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (37, N'Hector                        ', N'Weaver                        ', N'0716582905   ', CAST(N'2008-08-21' AS Date), 31, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (38, N'Libby                         ', N'Perry                         ', N'0715427830   ', CAST(N'2013-07-23' AS Date), 37, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (39, N'Silas                         ', N'Wheeler                       ', N'0734678640   ', CAST(N'2011-07-24' AS Date), 76, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (40, N'Brandon                       ', N'Malone                        ', N'0739490079   ', CAST(N'2014-12-14' AS Date), 81, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (41, N'Jerry                         ', N'Ford                          ', N'0723059870   ', CAST(N'2009-10-25' AS Date), 4, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (42, N'Neve                          ', N'Levy                          ', N'0797208321   ', CAST(N'2013-07-07' AS Date), 42, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (43, N'Portia                        ', N'Buchanan                      ', N'0766707087   ', CAST(N'2012-10-03' AS Date), 66, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (44, N'Leo                           ', N'Kinney                        ', N'0792997743   ', CAST(N'2012-11-15' AS Date), 22, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (45, N'Armando                       ', N'Campbell                      ', N'0755863493   ', CAST(N'2006-08-29' AS Date), 97, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (46, N'Meghan                        ', N'Mcdowell                      ', N'0768591649   ', CAST(N'2007-07-11' AS Date), 36, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (47, N'Karina                        ', N'Fox                           ', N'0768024884   ', CAST(N'2014-02-10' AS Date), 52, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (48, N'Nell                          ', N'Pacheco                       ', N'0754290130   ', CAST(N'2002-06-14' AS Date), 9, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (49, N'Lillian                       ', N'Rivera                        ', N'0789459984   ', CAST(N'2005-01-08' AS Date), 63, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (50, N'Melissa                       ', N'Thomas                        ', N'0771898081   ', CAST(N'2010-10-04' AS Date), 22, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (51, N'Cullen                        ', N'Glass                         ', N'0775826141   ', CAST(N'2011-01-11' AS Date), 50, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (52, N'Ruby                          ', N'Whitley                       ', N'0724572502   ', CAST(N'2013-09-01' AS Date), 63, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (53, N'Damon                         ', N'Pickett                       ', N'0712467478   ', CAST(N'2010-05-28' AS Date), 62, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (54, N'Samuel                        ', N'Vincent                       ', N'0733298794   ', CAST(N'2005-12-17' AS Date), 54, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (55, N'Garrett                       ', N'Whitaker                      ', N'0759226034   ', CAST(N'2014-03-13' AS Date), 94, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (56, N'Aquila                        ', N'Bullock                       ', N'0734534266   ', CAST(N'2008-12-16' AS Date), 85, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (57, N'Igor                          ', N'Spence                        ', N'0762863030   ', CAST(N'2003-03-14' AS Date), 80, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (58, N'Elton                         ', N'Thomas                        ', N'0776986743   ', CAST(N'2005-05-11' AS Date), 53, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (59, N'Emerald                       ', N'Harrison                      ', N'0743051418   ', CAST(N'2007-08-18' AS Date), 71, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (60, N'Graham                        ', N'Blackburn                     ', N'0762960275   ', CAST(N'2010-03-13' AS Date), 88, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (61, N'Chadwick                      ', N'Cherry                        ', N'0796651946   ', CAST(N'2014-07-29' AS Date), 72, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (62, N'Keane                         ', N'Pearson                       ', N'0742514207   ', CAST(N'2006-10-30' AS Date), 9, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (63, N'Bree                          ', N'Richard                       ', N'0799108863   ', CAST(N'2011-12-11' AS Date), 13, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (64, N'Kamal                         ', N'Britt                         ', N'0732408681   ', CAST(N'2010-12-24' AS Date), 91, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (65, N'Drake                         ', N'Sloan                         ', N'0782719814   ', CAST(N'2010-12-06' AS Date), 15, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (66, N'Elizabeth                     ', N'Barker                        ', N'0779964040   ', CAST(N'2004-01-18' AS Date), 49, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (67, N'Vernon                        ', N'Mcmahon                       ', N'0737436736   ', CAST(N'2016-08-12' AS Date), 48, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (68, N'Devin                         ', N'West                          ', N'0736045686   ', CAST(N'2015-05-18' AS Date), 26, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (69, N'Tamekah                       ', N'Cooley                        ', N'0775005403   ', CAST(N'2014-02-19' AS Date), 72, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (70, N'Holly                         ', N'Slater                        ', N'0747148995   ', CAST(N'2009-02-25' AS Date), 44, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (71, N'Ferris                        ', N'Vance                         ', N'0754104626   ', CAST(N'2005-01-23' AS Date), 9, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (72, N'Paki                          ', N'Green                         ', N'0765893017   ', CAST(N'2008-12-02' AS Date), 57, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (73, N'Austin                        ', N'Mcintosh                      ', N'0772762639   ', CAST(N'2014-09-27' AS Date), 44, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (74, N'Magee                         ', N'Hancock                       ', N'0761803349   ', CAST(N'2015-09-09' AS Date), 20, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (75, N'Haley                         ', N'Bond                          ', N'0779930142   ', CAST(N'2011-03-30' AS Date), 57, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (76, N'Teegan                        ', N'Munoz                         ', N'0769667236   ', CAST(N'2002-10-06' AS Date), 8, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (77, N'Miranda                       ', N'Ellis                         ', N'0797180636   ', CAST(N'2016-01-22' AS Date), 52, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (78, N'Lavinia                       ', N'Sellers                       ', N'0722691866   ', CAST(N'2008-09-06' AS Date), 15, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (79, N'Shad                          ', N'Booth                         ', N'0793303246   ', CAST(N'2006-09-25' AS Date), 45, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (80, N'Benedict                      ', N'Mcmahon                       ', N'0729610072   ', CAST(N'2008-03-06' AS Date), 39, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (81, N'Gillian                       ', N'Matthews                      ', N'0747427874   ', CAST(N'2009-09-11' AS Date), 60, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (82, N'Rooney                        ', N'Whitley                       ', N'0741986028   ', CAST(N'2011-12-06' AS Date), 95, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (83, N'Raphael                       ', N'Dillard                       ', N'0775576483   ', CAST(N'2014-02-16' AS Date), 78, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (84, N'Tamara                        ', N'Hayden                        ', N'0737576189   ', CAST(N'2014-08-14' AS Date), 71, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (85, N'Clinton                       ', N'Erickson                      ', N'0748999913   ', CAST(N'2003-01-14' AS Date), 32, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (86, N'Myles                         ', N'Davis                         ', N'0756854247   ', CAST(N'2011-01-11' AS Date), 23, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (87, N'Ryder                         ', N'Haley                         ', N'0747083606   ', CAST(N'2007-04-28' AS Date), 40, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (88, N'Amity                         ', N'Floyd                         ', N'0790093646   ', CAST(N'2003-05-15' AS Date), 9, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (89, N'Uta                           ', N'England                       ', N'0738076838   ', CAST(N'2004-03-09' AS Date), 19, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (90, N'Alea                          ', N'Kidd                          ', N'0726366776   ', CAST(N'2002-09-04' AS Date), 94, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (91, N'Miranda                       ', N'Whitfield                     ', N'0742245229   ', CAST(N'2009-10-03' AS Date), 89, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (92, N'Cedric                        ', N'Valencia                      ', N'0718035244   ', CAST(N'2006-04-30' AS Date), 87, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (93, N'Erich                         ', N'Oconnor                       ', N'0703517851   ', CAST(N'2015-03-21' AS Date), 34, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (94, N'Ferris                        ', N'Ballard                       ', N'0759035669   ', CAST(N'2006-11-22' AS Date), 10, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (95, N'Aretha                        ', N'Patton                        ', N'0710328291   ', CAST(N'2007-04-13' AS Date), 22, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (96, N'Gabriel                       ', N'Winters                       ', N'0711095114   ', CAST(N'2004-09-07' AS Date), 78, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (97, N'Benjamin                      ', N'Hendrix                       ', N'0761767726   ', CAST(N'2007-07-10' AS Date), 36, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (98, N'Robin                         ', N'Duran                         ', N'0712382071   ', CAST(N'2002-01-11' AS Date), 42, NULL)
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (99, N'Isabelle                      ', N'Matthews                      ', N'0773007796   ', CAST(N'2006-02-09' AS Date), 62, NULL)
GO
INSERT [dbo].[mecanic] ([id], [nume], [prenume], [telefon], [data_angajare], [fk_director], [password]) VALUES (100, N'Keegan                        ', N'Roth                          ', N'0784261220   ', CAST(N'2005-11-23' AS Date), 4, NULL)
SET IDENTITY_INSERT [dbo].[mecanic] OFF
SET IDENTITY_INSERT [dbo].[operatie] ON 

INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (11, 84, 40, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (12, 82, 6, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (13, 50, 15, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (14, 91, 65, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (15, 80, 34, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (16, 74, 69, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (17, 75, 37, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (18, 73, 7, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (19, 23, 71, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (20, 18, 79, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (21, 32, 94, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (22, 2, 7, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (23, 64, 73, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (24, 67, 30, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (25, 42, 100, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (26, 3, 25, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (27, 47, 23, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (28, 52, 8, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (29, 69, 15, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (30, 73, 87, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (31, 35, 35, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (32, 56, 8, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (33, 4, 73, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (34, 40, 51, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (35, 14, 88, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (36, 68, 56, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (37, 2, 22, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (38, 28, 35, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (39, 39, 92, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (40, 6, 33, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (41, 51, 40, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (42, 64, 45, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (43, 95, 20, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (44, 77, 83, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (45, 54, 56, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (46, 45, 52, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (47, 75, 15, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (48, 81, 73, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (49, 100, 62, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (50, 32, 77, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (51, 70, 80, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (52, 7, 67, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (53, 91, 39, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (54, 4, 21, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (55, 10, 13, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (56, 74, 50, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (57, 61, 92, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (58, 38, 95, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (59, 25, 23, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (60, 70, 55, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (61, 99, 68, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (62, 33, 65, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (63, 22, 77, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (64, 81, 85, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (65, 51, 43, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (66, 70, 44, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (67, 26, 3, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (68, 2, 59, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (69, 38, 4, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (70, 24, 83, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (71, 70, 92, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (72, 94, 13, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (73, 29, 85, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (74, 3, 72, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (75, 71, 39, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (76, 65, 87, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (77, 65, 70, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (78, 62, 93, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (79, 66, 34, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (80, 26, 26, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (81, 59, 53, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (82, 15, 90, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (83, 61, 34, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (84, 39, 22, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (85, 11, 13, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (86, 68, 21, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (87, 43, 83, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (88, 96, 45, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (89, 48, 52, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (90, 67, 6, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (91, 66, 37, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (92, 19, 58, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (93, 42, 33, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (94, 17, 88, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (95, 58, 71, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (96, 50, 90, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (97, 80, 26, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (98, 32, 10, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (99, 74, 14, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (100, 83, 81, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (101, 84, 54, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (102, 91, 25, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (103, 84, 90, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (104, 58, 88, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (105, 47, 64, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (106, 1, 100, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (107, 8, 55, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (108, 62, 66, NULL, NULL, NULL)
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (109, 90, 25, NULL, NULL, NULL)
GO
INSERT [dbo].[operatie] ([id], [fk_reparatie], [fk_mecanic], [descriere], [fk_piesa], [fk_supplier]) VALUES (110, 91, 59, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[operatie] OFF
INSERT [dbo].[piesa] ([nume], [cantitate], [fk_supplier]) VALUES (N's                                                                                         ', 1, 1)
SET IDENTITY_INSERT [dbo].[proprietar] ON 

INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (1, N'Kelly                                                                           ', N'Copeland                                                                        ', N'071864195                     ', N'524727 0842381908   ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (2, N'Jessamine                                                                       ', N'Stout                                                                           ', N'078262286                     ', N'544341 994792 7154  ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (3, N'Zorita                                                                          ', N'Clark                                                                           ', N'077196695                     ', N'5370 8622 1333 5304 ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (4, N'Clayton                                                                         ', N'Salinas                                                                         ', N'074506996                     ', N'5184277691192620    ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (5, N'Judith                                                                          ', N'Reynolds                                                                        ', N'075361038                     ', N'516829 763726 0927  ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (6, N'Flavia                                                                          ', N'Sellers                                                                         ', N'072133868                     ', N'5278 9559 9472 2410 ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (7, N'Amy                                                                             ', N'Stuart                                                                          ', N'079062504                     ', N'5431 1141 5121 6667 ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (8, N'Athena                                                                          ', N'Yates                                                                           ', N'076325145                     ', N'5171 1886 4999 9658 ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (9, N'Russell                                                                         ', N'Rocha                                                                           ', N'074555789                     ', N'5353261548267244    ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (10, N'Sylvester                                                                       ', N'Bradley                                                                         ', N'071139298                     ', N'530 98160 54720 863 ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (11, N'Denton                                                                          ', N'Cox                                                                             ', N'078571273                     ', N'545261 460718 7887  ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (12, N'Alan                                                                            ', N'Pittman                                                                         ', N'076121893                     ', N'515193 7216788777   ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (13, N'Tatiana                                                                         ', N'Faulkner                                                                        ', N'076681333                     ', N'555657 4784880875   ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (14, N'Cameron                                                                         ', N'Ortega                                                                          ', N'071361213                     ', N'530 92599 71896 542 ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (15, N'Orla                                                                            ', N'Benson                                                                          ', N'071988854                     ', N'541207 3278493448   ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (16, N'Vivien                                                                          ', N'Gross                                                                           ', N'076116124                     ', N'559877 137787 3206  ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (17, N'Melodie                                                                         ', N'Lester                                                                          ', N'078316791                     ', N'525564 785986 1832  ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (18, N'Grant                                                                           ', N'Nelson                                                                          ', N'071532519                     ', N'552807 665709 6394  ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (19, N'Devin                                                                           ', N'White                                                                           ', N'078268293                     ', N'5301 0690 2268 3080 ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (20, N'Mariam                                                                          ', N'Leon                                                                            ', N'079392762                     ', N'512 62945 28460 212 ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (21, N'Dorothy                                                                         ', N'Crawford                                                                        ', N'077285475                     ', N'5585188125391768    ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (22, N'Sara                                                                            ', N'Huff                                                                            ', N'079526979                     ', N'5108 6279 6927 1873 ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (23, N'Clio                                                                            ', N'Howard                                                                          ', N'075053987                     ', N'5184 1597 1658 1468 ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (24, N'Jermaine                                                                        ', N'Nichols                                                                         ', N'073181639                     ', N'532172 5986517319   ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (25, N'Kibo                                                                            ', N'Morin                                                                           ', N'077237055                     ', N'557229 3727436212   ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (26, N'Marsden                                                                         ', N'Cabrera                                                                         ', N'077704268                     ', N'5543669370557493    ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (27, N'Reece                                                                           ', N'Gallagher                                                                       ', N'073196096                     ', N'554657 5241622431   ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (28, N'Xander                                                                          ', N'Carter                                                                          ', N'076086325                     ', N'530135 932374 2135  ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (29, N'Gail                                                                            ', N'Johnson                                                                         ', N'075027712                     ', N'537003 4047556337   ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (30, N'Chancellor                                                                      ', N'Lamb                                                                            ', N'071167734                     ', N'529 83593 83241 510 ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (31, N'Myles                                                                           ', N'Frazier                                                                         ', N'078497410                     ', N'516730 596686 2428  ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (32, N'Octavius                                                                        ', N'Mccarthy                                                                        ', N'079325798                     ', N'5278 2064 0797 9787 ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (33, N'Naida                                                                           ', N'Parker                                                                          ', N'072123337                     ', N'5544117146315373    ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (34, N'Ryan                                                                            ', N'Oneil                                                                           ', N'074825578                     ', N'5538347305978269    ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (35, N'Plato                                                                           ', N'Wolf                                                                            ', N'078406896                     ', N'531066 2656323111   ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (36, N'Isaiah                                                                          ', N'Kline                                                                           ', N'077311131                     ', N'558854 1478860416   ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (37, N'Boris                                                                           ', N'French                                                                          ', N'073518514                     ', N'555343 877910 0322  ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (38, N'Amy                                                                             ', N'Miles                                                                           ', N'072545720                     ', N'552677 800663 4625  ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (39, N'Hasad                                                                           ', N'Morse                                                                           ', N'071641636                     ', N'5340 0333 8425 9924 ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (40, N'Jacqueline                                                                      ', N'Hudson                                                                          ', N'072433255                     ', N'554415 882611 7556  ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (41, N'Gay                                                                             ', N'Butler                                                                          ', N'076235066                     ', N'5432 1738 6850 2289 ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (42, N'Amber                                                                           ', N'Mendoza                                                                         ', N'073378994                     ', N'536067 130963 6117  ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (43, N'Zephr                                                                           ', N'Morris                                                                          ', N'078121507                     ', N'5562727674998163    ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (44, N'Clark                                                                           ', N'Hopper                                                                          ', N'076266253                     ', N'547143 196338 6871  ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (45, N'Odessa                                                                          ', N'Franklin                                                                        ', N'074312409                     ', N'5185 2328 6018 2307 ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (46, N'Maisie                                                                          ', N'Howe                                                                            ', N'071972625                     ', N'518241 210781 8847  ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (47, N'Alfreda                                                                         ', N'Flynn                                                                           ', N'076918602                     ', N'5462 0077 9240 0611 ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (48, N'Quail                                                                           ', N'Baxter                                                                          ', N'077294926                     ', N'529376 2484284781   ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (49, N'Daria                                                                           ', N'Joyner                                                                          ', N'071315875                     ', N'5221 8735 7627 9105 ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (50, N'Kuame                                                                           ', N'Quinn                                                                           ', N'078712694                     ', N'5427156645076849    ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (51, N'Nolan                                                                           ', N'Fox                                                                             ', N'074676953                     ', N'5259 9138 8315 0071 ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (52, N'Leonard                                                                         ', N'Medina                                                                          ', N'077974793                     ', N'520 27399 37054 847 ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (53, N'Megan                                                                           ', N'Battle                                                                          ', N'076129922                     ', N'545812 484460 6560  ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (54, N'Lee                                                                             ', N'Garrett                                                                         ', N'075157308                     ', N'5419 1889 2838 0895 ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (55, N'Quyn                                                                            ', N'Kim                                                                             ', N'071309338                     ', N'517 53754 14794 762 ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (56, N'Isabella                                                                        ', N'Haynes                                                                          ', N'079857426                     ', N'5408 8724 2550 1920 ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (57, N'Winifred                                                                        ', N'Green                                                                           ', N'078479017                     ', N'545919 019466 4631  ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (58, N'Carlos                                                                          ', N'Simmons                                                                         ', N'071144998                     ', N'5412 1791 1087 0535 ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (59, N'Tara                                                                            ', N'Greene                                                                          ', N'075035206                     ', N'5445935096373005    ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (60, N'Isadora                                                                         ', N'Maldonado                                                                       ', N'072141408                     ', N'523548 5364270909   ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (61, N'Patricia                                                                        ', N'Hays                                                                            ', N'078923604                     ', N'534 26168 88875 837 ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (62, N'Sylvia                                                                          ', N'Hicks                                                                           ', N'073706345                     ', N'545430 2677476194   ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (63, N'Drake                                                                           ', N'Duke                                                                            ', N'074821550                     ', N'5417047014312851    ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (64, N'Tarik                                                                           ', N'Aguirre                                                                         ', N'076895003                     ', N'545216 7822130133   ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (65, N'India                                                                           ', N'Luna                                                                            ', N'077491500                     ', N'533045 348502 4658  ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (66, N'Kirby                                                                           ', N'Mccarthy                                                                        ', N'076285587                     ', N'518883 0331524226   ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (67, N'Ryan                                                                            ', N'Erickson                                                                        ', N'079859134                     ', N'549 12522 88472 899 ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (68, N'Dane                                                                            ', N'Cox                                                                             ', N'075124819                     ', N'524698 983274 3071  ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (69, N'Morgan                                                                          ', N'Tyler                                                                           ', N'072724889                     ', N'550359 278305 1805  ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (70, N'Nomlanga                                                                        ', N'Collins                                                                         ', N'071656809                     ', N'525363 4882569501   ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (71, N'Jolie                                                                           ', N'Santana                                                                         ', N'077238965                     ', N'5281409222579999    ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (72, N'Castor                                                                          ', N'Ballard                                                                         ', N'072292068                     ', N'5191 0400 3826 8334 ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (73, N'Kamal                                                                           ', N'Moran                                                                           ', N'072967745                     ', N'5362 4197 2946 9703 ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (74, N'Slade                                                                           ', N'Matthews                                                                        ', N'078263418                     ', N'523276 6346920346   ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (75, N'Tasha                                                                           ', N'Pugh                                                                            ', N'074518736                     ', N'523840 1599589424   ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (76, N'Alexa                                                                           ', N'Bolton                                                                          ', N'071233170                     ', N'516 94003 34388 426 ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (77, N'Armand                                                                          ', N'Vaughn                                                                          ', N'074453174                     ', N'545 55621 19510 624 ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (78, N'Sonya                                                                           ', N'Burns                                                                           ', N'071136954                     ', N'5363 1510 1367 6953 ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (79, N'Donna                                                                           ', N'Pickett                                                                         ', N'072904416                     ', N'5497397488032706    ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (80, N'Oleg                                                                            ', N'Wilson                                                                          ', N'078665113                     ', N'5149643015296971    ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (81, N'Lysandra                                                                        ', N'Robertson                                                                       ', N'078336833                     ', N'5111856105170310    ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (82, N'Indigo                                                                          ', N'Griffith                                                                        ', N'078939745                     ', N'5396043050283481    ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (83, N'Dominique                                                                       ', N'Carr                                                                            ', N'071703953                     ', N'521 62811 31143 567 ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (84, N'Bert                                                                            ', N'Odonnell                                                                        ', N'071673184                     ', N'559179 7199105441   ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (85, N'Reese                                                                           ', N'Hansen                                                                          ', N'078528132                     ', N'525217 150500 7834  ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (86, N'Adrian                                                                          ', N'Brennan                                                                         ', N'076127710                     ', N'535410 8447063993   ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (87, N'Yolanda                                                                         ', N'Salas                                                                           ', N'076049109                     ', N'515634 5750427783   ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (88, N'Tate                                                                            ', N'Travis                                                                          ', N'074501993                     ', N'553921 8155337733   ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (89, N'Tiger                                                                           ', N'Donaldson                                                                       ', N'077535228                     ', N'545 18049 31344 541 ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (90, N'Meredith                                                                        ', N'Arnold                                                                          ', N'072948602                     ', N'540610 7662893892   ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (91, N'Castor                                                                          ', N'Johns                                                                           ', N'071631248                     ', N'558895 6279828786   ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (92, N'Clarke                                                                          ', N'Chaney                                                                          ', N'071688988                     ', N'553 31536 11435 753 ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (93, N'Carolyn                                                                         ', N'Silva                                                                           ', N'077314847                     ', N'5361 7528 7293 2742 ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (94, N'Lucian                                                                          ', N'Molina                                                                          ', N'072673112                     ', N'5154165193541178    ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (95, N'Miriam                                                                          ', N'Webster                                                                         ', N'077169504                     ', N'533786 926104 3641  ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (96, N'Blossom                                                                         ', N'Puckett                                                                         ', N'077768822                     ', N'558354 851733 6386  ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (97, N'Curran                                                                          ', N'Jacobs                                                                          ', N'077895290                     ', N'5231948234028066    ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (98, N'May                                                                             ', N'Garza                                                                           ', N'076011759                     ', N'5157 4408 2595 3175 ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (99, N'Vivian                                                                          ', N'Galloway                                                                        ', N'078512994                     ', N'5507 5885 3932 9723 ')
GO
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (100, N'Hamish                                                                          ', N'Hayden                                                                          ', N'073125758                     ', N'540019 750601 8893  ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (101, N'mircea                                                                          ', N'imparatul                                                                       ', N'0734812341                    ', N'34123412341234      ')
INSERT [dbo].[proprietar] ([id], [nume], [prenume], [telefon], [nrcard]) VALUES (102, N'rab                                                                             ', N'bit                                                                             ', N'067733452342                  ', N'341293571029371423  ')
SET IDENTITY_INSERT [dbo].[proprietar] OFF
SET IDENTITY_INSERT [dbo].[reparatie] ON 

INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (1, N'1600082897699', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (2, N'1601092629799', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (3, N'1601101500099', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (4, N'1601111046399', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (5, N'1602020993899', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (6, N'1602093042299', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (7, N'1603022285499', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (8, N'1603050668699', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (9, N'1604030889799', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (10, N'1606062221699', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (11, N'1607071490299', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (12, N'1607072825099', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (13, N'1608030379799', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (14, N'1609050603899', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (15, N'1609060127499', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (16, N'1610051044499', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (17, N'1610052555999', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (18, N'1611102128799', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (19, N'1612011181899', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (20, N'1613042971899', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (21, N'1616011302899', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (22, N'1617031716299', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (23, N'1617040784299', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (24, N'1617121079499', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (25, N'1617122928999', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (26, N'1618042806099', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (27, N'1620020668799', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (28, N'1627020364999', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (29, N'1627111713799', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (30, N'1628051014099', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (31, N'1629122793099', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (32, N'1630121244499', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (33, N'1631061203499', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (34, N'1631070159999', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (35, N'1632040103699', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (36, N'1632080795399', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (37, N'1633080710499', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (38, N'1636061220699', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (39, N'1636110331499', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (40, N'1636110484599', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (41, N'1637032090799', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (42, N'1637080897599', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (43, N'1638031028399', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (44, N'1638110347199', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (45, N'1639091173899', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (46, N'1644092451399', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (47, N'1645072498499', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (48, N'1646060972699', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (49, N'1647092175999', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (50, N'1647101798999', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (51, N'1648090968999', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (52, N'1649020875299', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (53, N'1650051140899', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (54, N'1650062169299', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (55, N'1650070814399', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (56, N'1650083011399', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (57, N'1653071567599', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (58, N'1654090664099', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (59, N'1656020480599', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (60, N'1656043082899', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (61, N'1657070532199', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (62, N'1657071002999', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (63, N'1657080379499', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (64, N'1660080537899', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (65, N'1662060249499', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (66, N'1663051430299', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (67, N'1664090259499', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (68, N'1667053038599', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (69, N'1667092553099', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (70, N'1668072060599', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (71, N'1668101976899', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (72, N'1669031055999', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (73, N'1669110410599', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (74, N'1669111913899', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (75, N'1670040748999', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (76, N'1670040924999', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (77, N'1670102484199', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (78, N'1671110709599', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (79, N'1672092341599', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (80, N'1675073027999', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (81, N'1676030225199', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (82, N'1676032738799', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (83, N'1678072584899', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (84, N'1678091439899', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (85, N'1679010296499', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (86, N'1679020470599', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (87, N'1679090429499', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (88, N'1681020350599', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (89, N'1685081892299', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (90, N'1686022165199', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (91, N'1686062233299', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (92, N'1688051379199', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (93, N'1688072425099', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (94, N'1689081859199', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (95, N'1690053076799', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (96, N'1690112644999', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (97, N'1693122997399', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (98, N'1695042079799', NULL)
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (99, N'1697103020299', NULL)
GO
INSERT [dbo].[reparatie] ([id], [fk_masina], [descriere]) VALUES (100, N'1698093013599', NULL)
SET IDENTITY_INSERT [dbo].[reparatie] OFF
SET IDENTITY_INSERT [dbo].[supplier] ON 

INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (1, N'Martin                                  ', N'0701498578                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (2, N'Cain                                    ', N'0739365452                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (3, N'Burns                                   ', N'0792825461                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (4, N'Cervantes                               ', N'0706793949                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (5, N'Palmer                                  ', N'0797820981                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (6, N'Rivers                                  ', N'0710788047                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (7, N'Sims                                    ', N'0721121004                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (8, N'Little                                  ', N'0730418778                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (9, N'Harper                                  ', N'0709002066                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (10, N'Townsend                                ', N'0735934259                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (11, N'Clayton                                 ', N'0704951838                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (12, N'Turner                                  ', N'0763748806                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (13, N'Johnston                                ', N'0767776741                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (14, N'Velez                                   ', N'0700727941                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (15, N'Chaney                                  ', N'0727503555                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (16, N'Mueller                                 ', N'0711658606                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (17, N'Strong                                  ', N'0726131616                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (18, N'Watson                                  ', N'0778701872                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (19, N'Faulkner                                ', N'0772962084                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (20, N'Humphrey                                ', N'0792169917                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (21, N'Wheeler                                 ', N'0777972391                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (22, N'Ellis                                   ', N'0752204538                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (23, N'Hays                                    ', N'0708207553                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (24, N'Morris                                  ', N'0733761297                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (25, N'Hancock                                 ', N'0741174939                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (26, N'Spence                                  ', N'0798256667                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (27, N'Osborne                                 ', N'0721476118                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (28, N'Melendez                                ', N'0703418022                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (29, N'Holloway                                ', N'0754359776                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (30, N'Carter                                  ', N'0732576396                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (31, N'Goodwin                                 ', N'0727737582                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (32, N'Rodriguez                               ', N'0713559063                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (33, N'Curry                                   ', N'0791517653                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (34, N'Travis                                  ', N'0771321692                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (35, N'Le                                      ', N'0733467309                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (36, N'Lee                                     ', N'0716588399                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (37, N'Valentine                               ', N'0704782561                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (38, N'Mueller                                 ', N'0710425340                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (39, N'Cameron                                 ', N'0787024322                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (40, N'Wise                                    ', N'0794418192                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (41, N'Schmidt                                 ', N'0798860413                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (42, N'Glover                                  ', N'0790509560                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (43, N'Osborn                                  ', N'0768895016                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (44, N'Kaufman                                 ', N'0706218388                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (45, N'Sawyer                                  ', N'0746788842                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (46, N'Miranda                                 ', N'0737531999                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (47, N'Rocha                                   ', N'0786786944                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (48, N'Mccarthy                                ', N'0793668365                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (49, N'Clay                                    ', N'0740031926                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (50, N'Stout                                   ', N'0782655085                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (51, N'Everett                                 ', N'0723435372                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (52, N'Walsh                                   ', N'0725499081                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (53, N'Ellison                                 ', N'0775328292                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (54, N'Vaughn                                  ', N'0789588912                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (55, N'Stark                                   ', N'0701342197                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (56, N'Bartlett                                ', N'0720607028                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (57, N'Durham                                  ', N'0735787841                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (58, N'Page                                    ', N'0741896956                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (59, N'Hebert                                  ', N'0747091632                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (60, N'Stokes                                  ', N'0730900500                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (61, N'Cortez                                  ', N'0729084948                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (62, N'Sutton                                  ', N'0795013944                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (63, N'Farley                                  ', N'0741689698                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (64, N'Jensen                                  ', N'0757309670                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (65, N'Smith                                   ', N'0707488040                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (66, N'Ruiz                                    ', N'0737467109                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (67, N'Hewitt                                  ', N'0718779573                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (68, N'Fitzpatrick                             ', N'0705372585                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (69, N'Fisher                                  ', N'0749375341                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (70, N'Duke                                    ', N'0733360633                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (71, N'Hardin                                  ', N'0774162608                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (72, N'Lewis                                   ', N'0767336076                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (73, N'Kim                                     ', N'0733010271                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (74, N'Case                                    ', N'0772344131                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (75, N'Morgan                                  ', N'0767041067                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (76, N'Mcguire                                 ', N'0738966650                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (77, N'Cardenas                                ', N'0705130912                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (78, N'Barr                                    ', N'0731358618                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (79, N'Donovan                                 ', N'0711582769                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (80, N'Mccarty                                 ', N'0727332064                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (81, N'Ward                                    ', N'0735134162                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (82, N'Clemons                                 ', N'0787038123                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (83, N'Davidson                                ', N'0782529647                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (84, N'Wiley                                   ', N'0792341186                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (85, N'Duke                                    ', N'0724549044                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (86, N'Roman                                   ', N'0746796867                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (87, N'Padilla                                 ', N'0762271097                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (88, N'Duran                                   ', N'0749390863                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (89, N'Dyer                                    ', N'0762158281                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (90, N'Richards                                ', N'0772377590                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (91, N'Marquez                                 ', N'0750766220                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (92, N'Aguilar                                 ', N'0766840980                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (93, N'Miller                                  ', N'0751233331                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (94, N'Whitley                                 ', N'0743712526                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (95, N'Carson                                  ', N'0728929872                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (96, N'Golden                                  ', N'0774769810                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (97, N'Figueroa                                ', N'0705760150                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (98, N'Walker                                  ', N'0737812416                              ')
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (99, N'Ware                                    ', N'0706012407                              ')
GO
INSERT [dbo].[supplier] ([id], [nume], [telefon]) VALUES (100, N'Knox                                    ', N'0798058154                              ')
SET IDENTITY_INSERT [dbo].[supplier] OFF
SET IDENTITY_INSERT [dbo].[tip] ON 

INSERT [dbo].[tip] ([id], [nume]) VALUES (1, N'berlina                       ')
INSERT [dbo].[tip] ([id], [nume]) VALUES (2, N'SUV                           ')
INSERT [dbo].[tip] ([id], [nume]) VALUES (3, N'Truck                         ')
INSERT [dbo].[tip] ([id], [nume]) VALUES (4, N'Sedan                         ')
INSERT [dbo].[tip] ([id], [nume]) VALUES (5, N'Van                           ')
INSERT [dbo].[tip] ([id], [nume]) VALUES (6, N'Coupe                         ')
INSERT [dbo].[tip] ([id], [nume]) VALUES (7, N'Wagon                         ')
INSERT [dbo].[tip] ([id], [nume]) VALUES (8, N'Convertible                   ')
INSERT [dbo].[tip] ([id], [nume]) VALUES (9, N'Crossover                     ')
SET IDENTITY_INSERT [dbo].[tip] OFF
SET IDENTITY_INSERT [dbo].[tip_brevet] ON 

INSERT [dbo].[tip_brevet] ([id], [tip]) VALUES (1, N'sisteme refrigerare           ')
INSERT [dbo].[tip_brevet] ([id], [tip]) VALUES (2, N'elevator                      ')
INSERT [dbo].[tip_brevet] ([id], [tip]) VALUES (3, N'sudor                         ')
INSERT [dbo].[tip_brevet] ([id], [tip]) VALUES (4, N'prelucrare fier               ')
INSERT [dbo].[tip_brevet] ([id], [tip]) VALUES (5, N'sisteme electrice             ')
INSERT [dbo].[tip_brevet] ([id], [tip]) VALUES (6, N'diagnosticare                 ')
INSERT [dbo].[tip_brevet] ([id], [tip]) VALUES (7, NULL)
SET IDENTITY_INSERT [dbo].[tip_brevet] OFF
SET IDENTITY_INSERT [dbo].[vanzare] ON 

INSERT [dbo].[vanzare] ([id], [fk_angajat], [fk_proprietar], [fk_nume_piesa], [amount], [fk_supplier_piesa]) VALUES (3, 7, 2, N's                                                                                         ', 3, 1)
SET IDENTITY_INSERT [dbo].[vanzare] OFF
SET IDENTITY_INSERT [dbo].[vanzator] ON 

INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (7, N'Noble                         ', N'Flowers                       ', CAST(N'2013-05-25' AS Date), 1631.0000, 98, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (8, N'Dante                         ', N'Leach                         ', CAST(N'2015-02-08' AS Date), 2545.0000, 26, N'123                                     ')
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (9, N'Callum                        ', N'Lyons                         ', CAST(N'2014-12-11' AS Date), 1835.0000, 26, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (10, N'Ulysses                       ', N'Preston                       ', CAST(N'2016-04-05' AS Date), 1740.0000, 3, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (11, N'Barrett                       ', N'Austin                        ', CAST(N'2013-10-15' AS Date), 2130.0000, 99, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (12, N'Gil                           ', N'Merritt                       ', CAST(N'2013-12-31' AS Date), 2657.0000, 39, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (13, N'Josiah                        ', N'Munoz                         ', CAST(N'2008-06-26' AS Date), 1649.0000, 11, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (14, N'Kirk                          ', N'Craig                         ', CAST(N'2014-03-20' AS Date), 2809.0000, 47, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (15, N'Rashad                        ', N'Hodge                         ', CAST(N'2010-04-01' AS Date), 2044.0000, 24, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (16, N'Ferris                        ', N'Becker                        ', CAST(N'2010-10-03' AS Date), 1892.0000, 68, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (17, N'Arthur                        ', N'Bradford                      ', CAST(N'2016-08-30' AS Date), 2322.0000, 90, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (18, N'Brent                         ', N'Palmer                        ', CAST(N'2013-08-08' AS Date), 2048.0000, 53, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (19, N'Brenden                       ', N'Rich                          ', CAST(N'2010-06-24' AS Date), 2810.0000, 39, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (20, N'Kelly                         ', N'Norman                        ', CAST(N'2014-04-22' AS Date), 1780.0000, 73, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (21, N'Perry                         ', N'Mcconnell                     ', CAST(N'2004-03-21' AS Date), 2397.0000, 88, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (22, N'Mohammad                      ', N'Gardner                       ', CAST(N'2008-10-07' AS Date), 2851.0000, 17, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (23, N'Cedric                        ', N'Kemp                          ', CAST(N'2014-10-08' AS Date), 2044.0000, 54, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (24, N'Patrick                       ', N'Brewer                        ', CAST(N'2012-07-22' AS Date), 2341.0000, 97, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (25, N'Marshall                      ', N'Cervantes                     ', CAST(N'2009-02-08' AS Date), 1874.0000, 80, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (26, N'Rooney                        ', N'Blake                         ', CAST(N'2015-12-23' AS Date), 2252.0000, 87, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (32, N'Brent                         ', N'Shaw                          ', CAST(N'2008-02-12' AS Date), 2497.0000, 50, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (33, N'Jacob                         ', N'Wilkins                       ', CAST(N'2014-03-31' AS Date), 1123.0000, 39, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (34, N'Gannon                        ', N'Yates                         ', CAST(N'2014-08-31' AS Date), 1771.0000, 79, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (35, N'Kenneth                       ', N'Osborne                       ', CAST(N'2008-12-14' AS Date), 2784.0000, 10, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (36, N'Steven                        ', N'Rosario                       ', CAST(N'2009-06-22' AS Date), 2469.0000, 36, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (37, N'Rahim                         ', N'Boone                         ', CAST(N'2016-11-14' AS Date), 2090.0000, 35, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (38, N'Yuli                          ', N'Santos                        ', CAST(N'2014-04-23' AS Date), 2125.0000, 41, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (39, N'Caesar                        ', N'Farrell                       ', CAST(N'2006-08-19' AS Date), 1019.0000, 71, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (40, N'Demetrius                     ', N'Stuart                        ', CAST(N'2005-01-20' AS Date), 2435.0000, 84, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (41, N'Derek                         ', N'Fox                           ', CAST(N'2012-09-12' AS Date), 2082.0000, 6, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (42, N'Stewart                       ', N'Moody                         ', CAST(N'2004-06-02' AS Date), 1837.0000, 89, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (43, N'Hasad                         ', N'Avery                         ', CAST(N'2016-02-20' AS Date), 2958.0000, 99, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (44, N'Garrison                      ', N'Harding                       ', CAST(N'2013-05-19' AS Date), 1610.0000, 48, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (45, N'Jermaine                      ', N'Snider                        ', CAST(N'2009-03-23' AS Date), 2443.0000, 50, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (46, N'Raymond                       ', N'Welch                         ', CAST(N'2007-03-26' AS Date), 1702.0000, 92, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (47, N'Troy                          ', N'Franco                        ', CAST(N'2015-10-11' AS Date), 2425.0000, 62, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (48, N'Cody                          ', N'Avery                         ', CAST(N'2016-08-12' AS Date), 2149.0000, 22, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (49, N'Wyatt                         ', N'Sanchez                       ', CAST(N'2013-01-05' AS Date), 1152.0000, 68, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (50, N'Demetrius                     ', N'Patterson                     ', CAST(N'2009-11-10' AS Date), 2765.0000, 61, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (51, N'Rashad                        ', N'Roy                           ', CAST(N'2008-08-22' AS Date), 2170.0000, 40, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (52, N'Nissim                        ', N'Moss                          ', CAST(N'2004-10-05' AS Date), 2768.0000, 38, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (53, N'Baxter                        ', N'Berger                        ', CAST(N'2007-03-26' AS Date), 1038.0000, 9, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (54, N'Hu                            ', N'Dawson                        ', CAST(N'2015-11-05' AS Date), 1063.0000, 84, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (55, N'Burke                         ', N'Gilmore                       ', CAST(N'2013-01-23' AS Date), 2301.0000, 66, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (56, N'Bevis                         ', N'Dunlap                        ', CAST(N'2012-06-29' AS Date), 2522.0000, 92, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (57, N'Hashim                        ', N'Skinner                       ', CAST(N'2010-01-16' AS Date), 1426.0000, 6, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (58, N'Rogan                         ', N'Williams                      ', CAST(N'2011-04-07' AS Date), 2986.0000, 8, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (59, N'Walker                        ', N'Bush                          ', CAST(N'2012-09-21' AS Date), 1043.0000, 43, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (60, N'Hammett                       ', N'Hill                          ', CAST(N'2013-01-23' AS Date), 2038.0000, 74, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (61, N'Branden                       ', N'Henson                        ', CAST(N'2009-12-02' AS Date), 1600.0000, 72, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (62, N'Geoffrey                      ', N'Strong                        ', CAST(N'2014-01-08' AS Date), 2600.0000, 61, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (63, N'Nasim                         ', N'Mercado                       ', CAST(N'2011-12-01' AS Date), 2606.0000, 12, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (64, N'Bruce                         ', N'Marsh                         ', CAST(N'2011-01-09' AS Date), 2902.0000, 64, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (65, N'Andrew                        ', N'Brown                         ', CAST(N'2009-08-04' AS Date), 2106.0000, 60, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (66, N'Samuel                        ', N'Mayo                          ', CAST(N'2013-07-14' AS Date), 2646.0000, 27, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (67, N'Clarke                        ', N'Phillips                      ', CAST(N'2008-06-08' AS Date), 2702.0000, 67, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (68, N'Ivor                          ', N'Mclean                        ', CAST(N'2006-08-14' AS Date), 1819.0000, 55, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (69, N'Daniel                        ', N'Galloway                      ', CAST(N'2016-01-07' AS Date), 1216.0000, 34, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (70, N'Lester                        ', N'Cotton                        ', CAST(N'2009-03-30' AS Date), 2748.0000, 53, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (71, N'Robert                        ', N'Wilkinson                     ', CAST(N'2004-07-18' AS Date), 1442.0000, 8, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (72, N'Hector                        ', N'Gross                         ', CAST(N'2008-11-06' AS Date), 1014.0000, 94, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (73, N'Nero                          ', N'Lawson                        ', CAST(N'2007-10-10' AS Date), 2737.0000, 71, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (74, N'Igor                          ', N'Cooley                        ', CAST(N'2015-01-13' AS Date), 1597.0000, 98, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (75, N'Philip                        ', N'Barr                          ', CAST(N'2011-07-18' AS Date), 2578.0000, 93, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (76, N'Tarik                         ', N'Bond                          ', CAST(N'2004-12-09' AS Date), 1631.0000, 38, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (77, N'Emerson                       ', N'Ferguson                      ', CAST(N'2013-09-21' AS Date), 2045.0000, 95, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (78, N'Hayden                        ', N'Cantu                         ', CAST(N'2007-10-10' AS Date), 1565.0000, 12, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (79, N'Guy                           ', N'Mayo                          ', CAST(N'2013-07-29' AS Date), 1018.0000, 91, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (80, N'Joshua                        ', N'Bradford                      ', CAST(N'2016-07-05' AS Date), 1036.0000, 47, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (81, N'Fuller                        ', N'Macias                        ', CAST(N'2007-02-24' AS Date), 1900.0000, 21, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (92, N'Keegan                        ', N'Maddox                        ', CAST(N'2009-06-21' AS Date), 1143.0000, 73, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (93, N'Aquila                        ', N'Sears                         ', CAST(N'2007-09-05' AS Date), 2959.0000, 67, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (94, N'Ethan                         ', N'Walter                        ', CAST(N'2012-10-16' AS Date), 1886.0000, 4, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (95, N'Julian                        ', N'Nicholson                     ', CAST(N'2005-01-06' AS Date), 2713.0000, 41, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (96, N'Robert                        ', N'Morse                         ', CAST(N'2008-04-30' AS Date), 2661.0000, 4, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (97, N'Garrison                      ', N'Short                         ', CAST(N'2016-08-04' AS Date), 1739.0000, 33, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (98, N'Joseph                        ', N'Guthrie                       ', CAST(N'2015-08-25' AS Date), 2318.0000, 45, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (99, N'Cyrus                         ', N'Blackburn                     ', CAST(N'2009-10-23' AS Date), 1163.0000, 85, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (100, N'Flynn                         ', N'Cochran                       ', CAST(N'2012-09-09' AS Date), 2034.0000, 35, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (101, N'Hunter                        ', N'Donovan                       ', CAST(N'2009-10-04' AS Date), 2991.0000, 14, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (130, N'Denton                        ', N'Gillespie                     ', CAST(N'2010-04-03' AS Date), 2121.0000, 41, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (131, N'Barclay                       ', N'Ward                          ', CAST(N'2016-12-18' AS Date), 1744.0000, 60, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (132, N'Reed                          ', N'Maxwell                       ', CAST(N'2005-12-07' AS Date), 1180.0000, 43, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (133, N'Nash                          ', N'Montoya                       ', CAST(N'2006-05-19' AS Date), 2307.0000, 43, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (134, N'Hasad                         ', N'Morton                        ', CAST(N'2007-09-30' AS Date), 2102.0000, 77, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (135, N'Elton                         ', N'Wiggins                       ', CAST(N'2011-09-18' AS Date), 1250.0000, 56, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (136, N'Garth                         ', N'Chase                         ', CAST(N'2011-11-09' AS Date), 2183.0000, 15, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (137, N'Tad                           ', N'Barnett                       ', CAST(N'2008-03-26' AS Date), 1256.0000, 72, NULL)
INSERT [dbo].[vanzator] ([id], [nume], [prenume], [data_angajarii], [salariu], [fk_director_tehnic], [parola]) VALUES (138, N'Calvin                        ', N'Vance                         ', CAST(N'2010-02-03' AS Date), 1764.0000, 54, NULL)
SET IDENTITY_INSERT [dbo].[vanzator] OFF
ALTER TABLE [dbo].[brevet_dispozitiv]  WITH CHECK ADD  CONSTRAINT [FK_brevet_dispozitiv_tip_brevet] FOREIGN KEY([tipbrevet])
REFERENCES [dbo].[tip_brevet] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[brevet_dispozitiv] CHECK CONSTRAINT [FK_brevet_dispozitiv_tip_brevet]
GO
ALTER TABLE [dbo].[brevet_dispozitiv]  WITH CHECK ADD  CONSTRAINT [FK_mecanic] FOREIGN KEY([fk_mecanic])
REFERENCES [dbo].[mecanic] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[brevet_dispozitiv] CHECK CONSTRAINT [FK_mecanic]
GO
ALTER TABLE [dbo].[dispozitiv]  WITH CHECK ADD  CONSTRAINT [FK_dispozitiv_tip_brevet] FOREIGN KEY([brevet_necesar])
REFERENCES [dbo].[tip_brevet] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[dispozitiv] CHECK CONSTRAINT [FK_dispozitiv_tip_brevet]
GO
ALTER TABLE [dbo].[masina]  WITH CHECK ADD  CONSTRAINT [FK_masina_fabricant] FOREIGN KEY([fk_brand])
REFERENCES [dbo].[fabricant] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[masina] CHECK CONSTRAINT [FK_masina_fabricant]
GO
ALTER TABLE [dbo].[masina]  WITH CHECK ADD  CONSTRAINT [FK_masina_proprietar] FOREIGN KEY([fk_proprietar])
REFERENCES [dbo].[proprietar] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[masina] CHECK CONSTRAINT [FK_masina_proprietar]
GO
ALTER TABLE [dbo].[masina]  WITH CHECK ADD  CONSTRAINT [FK_masina_tip] FOREIGN KEY([fk_tip])
REFERENCES [dbo].[tip] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[masina] CHECK CONSTRAINT [FK_masina_tip]
GO
ALTER TABLE [dbo].[mecanic]  WITH CHECK ADD  CONSTRAINT [FK_mecanic_director_tehnic] FOREIGN KEY([fk_director])
REFERENCES [dbo].[director_tehnic] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[mecanic] CHECK CONSTRAINT [FK_mecanic_director_tehnic]
GO
ALTER TABLE [dbo].[operatie]  WITH CHECK ADD  CONSTRAINT [FK_operatie_mecanic] FOREIGN KEY([fk_mecanic])
REFERENCES [dbo].[mecanic] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[operatie] CHECK CONSTRAINT [FK_operatie_mecanic]
GO
ALTER TABLE [dbo].[operatie]  WITH CHECK ADD  CONSTRAINT [FK_operatie_piesa] FOREIGN KEY([fk_piesa], [fk_supplier])
REFERENCES [dbo].[piesa] ([nume], [fk_supplier])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[operatie] CHECK CONSTRAINT [FK_operatie_piesa]
GO
ALTER TABLE [dbo].[operatie]  WITH CHECK ADD  CONSTRAINT [FK_operatie_reparatie] FOREIGN KEY([fk_reparatie])
REFERENCES [dbo].[reparatie] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[operatie] CHECK CONSTRAINT [FK_operatie_reparatie]
GO
ALTER TABLE [dbo].[piesa]  WITH CHECK ADD  CONSTRAINT [FK_piesa_supplier1] FOREIGN KEY([fk_supplier])
REFERENCES [dbo].[supplier] ([id])
GO
ALTER TABLE [dbo].[piesa] CHECK CONSTRAINT [FK_piesa_supplier1]
GO
ALTER TABLE [dbo].[reparatie]  WITH CHECK ADD  CONSTRAINT [FK_reparatie_masina] FOREIGN KEY([fk_masina])
REFERENCES [dbo].[masina] ([vin])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[reparatie] CHECK CONSTRAINT [FK_reparatie_masina]
GO
ALTER TABLE [dbo].[utilizare_dispozitiv]  WITH CHECK ADD  CONSTRAINT [FK_utilizare_dispozitiv_dispozitiv] FOREIGN KEY([fk_dispozitiv])
REFERENCES [dbo].[dispozitiv] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[utilizare_dispozitiv] CHECK CONSTRAINT [FK_utilizare_dispozitiv_dispozitiv]
GO
ALTER TABLE [dbo].[utilizare_dispozitiv]  WITH CHECK ADD  CONSTRAINT [FK_utilizare_dispozitiv_mecanic] FOREIGN KEY([fk_mecanic])
REFERENCES [dbo].[mecanic] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[utilizare_dispozitiv] CHECK CONSTRAINT [FK_utilizare_dispozitiv_mecanic]
GO
ALTER TABLE [dbo].[vanzare]  WITH CHECK ADD  CONSTRAINT [FK_vanzare_angajat] FOREIGN KEY([fk_angajat])
REFERENCES [dbo].[vanzator] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[vanzare] CHECK CONSTRAINT [FK_vanzare_angajat]
GO
ALTER TABLE [dbo].[vanzare]  WITH CHECK ADD  CONSTRAINT [FK_vanzare_piesa] FOREIGN KEY([fk_nume_piesa], [fk_supplier_piesa])
REFERENCES [dbo].[piesa] ([nume], [fk_supplier])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[vanzare] CHECK CONSTRAINT [FK_vanzare_piesa]
GO
ALTER TABLE [dbo].[vanzare]  WITH CHECK ADD  CONSTRAINT [FK_vanzare_proprietar] FOREIGN KEY([fk_proprietar])
REFERENCES [dbo].[proprietar] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[vanzare] CHECK CONSTRAINT [FK_vanzare_proprietar]
GO
ALTER TABLE [dbo].[vanzator]  WITH CHECK ADD  CONSTRAINT [FK_Vanzator_Directortehnic] FOREIGN KEY([fk_director_tehnic])
REFERENCES [dbo].[director_tehnic] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[vanzator] CHECK CONSTRAINT [FK_Vanzator_Directortehnic]
GO
/****** Object:  StoredProcedure [dbo].[adauga_mecanic]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[adauga_mecanic]
@nume nchar(30),@prenume nchar(30),@telefon nchar(13),@data_angajarii date,@director int
as
insert into mecanic (
nume,
prenume,
telefon,
data_angajare,
fk_director)
values(@nume,
@prenume,
@telefon,
@data_angajarii,
@director)
GO
/****** Object:  StoredProcedure [dbo].[adauga_vanzator]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--CREATE PROCEDURE   add_reparatie 
--    @vin nvarchar(50),   
--    @descriere nvarchar(80)   
--AS   
--	insert into reparatie (fk_masina,descriere)
--	values(@vin,@descriere)

-- CREATE PROCEDURE   add_operatie_withp
--    @idrepair int,
--	@fk_mec int,
--    @descrier nvarchar(40),   
--	@fk_piesa nvarchar(90),
--	@fk_supplier int   
--AS   
--	insert into operatie 
--(fk_reparatie	,
--fk_mecanic,
--descriere,
--fk_piesa,
--fk_supplier)
--	values(@idrepair,@fk_mec,@descrier,@fk_piesa,@fk_supplier)


-- CREATE PROCEDURE   add_operatie_withoutp
--    @idrepair int,
--	@fk_mec int,
--    @descrier nvarchar(40)   
	
--AS   
--	insert into operatie 
--(fk_reparatie,
--fk_mecanic,
--descriere
--)
--	values(@idrepair,@fk_mec,@descrier)

-- CREATE PROCEDURE   stergi_supplier
--   @nume nvarchar(40)
    
	
--AS   
--	delete from supplier
--	where supplier.nume=@nume

-- CREATE PROCEDURE   stergi_fabricant
--   @nume nvarchar(40)
    
	
--AS   
--	delete from fabricant
--	where fabricant.nume=@nume


-- CREATE PROCEDURE   stergi_piesa
--   @nume nvarchar(90),@idsupplier int
    
	
--AS   
--	delete from piesa
--	where piesa.nume=@nume and piesa.fk_supplier=@idsupplier


-- CREATE PROCEDURE   stergi_proprietar
--   @nume nvarchar(90),@prenume nvarchar(80)
    
	
--AS   
--	delete from proprietar
--	where proprietar.nume=@nume and proprietar.prenume=@prenume
--drop procedure stergi_dispozitiv
--go
-- CREATE PROCEDURE   stergi_dispozitiv
--   @id int
    
	
--AS   
--	delete from dispozitiv
--	where dispozitiv.id=id


-- CREATE PROCEDURE   stergi_mecanic
--   @id int
    
	
--AS   
--	delete from mecanic
--	where mecanic.id=id


-- CREATE PROCEDURE   cauta_client
--   @nume nvarchar(50),@prenume nvarchar(50)
    
	
--AS   
--	select * from proprietar
--	where proprietar.nume=@nume and proprietar.prenume=prenume


--create procedure adauga_mecanic
--@nume nchar(30),@prenume nchar(30),@telefon nchar(13),@data_angajarii date,@director int
--as
--insert into mecanic (
--nume,
--prenume,
--telefon,
--data_angajare,
--fk_director)
--values(@nume,
--@prenume,
--@telefon,
--@data_angajarii,
--@director)

create procedure [dbo].[adauga_vanzator]
@nume nchar(30),@prenume nchar(30),@data_angajarii date,@salariu money,@director int
as
insert into vanzator(
nume,
prenume,
data_angajarii,
salariu,
fk_director_tehnic)
values(@nume,
@prenume,
@data_angajarii,
@salariu,
@director)

GO
/****** Object:  StoredProcedure [dbo].[Add_Brevet]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Add_Brevet]
    @fk_masina nvarchar(50),   
    @descriere nchar(80)   
AS   


INSERT INTO brevet_dispozitiv
VALUES (@fk_masina,@descriere);
    
GO
/****** Object:  StoredProcedure [dbo].[Add_Client]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Add_Client]
    @nume nchar(80), @prenume nchar(80), @telefon nchar(30) ,@nrcard nchar(20)
AS   
	IF @nrcard is not null   
      INSERT INTO proprietar
VALUES (@nume,@prenume,@telefon,@nrcard);


	     
 ELSE   
 INSERT INTO proprietar (nume,prenume,telefon)
     VALUES (@nume,@prenume,@telefon);

GO
/****** Object:  StoredProcedure [dbo].[Add_fabricant]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--CREATE PROCEDURE Add_Brevet
--    @fk_masina nvarchar(50),   
--    @descriere nchar(80)   
--AS   


--INSERT INTO brevet_dispozitiv
--VALUES (@fk_masina,@descriere);
    
--GO  
CREATE PROCEDURE [dbo].[Add_fabricant]
    @nume nvarchar(20) ,
	@nr_telefon nchar(10)
   
AS   


INSERT INTO fabricant
VALUES (@nume,@nr_telefon);
    
GO
/****** Object:  StoredProcedure [dbo].[add_operatie_withoutp]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--CREATE PROCEDURE   add_reparatie 
--    @vin nvarchar(50),   
--    @descriere nvarchar(80)   
--AS   
--	insert into reparatie (fk_masina,descriere)
--	values(@vin,@descriere)

-- CREATE PROCEDURE   add_operatie_withp
--    @idrepair int,
--	@fk_mec int,
--    @descrier nvarchar(40),   
--	@fk_piesa nvarchar(90),
--	@fk_supplier int   
--AS   
--	insert into operatie 
--(fk_reparatie	,
--fk_mecanic,
--descriere,
--fk_piesa,
--fk_supplier)
--	values(@idrepair,@fk_mec,@descrier,@fk_piesa,@fk_supplier)


 CREATE PROCEDURE   [dbo].[add_operatie_withoutp]
    @idrepair int,
	@fk_mec int,
    @descrier nvarchar(40)   
	
AS   
	insert into operatie 
(fk_reparatie,
fk_mecanic,
descriere
)
	values(@idrepair,@fk_mec,@descrier)
GO
/****** Object:  StoredProcedure [dbo].[add_operatie_withp]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE   [dbo].[add_operatie_withp]
    @idrepair int,
	@fk_mec int,
    @descrier nvarchar(40),   
	@fk_piesa nvarchar(90),
	@fk_supplier int   
AS   
	insert into operatie 
(fk_reparatie	,
fk_mecanic,
descriere,
fk_piesa,
fk_supplier)
	values(@idrepair,@fk_mec,@descrier,@fk_piesa,@fk_supplier)
GO
/****** Object:  StoredProcedure [dbo].[add_password_]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[add_password_]
	@password nchar(40),-- Add the parameters for the stored procedure here
	@nume nchar(30),
	@prenume nchar(30)

	
AS
BEGIN
	
	update vanzator
	set parola=@password
	where @nume=nume and @prenume=prenume
END
GO
/****** Object:  StoredProcedure [dbo].[add_password_dir_tehnic]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[add_password_dir_tehnic]
	@password nchar(40),-- Add the parameters for the stored procedure here
	@nume nchar(130),
	@prenume nchar(130)

	
AS
BEGIN
	
	update director_tehnic
	set password=@password
	where @nume=nume and @prenume=prenume
END
GO
/****** Object:  StoredProcedure [dbo].[add_password_mecanic]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[add_password_mecanic]
	@password nchar(40),-- Add the parameters for the stored procedure here
	@nume nchar(40),
	@prenume nchar(40)

	
AS
BEGIN
	
	update mecanic
	set password=@password
	where @nume=nume and @prenume=prenume
END
GO
/****** Object:  StoredProcedure [dbo].[add_piese]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--CREATE PROCEDURE   add_reparatie 
--    @vin nvarchar(50),   
--    @descriere nvarchar(80)   
--AS   
--	insert into reparatie (fk_masina,descriere)
--	values(@vin,@descriere)

-- CREATE PROCEDURE   add_operatie_withp
--    @idrepair int,
--	@fk_mec int,
--    @descrier nvarchar(40),   
--	@fk_piesa nvarchar(90),
--	@fk_supplier int   
--AS   
--	insert into operatie 
--(fk_reparatie	,
--fk_mecanic,
--descriere,
--fk_piesa,
--fk_supplier)
--	values(@idrepair,@fk_mec,@descrier,@fk_piesa,@fk_supplier)


-- CREATE PROCEDURE   add_operatie_withoutp
--    @idrepair int,
--	@fk_mec int,
--    @descrier nvarchar(40)   
	
--AS   
--	insert into operatie 
--(fk_reparatie,
--fk_mecanic,
--descriere
--)
--	values(@idrepair,@fk_mec,@descrier)

-- CREATE PROCEDURE   stergi_supplier
--   @nume nvarchar(40)
    
	
--AS   
--	delete from supplier
--	where supplier.nume=@nume

-- CREATE PROCEDURE   stergi_fabricant
--   @nume nvarchar(40)
    
	
--AS   
--	delete from fabricant
--	where fabricant.nume=@nume


-- CREATE PROCEDURE   stergi_piesa
--   @nume nvarchar(90),@idsupplier int
    
	
--AS   
--	delete from piesa
--	where piesa.nume=@nume and piesa.fk_supplier=@idsupplier


-- CREATE PROCEDURE   stergi_proprietar
--   @nume nvarchar(90),@prenume nvarchar(80)
    
	
--AS   
--	delete from proprietar
--	where proprietar.nume=@nume and proprietar.prenume=@prenume
--drop procedure stergi_dispozitiv
--go
-- CREATE PROCEDURE   stergi_dispozitiv
--   @id int
    
	
--AS   
--	delete from dispozitiv
--	where dispozitiv.id=id


-- CREATE PROCEDURE   stergi_mecanic
--   @id int
    
	
--AS   
--	delete from mecanic
--	where mecanic.id=id


-- CREATE PROCEDURE   cauta_client
--   @nume nvarchar(50),@prenume nvarchar(50)
    
	
--AS   
--	select * from proprietar
--	where proprietar.nume=@nume and proprietar.prenume=prenume


--create procedure adauga_mecanic
--@nume nchar(30),@prenume nchar(30),@telefon nchar(13),@data_angajarii date,@director int
--as
--insert into mecanic (
--nume,
--prenume,
--telefon,
--data_angajare,
--fk_director)
--values(@nume,
--@prenume,
--@telefon,
--@data_angajarii,
--@director)

--create procedure adauga_vanzator
--@nume nchar(30),@prenume nchar(30),@data_angajarii date,@salariu money,@director int
--as
--insert into vanzator(
--nume,
--prenume,
--data_angajarii,
--salariu,
--fk_director_tehnic)
--values(@nume,
--@prenume,
--@data_angajarii,
--@salariu,
--@director)

--create procedure monit_mecanic
--as
--select * from mecanic
--inner join operatie on operatie.fk_mecanic=mecanic.id
--inner join reparatie on reparatie.id=operatie.fk_reparatie

--create procedure monit_vanzator
--as
--select * from vanzator
--inner join vanzare on vanzare.fk_angajat=vanzator.id

--create procedure stocul_pieselor
--as
--select * from piesa


--create procedure operatii_reparatii
--as
--select * from reparatie
--inner join operatie on reparatie.id=operatie.fk_reparatie


--create procedure monit_mecanic
--as
--select * from mecanic
--inner join operatie on operatie.fk_mecanic=mecanic.id
--inner join reparatie on reparatie.id=operatie.fk_reparatie


--create procedure add_fabricant
--@nume nchar(20),@nrtelefon nchar(10)
--as
--insert into fabricant(
--nume,nr_telefon)
--values(@nume,
--@nrtelefon)

create procedure [dbo].[add_piese]
@nume nchar(20),@cantitate int,@fk_sup int
as
insert into piesa(
nume,cantitate,fk_supplier)
values(@nume,
@cantitate,@fk_sup)
GO
/****** Object:  StoredProcedure [dbo].[add_reparatie]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE   [dbo].[add_reparatie] 
    @vin nvarchar(50),   
    @descriere nvarchar(80)   
AS   
	insert into reparatie (fk_masina,descriere)
	values(@vin,@descriere)

 
GO
/****** Object:  StoredProcedure [dbo].[add_supplier]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[add_supplier]
    (@nume varchar(40),@telefon varchar(40))
As
Begin
   insert into supplier(nume,telefon)
   values (@nume,@telefon)
	end
GO
/****** Object:  StoredProcedure [dbo].[Add_tipmasina]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--CREATE PROCEDURE Add_Brevet
--    @fk_masina nvarchar(50),   
--    @descriere nchar(80)   
--AS   


--INSERT INTO brevet_dispozitiv
--VALUES (@fk_masina,@descriere);
    
--GO  
CREATE PROCEDURE [dbo].[Add_tipmasina]
    @nume nvarchar(30) 
   
AS   


INSERT INTO tip
VALUES (@nume);
    
GO
/****** Object:  StoredProcedure [dbo].[Add_Vanzare]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Add_Vanzare]
    @angajat int, @proprietar int , @nume_piesa nchar(80) ,@amount int,@fk_supplier int
AS   
	  
      INSERT INTO vanzare
VALUES (@angajat,@proprietar,@nume_piesa,@amount,@fk_supplier);

	  
GO
/****** Object:  StoredProcedure [dbo].[addtipbrevet]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[addtipbrevet]
	-- Add the parameters for the stored procedure here
	@tip nchar(30)
AS
BEGIN
	insert into tip_brevet values (@tip)
END
GO
/****** Object:  StoredProcedure [dbo].[cauta_client]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE   [dbo].[cauta_client]
   @nume nvarchar(50),@prenume nvarchar(50)
    
	
AS   
	select * from proprietar
	where proprietar.nume=@nume and proprietar.prenume=prenume
GO
/****** Object:  StoredProcedure [dbo].[cauta_dupa_nume]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Create Procedure searchvin
--    (@vin varchar(50))
--As
--Begin
--   select* from masina
--   inner join proprietar on proprietar.id=masina.fk_proprietar
--   inner join tip on masina.fk_tip=tip.id
--   inner join fabricant on masina.fk_brand=fabricant.id
--    where masina.vin=@vin
--	end


--exec searchvin '1660080537899'


--Create Procedure search_piese_disponibile
    
--As
--Begin
--   select* from piesa
--   inner join supplier on fk_supplier=piesa.fk_supplier
--   where piesa.cantitate>0
   
--	end



--Create Procedure search_piese_nume
--    (@nume varchar(90))
--As
--Begin
--   select* from piesa
--   inner join supplier on fk_supplier=piesa.fk_supplier
--   where piesa.nume=@nume
--	end

--Create Procedure toate_operatiile_masinii
--    (@vin varchar(50))
--As
--Begin
--   select* from operatie
--   inner join reparatie on fk_reparatie=reparatie.id
--   where fk_masina=@vin
--	end

Create Procedure [dbo].[cauta_dupa_nume]
    (@nume varchar(80),@prenume varchar(80))
As
Begin
   select* from proprietar
   inner join masina on proprietar.id=masina.fk_proprietar
    inner join tip on tip.id=masina.fk_tip
	 inner join fabricant on fabricant.id=masina.fk_brand
   where proprietar.nume=@nume and proprietar.prenume=@prenume
	end
GO
/****** Object:  StoredProcedure [dbo].[cauta_piese_dupa_clienti]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create Procedure [dbo].[cauta_piese_dupa_clienti]
    @nume nchar(40), @prenume nchar(40)
As
Begin
   select* from piesa
   inner join vanzare on piesa.fk_supplier=vanzare.id and piesa.nume=vanzare.fk_nume_piesa
   inner join proprietar on proprietar.id=vanzare.fk_nume_piesa
   where proprietar.nume=@nume and proprietar.prenume=@prenume
   
	end
GO
/****** Object:  StoredProcedure [dbo].[cauta_piese_dupa_furnizor]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create Procedure [dbo].[cauta_piese_dupa_furnizor]
    @nume nchar(40)
As
Begin
   select* from piesa
   inner join supplier on supplier.id=piesa.fk_supplier
   where supplier.nume=@nume
   
	end
GO
/****** Object:  StoredProcedure [dbo].[cauta_piese_dupa_nume]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create Procedure [dbo].[cauta_piese_dupa_nume]
    @nume nchar(40)
As
Begin
   select* from piesa
  
   where piesa.nume=@nume
   
	end
GO
/****** Object:  StoredProcedure [dbo].[delete_fabricant]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Create Procedure delete_supplier
--(@nume varchar(40))
--As
--Begin
--DECLARE @v1 int
--DECLARE @v2 int

--select v1=count(*)from
--  (select * from supplier where supplier.nume=@nume ) t
--  DELETE FROM supplier
--where supplier.nume=@nume and not exists (select * from piesa where piesa.fk_supplier=supplier.id)
--select v2=count(*) from
--  (select * from supplier where supplier.nume=@nume ) t
-- if (@v1>@v2)
--  return 'not present'
-- else return 'well done'
--end

Create Procedure [dbo].[delete_fabricant]
(@nume varchar(40))
As
Begin
DECLARE @v1 int
DECLARE @v2 int

select v1=count(*)from
  (select * from fabricant where fabricant.nume=@nume ) t
  DELETE FROM fabricant
where fabricant.nume=@nume and not exists (select * from masina where masina.fk_brand=fabricant.id)
select v2=count(*) from
  (select * from fabricant where fabricant.nume=@nume ) t
 if (@v1>@v2)
  return 'not present'
 else return 'well done'
end
GO
/****** Object:  StoredProcedure [dbo].[delete_supplier]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[delete_supplier]
(@nume varchar(40))
As
Begin
DECLARE @v1 int
DECLARE @v2 int

select v1=count(*)from
  (select * from supplier where supplier.nume=@nume ) t
  DELETE FROM supplier
where supplier.nume=@nume and not exists (select * from piesa where piesa.fk_supplier=supplier.id)
select v2=count(*) from
  (select * from supplier where supplier.nume=@nume ) t
 if (@v1>@v2)
  return 'not working'
 else return 'well done'
end
GO
/****** Object:  StoredProcedure [dbo].[fabricant_dupasupplier]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--CREATE PROCEDURE Add_Brevet
--    @fk_masina nvarchar(50),   
--    @descriere nchar(80)   
--AS   


--INSERT INTO brevet_dispozitiv
--VALUES (@fk_masina,@descriere);
    
--GO  
--CREATE PROCEDURE Add_fabricant
--    @nume nvarchar(20) ,
--	@nr_telefon nchar(10)
   
--AS   


--INSERT INTO fabricant
--VALUES (@nume,@nr_telefon);
    
--GO  
CREATE PROCEDURE [dbo].[fabricant_dupasupplier]
    @nume nvarchar(40) 
	
   
AS   

select * from piesa
inner join supplier on piesa.fk_supplier= supplier.id
where supplier.nume=@nume
    
GO
/****** Object:  StoredProcedure [dbo].[Masini_Nereparate]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Masini_Nereparate]   
AS   
select * from masina where masina.vin not in(select fk_masina from reparatie ) 
GO
/****** Object:  StoredProcedure [dbo].[monit_mecanic]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--CREATE PROCEDURE   add_reparatie 
--    @vin nvarchar(50),   
--    @descriere nvarchar(80)   
--AS   
--	insert into reparatie (fk_masina,descriere)
--	values(@vin,@descriere)

-- CREATE PROCEDURE   add_operatie_withp
--    @idrepair int,
--	@fk_mec int,
--    @descrier nvarchar(40),   
--	@fk_piesa nvarchar(90),
--	@fk_supplier int   
--AS   
--	insert into operatie 
--(fk_reparatie	,
--fk_mecanic,
--descriere,
--fk_piesa,
--fk_supplier)
--	values(@idrepair,@fk_mec,@descrier,@fk_piesa,@fk_supplier)


-- CREATE PROCEDURE   add_operatie_withoutp
--    @idrepair int,
--	@fk_mec int,
--    @descrier nvarchar(40)   
	
--AS   
--	insert into operatie 
--(fk_reparatie,
--fk_mecanic,
--descriere
--)
--	values(@idrepair,@fk_mec,@descrier)

-- CREATE PROCEDURE   stergi_supplier
--   @nume nvarchar(40)
    
	
--AS   
--	delete from supplier
--	where supplier.nume=@nume

-- CREATE PROCEDURE   stergi_fabricant
--   @nume nvarchar(40)
    
	
--AS   
--	delete from fabricant
--	where fabricant.nume=@nume


-- CREATE PROCEDURE   stergi_piesa
--   @nume nvarchar(90),@idsupplier int
    
	
--AS   
--	delete from piesa
--	where piesa.nume=@nume and piesa.fk_supplier=@idsupplier


-- CREATE PROCEDURE   stergi_proprietar
--   @nume nvarchar(90),@prenume nvarchar(80)
    
	
--AS   
--	delete from proprietar
--	where proprietar.nume=@nume and proprietar.prenume=@prenume
--drop procedure stergi_dispozitiv
--go
-- CREATE PROCEDURE   stergi_dispozitiv
--   @id int
    
	
--AS   
--	delete from dispozitiv
--	where dispozitiv.id=id


-- CREATE PROCEDURE   stergi_mecanic
--   @id int
    
	
--AS   
--	delete from mecanic
--	where mecanic.id=id


-- CREATE PROCEDURE   cauta_client
--   @nume nvarchar(50),@prenume nvarchar(50)
    
	
--AS   
--	select * from proprietar
--	where proprietar.nume=@nume and proprietar.prenume=prenume


--create procedure adauga_mecanic
--@nume nchar(30),@prenume nchar(30),@telefon nchar(13),@data_angajarii date,@director int
--as
--insert into mecanic (
--nume,
--prenume,
--telefon,
--data_angajare,
--fk_director)
--values(@nume,
--@prenume,
--@telefon,
--@data_angajarii,
--@director)

--create procedure adauga_vanzator
--@nume nchar(30),@prenume nchar(30),@data_angajarii date,@salariu money,@director int
--as
--insert into vanzator(
--nume,
--prenume,
--data_angajarii,
--salariu,
--fk_director_tehnic)
--values(@nume,
--@prenume,
--@data_angajarii,
--@salariu,
--@director)

create procedure [dbo].[monit_mecanic]
as
select * from mecanic
inner join operatie on operatie.fk_mecanic=mecanic.id
inner join reparatie on reparatie.id=operatie.fk_reparatie
GO
/****** Object:  StoredProcedure [dbo].[monit_vanzator]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--CREATE PROCEDURE   add_reparatie 
--    @vin nvarchar(50),   
--    @descriere nvarchar(80)   
--AS   
--	insert into reparatie (fk_masina,descriere)
--	values(@vin,@descriere)

-- CREATE PROCEDURE   add_operatie_withp
--    @idrepair int,
--	@fk_mec int,
--    @descrier nvarchar(40),   
--	@fk_piesa nvarchar(90),
--	@fk_supplier int   
--AS   
--	insert into operatie 
--(fk_reparatie	,
--fk_mecanic,
--descriere,
--fk_piesa,
--fk_supplier)
--	values(@idrepair,@fk_mec,@descrier,@fk_piesa,@fk_supplier)


-- CREATE PROCEDURE   add_operatie_withoutp
--    @idrepair int,
--	@fk_mec int,
--    @descrier nvarchar(40)   
	
--AS   
--	insert into operatie 
--(fk_reparatie,
--fk_mecanic,
--descriere
--)
--	values(@idrepair,@fk_mec,@descrier)

-- CREATE PROCEDURE   stergi_supplier
--   @nume nvarchar(40)
    
	
--AS   
--	delete from supplier
--	where supplier.nume=@nume

-- CREATE PROCEDURE   stergi_fabricant
--   @nume nvarchar(40)
    
	
--AS   
--	delete from fabricant
--	where fabricant.nume=@nume


-- CREATE PROCEDURE   stergi_piesa
--   @nume nvarchar(90),@idsupplier int
    
	
--AS   
--	delete from piesa
--	where piesa.nume=@nume and piesa.fk_supplier=@idsupplier


-- CREATE PROCEDURE   stergi_proprietar
--   @nume nvarchar(90),@prenume nvarchar(80)
    
	
--AS   
--	delete from proprietar
--	where proprietar.nume=@nume and proprietar.prenume=@prenume
--drop procedure stergi_dispozitiv
--go
-- CREATE PROCEDURE   stergi_dispozitiv
--   @id int
    
	
--AS   
--	delete from dispozitiv
--	where dispozitiv.id=id


-- CREATE PROCEDURE   stergi_mecanic
--   @id int
    
	
--AS   
--	delete from mecanic
--	where mecanic.id=id


-- CREATE PROCEDURE   cauta_client
--   @nume nvarchar(50),@prenume nvarchar(50)
    
	
--AS   
--	select * from proprietar
--	where proprietar.nume=@nume and proprietar.prenume=prenume


--create procedure adauga_mecanic
--@nume nchar(30),@prenume nchar(30),@telefon nchar(13),@data_angajarii date,@director int
--as
--insert into mecanic (
--nume,
--prenume,
--telefon,
--data_angajare,
--fk_director)
--values(@nume,
--@prenume,
--@telefon,
--@data_angajarii,
--@director)

--create procedure adauga_vanzator
--@nume nchar(30),@prenume nchar(30),@data_angajarii date,@salariu money,@director int
--as
--insert into vanzator(
--nume,
--prenume,
--data_angajarii,
--salariu,
--fk_director_tehnic)
--values(@nume,
--@prenume,
--@data_angajarii,
--@salariu,
--@director)

--create procedure monit_mecanic
--as
--select * from mecanic
--inner join operatie on operatie.fk_mecanic=mecanic.id
--inner join reparatie on reparatie.id=operatie.fk_reparatie

create procedure [dbo].[monit_vanzator]
as
select * from vanzator
inner join vanzare on vanzare.fk_angajat=vanzator.id
GO
/****** Object:  StoredProcedure [dbo].[operatii_reparatii]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--CREATE PROCEDURE   add_reparatie 
--    @vin nvarchar(50),   
--    @descriere nvarchar(80)   
--AS   
--	insert into reparatie (fk_masina,descriere)
--	values(@vin,@descriere)

-- CREATE PROCEDURE   add_operatie_withp
--    @idrepair int,
--	@fk_mec int,
--    @descrier nvarchar(40),   
--	@fk_piesa nvarchar(90),
--	@fk_supplier int   
--AS   
--	insert into operatie 
--(fk_reparatie	,
--fk_mecanic,
--descriere,
--fk_piesa,
--fk_supplier)
--	values(@idrepair,@fk_mec,@descrier,@fk_piesa,@fk_supplier)


-- CREATE PROCEDURE   add_operatie_withoutp
--    @idrepair int,
--	@fk_mec int,
--    @descrier nvarchar(40)   
	
--AS   
--	insert into operatie 
--(fk_reparatie,
--fk_mecanic,
--descriere
--)
--	values(@idrepair,@fk_mec,@descrier)

-- CREATE PROCEDURE   stergi_supplier
--   @nume nvarchar(40)
    
	
--AS   
--	delete from supplier
--	where supplier.nume=@nume

-- CREATE PROCEDURE   stergi_fabricant
--   @nume nvarchar(40)
    
	
--AS   
--	delete from fabricant
--	where fabricant.nume=@nume


-- CREATE PROCEDURE   stergi_piesa
--   @nume nvarchar(90),@idsupplier int
    
	
--AS   
--	delete from piesa
--	where piesa.nume=@nume and piesa.fk_supplier=@idsupplier


-- CREATE PROCEDURE   stergi_proprietar
--   @nume nvarchar(90),@prenume nvarchar(80)
    
	
--AS   
--	delete from proprietar
--	where proprietar.nume=@nume and proprietar.prenume=@prenume
--drop procedure stergi_dispozitiv
--go
-- CREATE PROCEDURE   stergi_dispozitiv
--   @id int
    
	
--AS   
--	delete from dispozitiv
--	where dispozitiv.id=id


-- CREATE PROCEDURE   stergi_mecanic
--   @id int
    
	
--AS   
--	delete from mecanic
--	where mecanic.id=id


-- CREATE PROCEDURE   cauta_client
--   @nume nvarchar(50),@prenume nvarchar(50)
    
	
--AS   
--	select * from proprietar
--	where proprietar.nume=@nume and proprietar.prenume=prenume


--create procedure adauga_mecanic
--@nume nchar(30),@prenume nchar(30),@telefon nchar(13),@data_angajarii date,@director int
--as
--insert into mecanic (
--nume,
--prenume,
--telefon,
--data_angajare,
--fk_director)
--values(@nume,
--@prenume,
--@telefon,
--@data_angajarii,
--@director)

--create procedure adauga_vanzator
--@nume nchar(30),@prenume nchar(30),@data_angajarii date,@salariu money,@director int
--as
--insert into vanzator(
--nume,
--prenume,
--data_angajarii,
--salariu,
--fk_director_tehnic)
--values(@nume,
--@prenume,
--@data_angajarii,
--@salariu,
--@director)

--create procedure monit_mecanic
--as
--select * from mecanic
--inner join operatie on operatie.fk_mecanic=mecanic.id
--inner join reparatie on reparatie.id=operatie.fk_reparatie

--create procedure monit_vanzator
--as
--select * from vanzator
--inner join vanzare on vanzare.fk_angajat=vanzator.id

--create procedure stocul_pieselor
--as
--select * from piesa


create procedure [dbo].[operatii_reparatii]
as
select * from reparatie
inner join operatie on reparatie.id=operatie.fk_reparatie
GO
/****** Object:  StoredProcedure [dbo].[piese_nume]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--CREATE PROCEDURE   add_reparatie 
--    @vin nvarchar(50),   
--    @descriere nvarchar(80)   
--AS   
--	insert into reparatie (fk_masina,descriere)
--	values(@vin,@descriere)

-- CREATE PROCEDURE   add_operatie_withp
--    @idrepair int,
--	@fk_mec int,
--    @descrier nvarchar(40),   
--	@fk_piesa nvarchar(90),
--	@fk_supplier int   
--AS   
--	insert into operatie 
--(fk_reparatie	,
--fk_mecanic,
--descriere,
--fk_piesa,
--fk_supplier)
--	values(@idrepair,@fk_mec,@descrier,@fk_piesa,@fk_supplier)


-- CREATE PROCEDURE   add_operatie_withoutp
--    @idrepair int,
--	@fk_mec int,
--    @descrier nvarchar(40)   
	
--AS   
--	insert into operatie 
--(fk_reparatie,
--fk_mecanic,
--descriere
--)
--	values(@idrepair,@fk_mec,@descrier)

-- CREATE PROCEDURE   stergi_supplier
--   @nume nvarchar(40)
    
	
--AS   
--	delete from supplier
--	where supplier.nume=@nume

-- CREATE PROCEDURE   stergi_fabricant
--   @nume nvarchar(40)
    
	
--AS   
--	delete from fabricant
--	where fabricant.nume=@nume


-- CREATE PROCEDURE   stergi_piesa
--   @nume nvarchar(90),@idsupplier int
    
	
--AS   
--	delete from piesa
--	where piesa.nume=@nume and piesa.fk_supplier=@idsupplier


-- CREATE PROCEDURE   stergi_proprietar
--   @nume nvarchar(90),@prenume nvarchar(80)
    
	
--AS   
--	delete from proprietar
--	where proprietar.nume=@nume and proprietar.prenume=@prenume
--drop procedure stergi_dispozitiv
--go
-- CREATE PROCEDURE   stergi_dispozitiv
--   @id int
    
	
--AS   
--	delete from dispozitiv
--	where dispozitiv.id=id


-- CREATE PROCEDURE   stergi_mecanic
--   @id int
    
	
--AS   
--	delete from mecanic
--	where mecanic.id=id


-- CREATE PROCEDURE   cauta_client
--   @nume nvarchar(50),@prenume nvarchar(50)
    
	
--AS   
--	select * from proprietar
--	where proprietar.nume=@nume and proprietar.prenume=prenume


--create procedure adauga_mecanic
--@nume nchar(30),@prenume nchar(30),@telefon nchar(13),@data_angajarii date,@director int
--as
--insert into mecanic (
--nume,
--prenume,
--telefon,
--data_angajare,
--fk_director)
--values(@nume,
--@prenume,
--@telefon,
--@data_angajarii,
--@director)

--create procedure adauga_vanzator
--@nume nchar(30),@prenume nchar(30),@data_angajarii date,@salariu money,@director int
--as
--insert into vanzator(
--nume,
--prenume,
--data_angajarii,
--salariu,
--fk_director_tehnic)
--values(@nume,
--@prenume,
--@data_angajarii,
--@salariu,
--@director)

--create procedure monit_mecanic
--as
--select * from mecanic
--inner join operatie on operatie.fk_mecanic=mecanic.id
--inner join reparatie on reparatie.id=operatie.fk_reparatie

--create procedure monit_vanzator
--as
--select * from vanzator
--inner join vanzare on vanzare.fk_angajat=vanzator.id

--create procedure stocul_pieselor
--as
--select * from piesa


--create procedure operatii_reparatii
--as
--select * from reparatie
--inner join operatie on reparatie.id=operatie.fk_reparatie


--create procedure monit_mecanic
--as
--select * from mecanic
--inner join operatie on operatie.fk_mecanic=mecanic.id
--inner join reparatie on reparatie.id=operatie.fk_reparatie


--create procedure add_fabricant
--@nume nchar(20),@nrtelefon nchar(10)
--as
--insert into fabricant(
--nume,nr_telefon)
--values(@nume,
--@nrtelefon)

--create procedure add_piese
--@nume nchar(20),@cantitate int,@fk_sup int
--as
--insert into piesa(
--nume,cantitate,fk_supplier)
--values(@nume,
--@cantitate,@fk_sup)

create procedure [dbo].[piese_nume]
@nume nchar(90)
as
select * from piesa
where piesa.nume=@nume
GO
/****** Object:  StoredProcedure [dbo].[piese_supplier]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--CREATE PROCEDURE   add_reparatie 
--    @vin nvarchar(50),   
--    @descriere nvarchar(80)   
--AS   
--	insert into reparatie (fk_masina,descriere)
--	values(@vin,@descriere)

-- CREATE PROCEDURE   add_operatie_withp
--    @idrepair int,
--	@fk_mec int,
--    @descrier nvarchar(40),   
--	@fk_piesa nvarchar(90),
--	@fk_supplier int   
--AS   
--	insert into operatie 
--(fk_reparatie	,
--fk_mecanic,
--descriere,
--fk_piesa,
--fk_supplier)
--	values(@idrepair,@fk_mec,@descrier,@fk_piesa,@fk_supplier)


-- CREATE PROCEDURE   add_operatie_withoutp
--    @idrepair int,
--	@fk_mec int,
--    @descrier nvarchar(40)   
	
--AS   
--	insert into operatie 
--(fk_reparatie,
--fk_mecanic,
--descriere
--)
--	values(@idrepair,@fk_mec,@descrier)

-- CREATE PROCEDURE   stergi_supplier
--   @nume nvarchar(40)
    
	
--AS   
--	delete from supplier
--	where supplier.nume=@nume

-- CREATE PROCEDURE   stergi_fabricant
--   @nume nvarchar(40)
    
	
--AS   
--	delete from fabricant
--	where fabricant.nume=@nume


-- CREATE PROCEDURE   stergi_piesa
--   @nume nvarchar(90),@idsupplier int
    
	
--AS   
--	delete from piesa
--	where piesa.nume=@nume and piesa.fk_supplier=@idsupplier


-- CREATE PROCEDURE   stergi_proprietar
--   @nume nvarchar(90),@prenume nvarchar(80)
    
	
--AS   
--	delete from proprietar
--	where proprietar.nume=@nume and proprietar.prenume=@prenume
--drop procedure stergi_dispozitiv
--go
-- CREATE PROCEDURE   stergi_dispozitiv
--   @id int
    
	
--AS   
--	delete from dispozitiv
--	where dispozitiv.id=id


-- CREATE PROCEDURE   stergi_mecanic
--   @id int
    
	
--AS   
--	delete from mecanic
--	where mecanic.id=id


-- CREATE PROCEDURE   cauta_client
--   @nume nvarchar(50),@prenume nvarchar(50)
    
	
--AS   
--	select * from proprietar
--	where proprietar.nume=@nume and proprietar.prenume=prenume


--create procedure adauga_mecanic
--@nume nchar(30),@prenume nchar(30),@telefon nchar(13),@data_angajarii date,@director int
--as
--insert into mecanic (
--nume,
--prenume,
--telefon,
--data_angajare,
--fk_director)
--values(@nume,
--@prenume,
--@telefon,
--@data_angajarii,
--@director)

--create procedure adauga_vanzator
--@nume nchar(30),@prenume nchar(30),@data_angajarii date,@salariu money,@director int
--as
--insert into vanzator(
--nume,
--prenume,
--data_angajarii,
--salariu,
--fk_director_tehnic)
--values(@nume,
--@prenume,
--@data_angajarii,
--@salariu,
--@director)

--create procedure monit_mecanic
--as
--select * from mecanic
--inner join operatie on operatie.fk_mecanic=mecanic.id
--inner join reparatie on reparatie.id=operatie.fk_reparatie

--create procedure monit_vanzator
--as
--select * from vanzator
--inner join vanzare on vanzare.fk_angajat=vanzator.id

--create procedure stocul_pieselor
--as
--select * from piesa


--create procedure operatii_reparatii
--as
--select * from reparatie
--inner join operatie on reparatie.id=operatie.fk_reparatie


--create procedure monit_mecanic
--as
--select * from mecanic
--inner join operatie on operatie.fk_mecanic=mecanic.id
--inner join reparatie on reparatie.id=operatie.fk_reparatie


--create procedure add_fabricant
--@nume nchar(20),@nrtelefon nchar(10)
--as
--insert into fabricant(
--nume,nr_telefon)
--values(@nume,
--@nrtelefon)

--create procedure add_piese
--@nume nchar(20),@cantitate int,@fk_sup int
--as
--insert into piesa(
--nume,cantitate,fk_supplier)
--values(@nume,
--@cantitate,@fk_sup)

--create procedure piese_nume
--@nume nchar(90)
--as
--select * from piesa
--where piesa.nume=@nume


create procedure [dbo].[piese_supplier]
@nume nchar(90)
as
select * from piesa
inner join supplier on supplier.id=piesa.fk_supplier
where supplier.nume=@nume
GO
/****** Object:  StoredProcedure [dbo].[piese_vandute]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--CREATE PROCEDURE   add_reparatie 
--    @vin nvarchar(50),   
--    @descriere nvarchar(80)   
--AS   
--	insert into reparatie (fk_masina,descriere)
--	values(@vin,@descriere)

-- CREATE PROCEDURE   add_operatie_withp
--    @idrepair int,
--	@fk_mec int,
--    @descrier nvarchar(40),   
--	@fk_piesa nvarchar(90),
--	@fk_supplier int   
--AS   
--	insert into operatie 
--(fk_reparatie	,
--fk_mecanic,
--descriere,
--fk_piesa,
--fk_supplier)
--	values(@idrepair,@fk_mec,@descrier,@fk_piesa,@fk_supplier)


-- CREATE PROCEDURE   add_operatie_withoutp
--    @idrepair int,
--	@fk_mec int,
--    @descrier nvarchar(40)   
	
--AS   
--	insert into operatie 
--(fk_reparatie,
--fk_mecanic,
--descriere
--)
--	values(@idrepair,@fk_mec,@descrier)

-- CREATE PROCEDURE   stergi_supplier
--   @nume nvarchar(40)
    
	
--AS   
--	delete from supplier
--	where supplier.nume=@nume

-- CREATE PROCEDURE   stergi_fabricant
--   @nume nvarchar(40)
    
	
--AS   
--	delete from fabricant
--	where fabricant.nume=@nume


-- CREATE PROCEDURE   stergi_piesa
--   @nume nvarchar(90),@idsupplier int
    
	
--AS   
--	delete from piesa
--	where piesa.nume=@nume and piesa.fk_supplier=@idsupplier


-- CREATE PROCEDURE   stergi_proprietar
--   @nume nvarchar(90),@prenume nvarchar(80)
    
	
--AS   
--	delete from proprietar
--	where proprietar.nume=@nume and proprietar.prenume=@prenume
--drop procedure stergi_dispozitiv
--go
-- CREATE PROCEDURE   stergi_dispozitiv
--   @id int
    
	
--AS   
--	delete from dispozitiv
--	where dispozitiv.id=id


-- CREATE PROCEDURE   stergi_mecanic
--   @id int
    
	
--AS   
--	delete from mecanic
--	where mecanic.id=id


-- CREATE PROCEDURE   cauta_client
--   @nume nvarchar(50),@prenume nvarchar(50)
    
	
--AS   
--	select * from proprietar
--	where proprietar.nume=@nume and proprietar.prenume=prenume


--create procedure adauga_mecanic
--@nume nchar(30),@prenume nchar(30),@telefon nchar(13),@data_angajarii date,@director int
--as
--insert into mecanic (
--nume,
--prenume,
--telefon,
--data_angajare,
--fk_director)
--values(@nume,
--@prenume,
--@telefon,
--@data_angajarii,
--@director)

--create procedure adauga_vanzator
--@nume nchar(30),@prenume nchar(30),@data_angajarii date,@salariu money,@director int
--as
--insert into vanzator(
--nume,
--prenume,
--data_angajarii,
--salariu,
--fk_director_tehnic)
--values(@nume,
--@prenume,
--@data_angajarii,
--@salariu,
--@director)

--create procedure monit_mecanic
--as
--select * from mecanic
--inner join operatie on operatie.fk_mecanic=mecanic.id
--inner join reparatie on reparatie.id=operatie.fk_reparatie

--create procedure monit_vanzator
--as
--select * from vanzator
--inner join vanzare on vanzare.fk_angajat=vanzator.id

--create procedure stocul_pieselor
--as
--select * from piesa


--create procedure operatii_reparatii
--as
--select * from reparatie
--inner join operatie on reparatie.id=operatie.fk_reparatie


--create procedure monit_mecanic
--as
--select * from mecanic
--inner join operatie on operatie.fk_mecanic=mecanic.id
--inner join reparatie on reparatie.id=operatie.fk_reparatie


--create procedure add_fabricant
--@nume nchar(20),@nrtelefon nchar(10)
--as
--insert into fabricant(
--nume,nr_telefon)
--values(@nume,
--@nrtelefon)

--create procedure add_piese
--@nume nchar(20),@cantitate int,@fk_sup int
--as
--insert into piesa(
--nume,cantitate,fk_supplier)
--values(@nume,
--@cantitate,@fk_sup)

--create procedure piese_nume
--@nume nchar(90)
--as
--select * from piesa
--where piesa.nume=@nume


--create procedure piese_supplier
--@nume nchar(90)
--as
--select * from piesa
--inner join supplier on supplier.id=piesa.fk_supplier
--where supplier.nume=@nume

create procedure [dbo].[piese_vandute]
as
select * from piesa
where piesa.nume in (select vanzare.fk_nume_piesa from vanzare where vanzare.fk_supplier_piesa=piesa.fk_supplier)
GO
/****** Object:  StoredProcedure [dbo].[search_piese_disponibile]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Create Procedure searchvin
--    (@vin varchar(50))
--As
--Begin
--   select* from masina
--   inner join proprietar on proprietar.id=masina.fk_proprietar
--   inner join tip on masina.fk_tip=tip.id
--   inner join fabricant on masina.fk_brand=fabricant.id
--    where masina.vin=@vin
--	end


--exec searchvin '1660080537899'


CREATE Procedure [dbo].[search_piese_disponibile]
    
As
Begin
   select* from piesa
   left join supplier on piesa.fk_supplier=supplier.id
   where piesa.cantitate>0
   
	end
GO
/****** Object:  StoredProcedure [dbo].[search_piese_nume]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[search_piese_nume]
    (@nume varchar(90))
As
Begin
   select* from piesa
   inner join supplier on supplier.id=piesa.fk_supplier
   where piesa.nume=@nume
	end
GO
/****** Object:  StoredProcedure [dbo].[searchvin]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[searchvin]
    (@vin varchar(50))
As
Begin
   select* from masina
   inner join proprietar on proprietar.id=masina.fk_proprietar
   inner join tip on masina.fk_tip=tip.id
   inner join fabricant on masina.fk_brand=fabricant.id
    where masina.vin=@vin
End
GO
/****** Object:  StoredProcedure [dbo].[stergi_dispozitiv]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE   [dbo].[stergi_dispozitiv]
   @id int
    
	
AS   
	delete from dispozitiv
	where dispozitiv.id=id
GO
/****** Object:  StoredProcedure [dbo].[stergi_fabricant]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--CREATE PROCEDURE   add_reparatie 
--    @vin nvarchar(50),   
--    @descriere nvarchar(80)   
--AS   
--	insert into reparatie (fk_masina,descriere)
--	values(@vin,@descriere)

-- CREATE PROCEDURE   add_operatie_withp
--    @idrepair int,
--	@fk_mec int,
--    @descrier nvarchar(40),   
--	@fk_piesa nvarchar(90),
--	@fk_supplier int   
--AS   
--	insert into operatie 
--(fk_reparatie	,
--fk_mecanic,
--descriere,
--fk_piesa,
--fk_supplier)
--	values(@idrepair,@fk_mec,@descrier,@fk_piesa,@fk_supplier)


-- CREATE PROCEDURE   add_operatie_withoutp
--    @idrepair int,
--	@fk_mec int,
--    @descrier nvarchar(40)   
	
--AS   
--	insert into operatie 
--(fk_reparatie,
--fk_mecanic,
--descriere
--)
--	values(@idrepair,@fk_mec,@descrier)

-- CREATE PROCEDURE   stergi_supplier
--   @nume nvarchar(40)
    
	
--AS   
--	delete from supplier
--	where supplier.nume=@nume

 CREATE PROCEDURE   [dbo].[stergi_fabricant]
   @nume nvarchar(40)
    
	
AS   
	delete from fabricant
	where fabricant.nume=@nume
GO
/****** Object:  StoredProcedure [dbo].[stergi_mecanic]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--CREATE PROCEDURE   add_reparatie 
--    @vin nvarchar(50),   
--    @descriere nvarchar(80)   
--AS   
--	insert into reparatie (fk_masina,descriere)
--	values(@vin,@descriere)

-- CREATE PROCEDURE   add_operatie_withp
--    @idrepair int,
--	@fk_mec int,
--    @descrier nvarchar(40),   
--	@fk_piesa nvarchar(90),
--	@fk_supplier int   
--AS   
--	insert into operatie 
--(fk_reparatie	,
--fk_mecanic,
--descriere,
--fk_piesa,
--fk_supplier)
--	values(@idrepair,@fk_mec,@descrier,@fk_piesa,@fk_supplier)


-- CREATE PROCEDURE   add_operatie_withoutp
--    @idrepair int,
--	@fk_mec int,
--    @descrier nvarchar(40)   
	
--AS   
--	insert into operatie 
--(fk_reparatie,
--fk_mecanic,
--descriere
--)
--	values(@idrepair,@fk_mec,@descrier)

-- CREATE PROCEDURE   stergi_supplier
--   @nume nvarchar(40)
    
	
--AS   
--	delete from supplier
--	where supplier.nume=@nume

-- CREATE PROCEDURE   stergi_fabricant
--   @nume nvarchar(40)
    
	
--AS   
--	delete from fabricant
--	where fabricant.nume=@nume


-- CREATE PROCEDURE   stergi_piesa
--   @nume nvarchar(90),@idsupplier int
    
	
--AS   
--	delete from piesa
--	where piesa.nume=@nume and piesa.fk_supplier=@idsupplier


-- CREATE PROCEDURE   stergi_proprietar
--   @nume nvarchar(90),@prenume nvarchar(80)
    
	
--AS   
--	delete from proprietar
--	where proprietar.nume=@nume and proprietar.prenume=@prenume
--drop procedure stergi_dispozitiv
--go
-- CREATE PROCEDURE   stergi_dispozitiv
--   @id int
    
	
--AS   
--	delete from dispozitiv
--	where dispozitiv.id=id


 CREATE PROCEDURE   [dbo].[stergi_mecanic]
   @id int
    
	
AS   
	delete from mecanic
	where mecanic.id=id
GO
/****** Object:  StoredProcedure [dbo].[stergi_piesa]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--CREATE PROCEDURE   add_reparatie 
--    @vin nvarchar(50),   
--    @descriere nvarchar(80)   
--AS   
--	insert into reparatie (fk_masina,descriere)
--	values(@vin,@descriere)

-- CREATE PROCEDURE   add_operatie_withp
--    @idrepair int,
--	@fk_mec int,
--    @descrier nvarchar(40),   
--	@fk_piesa nvarchar(90),
--	@fk_supplier int   
--AS   
--	insert into operatie 
--(fk_reparatie	,
--fk_mecanic,
--descriere,
--fk_piesa,
--fk_supplier)
--	values(@idrepair,@fk_mec,@descrier,@fk_piesa,@fk_supplier)


-- CREATE PROCEDURE   add_operatie_withoutp
--    @idrepair int,
--	@fk_mec int,
--    @descrier nvarchar(40)   
	
--AS   
--	insert into operatie 
--(fk_reparatie,
--fk_mecanic,
--descriere
--)
--	values(@idrepair,@fk_mec,@descrier)

-- CREATE PROCEDURE   stergi_supplier
--   @nume nvarchar(40)
    
	
--AS   
--	delete from supplier
--	where supplier.nume=@nume

-- CREATE PROCEDURE   stergi_fabricant
--   @nume nvarchar(40)
    
	
--AS   
--	delete from fabricant
--	where fabricant.nume=@nume


 CREATE PROCEDURE   [dbo].[stergi_piesa]
   @nume nvarchar(90),@idsupplier int
    
	
AS   
	delete from piesa
	where piesa.nume=@nume and piesa.fk_supplier=@idsupplier
GO
/****** Object:  StoredProcedure [dbo].[stergi_proprietar]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--CREATE PROCEDURE   add_reparatie 
--    @vin nvarchar(50),   
--    @descriere nvarchar(80)   
--AS   
--	insert into reparatie (fk_masina,descriere)
--	values(@vin,@descriere)

-- CREATE PROCEDURE   add_operatie_withp
--    @idrepair int,
--	@fk_mec int,
--    @descrier nvarchar(40),   
--	@fk_piesa nvarchar(90),
--	@fk_supplier int   
--AS   
--	insert into operatie 
--(fk_reparatie	,
--fk_mecanic,
--descriere,
--fk_piesa,
--fk_supplier)
--	values(@idrepair,@fk_mec,@descrier,@fk_piesa,@fk_supplier)


-- CREATE PROCEDURE   add_operatie_withoutp
--    @idrepair int,
--	@fk_mec int,
--    @descrier nvarchar(40)   
	
--AS   
--	insert into operatie 
--(fk_reparatie,
--fk_mecanic,
--descriere
--)
--	values(@idrepair,@fk_mec,@descrier)

-- CREATE PROCEDURE   stergi_supplier
--   @nume nvarchar(40)
    
	
--AS   
--	delete from supplier
--	where supplier.nume=@nume

-- CREATE PROCEDURE   stergi_fabricant
--   @nume nvarchar(40)
    
	
--AS   
--	delete from fabricant
--	where fabricant.nume=@nume


-- CREATE PROCEDURE   stergi_piesa
--   @nume nvarchar(90),@idsupplier int
    
	
--AS   
--	delete from piesa
--	where piesa.nume=@nume and piesa.fk_supplier=@idsupplier


 CREATE PROCEDURE   [dbo].[stergi_proprietar]
   @nume nvarchar(90),@prenume nvarchar(80)
    
	
AS   
	delete from proprietar
	where proprietar.nume=@nume and proprietar.prenume=@prenume
GO
/****** Object:  StoredProcedure [dbo].[stergi_supplier]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--CREATE PROCEDURE   add_reparatie 
--    @vin nvarchar(50),   
--    @descriere nvarchar(80)   
--AS   
--	insert into reparatie (fk_masina,descriere)
--	values(@vin,@descriere)

-- CREATE PROCEDURE   add_operatie_withp
--    @idrepair int,
--	@fk_mec int,
--    @descrier nvarchar(40),   
--	@fk_piesa nvarchar(90),
--	@fk_supplier int   
--AS   
--	insert into operatie 
--(fk_reparatie	,
--fk_mecanic,
--descriere,
--fk_piesa,
--fk_supplier)
--	values(@idrepair,@fk_mec,@descrier,@fk_piesa,@fk_supplier)


-- CREATE PROCEDURE   add_operatie_withoutp
--    @idrepair int,
--	@fk_mec int,
--    @descrier nvarchar(40)   
	
--AS   
--	insert into operatie 
--(fk_reparatie,
--fk_mecanic,
--descriere
--)
--	values(@idrepair,@fk_mec,@descrier)

 CREATE PROCEDURE   [dbo].[stergi_supplier]
   @nume nvarchar(40)
    
	
AS   
	delete from supplier
	where supplier.nume=@nume
GO
/****** Object:  StoredProcedure [dbo].[Stocul_pieselor]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--CREATE PROCEDURE Add_Brevet
--    @fk_masina nvarchar(50),   
--    @descriere nchar(80)   
--AS   


--INSERT INTO brevet_dispozitiv
--VALUES (@fk_masina,@descriere);
    
--GO  
CREATE PROCEDURE [dbo].[Stocul_pieselor] 
AS   


select * from piesa
    
GO
/****** Object:  StoredProcedure [dbo].[toate_masinile]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[toate_masinile]
As
Begin
   select* from masina
end
--Create Procedure searchvin
--    (@vin varchar(50))
--As
--Begin
--   select* from masina
--   inner join proprietar on proprietar.id=masina.fk_proprietar
--   inner join tip on masina.fk_tip=tip.id
--   inner join fabricant on masina.fk_brand=fabricant.id
--    where masina.vin=@vin
--	end


--exec searchvin '1660080537899'


--Create Procedure search_piese_disponibile
    
--As
--Begin
--   select* from piesa
--   inner join supplier on fk_supplier=piesa.fk_supplier
--   where piesa.cantitate>0
   
--	end



--Create Procedure search_piese_nume
--    (@nume varchar(90))
--As
--Begin
--   select* from piesa
--   inner join supplier on fk_supplier=piesa.fk_supplier
--   where piesa.nume=@nume
--	end

--Create Procedure toate_operatiile_masinii
--    (@vin varchar(50))
--As
--Begin
--   select* from operatie
--   inner join reparatie on fk_reparatie=reparatie.id
--   where fk_masina=@vin
--	end

--Create Procedure cauta_dupa_nume
--    (@nume varchar(80),@prenume varchar(80))
--As
--Begin
--   select* from proprietar
--   inner join masina on proprietar.id=masina.fk_proprietar
--    inner join tip on tip.id=masina.fk_tip
--	 inner join fabricant on fabricant.id=masina.fk_brand
--   where proprietar.nume=@nume and proprietar.prenume=@prenume
--	end

GO
/****** Object:  StoredProcedure [dbo].[toate_operatiile_masinii]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[toate_operatiile_masinii]
    (@vin varchar(50))
As
Begin
   select* from operatie
   inner join reparatie on fk_reparatie=reparatie.id
   where fk_masina=@vin
	end
GO
/****** Object:  StoredProcedure [dbo].[toate_piesele_vandute]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create Procedure [dbo].[toate_piesele_vandute]
As
Begin
   select piesa.nume, sum(amount)  from piesa
   inner join vanzare on piesa.fk_supplier=vanzare.fk_supplier_piesa and piesa.nume=vanzare.fk_nume_piesa
   group by piesa.nume
   
	end
GO
/****** Object:  StoredProcedure [dbo].[vezi_vanzare]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--CREATE PROCEDURE   add_reparatie 
--    @vin nvarchar(50),   
--    @descriere nvarchar(80)   
--AS   
--	insert into reparatie (fk_masina,descriere)
--	values(@vin,@descriere)

-- CREATE PROCEDURE   add_operatie_withp
--    @idrepair int,
--	@fk_mec int,
--    @descrier nvarchar(40),   
--	@fk_piesa nvarchar(90),
--	@fk_supplier int   
--AS   
--	insert into operatie 
--(fk_reparatie	,
--fk_mecanic,
--descriere,
--fk_piesa,
--fk_supplier)
--	values(@idrepair,@fk_mec,@descrier,@fk_piesa,@fk_supplier)


-- CREATE PROCEDURE   add_operatie_withoutp
--    @idrepair int,
--	@fk_mec int,
--    @descrier nvarchar(40)   
	
--AS   
--	insert into operatie 
--(fk_reparatie,
--fk_mecanic,
--descriere
--)
--	values(@idrepair,@fk_mec,@descrier)

-- CREATE PROCEDURE   stergi_supplier
--   @nume nvarchar(40)
    
	
--AS   
--	delete from supplier
--	where supplier.nume=@nume

-- CREATE PROCEDURE   stergi_fabricant
--   @nume nvarchar(40)
    
	
--AS   
--	delete from fabricant
--	where fabricant.nume=@nume


-- CREATE PROCEDURE   stergi_piesa
--   @nume nvarchar(90),@idsupplier int
    
	
--AS   
--	delete from piesa
--	where piesa.nume=@nume and piesa.fk_supplier=@idsupplier


-- CREATE PROCEDURE   stergi_proprietar
--   @nume nvarchar(90),@prenume nvarchar(80)
    
	
--AS   
--	delete from proprietar
--	where proprietar.nume=@nume and proprietar.prenume=@prenume
--drop procedure stergi_dispozitiv
--go
-- CREATE PROCEDURE   stergi_dispozitiv
--   @id int
    
	
--AS   
--	delete from dispozitiv
--	where dispozitiv.id=id


-- CREATE PROCEDURE   stergi_mecanic
--   @id int
    
	
--AS   
--	delete from mecanic
--	where mecanic.id=id


-- CREATE PROCEDURE   cauta_client
--   @nume nvarchar(50),@prenume nvarchar(50)
    
	
--AS   
--	select * from proprietar
--	where proprietar.nume=@nume and proprietar.prenume=prenume


--create procedure adauga_mecanic
--@nume nchar(30),@prenume nchar(30),@telefon nchar(13),@data_angajarii date,@director int
--as
--insert into mecanic (
--nume,
--prenume,
--telefon,
--data_angajare,
--fk_director)
--values(@nume,
--@prenume,
--@telefon,
--@data_angajarii,
--@director)

--create procedure adauga_vanzator
--@nume nchar(30),@prenume nchar(30),@data_angajarii date,@salariu money,@director int
--as
--insert into vanzator(
--nume,
--prenume,
--data_angajarii,
--salariu,
--fk_director_tehnic)
--values(@nume,
--@prenume,
--@data_angajarii,
--@salariu,
--@director)

--create procedure monit_mecanic
--as
--select * from mecanic
--inner join operatie on operatie.fk_mecanic=mecanic.id
--inner join reparatie on reparatie.id=operatie.fk_reparatie

--create procedure monit_vanzator
--as
--select * from vanzator
--inner join vanzare on vanzare.fk_angajat=vanzator.id

--create procedure stocul_pieselor
--as
--select * from piesa


--create procedure operatii_reparatii
--as
--select * from reparatie
--inner join operatie on reparatie.id=operatie.fk_reparatie


--create procedure monit_mecanic
--as
--select * from mecanic
--inner join operatie on operatie.fk_mecanic=mecanic.id
--inner join reparatie on reparatie.id=operatie.fk_reparatie


--create procedure add_fabricant
--@nume nchar(20),@nrtelefon nchar(10)
--as
--insert into fabricant(
--nume,nr_telefon)
--values(@nume,
--@nrtelefon)

--create procedure add_piese
--@nume nchar(20),@cantitate int,@fk_sup int
--as
--insert into piesa(
--nume,cantitate,fk_supplier)
--values(@nume,
--@cantitate,@fk_sup)

--create procedure piese_nume
--@nume nchar(90)
--as
--select * from piesa
--where piesa.nume=@nume


--create procedure piese_supplier
--@nume nchar(90)
--as
--select * from piesa
--inner join supplier on supplier.id=piesa.fk_supplier
--where supplier.nume=@nume

--create procedure piese_vandute
--as
--select * from piesa
--where piesa.nume in (select vanzare.fk_nume_piesa from vanzare where vanzare.fk_supplier_piesa=piesa.fk_supplier)


create procedure [dbo].[vezi_vanzare]
as
select * from vanzare
GO
/****** Object:  Trigger [dbo].[update_reparatie]    Script Date: 1/12/2018 1:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--create TRIGGER update_piesa
--ON piesa
--after  update
--AS
--BEGIN
--DECLARE @OldDoctorNumber INT, @NewdoctorNumber  INT

--  SELECT @OldDoctorNumber =cantitate FROM deleted
--SELECT @NewdoctorNumber =cantitate FROM inserted
--  if(@NewDoctorNumber<0)
--  rollback transaction 
--END;
--drop trigger sub_trg


--create TRIGGER update_vanzare
--ON vanzare
--after insert
--AS
--BEGIN
--DECLARE  @amount  INT,@fk_supplier  INT,@fk_nume_piesa nchar(90)

  
--SELECT @amount =amount,@fk_supplier=fk_supplier_piesa,@fk_nume_piesa=fk_nume_piesa FROM inserted
-- if(@amount<=(select top 1 cantitate from piesa where piesa.fk_supplier=@fk_supplier and piesa.nume=@fk_nume_piesa))
-- rollback transaction
-- else
-- update piesa
-- set cantitate=cantitate-@amount
-- where piesa.fk_supplier=@fk_supplier and piesa.nume=@fk_nume_piesa
--END;
--SELECT * FROM sys.triggers



CREATE TRIGGER [dbo].[update_reparatie]
ON [dbo].[operatie]
after insert
AS
BEGIN
DECLARE @fk_supplier  INT,@fk_nume_piesa nchar(90)

  
SELECT @fk_supplier=fk_supplier,@fk_nume_piesa=fk_piesa FROM inserted
 if(1>(select top 1 cantitate from piesa where piesa.fk_supplier=@fk_supplier and piesa.nume=@fk_nume_piesa))
 rollback transaction
 else
 update piesa
 set cantitate=cantitate-1
 where piesa.fk_supplier=@fk_supplier and piesa.nume=@fk_nume_piesa
END;
GO
ALTER TABLE [dbo].[operatie] ENABLE TRIGGER [update_reparatie]
GO
/****** Object:  Trigger [dbo].[update_piesa]    Script Date: 1/12/2018 1:59:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[update_piesa]
ON [dbo].[piesa]
after  update
AS
BEGIN
DECLARE @OldDoctorNumber INT, @NewdoctorNumber  INT

  SELECT @OldDoctorNumber =cantitate FROM deleted
SELECT @NewdoctorNumber =cantitate FROM inserted
  if(@NewDoctorNumber<0)
  rollback transaction 
END;
GO
ALTER TABLE [dbo].[piesa] ENABLE TRIGGER [update_piesa]
GO
/****** Object:  Trigger [dbo].[update_vanzare]    Script Date: 1/12/2018 1:59:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create TRIGGER [dbo].[update_vanzare]
ON [dbo].[vanzare]
after insert
AS
BEGIN
DECLARE  @amount  INT,@fk_supplier  INT,@fk_nume_piesa nchar(90)

  
SELECT @amount =amount,@fk_supplier=fk_supplier_piesa,@fk_nume_piesa=fk_nume_piesa FROM inserted
 if(@amount<=(select top 1 cantitate from piesa where piesa.fk_supplier=@fk_supplier and piesa.nume=@fk_nume_piesa))
 rollback transaction
 else
 update piesa
 set cantitate=cantitate-@amount
 where piesa.fk_supplier=@fk_supplier and piesa.nume=@fk_nume_piesa
END;
SELECT * FROM sys.triggers
GO
ALTER TABLE [dbo].[vanzare] ENABLE TRIGGER [update_vanzare]
GO
