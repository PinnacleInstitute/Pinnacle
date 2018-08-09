EXEC [dbo].pts_CheckProc 'pts_Email_Add'
 GO

CREATE PROCEDURE [dbo].pts_Email_Add ( 
   @EmailID int OUTPUT,
   @CompanyID int,
   @NewsLetterID int,
   @EmailListID int,
   @EmailName nvarchar (60),
   @FromEmail nvarchar (60),
   @Subject nvarchar (80),
   @FileName nvarchar (20),
   @Status int,
   @SendDate datetime,
   @Repeat nvarchar (5),
   @EndDate datetime,
   @Mailings int,
   @Emails int,
   @TestEmail nvarchar (80),
   @TestFirstName nvarchar (30),
   @TestLastName nvarchar (30),
   @TestData1 nvarchar (80),
   @TestData2 nvarchar (80),
   @TestData3 nvarchar (80),
   @TestData4 nvarchar (80),
   @TestData5 nvarchar (80),
   @EmailType int,
   @IsSalesStep bit,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Email (
            CompanyID , 
            NewsLetterID , 
            EmailListID , 
            EmailName , 
            FromEmail , 
            Subject , 
            FileName , 
            Status , 
            SendDate , 
            Repeat , 
            EndDate , 
            Mailings , 
            Emails , 
            TestEmail , 
            TestFirstName , 
            TestLastName , 
            TestData1 , 
            TestData2 , 
            TestData3 , 
            TestData4 , 
            TestData5 , 
            EmailType , 
            IsSalesStep
            )
VALUES (
            @CompanyID ,
            @NewsLetterID ,
            @EmailListID ,
            @EmailName ,
            @FromEmail ,
            @Subject ,
            @FileName ,
            @Status ,
            @SendDate ,
            @Repeat ,
            @EndDate ,
            @Mailings ,
            @Emails ,
            @TestEmail ,
            @TestFirstName ,
            @TestLastName ,
            @TestData1 ,
            @TestData2 ,
            @TestData3 ,
            @TestData4 ,
            @TestData5 ,
            @EmailType ,
            @IsSalesStep            )

SET @mNewID = @@IDENTITY

SET @EmailID = @mNewID

GO