Attribute VB_Name = "CStatementMod"
Option Explicit
'-----constants
Private Const cModName As String = "CStatementMod"

'-----enum item type constants
Public Const cptsStatementEnumFindType As Long = 1
Public Const cptsStatementEnumStatus As Long = 16313
Public Const cptsStatementEnumPayType As Long = 16314

'-----enum FindType constants
Public Const cptsStatementFindStatementDate As Long = 16310
Public Const cptsStatementFindStatementID As Long = 16301
Public Const cptsStatementFindPaidDate As Long = 16311
Public Const cptsStatementFindAmount As Long = 16312

'-----enum Status constants
Public Const cptsStatementStatusSubmitted As Long = 1
Public Const cptsStatementStatusPending As Long = 2
Public Const cptsStatementStatusPaid As Long = 3
Public Const cptsStatementStatusDeclined As Long = 4
Public Const cptsStatementStatusCancelled As Long = 5

'-----enum PayType constants
Public Const cptsStatementPayTypeUnknown As Long = 0
Public Const cptsStatementPayTypeACH As Long = 1
Public Const cptsStatementPayTypeOther As Long = 2