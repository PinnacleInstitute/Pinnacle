EXEC [dbo].pts_CheckTable 'Employee'
 GO

CREATE TABLE [dbo].[Employee] (
   [EmployeeID] int IDENTITY (1,1) NOT NULL ,
   [AuthUserID] int NOT NULL ,
   [MemberID] int NOT NULL ,
   [NameLast] nvarchar (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [NameFirst] nvarchar (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Email] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Street] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Unit] nvarchar (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [City] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [State] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Zip] nvarchar (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Country] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Phone] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Mobile] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Title] nvarchar (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL ,
   [Notes] varchar (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Security] varchar (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Employee] WITH NOCHECK ADD
   CONSTRAINT [DF_Employee_AuthUserID] DEFAULT (0) FOR [AuthUserID] ,
   CONSTRAINT [DF_Employee_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Employee_NameLast] DEFAULT ('') FOR [NameLast] ,
   CONSTRAINT [DF_Employee_NameFirst] DEFAULT ('') FOR [NameFirst] ,
   CONSTRAINT [DF_Employee_Email] DEFAULT ('') FOR [Email] ,
   CONSTRAINT [DF_Employee_Street] DEFAULT ('') FOR [Street] ,
   CONSTRAINT [DF_Employee_Unit] DEFAULT ('') FOR [Unit] ,
   CONSTRAINT [DF_Employee_City] DEFAULT ('') FOR [City] ,
   CONSTRAINT [DF_Employee_State] DEFAULT ('') FOR [State] ,
   CONSTRAINT [DF_Employee_Zip] DEFAULT ('') FOR [Zip] ,
   CONSTRAINT [DF_Employee_Country] DEFAULT ('') FOR [Country] ,
   CONSTRAINT [DF_Employee_Phone] DEFAULT ('') FOR [Phone] ,
   CONSTRAINT [DF_Employee_Mobile] DEFAULT ('') FOR [Mobile] ,
   CONSTRAINT [DF_Employee_Title] DEFAULT ('') FOR [Title] ,
   CONSTRAINT [DF_Employee_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Employee_Notes] DEFAULT ('') FOR [Notes] ,
   CONSTRAINT [DF_Employee_Security] DEFAULT ('') FOR [Security]
GO

ALTER TABLE [dbo].[Employee] WITH NOCHECK ADD
   CONSTRAINT [PK_Employee] PRIMARY KEY NONCLUSTERED
   ([EmployeeID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Employee_AuthUserID]
   ON [dbo].[Employee]
   ([AuthUserID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Employee_NameFirst]
   ON [dbo].[Employee]
   ([NameLast], [NameFirst])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO