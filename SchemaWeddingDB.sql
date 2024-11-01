USE [master]
GO
/****** Object:  Database [Wedding]    Script Date: 09/10/24 17:58:40 ******/
CREATE DATABASE [Wedding]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Wedding', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.IT\MSSQL\DATA\Wedding.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Wedding_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.IT\MSSQL\DATA\Wedding_log.ldf' , SIZE = 6272KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Wedding] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Wedding].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Wedding] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Wedding] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Wedding] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Wedding] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Wedding] SET ARITHABORT OFF 
GO
ALTER DATABASE [Wedding] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Wedding] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Wedding] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Wedding] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Wedding] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Wedding] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Wedding] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Wedding] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Wedding] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Wedding] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Wedding] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Wedding] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Wedding] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Wedding] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Wedding] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Wedding] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Wedding] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Wedding] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Wedding] SET RECOVERY FULL 
GO
ALTER DATABASE [Wedding] SET  MULTI_USER 
GO
ALTER DATABASE [Wedding] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Wedding] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Wedding] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Wedding] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Wedding', N'ON'
GO
USE [Wedding]
GO
/****** Object:  StoredProcedure [dbo].[CodigoDetalle_Insert]    Script Date: 09/10/24 17:58:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Allan Varela>
-- Create date: <25/08/2021>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CodigoDetalle_Insert]
	-- Add the parameters for the stored procedure here
	
	
	@CodigoMaster varchar(20)=NULL,
	@Nombre varchar(50)=NULL,
	@Apellido varchar(50)=NULL,
	@RequiereHabitacion bit=NULL,
	@Activo bit=NULL

	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	    -- Insert statements for procedure here
	Insert into CodigoDetalle(
[CodigoMaster],
[Nombre],
[Apellido],
[RequiereHabitacion],
[Activo]
	)
	Values(
	@CodigoMaster,
	@Nombre,
	@Apellido,
	@RequiereHabitacion,
	@Activo
	)

	declare @cuposDisponibles int
	declare @registrosActuales int
	select @registrosActuales= [RegistrosActuales] from CodigoMaster where Codigo=@CodigoMaster
	set @cuposDisponibles=@registrosActuales+1
	update CodigoMaster set RegistrosActuales=@cuposDisponibles where Codigo=@CodigoMaster

END
GO
/****** Object:  StoredProcedure [dbo].[CodigoDetalle_Select]    Script Date: 09/10/24 17:58:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Allan Varela>
-- Create date: <25/08/2021>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CodigoDetalle_Select]
	-- Add the parameters for the stored procedure here
	
	@Id int=null,
	@CodigoMaster varchar(20)=NULL,
	@Nombre varchar(50)=NULL,
	@Apellido varchar(50)=NULL,
	@RequiereHabitacion bit=NULL,
	@Activo bit=NULL

	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	    -- Insert statements for procedure here
	Select Id,
	CodigoMaster,
	Nombre,
	Apellido,
	RequiereHabitacion,
	Activo
 from CodigoDetalle
 where (@Id IS NULL OR @Id=Id)
   AND (@CodigoMaster IS NULL OR @CodigoMaster=CodigoMaster)
   AND (@Nombre IS NULL OR @Nombre=Nombre)
   AND (@Apellido IS NULL OR @Apellido=Apellido)
   AND (@RequiereHabitacion IS NULL OR @RequiereHabitacion=RequiereHabitacion)
   AND (@Activo IS NULL OR @Activo=Activo)
END
GO
/****** Object:  StoredProcedure [dbo].[CodigoMaster_Select]    Script Date: 09/10/24 17:58:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:  ArVarela
-- Create date: 29/04/2020
-- =============================================
CREATE PROCEDURE [dbo].[CodigoMaster_Select]
  @Codigo varchar(50),
	@Familia varchar(50)=NULL,
	@Limite int=NULL,
	@RegistrosActuales int=NULL,
	@Activo bit=NULL
AS
 SET NOCOUNT OFF;

    SELECT Codigo,
	Familia,
	Limite,
	RegistrosActuales,
	Activo
    FROM CodigoMaster
    WHERE (@Codigo IS NULL OR @Codigo=Codigo)
   AND (@Familia IS NULL OR @Familia=Familia)
   AND (@Limite IS NULL OR @Limite=Limite)
   AND (@RegistrosActuales IS NULL OR @RegistrosActuales=RegistrosActuales)
   AND (@Activo IS NULL OR @Activo=Activo)

-- =====EXISTS==================================
SET ANSI_NULLS ON

GO
/****** Object:  StoredProcedure [dbo].[CodigoMaster_Update]    Script Date: 09/10/24 17:58:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:  Allan Varela
-- Create date: 09/abril/2020
-- =============================================
CREATE PROCEDURE [dbo].[CodigoMaster_Update]
	@Codigo varchar(50),
	@Familia varchar(50),
	@Limite int,
	@RegistrosActuales int,
	@Activo bit
AS
 SET NOCOUNT OFF;

    UPDATE CodigoMaster SET 
	--Codigo=@Codigo,
	Familia=@Familia,
	Limite=@Limite,
	RegistrosActuales=@RegistrosActuales,
	Activo=@Activo
    WHERE ( Codigo=@Codigo)

-- =====SELECT==================================
SET ANSI_NULLS ON
GO
/****** Object:  Table [dbo].[CodigoDetalle]    Script Date: 09/10/24 17:58:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CodigoDetalle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CodigoMaster] [varchar](20) NOT NULL,
	[Nombre] [varchar](50) NULL,
	[Apellido] [varchar](50) NULL,
	[RequiereHabitacion] [bit] NULL,
	[Activo] [bit] NULL,
 CONSTRAINT [PK_CodigoDetalle] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CodigoMaster]    Script Date: 09/10/24 17:58:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CodigoMaster](
	[Codigo] [varchar](20) NULL,
	[Familia] [varchar](50) NULL,
	[Limite] [int] NULL,
	[RegistrosActuales] [int] NULL,
	[Activo] [bit] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
USE [master]
GO
ALTER DATABASE [Wedding] SET  READ_WRITE 
GO
