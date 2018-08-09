VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CAssessQuestionB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CAssessQuestion"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tAssessQuestionType
   AssessQuestionID As String
   AssessmentID As String
   QuestionCode As String
   Question As String
   Description As String
   Grp As String
   Seq As String
   QuestionType As String
   RankMin As String
   RankMax As String
   ResultType As String
   Answer As String
   Points As String
   NextType As String
   NextQuestion As String
   Formula As String
   CustomCode As String
   MultiSelect As String
   MediaType As String
   MediaFile As String
   Courses As String
   Status As String
   Discrimination As String
   Difficulty As String
   Guessing As String
   UseCount As String
   MemberID As String
   NextGrp As String
   GroupMin As String
   GroupMax As String
   MemberAssessID As String
End Type

Public Sub Add( _ 
   ByRef brRec As tAssessQuestionType, _ 
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
      .Parameters.Append .CreateParameter("@AssessQuestionID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AssessmentID", adInteger, adParamInput, vbNull, CLng(brRec.AssessmentID))
      .Parameters.Append .CreateParameter("@QuestionCode", adInteger, adParamInput, vbNull, CLng(brRec.QuestionCode))
      .Parameters.Append .CreateParameter("@Question", adVarWChar, adParamInput, 1000, brRec.Question)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 2000, brRec.Description)
      .Parameters.Append .CreateParameter("@Grp", adInteger, adParamInput, vbNull, CLng(brRec.Grp))
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@QuestionType", adInteger, adParamInput, vbNull, CLng(brRec.QuestionType))
      .Parameters.Append .CreateParameter("@RankMin", adInteger, adParamInput, vbNull, CLng(brRec.RankMin))
      .Parameters.Append .CreateParameter("@RankMax", adInteger, adParamInput, vbNull, CLng(brRec.RankMax))
      .Parameters.Append .CreateParameter("@ResultType", adInteger, adParamInput, vbNull, CLng(brRec.ResultType))
      .Parameters.Append .CreateParameter("@Answer", adInteger, adParamInput, vbNull, CLng(brRec.Answer))
      .Parameters.Append .CreateParameter("@Points", adInteger, adParamInput, vbNull, CLng(brRec.Points))
      .Parameters.Append .CreateParameter("@NextType", adInteger, adParamInput, vbNull, CLng(brRec.NextType))
      .Parameters.Append .CreateParameter("@NextQuestion", adInteger, adParamInput, vbNull, CLng(brRec.NextQuestion))
      .Parameters.Append .CreateParameter("@Formula", adVarWChar, adParamInput, 100, brRec.Formula)
      .Parameters.Append .CreateParameter("@CustomCode", adInteger, adParamInput, vbNull, CLng(brRec.CustomCode))
      .Parameters.Append .CreateParameter("@MultiSelect", adSmallInt, adParamInput, vbNull, CInt(brRec.MultiSelect))
      .Parameters.Append .CreateParameter("@MediaType", adInteger, adParamInput, vbNull, CLng(brRec.MediaType))
      .Parameters.Append .CreateParameter("@MediaFile", adVarWChar, adParamInput, 80, brRec.MediaFile)
      .Parameters.Append .CreateParameter("@Courses", adVarWChar, adParamInput, 50, brRec.Courses)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      Dim tmpParamDiscrimination As ADODB.Parameter
      Set tmpParamDiscrimination = .CreateParameter("@Discrimination", adNumeric, adParamInput, 10, CDbl(brRec.Discrimination))
      tmpParamDiscrimination.Precision = 10
      tmpParamDiscrimination.NumericScale = 8
      .Parameters.Append tmpParamDiscrimination
      Dim tmpParamDifficulty As ADODB.Parameter
      Set tmpParamDifficulty = .CreateParameter("@Difficulty", adNumeric, adParamInput, 10, CDbl(brRec.Difficulty))
      tmpParamDifficulty.Precision = 10
      tmpParamDifficulty.NumericScale = 8
      .Parameters.Append tmpParamDifficulty
      Dim tmpParamGuessing As ADODB.Parameter
      Set tmpParamGuessing = .CreateParameter("@Guessing", adNumeric, adParamInput, 10, CDbl(brRec.Guessing))
      tmpParamGuessing.Precision = 10
      tmpParamGuessing.NumericScale = 8
      .Parameters.Append tmpParamGuessing
      .Parameters.Append .CreateParameter("@UseCount", adInteger, adParamInput, vbNull, CLng(brRec.UseCount))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_AssessQuestion_Add"

   '-----get return values
   With brRec
      .AssessQuestionID = moUtil.FetchLong(oCmd.Parameters.Item("@AssessQuestionID").Value)
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

