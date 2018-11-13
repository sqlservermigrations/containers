USE DBA
GO
/****** Object:  Schema [perms]    Script Date: 11/13/2018 3:41:13 PM ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'perms')
EXEC sys.sp_executesql N'CREATE SCHEMA [perms]'
GO
/****** Object:  UserDefinedFunction [dbo].[fn_RoundDateTime]    Script Date: 11/13/2018 3:41:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_RoundDateTime]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'

create function [dbo].[fn_RoundDateTime](
	@Interval int,
	@Time DateTime	
)
	returns DateTime
begin
	-- Always discard seconds and milliseconds.
	select @Time = dateadd(millisecond, -datepart(millisecond, @Time), @Time)
	select @Time = dateadd(second, -datepart(second, @Time), @Time)

	if @Interval > 0 select @Time = dateadd(minute, -datepart(minute, @Time), @Time)
	if @Interval > 1 select @Time = dateadd(hour, -datepart(hour, @Time), @Time)
	if @Interval > 2 select @Time = dateadd(day, 1 - datepart(day, @Time), @Time)
	if @Interval > 3 select @Time = dateadd(month, 1 -datepart(month, @Time), @Time)
	
	return @Time
end




' 
END
GO
/****** Object:  Table [perms].[Database_Permissions]    Script Date: 11/13/2018 3:41:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[perms].[Database_Permissions]') AND type in (N'U'))
BEGIN
CREATE TABLE [perms].[Database_Permissions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[snapshot_id] [int] NOT NULL,
	[state] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[state_desc] [nvarchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[permission_name] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[username] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_Perms_Database_Permissions] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [perms].[Object_Permissions]    Script Date: 11/13/2018 3:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[perms].[Object_Permissions]') AND type in (N'U'))
BEGIN
CREATE TABLE [perms].[Object_Permissions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[snapshot_id] [int] NOT NULL,
	[state] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[state_desc] [nvarchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[permission_name] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[schemaname] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[objectname] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[username] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[class_desc] [nvarchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[columnname] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_Perms_Object_Permissions] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [perms].[Role_Memberships]    Script Date: 11/13/2018 3:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[perms].[Role_Memberships]') AND type in (N'U'))
BEGIN
CREATE TABLE [perms].[Role_Memberships](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[snapshot_id] [int] NOT NULL,
	[rolename] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[username] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_Perms_Role_Memberships] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [perms].[Roles]    Script Date: 11/13/2018 3:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[perms].[Roles]') AND type in (N'U'))
BEGIN
CREATE TABLE [perms].[Roles](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[snapshot_id] [int] NOT NULL,
	[rolename] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[roletype] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[roletypedesc] [nvarchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[defaultschema] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_Perms_Roles] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [perms].[Schema_Permissions]    Script Date: 11/13/2018 3:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[perms].[Schema_Permissions]') AND type in (N'U'))
BEGIN
CREATE TABLE [perms].[Schema_Permissions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[snapshot_id] [int] NOT NULL,
	[state] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[state_desc] [nvarchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[permission_name] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[schemaname] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[username] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_Perms_Schema_Permissions] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [perms].[Snapshots]    Script Date: 11/13/2018 3:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[perms].[Snapshots]') AND type in (N'U'))
BEGIN
CREATE TABLE [perms].[Snapshots](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[databasename] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[snaptime] [datetime] NOT NULL,
 CONSTRAINT [PK_Perms_Snapshots] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [perms].[Users]    Script Date: 11/13/2018 3:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[perms].[Users]') AND type in (N'U'))
BEGIN
CREATE TABLE [perms].[Users](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[snapshot_id] [int] NOT NULL,
	[username] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[usertype] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[usertypedesc] [nvarchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[defaultschema] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[loginname] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[logintype] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[is_disabled] [int] NOT NULL,
 CONSTRAINT [PK_Perms_Users] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[perms].[FK_Perms_Database_Permissions_Snapshot]') AND parent_object_id = OBJECT_ID(N'[perms].[Database_Permissions]'))
ALTER TABLE [perms].[Database_Permissions]  WITH CHECK ADD  CONSTRAINT [FK_Perms_Database_Permissions_Snapshot] FOREIGN KEY([snapshot_id])
REFERENCES [perms].[Snapshots] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[perms].[FK_Perms_Database_Permissions_Snapshot]') AND parent_object_id = OBJECT_ID(N'[perms].[Database_Permissions]'))
ALTER TABLE [perms].[Database_Permissions] CHECK CONSTRAINT [FK_Perms_Database_Permissions_Snapshot]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[perms].[FK_Perms_Object_Permissions_Snapshot]') AND parent_object_id = OBJECT_ID(N'[perms].[Object_Permissions]'))
ALTER TABLE [perms].[Object_Permissions]  WITH CHECK ADD  CONSTRAINT [FK_Perms_Object_Permissions_Snapshot] FOREIGN KEY([snapshot_id])
REFERENCES [perms].[Snapshots] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[perms].[FK_Perms_Object_Permissions_Snapshot]') AND parent_object_id = OBJECT_ID(N'[perms].[Object_Permissions]'))
ALTER TABLE [perms].[Object_Permissions] CHECK CONSTRAINT [FK_Perms_Object_Permissions_Snapshot]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[perms].[FK_Perms_Role_Memberships_Snapshot]') AND parent_object_id = OBJECT_ID(N'[perms].[Role_Memberships]'))
ALTER TABLE [perms].[Role_Memberships]  WITH CHECK ADD  CONSTRAINT [FK_Perms_Role_Memberships_Snapshot] FOREIGN KEY([snapshot_id])
REFERENCES [perms].[Snapshots] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[perms].[FK_Perms_Role_Memberships_Snapshot]') AND parent_object_id = OBJECT_ID(N'[perms].[Role_Memberships]'))
ALTER TABLE [perms].[Role_Memberships] CHECK CONSTRAINT [FK_Perms_Role_Memberships_Snapshot]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[perms].[FK_Perms_Roles_Snapshot]') AND parent_object_id = OBJECT_ID(N'[perms].[Roles]'))
ALTER TABLE [perms].[Roles]  WITH CHECK ADD  CONSTRAINT [FK_Perms_Roles_Snapshot] FOREIGN KEY([snapshot_id])
REFERENCES [perms].[Snapshots] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[perms].[FK_Perms_Roles_Snapshot]') AND parent_object_id = OBJECT_ID(N'[perms].[Roles]'))
ALTER TABLE [perms].[Roles] CHECK CONSTRAINT [FK_Perms_Roles_Snapshot]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[perms].[FK_Perms_Schema_Permissions_Snapshot]') AND parent_object_id = OBJECT_ID(N'[perms].[Schema_Permissions]'))
ALTER TABLE [perms].[Schema_Permissions]  WITH CHECK ADD  CONSTRAINT [FK_Perms_Schema_Permissions_Snapshot] FOREIGN KEY([snapshot_id])
REFERENCES [perms].[Snapshots] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[perms].[FK_Perms_Schema_Permissions_Snapshot]') AND parent_object_id = OBJECT_ID(N'[perms].[Schema_Permissions]'))
ALTER TABLE [perms].[Schema_Permissions] CHECK CONSTRAINT [FK_Perms_Schema_Permissions_Snapshot]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[perms].[FK_Perms_Users_Snapshot]') AND parent_object_id = OBJECT_ID(N'[perms].[Users]'))
ALTER TABLE [perms].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Perms_Users_Snapshot] FOREIGN KEY([snapshot_id])
REFERENCES [perms].[Snapshots] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[perms].[FK_Perms_Users_Snapshot]') AND parent_object_id = OBJECT_ID(N'[perms].[Users]'))
ALTER TABLE [perms].[Users] CHECK CONSTRAINT [FK_Perms_Users_Snapshot]
GO
/****** Object:  StoredProcedure [perms].[uspApplyPerms]    Script Date: 11/13/2018 3:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[perms].[uspApplyPerms]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [perms].[uspApplyPerms] AS' 
END
GO





ALTER PROCEDURE [perms].[uspApplyPerms]
    @DBName sysname ,
    @SnapshotID INT = NULL ,
    @User sysname = NULL ,
    @CreateLogins BIT = 1 ,
    @ExecuteScript BIT = 0 ,				
    @DestinationDatabase sysname = NULL ,
    @AltUsernames XML = NULL	-- future functionality
AS
    SET NOCOUNT ON;

/* 
VALUE FOR @AltUsernames = 
<altusers>
	<user>
		<original>DOMAIN\abc1234</original>	-- REQUIRED. original username, as found in the perms.Users table
		<new>DOMAIN\abc1234</new>			-- REQUIRED. new username. should include domain name if appropriate - e.g. DOMAIN\Test
		<defaultschema>dbo</defaultschema>	-- OPTIONAL. default schema
		<loginname>DOMAIN\abc1234</loginname>	-- OPTIONAL. login name. Defaults to new username
		<logintype>U</logintype>			-- OPTIONAL, defaults to U. S = SQL User, U = Windows User, G = Windows Group
	</user>
</altusers>
*/

    DECLARE @SQLSTMT NVARCHAR(4000);
    DECLARE @SQLSTMT2 NVARCHAR(4000);
    DECLARE @VSnapshotID INT;

    DECLARE @CRLF NCHAR(2);
    SELECT  @CRLF = NCHAR(13) + NCHAR(10);

