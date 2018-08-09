Attribute VB_Name = "CMachineMod"
Option Explicit
'-----constants
Private Const cModName As String = "CMachineMod"

'-----enum item type constants
Public Const cptsMachineEnumFindType As Long = 1
Public Const cptsMachineEnumStatus As Long = 10718
Public Const cptsMachineEnumService As Long = 10719

'-----enum FindType constants
Public Const cptsMachineFindMachineName As Long = 10714
Public Const cptsMachineFindEmail As Long = 10715

'-----enum Status constants
Public Const cptsMachineStatusSetup As Long = 1
Public Const cptsMachineStatusActive As Long = 2
Public Const cptsMachineStatusCancelled As Long = 3
Public Const cptsMachineStatusRemoved As Long = 4

'-----enum Service constants
Public Const cptsMachineServiceBackup As Long = 1
Public Const cptsMachineServiceBriefcase As Long = 2