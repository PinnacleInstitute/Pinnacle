VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CQuizQuestionB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CQuizQuestion"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tQuizQuestionType
   QuizQuestionID As String
   LessonID As String
   QuizChoiceID As String
   Question As String
   Explain As String
   Points As String
   IsRandom As String
   Seq As String
   MediaType As String
   MediaFile As String
End Type

Public Sub Add( _ 
   ByRef brRec As tQuizQuestionType, _ 
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
      .Parameters.Append .CreateParameter("@QuizQuestionID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@LessonID", adInteger, adParamInput, vbNull, CLng(brRec.LessonID))
      .Parameters.Append .CreateParameter("@QuizChoiceID", adInteger, adParamInput, vbNull, CLng(brRec.QuizChoiceID))
      .Parameters.Append .CreateParameter("@Question", adVarWChar, adParamInput, 2000, brRec.Question)
      .Parameters.Append .CreateParameter("@Explain", adVarWChar, adParamInput, 1000, brRec.Explain)
      .Parameters.Append .CreateParameter("@Points", adInteger, adParamInput, vbNull, CLng(brRec.Points))
      .Parameters.Append .CreateParameter("@IsRandom", adSmallInt, adParamInput, vbNull, CInt(brRec.IsRandom))
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@MediaType", adInteger, adParamInput, vbNull, CLng(brRec.MediaType))
      .Parameters.Append .CreateParameter("@MediaFile", adVarWChar, adParamInput, 80, brRec.MediaFile)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_QuizQuestion_Add"

   '-----get return values
   With brRec
      .QuizQuestionID = moUtil.FetchLong(oCmd.Parameters.Item("@QuizQuestionID").Value)
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
   ByRef brRec As tQuizQuestionType, _ 
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
      .QuizQuestionID = moUtil.EditLong(.QuizQuestionID, "QuizQuestionID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@QuizQuestionID", adInteger, adParamInput, vbNull, CLng(brRec.QuizQuestionID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_QuizQuestion_Delete"

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
   ByRef brRec As tQuizQuestionType, _ 
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
      .QuizQuestionID = moUtil.EditLong(.QuizQuestionID, "QuizQuestionID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@QuizQuestionID", adInteger, adParamInput, vbNull, CLng(brRec.QuizQuestionID))
      .Parameters.Append .CreateParameter("@LessonID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@QuizChoiceID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Question", adVarWChar, adParamOutput, 2000, vbNull)
      .Parameters.Append .CreateParameter("@Explain", adVarWChar, adParamOutput, 1000, vbNull)
      .Parameters.Append .CreateParameter("@Points", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsRandom", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MediaType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MediaFile", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_QuizQuestion_Fetch"

   '-----get return values
   With brRec
      .LessonID = moUtil.FetchLong(oCmd.Parameters.Item("@LessonID").Value)
      .QuizChoiceID = moUtil.FetchLong(oCmd.Parameters.Item("@QuizChoiceID").Value)
      .Question = moUtil.FetchString(oCmd.Parameters.Item("@Question").Value)
      .Explain = moUtil.FetchString(oCmd.Parameters.Item("@Explain").Value)
      .Points = moUtil.FetchLong(oCmd.Parameters.Item("@Points").Value)
      .IsRandom = moUtil.FetchInteger(oCmd.Parameters.Item("@IsRandom").Value)
      .Seq = moUtil.FetchLong(oCmd.Parameters.Item("@Seq").Value)
      .MediaType = moUtil.FetchLong(oCmd.Parameters.Item("@MediaType").Value)
      .MediaFile = moUtil.FetchString(oCmd.Parameters.Item("@MediaFile").Value)
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

Public Function ListQuizQuestion( _ 
   ByVal bvLessonID As Long, _ 
   ByVal bvUserID As Long) As tQuizQuestionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListQuizQuestion"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tQuizQuestionType
   Dim vRec As tQuizQuestionType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvLessonID = moUtil.EditLong(bvLessonID, "LessonID", True, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@LessonID", adInteger, adParamInput, vbNull, CLng(bvLessonID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_QuizQuestion_ListQuizQuestion")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.QuizQuestionID = moUtil.FetchLong(.Fields.Item("QuizQuestionID").Value)
            vRec.LessonID = moUtil.FetchLong(.Fields.Item("LessonID").Value)
            vRec.QuizChoiceID = moUtil.FetchLong(.Fields.Item("QuizChoiceID").Value)
            vRec.Question = moUtil.FetchString(.Fields.Item("Question").Value)
            vRec.Explain = moUtil.FetchString(.Fields.Item("Explain").Value)
            vRec.Points = moUtil.FetchLong(.Fields.Item("Points").Value)
            vRec.IsRandom = moUtil.FetchInteger(.Fields.Item("IsRandom").Value)
            vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
            vRec.MediaType = moUtil.FetchLong(.Fields.Item("MediaType").Value)
            vRec.MediaFile = moUtil.FetchString(.Fields.Item("MediaFile").Value)
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
   ByRef brRec As tQuizQuestionType, _ 
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
      .Parameters.Append .CreateParameter("@QuizQuestionID", adInteger, adParamInput, vbNull, CLng(brRec.QuizQuestionID))
      .Parameters.Append .CreateParameter("@LessonID", adInteger, adParamInput, vbNull, CLng(brRec.LessonID))
      .Parameters.Append .CreateParameter("@QuizChoiceID", adInteger, adParamInput, vbNull, CLng(brRec.QuizChoiceID))
      .Parameters.Append .CreateParameter("@Question", adVarWChar, adParamInput, 2000, brRec.Question)
      .Parameters.Append .CreateParameter("@Explain", adVarWChar, adParamInput, 1000, brRec.Explain)
      .Parameters.Append .CreateParameter("@Points", adInteger, adParamInput, vbNull, CLng(brRec.Points))
      .Parameters.Append .CreateParameter("@IsRandom", adSmallInt, adParamInput, vbNull, CInt(brRec.IsRandom))
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@MediaType", adInteger, adParamInput, vbNull, CLng(brRec.MediaType))
      .Parameters.Append .CreateParameter("@MediaFile", adVarWChar, adParamInput, 80, brRec.MediaFile)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_QuizQuestion_Update"

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
   ByRef brRec As tQuizQuestionType, _ 
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
         .QuizQuestionID = moUtil.EditLong(.QuizQuestionID, "QuizQuestionID", True, , 1) 
      End If
      .LessonID = moUtil.EditLong(.LessonID, "LessonID", False) 
      .QuizChoiceID = moUtil.EditLong(.QuizChoiceID, "QuizChoiceID", False) 
      .Question = moUtil.EditString(.Question, "Question", False, , 1, 2000) 
      .Explain = moUtil.EditString(.Explain, "Explain", False, , 1, 1000) 
      .Points = moUtil.EditLong(.Points, "Points", False) 
      .IsRandom = moUtil.EditInteger(.IsRandom, "IsRandom", False, 0, 0, 1) 
      .Seq = moUtil.EditLong(.Seq, "Seq", False) 
      .MediaType = moUtil.EditLong(.MediaType, "MediaType", False) 
      .MediaFile = moUtil.EditString(.MediaFile, "MediaFile", False, , 1, 80) 
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