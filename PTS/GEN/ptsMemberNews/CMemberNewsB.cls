VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CMemberNewsB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CMemberNews"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tMemberNewsType
   MemberNewsID As String
   MemberID As String
   NewsLetterID As String
   NewsLetterName As String
   Description As String
   CompanyName As String
   NameLast As String
   NameFirst As String
   MemberName As String
   EnrollDate As String
End Type

Public Sub Add( _ 
   ByRef brRec As tMemberNewsType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Add the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Add"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oCtx As ObjectContext

   On Error GoTo ErrorHandler

   '-----get the object context for this transaction
   If moSys.IsMTS Then Set oCtx = GetObjectContext()

   '-----edit the input parameters
   Validate brRec, bvUserID, 1

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberNewsID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@NewsLetterID", adInteger, adParamInput, vbNull, CLng(brRec.NewsLetterID))
      .Parameters.Append .CreateParameter("@EnrollDate", adDate, adParamInput, vbNull, CDate(brRec.EnrollDate))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MemberNews_Add"

   '-----get return values
   With brRec
      .MemberNewsID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberNewsID").Value)
   End With

   '-----clean up
   If moSys.IsMTS Then oCtx.SetComplete
   Set oCtx = Nothing
   Set oCmd = Nothing

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   If moSys.IsMTS Then oCtx.SetAbort
   Set oCtx = Nothing
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Function DeleteMember( _ 
   ByRef brRec As tMemberNewsType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "DeleteMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", True, 0) 
      .NewsLetterID = moUtil.EditLong(.NewsLetterID, "NewsLetterID", True, 0) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@NewsLetterID", adInteger, adParamInput, vbNull, CLng(brRec.NewsLetterID))
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MemberNews_DeleteMember"

   '-----get return values
   DeleteMember = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function GetMember( _ 
   ByRef brRec As tMemberNewsType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "GetMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", True, 0) 
      .NewsLetterID = moUtil.EditLong(.NewsLetterID, "NewsLetterID", True, 0) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@NewsLetterID", adInteger, adParamInput, vbNull, CLng(brRec.NewsLetterID))
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MemberNews_GetMember"

   '-----get return values
   GetMember = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Sub Delete( _ 
   ByRef brRec As tMemberNewsType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Delete the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Delete"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oCtx As ObjectContext

   On Error GoTo ErrorHandler

   '-----get the object context for this transaction
   If moSys.IsMTS Then Set oCtx = GetObjectContext()

   '-----edit the input parameters
   With brRec
      .MemberNewsID = moUtil.EditLong(.MemberNewsID, "MemberNewsID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberNewsID", adInteger, adParamInput, vbNull, CLng(brRec.MemberNewsID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MemberNews_Delete"

   '-----clean up
   If moSys.IsMTS Then oCtx.SetComplete
   Set oCtx = Nothing
   Set oCmd = Nothing

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   If moSys.IsMTS Then oCtx.SetAbort
   Set oCtx = Nothing
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub Fetch( _ 
   ByRef brRec As tMemberNewsType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Fetch"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .MemberNewsID = moUtil.EditLong(.MemberNewsID, "MemberNewsID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberNewsID", adInteger, adParamInput, vbNull, CLng(brRec.MemberNewsID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NewsLetterID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NewsLetterName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamOutput, 200, vbNull)
      .Parameters.Append .CreateParameter("@CompanyName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@MemberName", adVarWChar, adParamOutput, 62, vbNull)
      .Parameters.Append .CreateParameter("@EnrollDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MemberNews_Fetch"

   '-----get return values
   With brRec
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .NewsLetterID = moUtil.FetchLong(oCmd.Parameters.Item("@NewsLetterID").Value)
      .NewsLetterName = moUtil.FetchString(oCmd.Parameters.Item("@NewsLetterName").Value)
      .Description = moUtil.FetchString(oCmd.Parameters.Item("@Description").Value)
      .CompanyName = moUtil.FetchString(oCmd.Parameters.Item("@CompanyName").Value)
      .NameLast = moUtil.FetchString(oCmd.Parameters.Item("@NameLast").Value)
      .NameFirst = moUtil.FetchString(oCmd.Parameters.Item("@NameFirst").Value)
      .MemberName = moUtil.FetchString(oCmd.Parameters.Item("@MemberName").Value)
      .EnrollDate = moUtil.FetchDate(oCmd.Parameters.Item("@EnrollDate").Value)
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

Public Function ListMember( _ 
   ByVal bvMemberID As Long) As tMemberNewsType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberNewsType
   Dim vRec As tMemberNewsType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MemberNews_ListMember")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MemberNewsID = moUtil.FetchLong(.Fields.Item("MemberNewsID").Value)
            vRec.NewsLetterID = moUtil.FetchLong(.Fields.Item("NewsLetterID").Value)
            vRec.NewsLetterName = moUtil.FetchString(.Fields.Item("NewsLetterName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.CompanyName = moUtil.FetchString(.Fields.Item("CompanyName").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.EnrollDate = moUtil.FetchDate(.Fields.Item("EnrollDate").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListMember = vRecs

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

Public Sub Update( _ 
   ByRef brRec As tMemberNewsType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Updates the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Update"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oCtx As ObjectContext

   On Error GoTo ErrorHandler

   '-----get the object context for this transaction
   If moSys.IsMTS Then Set oCtx = GetObjectContext()

   '-----edit the input parameters
   Validate brRec, bvUserID

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberNewsID", adInteger, adParamInput, vbNull, CLng(brRec.MemberNewsID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@NewsLetterID", adInteger, adParamInput, vbNull, CLng(brRec.NewsLetterID))
      .Parameters.Append .CreateParameter("@EnrollDate", adDate, adParamInput, vbNull, CDate(brRec.EnrollDate))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MemberNews_Update"

   '-----clean up
   If moSys.IsMTS Then oCtx.SetComplete
   Set oCtx = Nothing
   Set oCmd = Nothing

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   If moSys.IsMTS Then oCtx.SetAbort
   Set oCtx = Nothing
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub Validate( _ 
   ByRef brRec As tMemberNewsType, _ 
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
         .MemberNewsID = moUtil.EditLong(.MemberNewsID, "MemberNewsID", True, , 1) 
      End If
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", True) 
      .NewsLetterID = moUtil.EditLong(.NewsLetterID, "NewsLetterID", True) 
      .EnrollDate = moUtil.EditDate(.EnrollDate, "EnrollDate", True) 
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