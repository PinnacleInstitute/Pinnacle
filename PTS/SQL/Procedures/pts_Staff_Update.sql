EXEC [dbo].pts_CheckProc 'pts_Staff_Update'
 GO

CREATE PROCEDURE [dbo].pts_Staff_Update ( 
   @StaffID int,
   @MerchantID int,
   @ConsumerID int,
   @StaffName nvarchar (40),
   @Code int,
   @Status int,
   @StaffDate datetime,
   @Access varchar (80),
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE st
SET st.MerchantID = @MerchantID ,
   st.ConsumerID = @ConsumerID ,
   st.StaffName = @StaffName ,
   st.Code = @Code ,
   st.Status = @Status ,
   st.StaffDate = @StaffDate ,
   st.Access = @Access
FROM Staff AS st
WHERE st.StaffID = @StaffID

GO