-- Create Temp Table
    CREATE TABLE #SQL_Results
        (
          id INT IDENTITY(1, 1)
                 NOT NULL ,
          stmt NVARCHAR(1000) NOT NULL
        );

-- Determine Correct Snapshot ID
    SELECT  @VSnapshotID = NULL;
    IF @SnapshotID IS NULL
        SELECT TOP 1
                @VSnapshotID = ID
        FROM    [perms].[Snapshots]
        WHERE   databasename = @DBName
        ORDER BY snaptime DESC;
    ELSE
        SELECT TOP 1
                @VSnapshotID = ID
        FROM    [perms].[Snapshots]
        WHERE   databasename = @DBName
                AND ID = @SnapshotID
        ORDER BY snaptime DESC;

    IF @VSnapshotID IS NULL -- STILL???
        BEGIN
            RAISERROR(N'No Valid Snapshot Available',16,1);
            RETURN;
        END;

-- Setup Alternate Usernames Capability
    CREATE TABLE #AltUsers
        (
          originaluser sysname NOT NULL ,
          newuser sysname NOT NULL ,
          defaultschema sysname NULL ,
          loginname sysname NULL ,
          logintype CHAR(1) NULL
                            DEFAULT 'U'
        );

    IF @AltUsernames IS NOT NULL
        BEGIN
            INSERT  INTO #AltUsers
                    ( originaluser ,
                      newuser ,
                      defaultschema ,
                      loginname ,
                      logintype
                    )
                    SELECT  Tbl.Col.value('original[1]', 'sysname') AS originaluser ,
                            Tbl.Col.value('new[1]', 'sysname') AS newuser ,
                            Tbl.Col.value('defaultschema[1]', 'sysname') AS newuser ,
                            Tbl.Col.value('loginname[1]', 'sysname') AS newuser ,
                            Tbl.Col.value('logintype[1]', 'char(1)') AS logintype
                    FROM    @AltUsernames.nodes('/altusers/user') Tbl ( Col );
        END;

    INSERT  INTO #AltUsers
            ( originaluser ,
              newuser ,
              defaultschema ,
              loginname ,
              logintype
            )
            SELECT  username ,
                    username ,
                    defaultschema ,
                    loginname ,
                    logintype
            FROM    perms.Users
            WHERE   username NOT IN ( SELECT    originaluser
                                      FROM      #AltUsers )
                    AND snapshot_id = @VSnapshotID;

    UPDATE  #AltUsers
    SET     #AltUsers.defaultschema = u.defaultschema
    FROM    #AltUsers
            JOIN perms.Users u ON #AltUsers.originaluser = u.username
    WHERE   #AltUsers.defaultschema IS NULL;

    UPDATE  #AltUsers
    SET     loginname = newuser
    WHERE   loginname IS NULL;

    UPDATE  #AltUsers
    SET     logintype = 'U'
    WHERE   logintype IS NULL;



    INSERT  INTO #SQL_Results
            ( stmt )
            SELECT  '-- Database: ' + @DBName;
    INSERT  INTO #SQL_Results
            ( stmt
            )
            SELECT  '-- Snapshot ID: ' + CAST(@VSnapshotID AS VARCHAR(10));

    INSERT  INTO #SQL_Results
            ( stmt )
    VALUES  ( '' );

    IF @DestinationDatabase IS NULL
        INSERT  INTO #SQL_Results
                ( stmt )
        VALUES  ( 'USE ' + @DBName + ';' );
    ELSE
        INSERT  INTO #SQL_Results
                ( stmt
                )
        VALUES  ( 'USE ' + @DestinationDatabase + ';'
                );

    INSERT  INTO #SQL_Results
            ( stmt )
    VALUES  ( '' );


-- ### LOGINS ###
    INSERT  INTO #SQL_Results
            ( stmt )
    VALUES  ( '-- ### LOGINS ###' );

-- U, S, G
    IF @CreateLogins = 1
        BEGIN
            INSERT  INTO #SQL_Results
                    ( stmt
                    )
                    SELECT  'IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'''
                            + loginname + ''') ' + 'BEGIN ' + 'CREATE LOGIN '
                            + QUOTENAME(loginname)
                            + CASE WHEN logintype = 'U' THEN ' FROM WINDOWS '
                                   WHEN logintype = 'G' THEN ' FROM WINDOWS '
                                   ELSE ' WITH PASSWORD = '
                                        + CONVERT(VARCHAR(MAX), l.password_hash, 1)
                                        + ' HASHED, SID='
                                        + CONVERT(VARCHAR(MAX), p.sid, 1)-- ALTER LOGIN ' + QUOTENAME(loginname) + ' DISABLE '
                              END + ' END'
--FROM [perms].[Users] u
                    FROM    #AltUsers u
                            INNER JOIN sys.server_principals p ON p.name = u.loginname
                            LEFT JOIN sys.sql_logins l ON l.principal_id = p.principal_id
                    WHERE   ( @User IS NULL
                              OR u.originaluser = @User
                            );
--WHERE u.snapshot_id = @VSnapshotID
-- AND (@User IS NULL OR u.username = @User);


            INSERT  INTO #SQL_Results
                    ( stmt
                    )
                    SELECT  'ALTER LOGIN ' + QUOTENAME(loginname) + ' DISABLE'
                    FROM    [perms].[Users] u
                    WHERE   u.snapshot_id = @VSnapshotID
                            AND ( u.is_disabled = 1 )
                            AND ( @User IS NULL
                                  OR u.username = @User
                                );

    --SELECT @SQLSTMT;
    --SELECT @SQLSTMT2;		
        END;

    INSERT  INTO #SQL_Results
            ( stmt )
    VALUES  ( '' );

-- ### REPAIR EXISTING USERS ###
    INSERT  INTO #SQL_Results
            ( stmt )
    VALUES  ( '-- ### REPAIR USERS ###' );

    INSERT  INTO #SQL_Results
            ( stmt
            )
            SELECT  'IF EXISTS (SELECT * FROM sys.database_principals dp '
                    + 'LEFT JOIN sys.server_principals sp ON dp.sid = sp.sid '
                    + 'WHERE dp.type = ''S'' ' + 'AND sp.sid IS NULL '
                    + 'AND dp.name = N' + QUOTENAME(newuser, '''') + ') '
                    + 'EXEC sp_change_users_login ''Auto_Fix'', '
                    + QUOTENAME(newuser, '''') + ';' + @CRLF
            FROM    #AltUsers u
            WHERE   ( @User IS NULL
                      OR u.originaluser = @User
                    )
                    AND u.logintype = 'S';

    INSERT  INTO #SQL_Results
            ( stmt )
    VALUES  ( '' );

-- ### USERS ###
    INSERT  INTO #SQL_Results
            ( stmt )
    VALUES  ( '-- ### USERS ###' );

--SELECT @SQLSTMT = ''
    INSERT  INTO #SQL_Results
            ( stmt
            )
            SELECT  'IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'
                    + QUOTENAME(newuser, '''') + ') ' + 'CREATE USER '
                    + QUOTENAME(newuser) + ' FOR LOGIN ' + QUOTENAME(loginname)
                    + CASE WHEN defaultschema IS NOT NULL
                           THEN ' WITH DEFAULT_SCHEMA='
                                + QUOTENAME(defaultschema)
                           ELSE ''
                      END + ';' + @CRLF
