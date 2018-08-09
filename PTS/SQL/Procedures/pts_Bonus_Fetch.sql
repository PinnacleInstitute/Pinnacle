EXEC [dbo].pts_CheckProc 'pts_Bonus_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Bonus_Fetch ( 
   @BonusID int,
   @CompanyID int OUTPUT,
   @MemberID int OUTPUT,
   @TitleName nvarchar (40) OUTPUT,
   @BonusDate datetime OUTPUT,
   @Title int OUTPUT,
   @BV money OUTPUT,
   @QV money OUTPUT,
   @Total money OUTPUT,
   @PaidDate datetime OUTPUT,
   @Reference varchar (20) OUTPUT,
   @IsPrivate bit OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = bo.CompanyID ,
   @MemberID = bo.MemberID ,
   @TitleName = ti.TitleName ,
   @BonusDate = bo.BonusDate ,
   @Title = bo.Title ,
   @BV = bo.BV ,
   @QV = bo.QV ,
   @Total = bo.Total ,
   @PaidDate = bo.PaidDate ,
   @Reference = bo.Reference ,
   @IsPrivate = bo.IsPrivate
FROM Bonus AS bo (NOLOCK)
LEFT OUTER JOIN Title AS ti (NOLOCK) ON (bo.CompanyID = ti.CompanyID AND bo.Title = ti.TitleNo)
WHERE bo.BonusID = @BonusID

GO