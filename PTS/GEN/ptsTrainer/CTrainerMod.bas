Attribute VB_Name = "CTrainerMod"
Option Explicit
'-----constants
Private Const cModName As String = "CTrainerMod"

'-----enum item type constants
Public Const cptsTrainerEnumFindType As Long = 1
Public Const cptsTrainerEnumUserGroup As Long = 0306
Public Const cptsTrainerEnumUserStatus As Long = 0307
Public Const cptsTrainerEnumStatus As Long = 0324
Public Const cptsTrainerEnumTier As Long = 0325

'-----enum FindType constants
Public Const cptsTrainerFindCompanyName As Long = 0310
Public Const cptsTrainerFindTrainerName As Long = 0313
Public Const cptsTrainerFindTrainerID As Long = 0301
Public Const cptsTrainerFindTier As Long = 0325
Public Const cptsTrainerFindStatus As Long = 0324
Public Const cptsTrainerFindEnrollDate As Long = 0338

'-----enum UserGroup constants
Public Const cptsTrainerUserGroupTrainer As Long = 31

'-----enum UserStatus constants
Public Const cptsTrainerUserStatusActive As Long = 1
Public Const cptsTrainerUserStatusInActive As Long = 2
Public Const cptsTrainerUserStatusReadOnly As Long = 3

'-----enum Status constants
Public Const cptsTrainerStatusPending As Long = 1
Public Const cptsTrainerStatusActive As Long = 2
Public Const cptsTrainerStatusInActive As Long = 3

'-----enum Tier constants
Public Const cptsTrainerTierTier1 As Long = 1
Public Const cptsTrainerTierTier2 As Long = 2
Public Const cptsTrainerTierTier3 As Long = 3