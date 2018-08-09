Attribute VB_Name = "CExpenseMod"
Option Explicit
'-----constants
Private Const cModName As String = "CExpenseMod"

'-----enum item type constants
Public Const cptsExpenseEnumFindType As Long = 1
Public Const cptsExpenseEnumExpType As Long = 6410

'-----enum FindType constants
Public Const cptsExpenseFindExpDate As Long = 6411
Public Const cptsExpenseFindAmount As Long = 6413
Public Const cptsExpenseFindPurpose As Long = 6419
Public Const cptsExpenseFindNote1 As Long = 6417
Public Const cptsExpenseFindNote2 As Long = 6418

'-----enum ExpType constants
Public Const cptsExpenseExpTypeMileage As Long = 1
Public Const cptsExpenseExpTypeMeals As Long = 2
Public Const cptsExpenseExpTypeTravel As Long = 3
Public Const cptsExpenseExpTypeHomeOffice As Long = 4
Public Const cptsExpenseExpTypeMisc As Long = 5