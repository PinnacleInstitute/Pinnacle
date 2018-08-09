EXEC [dbo].pts_CheckProc 'pts_Finance_ListMember'
GO

CREATE PROCEDURE [dbo].pts_Finance_ListMember
   @MemberID int
AS

SET NOCOUNT ON

SELECT      .FinanceID, 
         ***ERROR WTENTITY/WTATTRIBUTE Invalid Name - TitleDate ***.TitleDate, 
         ***ERROR WTENTITY/WTATTRIBUTE Invalid Name - Title ***.Title, 
         .TitleName, 
         ***ERROR WTENTITY/WTATTRIBUTE Invalid Name - IsEarned ***.IsEarned
WHERE (.MemberID = @MemberID)

ORDER BY   ***ERROR WTENTITY/WTATTRIBUTE Invalid Name - TitleDate ***.TitleDate DESC

GO