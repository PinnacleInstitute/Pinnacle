Attribute VB_Name = "CSignatureMod"
Option Explicit
'-----constants
Private Const cModName As String = "CSignatureMod"

'-----enum item type constants
Public Const cptsSignatureEnumUseType As Long = 6103

'-----enum UseType constants
Public Const cptsSignatureUseTypeDefault As Long = 1
Public Const cptsSignatureUseTypeLeadPage As Long = 2
Public Const cptsSignatureUseTypePresentation As Long = 3
Public Const cptsSignatureUseTypeLeadEmail As Long = 4
Public Const cptsSignatureUseTypeProspectEmail As Long = 5
Public Const cptsSignatureUseTypeCustomerEmail As Long = 6
Public Const cptsSignatureUseTypeWelcome As Long = 7
Public Const cptsSignatureUseTypeStory As Long = 8
Public Const cptsSignatureUseTypeVision As Long = 9
Public Const cptsSignatureUseTypeTestimony As Long = 10
Public Const cptsSignatureUseTypeInvite As Long = 11