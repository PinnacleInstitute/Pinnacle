VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CCourseB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CCourse"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tCourseType
   CourseID As String
   CourseCategoryID As String
   TrainerID As String
   CompanyID As String
   ExamID As String
   CourseCategoryName As String
   TrainerName As String
   CourseName As String
   Status As String
   CourseType As String
   CourseLevel As String
   Description As String
   Language As String
   CourseLength As String
   CourseDate As String
   IsPaid As String
   Price As String
   Grp As String
   Seq As String
   PassingGrade As String
   Rating As String
   RatingCnt As String
   Classes As String
   Video As String
   Audio As String
   Quiz As String
   Reference As String
   ScoreFactor As String
   NoCertificate As String
   NoEvaluation As String
   IsCustomCertificate As String
   Credit As String
   ExamWeight As String
   Pre As String
   Quantity As String
   Amount As String
   OrgID As String
   OrgStatus As String
   OrgSeq As String
   OrgCourseID As String
End Type

Public Sub Add( _ 
   ByRef brRec As tCourseType, _ 
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
      .Parameters.Append .CreateParameter("@CourseID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CourseCategoryID", adInteger, adParamInput, vbNull, CLng(brRec.CourseCategoryID))
      .Parameters.Append .CreateParameter("@TrainerID", adInteger, adParamInput, vbNull, CLng(brRec.TrainerID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@ExamID", adInteger, adParamInput, vbNull, CLng(brRec.ExamID))
      .Parameters.Append .CreateParameter("@CourseName", adVarWChar, adParamInput, 80, brRec.CourseName)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@CourseType", adInteger, adParamInput, vbNull, CLng(brRec.CourseType))
      .Parameters.Append .CreateParameter("@CourseLevel", adInteger, adParamInput, vbNull, CLng(brRec.CourseLevel))
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 1000, brRec.Description)
      .Parameters.Append .CreateParameter("@Language", adVarWChar, adParamInput, 20, brRec.Language)
      .Parameters.Append .CreateParameter("@CourseLength", adInteger, adParamInput, vbNull, CLng(brRec.CourseLength))
      .Parameters.Append .CreateParameter("@CourseDate", adDate, adParamInput, vbNull, CDate(brRec.CourseDate))
      .Parameters.Append .CreateParameter("@IsPaid", adSmallInt, adParamInput, vbNull, CInt(brRec.IsPaid))
      .Parameters.Append .CreateParameter("@Price", adCurrency, adParamInput, vbNull, CCur(brRec.Price))
      .Parameters.Append .CreateParameter("@Grp", adInteger, adParamInput, vbNull, CLng(brRec.Grp))
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@PassingGrade", adInteger, adParamInput, vbNull, CLng(brRec.PassingGrade))
      .Parameters.Append .CreateParameter("@Rating", adInteger, adParamInput, vbNull, CLng(brRec.Rating))
      .Parameters.Append .CreateParameter("@RatingCnt", adInteger, adParamInput, vbNull, CLng(brRec.RatingCnt))
      .Parameters.Append .CreateParameter("@Classes", adInteger, adParamInput, vbNull, CLng(brRec.Classes))
      .Parameters.Append .CreateParameter("@Video", adSmallInt, adParamInput, vbNull, CInt(brRec.Video))
      .Parameters.Append .CreateParameter("@Audio", adSmallInt, adParamInput, vbNull, CInt(brRec.Audio))
      .Parameters.Append .CreateParameter("@Quiz", adSmallInt, adParamInput, vbNull, CInt(brRec.Quiz))
      .Parameters.Append .CreateParameter("@Reference", adVarWChar, adParamInput, 15, brRec.Reference)
      Dim tmpParamScoreFactor As ADODB.Parameter
      Set tmpParamScoreFactor = .CreateParameter("@ScoreFactor", adNumeric, adParamInput, 10, CDbl(brRec.ScoreFactor))
      tmpParamScoreFactor.Precision = 10
      tmpParamScoreFactor.NumericScale = 6
      .Parameters.Append tmpParamScoreFactor
      .Parameters.Append .CreateParameter("@NoCertificate", adSmallInt, adParamInput, vbNull, CInt(brRec.NoCertificate))
      .Parameters.Append .CreateParameter("@NoEvaluation", adSmallInt, adParamInput, vbNull, CInt(brRec.NoEvaluation))
      .Parameters.Append .CreateParameter("@IsCustomCertificate", adSmallInt, adParamInput, vbNull, CInt(brRec.IsCustomCertificate))
      .Parameters.Append .CreateParameter("@Credit", adCurrency, adParamInput, vbNull, CCur(brRec.Credit))
      .Parameters.Append .CreateParameter("@ExamWeight", adInteger, adParamInput, vbNull, CLng(brRec.ExamWeight))
      .Parameters.Append .CreateParameter("@Pre", adVarWChar, adParamInput, 20, brRec.Pre)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Course_Add"

   '-----get return values
   With brRec
      .CourseID = moUtil.FetchLong(oCmd.Parameters.Item("@CourseID").Value)
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

Public Function UpdateFT( _ 
   ByRef brRec As tCourseType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "UpdateFT"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CourseID", adInteger, adParamInput, vbNull, CLng(brRec.CourseID))
      .Parameters.Append .CreateParameter("@CourseName", adVarWChar, adParamInput, 80, brRec.CourseName)
      .Parameters.Append .CreateParameter("@TrainerName", adVarWChar, adParamInput, 60, brRec.TrainerName)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 1000, brRec.Description)
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Course_UpdateFT"

   '-----get return values
   UpdateFT = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function SetContent( _ 
   ByRef brRec As tCourseType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "SetContent"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CourseID", adInteger, adParamInput, vbNull, CLng(brRec.CourseID))
      .Parameters.Append .CreateParameter("@TrainerID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Course_SetContent"

   '-----get return values
   SetContent = moUtil.FetchLong(oCmd.Parameters.Item("@TrainerID").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function CanUpload( _ 
   ByRef brRec As tCourseType, _ 
   ByVal bvUserID As Long) As Integer
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CanUpload"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CourseID", adInteger, adParamInput, vbNull, CLng(brRec.CourseID))
      .Parameters.Append .CreateParameter("@IsUpload", adSmallInt, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Course_CanUpload"

   '-----get return values
   CanUpload = moUtil.FetchInteger(oCmd.Parameters.Item("@IsUpload").Value)

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
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Course_Count"

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
   ByRef brRec As tCourseType, _ 
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
      .CourseID = moUtil.EditLong(.CourseID, "CourseID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CourseID", adInteger, adParamInput, vbNull, CLng(brRec.CourseID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Course_Delete"

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
   ByRef brRec As tCourseType, _ 
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
      .CourseID = moUtil.EditLong(.CourseID, "CourseID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CourseID", adInteger, adParamInput, vbNull, CLng(brRec.CourseID))
      .Parameters.Append .CreateParameter("@CourseCategoryID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@TrainerID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ExamID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CourseCategoryName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@TrainerName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@CourseName", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CourseType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CourseLevel", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamOutput, 1000, vbNull)
      .Parameters.Append .CreateParameter("@Language", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@CourseLength", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CourseDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsPaid", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Price", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Grp", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PassingGrade", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Rating", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@RatingCnt", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Classes", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Video", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Audio", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Quiz", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Reference", adVarWChar, adParamOutput, 15, vbNull)
      Dim tmpParamScoreFactor As ADODB.Parameter
      Set tmpParamScoreFactor = .CreateParameter("@ScoreFactor", adNumeric, adParamOutput, 10, vbNull)
      tmpParamScoreFactor.Precision = 10
      tmpParamScoreFactor.NumericScale = 6
      .Parameters.Append tmpParamScoreFactor
      .Parameters.Append .CreateParameter("@NoCertificate", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NoEvaluation", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsCustomCertificate", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Credit", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ExamWeight", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Pre", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Course_Fetch"

   '-----get return values
   With brRec
      .CourseCategoryID = moUtil.FetchLong(oCmd.Parameters.Item("@CourseCategoryID").Value)
      .TrainerID = moUtil.FetchLong(oCmd.Parameters.Item("@TrainerID").Value)
      .CompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@CompanyID").Value)
      .ExamID = moUtil.FetchLong(oCmd.Parameters.Item("@ExamID").Value)
      .CourseCategoryName = moUtil.FetchString(oCmd.Parameters.Item("@CourseCategoryName").Value)
      .TrainerName = moUtil.FetchString(oCmd.Parameters.Item("@TrainerName").Value)
      .CourseName = moUtil.FetchString(oCmd.Parameters.Item("@CourseName").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .CourseType = moUtil.FetchLong(oCmd.Parameters.Item("@CourseType").Value)
      .CourseLevel = moUtil.FetchLong(oCmd.Parameters.Item("@CourseLevel").Value)
      .Description = moUtil.FetchString(oCmd.Parameters.Item("@Description").Value)
      .Language = moUtil.FetchString(oCmd.Parameters.Item("@Language").Value)
      .CourseLength = moUtil.FetchLong(oCmd.Parameters.Item("@CourseLength").Value)
      .CourseDate = moUtil.FetchDate(oCmd.Parameters.Item("@CourseDate").Value)
      .IsPaid = moUtil.FetchInteger(oCmd.Parameters.Item("@IsPaid").Value)
      .Price = moUtil.FetchCurrency(oCmd.Parameters.Item("@Price").Value)
      .Grp = moUtil.FetchLong(oCmd.Parameters.Item("@Grp").Value)
      .Seq = moUtil.FetchLong(oCmd.Parameters.Item("@Seq").Value)
      .PassingGrade = moUtil.FetchLong(oCmd.Parameters.Item("@PassingGrade").Value)
      .Rating = moUtil.FetchLong(oCmd.Parameters.Item("@Rating").Value)
      .RatingCnt = moUtil.FetchLong(oCmd.Parameters.Item("@RatingCnt").Value)
      .Classes = moUtil.FetchLong(oCmd.Parameters.Item("@Classes").Value)
      .Video = moUtil.FetchInteger(oCmd.Parameters.Item("@Video").Value)
      .Audio = moUtil.FetchInteger(oCmd.Parameters.Item("@Audio").Value)
      .Quiz = moUtil.FetchInteger(oCmd.Parameters.Item("@Quiz").Value)
      .Reference = moUtil.FetchString(oCmd.Parameters.Item("@Reference").Value)
      .ScoreFactor = moUtil.FetchDouble(oCmd.Parameters.Item("@ScoreFactor").Value)
      .NoCertificate = moUtil.FetchInteger(oCmd.Parameters.Item("@NoCertificate").Value)
      .NoEvaluation = moUtil.FetchInteger(oCmd.Parameters.Item("@NoEvaluation").Value)
      .IsCustomCertificate = moUtil.FetchInteger(oCmd.Parameters.Item("@IsCustomCertificate").Value)
      .Credit = moUtil.FetchCurrency(oCmd.Parameters.Item("@Credit").Value)
      .ExamWeight = moUtil.FetchLong(oCmd.Parameters.Item("@ExamWeight").Value)
      .Pre = moUtil.FetchString(oCmd.Parameters.Item("@Pre").Value)
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

Public Function Find( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tCourseType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tCourseType
   Dim vRec As tCourseType
   Dim idxRec As Integer
   Dim sProc As String
   Dim MaxBookMark As Integer
   Dim MaxRows As Integer
   Dim oBookmark As wtSystem.CBookmark

   On Error GoTo ErrorHandler

   '-----initialize the bookmark
   Set oBookMark = New wtSystem.CBookmark
   With oBookMark
      .LastBookmark = brBookMark
      .Direction = bvDirection
      .SearchText = bvSearchText
      .SearchType = bvFindType
   End With

   '-----edit the input parameters
   bvFindType = moUtil.EditLong(bvFindType, "Find Type", True, , 1) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsCourseFindCourseName
         sProc = "pts_Course_FindCourseName"
         MaxBookMark = 90
      Case cptsCourseFindCourseID
         sProc = "pts_Course_FindCourseID"
         MaxBookMark = 20
      Case cptsCourseFindStatus
         sProc = "pts_Course_FindStatus"
         MaxBookMark = 20
      Case cptsCourseFindCourseDate
         sProc = "pts_Course_FindCourseDate"
         MaxBookMark = 30
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), sProc)

   '-----get return values
   MaxRows = moUtil.FetchInteger(oCmd.Parameters.Item("@MaxRows").Value)

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            If idxRec < MaxRows Then
               vRec.CourseID = moUtil.FetchLong(.Fields.Item("CourseID").Value)
               vRec.CourseCategoryID = moUtil.FetchLong(.Fields.Item("CourseCategoryID").Value)
               vRec.TrainerID = moUtil.FetchLong(.Fields.Item("TrainerID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.ExamID = moUtil.FetchLong(.Fields.Item("ExamID").Value)
               vRec.CourseCategoryName = moUtil.FetchString(.Fields.Item("CourseCategoryName").Value)
               vRec.TrainerName = moUtil.FetchString(.Fields.Item("TrainerName").Value)
               vRec.CourseName = moUtil.FetchString(.Fields.Item("CourseName").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.CourseType = moUtil.FetchLong(.Fields.Item("CourseType").Value)
               vRec.CourseLevel = moUtil.FetchLong(.Fields.Item("CourseLevel").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Language = moUtil.FetchString(.Fields.Item("Language").Value)
               vRec.CourseLength = moUtil.FetchLong(.Fields.Item("CourseLength").Value)
               vRec.CourseDate = moUtil.FetchDate(.Fields.Item("CourseDate").Value)
               vRec.IsPaid = moUtil.FetchInteger(.Fields.Item("IsPaid").Value)
               vRec.Price = moUtil.FetchCurrency(.Fields.Item("Price").Value)
               vRec.Grp = moUtil.FetchLong(.Fields.Item("Grp").Value)
               vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
               vRec.PassingGrade = moUtil.FetchLong(.Fields.Item("PassingGrade").Value)
               vRec.Rating = moUtil.FetchLong(.Fields.Item("Rating").Value)
               vRec.RatingCnt = moUtil.FetchLong(.Fields.Item("RatingCnt").Value)
               vRec.Classes = moUtil.FetchLong(.Fields.Item("Classes").Value)
               vRec.Video = moUtil.FetchInteger(.Fields.Item("Video").Value)
               vRec.Audio = moUtil.FetchInteger(.Fields.Item("Audio").Value)
               vRec.Quiz = moUtil.FetchInteger(.Fields.Item("Quiz").Value)
               vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
               vRec.ScoreFactor = moUtil.FetchDouble(.Fields.Item("ScoreFactor").Value)
               vRec.NoCertificate = moUtil.FetchInteger(.Fields.Item("NoCertificate").Value)
               vRec.NoEvaluation = moUtil.FetchInteger(.Fields.Item("NoEvaluation").Value)
               vRec.IsCustomCertificate = moUtil.FetchInteger(.Fields.Item("IsCustomCertificate").Value)
               vRec.Credit = moUtil.FetchCurrency(.Fields.Item("Credit").Value)
               vRec.ExamWeight = moUtil.FetchLong(.Fields.Item("ExamWeight").Value)
               vRec.Pre = moUtil.FetchString(.Fields.Item("Pre").Value)
               idxRec = idxRec + 1
               ReDim Preserve vRecs(0 To idxRec)
               vRecs(idxRec) = vRec
            End If
            .MoveNext
         Loop
         .MoveFirst
      End If
   End With

   '-----update the bookmark for the next call
   With oBookMark
      .MaxRows = MaxRows
      .Update oRecs
      brBookmark = .NextBookmark
   End With

   '-----return the results
   Find = vRecs

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

Public Function FindCompany( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tCourseType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindCompany"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tCourseType
   Dim vRec As tCourseType
   Dim idxRec As Integer
   Dim sProc As String
   Dim MaxBookMark As Integer
   Dim MaxRows As Integer
   Dim oBookmark As wtSystem.CBookmark

   On Error GoTo ErrorHandler

   '-----initialize the bookmark
   Set oBookMark = New wtSystem.CBookmark
   With oBookMark
      .LastBookmark = brBookMark
      .Direction = bvDirection
      .SearchText = bvSearchText
      .SearchType = bvFindType
   End With

   '-----edit the input parameters
   bvFindType = moUtil.EditLong(bvFindType, "Find Type", True, , 1) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsCourseFindCourseName
         sProc = "pts_Course_FindCompanyCourseName"
         MaxBookMark = 90
      Case cptsCourseFindCourseID
         sProc = "pts_Course_FindCompanyCourseID"
         MaxBookMark = 20
      Case cptsCourseFindStatus
         sProc = "pts_Course_FindCompanyStatus"
         MaxBookMark = 20
      Case cptsCourseFindCourseDate
         sProc = "pts_Course_FindCompanyCourseDate"
         MaxBookMark = 30
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), sProc)

   '-----get return values
   MaxRows = moUtil.FetchInteger(oCmd.Parameters.Item("@MaxRows").Value)

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            If idxRec < MaxRows Then
               vRec.CourseID = moUtil.FetchLong(.Fields.Item("CourseID").Value)
               vRec.CourseCategoryID = moUtil.FetchLong(.Fields.Item("CourseCategoryID").Value)
               vRec.TrainerID = moUtil.FetchLong(.Fields.Item("TrainerID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.ExamID = moUtil.FetchLong(.Fields.Item("ExamID").Value)
               vRec.CourseCategoryName = moUtil.FetchString(.Fields.Item("CourseCategoryName").Value)
               vRec.TrainerName = moUtil.FetchString(.Fields.Item("TrainerName").Value)
               vRec.CourseName = moUtil.FetchString(.Fields.Item("CourseName").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.CourseType = moUtil.FetchLong(.Fields.Item("CourseType").Value)
               vRec.CourseLevel = moUtil.FetchLong(.Fields.Item("CourseLevel").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Language = moUtil.FetchString(.Fields.Item("Language").Value)
               vRec.CourseLength = moUtil.FetchLong(.Fields.Item("CourseLength").Value)
               vRec.CourseDate = moUtil.FetchDate(.Fields.Item("CourseDate").Value)
               vRec.IsPaid = moUtil.FetchInteger(.Fields.Item("IsPaid").Value)
               vRec.Price = moUtil.FetchCurrency(.Fields.Item("Price").Value)
               vRec.Grp = moUtil.FetchLong(.Fields.Item("Grp").Value)
               vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
               vRec.PassingGrade = moUtil.FetchLong(.Fields.Item("PassingGrade").Value)
               vRec.Rating = moUtil.FetchLong(.Fields.Item("Rating").Value)
               vRec.RatingCnt = moUtil.FetchLong(.Fields.Item("RatingCnt").Value)
               vRec.Classes = moUtil.FetchLong(.Fields.Item("Classes").Value)
               vRec.Video = moUtil.FetchInteger(.Fields.Item("Video").Value)
               vRec.Audio = moUtil.FetchInteger(.Fields.Item("Audio").Value)
               vRec.Quiz = moUtil.FetchInteger(.Fields.Item("Quiz").Value)
               vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
               vRec.ScoreFactor = moUtil.FetchDouble(.Fields.Item("ScoreFactor").Value)
               vRec.NoCertificate = moUtil.FetchInteger(.Fields.Item("NoCertificate").Value)
               vRec.NoEvaluation = moUtil.FetchInteger(.Fields.Item("NoEvaluation").Value)
               vRec.IsCustomCertificate = moUtil.FetchInteger(.Fields.Item("IsCustomCertificate").Value)
               vRec.Credit = moUtil.FetchCurrency(.Fields.Item("Credit").Value)
               vRec.ExamWeight = moUtil.FetchLong(.Fields.Item("ExamWeight").Value)
               vRec.Pre = moUtil.FetchString(.Fields.Item("Pre").Value)
               idxRec = idxRec + 1
               ReDim Preserve vRecs(0 To idxRec)
               vRecs(idxRec) = vRec
            End If
            .MoveNext
         Loop
         .MoveFirst
      End If
   End With

   '-----update the bookmark for the next call
   With oBookMark
      .MaxRows = MaxRows
      .Update oRecs
      brBookmark = .NextBookmark
   End With

   '-----return the results
   FindCompany = vRecs

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

Public Function FindOrg( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvOrgID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tCourseType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindOrg"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tCourseType
   Dim vRec As tCourseType
   Dim idxRec As Integer
   Dim sProc As String
   Dim MaxBookMark As Integer
   Dim MaxRows As Integer
   Dim oBookmark As wtSystem.CBookmark

   On Error GoTo ErrorHandler

   '-----initialize the bookmark
   Set oBookMark = New wtSystem.CBookmark
   With oBookMark
      .LastBookmark = brBookMark
      .Direction = bvDirection
      .SearchText = bvSearchText
      .SearchType = bvFindType
   End With

   '-----edit the input parameters
   bvFindType = moUtil.EditLong(bvFindType, "Find Type", True, , 1) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsCourseFindCourseName
         sProc = "pts_Course_FindOrgCourseName"
         MaxBookMark = 90
      Case cptsCourseFindCourseID
         sProc = "pts_Course_FindOrgCourseID"
         MaxBookMark = 20
      Case cptsCourseFindStatus
         sProc = "pts_Course_FindOrgStatus"
         MaxBookMark = 20
      Case cptsCourseFindCourseDate
         sProc = "pts_Course_FindOrgCourseDate"
         MaxBookMark = 30
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@OrgID", adInteger, adParamInput, vbNull, CLng(bvOrgID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), sProc)

   '-----get return values
   MaxRows = moUtil.FetchInteger(oCmd.Parameters.Item("@MaxRows").Value)

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            If idxRec < MaxRows Then
               vRec.CourseID = moUtil.FetchLong(.Fields.Item("CourseID").Value)
               vRec.CourseCategoryID = moUtil.FetchLong(.Fields.Item("CourseCategoryID").Value)
               vRec.TrainerID = moUtil.FetchLong(.Fields.Item("TrainerID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.ExamID = moUtil.FetchLong(.Fields.Item("ExamID").Value)
               vRec.CourseCategoryName = moUtil.FetchString(.Fields.Item("CourseCategoryName").Value)
               vRec.TrainerName = moUtil.FetchString(.Fields.Item("TrainerName").Value)
               vRec.CourseName = moUtil.FetchString(.Fields.Item("CourseName").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.CourseType = moUtil.FetchLong(.Fields.Item("CourseType").Value)
               vRec.CourseLevel = moUtil.FetchLong(.Fields.Item("CourseLevel").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Language = moUtil.FetchString(.Fields.Item("Language").Value)
               vRec.CourseLength = moUtil.FetchLong(.Fields.Item("CourseLength").Value)
               vRec.CourseDate = moUtil.FetchDate(.Fields.Item("CourseDate").Value)
               vRec.IsPaid = moUtil.FetchInteger(.Fields.Item("IsPaid").Value)
               vRec.Price = moUtil.FetchCurrency(.Fields.Item("Price").Value)
               vRec.Grp = moUtil.FetchLong(.Fields.Item("Grp").Value)
               vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
               vRec.PassingGrade = moUtil.FetchLong(.Fields.Item("PassingGrade").Value)
               vRec.Rating = moUtil.FetchLong(.Fields.Item("Rating").Value)
               vRec.RatingCnt = moUtil.FetchLong(.Fields.Item("RatingCnt").Value)
               vRec.Classes = moUtil.FetchLong(.Fields.Item("Classes").Value)
               vRec.Video = moUtil.FetchInteger(.Fields.Item("Video").Value)
               vRec.Audio = moUtil.FetchInteger(.Fields.Item("Audio").Value)
               vRec.Quiz = moUtil.FetchInteger(.Fields.Item("Quiz").Value)
               vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
               vRec.ScoreFactor = moUtil.FetchDouble(.Fields.Item("ScoreFactor").Value)
               vRec.NoCertificate = moUtil.FetchInteger(.Fields.Item("NoCertificate").Value)
               vRec.NoEvaluation = moUtil.FetchInteger(.Fields.Item("NoEvaluation").Value)
               vRec.IsCustomCertificate = moUtil.FetchInteger(.Fields.Item("IsCustomCertificate").Value)
               vRec.Credit = moUtil.FetchCurrency(.Fields.Item("Credit").Value)
               vRec.ExamWeight = moUtil.FetchLong(.Fields.Item("ExamWeight").Value)
               vRec.Pre = moUtil.FetchString(.Fields.Item("Pre").Value)
               idxRec = idxRec + 1
               ReDim Preserve vRecs(0 To idxRec)
               vRecs(idxRec) = vRec
            End If
            .MoveNext
         Loop
         .MoveFirst
      End If
   End With

   '-----update the bookmark for the next call
   With oBookMark
      .MaxRows = MaxRows
      .Update oRecs
      brBookmark = .NextBookmark
   End With

   '-----return the results
   FindOrg = vRecs

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

Public Function FindTrainer( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvTrainerID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tCourseType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindTrainer"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tCourseType
   Dim vRec As tCourseType
   Dim idxRec As Integer
   Dim sProc As String
   Dim MaxBookMark As Integer
   Dim MaxRows As Integer
   Dim oBookmark As wtSystem.CBookmark

   On Error GoTo ErrorHandler

   '-----initialize the bookmark
   Set oBookMark = New wtSystem.CBookmark
   With oBookMark
      .LastBookmark = brBookMark
      .Direction = bvDirection
      .SearchText = bvSearchText
      .SearchType = bvFindType
   End With

   '-----edit the input parameters
   bvFindType = moUtil.EditLong(bvFindType, "Find Type", True, , 1) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsCourseFindCourseName
         sProc = "pts_Course_FindTrainerCourseName"
         MaxBookMark = 90
      Case cptsCourseFindCourseID
         sProc = "pts_Course_FindTrainerCourseID"
         MaxBookMark = 20
      Case cptsCourseFindStatus
         sProc = "pts_Course_FindTrainerStatus"
         MaxBookMark = 20
      Case cptsCourseFindCourseDate
         sProc = "pts_Course_FindTrainerCourseDate"
         MaxBookMark = 30
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@TrainerID", adInteger, adParamInput, vbNull, CLng(bvTrainerID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), sProc)

   '-----get return values
   MaxRows = moUtil.FetchInteger(oCmd.Parameters.Item("@MaxRows").Value)

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            If idxRec < MaxRows Then
               vRec.CourseID = moUtil.FetchLong(.Fields.Item("CourseID").Value)
               vRec.CourseCategoryID = moUtil.FetchLong(.Fields.Item("CourseCategoryID").Value)
               vRec.TrainerID = moUtil.FetchLong(.Fields.Item("TrainerID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.ExamID = moUtil.FetchLong(.Fields.Item("ExamID").Value)
               vRec.CourseCategoryName = moUtil.FetchString(.Fields.Item("CourseCategoryName").Value)
               vRec.TrainerName = moUtil.FetchString(.Fields.Item("TrainerName").Value)
               vRec.CourseName = moUtil.FetchString(.Fields.Item("CourseName").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.CourseType = moUtil.FetchLong(.Fields.Item("CourseType").Value)
               vRec.CourseLevel = moUtil.FetchLong(.Fields.Item("CourseLevel").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Language = moUtil.FetchString(.Fields.Item("Language").Value)
               vRec.CourseLength = moUtil.FetchLong(.Fields.Item("CourseLength").Value)
               vRec.CourseDate = moUtil.FetchDate(.Fields.Item("CourseDate").Value)
               vRec.IsPaid = moUtil.FetchInteger(.Fields.Item("IsPaid").Value)
               vRec.Price = moUtil.FetchCurrency(.Fields.Item("Price").Value)
               vRec.Grp = moUtil.FetchLong(.Fields.Item("Grp").Value)
               vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
               vRec.PassingGrade = moUtil.FetchLong(.Fields.Item("PassingGrade").Value)
               vRec.Rating = moUtil.FetchLong(.Fields.Item("Rating").Value)
               vRec.RatingCnt = moUtil.FetchLong(.Fields.Item("RatingCnt").Value)
               vRec.Classes = moUtil.FetchLong(.Fields.Item("Classes").Value)
               vRec.Video = moUtil.FetchInteger(.Fields.Item("Video").Value)
               vRec.Audio = moUtil.FetchInteger(.Fields.Item("Audio").Value)
               vRec.Quiz = moUtil.FetchInteger(.Fields.Item("Quiz").Value)
               vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
               vRec.ScoreFactor = moUtil.FetchDouble(.Fields.Item("ScoreFactor").Value)
               vRec.NoCertificate = moUtil.FetchInteger(.Fields.Item("NoCertificate").Value)
               vRec.NoEvaluation = moUtil.FetchInteger(.Fields.Item("NoEvaluation").Value)
               vRec.IsCustomCertificate = moUtil.FetchInteger(.Fields.Item("IsCustomCertificate").Value)
               vRec.Credit = moUtil.FetchCurrency(.Fields.Item("Credit").Value)
               vRec.ExamWeight = moUtil.FetchLong(.Fields.Item("ExamWeight").Value)
               vRec.Pre = moUtil.FetchString(.Fields.Item("Pre").Value)
               idxRec = idxRec + 1
               ReDim Preserve vRecs(0 To idxRec)
               vRecs(idxRec) = vRec
            End If
            .MoveNext
         Loop
         .MoveFirst
      End If
   End With

   '-----update the bookmark for the next call
   With oBookMark
      .MaxRows = MaxRows
      .Update oRecs
      brBookmark = .NextBookmark
   End With

   '-----return the results
   FindTrainer = vRecs

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

Public Function Search( _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long) As tCourseType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Search"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tCourseType
   Dim vRec As tCourseType
   Dim idxRec As Integer
   Dim MaxRows As Integer
   Dim oBookmark As wtSystem.CBookmark

   On Error GoTo ErrorHandler

   '-----initialize the bookmark
   Set oBookMark = New wtSystem.CBookmark
   With oBookMark
      .LastBookmark = brBookMark
      .Direction = bvDirection
      .SearchText = bvSearchText
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, 200, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, 14, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Course_Search")

   '-----get return values
   MaxRows = moUtil.FetchInteger(oCmd.Parameters.Item("@MaxRows").Value)

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            If idxRec < MaxRows Then
               vRec.CourseID = moUtil.FetchLong(.Fields.Item("CourseID").Value)
               vRec.CourseName = moUtil.FetchString(.Fields.Item("CourseName").Value)
               vRec.TrainerName = moUtil.FetchString(.Fields.Item("TrainerName").Value)
               vRec.TrainerID = moUtil.FetchLong(.Fields.Item("TrainerID").Value)
               vRec.CourseLength = moUtil.FetchLong(.Fields.Item("CourseLength").Value)
               vRec.Rating = moUtil.FetchLong(.Fields.Item("Rating").Value)
               vRec.RatingCnt = moUtil.FetchLong(.Fields.Item("RatingCnt").Value)
               vRec.Classes = moUtil.FetchLong(.Fields.Item("Classes").Value)
               vRec.Language = moUtil.FetchString(.Fields.Item("Language").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Video = moUtil.FetchInteger(.Fields.Item("Video").Value)
               vRec.Audio = moUtil.FetchInteger(.Fields.Item("Audio").Value)
               vRec.Quiz = moUtil.FetchInteger(.Fields.Item("Quiz").Value)
               vRec.CourseDate = moUtil.FetchDate(.Fields.Item("CourseDate").Value)
               vRec.Grp = moUtil.FetchLong(.Fields.Item("Grp").Value)
               idxRec = idxRec + 1
               ReDim Preserve vRecs(0 To idxRec)
               vRecs(idxRec) = vRec
            End If
            .MoveNext
         Loop
         .MoveFirst
      End If
   End With

   '-----update the bookmark for the next call
   With oBookMark
      .MaxRows = MaxRows
      .Update oRecs
      brBookmark = .NextBookmark
   End With
   Set oBookMark = Nothing

   '-----return the results
   Search = vRecs

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

Public Function TBCompanyDate( _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvTrainerID As Long, _ 
   ByVal bvCourseDate As Date) As tCourseType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "TBCompanyDate"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tCourseType
   Dim vRec As tCourseType
   Dim idxRec As Integer
   Dim MaxRows As Integer
   Dim oBookmark As wtSystem.CBookmark

   On Error GoTo ErrorHandler

   '-----initialize the bookmark
   Set oBookMark = New wtSystem.CBookmark
   With oBookMark
      .LastBookmark = brBookMark
      .Direction = bvDirection
      .SearchText = bvSearchText
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, 20, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, 20, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@TrainerID", adInteger, adParamInput, vbNull, CLng(bvTrainerID))
      .Parameters.Append .CreateParameter("@CourseDate", adDate, adParamInput, vbNull, CDate(bvCourseDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Course_TBCompanyDate")

   '-----get return values
   MaxRows = moUtil.FetchInteger(oCmd.Parameters.Item("@MaxRows").Value)

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            If idxRec < MaxRows Then
               vRec.CourseID = moUtil.FetchLong(.Fields.Item("CourseID").Value)
               vRec.CourseName = moUtil.FetchString(.Fields.Item("CourseName").Value)
               vRec.TrainerName = moUtil.FetchString(.Fields.Item("TrainerName").Value)
               vRec.TrainerID = moUtil.FetchLong(.Fields.Item("TrainerID").Value)
               vRec.CourseLength = moUtil.FetchLong(.Fields.Item("CourseLength").Value)
               vRec.Rating = moUtil.FetchLong(.Fields.Item("Rating").Value)
               vRec.RatingCnt = moUtil.FetchLong(.Fields.Item("RatingCnt").Value)
               vRec.Classes = moUtil.FetchLong(.Fields.Item("Classes").Value)
               vRec.Language = moUtil.FetchString(.Fields.Item("Language").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Video = moUtil.FetchInteger(.Fields.Item("Video").Value)
               vRec.Audio = moUtil.FetchInteger(.Fields.Item("Audio").Value)
               vRec.Quiz = moUtil.FetchInteger(.Fields.Item("Quiz").Value)
               vRec.CourseDate = moUtil.FetchDate(.Fields.Item("CourseDate").Value)
               vRec.Grp = moUtil.FetchLong(.Fields.Item("Grp").Value)
               idxRec = idxRec + 1
               ReDim Preserve vRecs(0 To idxRec)
               vRecs(idxRec) = vRec
            End If
            .MoveNext
         Loop
         .MoveFirst
      End If
   End With

   '-----update the bookmark for the next call
   With oBookMark
      .MaxRows = MaxRows
      .Update oRecs
      brBookmark = .NextBookmark
   End With
   Set oBookMark = Nothing

   '-----return the results
   TBCompanyDate = vRecs

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

Public Function TBPublicDate( _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCourseDate As Date) As tCourseType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "TBPublicDate"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tCourseType
   Dim vRec As tCourseType
   Dim idxRec As Integer
   Dim MaxRows As Integer
   Dim oBookmark As wtSystem.CBookmark

   On Error GoTo ErrorHandler

   '-----initialize the bookmark
   Set oBookMark = New wtSystem.CBookmark
   With oBookMark
      .LastBookmark = brBookMark
      .Direction = bvDirection
      .SearchText = bvSearchText
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, 20, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, 20, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CourseDate", adDate, adParamInput, vbNull, CDate(bvCourseDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Course_TBPublicDate")

   '-----get return values
   MaxRows = moUtil.FetchInteger(oCmd.Parameters.Item("@MaxRows").Value)

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            If idxRec < MaxRows Then
               vRec.CourseID = moUtil.FetchLong(.Fields.Item("CourseID").Value)
               vRec.CourseName = moUtil.FetchString(.Fields.Item("CourseName").Value)
               vRec.TrainerName = moUtil.FetchString(.Fields.Item("TrainerName").Value)
               vRec.TrainerID = moUtil.FetchLong(.Fields.Item("TrainerID").Value)
               vRec.CourseLength = moUtil.FetchLong(.Fields.Item("CourseLength").Value)
               vRec.Rating = moUtil.FetchLong(.Fields.Item("Rating").Value)
               vRec.RatingCnt = moUtil.FetchLong(.Fields.Item("RatingCnt").Value)
               vRec.Classes = moUtil.FetchLong(.Fields.Item("Classes").Value)
               vRec.Language = moUtil.FetchString(.Fields.Item("Language").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Video = moUtil.FetchInteger(.Fields.Item("Video").Value)
               vRec.Audio = moUtil.FetchInteger(.Fields.Item("Audio").Value)
               vRec.Quiz = moUtil.FetchInteger(.Fields.Item("Quiz").Value)
               vRec.CourseDate = moUtil.FetchDate(.Fields.Item("CourseDate").Value)
               vRec.Grp = moUtil.FetchLong(.Fields.Item("Grp").Value)
               idxRec = idxRec + 1
               ReDim Preserve vRecs(0 To idxRec)
               vRecs(idxRec) = vRec
            End If
            .MoveNext
         Loop
         .MoveFirst
      End If
   End With

   '-----update the bookmark for the next call
   With oBookMark
      .MaxRows = MaxRows
      .Update oRecs
      brBookmark = .NextBookmark
   End With
   Set oBookMark = Nothing

   '-----return the results
   TBPublicDate = vRecs

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

Public Function TBUnRegistered( _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvTrainerID As Long) As tCourseType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "TBUnRegistered"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tCourseType
   Dim vRec As tCourseType
   Dim idxRec As Integer
   Dim MaxRows As Integer
   Dim oBookmark As wtSystem.CBookmark

   On Error GoTo ErrorHandler

   '-----initialize the bookmark
   Set oBookMark = New wtSystem.CBookmark
   With oBookMark
      .LastBookmark = brBookMark
      .Direction = bvDirection
      .SearchText = bvSearchText
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, 80, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, 90, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@TrainerID", adInteger, adParamInput, vbNull, CLng(bvTrainerID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Course_TBUnRegistered")

   '-----get return values
   MaxRows = moUtil.FetchInteger(oCmd.Parameters.Item("@MaxRows").Value)

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            If idxRec < MaxRows Then
               vRec.CourseID = moUtil.FetchLong(.Fields.Item("CourseID").Value)
               vRec.CourseName = moUtil.FetchString(.Fields.Item("CourseName").Value)
               vRec.TrainerName = moUtil.FetchString(.Fields.Item("TrainerName").Value)
               vRec.TrainerID = moUtil.FetchLong(.Fields.Item("TrainerID").Value)
               vRec.CourseLength = moUtil.FetchLong(.Fields.Item("CourseLength").Value)
               vRec.Rating = moUtil.FetchLong(.Fields.Item("Rating").Value)
               vRec.RatingCnt = moUtil.FetchLong(.Fields.Item("RatingCnt").Value)
               vRec.Classes = moUtil.FetchLong(.Fields.Item("Classes").Value)
               vRec.Language = moUtil.FetchString(.Fields.Item("Language").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Video = moUtil.FetchInteger(.Fields.Item("Video").Value)
               vRec.Audio = moUtil.FetchInteger(.Fields.Item("Audio").Value)
               vRec.Quiz = moUtil.FetchInteger(.Fields.Item("Quiz").Value)
               vRec.CourseDate = moUtil.FetchDate(.Fields.Item("CourseDate").Value)
               vRec.Grp = moUtil.FetchLong(.Fields.Item("Grp").Value)
               idxRec = idxRec + 1
               ReDim Preserve vRecs(0 To idxRec)
               vRecs(idxRec) = vRec
            End If
            .MoveNext
         Loop
         .MoveFirst
      End If
   End With

   '-----update the bookmark for the next call
   With oBookMark
      .MaxRows = MaxRows
      .Update oRecs
      brBookmark = .NextBookmark
   End With
   Set oBookMark = Nothing

   '-----return the results
   TBUnRegistered = vRecs

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

Public Function TBFavoritePublic( _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvTrainerID As Long, _ 
   ByVal bvCourseDate As Date) As tCourseType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "TBFavoritePublic"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tCourseType
   Dim vRec As tCourseType
   Dim idxRec As Integer
   Dim MaxRows As Integer
   Dim oBookmark As wtSystem.CBookmark

   On Error GoTo ErrorHandler

   '-----initialize the bookmark
   Set oBookMark = New wtSystem.CBookmark
   With oBookMark
      .LastBookmark = brBookMark
      .Direction = bvDirection
      .SearchText = bvSearchText
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, 20, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, 20, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@TrainerID", adInteger, adParamInput, vbNull, CLng(bvTrainerID))
      .Parameters.Append .CreateParameter("@CourseDate", adDate, adParamInput, vbNull, CDate(bvCourseDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Course_TBFavoritePublic")

   '-----get return values
   MaxRows = moUtil.FetchInteger(oCmd.Parameters.Item("@MaxRows").Value)

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            If idxRec < MaxRows Then
               vRec.CourseID = moUtil.FetchLong(.Fields.Item("CourseID").Value)
               vRec.CourseName = moUtil.FetchString(.Fields.Item("CourseName").Value)
               vRec.TrainerName = moUtil.FetchString(.Fields.Item("TrainerName").Value)
               vRec.TrainerID = moUtil.FetchLong(.Fields.Item("TrainerID").Value)
               vRec.CourseLength = moUtil.FetchLong(.Fields.Item("CourseLength").Value)
               vRec.Rating = moUtil.FetchLong(.Fields.Item("Rating").Value)
               vRec.RatingCnt = moUtil.FetchLong(.Fields.Item("RatingCnt").Value)
               vRec.Classes = moUtil.FetchLong(.Fields.Item("Classes").Value)
               vRec.Language = moUtil.FetchString(.Fields.Item("Language").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Video = moUtil.FetchInteger(.Fields.Item("Video").Value)
               vRec.Audio = moUtil.FetchInteger(.Fields.Item("Audio").Value)
               vRec.Quiz = moUtil.FetchInteger(.Fields.Item("Quiz").Value)
               vRec.CourseDate = moUtil.FetchDate(.Fields.Item("CourseDate").Value)
               vRec.Grp = moUtil.FetchLong(.Fields.Item("Grp").Value)
               idxRec = idxRec + 1
               ReDim Preserve vRecs(0 To idxRec)
               vRecs(idxRec) = vRec
            End If
            .MoveNext
         Loop
         .MoveFirst
      End If
   End With

   '-----update the bookmark for the next call
   With oBookMark
      .MaxRows = MaxRows
      .Update oRecs
      brBookmark = .NextBookmark
   End With
   Set oBookMark = Nothing

   '-----return the results
   TBFavoritePublic = vRecs

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

Public Function TBFavoriteCompany( _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvTrainerID As Long, _ 
   ByVal bvCourseDate As Date) As tCourseType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "TBFavoriteCompany"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tCourseType
   Dim vRec As tCourseType
   Dim idxRec As Integer
   Dim MaxRows As Integer
   Dim oBookmark As wtSystem.CBookmark

   On Error GoTo ErrorHandler

   '-----initialize the bookmark
   Set oBookMark = New wtSystem.CBookmark
   With oBookMark
      .LastBookmark = brBookMark
      .Direction = bvDirection
      .SearchText = bvSearchText
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, 20, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, 20, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@TrainerID", adInteger, adParamInput, vbNull, CLng(bvTrainerID))
      .Parameters.Append .CreateParameter("@CourseDate", adDate, adParamInput, vbNull, CDate(bvCourseDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Course_TBFavoriteCompany")

   '-----get return values
   MaxRows = moUtil.FetchInteger(oCmd.Parameters.Item("@MaxRows").Value)

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            If idxRec < MaxRows Then
               vRec.CourseID = moUtil.FetchLong(.Fields.Item("CourseID").Value)
               vRec.CourseName = moUtil.FetchString(.Fields.Item("CourseName").Value)
               vRec.TrainerName = moUtil.FetchString(.Fields.Item("TrainerName").Value)
               vRec.TrainerID = moUtil.FetchLong(.Fields.Item("TrainerID").Value)
               vRec.CourseLength = moUtil.FetchLong(.Fields.Item("CourseLength").Value)
               vRec.Rating = moUtil.FetchLong(.Fields.Item("Rating").Value)
               vRec.RatingCnt = moUtil.FetchLong(.Fields.Item("RatingCnt").Value)
               vRec.Classes = moUtil.FetchLong(.Fields.Item("Classes").Value)
               vRec.Language = moUtil.FetchString(.Fields.Item("Language").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Video = moUtil.FetchInteger(.Fields.Item("Video").Value)
               vRec.Audio = moUtil.FetchInteger(.Fields.Item("Audio").Value)
               vRec.Quiz = moUtil.FetchInteger(.Fields.Item("Quiz").Value)
               vRec.CourseDate = moUtil.FetchDate(.Fields.Item("CourseDate").Value)
               vRec.Grp = moUtil.FetchLong(.Fields.Item("Grp").Value)
               idxRec = idxRec + 1
               ReDim Preserve vRecs(0 To idxRec)
               vRecs(idxRec) = vRec
            End If
            .MoveNext
         Loop
         .MoveFirst
      End If
   End With

   '-----update the bookmark for the next call
   With oBookMark
      .MaxRows = MaxRows
      .Update oRecs
      brBookmark = .NextBookmark
   End With
   Set oBookMark = Nothing

   '-----return the results
   TBFavoriteCompany = vRecs

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

Public Function ListCourse( _ 
   ByVal bvCourseCategoryID As Long, _ 
   ByVal bvUserID As Long) As tCourseType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListCourse"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tCourseType
   Dim vRec As tCourseType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CourseCategoryID", adInteger, adParamInput, vbNull, CLng(bvCourseCategoryID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Course_ListCourse")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.CourseID = moUtil.FetchLong(.Fields.Item("CourseID").Value)
            vRec.TrainerID = moUtil.FetchLong(.Fields.Item("TrainerID").Value)
            vRec.CourseCategoryID = moUtil.FetchLong(.Fields.Item("CourseCategoryID").Value)
            vRec.TrainerName = moUtil.FetchString(.Fields.Item("TrainerName").Value)
            vRec.CourseName = moUtil.FetchString(.Fields.Item("CourseName").Value)
            vRec.CourseLength = moUtil.FetchLong(.Fields.Item("CourseLength").Value)
            vRec.Video = moUtil.FetchInteger(.Fields.Item("Video").Value)
            vRec.Audio = moUtil.FetchInteger(.Fields.Item("Audio").Value)
            vRec.Quiz = moUtil.FetchInteger(.Fields.Item("Quiz").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListCourse = vRecs

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

Public Function ListPrivate( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvUserID As Long) As tCourseType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListPrivate"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tCourseType
   Dim vRec As tCourseType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Course_ListPrivate")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.CourseID = moUtil.FetchLong(.Fields.Item("CourseID").Value)
            vRec.TrainerID = moUtil.FetchLong(.Fields.Item("TrainerID").Value)
            vRec.CourseCategoryID = moUtil.FetchLong(.Fields.Item("CourseCategoryID").Value)
            vRec.TrainerName = moUtil.FetchString(.Fields.Item("TrainerName").Value)
            vRec.TrainerID = moUtil.FetchLong(.Fields.Item("TrainerID").Value)
            vRec.CourseName = moUtil.FetchString(.Fields.Item("CourseName").Value)
            vRec.CourseLength = moUtil.FetchLong(.Fields.Item("CourseLength").Value)
            vRec.Rating = moUtil.FetchLong(.Fields.Item("Rating").Value)
            vRec.RatingCnt = moUtil.FetchLong(.Fields.Item("RatingCnt").Value)
            vRec.Classes = moUtil.FetchLong(.Fields.Item("Classes").Value)
            vRec.Language = moUtil.FetchString(.Fields.Item("Language").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Video = moUtil.FetchInteger(.Fields.Item("Video").Value)
            vRec.Audio = moUtil.FetchInteger(.Fields.Item("Audio").Value)
            vRec.Quiz = moUtil.FetchInteger(.Fields.Item("Quiz").Value)
            vRec.CourseDate = moUtil.FetchDate(.Fields.Item("CourseDate").Value)
            vRec.Grp = moUtil.FetchLong(.Fields.Item("Grp").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListPrivate = vRecs

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

Public Function ListSingleCourse( _ 
   ByVal bvCourseID As Long, _ 
   ByVal bvUserID As Long) As tCourseType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListSingleCourse"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tCourseType
   Dim vRec As tCourseType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvCourseID = moUtil.EditLong(bvCourseID, "CourseID", True, 0, 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CourseID", adInteger, adParamInput, vbNull, CLng(bvCourseID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Course_ListSingleCourse")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.CourseID = moUtil.FetchLong(.Fields.Item("CourseID").Value)
            vRec.CourseName = moUtil.FetchString(.Fields.Item("CourseName").Value)
            vRec.TrainerName = moUtil.FetchString(.Fields.Item("TrainerName").Value)
            vRec.TrainerID = moUtil.FetchLong(.Fields.Item("TrainerID").Value)
            vRec.CourseLength = moUtil.FetchLong(.Fields.Item("CourseLength").Value)
            vRec.Rating = moUtil.FetchLong(.Fields.Item("Rating").Value)
            vRec.RatingCnt = moUtil.FetchLong(.Fields.Item("RatingCnt").Value)
            vRec.Classes = moUtil.FetchLong(.Fields.Item("Classes").Value)
            vRec.Language = moUtil.FetchString(.Fields.Item("Language").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Video = moUtil.FetchInteger(.Fields.Item("Video").Value)
            vRec.Audio = moUtil.FetchInteger(.Fields.Item("Audio").Value)
            vRec.Quiz = moUtil.FetchInteger(.Fields.Item("Quiz").Value)
            vRec.CourseDate = moUtil.FetchDate(.Fields.Item("CourseDate").Value)
            vRec.Grp = moUtil.FetchLong(.Fields.Item("Grp").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListSingleCourse = vRecs

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

Public Function ListTextCourses( _ 
   ByVal bvDescription As String) As tCourseType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListTextCourses"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tCourseType
   Dim vRec As tCourseType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvDescription = moUtil.EditString(bvDescription, "Description", True, "", 1, 1000) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 1000, bvDescription)
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Course_ListTextCourses")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.CourseID = moUtil.FetchLong(.Fields.Item("CourseID").Value)
            vRec.CourseName = moUtil.FetchString(.Fields.Item("CourseName").Value)
            vRec.TrainerName = moUtil.FetchString(.Fields.Item("TrainerName").Value)
            vRec.TrainerID = moUtil.FetchLong(.Fields.Item("TrainerID").Value)
            vRec.CourseLength = moUtil.FetchLong(.Fields.Item("CourseLength").Value)
            vRec.Rating = moUtil.FetchLong(.Fields.Item("Rating").Value)
            vRec.RatingCnt = moUtil.FetchLong(.Fields.Item("RatingCnt").Value)
            vRec.Classes = moUtil.FetchLong(.Fields.Item("Classes").Value)
            vRec.Language = moUtil.FetchString(.Fields.Item("Language").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Video = moUtil.FetchInteger(.Fields.Item("Video").Value)
            vRec.Audio = moUtil.FetchInteger(.Fields.Item("Audio").Value)
            vRec.Quiz = moUtil.FetchInteger(.Fields.Item("Quiz").Value)
            vRec.CourseDate = moUtil.FetchDate(.Fields.Item("CourseDate").Value)
            vRec.Amount = moUtil.FetchLong(.Fields.Item("Amount").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListTextCourses = vRecs

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

Public Function ListOrg( _ 
   ByVal bvOrgID As Long) As tCourseType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListOrg"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tCourseType
   Dim vRec As tCourseType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@OrgID", adInteger, adParamInput, vbNull, CLng(bvOrgID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Course_ListOrg")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.CourseID = moUtil.FetchLong(.Fields.Item("CourseID").Value)
            vRec.CourseName = moUtil.FetchString(.Fields.Item("CourseName").Value)
            vRec.TrainerName = moUtil.FetchString(.Fields.Item("TrainerName").Value)
            vRec.TrainerID = moUtil.FetchLong(.Fields.Item("TrainerID").Value)
            vRec.CourseLength = moUtil.FetchLong(.Fields.Item("CourseLength").Value)
            vRec.CourseType = moUtil.FetchLong(.Fields.Item("CourseType").Value)
            vRec.CourseLevel = moUtil.FetchLong(.Fields.Item("CourseLevel").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.Rating = moUtil.FetchLong(.Fields.Item("Rating").Value)
            vRec.RatingCnt = moUtil.FetchLong(.Fields.Item("RatingCnt").Value)
            vRec.Classes = moUtil.FetchLong(.Fields.Item("Classes").Value)
            vRec.Language = moUtil.FetchString(.Fields.Item("Language").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Video = moUtil.FetchInteger(.Fields.Item("Video").Value)
            vRec.Audio = moUtil.FetchInteger(.Fields.Item("Audio").Value)
            vRec.Quiz = moUtil.FetchInteger(.Fields.Item("Quiz").Value)
            vRec.Grp = moUtil.FetchLong(.Fields.Item("Grp").Value)
            vRec.OrgCourseID = moUtil.FetchLong(.Fields.Item("OrgCourseID").Value)
            vRec.OrgStatus = moUtil.FetchLong(.Fields.Item("OrgStatus").Value)
            vRec.OrgSeq = moUtil.FetchLong(.Fields.Item("OrgSeq").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListOrg = vRecs

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

Public Function ListFavorite( _ 
   ByVal bvOrgID As Long, _ 
   ByVal bvUserID As Long) As tCourseType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListFavorite"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tCourseType
   Dim vRec As tCourseType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvOrgID = moUtil.EditLong(bvOrgID, "OrgID", True, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@OrgID", adInteger, adParamInput, vbNull, CLng(bvOrgID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Course_ListFavorite")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.CourseID = moUtil.FetchLong(.Fields.Item("CourseID").Value)
            vRec.CourseName = moUtil.FetchString(.Fields.Item("CourseName").Value)
            vRec.CourseLength = moUtil.FetchLong(.Fields.Item("CourseLength").Value)
            vRec.Rating = moUtil.FetchLong(.Fields.Item("Rating").Value)
            vRec.RatingCnt = moUtil.FetchLong(.Fields.Item("RatingCnt").Value)
            vRec.Classes = moUtil.FetchLong(.Fields.Item("Classes").Value)
            vRec.Language = moUtil.FetchString(.Fields.Item("Language").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Video = moUtil.FetchInteger(.Fields.Item("Video").Value)
            vRec.Audio = moUtil.FetchInteger(.Fields.Item("Audio").Value)
            vRec.Quiz = moUtil.FetchInteger(.Fields.Item("Quiz").Value)
            vRec.CourseDate = moUtil.FetchDate(.Fields.Item("CourseDate").Value)
            vRec.Grp = moUtil.FetchLong(.Fields.Item("Grp").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListFavorite = vRecs

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

Public Function ListProgram( _ 
   ByVal bvOrgID As Long, _ 
   ByVal bvUserID As Long) As tCourseType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListProgram"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tCourseType
   Dim vRec As tCourseType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvOrgID = moUtil.EditLong(bvOrgID, "OrgID", True, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@OrgID", adInteger, adParamInput, vbNull, CLng(bvOrgID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Course_ListProgram")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.CourseID = moUtil.FetchLong(.Fields.Item("CourseID").Value)
            vRec.CourseName = moUtil.FetchString(.Fields.Item("CourseName").Value)
            vRec.CourseLength = moUtil.FetchLong(.Fields.Item("CourseLength").Value)
            vRec.Rating = moUtil.FetchLong(.Fields.Item("Rating").Value)
            vRec.RatingCnt = moUtil.FetchLong(.Fields.Item("RatingCnt").Value)
            vRec.Classes = moUtil.FetchLong(.Fields.Item("Classes").Value)
            vRec.Language = moUtil.FetchString(.Fields.Item("Language").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Video = moUtil.FetchInteger(.Fields.Item("Video").Value)
            vRec.Audio = moUtil.FetchInteger(.Fields.Item("Audio").Value)
            vRec.Quiz = moUtil.FetchInteger(.Fields.Item("Quiz").Value)
            vRec.CourseDate = moUtil.FetchDate(.Fields.Item("CourseDate").Value)
            vRec.Grp = moUtil.FetchLong(.Fields.Item("Grp").Value)
            vRec.Credit = moUtil.FetchCurrency(.Fields.Item("Credit").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListProgram = vRecs

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

Public Function ListCourseCategory( _ 
   ByVal bvCourseCategoryID As Long, _ 
   ByVal bvUserID As Long) As tCourseType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListCourseCategory"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tCourseType
   Dim vRec As tCourseType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CourseCategoryID", adInteger, adParamInput, vbNull, CLng(bvCourseCategoryID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Course_ListCourseCategory")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.CourseID = moUtil.FetchLong(.Fields.Item("CourseID").Value)
            vRec.CourseName = moUtil.FetchString(.Fields.Item("CourseName").Value)
            vRec.TrainerName = moUtil.FetchString(.Fields.Item("TrainerName").Value)
            vRec.TrainerID = moUtil.FetchLong(.Fields.Item("TrainerID").Value)
            vRec.CourseLength = moUtil.FetchLong(.Fields.Item("CourseLength").Value)
            vRec.Rating = moUtil.FetchLong(.Fields.Item("Rating").Value)
            vRec.RatingCnt = moUtil.FetchLong(.Fields.Item("RatingCnt").Value)
            vRec.Classes = moUtil.FetchLong(.Fields.Item("Classes").Value)
            vRec.Language = moUtil.FetchString(.Fields.Item("Language").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Video = moUtil.FetchInteger(.Fields.Item("Video").Value)
            vRec.Audio = moUtil.FetchInteger(.Fields.Item("Audio").Value)
            vRec.Quiz = moUtil.FetchInteger(.Fields.Item("Quiz").Value)
            vRec.CourseDate = moUtil.FetchDate(.Fields.Item("CourseDate").Value)
            vRec.Grp = moUtil.FetchLong(.Fields.Item("Grp").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListCourseCategory = vRecs

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

Public Function ListGrp( _ 
   ByVal bvGrp As Long) As tCourseType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListGrp"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tCourseType
   Dim vRec As tCourseType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Grp", adInteger, adParamInput, vbNull, CLng(bvGrp))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Course_ListGrp")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.CourseID = moUtil.FetchLong(.Fields.Item("CourseID").Value)
            vRec.CourseName = moUtil.FetchString(.Fields.Item("CourseName").Value)
            vRec.TrainerName = moUtil.FetchString(.Fields.Item("TrainerName").Value)
            vRec.TrainerID = moUtil.FetchLong(.Fields.Item("TrainerID").Value)
            vRec.CourseLength = moUtil.FetchLong(.Fields.Item("CourseLength").Value)
            vRec.Rating = moUtil.FetchLong(.Fields.Item("Rating").Value)
            vRec.RatingCnt = moUtil.FetchLong(.Fields.Item("RatingCnt").Value)
            vRec.Classes = moUtil.FetchLong(.Fields.Item("Classes").Value)
            vRec.Language = moUtil.FetchString(.Fields.Item("Language").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Video = moUtil.FetchInteger(.Fields.Item("Video").Value)
            vRec.Audio = moUtil.FetchInteger(.Fields.Item("Audio").Value)
            vRec.Quiz = moUtil.FetchInteger(.Fields.Item("Quiz").Value)
            vRec.CourseDate = moUtil.FetchDate(.Fields.Item("CourseDate").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListGrp = vRecs

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

Public Function ReportStatus() As tCourseType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tCourseType
   Dim vRec As tCourseType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Course_ReportStatus")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.CourseID = moUtil.FetchLong(.Fields.Item("CourseID").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.Quantity = moUtil.FetchLong(.Fields.Item("Quantity").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ReportStatus = vRecs

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

Public Function ReportReview() As tCourseType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportReview"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tCourseType
   Dim vRec As tCourseType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Course_ReportReview")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.CourseID = moUtil.FetchLong(.Fields.Item("CourseID").Value)
            vRec.CourseName = moUtil.FetchString(.Fields.Item("CourseName").Value)
            vRec.TrainerName = moUtil.FetchString(.Fields.Item("TrainerName").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ReportReview = vRecs

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
   ByRef brRec As tCourseType, _ 
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
      .Parameters.Append .CreateParameter("@CourseID", adInteger, adParamInput, vbNull, CLng(brRec.CourseID))
      .Parameters.Append .CreateParameter("@CourseCategoryID", adInteger, adParamInput, vbNull, CLng(brRec.CourseCategoryID))
      .Parameters.Append .CreateParameter("@TrainerID", adInteger, adParamInput, vbNull, CLng(brRec.TrainerID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@ExamID", adInteger, adParamInput, vbNull, CLng(brRec.ExamID))
      .Parameters.Append .CreateParameter("@CourseName", adVarWChar, adParamInput, 80, brRec.CourseName)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@CourseType", adInteger, adParamInput, vbNull, CLng(brRec.CourseType))
      .Parameters.Append .CreateParameter("@CourseLevel", adInteger, adParamInput, vbNull, CLng(brRec.CourseLevel))
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 1000, brRec.Description)
      .Parameters.Append .CreateParameter("@Language", adVarWChar, adParamInput, 20, brRec.Language)
      .Parameters.Append .CreateParameter("@CourseLength", adInteger, adParamInput, vbNull, CLng(brRec.CourseLength))
      .Parameters.Append .CreateParameter("@CourseDate", adDate, adParamInput, vbNull, CDate(brRec.CourseDate))
      .Parameters.Append .CreateParameter("@IsPaid", adSmallInt, adParamInput, vbNull, CInt(brRec.IsPaid))
      .Parameters.Append .CreateParameter("@Price", adCurrency, adParamInput, vbNull, CCur(brRec.Price))
      .Parameters.Append .CreateParameter("@Grp", adInteger, adParamInput, vbNull, CLng(brRec.Grp))
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@PassingGrade", adInteger, adParamInput, vbNull, CLng(brRec.PassingGrade))
      .Parameters.Append .CreateParameter("@Rating", adInteger, adParamInput, vbNull, CLng(brRec.Rating))
      .Parameters.Append .CreateParameter("@RatingCnt", adInteger, adParamInput, vbNull, CLng(brRec.RatingCnt))
      .Parameters.Append .CreateParameter("@Classes", adInteger, adParamInput, vbNull, CLng(brRec.Classes))
      .Parameters.Append .CreateParameter("@Video", adSmallInt, adParamInput, vbNull, CInt(brRec.Video))
      .Parameters.Append .CreateParameter("@Audio", adSmallInt, adParamInput, vbNull, CInt(brRec.Audio))
      .Parameters.Append .CreateParameter("@Quiz", adSmallInt, adParamInput, vbNull, CInt(brRec.Quiz))
      .Parameters.Append .CreateParameter("@Reference", adVarWChar, adParamInput, 15, brRec.Reference)
      Dim tmpParamScoreFactor As ADODB.Parameter
      Set tmpParamScoreFactor = .CreateParameter("@ScoreFactor", adNumeric, adParamInput, 10, CDbl(brRec.ScoreFactor))
      tmpParamScoreFactor.Precision = 10
      tmpParamScoreFactor.NumericScale = 6
      .Parameters.Append tmpParamScoreFactor
      .Parameters.Append .CreateParameter("@NoCertificate", adSmallInt, adParamInput, vbNull, CInt(brRec.NoCertificate))
      .Parameters.Append .CreateParameter("@NoEvaluation", adSmallInt, adParamInput, vbNull, CInt(brRec.NoEvaluation))
      .Parameters.Append .CreateParameter("@IsCustomCertificate", adSmallInt, adParamInput, vbNull, CInt(brRec.IsCustomCertificate))
      .Parameters.Append .CreateParameter("@Credit", adCurrency, adParamInput, vbNull, CCur(brRec.Credit))
      .Parameters.Append .CreateParameter("@ExamWeight", adInteger, adParamInput, vbNull, CLng(brRec.ExamWeight))
      .Parameters.Append .CreateParameter("@Pre", adVarWChar, adParamInput, 20, brRec.Pre)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Course_Update"

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
   ByRef brRec As tCourseType, _ 
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
         .CourseID = moUtil.EditLong(.CourseID, "CourseID", True, , 1) 
      End If
      .CourseCategoryID = moUtil.EditLong(.CourseCategoryID, "CourseCategoryID", False) 
      .TrainerID = moUtil.EditLong(.TrainerID, "TrainerID", False) 
      .CompanyID = moUtil.EditLong(.CompanyID, "CompanyID", False) 
      .ExamID = moUtil.EditLong(.ExamID, "ExamID", False) 
      .CourseName = moUtil.EditString(.CourseName, "CourseName", True, , 1, 80) 
      .Status = moUtil.EditLong(.Status, "Status", True) 
      .CourseType = moUtil.EditLong(.CourseType, "CourseType", True) 
      .CourseLevel = moUtil.EditLong(.CourseLevel, "CourseLevel", True) 
      .Description = moUtil.EditString(.Description, "Description", False, , 1, 1000) 
      .Language = moUtil.EditString(.Language, "Language", False, , 1, 20) 
      .CourseLength = moUtil.EditLong(.CourseLength, "CourseLength", True) 
      .CourseDate = moUtil.EditDate(.CourseDate, "CourseDate", True) 
      .IsPaid = moUtil.EditInteger(.IsPaid, "IsPaid", False, 0, 0, 1) 
      .Price = moUtil.EditCurrency(.Price, "Price", False) 
      .Grp = moUtil.EditLong(.Grp, "Grp", False) 
      .Seq = moUtil.EditLong(.Seq, "Seq", False) 
      .PassingGrade = moUtil.EditLong(.PassingGrade, "PassingGrade", False) 
      .Rating = moUtil.EditLong(.Rating, "Rating", False) 
      .RatingCnt = moUtil.EditLong(.RatingCnt, "RatingCnt", False) 
      .Classes = moUtil.EditLong(.Classes, "Classes", False) 
      .Video = moUtil.EditInteger(.Video, "Video", False, 0, 0, 1) 
      .Audio = moUtil.EditInteger(.Audio, "Audio", False, 0, 0, 1) 
      .Quiz = moUtil.EditInteger(.Quiz, "Quiz", False, 0, 0, 1) 
      .Reference = moUtil.EditString(.Reference, "Reference", False, , 1, 15) 
      .ScoreFactor = moUtil.EditDouble(.ScoreFactor, "ScoreFactor", False) 
      .NoCertificate = moUtil.EditInteger(.NoCertificate, "NoCertificate", False, 0, 0, 1) 
      .NoEvaluation = moUtil.EditInteger(.NoEvaluation, "NoEvaluation", False, 0, 0, 1) 
      .IsCustomCertificate = moUtil.EditInteger(.IsCustomCertificate, "IsCustomCertificate", False, 0, 0, 1) 
      .Credit = moUtil.EditCurrency(.Credit, "Credit", False, , 0, 9.99) 
      .ExamWeight = moUtil.EditLong(.ExamWeight, "ExamWeight", False) 
      .Pre = moUtil.EditString(.Pre, "Pre", False, , 1, 20) 
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