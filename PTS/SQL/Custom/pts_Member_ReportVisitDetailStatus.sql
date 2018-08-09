EXEC [dbo].pts_CheckProc 'pts_Member_ReportVisitDetailStatus'
GO

CREATE PROCEDURE [dbo].pts_Member_ReportVisitDetailStatus
   @CompanyID int,
   @Quantity int,
   @Status int
AS

SET NOCOUNT ON

IF @Quantity = 32
BEGIN
	SELECT TOP 1000 MemberID, LTRIM(RTRIM(NameLast)) +  ', '  + LTRIM(RTRIM(NameFirst)) 'MemberName', CompanyName, VisitDate FROM Member
	WHERE VisitDate = 0
	AND (@CompanyID = 0 OR CompanyID = @CompanyID) AND Status = @Status
END
IF @Quantity = 1
BEGIN
	SELECT TOP 1000 MemberID, LTRIM(RTRIM(NameLast)) +  ', '  + LTRIM(RTRIM(NameFirst)) 'MemberName', CompanyName, VisitDate FROM Member
	WHERE DATEDIFF(dd, VisitDate, CURRENT_TIMESTAMP) <= 1
	AND (@CompanyID = 0 OR CompanyID = @CompanyID) AND Status = @Status
	ORDER BY VisitDate DESC
END
IF @Quantity = 3
BEGIN
	SELECT TOP 1000 MemberID, LTRIM(RTRIM(NameLast)) +  ', '  + LTRIM(RTRIM(NameFirst)) 'MemberName', CompanyName, VisitDate FROM Member
	WHERE DATEDIFF(dd, VisitDate, CURRENT_TIMESTAMP) > 1
	AND DATEDIFF(dd, VisitDate, CURRENT_TIMESTAMP) <= 3
	AND ( Status < 4 )
	AND (@CompanyID = 0 OR CompanyID = @CompanyID) AND Status = @Status
	ORDER BY VisitDate DESC
END
IF @Quantity = 7
BEGIN
	SELECT TOP 1000 MemberID, LTRIM(RTRIM(NameLast)) +  ', '  + LTRIM(RTRIM(NameFirst)) 'MemberName', CompanyName, VisitDate FROM Member
	WHERE DATEDIFF(dd, VisitDate, CURRENT_TIMESTAMP) > 3
	AND DATEDIFF(wk, VisitDate, CURRENT_TIMESTAMP) <= 1
	AND (@CompanyID = 0 OR CompanyID = @CompanyID) AND Status = @Status
	ORDER BY VisitDate DESC
END
IF @Quantity = 14
BEGIN
	SELECT TOP 1000 MemberID, LTRIM(RTRIM(NameLast)) +  ', '  + LTRIM(RTRIM(NameFirst)) 'MemberName', CompanyName, VisitDate FROM Member
	WHERE DATEDIFF(wk, VisitDate, CURRENT_TIMESTAMP) > 1
	AND DATEDIFF(wk, VisitDate, CURRENT_TIMESTAMP) <= 2
	AND (@CompanyID = 0 OR CompanyID = @CompanyID) AND Status = @Status
	ORDER BY VisitDate DESC
END
IF @Quantity = 30
BEGIN
	SELECT TOP 1000 MemberID, LTRIM(RTRIM(NameLast)) +  ', '  + LTRIM(RTRIM(NameFirst)) 'MemberName', CompanyName, VisitDate FROM Member
	WHERE DATEDIFF(wk, VisitDate, CURRENT_TIMESTAMP) > 2
	AND DATEDIFF(m, VisitDate, CURRENT_TIMESTAMP) <= 1
	AND (@CompanyID = 0 OR CompanyID = @CompanyID) AND Status = @Status
	ORDER BY VisitDate DESC
END
IF @Quantity = 31
BEGIN
	SELECT TOP 1000 MemberID, LTRIM(RTRIM(NameLast)) +  ', '  + LTRIM(RTRIM(NameFirst)) 'MemberName', CompanyName, VisitDate FROM Member
	WHERE DATEDIFF(m, VisitDate, CURRENT_TIMESTAMP) > 1
	AND VisitDate != 0
	AND (@CompanyID = 0 OR CompanyID = @CompanyID) AND Status = @Status
	ORDER BY VisitDate DESC
END


GO