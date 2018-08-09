Attribute VB_Name = "CPromoMod"
Option Explicit
'-----constants
Private Const cModName As String = "CPromoMod"

'-----enum item type constants
Public Const cptsPromoEnumFindType As Long = 1
Public Const cptsPromoEnumStatus As Long = 15409
Public Const cptsPromoEnumTargetArea As Long = 15410
Public Const cptsPromoEnumTargetType As Long = 15411

'-----enum FindType constants
Public Const cptsPromoFindPromoName As Long = 15405
Public Const cptsPromoFindSendDate As Long = 15416
Public Const cptsPromoFindStatus As Long = 15409

'-----enum Status constants
Public Const cptsPromoStatusCompose As Long = 1
Public Const cptsPromoStatusReady As Long = 2
Public Const cptsPromoStatusSent As Long = 3
Public Const cptsPromoStatusCancelled As Long = 4

'-----enum TargetArea constants
Public Const cptsPromoTargetAreaZip As Long = 1
Public Const cptsPromoTargetAreaCity As Long = 2
Public Const cptsPromoTargetAreaState As Long = 3

'-----enum TargetType constants
Public Const cptsPromoTargetTypeTargetType1 As Long = 1
Public Const cptsPromoTargetTypeTargetType2 As Long = 2
Public Const cptsPromoTargetTypeTargetType3 As Long = 3
Public Const cptsPromoTargetTypeTargetType4 As Long = 4
Public Const cptsPromoTargetTypeTargetType5 As Long = 5