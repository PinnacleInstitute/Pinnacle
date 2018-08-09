EXEC [dbo].pts_CheckProc 'pts_HomeTax_Add'
 GO

CREATE PROCEDURE [dbo].pts_HomeTax_Add ( 
   @HomeTaxID int OUTPUT,
   @MemberID int,
   @TaxRate int,
   @Office int,
   @Miles int,
   @Home money,
   @Meetings money,
   @Meals money,
   @Supplies money,
   @Gifts money,
   @Materials money,
   @Phones money,
   @Internet money,
   @Kids money,
   @Subscriptions money,
   @Entertainment money,
   @Activities money,
   @Events money,
   @Medical money,
   @Recreational money,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO HomeTax (
            MemberID , 
            TaxRate , 
            Office , 
            Miles , 
            Home , 
            Meetings , 
            Meals , 
            Supplies , 
            Gifts , 
            Materials , 
            Phones , 
            Internet , 
            Kids , 
            Subscriptions , 
            Entertainment , 
            Activities , 
            Events , 
            Medical , 
            Recreational
            )
VALUES (
            @MemberID ,
            @TaxRate ,
            @Office ,
            @Miles ,
            @Home ,
            @Meetings ,
            @Meals ,
            @Supplies ,
            @Gifts ,
            @Materials ,
            @Phones ,
            @Internet ,
            @Kids ,
            @Subscriptions ,
            @Entertainment ,
            @Activities ,
            @Events ,
            @Medical ,
            @Recreational            )

SET @mNewID = @@IDENTITY

SET @HomeTaxID = @mNewID

GO