EXEC [dbo].pts_CheckProc 'pts_Expense_FindNote2'
 GO

CREATE PROCEDURE [dbo].pts_Expense_FindNote2 ( 
   @SearchText nvarchar (100),
   @Bookmark nvarchar (110),
   @MaxRows tinyint OUTPUT,
   @MemberID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(ex.Note2, '') + dbo.wtfn_FormatNumber(ex.ExpenseID, 10) 'BookMark' ,
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
WHERE ISNULL(ex.Note2, '') LIKE '%' + @SearchText + '%'
AND ISNULL(ex.Note2, '') + dbo.wtfn_FormatNumber(ex.ExpenseID, 10) >= @BookMark
AND         (ex.MemberID = @MemberID)
ORDER BY 'Bookmark'

GO