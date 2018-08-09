Attribute VB_Name = "CCompanyMod"
Option Explicit
'-----constants
Private Const cModName As String = "CCompanyMod"

'-----enum item type constants
Public Const cptsCompanyEnumFindType As Long = 1
Public Const cptsCompanyEnumCompanyType As Long = 3806
Public Const cptsCompanyEnumStatus As Long = 3807

'-----enum FindType constants
Public Const cptsCompanyFindCompanyName As Long = 3805
Public Const cptsCompanyFindCompanyID As Long = 3801
Public Const cptsCompanyFindContactName As Long = 3810
Public Const cptsCompanyFindEmail As Long = 3817
Public Const cptsCompanyFindEnrollDate As Long = 3823
Public Const cptsCompanyFindStatus As Long = 3807
Public Const cptsCompanyFindCompanyType As Long = 3806

'-----enum CompanyType constants
Public Const cptsCompanyCompanyTypeCompanyType1 As Long = 1
Public Const cptsCompanyCompanyTypeCompanyType2 As Long = 2
Public Const cptsCompanyCompanyTypeCompanyType3 As Long = 3
Public Const cptsCompanyCompanyTypeCompanyType4 As Long = 4
Public Const cptsCompanyCompanyTypeCompanyType5 As Long = 5
Public Const cptsCompanyCompanyTypeCompanyType6 As Long = 6

'-----enum Status constants
Public Const cptsCompanyStatusSetup As Long = 1
Public Const cptsCompanyStatusActive As Long = 2
Public Const cptsCompanyStatusDemo As Long = 3
Public Const cptsCompanyStatusInactive As Long = 4