VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CAssessChoiceB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CAssessChoice"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tAssessChoiceType
   AssessChoiceID As String
   AssessQuestionID As String
   Choice As String
   Seq As String
   Points As String
   NextQuestion As String
   Courses As String
   AssessmentID As String
   Grp As String
End Type

Public Sub Add( _ 
   ByRef brRec As tAssessChoiceType, _ 
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
      .Parameters.Append .CreateParameter("@AssessChoiceID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AssessQuestionID", adInteger, adParamInput, vbNull, CLng(brRec.AssessQuestionID))
      .Parameters.Append .CreateParameter("@Choice", adVarWChar, adParamInput, 200, brRec.Choice)
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@Points", adInteger, adParamInput, vbNull, CLng(brRec.Points))
      .Parameters.Append .CreateParameter("@NextQuestion", adInteger, adParamInput, vbNull, CLng(brRec.NextQuestion))
      .Parameters.Append .CreateParameter("@Courses", adVarWChar, adParamInput, 50, brRec.Courses)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_AssessChoice_Add"

   '-----get return values
   With brRec
      .AssessChoiceID = moUtil.FetchLong(oCmd.Parameters.Item("@AssessChoiceID").Value)
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

Public Sub Delete( _ 
   ByRef brRec As tAssessChoiceType, _ 
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
      .AssessChoiceID = moUtil.EditLong(.AssessChoiceID, "AssessChoiceID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AssessChoiceID", adInteger, adParamInput, vbNull, CLng(brRec.AssessChoiceID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_AssessChoice_Delete"

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
   ByRef brRec As tAssessChoiceType, _ 
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
      .AssessChoiceID = moUtil.EditLong(.AssessChoiceID, "AssessChoiceID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AssessChoiceID", adInteger, adParamInput, vbNull, CLng(brRec.AssessChoiceID))
      .Parameters.Append .CreateParameter("@AssessQuestionID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Choice", adVarWChar, adParamOutput, 200, vbNull)
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Points", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NextQuestion", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Courses", adVarWChar, adParamOutput, 50, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_AssessChoice_Fetch"

   '-----get return values
   With brRec
      .AssessQuestionID = moUtil.FetchLong(oCmd.Parameters.Item("@AssessQuestionID").Value)
      .Choice = moUtil.FetchString(oCmd.Parameters.Item("@Choice").Value)
      .Seq = moUtil.FetchLong(oCmd.Parameters.Item("@Seq").Value)
      .Points = moUtil.FetchLong(oCmd.Parameters.Item("@Points").Value)
      .NextQuestion = moUtil.FetchLong(oCmd.Parameters.Item("@NextQuestion").Value)
      .Courses = moUtil.FetchString(oCmd.Parameters.Item("@Courses").Value)
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

Public Function ListAssessment( _ 
   ByVal bvAssessmentID As Long, _ 
   ByVal bvUserID As Long) As tAssessChoiceType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListAssessment"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAssessChoiceType
   Dim vRec As tAssessChoiceType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvAssessmentID = moUtil.EditLong(bvAssessmentID, "AssessmentID", True, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AssessmentID", adInteger, adParamInput, vbNull, CLng(bvAssessmentID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_AssessChoice_ListAssessment")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.AssessChoiceID = moUtil.FetchLong(.Fields.Item("AssessChoiceID").Value)
            vRec.AssessQuestionID = moUtil.FetchLong(.Fields.Item("AssessQuestionID").Value)
            vRec.Choice = moUtil.FetchString(.Fields.Item("Choice").Value)
            vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
            vRec.Points = moUtil.FetchLong(.Fields.Item("Points").Value)
            vRec.NextQuestion = moUtil.FetchLong(.Fields.Item("NextQuestion").Value)
            vRec.Courses = moUtil.FetchString(.Fields.Item("Courses").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListAssessment = vRecs

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

Public Function ListAssessQuestion( _ 
   ByVal bvAssessQuestionID As Long, _ 
   ByVal bvUserID As Long) As tAssessChoiceType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListAssessQuestion"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAssessChoiceType
   Dim vRec As tAssessChoiceType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvAssessQuestionID = moUtil.EditLong(bvAssessQuestionID, "AssessQuestionID", True, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AssessQuestionID", adInteger, adParamInput, vbNull, CLng(bvAssessQuestionID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_AssessChoice_ListAssessQuestion")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.AssessChoiceID = moUtil.FetchLong(.Fields.Item("AssessChoiceID").Value)
            vRec.AssessQuestionID = moUtil.FetchLong(.Fields.Item("AssessQuestionID").Value)
            vRec.Choice = moUtil.FetchString(.Fields.Item("Choice").Value)
            vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
            vRec.Points = moUtil.FetchLong(.Fields.Item("Points").Value)
            vRec.NextQuestion = moUtil.FetchLong(.Fields.Item("NextQuestion").Value)
            vRec.Courses = moUtil.FetchString(.Fields.Item("Courses").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListAssessQuestion = vRecs

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

Public Function ListQuestionText( _ 
   ByVal bvCourses As String) As tAssessChoiceType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListQuestionText"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAssessChoiceType
   Dim vRec As tAssessChoiceType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvCourses = moUtil.EditString(bvCourses, "Courses", True, "", 1, 50) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Courses", adVarWChar, adParamInput, 50, bvCourses)
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_AssessChoice_ListQuestionText")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.AssessChoiceID = moUtil.FetchLong(.Fields.Item("AssessChoiceID").Value)
            vRec.AssessQuestionID = moUtil.FetchLong(.Fields.Item("AssessQuestionID").Value)
            vRec.Choice = moUtil.FetchString(.Fields.Item("Choice").Value)
            vRec.Points = moUtil.FetchLong(.Fields.Item("Points").Value)
            vRec.NextQuestion = moUtil.FetchLong(.Fields.Item("NextQuestion").Value)
            vRec.Courses = moUtil.FetchString(.Fields.Item("Courses").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListQuestionText = vRecs

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

Public Function ListGroup( _ 
   ByVal bvAssessmentID As Long, _ 
   ByVal bvGrp As Long, _ 
   ByVal bvUserID As Long) As tAssessChoiceType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListGroup"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAssessChoiceType
   Dim vRec As tAssessChoiceType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvAssessmentID = moUtil.EditLong(bvAssessmentID, "AssessmentID", True, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AssessmentID", adInteger, adParamInput, vbNull, CLng(bvAssessmentID))
      .Parameters.Append .CreateParameter("@Grp", adInteger, adParamInput, vbNull, CLng(bvGrp))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_AssessChoice_ListGroup")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.AssessChoiceID = moUtil.FetchLong(.Fields.Item("AssessChoiceID").Value)
            vRec.AssessQuestionID = moUtil.FetchLong(.Fields.Item("AssessQuestionID").Value)
            vRec.Choice = moUtil.FetchString(.Fields.Item("Choice").Value)
            vRec.Points = moUtil.FetchLong(.Fields.Item("Points").Value)
            vRec.NextQuestion = moUtil.FetchLong(.Fields.Item("NextQuestion").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListGroup = vRecs

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
   ByRef brRec As tAssessChoiceType, _ 
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
      .Parameters.Append .CreateParameter("@AssessChoiceID", adInteger, adParamInput, vbNull, CLng(brRec.AssessChoiceID))
      .Parameters.Append .CreateParameter("@AssessQuestionID", adInteger, adParamInput, vbNull, CLng(brRec.AssessQuestionID))
      .Parameters.Append .CreateParameter("@Choice", adVarWChar, adParamInput, 200, brRec.Choice)
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@Points", adInteger, adParamInput, vbNull, CLng(brRec.Points))
      .Parameters.Append .CreateParameter("@NextQuestion", adInteger, adParamInput, vbNull, CLng(brRec.NextQuestion))
      .Parameters.Append .CreateParameter("@Courses", adVarWChar, adParamInput, 50, brRec.Courses)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_AssessChoice_Update"

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
   ByRef brRec As tAssessChoiceType, _ 
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
         .AssessChoiceID = moUtil.EditLong(.AssessChoiceID, "AssessChoiceID", True, , 1) 
      End If
      .AssessQuestionID = moUtil.EditLong(.AssessQuestionID, "AssessQuestionID", False) 
      .Choice = moUtil.EditString(.Choice, "Choice", False, , 1, 200) 
      .Seq = moUtil.EditLong(.Seq, "Seq", False) 
      .Points = moUtil.EditLong(.Points, "Points", False) 
      .NextQuestion = moUtil.EditLong(.NextQuestion, "NextQuestion", False) 
      .Courses = moUtil.EditString(.Courses, "Courses", False, , 1, 50) 
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