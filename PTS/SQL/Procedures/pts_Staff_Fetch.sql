EXEC [dbo].pts_CheckProc 'pts_Staff_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Staff_Fetch ( 
   @StaffID int,
   @MerchantID int OUTPUT,
   @ConsumerID int OUTPUT,
   @StaffName nvarchar (40) OUTPUT,
   @Code int OUTPUT,
   @Status int OUTPUT,
   @StaffDate datetime OUTPUT,
   @Access varchar (80) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MerchantID = st.MerchantID ,
   @ConsumerID = st.ConsumerID ,
   @StaffName = st.StaffName ,
   @Code = st.Code ,
   @Status = st.Status ,
   @StaffDate = st.StaffDate ,
   @Access = st.Access
FROM Staff AS st (NOLOCK)
WHERE st.StaffID = @StaffID

GO