Attribute VB_Name = "CCommissionMod"
Option Explicit
'-----constants
Private Const cModName As String = "CCommissionMod"

'-----enum item type constants
Public Const cptsCommissionEnumFindType As Long = 1
Public Const cptsCommissionEnumStatus As Long = 0911

'-----enum FindType constants
Public Const cptsCommissionFindCommDate As Long = 0910
Public Const cptsCommissionFindCommTypeName As Long = 0907
Public Const cptsCommissionFindCommissionID As Long = 0901
Public Const cptsCommissionFindAmount As Long = 0913
Public Const cptsCommissionFindDescription As Long = 0916
Public Const cptsCommissionFindOwnerID As Long = 0904

'-----enum Status constants
Public Const cptsCommissionStatusSubmitted As Long = 1
Public Const cptsCommissionStatusPayout As Long = 2