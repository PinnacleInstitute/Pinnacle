VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CAdvanceB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CAdvance"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tAdvanceType
   AdvanceID As String
   MemberID As String
   Personal As String
   Group As String
   Title As String
   IsLocked As String
   Title1 As String
   Title2 As String
   Title3 As String
   Title4 As String
   Title5 As String
   Process As String
End Type

Public Function UpdateTitle( _ 
   ByRef brRec As tAdvanceType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "UpdateTitle"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", False, 0) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@Count", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Advance_UpdateTitle"

   '-----get return values
   UpdateTitle = moUtil.FetchLong(oCmd.Parameters.Item("@Count").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Sub FetchMember( _ 
   ByRef brRec As tAdvanceType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FetchMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", True, 0) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@AdvanceID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Personal", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Group", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Title", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsLocked", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Title1", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Title2", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Title3", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Title4", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Title5", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Advance_FetchMember"

   '-----get return values
   With brRec
      .AdvanceID = moUtil.FetchLong(oCmd.Parameters.Item("@AdvanceID").Value)
      .Personal = moUtil.FetchLong(oCmd.Parameters.Item("@Personal").Value)
      .Group = moUtil.FetchLong(oCmd.Parameters.Item("@Group").Value)
      .Title = moUtil.FetchLong(oCmd.Parameters.Item("@Title").Value)
      .IsLocked = moUtil.FetchInteger(oCmd.Parameters.Item("@IsLocked").Value)
      .Title1 = moUtil.FetchLong(oCmd.Parameters.Item("@Title1").Value)
      .Title2 = moUtil.FetchLong(oCmd.Parameters.Item("@Title2").Value)
      .Title3 = moUtil.FetchLong(oCmd.Parameters.Item("@Title3").Value)
      .Title4 = moUtil.FetchLong(oCmd.Parameters.Item("@Title4").Value)
      .Title5 = moUtil.FetchLong(oCmd.Parameters.Item("@Title5").Value)
   End With

   '-----clean up
   Set oCmd = Nothing

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub Validate( _ 
   ByRef brRec As tAdvanceType, _ 
   ByVal bvUserID As Long, _ 
   Optional ByVal bvNew As Integer = 0)
   '------------------------------------------------------------------------------------------------------------------------
   '   Validates the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Validate"
   '------------------------------------------------------------------------------------------------------------------------

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      If bvNew = 0 Then
         .AdvanceID = moUtil.EditLong(.AdvanceID, "AdvanceID", True, , 1) 
      End If
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", True) 
      .Personal = moUtil.EditLong(.Personal, "Personal", False) 
      .Group = moUtil.EditLong(.Group, "Group", False) 
      .Title = moUtil.EditLong(.Title, "Title", False) 
      .IsLocked = moUtil.EditInteger(.IsLocked, "IsLocked", False, 0, 0, 1) 
      .Title1 = moUtil.EditLong(.Title1, "Title1", False) 
      .Title2 = moUtil.EditLong(.Title2, "Title2", False) 
      .Title3 = moUtil.EditLong(.Title3, "Title3", False) 
      .Title4 = moUtil.EditLong(.Title4, "Title4", False) 
      .Title5 = moUtil.EditLong(.Title5, "Title5", False) 
      .Process = moUtil.EditLong(.Process, "Process", False) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Private Sub Class_Initialize()
   Set moSys = New wtSystem.CSystem
   Set moUtil = New wtSystem.CUtility
End Sub

Private Sub Class_Terminate()
   Set moSys = Nothing
   Set moUtil = Nothing
End Sub