/****** Object:  Database [DBA]    Script Date: 11/13/2018 2:36:47 PM ******/
CREATE DATABASE [DBA]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DBA', FILENAME = N'/var/opt/mssql/data/DBA.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DBA_log', FILENAME = N'/var/opt/mssql/data/DBA_log.ldf' , SIZE = 5120KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DBA].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DBA] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DBA] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DBA] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DBA] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DBA] SET ARITHABORT OFF 
GO
ALTER DATABASE [DBA] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DBA] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DBA] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DBA] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DBA] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DBA] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DBA] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DBA] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DBA] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DBA] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DBA] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DBA] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DBA] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DBA] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DBA] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DBA] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DBA] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DBA] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DBA] SET  MULTI_USER 
GO
ALTER DATABASE [DBA] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DBA] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DBA] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DBA] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DBA] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DBA] SET QUERY_STORE = OFF
GO
USE [DBA]
GO
ALTER DATABASE SCOPED CONFIGURATION SET ACCELERATED_PLAN_FORCING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET BATCH_MODE_ADAPTIVE_JOINS = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET BATCH_MODE_MEMORY_GRANT_FEEDBACK = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET BATCH_MODE_ON_ROWSTORE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET DEFERRED_COMPILATION_TV = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ELEVATE_ONLINE = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ELEVATE_RESUMABLE = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET GLOBAL_TEMPORARY_TABLE_AUTO_DROP = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET INTERLEAVED_EXECUTION_TVF = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ISOLATE_SECURITY_POLICY_CARDINALITY = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LIGHTWEIGHT_QUERY_PROFILING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET OPTIMIZE_FOR_AD_HOC_WORKLOADS = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ROW_MODE_MEMORY_GRANT_FEEDBACK = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET TSQL_SCALAR_UDF_INLINING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET XTP_PROCEDURE_EXECUTION_STATISTICS = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET XTP_QUERY_EXECUTION_STATISTICS = OFF;
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Database used to store SQL Server instance maintenance tasks. �Should be included on all managed SQL Server instances.' 
GO
ALTER DATABASE [DBA] SET  READ_WRITE 
GO
/****** Object:  DatabaseRole [Read_Role]    Script Date: 11/13/2018 2:36:54 PM ******/
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Read_Role' AND type = 'R')
CREATE ROLE [Read_Role]
GO
