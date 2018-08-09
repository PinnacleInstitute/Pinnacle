Attribute VB_Name = "CCreditMod"
Option Explicit
'-----constants
Private Const cModName As String = "CCreditMod"

'-----enum item type constants
Public Const cptsCreditEnumCreditType As Long = 11006
Public Const cptsCreditEnumStatus As Long = 11007

'-----enum CreditType constants
Public Const cptsCreditCreditTypeCreditType1 As Long = 1
Public Const cptsCreditCreditTypeCreditType2 As Long = 2
Public Const cptsCreditCreditTypeCreditType3 As Long = 3
Public Const cptsCreditCreditTypeCreditType4 As Long = 4
Public Const cptsCreditCreditTypeCreditType5 As Long = 5

'-----enum Status constants
Public Const cptsCreditStatusPending As Long = 1
Public Const cptsCreditStatusActive As Long = 2
Public Const cptsCreditStatusInactive As Long = 3