-- Copy Support Lists from Company to Company
DECLARE @FromCompanyID int, @ToCompanyID int  
SET @FromCompanyID = 18
SET @ToCompanyID = 19

-- Copy Support Question Topics
INSERT INTO QuestionType (CompanyID, QuestionTypeName, Seq, UserType, Secure) 
SELECT @ToCompanyID, QuestionTypeName, Seq, UserType, Secure FROM QuestionType WHERE CompanyID = @FromCompanyID

select * from QuestionType where CompanyID = @ToCompanyID

-- Copy Support Ticket Topics
INSERT INTO IssueCategory (CompanyID, IssueCategoryName, Seq, UserType, InputOptions) 
SELECT @ToCompanyID, IssueCategoryName, Seq, UserType, InputOptions FROM IssueCategory WHERE CompanyID = @FromCompanyID

select * from IssueCategory where CompanyID = @ToCompanyID



