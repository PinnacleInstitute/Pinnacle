VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CAssessAnswerB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CAssessAnswer"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tAssessAnswerType
   AssessAnswerID As String
   MemberAssessID As String
   AssessQuestionID As String
   AssessChoiceID As String
   Discrimination As String
   Difficulty As String
   Guessing As String
   UseCount As String
   Answer As String
   AnswerDate As String
   AnswerText As String
   MemberID As String
   AssessmentID As String
   Grp As String
   Questions As String
End Type

Public Sub Add( _ 
   ByRef brRec As tAssessAnswerType, _ 
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
      .Parameters.Append .CreateParameter("@AssessAnswerID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberAssessID", adInteger, adParamInput, vbNull, CLng(brRec.MemberAssessID))
      .Parameters.Append .CreateParameter("@AssessQuestionID", adInteger, adParamInput, vbNull, CLng(brRec.AssessQuestionID))
      .Parameters.Append .CreateParameter("@AssessChoiceID", adInteger, adParamInput, vbNull, CLng(brRec.AssessChoiceID))
      .Parameters.Append .CreateParameter("@Answer", adInteger, adParamInput, vbNull, CLng(brRec.Answer))
      .Parameters.Append .CreateParameter("@AnswerDate", adDate, adParamInput, vbNull, CDate(brRec.AnswerDate))
      .Parameters.Append .CreateParameter("@AnswerText", adVarWChar, adParamInput, 500, brRec.AnswerText)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_AssessAnswer_Add"

   '-----get return values
   With brRec
      .AssessAnswerID = moUtil.FetchLong(oCmd.Parameters.Item("@AssessAnswerID").Value)
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

Public Function Count( _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the number of records.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Count"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("Return", adInteger, adParamReturnValue, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With
   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_AssessAnswer_Count"

   '-----get return values
   Count = moUtil.FetchLong(oCmd.Parameters.Item("Return").Value)

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
   ByRef brRec As tAssessAnswerType, _ 
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
      .AssessAnswerID = moUtil.EditLong(.AssessAnswerID, "AssessAnswerID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AssessAnswerID", adInteger, adParamInput, vbNull, CLng(brRec.AssessAnswerID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_AssessAnswer_Delete"

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
   ByRef brRec As tAssessAnswerType, _ 
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
      .AssessAnswerID = moUtil.EditLong(.AssessAnswerID, "AssessAnswerID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AssessAnswerID", adInteger, adParamInput, vbNull, CLng(brRec.AssessAnswerID))
      .Parameters.Append .CreateParameter("@MemberAssessID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AssessQuestionID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AssessChoiceID", adInteger, adParamOutput, vbNull, vbNull)
      Dim tmpParamDiscrimination As ADODB.Parameter
      Set tmpParamDiscrimination = .CreateParameter("@Discrimination", adNumeric, adParamOutput, 10, vbNull)
      tmpParamDiscrimination.Precision = 10
      tmpParamDiscrimination.NumericScale = 8
      .Parameters.Append tmpParamDiscrimination
      Dim tmpParamDifficulty As ADODB.Parameter
      Set tmpParamDifficulty = .CreateParameter("@Difficulty", adNumeric, adParamOutput, 10, vbNull)
      tmpParamDifficulty.Precision = 10
      tmpParamDifficulty.NumericScale = 8
      .Parameters.Append tmpParamDifficulty
      Dim tmpParamGuessing As ADODB.Parameter
      Set tmpParamGuessing = .CreateParameter("@Guessing", adNumeric, adParamOutput, 10, vbNull)
      tmpParamGuessing.Precision = 10
      tmpParamGuessing.NumericScale = 8
      .Parameters.Append tmpParamGuessing
      .Parameters.Append .CreateParameter("@UseCount", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Answer", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AnswerDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AnswerText", adVarWChar, adParamOutput, 500, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_AssessAnswer_Fetch"

   '-----get return values
   With brRec
      .MemberAssessID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberAssessID").Value)
      .AssessQuestionID = moUtil.FetchLong(oCmd.Parameters.Item("@AssessQuestionID").Value)
      .AssessChoiceID = moUtil.FetchLong(oCmd.Parameters.Item("@AssessChoiceID").Value)
      .Discrimination = moUtil.FetchDouble(oCmd.Parameters.Item("@Discrimination").Value)
      .Difficulty = moUtil.FetchDouble(oCmd.Parameters.Item("@Difficulty").Value)
      .Guessing = moUtil.FetchDouble(oCmd.Parameters.Item("@Guessing").Value)
      .UseCount = moUtil.FetchLong(oCmd.Parameters.Item("@UseCount").Value)
      .Answer = moUtil.FetchLong(oCmd.Parameters.Item("@Answer").Value)
      .AnswerDate = moUtil.FetchDate(oCmd.Parameters.Item("@AnswerDate").Value)
      .AnswerText = moUtil.FetchString(oCmd.Parameters.Item("@AnswerText").Value)
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

Public Function ListGroup( _ 
   ByVal bvMemberAssessID As Long, _ 
   ByVal bvAssessmentID As Long, _ 
   ByVal bvGrp As Long, _ 
   ByVal bvUserID As Long) As tAssessAnswerType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListGroup"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAssessAnswerType
   Dim vRec As tAssessAnswerType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvMemberAssessID = moUtil.EditLong(bvMemberAssessID, "MemberAssessID", True, 0) 
      bvAssessmentID = moUtil.EditLong(bvAssessmentID, "AssessmentID", True, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberAssessID", adInteger, adParamInput, vbNull, CLng(bvMemberAssessID))
      .Parameters.Append .CreateParameter("@AssessmentID", adInteger, adParamInput, vbNull, CLng(bvAssessmentID))
      .Parameters.Append .CreateParameter("@Grp", adInteger, adParamInput, vbNull, CLng(bvGrp))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_AssessAnswer_ListGroup")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.AssessAnswerID = moUtil.FetchLong(.Fields.Item("AssessAnswerID").Value)
            vRec.AssessQuestionID = moUtil.FetchLong(.Fields.Item("AssessQuestionID").Value)
            vRec.AssessChoiceID = moUtil.FetchLong(.Fields.Item("AssessChoiceID").Value)
            vRec.Answer = moUtil.FetchLong(.Fields.Item("Answer").Value)
            vRec.AnswerDate = moUtil.FetchDate(.Fields.Item("AnswerDate").Value)
            vRec.AnswerText = moUtil.FetchString(.Fields.Item("AnswerText").Value)
            vRec.Discrimination = moUtil.FetchDouble(.Fields.Item("Discrimination").Value)
            vRec.Difficulty = moUtil.FetchDouble(.Fields.Item("Difficulty").Value)
            vRec.Guessing = moUtil.FetchDouble(.Fields.Item("Guessing").Value)
            vRec.UseCount = moUtil.FetchLong(.Fields.Item("UseCount").Value)
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

Public Function ListAnswers( _ 
   ByVal bvMemberAssessID As Long, _ 
   ByVal bvUserID As Long) As tAssessAnswerType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListAnswers"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAssessAnswerType
   Dim vRec As tAssessAnswerType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvMemberAssessID = moUtil.EditLong(bvMemberAssessID, "MemberAssessID", True, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberAssessID", adInteger, adParamInput, vbNull, CLng(bvMemberAssessID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_AssessAnswer_ListAnswers")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.AssessAnswerID = moUtil.FetchLong(.Fields.Item("AssessAnswerID").Value)
            vRec.AssessQuestionID = moUtil.FetchLong(.Fields.Item("AssessQuestionID").Value)
            vRec.AssessChoiceID = moUtil.FetchLong(.Fields.Item("AssessChoiceID").Value)
            vRec.Answer = moUtil.FetchLong(.Fields.Item("Answer").Value)
            vRec.AnswerDate = moUtil.FetchDate(.Fields.Item("AnswerDate").Value)
            vRec.AnswerText = moUtil.FetchString(.Fields.Item("AnswerText").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListAnswers = vRecs

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
   ByVal bvQuestions As String) As tAssessAnswerType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListQuestionText"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAssessAnswerType
   Dim vRec As tAssessAnswerType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvQuestions = moUtil.EditString(bvQuestions, "Questions", True, "", 1, 50) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Questions", adVarWChar, adParamInput, 50, bvQuestions)
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_AssessAnswer_ListQuestionText")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.AssessAnswerID = moUtil.FetchLong(.Fields.Item("AssessAnswerID").Value)
            vRec.AssessQuestionID = moUtil.FetchLong(.Fields.Item("AssessQuestionID").Value)
            vRec.AssessChoiceID = moUtil.FetchLong(.Fields.Item("AssessChoiceID").Value)
            vRec.Answer = moUtil.FetchLong(.Fields.Item("Answer").Value)
            vRec.AnswerDate = moUtil.FetchDate(.Fields.Item("AnswerDate").Value)
            vRec.AnswerText = moUtil.FetchString(.Fields.Item("AnswerText").Value)
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

Public Sub Update( _ 
   ByRef brRec As tAssessAnswerType, _ 
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
      .Parameters.Append .CreateParameter("@AssessAnswerID", adInteger, adParamInput, vbNull, CLng(brRec.AssessAnswerID))
      .Parameters.Append .CreateParameter("@MemberAssessID", adInteger, adParamInput, vbNull, CLng(brRec.MemberAssessID))
      .Parameters.Append .CreateParameter("@AssessQuestionID", adInteger, adParamInput, vbNull, CLng(brRec.AssessQuestionID))
      .Parameters.Append .CreateParameter("@AssessChoiceID", adInteger, adParamInput, vbNull, CLng(brRec.AssessChoiceID))
      .Parameters.Append .CreateParameter("@Answer", adInteger, adParamInput, vbNull, CLng(brRec.Answer))
      .Parameters.Append .CreateParameter("@AnswerDate", adDate, adParamInput, vbNull, CDate(brRec.AnswerDate))
      .Parameters.Append .CreateParameter("@AnswerText", adVarWChar, adParamInput, 500, brRec.AnswerText)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_AssessAnswer_Update"

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
   ByRef brRec As tAssessAnswerType, _ 
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
         .AssessAnswerID = moUtil.EditLong(.AssessAnswerID, "AssessAnswerID", True, , 1) 
      End If
      .MemberAssessID = moUtil.EditLong(.MemberAssessID, "MemberAssessID", True) 
      .AssessQuestionID = moUtil.EditLong(.AssessQuestionID, "AssessQuestionID", True) 
      .AssessChoiceID = moUtil.EditLong(.AssessChoiceID, "AssessChoiceID", False) 
      .Answer = moUtil.EditLong(.Answer, "Answer", False) 
      .AnswerDate = moUtil.EditDate(.AnswerDate, "AnswerDate", False) 
      .AnswerText = moUtil.EditString(.AnswerText, "AnswerText", False, , 1, 500) 
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