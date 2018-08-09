Attribute VB_Name = "CSuggestionMod"
Option Explicit
'-----constants
Private Const cModName As String = "CSuggestionMod"

'-----enum item type constants
Public Const cptsSuggestionEnumFindType As Long = 1
Public Const cptsSuggestionEnumStatus As Long = 4512

'-----enum FindType constants
Public Const cptsSuggestionFindSuggestionDate As Long = 4513
Public Const cptsSuggestionFindSuggestionID As Long = 4501
Public Const cptsSuggestionFindSubject As Long = 4510
Public Const cptsSuggestionFindResponse As Long = 4514

'-----enum Status constants
Public Const cptsSuggestionStatusUnread As Long = 1
Public Const cptsSuggestionStatusRead As Long = 2
Public Const cptsSuggestionStatusAccept As Long = 3
Public Const cptsSuggestionStatusReward As Long = 4