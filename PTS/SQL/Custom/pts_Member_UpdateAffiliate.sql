EXEC [dbo].pts_CheckProc 'pts_Member_UpdateAffiliate'
GO

CREATE PROCEDURE [dbo].pts_Member_UpdateAffiliate
   @MemberID int,
   @BillingID int,
   @CompanyName nvarchar (60),
   @NameLast nvarchar (30),
   @NameFirst nvarchar (30),
   @Street nvarchar (60),
   @Unit nvarchar (40),
   @City nvarchar (30),
   @State nvarchar (30),
   @Zip nvarchar (20),
   @Country nvarchar (30),
   @Email nvarchar (80),
   @Phone1 nvarchar (30),
   @Phone2 nvarchar (30),
   @Fax nvarchar (30),
   @Newsletter int,
   @UserID int
AS

DECLARE   @mNow datetime, 
         @mNewID int

SET         NOCOUNT ON

SET         @mNow = GETDATE()

UPDATE   me
SET         me.BillingID = @BillingID ,
            me.CompanyName = @CompanyName ,
            me.NameLast = @NameLast ,
            me.NameFirst = @NameFirst ,
            me.Street = @Street ,
            me.Unit = @Unit ,
            me.City = @City ,
            me.State = @State ,
            me.Zip = @Zip ,
            me.Country = @Country ,
            me.Email = @Email ,
            me.Phone1 = @Phone1 ,
            me.Phone2 = @Phone2 ,
            me.Fax = @Fax ,
            me.Newsletter = @Newsletter ,
            me.ChangeDate = @mNow ,
            me.ChangeID = @UserID
FROM      Member AS me
WHERE      (me.MemberID = @MemberID)


GO