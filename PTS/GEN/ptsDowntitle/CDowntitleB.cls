VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CDownTitleB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CDownTitle"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tDownTitleType
   DownTitleID As String
   TitleName As String
   Line As String
   MemberID As String
   Leg As String
   Title As String
   Cnt As String
End Type

Public Sub Adjust( _ 
   ByRef brRec As tDownTitleType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Execute a Command
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Adjust"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .Line = moUtil.EditLong(.Line, "Line", True, 0) 
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", True, 0) 
      .Leg = moUtil.EditLong(.Leg, "Leg", True, 0) 
      .Title = moUtil.EditLong(.Title, "Title", True, 0) 
      .Cnt = moUtil.EditLong(.Cnt, "Cnt", True, 0) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Line", adInteger, adParamInput, vbNull, CLng(brRec.Line))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@Leg", adInteger, adParamInput, vbNull, CLng(brRec.Leg))
      .Parameters.Append .CreateParameter("@Title", adInteger, adParamInput, vbNull, CLng(brRec.Title))
      .Parameters.Append .CreateParameter("@Cnt", adInteger, adParamInput, vbNull, CLng(brRec.Cnt))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_DownTitle_Adjust"

   '-----clean up
   Set oCmd = Nothing

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Function Summary( _ 
   ByVal bvLine As Long, _ 
   ByVal bvMemberID As Long) As tDownTitleType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Summary"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tDownTitleType
   Dim vRec As tDownTitleType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Line", adInteger, adParamInput, vbNull, CLng(bvLine))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_DownTitle_Summary")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.DownTitleID = moUtil.FetchLong(.Fields.Item("DownTitleID").Value)
            vRec.Title = moUtil.FetchLong(.Fields.Item("Title").Value)
            vRec.Leg = moUtil.FetchLong(.Fields.Item("Leg").Value)
            vRec.Cnt = moUtil.FetchLong(.Fields.Item("Cnt").Value)
            vRec.TitleName = moUtil.FetchString(.Fields.Item("TitleName").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   Summary = vRecs

   '-----clean up
   Set oRecs = Nothing
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oRecs = Nothing
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Sub Validate( _ 
   ByRef brRec As tDownTitleType, _ 
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
         .DownTitleID = moUtil.EditLong(.DownTitleID, "DownTitleID", True, , 1) 
      End If
      .Line = moUtil.EditLong(.Line, "Line", False) 
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", False) 
      .Leg = moUtil.EditLong(.Leg, "Leg", False) 
      .Title = moUtil.EditLong(.Title, "Title", False) 
      .Cnt = moUtil.EditLong(.Cnt, "Cnt", False) 
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