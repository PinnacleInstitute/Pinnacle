VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CQuizAnswerB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CQuizAnswer"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tQuizAnswerType
   QuizAnswerID As String
   SessionLessonID As String
   QuizQuestionID As String
   QuizChoiceID As String
   Question As String
   Explain As String
   QuizChoiceText As String
   IsCorrect As String
   CreateDate As String
End Type

Public Sub Add( _ 
   ByRef brRec As tQuizAnswerType, _ 
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
      .Parameters.Append .CreateParameter("@QuizAnswerID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SessionLessonID", adInteger, adParamInput, vbNull, CLng(brRec.SessionLessonID))
      .Parameters.Append .CreateParameter("@QuizQuestionID", adInteger, adParamInput, vbNull, CLng(brRec.QuizQuestionID))
      .Parameters.Append .CreateParameter("@QuizChoiceID", adInteger, adParamInput, vbNull, CLng(brRec.QuizChoiceID))
      .Parameters.Append .CreateParameter("@IsCorrect", adSmallInt, adParamInput, vbNull, CInt(brRec.IsCorrect))
      .Parameters.Append .CreateParameter("@CreateDate", adDate, adParamInput, vbNull, CDate(brRec.CreateDate))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_QuizAnswer_Add"

   '-----get return values
   With brRec
      .QuizAnswerID = moUtil.FetchLong(oCmd.Parameters.Item("@QuizAnswerID").Value)
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

Public Function Grade( _ 
   ByRef brRec As tQuizAnswerType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Grade"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SessionLessonID", adInteger, adParamInput, vbNull, CLng(brRec.SessionLessonID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
      .Parameters.Append .CreateParameter("@QuizAnswerID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_QuizAnswer_Grade"

   '-----get return values
   Grade = moUtil.FetchLong(oCmd.Parameters.Item("@QuizAnswerID").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Sub Fetch( _ 
   ByRef brRec As tQuizAnswerType, _ 
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
      .QuizAnswerID = moUtil.EditLong(.QuizAnswerID, "QuizAnswerID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@QuizAnswerID", adInteger, adParamInput, vbNull, CLng(brRec.QuizAnswerID))
      .Parameters.Append .CreateParameter("@SessionLessonID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@QuizQuestionID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@QuizChoiceID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Question", adVarWChar, adParamOutput, 2000, vbNull)
      .Parameters.Append .CreateParameter("@Explain", adVarWChar, adParamOutput, 1000, vbNull)
      .Parameters.Append .CreateParameter("@QuizChoiceText", adVarWChar, adParamOutput, 1000, vbNull)
      .Parameters.Append .CreateParameter("@IsCorrect", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CreateDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_QuizAnswer_Fetch"

   '-----get return values
   With brRec
      .SessionLessonID = moUtil.FetchLong(oCmd.Parameters.Item("@SessionLessonID").Value)
      .QuizQuestionID = moUtil.FetchLong(oCmd.Parameters.Item("@QuizQuestionID").Value)
      .QuizChoiceID = moUtil.FetchLong(oCmd.Parameters.Item("@QuizChoiceID").Value)
      .Question = moUtil.FetchString(oCmd.Parameters.Item("@Question").Value)
      .Explain = moUtil.FetchString(oCmd.Parameters.Item("@Explain").Value)
      .QuizChoiceText = moUtil.FetchString(oCmd.Parameters.Item("@QuizChoiceText").Value)
      .IsCorrect = moUtil.FetchInteger(oCmd.Parameters.Item("@IsCorrect").Value)
      .CreateDate = moUtil.FetchDate(oCmd.Parameters.Item("@CreateDate").Value)
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

Public Function ListQuizAnswer( _ 
   ByVal bvSessionLessonID As Long, _ 
   ByVal bvUserID As Long) As tQuizAnswerType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListQuizAnswer"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tQuizAnswerType
   Dim vRec As tQuizAnswerType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SessionLessonID", adInteger, adParamInput, vbNull, CLng(bvSessionLessonID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_QuizAnswer_ListQuizAnswer")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.QuizAnswerID = moUtil.FetchLong(.Fields.Item("QuizAnswerID").Value)
            vRec.QuizQuestionID = moUtil.FetchLong(.Fields.Item("QuizQuestionID").Value)
            vRec.QuizChoiceID = moUtil.FetchLong(.Fields.Item("QuizChoiceID").Value)
            vRec.IsCorrect = moUtil.FetchInteger(.Fields.Item("IsCorrect").Value)
            vRec.Question = moUtil.FetchString(.Fields.Item("Question").Value)
            vRec.Explain = moUtil.FetchString(.Fields.Item("Explain").Value)
            vRec.QuizChoiceText = moUtil.FetchString(.Fields.Item("QuizChoiceText").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListQuizAnswer = vRecs

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

Public Function ListQuizQuestion( _ 
   ByVal bvSessionLessonID As Long, _ 
   ByVal bvUserID As Long) As tQuizAnswerType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListQuizQuestion"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tQuizAnswerType
   Dim vRec As tQuizAnswerType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SessionLessonID", adInteger, adParamInput, vbNull, CLng(bvSessionLessonID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_QuizAnswer_ListQuizQuestion")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.QuizAnswerID = moUtil.FetchLong(.Fields.Item("QuizAnswerID").Value)
            vRec.QuizQuestionID = moUtil.FetchLong(.Fields.Item("QuizQuestionID").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListQuizQuestion = vRecs

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
   ByRef brRec As tQuizAnswerType, _ 
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
      .Parameters.Append .CreateParameter("@QuizAnswerID", adInteger, adParamInput, vbNull, CLng(brRec.QuizAnswerID))
      .Parameters.Append .CreateParameter("@SessionLessonID", adInteger, adParamInput, vbNull, CLng(brRec.SessionLessonID))
      .Parameters.Append .CreateParameter("@QuizQuestionID", adInteger, adParamInput, vbNull, CLng(brRec.QuizQuestionID))
      .Parameters.Append .CreateParameter("@QuizChoiceID", adInteger, adParamInput, vbNull, CLng(brRec.QuizChoiceID))
      .Parameters.Append .CreateParameter("@IsCorrect", adSmallInt, adParamInput, vbNull, CInt(brRec.IsCorrect))
      .Parameters.Append .CreateParameter("@CreateDate", adDate, adParamInput, vbNull, CDate(brRec.CreateDate))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_QuizAnswer_Update"

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
   ByRef brRec As tQuizAnswerType, _ 
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
         .QuizAnswerID = moUtil.EditLong(.QuizAnswerID, "QuizAnswerID", True, , 1) 
      End If
      .SessionLessonID = moUtil.EditLong(.SessionLessonID, "SessionLessonID", False) 
      .QuizQuestionID = moUtil.EditLong(.QuizQuestionID, "QuizQuestionID", False) 
      .QuizChoiceID = moUtil.EditLong(.QuizChoiceID, "QuizChoiceID", False) 
      .IsCorrect = moUtil.EditInteger(.IsCorrect, "IsCorrect", False, 0, 0, 1) 
      .CreateDate = moUtil.EditDate(.CreateDate, "CreateDate", False) 
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