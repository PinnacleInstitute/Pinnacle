EXEC [dbo].pts_CheckProc 'pts_Contest_Add'
 GO

CREATE PROCEDURE [dbo].pts_Contest_Add ( 
   @ContestID int OUTPUT,
   @CompanyID int,
   @MemberID int,
   @ContestName nvarchar (40),
   @Description nvarchar (1000),
   @Status int,
   @Metric int,
   @StartDate datetime,
   @EndDate datetime,
   @IsPrivate bit,
   @Custom1 int,
   @Custom2 int,
   @Custom3 int,
   @Custom4 int,
   @Custom5 int,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Contest (
            CompanyID , 
            MemberID , 
            ContestName , 
            Description , 
            Status , 
            Metric , 
            StartDate , 
            EndDate , 
            IsPrivate , 
            Custom1 , 
            Custom2 , 
            Custom3 , 
            Custom4 , 
            Custom5
            )
VALUES (
            @CompanyID ,
            @MemberID ,
            @ContestName ,
            @Description ,
            @Status ,
            @Metric ,
            @StartDate ,
            @EndDate ,
            @IsPrivate ,
            @Custom1 ,
            @Custom2 ,
            @Custom3 ,
            @Custom4 ,
            @Custom5            )

SET @mNewID = @@IDENTITY

SET @ContestID = @mNewID

GO