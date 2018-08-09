Attribute VB_Name = "CAttachmentMod"
Option Explicit
'-----constants
Private Const cModName As String = "CAttachmentMod"

'-----enum item type constants
Public Const cptsAttachmentEnumFindType As Long = 1
Public Const cptsAttachmentEnumStatus As Long = 8020

'-----enum FindType constants
Public Const cptsAttachmentFindAttachName As Long = 8010
Public Const cptsAttachmentFindDescription As Long = 8012
Public Const cptsAttachmentFindFileName As Long = 8011
Public Const cptsAttachmentFindAttachDate As Long = 8015

'-----enum Status constants
Public Const cptsAttachmentStatusActive As Long = 1
Public Const cptsAttachmentStatusInActive As Long = 2
Public Const cptsAttachmentStatusPrivate As Long = 3