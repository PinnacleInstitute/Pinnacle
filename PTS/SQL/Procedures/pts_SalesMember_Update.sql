EXEC [dbo].pts_CheckProc 'pts_SalesMember_Update'
 GO

CREATE PROCEDURE [dbo].pts_SalesMember_Update ( 
   @SalesMemberID int,
   @SalesAreaID int,
   @MemberID int,
   @Status int,
   @StatusDate datetime,
   @FTE int,
   @Assignment varchar (40),
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE slm
SET slm.SalesAreaID = @SalesAreaID ,
   slm.MemberID = @MemberID ,
   slm.Status = @Status ,
   slm.StatusDate = @StatusDate ,
   slm.FTE = @FTE ,
   slm.Assignment = @Assignment
FROM SalesMember AS slm
WHERE slm.SalesMemberID = @SalesMemberID

GO