--FROM [perms].[Users] u
            FROM    #AltUsers u
            WHERE   ( @User IS NULL
                      OR u.originaluser = @User
                    );
--WHERE u.snapshot_id = @VSnapshotID
--		AND (@User IS NULL OR u.username = @User);

    INSERT  INTO #SQL_Results
            ( stmt )
    VALUES  ( '' );

-- ### ROLES ###
/* First things first, we need to put the roles into #AltUsers so that when
we do the actual permissions, they are there */
    INSERT  INTO #AltUsers
            ( originaluser ,
              newuser
            )
            SELECT  rolename ,
                    rolename
            FROM    perms.Roles
            WHERE   snapshot_id = @VSnapshotID;

-- First, do Database Roles
    INSERT  INTO #SQL_Results
            ( stmt )
    VALUES  ( '-- ### ROLES ###' );
    INSERT  INTO #SQL_Results
            ( stmt
            )
            SELECT  'IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'
                    + QUOTENAME(rolename, '''') + ' AND type = ''R'') '
                    + 'CREATE ROLE ' + QUOTENAME(rolename)
                    + ' AUTHORIZATION [dbo]'
            FROM    [perms].[Roles] r
            WHERE   r.snapshot_id = @VSnapshotID
                    AND r.roletype = 'R'
                    AND ( @User IS NULL
                          OR r.rolename = @User
                        );

-- Then, do Application Roles.  Note, doesn't transfer password
    INSERT  INTO #SQL_Results
            ( stmt
            )
            SELECT  'IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'''
                    + QUOTENAME(rolename) + ''' AND type = ''A'') '
                    + 'CREATE APPLICATION ROLE ' + QUOTENAME(rolename)
                    + ' WITH PASSWORD = ''1111111111'' '
                    + CASE WHEN defaultschema IS NOT NULL
                           THEN ', DEFAULT_SCHEMA=' + QUOTENAME(defaultschema)
                           ELSE ''
                      END
            FROM    [perms].[Roles] r
            WHERE   r.snapshot_id = @VSnapshotID
                    AND r.roletype = 'A'
                    AND ( @User IS NULL );


    INSERT  INTO #SQL_Results
            ( stmt )
    VALUES  ( '' );

-- ### ROLE ASSIGNMENTS ###
--      Reapply 2012 and before: Exec sp_addrolemember @rolename = COL1, @membername = COL2
--		Reapply 2012 and later: ALTER ROLE Sales ADD MEMBER Barry;
    INSERT  INTO #SQL_Results
            ( stmt )
    VALUES  ( '-- ### ROLE ASSIGNMENTS ###' );
    INSERT  INTO #SQL_Results
            ( stmt
            )
            SELECT  'IF IS_ROLEMEMBER(' + QUOTENAME(rolename, '''') + ','
                    + QUOTENAME(au.newuser, '''') + ') = 0 '
                    + 'EXEC sp_addrolemember @rolename = '
                    + QUOTENAME(rolename, '''') + ', @membername = '
                    + QUOTENAME(au.newuser, '''')
            FROM    [perms].[Role_Memberships] rm
                    JOIN #AltUsers au ON rm.username = au.originaluser
            WHERE   rm.snapshot_id = @VSnapshotID
                    AND ( @User IS NULL
                          OR rm.username = @User
                        );

    INSERT  INTO #SQL_Results
            ( stmt )
    VALUES  ( '' );


-- ### OBJECT PERMISSIONS ###
--		Reapply: --CASE WHEN perm.state <> 'W' THEN perm.state_desc ELSE 'GRANT' END
--+ SPACE(1) + perm.permission_name + SPACE(1) + 'ON ' + QUOTENAME(USER_NAME(obj.schema_id)) + '.' + QUOTENAME(obj.name)
--+ CASE WHEN cl.column_id IS NULL THEN SPACE(0) ELSE '(' + QUOTENAME(cl.name) + ')' END
--+ SPACE(1) + 'TO' + SPACE(1) + QUOTENAME(@NewUser) COLLATE database_default
--+ CASE WHEN perm.state <> 'W' THEN SPACE(0) ELSE SPACE(1) + 'WITH GRANT OPTION' END AS '--Object Level Permissions'

    INSERT  INTO #SQL_Results
            ( stmt
            )
    VALUES  ( '-- ### OBJECT PERMISSIONS ###'
            );
    INSERT  INTO #SQL_Results
            ( stmt
            )
            SELECT  'IF NOT EXISTS (SELECT * FROM sys.database_permissions '
                    + 'WHERE class_desc = ''OBJECT_OR_COLUMN'' '
                    + 'AND grantee_principal_id = DATABASE_PRINCIPAL_ID('
                    + QUOTENAME(au.newuser, '''') + ') '
                    + 'AND permission_name = ' + QUOTENAME(permission_name,
                                                           '''')
                    + ' AND state_desc = ' + QUOTENAME(state_desc, '''')
                    + ' AND major_id = OBJECT_ID(N' + QUOTENAME(objectname,
                                                              '''') + ') '
                    + CASE WHEN columnname IS NULL THEN SPACE(0)
                           ELSE 'AND minor_id = columnproperty(object_id(N'''
                                + schemaname + '.' + objectname + '''),N'''
                                + columnname + ''', ''columnid'') '
                      END + ') ' + CASE WHEN state <> 'W'
                                        THEN state_desc + SPACE(1)
                                        ELSE 'GRANT '
                                   END + permission_name + ' ON '
                    + QUOTENAME(schemaname) + '.' + QUOTENAME(objectname)
                    + CASE WHEN columnname IS NULL THEN SPACE(1)
                           ELSE ' (' + QUOTENAME(columnname) + ')'
                      END + 'TO ' + QUOTENAME(au.newuser)
                    + CASE WHEN state <> 'W' THEN SPACE(0)
                           ELSE ' WITH GRANT OPTION'
                      END
            FROM    [perms].[Object_Permissions] op
                    JOIN #AltUsers au ON op.username = au.originaluser
            WHERE   op.snapshot_id = @VSnapshotID
                    AND ( @User IS NULL
                          OR op.username = @User
                        );

    INSERT  INTO #SQL_Results
            ( stmt )
    VALUES  ( '' );

-- ### SCHEMA PERMISSIONS ###
--		Reapply: GRANT @permission_name ON SCHEMA::@SchemaName TO @UserName
    INSERT  INTO #SQL_Results
            ( stmt
            )
    VALUES  ( '-- ### SCHEMA PERMISSIONS ###'
            );
    INSERT  INTO #SQL_Results
            ( stmt
            )
            SELECT  'IF NOT EXISTS (SELECT * FROM sys.database_permissions '
                    + 'WHERE class_desc = ''SCHEMA'' '
                    + 'AND grantee_principal_id = DATABASE_PRINCIPAL_ID('
                    + QUOTENAME(au.newuser, '''') + ') '
                    + 'AND permission_name = ' + QUOTENAME(permission_name,
                                                           '''')
                    + ' AND state_desc = ' + QUOTENAME(state_desc, '''')
                    + ' AND major_id = SCHEMA_ID(N' + QUOTENAME(schemaname,
                                                              '''') + ')) '
                    + CASE WHEN state <> 'W' THEN state_desc + SPACE(1)
                           ELSE 'GRANT '
                      END + permission_name + ' ON SCHEMA :: ' + schemaname
                    + ' TO ' + QUOTENAME(au.newuser)
                    + CASE WHEN state <> 'W' THEN ';'
                           ELSE ' WITH GRANT OPTION;'
                      END
            FROM    [perms].[Schema_Permissions] sp
                    JOIN #AltUsers au ON sp.username = au.originaluser
            WHERE   sp.snapshot_id = @VSnapshotID
                    AND ( @User IS NULL
                          OR sp.username = @User
                        );

    INSERT  INTO #SQL_Results
            ( stmt )
    VALUES  ( '' );

-- ### DATABASE PERMISSIONS ###
--		Reapply: --CASE WHEN perm.state <> 'W' THEN perm.state_desc ELSE 'GRANT' END
--+ SPACE(1) + perm.permission_name + SPACE(1)
--+ SPACE(1) + 'TO' + SPACE(1) + QUOTENAME(@NewUser) COLLATE database_default
--+ CASE WHEN perm.state <> 'W' THEN SPACE(0) ELSE SPACE(1) + 'WITH GRANT OPTION' END AS '--Database Level Permissions'
    INSERT  INTO #SQL_Results
            ( stmt
            )
    VALUES  ( '-- ### DATABASE PERMISSIONS ###'
            );
    INSERT  INTO #SQL_Results
            ( stmt
            )
            SELECT  'IF NOT EXISTS (SELECT * FROM sys.database_permissions '
                    + 'WHERE class_desc = ''DATABASE'' '
                    + 'AND grantee_principal_id = DATABASE_PRINCIPAL_ID('
                    + QUOTENAME(au.newuser, '''') + ') '
                    + 'AND permission_name = ' + QUOTENAME(permission_name,
                                                           '''')
                    + ' AND state_desc = ' + QUOTENAME(state_desc, '''')
                    + ' AND major_id = 0) '
                    + CASE WHEN state <> 'W' THEN state_desc + SPACE(1)
                           ELSE 'GRANT '
                      END + permission_name + ' TO ' + QUOTENAME(au.newuser)
                    + CASE WHEN state <> 'W' THEN ';'
                           ELSE ' WITH GRANT OPTION;'
                      END
            FROM    [perms].[Database_Permissions] dp
                    JOIN #AltUsers au ON dp.username = au.originaluser
            WHERE   dp.snapshot_id = @VSnapshotID
                    AND ( @User IS NULL
                          OR dp.username = @User
                        );

--LC if @executeScript = 0 return the statements.
    IF @ExecuteScript = 0
        BEGIN
            SELECT  CAST(( STUFF(
		    (SELECT @CRLF + stmt
             FROM   #SQL_Results
             ORDER BY id
                           FOR   XML PATH('') ,
                                     TYPE
		    ).value('.[1]', 'nvarchar(max)'), 1, 2, '') ) AS XML) AS sqlstmt;

    --SELECT stmt AS '--' FROM #SQL_Results ORDER BY ID
    --SELECT stmt FROM #SQL_Results ORDER BY ID FOR XML PATH('')
        END;

    IF @ExecuteScript = 1
        BEGIN
            DECLARE @sqlstmt_prep NVARCHAR(4000);
            DECLARE sql_cursor CURSOR
            FOR
                SELECT  stmt
                FROM    #SQL_Results
                WHERE   stmt <> ''
                        AND stmt NOT LIKE 'USE %'
                        AND stmt NOT LIKE '--%'
                ORDER BY id;
	
            OPEN sql_cursor;
            FETCH NEXT FROM sql_cursor INTO @SQLSTMT;
	
            WHILE @@FETCH_STATUS = 0
                BEGIN
                    IF @DestinationDatabase IS NULL
                        SELECT  @sqlstmt_prep = 'USE ' + @DBName + '; ';
                    ELSE
                        SELECT  @sqlstmt_prep = 'USE ' + @DestinationDatabase
                                + '; ';
                    SELECT  @sqlstmt_prep = @sqlstmt_prep + @SQLSTMT;
                    EXEC sp_executesql @sqlstmt_prep;
		--SELECT @sqlstmt_prep;
		
                    FETCH NEXT FROM sql_cursor INTO @SQLSTMT;
                END;
	
            CLOSE sql_cursor;
            DEALLOCATE sql_cursor;
        END;

    DROP TABLE #SQL_Results;
    DROP TABLE #AltUsers;

    SET NOCOUNT OFF;







GO
/****** Object:  StoredProcedure [perms].[uspClonePerms]    Script Date: 11/13/2018 3:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[perms].[uspClonePerms]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [perms].[uspClonePerms] AS' 
END
GO


/*
This Proc will copy all of the permissions from a given user and assign those permissions to another user.
It will do this for every database on a server, so if a user has permissions on 3 databases, the new user and permissions will be added to those 3 databases.

Example:
EXEC [perms].[uspClonePerms] @UserName = 'DOMAIN\user1234', @NewUser = 'DOMAIN\user456',@CreateLogins = 1,@ExecuteScript = 0
*/

ALTER PROCEDURE [perms].[uspClonePerms]
	@UserName VARCHAR(255) --the user we want to clone
	,@NewUser VARCHAR(255) --the name of the new user
	,@CreateLogins BIT = 1
	,@ExecuteScript BIT = 0
		
AS 

DECLARE @sql nvarchar(4000)
		,@db VARCHAR(50)
-- List the DBs this user has access to, based on the most recent Snapshots
SELECT DISTINCT
        s1.ID AS ID ,
        databasename AS DB ,
        snaptime
INTO    #CurrentSnaps
FROM    perms.Snapshots s1
        INNER JOIN perms.Role_Memberships rm ON rm.snapshot_id = s1.ID
WHERE   rm.username = @UserName
        AND snaptime IN ( SELECT    MAX(snaptime)
                          FROM      perms.Snapshots s2
                          WHERE     s2.databasename = s1.databasename )
ORDER BY databasename;

--SELECT * FROM #CurrentSnaps

--IF there are databases found, we need to add the new user to them
IF (SELECT COUNT(*) FROM #CurrentSnaps) > 0
BEGIN
	--Create an XML string to pass to the permissions proc; this tells it what user we want to clone the new user as.
	DECLARE @AltUsernames XML = '<altusers><user><original>'+@UserName+'</original><new>'+@NewUser+'</new></user></altusers>'

	--In case our user has permission on more than 1 database, we're going to loop through the list to make sure we get them all.
	DECLARE cur CURSOR FOR SELECT DB FROM #CurrentSnaps
	OPEN cur

	FETCH NEXT FROM cur INTO @db

	WHILE @@FETCH_STATUS = 0 
	BEGIN
		-- 1) Write our SQL string that calls the PROC that actually applies the permissions.
		SET @SQL = '
		EXEC [perms].[uspApplyPerms]
			@DBName = ['+@db+'],
			@User = ['+@UserName+'],
			@CreateLogins = '+CAST(@CreateLogins AS CHAR(1))+',
			@ExecuteScript = '+CAST(@ExecuteScript AS CHAR(1))+',
			@AltUsernames = '''+CAST(@AltUsernames AS NVARCHAR(500))+'''
		'
		--make sure the DB is there
		IF DB_ID(@db) IS NOT NULL
		BEGIN
			-- 2) now run the command to call the PROD listed above
			EXEC sp_executesql @SQL	
		END

		FETCH NEXT FROM cur INTO @db
	END
	CLOSE cur    
	DEALLOCATE cur

END

DROP TABLE #CurrentSnaps





GO
/****** Object:  StoredProcedure [perms].[uspCreateSnapshot]    Script Date: 11/13/2018 3:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[perms].[uspCreateSnapshot]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [perms].[uspCreateSnapshot] AS' 
END
GO



ALTER PROCEDURE [perms].[uspCreateSnapshot]
(
	@DBName	sysname
)
AS

INSERT INTO [perms].[Snapshots] (databasename, snaptime) VALUES (@DBName, GETDATE())

DECLARE @SnapshotID nvarchar(20)
SELECT @SnapshotID = CAST(SCOPE_IDENTITY() AS NVarchar(20))

--select @SnapshotID = '1'
--declare @DBName sysname
--SELECT @DBName = 'TestDB'

DECLARE @CRLF nchar(2)
SELECT @CRLF = nchar(13) + nchar(10)

DECLARE @SQLStmt nvarchar(4000)
SELECT @SQLStmt = N'USE ' + QUOTENAME(@DBName) + @CRLF + @CRLF

-- NOTE: Use QUOTENAME(@VAR,'''') for building strings

-- ######### Users #########

SELECT @SQLStmt = @SQLStmt + N'
INSERT INTO [DBA].[perms].[Users]
(snapshot_id, username, usertype, usertypedesc, defaultschema, loginname, logintype, is_disabled)
select ' + 	@SnapshotID + N',
	dp.name AS UserName,					-- sysname
	dp.type AS UserType,					-- char(1)
	dp.type_desc AS UserTypeDesc,			-- nvarchar(60)
	dp.default_schema_name AS DefaultSchema,	-- sysname
	sp.name AS LoginName,					-- sysname
	sp.type AS LoginType,					-- char(1)
	sp.is_disabled							-- int
from sys.database_principals dp
join sys.server_principals sp on dp.sid = sp.sid
where dp.type_desc IN (''WINDOWS_GROUP'',''WINDOWS_USER'',''SQL_USER'')
	and dp.name not in (''dbo'',''guest'',''INFORMATION_SCHEMA'',''sys'')
order by UserName
' + @CRLF + @CRLF

-- ######### Roles #########

SELECT @SQLStmt = @SQLStmt + N'
INSERT INTO [DBA].[perms].[Roles]
(snapshot_id, rolename, roletype, roletypedesc, defaultschema)
select ' + @SnapshotID + ',
	name,						-- sysname
	type,						-- char(1)
	type_desc,					-- nvarchar(60)
	default_schema_name			-- sysname
from sys.database_principals
where type_desc IN (''DATABASE_ROLE'',''APPLICATION_ROLE'')
	and is_fixed_role = 0
	and principal_id <> 0
	' + @CRLF + @CRLF

-- ######### Role Memberships ######### 
--      Reapply: Exec sp_addrolemember @rolename = COL1, @membername = COL2

SELECT @SQLStmt = @SQLStmt + N'
INSERT INTO [DBA].[perms].[Role_Memberships]
(snapshot_id, rolename, username)
select ' + @SnapshotID + N',
	user_name(role_principal_id) AS RoleName,		-- nvarchar(256)
	user_name(member_principal_id) AS UserName	-- nvarchar(256)
from sys.database_role_members
order by RoleName, UserName
' + @CRLF + @CRLF

-- ######### Object permissions - GRANT, DENY, REVOKE statements ######### 
--		Reapply: --CASE WHEN perm.state <> 'W' THEN perm.state_desc ELSE 'GRANT' END
--+ SPACE(1) + perm.permission_name + SPACE(1) + 'ON ' + QUOTENAME(USER_NAME(obj.schema_id)) + '.' + QUOTENAME(obj.name)
--+ CASE WHEN cl.column_id IS NULL THEN SPACE(0) ELSE '(' + QUOTENAME(cl.name) + ')' END
--+ SPACE(1) + 'TO' + SPACE(1) + QUOTENAME(@NewUser) COLLATE database_default
--+ CASE WHEN perm.state <> 'W' THEN SPACE(0) ELSE SPACE(1) + 'WITH GRANT OPTION' END AS '--Object Level Permissions'

SELECT @SQLStmt = @SQLStmt + N'
INSERT INTO [DBA].[perms].[Object_Permissions]
(snapshot_id, state, state_desc, permission_name, schemaname, objectname, username, class_desc, columnname)
SELECT ' + @SnapshotID + N',
	perm.state,			-- char(1) -- D (DENY), R (REVOKE), G (GRANT), W (GRANT_WITH_GRANT_OPTION)
	perm.state_desc,	-- nvarchar(60) -- actual state command for D, R, G; GRANT_WITH_GRANT_OPTION for W
	perm.permission_name,	-- nvarchar(128) -- permission; e.g. EXECUTE for SProcs
	SCHEMA_NAME(obj.schema_id) AS SchemaName,		-- nvarchar(256)	-- schema name
	obj.name,			-- sysname -- the object''s name
	USER_NAME(perm.grantee_principal_id) AS UserName,	-- nvarchar(60) -- the username
	perm.class_desc,	-- nvarchar(60)
	cl.name AS ColumnName	-- sysname -- column name, if applicable
FROM
sys.database_permissions AS perm
INNER JOIN
--LEFT JOIN
sys.objects AS obj
ON perm.major_id = obj.[object_id]
LEFT JOIN
sys.columns AS cl
ON cl.column_id = perm.minor_id AND cl.[object_id] = perm.major_id
WHERE perm.class_desc = ''OBJECT_OR_COLUMN''
order by obj.name, UserName
' + @CRLF + @CRLF

-- ######### Schema assignments - GRANT, DENY, REVOKE statements ######### 
--		Reapply: GRANT @permission_name ON SCHEMA::@SchemaName TO @UserName

SELECT @SQLStmt = @SQLStmt + N'
INSERT INTO [DBA].[perms].[Schema_Permissions]
(snapshot_id, state, state_desc, permission_name, schemaname, username)
SELECT ' + @SnapshotID + N',
	perm.state,									-- char(1)
	perm.state_desc,							-- nvarchar(60)
	perm.permission_name,						-- nvarchar(128)
	SCHEMA_NAME(major_id) AS SchemaName,		-- sysname
	USER_NAME(grantee_principal_id) AS UserName	-- nvarchar(256)
FROM sys.database_permissions perm
where class_desc = ''SCHEMA''
' + @CRLF + @CRLF

-- ######### Database permissions - GRANT, DENY, REVOKE ######### 
--		Reapply: --CASE WHEN perm.state <> 'W' THEN perm.state_desc ELSE 'GRANT' END
--+ SPACE(1) + perm.permission_name + SPACE(1)
--+ SPACE(1) + 'TO' + SPACE(1) + QUOTENAME(@NewUser) COLLATE database_default
--+ CASE WHEN perm.state <> 'W' THEN SPACE(0) ELSE SPACE(1) + 'WITH GRANT OPTION' END AS '--Database Level Permissions'

SELECT @SQLStmt = @SQLStmt + N'
INSERT INTO [DBA].[perms].[Database_Permissions]
(snapshot_id, state, state_desc, permission_name, username)
SELECT ' + @SnapshotID + N',
	perm.state,			-- char(1) -- D (DENY), R (REVOKE), G (GRANT), W (GRANT_WITH_GRANT_OPTION)
	perm.state_desc,	-- nvarchar(60) -- actual state command for D, R, G; GRANT_WITH_GRANT_OPTION for W
	perm.permission_name,	--nvarchar(128) -- permission; e.g. EXECUTE for SProcs
	USER_NAME(perm.grantee_principal_id) AS UserName	-- nvarchar(256) -- the username
FROM
sys.database_permissions AS perm
WHERE
class_desc = ''DATABASE''
--perm.major_id = 0
ORDER
BY perm.permission_name ASC, perm.state_desc ASC
' + @CRLF + @CRLF

--PRINT @SQLStmt

EXECUTE sp_executesql @SQLStmt

/*
	database_permissions.class_desc:
	
	  Implemented:
		OBJECT_OR_COLUMN
		SCHEMA
		DATABASE
		
	  Unimplemented:
		DATABASE_PRINCIPAL
		ASSEMBLY
		TYPE
		XML_SCHEMA_COLLECTION
		MESSAGE_TYPE
		SERVICE_CONTRACT
		SERVICE
		REMOTE_SERVICE_BINDING
		ROUTE
		FULLTEXT_CATALOG
		SYMMETRIC_KEY
		CERTIFICATE
		ASYMMETRIC_KEY
*/





GO
/****** Object:  StoredProcedure [perms].[uspListCurrentSnapshots]    Script Date: 11/13/2018 3:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[perms].[uspListCurrentSnapshots]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [perms].[uspListCurrentSnapshots] AS' 
END
GO

ALTER PROCEDURE [perms].[uspListCurrentSnapshots] (
    @dbName nvarchar(128) = NULL
 )
AS
-- List Most Recent Snapshots
select id AS ID,
	databasename AS DB, 
	snaptime
from perms.snapshots s1
where snaptime in (
		select max(snaptime) from perms.snapshots s2 where s2.databasename = s1.databasename
	)
and (databaseName = @dbName OR @dbName IS NULL)
order by databasename



GO
/****** Object:  StoredProcedure [perms].[uspPermissionsSummary]    Script Date: 11/13/2018 3:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[perms].[uspPermissionsSummary]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [perms].[uspPermissionsSummary] AS' 
END
GO

ALTER PROCEDURE [perms].[uspPermissionsSummary]
	@db VARCHAR(25) = NULL
AS

SET NOCOUNT ON

select id AS ID,
	databasename AS DB, 
	snaptime
into #CurrentSnaps
from perms.snapshots s1
where snaptime in (
		select max(snaptime) from perms.snapshots s2 where s2.databasename = s1.databasename
	)
AND s1.databasename = CASE WHEN @db IS NOT NULL THEN @db ELSE s1.databasename END
order by databasename


SELECT 
	DISTINCT u.username + ':    '
	+ STUFF
	(
		(
			SELECT ', ' + cs.DB
			FROM #CurrentSnaps cs
				JOIN perms.Database_Permissions dp ON cs.ID = dp.snapshot_id
			WHERE dp.username = u.username
				AND dp.state_desc LIKE 'GRANT%'
				AND dp.permission_name = 'CONNECT'
			ORDER BY cs.DB
			FOR XML PATH('')
		), 1, 2, ''
	) AS 'Database Connect Permissions'
FROM perms.Users u
ORDER BY 'Database Connect Permissions'


SELECT 
	DISTINCT u.username,
	STUFF
	(
		(
			SELECT ', ' + cs.DB
			FROM #CurrentSnaps cs
				JOIN perms.Database_Permissions dp ON cs.ID = dp.snapshot_id
			WHERE dp.username = u.username
				AND dp.state_desc LIKE 'GRANT%'
				AND dp.permission_name = 'VIEW DEFINITION'
			ORDER BY cs.DB
			FOR XML PATH('')
		), 1, 2, ''
	) AS dblist --'Database List (GRANT VIEW DEFINITION)'
INTO #ViewDefinitions
FROM perms.Users u
--ORDER BY u.username

SELECT username + ':     ' + dblist AS 'View Definition Permissions'
FROM #ViewDefinitions
WHERE dblist IS NOT NULL
ORDER BY username

drop table #CurrentSnaps
drop table #ViewDefinitions

SET NOCOUNT OFF



GO
/****** Object:  StoredProcedure [perms].[uspPurgeSnapshots]    Script Date: 11/13/2018 3:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[perms].[uspPurgeSnapshots]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [perms].[uspPurgeSnapshots] AS' 
END
GO

ALTER PROCEDURE [perms].[uspPurgeSnapshots]
AS

DECLARE @DAYS_TO_KEEP int
SET @DAYS_TO_KEEP = 90

BEGIN TRANSACTION

BEGIN TRY

	SELECT ID
	INTO #OldSnapshots
	FROM [perms].[Snapshots] ss
	WHERE ss.snaptime < DATEADD(day,0-@DAYS_TO_KEEP,GETDATE())

	DELETE FROM [perms].[Database_Permissions]
	WHERE snapshot_id IN (SELECT ID FROM #OldSnapshots)

	DELETE FROM [perms].[Schema_Permissions]
	WHERE snapshot_id IN (SELECT ID FROM #OldSnapshots)

	DELETE FROM [perms].[Object_Permissions]
	WHERE snapshot_id IN (SELECT ID FROM #OldSnapshots)

	DELETE FROM [perms].[Role_Memberships]
	WHERE snapshot_id IN (SELECT ID FROM #OldSnapshots)

	DELETE FROM [perms].[Roles]
	WHERE snapshot_id IN (SELECT ID FROM #OldSnapshots)

	DELETE FROM [perms].[Users]
	WHERE snapshot_id IN (SELECT ID FROM #OldSnapshots)

	DELETE FROM [perms].[Snapshots]
	WHERE ID IN (SELECT ID FROM #OldSnapshots)

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
END CATCH



GO
/****** Object:  StoredProcedure [perms].[uspRemoveAllUsersFromDB]    Script Date: 11/13/2018 3:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[perms].[uspRemoveAllUsersFromDB]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [perms].[uspRemoveAllUsersFromDB] AS' 
END
GO

ALTER PROCEDURE [perms].[uspRemoveAllUsersFromDB] (
    @dbName NVARCHAR(128)
 )
AS
/*===================================================
  Author: Luke Campbell
  Created: 2016-12-12
  Purpose: To remove all users from a restored database.
            Users will be added back using the latest permissions snapshot for that database.
  Users owning certificates will not be dropped.
====================================================*/

BEGIN
    DECLARE @Message NVARCHAR(255)					--Displays progress
    DECLARE @SQL NVARCHAR(4000)					   --Used for dynamic sql
    DECLARE @Error NVARCHAR(400)

    --ensure parameters supplied are compatible.
    SET @Error = 0
    IF @dbName = ''
    BEGIN
	 SET @Message = 'The value for parameter @dbName is not supported.' + CHAR(13) + CHAR(10)
	 RAISERROR(@Message,16,1) WITH NOWAIT
	 SET @Error = @@ERROR
    END


     SET @sql = N'USE ' + QUOTENAME(@dbName )

     SET @sql = @sql + N'

			 SET NOCOUNT ON

			 DECLARE @UserID       varchar(128)
			 DECLARE @SQLstmt      varchar(255)
			 DECLARE @salogin	   varchar(50)

			 --determine the name for the sa account
			 SELECT @salogin = name FROM sys.syslogins WHERE sid = 0x01			 

			 PRINT ''Fix Database Users''
			 PRINT ''Server:   '' + @@servername
			 PRINT ''Database: '' + DB_NAME()


			 EXEC sp_changedbowner @salogin

			 --avoid dropping users that were creating using certificates
			 DECLARE DropUserCursor CURSOR FOR
			 SELECT p.name FROM sys.database_principals p
				LEFT JOIN sys.certificates c
				ON p.principal_id = c.principal_id
				WHERE p.type <> ''R''
				AND p.principal_id >=5
				AND c.principal_id IS NULL

			 OPEN DropUserCursor
			 FETCH NEXT FROM DropUserCursor INTO @UserID
			 WHILE @@FETCH_STATUS = 0
				BEGIN
				   SELECT @SQLstmt = ''exec sp_revokedbaccess '''''' + @UserID + ''''''''
				PRINT @SQLstmt
				EXEC (@SQLstmt)
				FETCH NEXT FROM DropUserCursor INTO @UserID
				END

			 CLOSE DropUserCursor
			 DEALLOCATE DropUserCursor
	   '
   EXECUTE sp_executesql @sql
   --PRINT @sql
 
END








GO
/****** Object:  StoredProcedure [perms].[uspShowDBPermissions]    Script Date: 11/13/2018 3:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[perms].[uspShowDBPermissions]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [perms].[uspShowDBPermissions] AS' 
END
GO

ALTER PROCEDURE [perms].[uspShowDBPermissions]
	@DBName sysname
AS

SET NOCOUNT ON

DECLARE @SQLSTMT nvarchar(4000)
DECLARE @SQLSTMT2 nvarchar(4000)
DECLARE @VSnapshotID int

DECLARE @CRLF nchar(2)
SELECT @CRLF = nchar(13) + nchar(10)

-- Create Temp Table
CREATE TABLE #SQL_Results
(
	id		int identity(1,1) NOT NULL,
	stmt	nvarchar(1000)	NOT NULL
)

-- Determine Correct Snapshot ID
SELECT TOP 1 @VSnapshotID = ID FROM [perms].[Snapshots] WHERE databasename = @DBName ORDER BY snaptime DESC

IF @VSnapshotID IS NULL -- STILL???
BEGIN
	RAISERROR(N'No Valid Snapshot Available',16,1)
	RETURN
END

SELECT @DBName + ' on ' + CAST(SERVERPROPERTY('MachineName') AS varchar) AS '=== Database ==='

-- ### USERS ###

SELECT username + ' from Login ' + loginname + ' (' + logintype + ')' AS '=== Users ==='
FROM [perms].[Users] u
WHERE u.snapshot_id = @VSnapshotID
ORDER BY u.username

-- ### ROLES ###

-- First, do Database Roles
SELECT r.rolename
	+ CASE 
		WHEN r.roletype = 'R' THEN ' (Database Role)'
		ELSE ' (Application Role'
	  END
	AS '=== Roles ==='
FROM [perms].[Roles] r
WHERE r.snapshot_id = @VSnapshotID

-- ### ROLE ASSIGNMENTS ###
SELECT rm.rolename + ': ' + rm.username AS '=== Role Memberships ==='
FROM [perms].[Role_Memberships] rm
WHERE rm.snapshot_id = @VSnapshotID


-- ### OBJECT PERMISSIONS ###

SELECT schemaname + '.' + objectname
	+  CASE
		WHEN columnname IS NULL THEN ': '
		ELSE ' (' + QUOTENAME(columnname) + '): '
	   END
	+ CASE
		WHEN state <> 'W' THEN state_desc + SPACE(1)
		ELSE 'GRANT '
	  END
	+ permission_name 
	+ ' TO ' + username
	+ CASE
		WHEN state <> 'W' THEN SPACE(0)
		ELSE ' (WITH GRANT OPTION)'
	  END
	AS '=== Object Permissions ==='
FROM [perms].[Object_Permissions] op
WHERE op.snapshot_id = @VSnapshotID

-- ### SCHEMA PERMISSIONS ###
SELECT schemaname + ': '
	+ CASE
		WHEN sp.state <> 'W' THEN state_desc + SPACE(1)
		ELSE 'GRANT '
	  END
	+ permission_name 
	+ ' TO ' + username
	+ CASE
		WHEN sp.state <> 'W' THEN SPACE(0)
		ELSE ' (WITH GRANT OPTION)'
	  END
	AS '=== Schema Permissions ==='
FROM [perms].[Schema_Permissions] sp
WHERE sp.snapshot_id = @VSnapshotID


-- ### DATABASE PERMISSIONS ###
SELECT 
	CASE
		WHEN state <> 'W' THEN state_desc + SPACE(1)
		ELSE 'GRANT '
	END
	+ permission_name 
	+ ' TO ' + username
	+ CASE
		WHEN state <> 'W' THEN ''
		ELSE ' (WITH GRANT OPTION)'
	  END
	AS '=== Database Permissions ==='
FROM [perms].[Database_Permissions] dp
WHERE dp.snapshot_id = @VSnapshotID


SET NOCOUNT OFF



GO
/****** Object:  StoredProcedure [perms].[uspShowUserPerms]    Script Date: 11/13/2018 3:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[perms].[uspShowUserPerms]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [perms].[uspShowUserPerms] AS' 
END
GO

ALTER PROCEDURE [perms].[uspShowUserPerms]
(
	@UserName varchar(255)
)
AS

SET NOCOUNT ON

-- List Most Recent Snapshots
select id AS ID,
	databasename AS DB, 
	snaptime
into #CurrentSnaps
from perms.snapshots s1
where snaptime in (
		select max(snaptime) from perms.snapshots s2 where s2.databasename = s1.databasename
	)
order by databasename

--select * from #CurrentSnaps


SELECT @UserName + ' on ' + CAST(SERVERPROPERTY('MachineName') AS varchar) AS '=== User ==='

-- Role Memberships --
 select cs.DB + ': ' + rm.rolename AS '=== Role Memberships ==='
 from perms.role_memberships rm
 --join perms.snapshots ss on rm.snapshot_id = ss.id
 join #CurrentSnaps cs on cs.id = rm.snapshot_id
 where rm.username = @UserName
	--and rm.snapshot_id in (SELECT ID FROM #CurrentSnaps)
 --order by ss.databasename
 order by cs.DB
 
 -- Database Permissions --
 select cs.DB + ': ' + state_desc + ' ' + permission_name AS '=== Database Permissions ==='
 from perms.database_permissions dp
 join #CurrentSnaps cs on cs.id = dp.snapshot_id
 where dp.username = @UserName
 order by cs.db

 -- Schema Permissions --
 select cs.DB + '.' + sp.schemaname + ': ' + state_desc + ' ' + permission_name AS '=== Schema Permissions ==='
 from perms.schema_permissions sp
 join #CurrentSnaps cs on cs.id = sp.snapshot_id
 where sp.username = @UserName
 order by cs.db
 
 -- Object Permissions --
 select cs.DB + '.' + op.schemaname + '.' + op.objectname
	+  CASE
		WHEN columnname IS NULL THEN SPACE(1)
		ELSE ' (' + QUOTENAME(columnname) + ')'
	   END
	+ ': ' + op.state_desc + ' ' + op.permission_name AS '=== Object Permissions ==='
	 --cs.DB + '.' + sp.schemaname + ': ' + state_desc + ' ' + permission_name
 from perms.object_permissions op
 join #CurrentSnaps cs on cs.id = op.snapshot_id
 where op.username = @UserName
 order by cs.db
 
 drop table #CurrentSnaps
 
SET NOCOUNT OFF



GO
/****** Object:  StoredProcedure [perms].[uspSnapshotAllDBs]    Script Date: 11/13/2018 3:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[perms].[uspSnapshotAllDBs]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [perms].[uspSnapshotAllDBs] AS' 
END
GO

ALTER PROCEDURE [perms].[uspSnapshotAllDBs]
AS

DECLARE @tmpDatabases TABLE (ID int IDENTITY PRIMARY KEY,
                               DatabaseName nvarchar(max),
                               Completed bit)
DECLARE @CurrentID int
DECLARE @CurrentDatabaseName nvarchar(max)

INSERT INTO @tmpDatabases (DatabaseName, Completed)
  SELECT Name AS DatabaseName,
         0 AS Completed
  FROM sys.databases
  WHERE state = 0
		AND source_database_id IS NULL
  ORDER BY Name ASC

--  SELECT DatabaseName AS DatabaseName,
--         0 AS Completed
--  FROM dbo.DatabaseSelect ('USER_DATABASES,SYSTEM_DATABASES')
--  ORDER BY DatabaseName ASC

WHILE EXISTS (SELECT * FROM @tmpDatabases WHERE Completed = 0)
BEGIN
    SELECT TOP 1 @CurrentID = ID,
                 @CurrentDatabaseName = DatabaseName
    FROM @tmpDatabases
    WHERE Completed = 0
    ORDER BY ID ASC

	EXEC [perms].[uspCreateSnapshot] @DBName = @CurrentDatabaseName

    -- Update that the database is completed
    UPDATE @tmpDatabases
    SET Completed = 1
    WHERE ID = @CurrentID

    -- Clear variables
    SET @CurrentID = NULL
    SET @CurrentDatabaseName = NULL
END



GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , NULL,NULL, NULL,NULL, NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Database used to store SQL Server instance maintenance tasks. �Should be included on all managed SQL Server instances.' 
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'perms', N'TABLE',N'Database_Permissions', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contains permissions for each database on the SQL Server instance. �Used to create permission snapshots in the event a restore is needed.' , @level0type=N'SCHEMA',@level0name=N'perms', @level1type=N'TABLE',@level1name=N'Database_Permissions'
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'perms', N'TABLE',N'Object_Permissions', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contains permissions for each object within each database on the SQL Server instance. �Used to create permission snapshots in the event a restore is needed.' , @level0type=N'SCHEMA',@level0name=N'perms', @level1type=N'TABLE',@level1name=N'Object_Permissions'
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'perms', N'TABLE',N'Role_Memberships', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contains members of each role within each database on the SQL Server instance. �Used to create permission snapshots in the event a restore is needed.' , @level0type=N'SCHEMA',@level0name=N'perms', @level1type=N'TABLE',@level1name=N'Role_Memberships'
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'perms', N'TABLE',N'Roles', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contains roles within each database on the SQL Server instance. �Used to create permission snapshots in the event a restore is needed.' , @level0type=N'SCHEMA',@level0name=N'perms', @level1type=N'TABLE',@level1name=N'Roles'
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'perms', N'TABLE',N'Schema_Permissions', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contains schema permissions within each database on the SQL Server instance. �Used to create permission snapshots in the event a restore is needed.' , @level0type=N'SCHEMA',@level0name=N'perms', @level1type=N'TABLE',@level1name=N'Schema_Permissions'
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'perms', N'TABLE',N'Snapshots', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contains permission snapshot information for each snapshot created. �Permissions snapshots are created via a scheduled sql server agent job on each instance.' , @level0type=N'SCHEMA',@level0name=N'perms', @level1type=N'TABLE',@level1name=N'Snapshots'
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'perms', N'TABLE',N'Users', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contains users within each database on the SQL Server instance. �Used to create permission snapshots in the event a restore is needed.' , @level0type=N'SCHEMA',@level0name=N'perms', @level1type=N'TABLE',@level1name=N'Users'
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'perms', N'PROCEDURE',N'uspApplyPerms', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Stored procedure is used to apply permissions, taken from a previous snapshot, to a given database.' , @level0type=N'SCHEMA',@level0name=N'perms', @level1type=N'PROCEDURE',@level1name=N'uspApplyPerms'
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'perms', N'PROCEDURE',N'uspClonePerms', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Stored procedure is used to clone permissions, taken from a previous snapshot, to a given database. �Clones from one user to another.' , @level0type=N'SCHEMA',@level0name=N'perms', @level1type=N'PROCEDURE',@level1name=N'uspClonePerms'
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'perms', N'PROCEDURE',N'uspCreateSnapshot', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Creates a permission snapshot for a given database.�' , @level0type=N'SCHEMA',@level0name=N'perms', @level1type=N'PROCEDURE',@level1name=N'uspCreateSnapshot'
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'perms', N'PROCEDURE',N'uspListCurrentSnapshots', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Lists current snapshots for a given database.' , @level0type=N'SCHEMA',@level0name=N'perms', @level1type=N'PROCEDURE',@level1name=N'uspListCurrentSnapshots'
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'perms', N'PROCEDURE',N'uspPermissionsSummary', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Provides a summary report of permissions for a given database.' , @level0type=N'SCHEMA',@level0name=N'perms', @level1type=N'PROCEDURE',@level1name=N'uspPermissionsSummary'
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'perms', N'PROCEDURE',N'uspPurgeSnapshots', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Removes snapshots older than 90 days.' , @level0type=N'SCHEMA',@level0name=N'perms', @level1type=N'PROCEDURE',@level1name=N'uspPurgeSnapshots'
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'perms', N'PROCEDURE',N'uspRemoveAllUsersFromDB', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Used to clean up users from a restored database.�' , @level0type=N'SCHEMA',@level0name=N'perms', @level1type=N'PROCEDURE',@level1name=N'uspRemoveAllUsersFromDB'
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'perms', N'PROCEDURE',N'uspShowDBPermissions', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Show database permissions for a given database as they existed during the last snapshot creation.' , @level0type=N'SCHEMA',@level0name=N'perms', @level1type=N'PROCEDURE',@level1name=N'uspShowDBPermissions'
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'perms', N'PROCEDURE',N'uspShowUserPerms', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Show user permissions for a given user as they existed during the last snapshot creation.' , @level0type=N'SCHEMA',@level0name=N'perms', @level1type=N'PROCEDURE',@level1name=N'uspShowUserPerms'
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'perms', N'PROCEDURE',N'uspSnapshotAllDBs', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Creates a snapshot of all databases on the instance.' , @level0type=N'SCHEMA',@level0name=N'perms', @level1type=N'PROCEDURE',@level1name=N'uspSnapshotAllDBs'
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'FUNCTION',N'fn_RoundDateTime', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Used to round date and times.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'FUNCTION',@level1name=N'fn_RoundDateTime'
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'perms', NULL,NULL, NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contains all objects related to the collection of permission data.' , @level0type=N'SCHEMA',@level0name=N'perms'
GO
