EXEC [dbo].pts_CheckProc 'pts_Company_Add'
GO

CREATE PROCEDURE [dbo].pts_Company_Add
   @CompanyID int OUTPUT,
   @MemberID int,
   @BillingID int,
   @CompanyName nvarchar (60),
   @CompanyType int,
   @Status int,
   @NameLast nvarchar (30),
   @NameFirst nvarchar (30),
   @Street nvarchar (60),
   @Unit nvarchar (40),
   @City nvarchar (30),
   @State nvarchar (30),
   @Zip nvarchar (20),
   @Country nvarchar (30),
   @Email nvarchar (80),
   @Email2 nvarchar (80),
   @Email3 nvarchar (80),
   @Phone1 nvarchar (30),
   @Phone2 nvarchar (30),
   @Fax nvarchar (30),
   @EnrollDate datetime,
   @Subnet nvarchar (20),
   @LostBonusDate datetime,
   @UserID int
AS

DECLARE @mNow datetime, 
         @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()
INSERT INTO Company (
            MemberID , 
            BillingID , 
            CompanyName , 
            CompanyType , 
            Status , 
            NameLast , 
            NameFirst , 
            Street , 
            Unit , 
            City , 
            State , 
            Zip , 
            Country , 
            Email , 
            Email2 , 
            Email3 , 
            Phone1 , 
            Phone2 , 
            Fax , 
            EnrollDate , 
            Subnet , 
            LostBonusDate

            )
VALUES (
            @MemberID ,
            @BillingID ,
            @CompanyName ,
            @CompanyType ,
            @Status ,
            @NameLast ,
            @NameFirst ,
            @Street ,
            @Unit ,
            @City ,
            @State ,
            @Zip ,
            @Country ,
            @Email ,
            @Email2 ,
            @Email3 ,
            @Phone1 ,
            @Phone2 ,
            @Fax ,
            @EnrollDate ,
            @Subnet ,
            @LostBonusDate
            )

SET @mNewID = @@Identity
SET @CompanyID = @mNewID
GO