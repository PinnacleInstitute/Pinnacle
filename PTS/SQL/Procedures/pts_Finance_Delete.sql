EXEC [dbo].pts_CheckProc 'pts_Finance_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Finance_Delete ( 
   @FinanceID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE fi
FROM Finance AS fi
WHERE fi.FinanceID = @FinanceID

GO