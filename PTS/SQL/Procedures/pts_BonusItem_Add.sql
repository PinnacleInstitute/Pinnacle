EXEC [dbo].pts_CheckProc 'pts_BonusItem_Add'
GO

CREATE PROCEDURE [dbo].pts_BonusItem_Add
   @BonusItemID int OUTPUT,
   @BonusID int,
   @CompanyID int,
   @MemberID int,
   @MemberBonusID int,
   @CommType int,
   @Amount money,
   @Reference varchar (20),
   @UserID int
AS

DECLARE @mNow datetime, 
         @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()
INSERT INTO BonusItem (
            BonusID , 
            CompanyID , 
            MemberID , 
            MemberBonusID , 
            CommType , 
            Amount , 
            Reference

            )
VALUES (
            @BonusID ,
            @CompanyID ,
            @MemberID ,
            @MemberBonusID ,
            @CommType ,
            @Amount ,
            @Reference
            )

SET @mNewID = @@IDENTITY
SET @BonusItemID = @mNewID
EXEC pts_Bonus_ComputeTotal
   @MemberBonusID

GO