Attribute VB_Name = "CMemberMod"
Option Explicit
'-----constants
Private Const cModName As String = "CMemberMod"

'-----enum item type constants
Public Const cptsMemberEnumFindType As Long = 1
Public Const cptsMemberEnumUserGroup As Long = 0413
Public Const cptsMemberEnumUserStatus As Long = 0414
Public Const cptsMemberEnumQualify As Long = 0428
Public Const cptsMemberEnumStatus As Long = 0435
Public Const cptsMemberEnumBilling As Long = 0449
Public Const cptsMemberEnumQuizLimit As Long = 0451
Public Const cptsMemberEnumTaxIDType As Long = 0462
Public Const cptsMemberEnumStatusChange As Long = 0467
Public Const cptsMemberEnumTimezone As Long = 0489

'-----enum FindType constants
Public Const cptsMemberFindMemberName As Long = 0419
Public Const cptsMemberFindCompanyName As Long = 0416
Public Const cptsMemberFindEnrollDate As Long = 0438
Public Const cptsMemberFindMemberID As Long = 0401
Public Const cptsMemberFindReference As Long = 0452
Public Const cptsMemberFindPhone1 As Long = 0432
Public Const cptsMemberFindStatus As Long = 0435
Public Const cptsMemberFindEmail As Long = 0430
Public Const cptsMemberFindMasterID As Long = 0455
Public Const cptsMemberFindGroupID As Long = 0470
Public Const cptsMemberFindRole As Long = 0471
Public Const cptsMemberFindInitPrice As Long = 0440
Public Const cptsMemberFindOptions2 As Long = 0474

'-----enum UserGroup constants
Public Const cptsMemberUserGroupMember As Long = 41

'-----enum UserStatus constants
Public Const cptsMemberUserStatusActive As Long = 1
Public Const cptsMemberUserStatusInActive As Long = 2
Public Const cptsMemberUserStatusReadOnly As Long = 3

'-----enum Qualify constants
Public Const cptsMemberQualifyQualifyNo As Long = 1
Public Const cptsMemberQualifyQualifyYes As Long = 2
Public Const cptsMemberQualifyQualifyLock As Long = 3

'-----enum Status constants
Public Const cptsMemberStatusPaid As Long = 1
Public Const cptsMemberStatusTrial As Long = 2
Public Const cptsMemberStatusFree As Long = 3
Public Const cptsMemberStatusSuspended As Long = 4
Public Const cptsMemberStatusInActive As Long = 5
Public Const cptsMemberStatusCancelled As Long = 6
Public Const cptsMemberStatusTerminated As Long = 7

'-----enum Billing constants
Public Const cptsMemberBillingBillNone As Long = 1
Public Const cptsMemberBillingBillCompany As Long = 2
Public Const cptsMemberBillingBillMember As Long = 3
Public Const cptsMemberBillingBillMaster As Long = 4
Public Const cptsMemberBillingBillManual As Long = 5

'-----enum QuizLimit constants
Public Const cptsMemberQuizLimitNoRetake As Long = 1
Public Const cptsMemberQuizLimitNoAnswer As Long = 2

'-----enum TaxIDType constants
Public Const cptsMemberTaxIDTypeTaxIDType1 As Long = 1
Public Const cptsMemberTaxIDTypeTaxIDType2 As Long = 2
Public Const cptsMemberTaxIDTypeTaxIDType3 As Long = 3
Public Const cptsMemberTaxIDTypeTaxIDType4 As Long = 4
Public Const cptsMemberTaxIDTypeTaxIDType5 As Long = 5
Public Const cptsMemberTaxIDTypeTaxIDType6 As Long = 6
Public Const cptsMemberTaxIDTypeTaxIDType7 As Long = 7
Public Const cptsMemberTaxIDTypeTaxIDType8 As Long = 8

'-----enum StatusChange constants
Public Const cptsMemberStatusChangePaid As Long = 1
Public Const cptsMemberStatusChangeTrial As Long = 2
Public Const cptsMemberStatusChangeFree As Long = 3
Public Const cptsMemberStatusChangeSuspended As Long = 4
Public Const cptsMemberStatusChangeInActive As Long = 5
Public Const cptsMemberStatusChangeCancelled As Long = 6
Public Const cptsMemberStatusChangeTerminated As Long = 7

'-----enum Timezone constants
Public Const cptsMemberTimezoneGMTm12 As Long = -12
Public Const cptsMemberTimezoneGMTm11 As Long = -11
Public Const cptsMemberTimezoneGMTm10 As Long = -10
Public Const cptsMemberTimezoneGMTm9 As Long = -9
Public Const cptsMemberTimezoneGMTm8 As Long = -8
Public Const cptsMemberTimezoneGMTm7 As Long = -7
Public Const cptsMemberTimezoneGMTm6 As Long = -6
Public Const cptsMemberTimezoneGMTm5 As Long = -5
Public Const cptsMemberTimezoneGMTm4 As Long = -4
Public Const cptsMemberTimezoneGMTm3 As Long = -3
Public Const cptsMemberTimezoneGMTm2 As Long = -2
Public Const cptsMemberTimezoneGMTm1 As Long = -1
Public Const cptsMemberTimezoneGMT As Long = 0
Public Const cptsMemberTimezoneGMTp1 As Long = 1
Public Const cptsMemberTimezoneGMTp2 As Long = 2
Public Const cptsMemberTimezoneGMTp3 As Long = 3
Public Const cptsMemberTimezoneGMTp4 As Long = 4
Public Const cptsMemberTimezoneGMTp5 As Long = 5
Public Const cptsMemberTimezoneGMTp6 As Long = 6
Public Const cptsMemberTimezoneGMTp7 As Long = 7
Public Const cptsMemberTimezoneGMTp8 As Long = 8
Public Const cptsMemberTimezoneGMTp9 As Long = 9
Public Const cptsMemberTimezoneGMTp10 As Long = 10
Public Const cptsMemberTimezoneGMTp11 As Long = 11
Public Const cptsMemberTimezoneGMTp12 As Long = 12