VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CSuggestionB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CSuggestion"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tSuggestionType
   SuggestionID As String
   OrgID As String
   MemberID As String
   OrgName As String
   CompanyID As String
   NameLast As String
   NameFirst As String
   MemberName As String
   Subject As String
   Description As String
   Status As String
   SuggestionDate As String
   Response As String
   ChangeDate As String
End Type

Public Sub Add( _ 
   ByRef brRec As tSuggestionType, _ 
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
      .Parameters.Append .CreateParameter("@SuggestionID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@OrgID", adInteger, adParamInput, vbNull, CLng(brRec.OrgID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@Subject", adVarWChar, adParamInput, 60, brRec.Subject)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 2000, brRec.Description)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@SuggestionDate", adDate, adParamInput, vbNull, CDate(brRec.SuggestionDate))
      .Parameters.Append .CreateParameter("@Response", adVarWChar, adParamInput, 1000, brRec.Response)
      .Parameters.Append .CreateParameter("@ChangeDate", adDate, adParamInput, vbNull, CDate(brRec.ChangeDate))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Suggestion_Add"

   '-----get return values
   With brRec
      .SuggestionID = moUtil.FetchLong(oCmd.Parameters.Item("@SuggestionID").Value)
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
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Suggestion_Count"

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
   ByRef brRec As tSuggestionType, _ 
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
      .SuggestionID = moUtil.EditLong(.SuggestionID, "SuggestionID", False, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SuggestionID", adInteger, adParamInput, vbNull, CLng(brRec.SuggestionID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Suggestion_Delete"

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
   ByRef brRec As tSuggestionType, _ 
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
      .SuggestionID = moUtil.EditLong(.SuggestionID, "SuggestionID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SuggestionID", adInteger, adParamInput, vbNull, CLng(brRec.SuggestionID))
      .Parameters.Append .CreateParameter("@OrgID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@OrgName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@MemberName", adVarWChar, adParamOutput, 62, vbNull)
      .Parameters.Append .CreateParameter("@Subject", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamOutput, 2000, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SuggestionDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Response", adVarWChar, adParamOutput, 1000, vbNull)
      .Parameters.Append .CreateParameter("@ChangeDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Suggestion_Fetch"

   '-----get return values
   With brRec
      .OrgID = moUtil.FetchLong(oCmd.Parameters.Item("@OrgID").Value)
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .OrgName = moUtil.FetchString(oCmd.Parameters.Item("@OrgName").Value)
      .CompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@CompanyID").Value)
      .NameLast = moUtil.FetchString(oCmd.Parameters.Item("@NameLast").Value)
      .NameFirst = moUtil.FetchString(oCmd.Parameters.Item("@NameFirst").Value)
      .MemberName = moUtil.FetchString(oCmd.Parameters.Item("@MemberName").Value)
      .Subject = moUtil.FetchString(oCmd.Parameters.Item("@Subject").Value)
      .Description = moUtil.FetchString(oCmd.Parameters.Item("@Description").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .SuggestionDate = moUtil.FetchDate(oCmd.Parameters.Item("@SuggestionDate").Value)
      .Response = moUtil.FetchString(oCmd.Parameters.Item("@Response").Value)
      .ChangeDate = moUtil.FetchDate(oCmd.Parameters.Item("@ChangeDate").Value)
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

Public Function FindOrg( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvOrgID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tSuggestionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindOrg"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSuggestionType
   Dim vRec As tSuggestionType
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
      Case cptsSuggestionFindSuggestionDate
         sProc = "pts_Suggestion_FindOrgSuggestionDate"
         MaxBookMark = 30
      Case cptsSuggestionFindSuggestionID
         sProc = "pts_Suggestion_FindOrgSuggestionID"
         MaxBookMark = 20
      Case cptsSuggestionFindSubject
         sProc = "pts_Suggestion_FindOrgSubject"
         MaxBookMark = 70
      Case cptsSuggestionFindResponse
         sProc = "pts_Suggestion_FindOrgResponse"
         MaxBookMark = 1010
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
               vRec.SuggestionID = moUtil.FetchLong(.Fields.Item("SuggestionID").Value)
               vRec.OrgID = moUtil.FetchLong(.Fields.Item("OrgID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.OrgName = moUtil.FetchString(.Fields.Item("OrgName").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.Subject = moUtil.FetchString(.Fields.Item("Subject").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.SuggestionDate = moUtil.FetchDate(.Fields.Item("SuggestionDate").Value)
               vRec.Response = moUtil.FetchString(.Fields.Item("Response").Value)
               vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
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

Public Function FindCompany( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tSuggestionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindCompany"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSuggestionType
   Dim vRec As tSuggestionType
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
      Case cptsSuggestionFindSuggestionDate
         sProc = "pts_Suggestion_FindCompanySuggestionDate"
         MaxBookMark = 30
      Case cptsSuggestionFindSuggestionID
         sProc = "pts_Suggestion_FindCompanySuggestionID"
         MaxBookMark = 20
      Case cptsSuggestionFindSubject
         sProc = "pts_Suggestion_FindCompanySubject"
         MaxBookMark = 70
      Case cptsSuggestionFindResponse
         sProc = "pts_Suggestion_FindCompanyResponse"
         MaxBookMark = 1010
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
               vRec.SuggestionID = moUtil.FetchLong(.Fields.Item("SuggestionID").Value)
               vRec.OrgID = moUtil.FetchLong(.Fields.Item("OrgID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.OrgName = moUtil.FetchString(.Fields.Item("OrgName").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.Subject = moUtil.FetchString(.Fields.Item("Subject").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.SuggestionDate = moUtil.FetchDate(.Fields.Item("SuggestionDate").Value)
               vRec.Response = moUtil.FetchString(.Fields.Item("Response").Value)
               vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
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

Public Function FindOrgStatus( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvOrgID As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tSuggestionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindOrgStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSuggestionType
   Dim vRec As tSuggestionType
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
      Case cptsSuggestionFindSuggestionDate
         sProc = "pts_Suggestion_FindOrgStatusSuggestionDate"
         MaxBookMark = 30
      Case cptsSuggestionFindSuggestionID
         sProc = "pts_Suggestion_FindOrgStatusSuggestionID"
         MaxBookMark = 20
      Case cptsSuggestionFindSubject
         sProc = "pts_Suggestion_FindOrgStatusSubject"
         MaxBookMark = 70
      Case cptsSuggestionFindResponse
         sProc = "pts_Suggestion_FindOrgStatusResponse"
         MaxBookMark = 1010
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@OrgID", adInteger, adParamInput, vbNull, CLng(bvOrgID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
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
               vRec.SuggestionID = moUtil.FetchLong(.Fields.Item("SuggestionID").Value)
               vRec.OrgID = moUtil.FetchLong(.Fields.Item("OrgID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.OrgName = moUtil.FetchString(.Fields.Item("OrgName").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.Subject = moUtil.FetchString(.Fields.Item("Subject").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.SuggestionDate = moUtil.FetchDate(.Fields.Item("SuggestionDate").Value)
               vRec.Response = moUtil.FetchString(.Fields.Item("Response").Value)
               vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
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
   FindOrgStatus = vRecs

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

Public Function FindCompanyStatus( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tSuggestionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindCompanyStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSuggestionType
   Dim vRec As tSuggestionType
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
      Case cptsSuggestionFindSuggestionDate
         sProc = "pts_Suggestion_FindCompanyStatusSuggestionDate"
         MaxBookMark = 30
      Case cptsSuggestionFindSuggestionID
         sProc = "pts_Suggestion_FindCompanyStatusSuggestionID"
         MaxBookMark = 20
      Case cptsSuggestionFindSubject
         sProc = "pts_Suggestion_FindCompanyStatusSubject"
         MaxBookMark = 70
      Case cptsSuggestionFindResponse
         sProc = "pts_Suggestion_FindCompanyStatusResponse"
         MaxBookMark = 1010
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
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
               vRec.SuggestionID = moUtil.FetchLong(.Fields.Item("SuggestionID").Value)
               vRec.OrgID = moUtil.FetchLong(.Fields.Item("OrgID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.OrgName = moUtil.FetchString(.Fields.Item("OrgName").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.Subject = moUtil.FetchString(.Fields.Item("Subject").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.SuggestionDate = moUtil.FetchDate(.Fields.Item("SuggestionDate").Value)
               vRec.Response = moUtil.FetchString(.Fields.Item("Response").Value)
               vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
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
   FindCompanyStatus = vRecs

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

Public Function ListSubmitted( _ 
   ByVal bvMemberID As Long) As tSuggestionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListSubmitted"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSuggestionType
   Dim vRec As tSuggestionType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Suggestion_ListSubmitted")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SuggestionID = moUtil.FetchLong(.Fields.Item("SuggestionID").Value)
            vRec.SuggestionDate = moUtil.FetchDate(.Fields.Item("SuggestionDate").Value)
            vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
            vRec.Subject = moUtil.FetchString(.Fields.Item("Subject").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Response = moUtil.FetchString(.Fields.Item("Response").Value)
            vRec.OrgName = moUtil.FetchString(.Fields.Item("OrgName").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListSubmitted = vRecs

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

Public Function ListReplied( _ 
   ByVal bvMemberID As Long) As tSuggestionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListReplied"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSuggestionType
   Dim vRec As tSuggestionType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Suggestion_ListReplied")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SuggestionID = moUtil.FetchLong(.Fields.Item("SuggestionID").Value)
            vRec.SuggestionDate = moUtil.FetchDate(.Fields.Item("SuggestionDate").Value)
            vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
            vRec.Subject = moUtil.FetchString(.Fields.Item("Subject").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Response = moUtil.FetchString(.Fields.Item("Response").Value)
            vRec.OrgName = moUtil.FetchString(.Fields.Item("OrgName").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListReplied = vRecs

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

Public Function ListDate( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvSuggestionDate As Date) As tSuggestionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListDate"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSuggestionType
   Dim vRec As tSuggestionType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True, 0) 
      bvSuggestionDate = moUtil.EditDate(bvSuggestionDate, "SuggestionDate", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@SuggestionDate", adDate, adParamInput, vbNull, CDate(bvSuggestionDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Suggestion_ListDate")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SuggestionID = moUtil.FetchLong(.Fields.Item("SuggestionID").Value)
            vRec.SuggestionDate = moUtil.FetchDate(.Fields.Item("SuggestionDate").Value)
            vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
            vRec.Subject = moUtil.FetchString(.Fields.Item("Subject").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Response = moUtil.FetchString(.Fields.Item("Response").Value)
            vRec.OrgName = moUtil.FetchString(.Fields.Item("OrgName").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListDate = vRecs

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
   ByRef brRec As tSuggestionType, _ 
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
      .Parameters.Append .CreateParameter("@SuggestionID", adInteger, adParamInput, vbNull, CLng(brRec.SuggestionID))
      .Parameters.Append .CreateParameter("@OrgID", adInteger, adParamInput, vbNull, CLng(brRec.OrgID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@Subject", adVarWChar, adParamInput, 60, brRec.Subject)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 2000, brRec.Description)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@SuggestionDate", adDate, adParamInput, vbNull, CDate(brRec.SuggestionDate))
      .Parameters.Append .CreateParameter("@Response", adVarWChar, adParamInput, 1000, brRec.Response)
      .Parameters.Append .CreateParameter("@ChangeDate", adDate, adParamInput, vbNull, CDate(brRec.ChangeDate))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Suggestion_Update"

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
   ByRef brRec As tSuggestionType, _ 
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
         .SuggestionID = moUtil.EditLong(.SuggestionID, "SuggestionID", False, , 1) 
      End If
      .OrgID = moUtil.EditLong(.OrgID, "OrgID", False) 
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", False) 
      .Subject = moUtil.EditString(.Subject, "Subject", True, , 1, 60) 
      .Description = moUtil.EditString(.Description, "Description", False, , 1, 2000) 
      .Status = moUtil.EditLong(.Status, "Status", True) 
      .SuggestionDate = moUtil.EditDate(.SuggestionDate, "SuggestionDate", False) 
      .Response = moUtil.EditString(.Response, "Response", False, , 1, 1000) 
      .ChangeDate = moUtil.EditDate(.ChangeDate, "ChangeDate", False) 
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