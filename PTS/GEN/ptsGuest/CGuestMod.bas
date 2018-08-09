Attribute VB_Name = "CGuestMod"
Option Explicit
'-----constants
Private Const cModName As String = "CGuestMod"

'-----enum item type constants
Public Const cptsGuestEnumStatus As Long = 2609

'-----enum Status constants
Public Const cptsGuestStatusNotSent As Long = 1
Public Const cptsGuestStatusSent As Long = 2
Public Const cptsGuestStatusAckYes As Long = 3
Public Const cptsGuestStatusAckNo As Long = 4
Public Const cptsGuestStatusAckMaybe As Long = 5