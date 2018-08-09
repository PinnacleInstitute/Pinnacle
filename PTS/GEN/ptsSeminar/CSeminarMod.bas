Attribute VB_Name = "CSeminarMod"
Option Explicit
'-----constants
Private Const cModName As String = "CSeminarMod"

'-----enum item type constants
Public Const cptsSeminarEnumFindType As Long = 1
Public Const cptsSeminarEnumStatus As Long = 17712

'-----enum FindType constants
Public Const cptsSeminarFindSeminarName As Long = 17710
Public Const cptsSeminarFindDescription As Long = 17711

'-----enum Status constants
Public Const cptsSeminarStatusPending As Long = 1
Public Const cptsSeminarStatusActive As Long = 2
Public Const cptsSeminarStatusComplete As Long = 3
Public Const cptsSeminarStatusCancelled As Long = 4