Public Function GetNextQuestion( _ 
   ByRef brRec As tAssessQuestionType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "GetNextQuestion"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AssessQuestionID", adInteger, adParamInput, vbNull, CLng(brRec.AssessQuestionID))
      .Parameters.Append .CreateParameter("@MemberAssessID", adInteger, adParamInput, vbNull, CLng(brRec.MemberAssessID))
      .Parameters.Append .CreateParameter("@Next", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_AssessQuestion_GetNextQuestion"

   '-----get return values
   GetNextQuestion = moUtil.FetchLong(oCmd.Parameters.Item("@Next").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function NextCATQuestion( _ 
   ByRef brRec As tAssessQuestionType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "NextCATQuestion"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberAssessID", adInteger, adParamInput, vbNull, CLng(brRec.MemberAssessID))
      Dim tmpParamDifficulty As ADODB.Parameter
      Set tmpParamDifficulty = .CreateParameter("@Difficulty", adNumeric, adParamInput, 10, CDbl(brRec.Difficulty))
      tmpParamDifficulty.Precision = 10
      tmpParamDifficulty.NumericScale = 8
      .Parameters.Append tmpParamDifficulty
      .Parameters.Append .CreateParameter("@AssessQuestionID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_AssessQuestion_NextCATQuestion"

   '-----get return values
   NextCATQuestion = moUtil.FetchLong(oCmd.Parameters.Item("@AssessQuestionID").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function CATGroupCount( _ 
   ByRef brRec As tAssessQuestionType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CATGroupCount"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AssessQuestionID", adInteger, adParamInput, vbNull, CLng(brRec.AssessQuestionID))
      Dim tmpParamGroupMin As ADODB.Parameter
      Set tmpParamGroupMin = .CreateParameter("@GroupMin", adNumeric, adParamInput, 10, CDbl(brRec.GroupMin))
      tmpParamGroupMin.Precision = 10
      tmpParamGroupMin.NumericScale = 8
      .Parameters.Append tmpParamGroupMin
      Dim tmpParamGroupMax As ADODB.Parameter
      Set tmpParamGroupMax = .CreateParameter("@GroupMax", adNumeric, adParamInput, 10, CDbl(brRec.GroupMax))
      tmpParamGroupMax.Precision = 10
      tmpParamGroupMax.NumericScale = 8
      .Parameters.Append tmpParamGroupMax
      .Parameters.Append .CreateParameter("@UseCount", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_AssessQuestion_CATGroupCount"

   '-----get return values
   CATGroupCount = moUtil.FetchLong(oCmd.Parameters.Item("@UseCount").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function CATGroupCorrectCount( _ 
   ByRef brRec As tAssessQuestionType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CATGroupCorrectCount"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AssessQuestionID", adInteger, adParamInput, vbNull, CLng(brRec.AssessQuestionID))
      Dim tmpParamGroupMin As ADODB.Parameter
      Set tmpParamGroupMin = .CreateParameter("@GroupMin", adNumeric, adParamInput, 10, CDbl(brRec.GroupMin))
      tmpParamGroupMin.Precision = 10
      tmpParamGroupMin.NumericScale = 8
      .Parameters.Append tmpParamGroupMin
      Dim tmpParamGroupMax As ADODB.Parameter
      Set tmpParamGroupMax = .CreateParameter("@GroupMax", adNumeric, adParamInput, 10, CDbl(brRec.GroupMax))
      tmpParamGroupMax.Precision = 10
      tmpParamGroupMax.NumericScale = 8
      .Parameters.Append tmpParamGroupMax
      .Parameters.Append .CreateParameter("@UseCount", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_AssessQuestion_CATGroupCorrectCount"

   '-----get return values
   CATGroupCorrectCount = moUtil.FetchLong(oCmd.Parameters.Item("@UseCount").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

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
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_AssessQuestion_Count"

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
   ByRef brRec As tAssessQuestionType, _ 
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
      .AssessQuestionID = moUtil.EditLong(.AssessQuestionID, "AssessQuestionID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AssessQuestionID", adInteger, adParamInput, vbNull, CLng(brRec.AssessQuestionID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_AssessQuestion_Delete"

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
   ByRef brRec As tAssessQuestionType, _ 
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
      .AssessQuestionID = moUtil.EditLong(.AssessQuestionID, "AssessQuestionID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AssessQuestionID", adInteger, adParamInput, vbNull, CLng(brRec.AssessQuestionID))
      .Parameters.Append .CreateParameter("@AssessmentID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@QuestionCode", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Question", adVarWChar, adParamOutput, 1000, vbNull)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamOutput, 2000, vbNull)
      .Parameters.Append .CreateParameter("@Grp", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@QuestionType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@RankMin", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@RankMax", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ResultType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Answer", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Points", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NextType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NextQuestion", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Formula", adVarWChar, adParamOutput, 100, vbNull)
      .Parameters.Append .CreateParameter("@CustomCode", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MultiSelect", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MediaType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MediaFile", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@Courses", adVarWChar, adParamOutput, 50, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
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
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_AssessQuestion_Fetch"

   '-----get return values
   With brRec
      .AssessmentID = moUtil.FetchLong(oCmd.Parameters.Item("@AssessmentID").Value)
      .QuestionCode = moUtil.FetchLong(oCmd.Parameters.Item("@QuestionCode").Value)
      .Question = moUtil.FetchString(oCmd.Parameters.Item("@Question").Value)
      .Description = moUtil.FetchString(oCmd.Parameters.Item("@Description").Value)
      .Grp = moUtil.FetchLong(oCmd.Parameters.Item("@Grp").Value)
      .Seq = moUtil.FetchLong(oCmd.Parameters.Item("@Seq").Value)
      .QuestionType = moUtil.FetchLong(oCmd.Parameters.Item("@QuestionType").Value)
      .RankMin = moUtil.FetchLong(oCmd.Parameters.Item("@RankMin").Value)
      .RankMax = moUtil.FetchLong(oCmd.Parameters.Item("@RankMax").Value)
      .ResultType = moUtil.FetchLong(oCmd.Parameters.Item("@ResultType").Value)
      .Answer = moUtil.FetchLong(oCmd.Parameters.Item("@Answer").Value)
      .Points = moUtil.FetchLong(oCmd.Parameters.Item("@Points").Value)
      .NextType = moUtil.FetchLong(oCmd.Parameters.Item("@NextType").Value)
      .NextQuestion = moUtil.FetchLong(oCmd.Parameters.Item("@NextQuestion").Value)
      .Formula = moUtil.FetchString(oCmd.Parameters.Item("@Formula").Value)
      .CustomCode = moUtil.FetchLong(oCmd.Parameters.Item("@CustomCode").Value)
      .MultiSelect = moUtil.FetchInteger(oCmd.Parameters.Item("@MultiSelect").Value)
      .MediaType = moUtil.FetchLong(oCmd.Parameters.Item("@MediaType").Value)
      .MediaFile = moUtil.FetchString(oCmd.Parameters.Item("@MediaFile").Value)
      .Courses = moUtil.FetchString(oCmd.Parameters.Item("@Courses").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .Discrimination = moUtil.FetchDouble(oCmd.Parameters.Item("@Discrimination").Value)
      .Difficulty = moUtil.FetchDouble(oCmd.Parameters.Item("@Difficulty").Value)
      .Guessing = moUtil.FetchDouble(oCmd.Parameters.Item("@Guessing").Value)
      .UseCount = moUtil.FetchLong(oCmd.Parameters.Item("@UseCount").Value)
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

Public Sub LoadQuestionCode( _ 
   ByRef brRec As tAssessQuestionType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "LoadQuestionCode"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AssessmentID", adInteger, adParamInput, vbNull, CLng(brRec.AssessmentID))
      .Parameters.Append .CreateParameter("@QuestionCode", adInteger, adParamInput, vbNull, CLng(brRec.QuestionCode))
      .Parameters.Append .CreateParameter("@AssessQuestionID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NextGrp", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@QuestionType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Question", adVarWChar, adParamOutput, 1000, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_AssessQuestion_LoadQuestionCode"

   '-----get return values
   With brRec
      .AssessQuestionID = moUtil.FetchLong(oCmd.Parameters.Item("@AssessQuestionID").Value)
      .NextGrp = moUtil.FetchLong(oCmd.Parameters.Item("@NextGrp").Value)
      .QuestionType = moUtil.FetchLong(oCmd.Parameters.Item("@QuestionType").Value)
      .Question = moUtil.FetchString(oCmd.Parameters.Item("@Question").Value)
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

Public Sub LoadDefaultQuestion( _ 
   ByRef brRec As tAssessQuestionType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "LoadDefaultQuestion"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AssessmentID", adInteger, adParamInput, vbNull, CLng(brRec.AssessmentID))
      .Parameters.Append .CreateParameter("@Grp", adInteger, adParamInput, vbNull, CLng(brRec.Grp))
      .Parameters.Append .CreateParameter("@AssessQuestionID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NextGrp", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@QuestionType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Question", adVarWChar, adParamOutput, 1000, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_AssessQuestion_LoadDefaultQuestion"

   '-----get return values
   With brRec
      .AssessQuestionID = moUtil.FetchLong(oCmd.Parameters.Item("@AssessQuestionID").Value)
      .NextGrp = moUtil.FetchLong(oCmd.Parameters.Item("@NextGrp").Value)
      .QuestionType = moUtil.FetchLong(oCmd.Parameters.Item("@QuestionType").Value)
      .Question = moUtil.FetchString(oCmd.Parameters.Item("@Question").Value)
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
   ByVal bvUserID As Long) As tAssessQuestionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListAssessment"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAssessQuestionType
   Dim vRec As tAssessQuestionType
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
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_AssessQuestion_ListAssessment")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.AssessQuestionID = moUtil.FetchLong(.Fields.Item("AssessQuestionID").Value)
            vRec.AssessmentID = moUtil.FetchLong(.Fields.Item("AssessmentID").Value)
            vRec.QuestionCode = moUtil.FetchLong(.Fields.Item("QuestionCode").Value)
            vRec.Question = moUtil.FetchString(.Fields.Item("Question").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Grp = moUtil.FetchLong(.Fields.Item("Grp").Value)
            vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
            vRec.QuestionType = moUtil.FetchLong(.Fields.Item("QuestionType").Value)
            vRec.RankMin = moUtil.FetchLong(.Fields.Item("RankMin").Value)
            vRec.RankMax = moUtil.FetchLong(.Fields.Item("RankMax").Value)
            vRec.ResultType = moUtil.FetchLong(.Fields.Item("ResultType").Value)
            vRec.Answer = moUtil.FetchLong(.Fields.Item("Answer").Value)
            vRec.Points = moUtil.FetchLong(.Fields.Item("Points").Value)
            vRec.NextType = moUtil.FetchLong(.Fields.Item("NextType").Value)
            vRec.NextQuestion = moUtil.FetchLong(.Fields.Item("NextQuestion").Value)
            vRec.Formula = moUtil.FetchString(.Fields.Item("Formula").Value)
            vRec.CustomCode = moUtil.FetchLong(.Fields.Item("CustomCode").Value)
            vRec.MultiSelect = moUtil.FetchInteger(.Fields.Item("MultiSelect").Value)
            vRec.MediaType = moUtil.FetchLong(.Fields.Item("MediaType").Value)
            vRec.MediaFile = moUtil.FetchString(.Fields.Item("MediaFile").Value)
            vRec.Courses = moUtil.FetchString(.Fields.Item("Courses").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
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

Public Function ListQuestionText( _ 
   ByVal bvCourses As String) As tAssessQuestionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListQuestionText"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAssessQuestionType
   Dim vRec As tAssessQuestionType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvCourses = moUtil.EditString(bvCourses, "Courses", True, "", 1, 50) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Courses", adVarWChar, adParamInput, 50, bvCourses)
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_AssessQuestion_ListQuestionText")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.AssessQuestionID = moUtil.FetchLong(.Fields.Item("AssessQuestionID").Value)
            vRec.AssessmentID = moUtil.FetchLong(.Fields.Item("AssessmentID").Value)
            vRec.Question = moUtil.FetchString(.Fields.Item("Question").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.QuestionCode = moUtil.FetchLong(.Fields.Item("QuestionCode").Value)
            vRec.Grp = moUtil.FetchLong(.Fields.Item("Grp").Value)
            vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
            vRec.QuestionType = moUtil.FetchLong(.Fields.Item("QuestionType").Value)
            vRec.MultiSelect = moUtil.FetchInteger(.Fields.Item("MultiSelect").Value)
            vRec.NextQuestion = moUtil.FetchLong(.Fields.Item("NextQuestion").Value)
            vRec.RankMin = moUtil.FetchLong(.Fields.Item("RankMin").Value)
            vRec.RankMax = moUtil.FetchLong(.Fields.Item("RankMax").Value)
            vRec.NextType = moUtil.FetchLong(.Fields.Item("NextType").Value)
            vRec.CustomCode = moUtil.FetchLong(.Fields.Item("CustomCode").Value)
            vRec.MediaType = moUtil.FetchLong(.Fields.Item("MediaType").Value)
            vRec.MediaFile = moUtil.FetchString(.Fields.Item("MediaFile").Value)
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
   ByVal bvUserID As Long) As tAssessQuestionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListGroup"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAssessQuestionType
   Dim vRec As tAssessQuestionType
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
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_AssessQuestion_ListGroup")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.Grp = moUtil.FetchLong(.Fields.Item("Grp").Value)
            vRec.AssessmentID = moUtil.FetchLong(.Fields.Item("AssessmentID").Value)
            vRec.AssessQuestionID = moUtil.FetchLong(.Fields.Item("AssessQuestionID").Value)
            vRec.Question = moUtil.FetchString(.Fields.Item("Question").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.QuestionCode = moUtil.FetchLong(.Fields.Item("QuestionCode").Value)
            vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
            vRec.QuestionType = moUtil.FetchLong(.Fields.Item("QuestionType").Value)
            vRec.MultiSelect = moUtil.FetchInteger(.Fields.Item("MultiSelect").Value)
            vRec.NextQuestion = moUtil.FetchLong(.Fields.Item("NextQuestion").Value)
            vRec.RankMin = moUtil.FetchLong(.Fields.Item("RankMin").Value)
            vRec.RankMax = moUtil.FetchLong(.Fields.Item("RankMax").Value)
            vRec.NextType = moUtil.FetchLong(.Fields.Item("NextType").Value)
            vRec.CustomCode = moUtil.FetchLong(.Fields.Item("CustomCode").Value)
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
   ByRef brRec As tAssessQuestionType, _ 
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
      .Parameters.Append .CreateParameter("@AssessQuestionID", adInteger, adParamInput, vbNull, CLng(brRec.AssessQuestionID))
      .Parameters.Append .CreateParameter("@AssessmentID", adInteger, adParamInput, vbNull, CLng(brRec.AssessmentID))
      .Parameters.Append .CreateParameter("@QuestionCode", adInteger, adParamInput, vbNull, CLng(brRec.QuestionCode))
      .Parameters.Append .CreateParameter("@Question", adVarWChar, adParamInput, 1000, brRec.Question)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 2000, brRec.Description)
      .Parameters.Append .CreateParameter("@Grp", adInteger, adParamInput, vbNull, CLng(brRec.Grp))
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@QuestionType", adInteger, adParamInput, vbNull, CLng(brRec.QuestionType))
      .Parameters.Append .CreateParameter("@RankMin", adInteger, adParamInput, vbNull, CLng(brRec.RankMin))
      .Parameters.Append .CreateParameter("@RankMax", adInteger, adParamInput, vbNull, CLng(brRec.RankMax))
      .Parameters.Append .CreateParameter("@ResultType", adInteger, adParamInput, vbNull, CLng(brRec.ResultType))
      .Parameters.Append .CreateParameter("@Answer", adInteger, adParamInput, vbNull, CLng(brRec.Answer))
      .Parameters.Append .CreateParameter("@Points", adInteger, adParamInput, vbNull, CLng(brRec.Points))
      .Parameters.Append .CreateParameter("@NextType", adInteger, adParamInput, vbNull, CLng(brRec.NextType))
      .Parameters.Append .CreateParameter("@NextQuestion", adInteger, adParamInput, vbNull, CLng(brRec.NextQuestion))
      .Parameters.Append .CreateParameter("@Formula", adVarWChar, adParamInput, 100, brRec.Formula)
      .Parameters.Append .CreateParameter("@CustomCode", adInteger, adParamInput, vbNull, CLng(brRec.CustomCode))
      .Parameters.Append .CreateParameter("@MultiSelect", adSmallInt, adParamInput, vbNull, CInt(brRec.MultiSelect))
      .Parameters.Append .CreateParameter("@MediaType", adInteger, adParamInput, vbNull, CLng(brRec.MediaType))
      .Parameters.Append .CreateParameter("@MediaFile", adVarWChar, adParamInput, 80, brRec.MediaFile)
      .Parameters.Append .CreateParameter("@Courses", adVarWChar, adParamInput, 50, brRec.Courses)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      Dim tmpParamDiscrimination As ADODB.Parameter
      Set tmpParamDiscrimination = .CreateParameter("@Discrimination", adNumeric, adParamInput, 10, CDbl(brRec.Discrimination))
      tmpParamDiscrimination.Precision = 10
      tmpParamDiscrimination.NumericScale = 8
      .Parameters.Append tmpParamDiscrimination
      Dim tmpParamDifficulty As ADODB.Parameter
      Set tmpParamDifficulty = .CreateParameter("@Difficulty", adNumeric, adParamInput, 10, CDbl(brRec.Difficulty))
      tmpParamDifficulty.Precision = 10
      tmpParamDifficulty.NumericScale = 8
      .Parameters.Append tmpParamDifficulty
      Dim tmpParamGuessing As ADODB.Parameter
      Set tmpParamGuessing = .CreateParameter("@Guessing", adNumeric, adParamInput, 10, CDbl(brRec.Guessing))
      tmpParamGuessing.Precision = 10
      tmpParamGuessing.NumericScale = 8
      .Parameters.Append tmpParamGuessing
      .Parameters.Append .CreateParameter("@UseCount", adInteger, adParamInput, vbNull, CLng(brRec.UseCount))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_AssessQuestion_Update"

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
   ByRef brRec As tAssessQuestionType, _ 
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
         .AssessQuestionID = moUtil.EditLong(.AssessQuestionID, "AssessQuestionID", True, , 1) 
      End If
      .AssessmentID = moUtil.EditLong(.AssessmentID, "AssessmentID", True) 
      .QuestionCode = moUtil.EditLong(.QuestionCode, "QuestionCode", False) 
      .Question = moUtil.EditString(.Question, "Question", True, , 1, 1000) 
      .Description = moUtil.EditString(.Description, "Description", False, , 1, 2000) 
      .Grp = moUtil.EditLong(.Grp, "Grp", False) 
      .Seq = moUtil.EditLong(.Seq, "Seq", False) 
      .QuestionType = moUtil.EditLong(.QuestionType, "QuestionType", False) 
      .RankMin = moUtil.EditLong(.RankMin, "RankMin", False) 
      .RankMax = moUtil.EditLong(.RankMax, "RankMax", False) 
      .ResultType = moUtil.EditLong(.ResultType, "ResultType", False) 
      .Answer = moUtil.EditLong(.Answer, "Answer", False) 
      .Points = moUtil.EditLong(.Points, "Points", False) 
      .NextType = moUtil.EditLong(.NextType, "NextType", False) 
      .NextQuestion = moUtil.EditLong(.NextQuestion, "NextQuestion", False) 
      .Formula = moUtil.EditString(.Formula, "Formula", False, , 1, 100) 
      .CustomCode = moUtil.EditLong(.CustomCode, "CustomCode", False) 
      .MultiSelect = moUtil.EditInteger(.MultiSelect, "MultiSelect", False, 0, 0, 1) 
      .MediaType = moUtil.EditLong(.MediaType, "MediaType", False) 
      .MediaFile = moUtil.EditString(.MediaFile, "MediaFile", False, , 1, 80) 
      .Courses = moUtil.EditString(.Courses, "Courses", False, , 1, 50) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .Discrimination = moUtil.EditDouble(.Discrimination, "Discrimination", False) 
      .Difficulty = moUtil.EditDouble(.Difficulty, "Difficulty", False) 
      .Guessing = moUtil.EditDouble(.Guessing, "Guessing", False) 
      .UseCount = moUtil.EditLong(.UseCount, "UseCount", False) 
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