EXEC [dbo].pts_CheckProc 'pts_Emailee_ListCustom'
GO
--EXEC pts_Emailee_ListCustom 9, 210, '1', '', '', '', ''

CREATE PROCEDURE [dbo].pts_Emailee_ListCustom
   @CompanyID int ,
   @EmailListID int ,
   @Data1 nvarchar (80) ,
   @Data2 nvarchar (80) ,
   @Data3 nvarchar (80) ,
   @Data4 nvarchar (80) ,
   @Data5 nvarchar (80)
AS

SET NOCOUNT ON

IF @EmailListID = 1 EXEC pts_Emailee_ListCustom_1_TrialMembership @Data1, @Data2, @Data3, @Data4, @Data5
IF @EmailListID = 2 EXEC pts_Emailee_ListCustom_2_MembersLastVisit @Data1, @Data2, @Data3, @Data4, @Data5
IF @EmailListID = 3 EXEC pts_Emailee_ListCustom_3_ClassesCompleted @Data1, @Data2, @Data3, @Data4, @Data5
IF @EmailListID = 4 EXEC pts_Emailee_ListCustom_4_MemberEnrollment @Data1, @Data2, @Data3, @Data4, @Data5
IF @EmailListID = 5 EXEC pts_Emailee_ListCustom_5_AllMembers @Data1, @Data2, @Data3, @Data4, @Data5
IF @EmailListID = 6 EXEC pts_Emailee_ListCustom_6_AssessmentsCompleted @Data1, @Data2, @Data3, @Data4, @Data5
IF @EmailListID = 7 EXEC pts_Emailee_ListCustom_7_SuggestionsSubmitted @Data1, @Data2, @Data3, @Data4, @Data5
IF @EmailListID = 8 EXEC pts_Emailee_ListCustom_8_MemberReference @Data1, @Data2, @Data3, @Data4, @Data5
IF @EmailListID = 9 EXEC pts_Emailee_ListCustom_9_PaymentNote @Data1, @Data2, @Data3, @Data4, @Data5
IF @EmailListID = 10 EXEC pts_Emailee_ListCustom_10_PaymentStatus @Data1, @Data2, @Data3, @Data4, @Data5
IF @EmailListID = 11 EXEC pts_Emailee_ListCustom_11_MemberLogon @Data1, @Data2, @Data3, @Data4, @Data5

