EXEC [dbo].pts_CheckProc 'pts_Staff_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Staff_Delete ( 
   @StaffID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE st
FROM Staff AS st
WHERE st.StaffID = @StaffID

GO