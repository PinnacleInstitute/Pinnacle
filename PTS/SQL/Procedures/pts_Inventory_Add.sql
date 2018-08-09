EXEC [dbo].pts_CheckProc 'pts_Inventory_Add'
 GO

CREATE PROCEDURE [dbo].pts_Inventory_Add ( 
   @InventoryID int OUTPUT,
   @MemberID int,
   @ProductID int,
   @Attribute1 nvarchar (15),
   @Attribute2 nvarchar (15),
   @Attribute3 nvarchar (15),
   @InStock int,
   @ReOrder int,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Inventory (
            MemberID , 
            ProductID , 
            Attribute1 , 
            Attribute2 , 
            Attribute3 , 
            InStock , 
            ReOrder
            )
VALUES (
            @MemberID ,
            @ProductID ,
            @Attribute1 ,
            @Attribute2 ,
            @Attribute3 ,
            @InStock ,
            @ReOrder            )

SET @mNewID = @@IDENTITY

SET @InventoryID = @mNewID

GO