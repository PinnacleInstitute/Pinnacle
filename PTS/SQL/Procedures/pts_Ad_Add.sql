EXEC [dbo].pts_CheckProc 'pts_Ad_Add'
 GO

CREATE PROCEDURE [dbo].pts_Ad_Add ( 
   @AdID int OUTPUT,
   @CompanyID int,
   @MemberID int,
   @AdName nvarchar (60),
   @Status int,
   @Msg nvarchar (2000),
   @Placement int,
   @RefID int,
   @Priority int,
   @POrder int,
   @Zip nvarchar (20),
   @City nvarchar (30),
   @MTA nvarchar (15),
   @State nvarchar (30),
   @StartAge int,
   @EndAge int,
   @StartDate datetime,
   @EndDate datetime,
   @MaxPlace int,
   @Places int,
   @Clicks int,
   @Rotation nvarchar (10),
   @Weight int,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Ad (
            CompanyID , 
            MemberID , 
            AdName , 
            Status , 
            Msg , 
            Placement , 
            RefID , 
            Priority , 
            POrder , 
            Zip , 
            City , 
            MTA , 
            State , 
            StartAge , 
            EndAge , 
            StartDate , 
            EndDate , 
            MaxPlace , 
            Places , 
            Clicks , 
            Rotation , 
            Weight
            )
VALUES (
            @CompanyID ,
            @MemberID ,
            @AdName ,
            @Status ,
            @Msg ,
            @Placement ,
            @RefID ,
            @Priority ,
            @POrder ,
            @Zip ,
            @City ,
            @MTA ,
            @State ,
            @StartAge ,
            @EndAge ,
            @StartDate ,
            @EndDate ,
            @MaxPlace ,
            @Places ,
            @Clicks ,
            @Rotation ,
            @Weight            )

SET @mNewID = @@IDENTITY

SET @AdID = @mNewID

GO