Attribute VB_Name = "CBarterAdMod"
Option Explicit
'-----constants
Private Const cModName As String = "CBarterAdMod"

'-----enum item type constants
Public Const cptsBarterAdEnumFindType As Long = 1
Public Const cptsBarterAdEnumStatus As Long = 17211
Public Const cptsBarterAdEnumCondition As Long = 17236

'-----enum FindType constants
Public Const cptsBarterAdFindPostDate As Long = 17212
Public Const cptsBarterAdFindUpdateDate As Long = 17213
Public Const cptsBarterAdFindTitle As Long = 17210
Public Const cptsBarterAdFindBarterAdID As Long = 17201

'-----enum Status constants
Public Const cptsBarterAdStatusPending As Long = 1
Public Const cptsBarterAdStatusActive As Long = 2
Public Const cptsBarterAdStatusSold As Long = 3
Public Const cptsBarterAdStatusInActive As Long = 4
Public Const cptsBarterAdStatusCancelled As Long = 5

'-----enum Condition constants
Public Const cptsBarterAdConditionNew As Long = 1
Public Const cptsBarterAdConditionLikeNew As Long = 2
Public Const cptsBarterAdConditionExellent As Long = 3
Public Const cptsBarterAdConditionGood As Long = 4
Public Const cptsBarterAdConditionFair As Long = 5
Public Const cptsBarterAdConditionPoor As Long = 6
Public Const cptsBarterAdConditionSalvage As Long = 7