-- COMPANY SPECIFIC LISTS ----------------------------------------------------------------------------
-- Member Enrollment Date Range
IF @EmailListID = 99 EXEC pts_Emailee_ListCustom_99 @CompanyID, @Data1, @Data2, @Data3, @Data4, @Data5
-- Members Geography
IF @EmailListID = 98 EXEC pts_Emailee_ListCustom_98 @CompanyID, @Data1, @Data2, @Data3, @Data4, @Data5
-- Business Memberships
IF @EmailListID = 97 EXEC pts_Emailee_ListCustom_97 @CompanyID, @Data1, @Data2, @Data3, @Data4, @Data5
-- Trial Memberships
IF @EmailListID = 96 EXEC pts_Emailee_ListCustom_96 @CompanyID, @Data1, @Data2, @Data3, @Data4, @Data5
-- Member Enrollment Day
IF @EmailListID = 95 EXEC pts_Emailee_ListCustom_95 @CompanyID, @Data1, @Data2, @Data3, @Data4, @Data5
-- Members Last Visit Day
IF @EmailListID = 94 EXEC pts_Emailee_ListCustom_94 @CompanyID, @Data1, @Data2, @Data3, @Data4, @Data5
-- Course Completed Day
IF @EmailListID = 93 EXEC pts_Emailee_ListCustom_93 @CompanyID, @Data1, @Data2, @Data3, @Data4, @Data5
-- Certification Completed Day
IF @EmailListID = 92 EXEC pts_Emailee_ListCustom_92 @CompanyID, @Data1, @Data2, @Data3, @Data4, @Data5
-- Course Complete Date Range
IF @EmailListID = 91 EXEC pts_Emailee_ListCustom_91 @CompanyID, @Data1, @Data2, @Data3, @Data4, @Data5
-- Certification Completed Date Range
IF @EmailListID = 90 EXEC pts_Emailee_ListCustom_90 @CompanyID, @Data1, @Data2, @Data3, @Data4, @Data5
-- Member Last Visit Date Range
IF @EmailListID = 89 EXEC pts_Emailee_ListCustom_89 @CompanyID, @Data1, @Data2, @Data3, @Data4, @Data5
-- Member Group Role
IF @EmailListID = 88 EXEC pts_Emailee_ListCustom_88 @CompanyID, @Data1, @Data2, @Data3, @Data4, @Data5
-- Business Members
IF @EmailListID = 87 EXEC pts_Emailee_ListCustom_87 @CompanyID, @Data1, @Data2, @Data3, @Data4, @Data5
-- Members Logon Information
IF @EmailListID = 86 EXEC pts_Emailee_ListCustom_86 @CompanyID, @Data1, @Data2, @Data3, @Data4, @Data5
-- Member Titles
IF @EmailListID = 85 EXEC pts_Emailee_ListCustom_85 @CompanyID, @Data1, @Data2, @Data3, @Data4, @Data5
-- Member Visit Date
IF @EmailListID = 84 EXEC pts_Emailee_ListCustom_84 @CompanyID, @Data1, @Data2, @Data3, @Data4, @Data5
-- Member Payment Paid
IF @EmailListID = 83 EXEC pts_Emailee_ListCustom_83 @CompanyID, @Data1, @Data2, @Data3, @Data4, @Data5
-- Member Bonus Paid
IF @EmailListID = 82 EXEC pts_Emailee_ListCustom_82 @CompanyID, @Data1, @Data2, @Data3, @Data4, @Data5
-- Declined Payments
IF @EmailListID = 81 EXEC pts_Emailee_ListCustom_81 @CompanyID, @Data1, @Data2, @Data3, @Data4, @Data5
-- Binary Members
IF @EmailListID = 80 EXEC pts_Emailee_ListCustom_80 @CompanyID, @Data1, @Data2, @Data3, @Data4, @Data5
-- Coded Teams
IF @EmailListID = 79 EXEC pts_Emailee_ListCustom_79 @CompanyID, @Data1, @Data2, @Data3, @Data4, @Data5
-- temp list
IF @EmailListID = 78 EXEC pts_Emailee_ListCustom_78 @CompanyID, @Data1, @Data2, @Data3, @Data4, @Data5

-- *********************
-- CloudZow Email Lists
-- *********************
-- Free Trial Customers
IF @EmailListID = 200 EXEC pts_Emailee_ListCustom_200 @CompanyID, @Data1, @Data2, @Data3, @Data4, @Data5
-- Active New Resellers
IF @EmailListID = 201 EXEC pts_Emailee_ListCustom_201 @CompanyID, @Data1, @Data2, @Data3, @Data4, @Data5
-- Active New Affiliates
IF @EmailListID = 202 EXEC pts_Emailee_ListCustom_202 @CompanyID, @Data1, @Data2, @Data3, @Data4, @Data5
-- Prospects on Sales Campaign #5
IF @EmailListID = 203 EXEC pts_Emailee_ListCustom_203 @CompanyID, @Data1, @Data2, @Data3, @Data4, @Data5
-- Computers with No Backup Data
IF @EmailListID = 204 EXEC pts_Emailee_ListCustom_204 @CompanyID, @Data1, @Data2, @Data3, @Data4, @Data5
-- Computers with No Backup Data Before a Date
IF @EmailListID = 205 EXEC pts_Emailee_ListCustom_205 @CompanyID, @Data1, @Data2, @Data3, @Data4, @Data5

-- *********************
-- New Member Email Lists
-- *********************
-- New Members
IF @EmailListID = 210 EXEC pts_Emailee_ListCustom_210 @CompanyID, @Data1, @Data2, @Data3, @Data4, @Data5

GO