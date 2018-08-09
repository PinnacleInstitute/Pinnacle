--SELECT CompanyID,AffiliateID,BillingID,CompanyName,CompanyType,Status,NameLast,NameFirst,Street,
--Unit,City,State,Zip,Country,Email,Phone1,Phone2,Fax,Price,IsCatalog,IsDiscount,Billing,PromoCode,AccessLimit,QuizLimit,
--MemberLimit,EnrollDate,TrialDays,IsTrialPayment,IsSignIn,IsJoinNow,RefName
--FROM company

--SELECT OrgID,AffiliateID,BillingID,OrgName,OrgType,Status,NameLast,NameFirst,Street,
--Unit,City,State,Zip,Country,Email,Phone1,Phone2,Fax,Price,IsCatalog,IsDiscount,Billing,PromoCode,AccessLimit,QuizLimit,
--MemberLimit,EnrollDate,TrialDays,IsTrialPayment,IsSignIn,IsJoinNow,RefName
--FROM ORG WHERE ParentID = 0


--SET IDENTITY_INSERT to ON.
SET	IDENTITY_INSERT Company ON

--Add the default sysadmin record
INSERT INTO	Company
(
CompanyID,AffiliateID,BillingID,CompanyName,CompanyType,Status,NameLast,NameFirst,Street,
Unit,City,State,Zip,Country,Email,Phone1,Phone2,Fax,Price,IsCatalog,IsDiscount,Billing,PromoCode,AccessLimit,QuizLimit,
MemberLimit,EnrollDate,TrialDays,IsTrialPayment,IsSignIn,IsJoinNow,RefName
)

SELECT OrgID,AffiliateID,BillingID,OrgName,OrgType,Status,NameLast,NameFirst,Street,
Unit,City,State,Zip,Country,Email,Phone1,Phone2,Fax,Price,IsCatalog,IsDiscount,Billing,PromoCode,AccessLimit,QuizLimit,
MemberLimit,EnrollDate,TrialDays,IsTrialPayment,IsSignIn,IsJoinNow,RefName
FROM ORG WHERE ParentID = 0

SET IDENTITY_INSERT Company OFF

DBCC CHECKIDENT ('Company', RESEED, 550)

GO
