EXEC [dbo].pts_CheckProc 'pts_Expense_FindTypeExpDate'
 GO

CREATE PROCEDURE [dbo].pts_Expense_FindTypeExpDate ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @MemberID int,
   @ExpType int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20
IF (@Bookmark = '') SET @Bookmark = '99991231'
IF (ISDATE(@SearchText) = 1)
            SET @SearchText = CONVERT(nvarchar(10), CONVERT(datetime, @SearchText), 112)
ELSE
            SET @SearchText = ''


SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), ex.ExpDate, 112), '') + dbo.wtfn_FormatNumber(ex.ExpenseID, 10) 'BookMark' ,
            ex.ExpenseID 'ExpenseID' ,
            ex.MemberID 'MemberID' ,
            ex.ExpenseTypeID 'ExpenseTypeID' ,
            ext.ExpenseTypeName 'ExpenseTypeName' ,
            ext.TaxType 'TaxType' ,
            ext.IsRequired 'IsRequired' ,
            ex.ExpType 'ExpType' ,
            ex.ExpDate 'ExpDate' ,
            ex.Total 'Total' ,
            ex.Amount 'Amount' ,
            ex.MilesStart 'MilesStart' ,
            ex.MilesEnd 'MilesEnd' ,
            ex.TotalMiles 'TotalMiles' ,
            ex.Note1 'Note1' ,
            ex.Note2 'Note2' ,
            ex.Purpose 'Purpose'
FROM Expense AS ex (NOLOCK)
LEFT OUTER JOIN ExpenseType AS ext (NOLOCK) ON (ex.ExpenseTypeID = ext.ExpenseTypeID)
WHERE ISNULL(CONVERT(nvarchar(10), ex.ExpDate, 112), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), ex.ExpDate, 112), '') + dbo.wtfn_FormatNumber(ex.ExpenseID, 10) <= @BookMark
AND         (ex.MemberID = @MemberID)
AND         (ex.ExpType = @ExpType)
ORDER BY 'Bookmark' DESC

GO