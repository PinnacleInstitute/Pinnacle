VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CBarterCampaignB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CBarterCampaign"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tBarterCampaignType
   BarterCampaignID As String
   ConsumerID As String
   BarterAdID As String
   BarterAreaID As String
   BarterCategoryID As String
   CampaignName As String
   Status As String
   StartDate As String
   EndDate As String
   IsKeyword As String
   IsAllCategory As String
   IsMainCategory As String
   IsSubCategory As String
   IsAllLocation As String
   IsCountry As String
   IsState As String
   IsCity As String
   IsArea As String
   Keyword As String
   FT As String
   Credits As String
End Type

Public Sub Add( _ 
   ByRef brRec As tBarterCampaignType, _ 
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
      .Parameters.Append .CreateParameter("@BarterCampaignID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ConsumerID", adInteger, adParamInput, vbNull, CLng(brRec.ConsumerID))
      .Parameters.Append .CreateParameter("@BarterAdID", adInteger, adParamInput, vbNull, CLng(brRec.BarterAdID))
      .Parameters.Append .CreateParameter("@BarterAreaID", adInteger, adParamInput, vbNull, CLng(brRec.BarterAreaID))
      .Parameters.Append .CreateParameter("@BarterCategoryID", adInteger, adParamInput, vbNull, CLng(brRec.BarterCategoryID))
      .Parameters.Append .CreateParameter("@CampaignName", adVarWChar, adParamInput, 100, brRec.CampaignName)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@StartDate", adDate, adParamInput, vbNull, CDate(brRec.StartDate))
      .Parameters.Append .CreateParameter("@EndDate", adDate, adParamInput, vbNull, CDate(brRec.EndDate))
      .Parameters.Append .CreateParameter("@IsKeyword", adSmallInt, adParamInput, vbNull, CInt(brRec.IsKeyword))
      .Parameters.Append .CreateParameter("@IsAllCategory", adSmallInt, adParamInput, vbNull, CInt(brRec.IsAllCategory))
      .Parameters.Append .CreateParameter("@IsMainCategory", adSmallInt, adParamInput, vbNull, CInt(brRec.IsMainCategory))
      .Parameters.Append .CreateParameter("@IsSubCategory", adSmallInt, adParamInput, vbNull, CInt(brRec.IsSubCategory))
      .Parameters.Append .CreateParameter("@IsAllLocation", adSmallInt, adParamInput, vbNull, CInt(brRec.IsAllLocation))
      .Parameters.Append .CreateParameter("@IsCountry", adSmallInt, adParamInput, vbNull, CInt(brRec.IsCountry))
      .Parameters.Append .CreateParameter("@IsState", adSmallInt, adParamInput, vbNull, CInt(brRec.IsState))
      .Parameters.Append .CreateParameter("@IsCity", adSmallInt, adParamInput, vbNull, CInt(brRec.IsCity))
      .Parameters.Append .CreateParameter("@IsArea", adSmallInt, adParamInput, vbNull, CInt(brRec.IsArea))
      .Parameters.Append .CreateParameter("@Keyword", adVarWChar, adParamInput, 100, brRec.Keyword)
      .Parameters.Append .CreateParameter("@FT", adVarWChar, adParamInput, 500, brRec.FT)
      .Parameters.Append .CreateParameter("@Credits", adCurrency, adParamInput, vbNull, CCur(brRec.Credits))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_BarterCampaign_Add"

   '-----get return values
   With brRec
      .BarterCampaignID = moUtil.FetchLong(oCmd.Parameters.Item("@BarterCampaignID").Value)
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

Public Function Custom( _ 
   ByRef brRec As tBarterCampaignType, _ 
   ByVal bvUserID As Long) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Custom"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@BarterCampaignID", adInteger, adParamInput, vbNull, CLng(brRec.BarterCampaignID))
      .Parameters.Append .CreateParameter("@BarterAdID", adInteger, adParamInput, vbNull, CLng(brRec.BarterAdID))
      .Parameters.Append .CreateParameter("@BarterCategoryID", adInteger, adParamInput, vbNull, CLng(brRec.BarterCategoryID))
      .Parameters.Append .CreateParameter("@Result", adVarWChar, adParamOutput, 1000, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_BarterCampaign_Custom"

   '-----get return values
   Custom = moUtil.FetchString(oCmd.Parameters.Item("@Result").Value)

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
   ByRef brRec As tBarterCampaignType, _ 
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
      .BarterCampaignID = moUtil.EditLong(.BarterCampaignID, "BarterCampaignID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@BarterCampaignID", adInteger, adParamInput, vbNull, CLng(brRec.BarterCampaignID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_BarterCampaign_Delete"

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
   ByRef brRec As tBarterCampaignType, _ 
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
      .BarterCampaignID = moUtil.EditLong(.BarterCampaignID, "BarterCampaignID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@BarterCampaignID", adInteger, adParamInput, vbNull, CLng(brRec.BarterCampaignID))
      .Parameters.Append .CreateParameter("@ConsumerID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BarterAdID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BarterAreaID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BarterCategoryID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CampaignName", adVarWChar, adParamOutput, 100, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@StartDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@EndDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsKeyword", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsAllCategory", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsMainCategory", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsSubCategory", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsAllLocation", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsCountry", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsState", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsCity", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsArea", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Keyword", adVarWChar, adParamOutput, 100, vbNull)
      .Parameters.Append .CreateParameter("@FT", adVarWChar, adParamOutput, 500, vbNull)
      .Parameters.Append .CreateParameter("@Credits", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_BarterCampaign_Fetch"

   '-----get return values
   With brRec
      .ConsumerID = moUtil.FetchLong(oCmd.Parameters.Item("@ConsumerID").Value)
      .BarterAdID = moUtil.FetchLong(oCmd.Parameters.Item("@BarterAdID").Value)
      .BarterAreaID = moUtil.FetchLong(oCmd.Parameters.Item("@BarterAreaID").Value)
      .BarterCategoryID = moUtil.FetchLong(oCmd.Parameters.Item("@BarterCategoryID").Value)
      .CampaignName = moUtil.FetchString(oCmd.Parameters.Item("@CampaignName").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .StartDate = moUtil.FetchDate(oCmd.Parameters.Item("@StartDate").Value)
      .EndDate = moUtil.FetchDate(oCmd.Parameters.Item("@EndDate").Value)
      .IsKeyword = moUtil.FetchInteger(oCmd.Parameters.Item("@IsKeyword").Value)
      .IsAllCategory = moUtil.FetchInteger(oCmd.Parameters.Item("@IsAllCategory").Value)
      .IsMainCategory = moUtil.FetchInteger(oCmd.Parameters.Item("@IsMainCategory").Value)
      .IsSubCategory = moUtil.FetchInteger(oCmd.Parameters.Item("@IsSubCategory").Value)
      .IsAllLocation = moUtil.FetchInteger(oCmd.Parameters.Item("@IsAllLocation").Value)
      .IsCountry = moUtil.FetchInteger(oCmd.Parameters.Item("@IsCountry").Value)
      .IsState = moUtil.FetchInteger(oCmd.Parameters.Item("@IsState").Value)
      .IsCity = moUtil.FetchInteger(oCmd.Parameters.Item("@IsCity").Value)
      .IsArea = moUtil.FetchInteger(oCmd.Parameters.Item("@IsArea").Value)
      .Keyword = moUtil.FetchString(oCmd.Parameters.Item("@Keyword").Value)
      .FT = moUtil.FetchString(oCmd.Parameters.Item("@FT").Value)
      .Credits = moUtil.FetchCurrency(oCmd.Parameters.Item("@Credits").Value)
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
   ByVal bvConsumerID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tBarterCampaignType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tBarterCampaignType
   Dim vRec As tBarterCampaignType
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
      Case cptsBarterCampaignFindCampaignName
         sProc = "pts_BarterCampaign_FindCampaignName"
         MaxBookMark = 110
      Case cptsBarterCampaignFindStartDate
         sProc = "pts_BarterCampaign_FindStartDate"
         MaxBookMark = 30
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ConsumerID", adInteger, adParamInput, vbNull, CLng(bvConsumerID))
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
               vRec.BarterCampaignID = moUtil.FetchLong(.Fields.Item("BarterCampaignID").Value)
               vRec.ConsumerID = moUtil.FetchLong(.Fields.Item("ConsumerID").Value)
               vRec.BarterAdID = moUtil.FetchLong(.Fields.Item("BarterAdID").Value)
               vRec.BarterAreaID = moUtil.FetchLong(.Fields.Item("BarterAreaID").Value)
               vRec.BarterCategoryID = moUtil.FetchLong(.Fields.Item("BarterCategoryID").Value)
               vRec.CampaignName = moUtil.FetchString(.Fields.Item("CampaignName").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.StartDate = moUtil.FetchDate(.Fields.Item("StartDate").Value)
               vRec.EndDate = moUtil.FetchDate(.Fields.Item("EndDate").Value)
               vRec.IsKeyword = moUtil.FetchInteger(.Fields.Item("IsKeyword").Value)
               vRec.IsAllCategory = moUtil.FetchInteger(.Fields.Item("IsAllCategory").Value)
               vRec.IsMainCategory = moUtil.FetchInteger(.Fields.Item("IsMainCategory").Value)
               vRec.IsSubCategory = moUtil.FetchInteger(.Fields.Item("IsSubCategory").Value)
               vRec.IsAllLocation = moUtil.FetchInteger(.Fields.Item("IsAllLocation").Value)
               vRec.IsCountry = moUtil.FetchInteger(.Fields.Item("IsCountry").Value)
               vRec.IsState = moUtil.FetchInteger(.Fields.Item("IsState").Value)
               vRec.IsCity = moUtil.FetchInteger(.Fields.Item("IsCity").Value)
               vRec.IsArea = moUtil.FetchInteger(.Fields.Item("IsArea").Value)
               vRec.Keyword = moUtil.FetchString(.Fields.Item("Keyword").Value)
               vRec.FT = moUtil.FetchString(.Fields.Item("FT").Value)
               vRec.Credits = moUtil.FetchCurrency(.Fields.Item("Credits").Value)
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

Public Function FindStatus( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvConsumerID As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tBarterCampaignType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tBarterCampaignType
   Dim vRec As tBarterCampaignType
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
      Case cptsBarterCampaignFindCampaignName
         sProc = "pts_BarterCampaign_FindStatusCampaignName"
         MaxBookMark = 110
      Case cptsBarterCampaignFindStartDate
         sProc = "pts_BarterCampaign_FindStatusStartDate"
         MaxBookMark = 30
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ConsumerID", adInteger, adParamInput, vbNull, CLng(bvConsumerID))
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
               vRec.BarterCampaignID = moUtil.FetchLong(.Fields.Item("BarterCampaignID").Value)
               vRec.ConsumerID = moUtil.FetchLong(.Fields.Item("ConsumerID").Value)
               vRec.BarterAdID = moUtil.FetchLong(.Fields.Item("BarterAdID").Value)
               vRec.BarterAreaID = moUtil.FetchLong(.Fields.Item("BarterAreaID").Value)
               vRec.BarterCategoryID = moUtil.FetchLong(.Fields.Item("BarterCategoryID").Value)
               vRec.CampaignName = moUtil.FetchString(.Fields.Item("CampaignName").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.StartDate = moUtil.FetchDate(.Fields.Item("StartDate").Value)
               vRec.EndDate = moUtil.FetchDate(.Fields.Item("EndDate").Value)
               vRec.IsKeyword = moUtil.FetchInteger(.Fields.Item("IsKeyword").Value)
               vRec.IsAllCategory = moUtil.FetchInteger(.Fields.Item("IsAllCategory").Value)
               vRec.IsMainCategory = moUtil.FetchInteger(.Fields.Item("IsMainCategory").Value)
               vRec.IsSubCategory = moUtil.FetchInteger(.Fields.Item("IsSubCategory").Value)
               vRec.IsAllLocation = moUtil.FetchInteger(.Fields.Item("IsAllLocation").Value)
               vRec.IsCountry = moUtil.FetchInteger(.Fields.Item("IsCountry").Value)
               vRec.IsState = moUtil.FetchInteger(.Fields.Item("IsState").Value)
               vRec.IsCity = moUtil.FetchInteger(.Fields.Item("IsCity").Value)
               vRec.IsArea = moUtil.FetchInteger(.Fields.Item("IsArea").Value)
               vRec.Keyword = moUtil.FetchString(.Fields.Item("Keyword").Value)
               vRec.FT = moUtil.FetchString(.Fields.Item("FT").Value)
               vRec.Credits = moUtil.FetchCurrency(.Fields.Item("Credits").Value)
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
   FindStatus = vRecs

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

Public Function FindAd( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvBarterAdID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tBarterCampaignType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindAd"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tBarterCampaignType
   Dim vRec As tBarterCampaignType
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
      Case cptsBarterCampaignFindCampaignName
         sProc = "pts_BarterCampaign_FindAdCampaignName"
         MaxBookMark = 110
      Case cptsBarterCampaignFindStartDate
         sProc = "pts_BarterCampaign_FindAdStartDate"
         MaxBookMark = 30
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BarterAdID", adInteger, adParamInput, vbNull, CLng(bvBarterAdID))
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
               vRec.BarterCampaignID = moUtil.FetchLong(.Fields.Item("BarterCampaignID").Value)
               vRec.ConsumerID = moUtil.FetchLong(.Fields.Item("ConsumerID").Value)
               vRec.BarterAdID = moUtil.FetchLong(.Fields.Item("BarterAdID").Value)
               vRec.BarterAreaID = moUtil.FetchLong(.Fields.Item("BarterAreaID").Value)
               vRec.BarterCategoryID = moUtil.FetchLong(.Fields.Item("BarterCategoryID").Value)
               vRec.CampaignName = moUtil.FetchString(.Fields.Item("CampaignName").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.StartDate = moUtil.FetchDate(.Fields.Item("StartDate").Value)
               vRec.EndDate = moUtil.FetchDate(.Fields.Item("EndDate").Value)
               vRec.IsKeyword = moUtil.FetchInteger(.Fields.Item("IsKeyword").Value)
               vRec.IsAllCategory = moUtil.FetchInteger(.Fields.Item("IsAllCategory").Value)
               vRec.IsMainCategory = moUtil.FetchInteger(.Fields.Item("IsMainCategory").Value)
               vRec.IsSubCategory = moUtil.FetchInteger(.Fields.Item("IsSubCategory").Value)
               vRec.IsAllLocation = moUtil.FetchInteger(.Fields.Item("IsAllLocation").Value)
               vRec.IsCountry = moUtil.FetchInteger(.Fields.Item("IsCountry").Value)
               vRec.IsState = moUtil.FetchInteger(.Fields.Item("IsState").Value)
               vRec.IsCity = moUtil.FetchInteger(.Fields.Item("IsCity").Value)
               vRec.IsArea = moUtil.FetchInteger(.Fields.Item("IsArea").Value)
               vRec.Keyword = moUtil.FetchString(.Fields.Item("Keyword").Value)
               vRec.FT = moUtil.FetchString(.Fields.Item("FT").Value)
               vRec.Credits = moUtil.FetchCurrency(.Fields.Item("Credits").Value)
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
   FindAd = vRecs

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

Public Function FindAdStatus( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvBarterAdID As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tBarterCampaignType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindAdStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tBarterCampaignType
   Dim vRec As tBarterCampaignType
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
      Case cptsBarterCampaignFindCampaignName
         sProc = "pts_BarterCampaign_FindAdStatusCampaignName"
         MaxBookMark = 110
      Case cptsBarterCampaignFindStartDate
         sProc = "pts_BarterCampaign_FindAdStatusStartDate"
         MaxBookMark = 30
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BarterAdID", adInteger, adParamInput, vbNull, CLng(bvBarterAdID))
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
               vRec.BarterCampaignID = moUtil.FetchLong(.Fields.Item("BarterCampaignID").Value)
               vRec.ConsumerID = moUtil.FetchLong(.Fields.Item("ConsumerID").Value)
               vRec.BarterAdID = moUtil.FetchLong(.Fields.Item("BarterAdID").Value)
               vRec.BarterAreaID = moUtil.FetchLong(.Fields.Item("BarterAreaID").Value)
               vRec.BarterCategoryID = moUtil.FetchLong(.Fields.Item("BarterCategoryID").Value)
               vRec.CampaignName = moUtil.FetchString(.Fields.Item("CampaignName").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.StartDate = moUtil.FetchDate(.Fields.Item("StartDate").Value)
               vRec.EndDate = moUtil.FetchDate(.Fields.Item("EndDate").Value)
               vRec.IsKeyword = moUtil.FetchInteger(.Fields.Item("IsKeyword").Value)
               vRec.IsAllCategory = moUtil.FetchInteger(.Fields.Item("IsAllCategory").Value)
               vRec.IsMainCategory = moUtil.FetchInteger(.Fields.Item("IsMainCategory").Value)
               vRec.IsSubCategory = moUtil.FetchInteger(.Fields.Item("IsSubCategory").Value)
               vRec.IsAllLocation = moUtil.FetchInteger(.Fields.Item("IsAllLocation").Value)
               vRec.IsCountry = moUtil.FetchInteger(.Fields.Item("IsCountry").Value)
               vRec.IsState = moUtil.FetchInteger(.Fields.Item("IsState").Value)
               vRec.IsCity = moUtil.FetchInteger(.Fields.Item("IsCity").Value)
               vRec.IsArea = moUtil.FetchInteger(.Fields.Item("IsArea").Value)
               vRec.Keyword = moUtil.FetchString(.Fields.Item("Keyword").Value)
               vRec.FT = moUtil.FetchString(.Fields.Item("FT").Value)
               vRec.Credits = moUtil.FetchCurrency(.Fields.Item("Credits").Value)
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
   FindAdStatus = vRecs

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
   ByRef brRec As tBarterCampaignType, _ 
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
      .Parameters.Append .CreateParameter("@BarterCampaignID", adInteger, adParamInput, vbNull, CLng(brRec.BarterCampaignID))
      .Parameters.Append .CreateParameter("@ConsumerID", adInteger, adParamInput, vbNull, CLng(brRec.ConsumerID))
      .Parameters.Append .CreateParameter("@BarterAdID", adInteger, adParamInput, vbNull, CLng(brRec.BarterAdID))
      .Parameters.Append .CreateParameter("@BarterAreaID", adInteger, adParamInput, vbNull, CLng(brRec.BarterAreaID))
      .Parameters.Append .CreateParameter("@BarterCategoryID", adInteger, adParamInput, vbNull, CLng(brRec.BarterCategoryID))
      .Parameters.Append .CreateParameter("@CampaignName", adVarWChar, adParamInput, 100, brRec.CampaignName)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@StartDate", adDate, adParamInput, vbNull, CDate(brRec.StartDate))
      .Parameters.Append .CreateParameter("@EndDate", adDate, adParamInput, vbNull, CDate(brRec.EndDate))
      .Parameters.Append .CreateParameter("@IsKeyword", adSmallInt, adParamInput, vbNull, CInt(brRec.IsKeyword))
      .Parameters.Append .CreateParameter("@IsAllCategory", adSmallInt, adParamInput, vbNull, CInt(brRec.IsAllCategory))
      .Parameters.Append .CreateParameter("@IsMainCategory", adSmallInt, adParamInput, vbNull, CInt(brRec.IsMainCategory))
      .Parameters.Append .CreateParameter("@IsSubCategory", adSmallInt, adParamInput, vbNull, CInt(brRec.IsSubCategory))
      .Parameters.Append .CreateParameter("@IsAllLocation", adSmallInt, adParamInput, vbNull, CInt(brRec.IsAllLocation))
      .Parameters.Append .CreateParameter("@IsCountry", adSmallInt, adParamInput, vbNull, CInt(brRec.IsCountry))
      .Parameters.Append .CreateParameter("@IsState", adSmallInt, adParamInput, vbNull, CInt(brRec.IsState))
      .Parameters.Append .CreateParameter("@IsCity", adSmallInt, adParamInput, vbNull, CInt(brRec.IsCity))
      .Parameters.Append .CreateParameter("@IsArea", adSmallInt, adParamInput, vbNull, CInt(brRec.IsArea))
      .Parameters.Append .CreateParameter("@Keyword", adVarWChar, adParamInput, 100, brRec.Keyword)
      .Parameters.Append .CreateParameter("@FT", adVarWChar, adParamInput, 500, brRec.FT)
      .Parameters.Append .CreateParameter("@Credits", adCurrency, adParamInput, vbNull, CCur(brRec.Credits))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_BarterCampaign_Update"

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
   ByRef brRec As tBarterCampaignType, _ 
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
         .BarterCampaignID = moUtil.EditLong(.BarterCampaignID, "BarterCampaignID", True, , 1) 
      End If
      .ConsumerID = moUtil.EditLong(.ConsumerID, "ConsumerID", False) 
      .BarterAdID = moUtil.EditLong(.BarterAdID, "BarterAdID", False) 
      .BarterAreaID = moUtil.EditLong(.BarterAreaID, "BarterAreaID", False) 
      .BarterCategoryID = moUtil.EditLong(.BarterCategoryID, "BarterCategoryID", False) 
      .CampaignName = moUtil.EditString(.CampaignName, "CampaignName", False, , 1, 100) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .StartDate = moUtil.EditDate(.StartDate, "StartDate", False) 
      .EndDate = moUtil.EditDate(.EndDate, "EndDate", False) 
      .IsKeyword = moUtil.EditInteger(.IsKeyword, "IsKeyword", False, 0, 0, 1) 
      .IsAllCategory = moUtil.EditInteger(.IsAllCategory, "IsAllCategory", False, 0, 0, 1) 
      .IsMainCategory = moUtil.EditInteger(.IsMainCategory, "IsMainCategory", False, 0, 0, 1) 
      .IsSubCategory = moUtil.EditInteger(.IsSubCategory, "IsSubCategory", False, 0, 0, 1) 
      .IsAllLocation = moUtil.EditInteger(.IsAllLocation, "IsAllLocation", False, 0, 0, 1) 
      .IsCountry = moUtil.EditInteger(.IsCountry, "IsCountry", False, 0, 0, 1) 
      .IsState = moUtil.EditInteger(.IsState, "IsState", False, 0, 0, 1) 
      .IsCity = moUtil.EditInteger(.IsCity, "IsCity", False, 0, 0, 1) 
      .IsArea = moUtil.EditInteger(.IsArea, "IsArea", False, 0, 0, 1) 
      .Keyword = moUtil.EditString(.Keyword, "Keyword", False, , 1, 100) 
      .FT = moUtil.EditString(.FT, "FT", False, , 1, 500) 
      .Credits = moUtil.EditCurrency(.Credits, "Credits", False, , -999999.99, 999999.99) 
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