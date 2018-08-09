VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CEmailB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CEmail"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tEmailType
   EmailID As String
   CompanyID As String
   NewsLetterID As String
   EmailListID As String
   EmailName As String
   FromEmail As String
   Subject As String
   FileName As String
   Status As String
   SendDate As String
   Repeat As String
   EndDate As String
   Mailings As String
   Emails As String
   TestEmail As String
   TestFirstName As String
   TestLastName As String
   TestData1 As String
   TestData2 As String
   TestData3 As String
   TestData4 As String
   TestData5 As String
   EmailType As String
   IsSalesStep As String
End Type

Public Sub Add( _ 
   ByRef brRec As tEmailType, _ 
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
      .Parameters.Append .CreateParameter("@EmailID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@NewsLetterID", adInteger, adParamInput, vbNull, CLng(brRec.NewsLetterID))
      .Parameters.Append .CreateParameter("@EmailListID", adInteger, adParamInput, vbNull, CLng(brRec.EmailListID))
      .Parameters.Append .CreateParameter("@EmailName", adVarWChar, adParamInput, 60, brRec.EmailName)
      .Parameters.Append .CreateParameter("@FromEmail", adVarWChar, adParamInput, 60, brRec.FromEmail)
      .Parameters.Append .CreateParameter("@Subject", adVarWChar, adParamInput, 80, brRec.Subject)
      .Parameters.Append .CreateParameter("@FileName", adVarWChar, adParamInput, 20, brRec.FileName)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@SendDate", adDate, adParamInput, vbNull, CDate(brRec.SendDate))
      .Parameters.Append .CreateParameter("@Repeat", adVarWChar, adParamInput, 5, brRec.Repeat)
      .Parameters.Append .CreateParameter("@EndDate", adDate, adParamInput, vbNull, CDate(brRec.EndDate))
      .Parameters.Append .CreateParameter("@Mailings", adInteger, adParamInput, vbNull, CLng(brRec.Mailings))
      .Parameters.Append .CreateParameter("@Emails", adInteger, adParamInput, vbNull, CLng(brRec.Emails))
      .Parameters.Append .CreateParameter("@TestEmail", adVarWChar, adParamInput, 80, brRec.TestEmail)
      .Parameters.Append .CreateParameter("@TestFirstName", adVarWChar, adParamInput, 30, brRec.TestFirstName)
      .Parameters.Append .CreateParameter("@TestLastName", adVarWChar, adParamInput, 30, brRec.TestLastName)
      .Parameters.Append .CreateParameter("@TestData1", adVarWChar, adParamInput, 80, brRec.TestData1)
      .Parameters.Append .CreateParameter("@TestData2", adVarWChar, adParamInput, 80, brRec.TestData2)
      .Parameters.Append .CreateParameter("@TestData3", adVarWChar, adParamInput, 80, brRec.TestData3)
      .Parameters.Append .CreateParameter("@TestData4", adVarWChar, adParamInput, 80, brRec.TestData4)
      .Parameters.Append .CreateParameter("@TestData5", adVarWChar, adParamInput, 80, brRec.TestData5)
      .Parameters.Append .CreateParameter("@EmailType", adInteger, adParamInput, vbNull, CLng(brRec.EmailType))
      .Parameters.Append .CreateParameter("@IsSalesStep", adSmallInt, adParamInput, vbNull, CInt(brRec.IsSalesStep))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Email_Add"

   '-----get return values
   With brRec
      .EmailID = moUtil.FetchLong(oCmd.Parameters.Item("@EmailID").Value)
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
   ByRef brRec As tEmailType, _ 
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
      .EmailID = moUtil.EditLong(.EmailID, "EmailID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@EmailID", adInteger, adParamInput, vbNull, CLng(brRec.EmailID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Email_Delete"

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

Public Function EnumUserProspect( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvSecurityToken As Long) As tEmailType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns an enumerated list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EnumUserProspect"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tEmailType
   Dim vRec As tEmailType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Email_EnumUserProspect")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.EmailID = moUtil.FetchLong(.Fields.Item("ID").Value)
            vRec.EmailName = moUtil.FetchString(.Fields.Item("Name").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   EnumUserProspect = vRecs

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
   ByRef brRec As tEmailType, _ 
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
      .EmailID = moUtil.EditLong(.EmailID, "EmailID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@EmailID", adInteger, adParamInput, vbNull, CLng(brRec.EmailID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NewsLetterID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@EmailListID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@EmailName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@FromEmail", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Subject", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@FileName", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SendDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Repeat", adVarWChar, adParamOutput, 5, vbNull)
      .Parameters.Append .CreateParameter("@EndDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Mailings", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Emails", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@TestEmail", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@TestFirstName", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@TestLastName", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@TestData1", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@TestData2", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@TestData3", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@TestData4", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@TestData5", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@EmailType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsSalesStep", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Email_Fetch"

   '-----get return values
   With brRec
      .CompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@CompanyID").Value)
      .NewsLetterID = moUtil.FetchLong(oCmd.Parameters.Item("@NewsLetterID").Value)
      .EmailListID = moUtil.FetchLong(oCmd.Parameters.Item("@EmailListID").Value)
      .EmailName = moUtil.FetchString(oCmd.Parameters.Item("@EmailName").Value)
      .FromEmail = moUtil.FetchString(oCmd.Parameters.Item("@FromEmail").Value)
      .Subject = moUtil.FetchString(oCmd.Parameters.Item("@Subject").Value)
      .FileName = moUtil.FetchString(oCmd.Parameters.Item("@FileName").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .SendDate = moUtil.FetchDate(oCmd.Parameters.Item("@SendDate").Value)
      .Repeat = moUtil.FetchString(oCmd.Parameters.Item("@Repeat").Value)
      .EndDate = moUtil.FetchDate(oCmd.Parameters.Item("@EndDate").Value)
      .Mailings = moUtil.FetchLong(oCmd.Parameters.Item("@Mailings").Value)
      .Emails = moUtil.FetchLong(oCmd.Parameters.Item("@Emails").Value)
      .TestEmail = moUtil.FetchString(oCmd.Parameters.Item("@TestEmail").Value)
      .TestFirstName = moUtil.FetchString(oCmd.Parameters.Item("@TestFirstName").Value)
      .TestLastName = moUtil.FetchString(oCmd.Parameters.Item("@TestLastName").Value)
      .TestData1 = moUtil.FetchString(oCmd.Parameters.Item("@TestData1").Value)
      .TestData2 = moUtil.FetchString(oCmd.Parameters.Item("@TestData2").Value)
      .TestData3 = moUtil.FetchString(oCmd.Parameters.Item("@TestData3").Value)
      .TestData4 = moUtil.FetchString(oCmd.Parameters.Item("@TestData4").Value)
      .TestData5 = moUtil.FetchString(oCmd.Parameters.Item("@TestData5").Value)
      .EmailType = moUtil.FetchLong(oCmd.Parameters.Item("@EmailType").Value)
      .IsSalesStep = moUtil.FetchInteger(oCmd.Parameters.Item("@IsSalesStep").Value)
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
   ByVal bvCompanyID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tEmailType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tEmailType
   Dim vRec As tEmailType
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
      Case cptsEmailFindEmailName
         sProc = "pts_Email_FindEmailName"
         MaxBookMark = 70
      Case cptsEmailFindSendDate
         sProc = "pts_Email_FindSendDate"
         MaxBookMark = 30
      Case cptsEmailFindStatus
         sProc = "pts_Email_FindStatus"
         MaxBookMark = 20
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
               vRec.EmailID = moUtil.FetchLong(.Fields.Item("EmailID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.NewsLetterID = moUtil.FetchLong(.Fields.Item("NewsLetterID").Value)
               vRec.EmailListID = moUtil.FetchLong(.Fields.Item("EmailListID").Value)
               vRec.EmailName = moUtil.FetchString(.Fields.Item("EmailName").Value)
               vRec.FromEmail = moUtil.FetchString(.Fields.Item("FromEmail").Value)
               vRec.Subject = moUtil.FetchString(.Fields.Item("Subject").Value)
               vRec.FileName = moUtil.FetchString(.Fields.Item("FileName").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.SendDate = moUtil.FetchDate(.Fields.Item("SendDate").Value)
               vRec.Repeat = moUtil.FetchString(.Fields.Item("Repeat").Value)
               vRec.EndDate = moUtil.FetchDate(.Fields.Item("EndDate").Value)
               vRec.Mailings = moUtil.FetchLong(.Fields.Item("Mailings").Value)
               vRec.Emails = moUtil.FetchLong(.Fields.Item("Emails").Value)
               vRec.TestEmail = moUtil.FetchString(.Fields.Item("TestEmail").Value)
               vRec.TestFirstName = moUtil.FetchString(.Fields.Item("TestFirstName").Value)
               vRec.TestLastName = moUtil.FetchString(.Fields.Item("TestLastName").Value)
               vRec.TestData1 = moUtil.FetchString(.Fields.Item("TestData1").Value)
               vRec.TestData2 = moUtil.FetchString(.Fields.Item("TestData2").Value)
               vRec.TestData3 = moUtil.FetchString(.Fields.Item("TestData3").Value)
               vRec.TestData4 = moUtil.FetchString(.Fields.Item("TestData4").Value)
               vRec.TestData5 = moUtil.FetchString(.Fields.Item("TestData5").Value)
               vRec.EmailType = moUtil.FetchLong(.Fields.Item("EmailType").Value)
               vRec.IsSalesStep = moUtil.FetchInteger(.Fields.Item("IsSalesStep").Value)
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

Public Function FindTeam( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvNewsLetterID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tEmailType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindTeam"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tEmailType
   Dim vRec As tEmailType
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
      Case cptsEmailFindEmailName
         sProc = "pts_Email_FindTeamEmailName"
         MaxBookMark = 70
      Case cptsEmailFindSendDate
         sProc = "pts_Email_FindTeamSendDate"
         MaxBookMark = 30
      Case cptsEmailFindStatus
         sProc = "pts_Email_FindTeamStatus"
         MaxBookMark = 20
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NewsLetterID", adInteger, adParamInput, vbNull, CLng(bvNewsLetterID))
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
               vRec.EmailID = moUtil.FetchLong(.Fields.Item("EmailID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.NewsLetterID = moUtil.FetchLong(.Fields.Item("NewsLetterID").Value)
               vRec.EmailListID = moUtil.FetchLong(.Fields.Item("EmailListID").Value)
               vRec.EmailName = moUtil.FetchString(.Fields.Item("EmailName").Value)
               vRec.FromEmail = moUtil.FetchString(.Fields.Item("FromEmail").Value)
               vRec.Subject = moUtil.FetchString(.Fields.Item("Subject").Value)
               vRec.FileName = moUtil.FetchString(.Fields.Item("FileName").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.SendDate = moUtil.FetchDate(.Fields.Item("SendDate").Value)
               vRec.Repeat = moUtil.FetchString(.Fields.Item("Repeat").Value)
               vRec.EndDate = moUtil.FetchDate(.Fields.Item("EndDate").Value)
               vRec.Mailings = moUtil.FetchLong(.Fields.Item("Mailings").Value)
               vRec.Emails = moUtil.FetchLong(.Fields.Item("Emails").Value)
               vRec.TestEmail = moUtil.FetchString(.Fields.Item("TestEmail").Value)
               vRec.TestFirstName = moUtil.FetchString(.Fields.Item("TestFirstName").Value)
               vRec.TestLastName = moUtil.FetchString(.Fields.Item("TestLastName").Value)
               vRec.TestData1 = moUtil.FetchString(.Fields.Item("TestData1").Value)
               vRec.TestData2 = moUtil.FetchString(.Fields.Item("TestData2").Value)
               vRec.TestData3 = moUtil.FetchString(.Fields.Item("TestData3").Value)
               vRec.TestData4 = moUtil.FetchString(.Fields.Item("TestData4").Value)
               vRec.TestData5 = moUtil.FetchString(.Fields.Item("TestData5").Value)
               vRec.EmailType = moUtil.FetchLong(.Fields.Item("EmailType").Value)
               vRec.IsSalesStep = moUtil.FetchInteger(.Fields.Item("IsSalesStep").Value)
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
   FindTeam = vRecs

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

Public Function ListEmails( _ 
   ByVal bvUserID As Long) As tEmailType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListEmails"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tEmailType
   Dim vRec As tEmailType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Email_ListEmails")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.EmailID = moUtil.FetchLong(.Fields.Item("EmailID").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListEmails = vRecs

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

Public Function ListProspectEmails( _ 
   ByVal bvUserID As Long) As tEmailType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListProspectEmails"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tEmailType
   Dim vRec As tEmailType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Email_ListProspectEmails")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.EmailID = moUtil.FetchLong(.Fields.Item("EmailID").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListProspectEmails = vRecs

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

Public Function ListNewsletterEmails( _ 
   ByVal bvUserID As Long) As tEmailType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListNewsletterEmails"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tEmailType
   Dim vRec As tEmailType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Email_ListNewsletterEmails")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.EmailID = moUtil.FetchLong(.Fields.Item("EmailID").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListNewsletterEmails = vRecs

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

Public Function ListNewsletter( _ 
   ByVal bvNewsLetterID As Long) As tEmailType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListNewsletter"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tEmailType
   Dim vRec As tEmailType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@NewsLetterID", adInteger, adParamInput, vbNull, CLng(bvNewsLetterID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Email_ListNewsletter")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.EmailID = moUtil.FetchLong(.Fields.Item("EmailID").Value)
            vRec.EmailName = moUtil.FetchString(.Fields.Item("EmailName").Value)
            vRec.SendDate = moUtil.FetchDate(.Fields.Item("SendDate").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.Emails = moUtil.FetchLong(.Fields.Item("Emails").Value)
            vRec.Mailings = moUtil.FetchLong(.Fields.Item("Mailings").Value)
            vRec.FileName = moUtil.FetchString(.Fields.Item("FileName").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListNewsletter = vRecs

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

Public Function ListNewsletterAll( _ 
   ByVal bvNewsLetterID As Long) As tEmailType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListNewsletterAll"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tEmailType
   Dim vRec As tEmailType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@NewsLetterID", adInteger, adParamInput, vbNull, CLng(bvNewsLetterID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Email_ListNewsletterAll")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.EmailID = moUtil.FetchLong(.Fields.Item("EmailID").Value)
            vRec.EmailName = moUtil.FetchString(.Fields.Item("EmailName").Value)
            vRec.SendDate = moUtil.FetchDate(.Fields.Item("SendDate").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.Emails = moUtil.FetchLong(.Fields.Item("Emails").Value)
            vRec.Mailings = moUtil.FetchLong(.Fields.Item("Mailings").Value)
            vRec.FileName = moUtil.FetchString(.Fields.Item("FileName").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListNewsletterAll = vRecs

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

Public Function ListSalesStep( _ 
   ByVal bvNewsLetterID As Long) As tEmailType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListSalesStep"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tEmailType
   Dim vRec As tEmailType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@NewsLetterID", adInteger, adParamInput, vbNull, CLng(bvNewsLetterID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Email_ListSalesStep")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.EmailID = moUtil.FetchLong(.Fields.Item("EmailID").Value)
            vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
            vRec.NewsLetterID = moUtil.FetchLong(.Fields.Item("NewsLetterID").Value)
            vRec.EmailName = moUtil.FetchString(.Fields.Item("EmailName").Value)
            vRec.FromEmail = moUtil.FetchString(.Fields.Item("FromEmail").Value)
            vRec.Subject = moUtil.FetchString(.Fields.Item("Subject").Value)
            vRec.FileName = moUtil.FetchString(.Fields.Item("FileName").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.SendDate = moUtil.FetchDate(.Fields.Item("SendDate").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListSalesStep = vRecs

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
   ByRef brRec As tEmailType, _ 
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
      .Parameters.Append .CreateParameter("@EmailID", adInteger, adParamInput, vbNull, CLng(brRec.EmailID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@NewsLetterID", adInteger, adParamInput, vbNull, CLng(brRec.NewsLetterID))
      .Parameters.Append .CreateParameter("@EmailListID", adInteger, adParamInput, vbNull, CLng(brRec.EmailListID))
      .Parameters.Append .CreateParameter("@EmailName", adVarWChar, adParamInput, 60, brRec.EmailName)
      .Parameters.Append .CreateParameter("@FromEmail", adVarWChar, adParamInput, 60, brRec.FromEmail)
      .Parameters.Append .CreateParameter("@Subject", adVarWChar, adParamInput, 80, brRec.Subject)
      .Parameters.Append .CreateParameter("@FileName", adVarWChar, adParamInput, 20, brRec.FileName)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@SendDate", adDate, adParamInput, vbNull, CDate(brRec.SendDate))
      .Parameters.Append .CreateParameter("@Repeat", adVarWChar, adParamInput, 5, brRec.Repeat)
      .Parameters.Append .CreateParameter("@EndDate", adDate, adParamInput, vbNull, CDate(brRec.EndDate))
      .Parameters.Append .CreateParameter("@Mailings", adInteger, adParamInput, vbNull, CLng(brRec.Mailings))
      .Parameters.Append .CreateParameter("@Emails", adInteger, adParamInput, vbNull, CLng(brRec.Emails))
      .Parameters.Append .CreateParameter("@TestEmail", adVarWChar, adParamInput, 80, brRec.TestEmail)
      .Parameters.Append .CreateParameter("@TestFirstName", adVarWChar, adParamInput, 30, brRec.TestFirstName)
      .Parameters.Append .CreateParameter("@TestLastName", adVarWChar, adParamInput, 30, brRec.TestLastName)
      .Parameters.Append .CreateParameter("@TestData1", adVarWChar, adParamInput, 80, brRec.TestData1)
      .Parameters.Append .CreateParameter("@TestData2", adVarWChar, adParamInput, 80, brRec.TestData2)
      .Parameters.Append .CreateParameter("@TestData3", adVarWChar, adParamInput, 80, brRec.TestData3)
      .Parameters.Append .CreateParameter("@TestData4", adVarWChar, adParamInput, 80, brRec.TestData4)
      .Parameters.Append .CreateParameter("@TestData5", adVarWChar, adParamInput, 80, brRec.TestData5)
      .Parameters.Append .CreateParameter("@EmailType", adInteger, adParamInput, vbNull, CLng(brRec.EmailType))
      .Parameters.Append .CreateParameter("@IsSalesStep", adSmallInt, adParamInput, vbNull, CInt(brRec.IsSalesStep))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Email_Update"

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
   ByRef brRec As tEmailType, _ 
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
         .EmailID = moUtil.EditLong(.EmailID, "EmailID", True, , 1) 
      End If
      .CompanyID = moUtil.EditLong(.CompanyID, "CompanyID", False, , 1) 
      .NewsLetterID = moUtil.EditLong(.NewsLetterID, "NewsLetterID", False, , 1) 
      .EmailListID = moUtil.EditLong(.EmailListID, "EmailListID", False, , 1) 
      .EmailName = moUtil.EditString(.EmailName, "EmailName", True, , 1, 60) 
      .FromEmail = moUtil.EditString(.FromEmail, "FromEmail", True, , 1, 60) 
      .Subject = moUtil.EditString(.Subject, "Subject", True, , 1, 80) 
      .FileName = moUtil.EditString(.FileName, "FileName", True, , 1, 20) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .SendDate = moUtil.EditDate(.SendDate, "SendDate", False) 
      .Repeat = moUtil.EditString(.Repeat, "Repeat", False) 
      .EndDate = moUtil.EditDate(.EndDate, "EndDate", False) 
      .Mailings = moUtil.EditLong(.Mailings, "Mailings", False) 
      .Emails = moUtil.EditLong(.Emails, "Emails", False) 
      .TestEmail = moUtil.EditString(.TestEmail, "TestEmail", False) 
      .TestFirstName = moUtil.EditString(.TestFirstName, "TestFirstName", False) 
      .TestLastName = moUtil.EditString(.TestLastName, "TestLastName", False) 
      .TestData1 = moUtil.EditString(.TestData1, "TestData1", False) 
      .TestData2 = moUtil.EditString(.TestData2, "TestData2", False) 
      .TestData3 = moUtil.EditString(.TestData3, "TestData3", False) 
      .TestData4 = moUtil.EditString(.TestData4, "TestData4", False) 
      .TestData5 = moUtil.EditString(.TestData5, "TestData5", False) 
      .EmailType = moUtil.EditLong(.EmailType, "EmailType", False) 
      .IsSalesStep = moUtil.EditInteger(.IsSalesStep, "IsSalesStep", False, 0, 0, 1) 
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