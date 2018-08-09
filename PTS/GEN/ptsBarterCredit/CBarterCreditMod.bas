Attribute VB_Name = "CBarterCreditMod"
Option Explicit
'-----constants
Private Const cModName As String = "CBarterCreditMod"

'-----enum item type constants
Public Const cptsBarterCreditEnumFindType As Long = 1
Public Const cptsBarterCreditEnumStatus As Long = 17412
Public Const cptsBarterCreditEnumCreditType As Long = 17413

'-----enum FindType constants
Public Const cptsBarterCreditFindCreditDate As Long = 17410
Public Const cptsBarterCreditFindCreditType As Long = 17413

'-----enum Status constants
Public Const cptsBarterCreditStatusActive As Long = 1
Public Const cptsBarterCreditStatusExpired As Long = 2
Public Const cptsBarterCreditStatusCancelled As Long = 3
Public Const cptsBarterCreditStatusReconcilled As Long = 4

'-----enum CreditType constants
Public Const cptsBarterCreditCreditTypeCredit As Long = 1
Public Const cptsBarterCreditCreditTypeDebit_Title As Long = 2
Public Const cptsBarterCreditCreditTypeDebit_Image As Long = 3
Public Const cptsBarterCreditCreditTypeDebit_Image2 As Long = 4
Public Const cptsBarterCreditCreditTypeDebit_Editor As Long = 5
Public Const cptsBarterCreditCreditTypeDebit_Long As Long = 6
Public Const cptsBarterCreditCreditTypeDebit_Listing As Long = 7
Public Const cptsBarterCreditCreditTypeDebit_Bundle1 As Long = 8
Public Const cptsBarterCreditCreditTypeDebit_Bundle2 As Long = 9
Public Const cptsBarterCreditCreditTypeTransfer As Long = 99