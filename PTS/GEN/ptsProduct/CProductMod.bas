Attribute VB_Name = "CProductMod"
Option Explicit
'-----constants
Private Const cModName As String = "CProductMod"

'-----enum item type constants
Public Const cptsProductEnumFindType As Long = 1
Public Const cptsProductEnumFulfill As Long = 5032
Public Const cptsProductEnumRecur As Long = 5033
Public Const cptsProductEnumInventory As Long = 5039

'-----enum FindType constants
Public Const cptsProductFindProductName As Long = 5005
Public Const cptsProductFindProductTypeName As Long = 5004
Public Const cptsProductFindCode As Long = 5038

'-----enum Fulfill constants
Public Const cptsProductFulfillCourse As Long = 1
Public Const cptsProductFulfillAssessment As Long = 2
Public Const cptsProductFulfillDownload As Long = 3
Public Const cptsProductFulfillCustom As Long = 4
Public Const cptsProductFulfillShip As Long = 5

'-----enum Recur constants
Public Const cptsProductRecurMonthly As Long = 1
Public Const cptsProductRecurWeekly As Long = 2

'-----enum Inventory constants
Public Const cptsProductInventoryNone As Long = 1
Public Const cptsProductInventorySimple As Long = 2
Public Const cptsProductInventoryAdvanced As Long = 3