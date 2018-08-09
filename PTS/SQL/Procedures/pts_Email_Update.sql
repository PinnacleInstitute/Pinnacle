EXEC [dbo].pts_CheckProc 'pts_Email_Update'
 GO

CREATE PROCEDURE [dbo].pts_Email_Update ( 
   @EmailID int,
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

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE ema
SET ema.CompanyID = @CompanyID ,
   ema.NewsLetterID = @NewsLetterID ,
   ema.EmailListID = @EmailListID ,
   ema.EmailName = @EmailName ,
   ema.FromEmail = @FromEmail ,
   ema.Subject = @Subject ,
   ema.FileName = @FileName ,
   ema.Status = @Status ,
   ema.SendDate = @SendDate ,
   ema.Repeat = @Repeat ,
   ema.EndDate = @EndDate ,
   ema.Mailings = @Mailings ,
   ema.Emails = @Emails ,
   ema.TestEmail = @TestEmail ,
   ema.TestFirstName = @TestFirstName ,
   ema.TestLastName = @TestLastName ,
   ema.TestData1 = @TestData1 ,
   ema.TestData2 = @TestData2 ,
   ema.TestData3 = @TestData3 ,
   ema.TestData4 = @TestData4 ,
   ema.TestData5 = @TestData5 ,
   ema.EmailType = @EmailType ,
   ema.IsSalesStep = @IsSalesStep
FROM Email AS ema
WHERE ema.EmailID = @EmailID

GO