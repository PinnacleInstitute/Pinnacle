EXEC [dbo].pts_CheckProc 'pts_Staff_List'
GO

CREATE PROCEDURE [dbo].pts_Staff_List
   @MerchantID int
AS

SET NOCOUNT ON

SELECT      st.StaffID, 
         st.ConsumerID, 
         st.StaffName, 
         st.Code, 
         st.Status, 
         st.StaffDate, 
         st.Access
FROM Staff AS st (NOLOCK)
WHERE (st.MerchantID = @MerchantID)

ORDER BY   st.StaffName

GO