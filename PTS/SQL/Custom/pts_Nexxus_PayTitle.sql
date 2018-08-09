EXEC [dbo].pts_CheckProc 'pts_Nexxus_PayTitle'
GO

--declare @Result varchar(1000) EXEC pts_Nexxus_PayTitle 12559, @Result output print @Result
--select * from Member where CompanyID = 21 order by MemberID desc

CREATE PROCEDURE [dbo].pts_Nexxus_PayTitle
   @MemberID int,
   @Code varchar(10)
AS

SET NOCOUNT ON

DECLARE @Title int, @Title2 int

IF @Code = '101' UPDATE Member SET Title2 = 3 WHERE MemberID = @MemberID
IF @Code = '102'
BEGIN
	IF @Title < 4
		UPDATE Member SET Title = 4, Title2 = 4 WHERE MemberID = @MemberID
	ELSE	
		UPDATE Member SET Title2 = 4 WHERE MemberID = @MemberID
END 
IF @Code = '103'
BEGIN
	SELECT @Title = Title FROM Member WHERE MemberID = @MemberID
	IF @Title < 5
		UPDATE Member SET Title = 5, Title2 = 5 WHERE MemberID = @MemberID
	ELSE	
		UPDATE Member SET Title2 = Title WHERE MemberID = @MemberID
END

GO

