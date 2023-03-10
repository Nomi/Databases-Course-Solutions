USE [master]
GO
/****** Object:  Database [Engines_DWH]    Script Date: 6/4/2020 8:19:10 PM ******/
CREATE DATABASE [Engines_DWH]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Engines_DWH', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Engines_DWH.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Engines_DWH_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Engines_DWH_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Engines_DWH] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Engines_DWH].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Engines_DWH] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Engines_DWH] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Engines_DWH] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Engines_DWH] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Engines_DWH] SET ARITHABORT OFF 
GO
ALTER DATABASE [Engines_DWH] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Engines_DWH] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Engines_DWH] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Engines_DWH] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Engines_DWH] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Engines_DWH] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Engines_DWH] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Engines_DWH] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Engines_DWH] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Engines_DWH] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Engines_DWH] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Engines_DWH] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Engines_DWH] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Engines_DWH] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Engines_DWH] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Engines_DWH] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Engines_DWH] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Engines_DWH] SET RECOVERY FULL 
GO
ALTER DATABASE [Engines_DWH] SET  MULTI_USER 
GO
ALTER DATABASE [Engines_DWH] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Engines_DWH] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Engines_DWH] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Engines_DWH] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Engines_DWH] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Engines_DWH', N'ON'
GO
ALTER DATABASE [Engines_DWH] SET QUERY_STORE = OFF
GO
USE [Engines_DWH]
GO
/****** Object:  Table [dbo].[Engine_Dimension]    Script Date: 6/4/2020 8:19:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Engine_Dimension](
	[surrogate_ED] [int] NOT NULL,
	[Engine_Serial] [int] NOT NULL,
	[Type] [varchar](30) NOT NULL,
	[Power] [decimal](8, 3) NOT NULL,
	[Production_Year] [decimal](4, 0) NOT NULL,
 CONSTRAINT [PK_Engine_Dimension] PRIMARY KEY CLUSTERED 
(
	[surrogate_ED] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sensor_Category_Dimension]    Script Date: 6/4/2020 8:19:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sensor_Category_Dimension](
	[surrogate_ScD] [int] NOT NULL,
	[CategoryID] [char](4) NOT NULL,
	[Category_Name] [varchar](20) NOT NULL,
	[Units] [varchar](15) NOT NULL,
	[Precision_Class] [varchar](15) NOT NULL,
 CONSTRAINT [PK_Sensor_Category_Dimension] PRIMARY KEY CLUSTERED 
(
	[surrogate_ScD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sensor_dimension]    Script Date: 6/4/2020 8:19:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sensor_dimension](
	[surrogate_SD] [int] NOT NULL,
	[Sensor_id] [int] NOT NULL,
	[sensorInstall_DateAndTIme] [datetime] NULL,
 CONSTRAINT [PK_Sensor_dimension] PRIMARY KEY CLUSTERED 
(
	[surrogate_SD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sensor_Facts]    Script Date: 6/4/2020 8:19:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sensor_Facts](
	[surrogate_SEF] [int] NOT NULL,
	[surrogate_ED] [int] NULL,
	[surrogate_SD] [int] NOT NULL,
	[surrogate_ScD] [int] NOT NULL,
	[engnum_vibration_warn] [bigint] NOT NULL,
	[engnum_overheat_warn] [bigint] NOT NULL,
	[engnum_highpressure_warn] [bigint] NOT NULL,
	[sensorTotal_registered_failures] [bigint] NOT NULL,
	[Engine_Status] [varchar](15) NULL,
	[engOperating_Mode] [varchar](15) NOT NULL,
	[sensorMeasure_DateAndTime] [datetime2](7) NULL,
	[sensorOperating_Status] [varchar](10) NOT NULL,
	[Sensor_Health_status] [varchar](10) NOT NULL,
	[sensor_Measurement_Value] [bigint] NULL,
 CONSTRAINT [PK_Sensor_Facts] PRIMARY KEY CLUSTERED 
(
	[surrogate_SEF] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Sensor_Facts]  WITH CHECK ADD  CONSTRAINT [FK_Sensor_Facts_Engine_Dimension] FOREIGN KEY([surrogate_ED])
REFERENCES [dbo].[Engine_Dimension] ([surrogate_ED])
GO
ALTER TABLE [dbo].[Sensor_Facts] CHECK CONSTRAINT [FK_Sensor_Facts_Engine_Dimension]
GO
ALTER TABLE [dbo].[Sensor_Facts]  WITH CHECK ADD  CONSTRAINT [FK_Sensor_Facts_Sensor_Category_Dimension] FOREIGN KEY([surrogate_ScD])
REFERENCES [dbo].[Sensor_Category_Dimension] ([surrogate_ScD])
GO
ALTER TABLE [dbo].[Sensor_Facts] CHECK CONSTRAINT [FK_Sensor_Facts_Sensor_Category_Dimension]
GO
ALTER TABLE [dbo].[Sensor_Facts]  WITH CHECK ADD  CONSTRAINT [FK_Sensor_Facts_Sensor_dimension] FOREIGN KEY([surrogate_SD])
REFERENCES [dbo].[Sensor_dimension] ([surrogate_SD])
GO
ALTER TABLE [dbo].[Sensor_Facts] CHECK CONSTRAINT [FK_Sensor_Facts_Sensor_dimension]
GO
USE [master]
GO
ALTER DATABASE [Engines_DWH] SET  READ_WRITE 
GO
