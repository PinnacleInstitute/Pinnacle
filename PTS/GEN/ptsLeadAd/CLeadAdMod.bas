Attribute VB_Name = "CLeadAdMod"
Option Explicit
'-----constants
Private Const cModName As String = "CLeadAdMod"

'-----enum item type constants
Public Const cptsLeadAdEnumFindType As Long = 1
Public Const cptsLeadAdEnumStatus As Long = 15606

'-----enum FindType constants
Public Const cptsLeadAdFindLeadAdName As Long = 15605
Public Const cptsLeadAdFindTarget As Long = 15607
Public Const cptsLeadAdFindLeadAdID As Long = 15601
Public Const cptsLeadAdFindGroupID As Long = 15603

'-----enum Status constants
Public Const cptsLeadAdStatusPending As Long = 1
Public Const cptsLeadAdStatusActive As Long = 2
Public Const cptsLeadAdStatusInActive As Long = 3
Public Const cptsLeadAdStatusDivider As Long = 4