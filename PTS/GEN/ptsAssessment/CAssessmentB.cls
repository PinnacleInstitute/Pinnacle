VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CAssessmentB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CAssessment"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tAssessmentType
   AssessmentID As String
   TrainerID As String
   CompanyID As String
   FirstQuestionCode As String
   AssessmentName As String
   Description As String
   Courses As String
   Assessments As String
   AssessDate As String
   Status As String
   AssessmentType As String
   NewURL As String
   EditURL As String
   ResultType As String
   Formula As String
   CustomCode As String
   Takes As String
   Delay As String
   IsTrial As String
   IsPaid As String
   IsCertify As String
   AssessType As String
   AssessLevel As String
   AssessLength As String
   ScoreFactor As String
   Rating As String
   Grade As String
   Points As String
   TimeLimit As String
   NoCertificate As String
   IsCustomCertificate As String
   MemberID As String
End Type

Public Sub Add( _ 
   ByRef brRec As tAssessmentType, _ 
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
      .Parameters.Append .CreateParameter("@AssessmentID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@TrainerID", adInteger, adParamInput, vbNull, CLng(brRec.TrainerID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@FirstQuestionCode", adInteger, adParamInput, vbNull, CLng(brRec.FirstQuestionCode))
      .Parameters.Append .CreateParameter("@AssessmentName", adVarWChar, adParamInput, 60, brRec.AssessmentName)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 500, brRec.Description)
      .Parameters.Append .CreateParameter("@Courses", adVarWChar, adParamInput, 50, brRec.Courses)
      .Parameters.Append .CreateParameter("@Assessments", adVarWChar, adParamInput, 50, brRec.Assessments)
      .Parameters.Append .CreateParameter("@AssessDate", adDate, adParamInput, vbNull, CDate(brRec.AssessDate))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@AssessmentType", adInteger, adParamInput, vbNull, CLng(brRec.AssessmentType))
      .Parameters.Append .CreateParameter("@NewURL", adVarWChar, adParamInput, 200, brRec.NewURL)
      .Parameters.Append .CreateParameter("@EditURL", adVarWChar, adParamInput, 200, brRec.EditURL)
      .Parameters.Append .CreateParameter("@ResultType", adInteger, adParamInput, vbNull, CLng(brRec.ResultType))
      .Parameters.Append .CreateParameter("@Formula", adVarWChar, adParamInput, 100, brRec.Formula)
      .Parameters.Append .CreateParameter("@CustomCode", adInteger, adParamInput, vbNull, CLng(brRec.CustomCode))
      .Parameters.Append .CreateParameter("@Takes", adInteger, adParamInput, vbNull, CLng(brRec.Takes))
      .Parameters.Append .CreateParameter("@Delay", adInteger, adParamInput, vbNull, CLng(brRec.Delay))
      .Parameters.Append .CreateParameter("@IsTrial", adSmallInt, adParamInput, vbNull, CInt(brRec.IsTrial))
      .Parameters.Append .CreateParameter("@IsPaid", adSmallInt, adParamInput, vbNull, CInt(brRec.IsPaid))
      .Parameters.Append .CreateParameter("@IsCertify", adSmallInt, adParamInput, vbNull, CInt(brRec.IsCertify))
      .Parameters.Append .CreateParameter("@AssessType", adInteger, adParamInput, vbNull, CLng(brRec.AssessType))
      .Parameters.Append .CreateParameter("@AssessLevel", adInteger, adParamInput, vbNull, CLng(brRec.AssessLevel))
      .Parameters.Append .CreateParameter("@AssessLength", adInteger, adParamInput, vbNull, CLng(brRec.AssessLength))
      Dim tmpParamScoreFactor As ADODB.Parameter
      Set tmpParamScoreFactor = .CreateParameter("@ScoreFactor", adNumeric, adParamInput, 10, CDbl(brRec.ScoreFactor))
      tmpParamScoreFactor.Precision = 10
      tmpParamScoreFactor.NumericScale = 6
      .Parameters.Append tmpParamScoreFactor
      .Parameters.Append .CreateParameter("@Rating", adInteger, adParamInput, vbNull, CLng(brRec.Rating))
      .Parameters.Append .CreateParameter("@Grade", adInteger, adParamInput, vbNull, CLng(brRec.Grade))
      .Parameters.Append .CreateParameter("@Points", adInteger, adParamInput, vbNull, CLng(brRec.Points))
      .Parameters.Append .CreateParameter("@TimeLimit", adInteger, adParamInput, vbNull, CLng(brRec.TimeLimit))
      .Parameters.Append .CreateParameter("@NoCertificate", adSmallInt, adParamInput, vbNull, CInt(brRec.NoCertificate))
      .Parameters.Append .CreateParameter("@IsCustomCertificate", adSmallInt, adParamInput, vbNull, CInt(brRec.IsCustomCertificate))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Assessment_Add"

   '-----get return values
   With brRec
      .AssessmentID = moUtil.FetchLong(oCmd.Parameters.Item("@AssessmentID").Value)
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

Public Function TestTakes( _ 
   ByRef brRec As tAssessmentType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "TestTakes"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AssessmentID", adInteger, adParamInput, vbNull, CLng(brRec.AssessmentID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@Takes", adInteger, adParamInput, vbNull, CLng(brRec.Takes))
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Assessment_TestTakes"

   '-----get return values
   TestTakes = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function TestDelay( _ 
   ByRef brRec As tAssessmentType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "TestDelay"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AssessmentID", adInteger, adParamInput, vbNull, CLng(brRec.AssessmentID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@Delay", adInteger, adParamInput, vbNull, CLng(brRec.Delay))
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Assessment_TestDelay"

   '-----get return values
   TestDelay = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function Valid( _ 
   ByRef brRec As tAssessmentType, _ 
   ByVal bvUserID As Long) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Valid"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AssessmentID", adInteger, adParamInput, vbNull, CLng(brRec.AssessmentID))
      .Parameters.Append .CreateParameter("@Result", adVarWChar, adParamOutput, 1000, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Assessment_Valid"

   '-----get return values
   Valid = moUtil.FetchString(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function Copy( _ 
   ByRef brRec As tAssessmentType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Copy"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .AssessmentID = moUtil.EditLong(.AssessmentID, "AssessmentID", True, 0, 1) 
      .TrainerID = moUtil.EditLong(.TrainerID, "TrainerID", True, 0) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AssessmentID", adInteger, adParamInput, vbNull, CLng(brRec.AssessmentID))
      .Parameters.Append .CreateParameter("@TrainerID", adInteger, adParamInput, vbNull, CLng(brRec.TrainerID))
      .Parameters.Append .CreateParameter("@NewAssessmentID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Assessment_Copy"

   '-----get return values
   Copy = moUtil.FetchLong(oCmd.Parameters.Item("@NewAssessmentID").Value)

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
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Assessment_Count"

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
   ByRef brRec As tAssessmentType, _ 
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
      .AssessmentID = moUtil.EditLong(.AssessmentID, "AssessmentID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AssessmentID", adInteger, adParamInput, vbNull, CLng(brRec.AssessmentID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Assessment_Delete"

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

Public Function EnumCompany( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvSecurityToken As Long) As tAssessmentType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns an enumerated list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EnumCompany"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAssessmentType
   Dim vRec As tAssessmentType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Assessment_EnumCompany")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.AssessmentID = moUtil.FetchLong(.Fields.Item("ID").Value)
            vRec.AssessmentName = moUtil.FetchString(.Fields.Item("Name").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   EnumCompany = vRecs

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

Public Sub Fetch( _ 
   ByRef brRec As tAssessmentType, _ 
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
      .AssessmentID = moUtil.EditLong(.AssessmentID, "AssessmentID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AssessmentID", adInteger, adParamInput, vbNull, CLng(brRec.AssessmentID))
      .Parameters.Append .CreateParameter("@TrainerID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@FirstQuestionCode", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AssessmentName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamOutput, 500, vbNull)
      .Parameters.Append .CreateParameter("@Courses", adVarWChar, adParamOutput, 50, vbNull)
      .Parameters.Append .CreateParameter("@Assessments", adVarWChar, adParamOutput, 50, vbNull)
      .Parameters.Append .CreateParameter("@AssessDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AssessmentType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NewURL", adVarWChar, adParamOutput, 200, vbNull)
      .Parameters.Append .CreateParameter("@EditURL", adVarWChar, adParamOutput, 200, vbNull)
      .Parameters.Append .CreateParameter("@ResultType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Formula", adVarWChar, adParamOutput, 100, vbNull)
      .Parameters.Append .CreateParameter("@CustomCode", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Takes", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Delay", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsTrial", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsPaid", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsCertify", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AssessType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AssessLevel", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AssessLength", adInteger, adParamOutput, vbNull, vbNull)
      Dim tmpParamScoreFactor As ADODB.Parameter
      Set tmpParamScoreFactor = .CreateParameter("@ScoreFactor", adNumeric, adParamOutput, 10, vbNull)
      tmpParamScoreFactor.Precision = 10
      tmpParamScoreFactor.NumericScale = 6
      .Parameters.Append tmpParamScoreFactor
      .Parameters.Append .CreateParameter("@Rating", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Grade", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Points", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@TimeLimit", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NoCertificate", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsCustomCertificate", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Assessment_Fetch"

   '-----get return values
   With brRec
      .TrainerID = moUtil.FetchLong(oCmd.Parameters.Item("@TrainerID").Value)
      .CompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@CompanyID").Value)
      .FirstQuestionCode = moUtil.FetchLong(oCmd.Parameters.Item("@FirstQuestionCode").Value)
      .AssessmentName = moUtil.FetchString(oCmd.Parameters.Item("@AssessmentName").Value)
      .Description = moUtil.FetchString(oCmd.Parameters.Item("@Description").Value)
      .Courses = moUtil.FetchString(oCmd.Parameters.Item("@Courses").Value)
      .Assessments = moUtil.FetchString(oCmd.Parameters.Item("@Assessments").Value)
      .AssessDate = moUtil.FetchDate(oCmd.Parameters.Item("@AssessDate").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .AssessmentType = moUtil.FetchLong(oCmd.Parameters.Item("@AssessmentType").Value)
      .NewURL = moUtil.FetchString(oCmd.Parameters.Item("@NewURL").Value)
      .EditURL = moUtil.FetchString(oCmd.Parameters.Item("@EditURL").Value)
      .ResultType = moUtil.FetchLong(oCmd.Parameters.Item("@ResultType").Value)
      .Formula = moUtil.FetchString(oCmd.Parameters.Item("@Formula").Value)
      .CustomCode = moUtil.FetchLong(oCmd.Parameters.Item("@CustomCode").Value)
      .Takes = moUtil.FetchLong(oCmd.Parameters.Item("@Takes").Value)
      .Delay = moUtil.FetchLong(oCmd.Parameters.Item("@Delay").Value)
      .IsTrial = moUtil.FetchInteger(oCmd.Parameters.Item("@IsTrial").Value)
      .IsPaid = moUtil.FetchInteger(oCmd.Parameters.Item("@IsPaid").Value)
      .IsCertify = moUtil.FetchInteger(oCmd.Parameters.Item("@IsCertify").Value)
      .AssessType = moUtil.FetchLong(oCmd.Parameters.Item("@AssessType").Value)
      .AssessLevel = moUtil.FetchLong(oCmd.Parameters.Item("@AssessLevel").Value)
      .AssessLength = moUtil.FetchLong(oCmd.Parameters.Item("@AssessLength").Value)
      .ScoreFactor = moUtil.FetchDouble(oCmd.Parameters.Item("@ScoreFactor").Value)
      .Rating = moUtil.FetchLong(oCmd.Parameters.Item("@Rating").Value)
      .Grade = moUtil.FetchLong(oCmd.Parameters.Item("@Grade").Value)
      .Points = moUtil.FetchLong(oCmd.Parameters.Item("@Points").Value)
      .TimeLimit = moUtil.FetchLong(oCmd.Parameters.Item("@TimeLimit").Value)
      .NoCertificate = moUtil.FetchInteger(oCmd.Parameters.Item("@NoCertificate").Value)
      .IsCustomCertificate = moUtil.FetchInteger(oCmd.Parameters.Item("@IsCustomCertificate").Value)
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
   Optional ByVal bvSecurityToken As Long = 0) As tAssessmentType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAssessmentType
   Dim vRec As tAssessmentType
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
      Case cptsAssessmentFindAssessmentName
         sProc = "pts_Assessment_FindAssessmentName"
         MaxBookMark = 70
      Case cptsAssessmentFindStatus
         sProc = "pts_Assessment_FindStatus"
         MaxBookMark = 20
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
               vRec.AssessmentID = moUtil.FetchLong(.Fields.Item("AssessmentID").Value)
               vRec.TrainerID = moUtil.FetchLong(.Fields.Item("TrainerID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.FirstQuestionCode = moUtil.FetchLong(.Fields.Item("FirstQuestionCode").Value)
               vRec.AssessmentName = moUtil.FetchString(.Fields.Item("AssessmentName").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Courses = moUtil.FetchString(.Fields.Item("Courses").Value)
               vRec.Assessments = moUtil.FetchString(.Fields.Item("Assessments").Value)
               vRec.AssessDate = moUtil.FetchDate(.Fields.Item("AssessDate").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.AssessmentType = moUtil.FetchLong(.Fields.Item("AssessmentType").Value)
               vRec.NewURL = moUtil.FetchString(.Fields.Item("NewURL").Value)
               vRec.EditURL = moUtil.FetchString(.Fields.Item("EditURL").Value)
               vRec.ResultType = moUtil.FetchLong(.Fields.Item("ResultType").Value)
               vRec.Formula = moUtil.FetchString(.Fields.Item("Formula").Value)
               vRec.CustomCode = moUtil.FetchLong(.Fields.Item("CustomCode").Value)
               vRec.Takes = moUtil.FetchLong(.Fields.Item("Takes").Value)
               vRec.Delay = moUtil.FetchLong(.Fields.Item("Delay").Value)
               vRec.IsTrial = moUtil.FetchInteger(.Fields.Item("IsTrial").Value)
               vRec.IsPaid = moUtil.FetchInteger(.Fields.Item("IsPaid").Value)
               vRec.IsCertify = moUtil.FetchInteger(.Fields.Item("IsCertify").Value)
               vRec.AssessType = moUtil.FetchLong(.Fields.Item("AssessType").Value)
               vRec.AssessLevel = moUtil.FetchLong(.Fields.Item("AssessLevel").Value)
               vRec.AssessLength = moUtil.FetchLong(.Fields.Item("AssessLength").Value)
               vRec.ScoreFactor = moUtil.FetchDouble(.Fields.Item("ScoreFactor").Value)
               vRec.Rating = moUtil.FetchLong(.Fields.Item("Rating").Value)
               vRec.Grade = moUtil.FetchLong(.Fields.Item("Grade").Value)
               vRec.Points = moUtil.FetchLong(.Fields.Item("Points").Value)
               vRec.TimeLimit = moUtil.FetchLong(.Fields.Item("TimeLimit").Value)
               vRec.NoCertificate = moUtil.FetchInteger(.Fields.Item("NoCertificate").Value)
               vRec.IsCustomCertificate = moUtil.FetchInteger(.Fields.Item("IsCustomCertificate").Value)
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

Public Function ListTrainer( _ 
   ByVal bvTrainerID As Long, _ 
   ByVal bvUserID As Long) As tAssessmentType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListTrainer"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAssessmentType
   Dim vRec As tAssessmentType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvTrainerID = moUtil.EditLong(bvTrainerID, "TrainerID", True, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@TrainerID", adInteger, adParamInput, vbNull, CLng(bvTrainerID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Assessment_ListTrainer")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.AssessmentID = moUtil.FetchLong(.Fields.Item("AssessmentID").Value)
            vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
            vRec.AssessmentName = moUtil.FetchString(.Fields.Item("AssessmentName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.IsTrial = moUtil.FetchInteger(.Fields.Item("IsTrial").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListTrainer = vRecs

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

Public Function ListCompany( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvUserID As Long) As tAssessmentType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListCompany"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAssessmentType
   Dim vRec As tAssessmentType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvCompanyID = moUtil.EditLong(bvCompanyID, "CompanyID", True, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Assessment_ListCompany")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.AssessmentID = moUtil.FetchLong(.Fields.Item("AssessmentID").Value)
            vRec.TrainerID = moUtil.FetchLong(.Fields.Item("TrainerID").Value)
            vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
            vRec.AssessmentName = moUtil.FetchString(.Fields.Item("AssessmentName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.IsTrial = moUtil.FetchInteger(.Fields.Item("IsTrial").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListCompany = vRecs

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

Public Function ListTB( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvAssessDate As Date, _ 
   ByVal bvStatus As Long, _ 
   ByVal bvIsTrial As Integer) As tAssessmentType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListTB"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAssessmentType
   Dim vRec As tAssessmentType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@AssessDate", adDate, adParamInput, vbNull, CDate(bvAssessDate))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
      .Parameters.Append .CreateParameter("@IsTrial", adSmallInt, adParamInput, vbNull, CInt(bvIsTrial))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Assessment_ListTB")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.AssessmentID = moUtil.FetchLong(.Fields.Item("AssessmentID").Value)
            vRec.AssessmentName = moUtil.FetchString(.Fields.Item("AssessmentName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.AssessDate = moUtil.FetchDate(.Fields.Item("AssessDate").Value)
            vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
            vRec.Takes = moUtil.FetchLong(.Fields.Item("Takes").Value)
            vRec.Delay = moUtil.FetchLong(.Fields.Item("Delay").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListTB = vRecs

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

Public Function ListAssessmentText( _ 
   ByVal bvAssessments As String) As tAssessmentType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListAssessmentText"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAssessmentType
   Dim vRec As tAssessmentType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvAssessments = moUtil.EditString(bvAssessments, "Assessments", True, "", 1, 50) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Assessments", adVarWChar, adParamInput, 50, bvAssessments)
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Assessment_ListAssessmentText")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.AssessmentID = moUtil.FetchLong(.Fields.Item("AssessmentID").Value)
            vRec.AssessmentName = moUtil.FetchString(.Fields.Item("AssessmentName").Value)
            vRec.AssessmentType = moUtil.FetchLong(.Fields.Item("AssessmentType").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.AssessDate = moUtil.FetchDate(.Fields.Item("AssessDate").Value)
            vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
            vRec.Takes = moUtil.FetchLong(.Fields.Item("Takes").Value)
            vRec.Delay = moUtil.FetchLong(.Fields.Item("Delay").Value)
            vRec.IsCertify = moUtil.FetchInteger(.Fields.Item("IsCertify").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListAssessmentText = vRecs

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

Public Function ListAssessment( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvUserID As Long) As tAssessmentType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListAssessment"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAssessmentType
   Dim vRec As tAssessmentType
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
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Assessment_ListAssessment")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.AssessmentID = moUtil.FetchLong(.Fields.Item("AssessmentID").Value)
            vRec.AssessmentName = moUtil.FetchString(.Fields.Item("AssessmentName").Value)
            vRec.AssessmentType = moUtil.FetchLong(.Fields.Item("AssessmentType").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.AssessDate = moUtil.FetchDate(.Fields.Item("AssessDate").Value)
            vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
            vRec.Takes = moUtil.FetchLong(.Fields.Item("Takes").Value)
            vRec.Delay = moUtil.FetchLong(.Fields.Item("Delay").Value)
            vRec.IsCertify = moUtil.FetchInteger(.Fields.Item("IsCertify").Value)
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

Public Function ListAssessmentType( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvAssessType As Long, _ 
   ByVal bvUserID As Long) As tAssessmentType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListAssessmentType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAssessmentType
   Dim vRec As tAssessmentType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvAssessType = moUtil.EditLong(bvAssessType, "AssessType", True, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@AssessType", adInteger, adParamInput, vbNull, CLng(bvAssessType))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Assessment_ListAssessmentType")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.AssessmentID = moUtil.FetchLong(.Fields.Item("AssessmentID").Value)
            vRec.AssessmentName = moUtil.FetchString(.Fields.Item("AssessmentName").Value)
            vRec.AssessmentType = moUtil.FetchLong(.Fields.Item("AssessmentType").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.AssessDate = moUtil.FetchDate(.Fields.Item("AssessDate").Value)
            vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
            vRec.Takes = moUtil.FetchLong(.Fields.Item("Takes").Value)
            vRec.Delay = moUtil.FetchLong(.Fields.Item("Delay").Value)
            vRec.IsCertify = moUtil.FetchInteger(.Fields.Item("IsCertify").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListAssessmentType = vRecs

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

Public Function ListAssessmentTrial( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvUserID As Long) As tAssessmentType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListAssessmentTrial"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAssessmentType
   Dim vRec As tAssessmentType
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
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Assessment_ListAssessmentTrial")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.AssessmentID = moUtil.FetchLong(.Fields.Item("AssessmentID").Value)
            vRec.AssessmentName = moUtil.FetchString(.Fields.Item("AssessmentName").Value)
            vRec.AssessmentType = moUtil.FetchLong(.Fields.Item("AssessmentType").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.AssessDate = moUtil.FetchDate(.Fields.Item("AssessDate").Value)
            vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
            vRec.Takes = moUtil.FetchLong(.Fields.Item("Takes").Value)
            vRec.Delay = moUtil.FetchLong(.Fields.Item("Delay").Value)
            vRec.IsCertify = moUtil.FetchInteger(.Fields.Item("IsCertify").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListAssessmentTrial = vRecs

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

Public Function ListAssessmentTrialType( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvAssessType As Long, _ 
   ByVal bvUserID As Long) As tAssessmentType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListAssessmentTrialType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAssessmentType
   Dim vRec As tAssessmentType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvAssessType = moUtil.EditLong(bvAssessType, "AssessType", True, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@AssessType", adInteger, adParamInput, vbNull, CLng(bvAssessType))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Assessment_ListAssessmentTrialType")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.AssessmentID = moUtil.FetchLong(.Fields.Item("AssessmentID").Value)
            vRec.AssessmentName = moUtil.FetchString(.Fields.Item("AssessmentName").Value)
            vRec.AssessmentType = moUtil.FetchLong(.Fields.Item("AssessmentType").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.AssessDate = moUtil.FetchDate(.Fields.Item("AssessDate").Value)
            vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
            vRec.Takes = moUtil.FetchLong(.Fields.Item("Takes").Value)
            vRec.Delay = moUtil.FetchLong(.Fields.Item("Delay").Value)
            vRec.IsCertify = moUtil.FetchInteger(.Fields.Item("IsCertify").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListAssessmentTrialType = vRecs

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
   ByRef brRec As tAssessmentType, _ 
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
      .Parameters.Append .CreateParameter("@AssessmentID", adInteger, adParamInput, vbNull, CLng(brRec.AssessmentID))
      .Parameters.Append .CreateParameter("@TrainerID", adInteger, adParamInput, vbNull, CLng(brRec.TrainerID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@FirstQuestionCode", adInteger, adParamInput, vbNull, CLng(brRec.FirstQuestionCode))
      .Parameters.Append .CreateParameter("@AssessmentName", adVarWChar, adParamInput, 60, brRec.AssessmentName)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 500, brRec.Description)
      .Parameters.Append .CreateParameter("@Courses", adVarWChar, adParamInput, 50, brRec.Courses)
      .Parameters.Append .CreateParameter("@Assessments", adVarWChar, adParamInput, 50, brRec.Assessments)
      .Parameters.Append .CreateParameter("@AssessDate", adDate, adParamInput, vbNull, CDate(brRec.AssessDate))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@AssessmentType", adInteger, adParamInput, vbNull, CLng(brRec.AssessmentType))
      .Parameters.Append .CreateParameter("@NewURL", adVarWChar, adParamInput, 200, brRec.NewURL)
      .Parameters.Append .CreateParameter("@EditURL", adVarWChar, adParamInput, 200, brRec.EditURL)
      .Parameters.Append .CreateParameter("@ResultType", adInteger, adParamInput, vbNull, CLng(brRec.ResultType))
      .Parameters.Append .CreateParameter("@Formula", adVarWChar, adParamInput, 100, brRec.Formula)
      .Parameters.Append .CreateParameter("@CustomCode", adInteger, adParamInput, vbNull, CLng(brRec.CustomCode))
      .Parameters.Append .CreateParameter("@Takes", adInteger, adParamInput, vbNull, CLng(brRec.Takes))
      .Parameters.Append .CreateParameter("@Delay", adInteger, adParamInput, vbNull, CLng(brRec.Delay))
      .Parameters.Append .CreateParameter("@IsTrial", adSmallInt, adParamInput, vbNull, CInt(brRec.IsTrial))
      .Parameters.Append .CreateParameter("@IsPaid", adSmallInt, adParamInput, vbNull, CInt(brRec.IsPaid))
      .Parameters.Append .CreateParameter("@IsCertify", adSmallInt, adParamInput, vbNull, CInt(brRec.IsCertify))
      .Parameters.Append .CreateParameter("@AssessType", adInteger, adParamInput, vbNull, CLng(brRec.AssessType))
      .Parameters.Append .CreateParameter("@AssessLevel", adInteger, adParamInput, vbNull, CLng(brRec.AssessLevel))
      .Parameters.Append .CreateParameter("@AssessLength", adInteger, adParamInput, vbNull, CLng(brRec.AssessLength))
      Dim tmpParamScoreFactor As ADODB.Parameter
      Set tmpParamScoreFactor = .CreateParameter("@ScoreFactor", adNumeric, adParamInput, 10, CDbl(brRec.ScoreFactor))
      tmpParamScoreFactor.Precision = 10
      tmpParamScoreFactor.NumericScale = 6
      .Parameters.Append tmpParamScoreFactor
      .Parameters.Append .CreateParameter("@Rating", adInteger, adParamInput, vbNull, CLng(brRec.Rating))
      .Parameters.Append .CreateParameter("@Grade", adInteger, adParamInput, vbNull, CLng(brRec.Grade))
      .Parameters.Append .CreateParameter("@Points", adInteger, adParamInput, vbNull, CLng(brRec.Points))
      .Parameters.Append .CreateParameter("@TimeLimit", adInteger, adParamInput, vbNull, CLng(brRec.TimeLimit))
      .Parameters.Append .CreateParameter("@NoCertificate", adSmallInt, adParamInput, vbNull, CInt(brRec.NoCertificate))
      .Parameters.Append .CreateParameter("@IsCustomCertificate", adSmallInt, adParamInput, vbNull, CInt(brRec.IsCustomCertificate))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Assessment_Update"

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
   ByRef brRec As tAssessmentType, _ 
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
         .AssessmentID = moUtil.EditLong(.AssessmentID, "AssessmentID", True, , 1) 
      End If
      .TrainerID = moUtil.EditLong(.TrainerID, "TrainerID", False) 
      .CompanyID = moUtil.EditLong(.CompanyID, "CompanyID", False) 
      .FirstQuestionCode = moUtil.EditLong(.FirstQuestionCode, "FirstQuestionCode", False) 
      .AssessmentName = moUtil.EditString(.AssessmentName, "AssessmentName", True, , 1, 60) 
      .Description = moUtil.EditString(.Description, "Description", False, , 1, 500) 
      .Courses = moUtil.EditString(.Courses, "Courses", False, , 1, 50) 
      .Assessments = moUtil.EditString(.Assessments, "Assessments", False, , 1, 50) 
      .AssessDate = moUtil.EditDate(.AssessDate, "AssessDate", True) 
      .Status = moUtil.EditLong(.Status, "Status", True) 
      .AssessmentType = moUtil.EditLong(.AssessmentType, "AssessmentType", True) 
      .NewURL = moUtil.EditString(.NewURL, "NewURL", False, , 1, 200) 
      .EditURL = moUtil.EditString(.EditURL, "EditURL", False, , 1, 200) 
      .ResultType = moUtil.EditLong(.ResultType, "ResultType", False) 
      .Formula = moUtil.EditString(.Formula, "Formula", False, , 1, 100) 
      .CustomCode = moUtil.EditLong(.CustomCode, "CustomCode", False) 
      .Takes = moUtil.EditLong(.Takes, "Takes", False) 
      .Delay = moUtil.EditLong(.Delay, "Delay", False) 
      .IsTrial = moUtil.EditInteger(.IsTrial, "IsTrial", False, 0, 0, 1) 
      .IsPaid = moUtil.EditInteger(.IsPaid, "IsPaid", False, 0, 0, 1) 
      .IsCertify = moUtil.EditInteger(.IsCertify, "IsCertify", False, 0, 0, 1) 
      .AssessType = moUtil.EditLong(.AssessType, "AssessType", True) 
      .AssessLevel = moUtil.EditLong(.AssessLevel, "AssessLevel", True) 
      .AssessLength = moUtil.EditLong(.AssessLength, "AssessLength", True) 
      .ScoreFactor = moUtil.EditDouble(.ScoreFactor, "ScoreFactor", False) 
      .Rating = moUtil.EditLong(.Rating, "Rating", False) 
      .Grade = moUtil.EditLong(.Grade, "Grade", False, , 0, 100) 
      .Points = moUtil.EditLong(.Points, "Points", False) 
      .TimeLimit = moUtil.EditLong(.TimeLimit, "TimeLimit", False) 
      .NoCertificate = moUtil.EditInteger(.NoCertificate, "NoCertificate", False, 0, 0, 1) 
      .IsCustomCertificate = moUtil.EditInteger(.IsCustomCertificate, "IsCustomCertificate", False, 0, 0, 1) 
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