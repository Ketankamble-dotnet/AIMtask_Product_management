USE [master]
GO
/****** Object:  Database [Product_Management]    Script Date: 3/28/2025 6:05:31 PM ******/
CREATE DATABASE [Product_Management]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Product_Management', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Product_Management.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Product_Management_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Product_Management_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Product_Management] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Product_Management].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Product_Management] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Product_Management] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Product_Management] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Product_Management] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Product_Management] SET ARITHABORT OFF 
GO
ALTER DATABASE [Product_Management] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Product_Management] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Product_Management] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Product_Management] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Product_Management] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Product_Management] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Product_Management] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Product_Management] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Product_Management] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Product_Management] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Product_Management] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Product_Management] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Product_Management] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Product_Management] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Product_Management] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Product_Management] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Product_Management] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Product_Management] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Product_Management] SET  MULTI_USER 
GO
ALTER DATABASE [Product_Management] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Product_Management] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Product_Management] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Product_Management] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Product_Management] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Product_Management] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Product_Management] SET QUERY_STORE = OFF
GO
USE [Product_Management]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 3/28/2025 6:05:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](255) NOT NULL,
	[Price] [decimal](10, 2) NOT NULL,
	[Category] [nvarchar](100) NOT NULL,
	[CreatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
/****** Object:  StoredProcedure [dbo].[SP_ManageProduct]    Script Date: 3/28/2025 6:05:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ManageProduct]
    @Id INT = NULL,
    @ProductName NVARCHAR(255) = NULL,
    @Price DECIMAL(10,2) = NULL,
    @Category NVARCHAR(100) = NULL,
    @Flag NVARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    IF @Flag = 'SELECT'
    BEGIN
SELECT * FROM Products ORDER BY Id DESC;
    END

 IF @Flag = 'INSERT'
    BEGIN
        INSERT INTO Products (ProductName, Price, Category, CreatedDate)
        VALUES (@ProductName, @Price, @Category, GETDATE());
    END

   IF @Flag = 'UPDATE'
    BEGIN
        UPDATE Products
        SET ProductName = @ProductName, Price = @Price, Category = @Category
        WHERE Id = @Id;
    END

    IF @Flag = 'DELETE'
    BEGIN
        DELETE FROM Products WHERE Id = @Id;
    END
END
GO
USE [master]
GO
ALTER DATABASE [Product_Management] SET  READ_WRITE 
GO
