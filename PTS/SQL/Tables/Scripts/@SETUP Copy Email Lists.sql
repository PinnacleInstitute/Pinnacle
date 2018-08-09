-- Copy Email Lists from Company to Company
DECLARE @FromCompanyID int, @ToCompanyID int  
SET @FromCompanyID = 18
SET @ToCompanyID = 19

INSERT INTO EmailList (CompanyID, EmailListName, SourceType, CustomID, Param1, Param2, Param3, Param4, Param5 ) 
SELECT @ToCompanyID, EmailListName, SourceType, CustomID, Param1, Param2, Param3, Param4, Param5 FROM EmailList WHERE CompanyID = @FromCompanyID

select * from EmailList where CompanyID = @ToCompanyID

