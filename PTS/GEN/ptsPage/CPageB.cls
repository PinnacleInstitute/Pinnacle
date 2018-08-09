VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CPageB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CPage"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tPageType
   PageID As String
   CompanyID As String
   MemberID As String
   PageName As String
   Category As String
   PageType As String
   Status As String
   Language As String
   IsPrivate As String
   Form As String
   Fields As String
   IsShare As String
   Subject As String
   GroupID1 As String
   GroupID2 As String
   GroupID3 As String
End Type

Public Sub Add( _ 
   ByRef brRec As tPageType, _ 
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
      .Parameters.Append .CreateParameter("@PageID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@PageName", adVarWChar, adParamInput, 60, brRec.PageName)
      .Parameters.Append .CreateParameter("@Category", adVarWChar, adParamInput, 20, brRec.Category)
      .Parameters.Append .CreateParameter("@PageType", adInteger, adParamInput, vbNull, CLng(brRec.PageType))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Language", adVarWChar, adParamInput, 6, brRec.Language)
      .Parameters.Append .CreateParameter("@IsPrivate", adSmallInt, adParamInput, vbNull, CInt(brRec.IsPrivate))
      .Parameters.Append .CreateParameter("@Form", adInteger, adParamInput, vbNull, CLng(brRec.Form))
      .Parameters.Append .CreateParameter("@Fields", adVarWChar, adParamInput, 1000, brRec.Fields)
      .Parameters.Append .CreateParameter("@IsShare", adSmallInt, adParamInput, vbNull, CInt(brRec.IsShare))
      .Parameters.Append .CreateParameter("@Subject", adVarWChar, adParamInput, 80, brRec.Subject)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Page_Add"

   '-----get return values
   With brRec
      .PageID = moUtil.FetchLong(oCmd.Parameters.Item("@PageID").Value)
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
   ByRef brRec As tPageType, _ 
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
      .Parameters.Append .CreateParameter("@PageID", adInteger, adParamInput, vbNull, CLng(brRec.PageID))
      .Parameters.Append .CreateParameter("@PageName", adVarWChar, adParamInput, 60, brRec.PageName)
      .Parameters.Append .CreateParameter("@Fields", adVarWChar, adParamInput, 1000, brRec.Fields)
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Page_UpdateFT"

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
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Page_Count"

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
   ByRef brRec As tPageType, _ 
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
      .PageID = moUtil.EditLong(.PageID, "PageID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@PageID", adInteger, adParamInput, vbNull, CLng(brRec.PageID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Page_Delete"

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

Public Function EnumPageList( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvGroupID1 As Long, _ 
   ByVal bvGroupID2 As Long, _ 
   ByVal bvGroupID3 As Long, _ 
   ByVal bvPageType As Long, _ 
   ByVal bvSecurityToken As Long) As tPageType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns an enumerated list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EnumPageList"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPageType
   Dim vRec As tPageType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@GroupID1", adInteger, adParamInput, vbNull, CLng(bvGroupID1))
      .Parameters.Append .CreateParameter("@GroupID2", adInteger, adParamInput, vbNull, CLng(bvGroupID2))
      .Parameters.Append .CreateParameter("@GroupID3", adInteger, adParamInput, vbNull, CLng(bvGroupID3))
      .Parameters.Append .CreateParameter("@PageType", adInteger, adParamInput, vbNull, CLng(bvPageType))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Page_EnumPageList")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.PageID = moUtil.FetchLong(.Fields.Item("ID").Value)
            vRec.PageName = moUtil.FetchString(.Fields.Item("Name").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   EnumPageList = vRecs

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

Public Function EnumPageCategoryList( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvGroupID1 As Long, _ 
   ByVal bvGroupID2 As Long, _ 
   ByVal bvGroupID3 As Long, _ 
   ByVal bvPageType As Long, _ 
   ByVal bvSecurityToken As Long) As tPageType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns an enumerated list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EnumPageCategoryList"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPageType
   Dim vRec As tPageType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@GroupID1", adInteger, adParamInput, vbNull, CLng(bvGroupID1))
      .Parameters.Append .CreateParameter("@GroupID2", adInteger, adParamInput, vbNull, CLng(bvGroupID2))
      .Parameters.Append .CreateParameter("@GroupID3", adInteger, adParamInput, vbNull, CLng(bvGroupID3))
      .Parameters.Append .CreateParameter("@PageType", adInteger, adParamInput, vbNull, CLng(bvPageType))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Page_EnumPageCategoryList")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.PageID = moUtil.FetchLong(.Fields.Item("ID").Value)
            vRec.PageName = moUtil.FetchString(.Fields.Item("Name").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   EnumPageCategoryList = vRecs

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
   ByRef brRec As tPageType, _ 
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
      .PageID = moUtil.EditLong(.PageID, "PageID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@PageID", adInteger, adParamInput, vbNull, CLng(brRec.PageID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PageName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Category", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@PageType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Language", adVarWChar, adParamOutput, 6, vbNull)
      .Parameters.Append .CreateParameter("@IsPrivate", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Form", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Fields", adVarWChar, adParamOutput, 1000, vbNull)
      .Parameters.Append .CreateParameter("@IsShare", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Subject", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Page_Fetch"

   '-----get return values
   With brRec
      .CompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@CompanyID").Value)
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .PageName = moUtil.FetchString(oCmd.Parameters.Item("@PageName").Value)
      .Category = moUtil.FetchString(oCmd.Parameters.Item("@Category").Value)
      .PageType = moUtil.FetchLong(oCmd.Parameters.Item("@PageType").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .Language = moUtil.FetchString(oCmd.Parameters.Item("@Language").Value)
      .IsPrivate = moUtil.FetchInteger(oCmd.Parameters.Item("@IsPrivate").Value)
      .Form = moUtil.FetchLong(oCmd.Parameters.Item("@Form").Value)
      .Fields = moUtil.FetchString(oCmd.Parameters.Item("@Fields").Value)
      .IsShare = moUtil.FetchInteger(oCmd.Parameters.Item("@IsShare").Value)
      .Subject = moUtil.FetchString(oCmd.Parameters.Item("@Subject").Value)
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

Public Function FindCompany( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvPageType As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tPageType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindCompany"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPageType
   Dim vRec As tPageType
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
   bvCompanyID = moUtil.EditLong(bvCompanyID, "CompanyID", True) 
   bvPageType = moUtil.EditLong(bvPageType, "PageType", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsPageFindPageName
         sProc = "pts_Page_FindCompanyPageName"
         MaxBookMark = 70
      Case cptsPageFindCategory
         sProc = "pts_Page_FindCompanyCategory"
         MaxBookMark = 30
      Case cptsPageFindPageID
         sProc = "pts_Page_FindCompanyPageID"
         MaxBookMark = 20
      Case cptsPageFindLanguage
         sProc = "pts_Page_FindCompanyLanguage"
         MaxBookMark = 16
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@PageType", adInteger, adParamInput, vbNull, CLng(bvPageType))
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
               vRec.PageID = moUtil.FetchLong(.Fields.Item("PageID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.PageName = moUtil.FetchString(.Fields.Item("PageName").Value)
               vRec.Category = moUtil.FetchString(.Fields.Item("Category").Value)
               vRec.PageType = moUtil.FetchLong(.Fields.Item("PageType").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Language = moUtil.FetchString(.Fields.Item("Language").Value)
               vRec.IsPrivate = moUtil.FetchInteger(.Fields.Item("IsPrivate").Value)
               vRec.Form = moUtil.FetchLong(.Fields.Item("Form").Value)
               vRec.Fields = moUtil.FetchString(.Fields.Item("Fields").Value)
               vRec.IsShare = moUtil.FetchInteger(.Fields.Item("IsShare").Value)
               vRec.Subject = moUtil.FetchString(.Fields.Item("Subject").Value)
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

Public Function FindCompanyCategory( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvPageType As Long, _ 
   ByVal bvCategory As String, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tPageType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindCompanyCategory"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPageType
   Dim vRec As tPageType
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
   bvCompanyID = moUtil.EditLong(bvCompanyID, "CompanyID", True) 
   bvPageType = moUtil.EditLong(bvPageType, "PageType", True) 
   bvCategory = moUtil.EditString(bvCategory, "Category", True, , 1, 20) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsPageFindPageName
         sProc = "pts_Page_FindCompanyCategoryPageName"
         MaxBookMark = 70
      Case cptsPageFindCategory
         sProc = "pts_Page_FindCompanyCategoryCategory"
         MaxBookMark = 30
      Case cptsPageFindPageID
         sProc = "pts_Page_FindCompanyCategoryPageID"
         MaxBookMark = 20
      Case cptsPageFindLanguage
         sProc = "pts_Page_FindCompanyCategoryLanguage"
         MaxBookMark = 16
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@PageType", adInteger, adParamInput, vbNull, CLng(bvPageType))
      .Parameters.Append .CreateParameter("@Category", adVarWChar, adParamInput, 20, bvCategory)
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
               vRec.PageID = moUtil.FetchLong(.Fields.Item("PageID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.PageName = moUtil.FetchString(.Fields.Item("PageName").Value)
               vRec.Category = moUtil.FetchString(.Fields.Item("Category").Value)
               vRec.PageType = moUtil.FetchLong(.Fields.Item("PageType").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Language = moUtil.FetchString(.Fields.Item("Language").Value)
               vRec.IsPrivate = moUtil.FetchInteger(.Fields.Item("IsPrivate").Value)
               vRec.Form = moUtil.FetchLong(.Fields.Item("Form").Value)
               vRec.Fields = moUtil.FetchString(.Fields.Item("Fields").Value)
               vRec.IsShare = moUtil.FetchInteger(.Fields.Item("IsShare").Value)
               vRec.Subject = moUtil.FetchString(.Fields.Item("Subject").Value)
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
   FindCompanyCategory = vRecs

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

Public Function FindMember( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvPageType As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tPageType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPageType
   Dim vRec As tPageType
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
   bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True) 
   bvPageType = moUtil.EditLong(bvPageType, "PageType", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsPageFindPageName
         sProc = "pts_Page_FindMemberPageName"
         MaxBookMark = 70
      Case cptsPageFindCategory
         sProc = "pts_Page_FindMemberCategory"
         MaxBookMark = 30
      Case cptsPageFindPageID
         sProc = "pts_Page_FindMemberPageID"
         MaxBookMark = 20
      Case cptsPageFindLanguage
         sProc = "pts_Page_FindMemberLanguage"
         MaxBookMark = 16
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@PageType", adInteger, adParamInput, vbNull, CLng(bvPageType))
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
               vRec.PageID = moUtil.FetchLong(.Fields.Item("PageID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.PageName = moUtil.FetchString(.Fields.Item("PageName").Value)
               vRec.Category = moUtil.FetchString(.Fields.Item("Category").Value)
               vRec.PageType = moUtil.FetchLong(.Fields.Item("PageType").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Language = moUtil.FetchString(.Fields.Item("Language").Value)
               vRec.IsPrivate = moUtil.FetchInteger(.Fields.Item("IsPrivate").Value)
               vRec.Form = moUtil.FetchLong(.Fields.Item("Form").Value)
               vRec.Fields = moUtil.FetchString(.Fields.Item("Fields").Value)
               vRec.IsShare = moUtil.FetchInteger(.Fields.Item("IsShare").Value)
               vRec.Subject = moUtil.FetchString(.Fields.Item("Subject").Value)
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
   FindMember = vRecs

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
   ByVal bvCompanyID As Long, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvGroupID1 As Long, _ 
   ByVal bvGroupID2 As Long, _ 
   ByVal bvGroupID3 As Long, _ 
   ByVal bvPageType As Long) As tPageType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Search"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPageType
   Dim vRec As tPageType
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
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@GroupID1", adInteger, adParamInput, vbNull, CLng(bvGroupID1))
      .Parameters.Append .CreateParameter("@GroupID2", adInteger, adParamInput, vbNull, CLng(bvGroupID2))
      .Parameters.Append .CreateParameter("@GroupID3", adInteger, adParamInput, vbNull, CLng(bvGroupID3))
      .Parameters.Append .CreateParameter("@PageType", adInteger, adParamInput, vbNull, CLng(bvPageType))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Page_Search")

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
               vRec.PageID = moUtil.FetchLong(.Fields.Item("PageID").Value)
               vRec.PageName = moUtil.FetchString(.Fields.Item("PageName").Value)
               vRec.Category = moUtil.FetchString(.Fields.Item("Category").Value)
               vRec.Subject = moUtil.FetchString(.Fields.Item("Subject").Value)
               vRec.Fields = moUtil.FetchString(.Fields.Item("Fields").Value)
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

Public Function ListForm( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvForm As Long) As tPageType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListForm"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPageType
   Dim vRec As tPageType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@Form", adInteger, adParamInput, vbNull, CLng(bvForm))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Page_ListForm")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.PageID = moUtil.FetchLong(.Fields.Item("PageID").Value)
            vRec.PageName = moUtil.FetchString(.Fields.Item("PageName").Value)
            vRec.Category = moUtil.FetchString(.Fields.Item("Category").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListForm = vRecs

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

Public Function ListFormPublic( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvForm As Long) As tPageType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListFormPublic"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPageType
   Dim vRec As tPageType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@Form", adInteger, adParamInput, vbNull, CLng(bvForm))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Page_ListFormPublic")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.PageID = moUtil.FetchLong(.Fields.Item("PageID").Value)
            vRec.PageName = moUtil.FetchString(.Fields.Item("PageName").Value)
            vRec.Category = moUtil.FetchString(.Fields.Item("Category").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListFormPublic = vRecs

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

Public Function ListPage( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvGroupID1 As Long, _ 
   ByVal bvGroupID2 As Long, _ 
   ByVal bvGroupID3 As Long, _ 
   ByVal bvPageType As Long) As tPageType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListPage"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPageType
   Dim vRec As tPageType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@GroupID1", adInteger, adParamInput, vbNull, CLng(bvGroupID1))
      .Parameters.Append .CreateParameter("@GroupID2", adInteger, adParamInput, vbNull, CLng(bvGroupID2))
      .Parameters.Append .CreateParameter("@GroupID3", adInteger, adParamInput, vbNull, CLng(bvGroupID3))
      .Parameters.Append .CreateParameter("@PageType", adInteger, adParamInput, vbNull, CLng(bvPageType))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Page_ListPage")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.PageID = moUtil.FetchLong(.Fields.Item("PageID").Value)
            vRec.PageName = moUtil.FetchString(.Fields.Item("PageName").Value)
            vRec.Category = moUtil.FetchString(.Fields.Item("Category").Value)
            vRec.Subject = moUtil.FetchString(.Fields.Item("Subject").Value)
            vRec.Fields = moUtil.FetchString(.Fields.Item("Fields").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListPage = vRecs

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

Public Function ListPageCategory( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvGroupID1 As Long, _ 
   ByVal bvGroupID2 As Long, _ 
   ByVal bvGroupID3 As Long, _ 
   ByVal bvPageType As Long, _ 
   ByVal bvCategory As String) As tPageType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListPageCategory"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPageType
   Dim vRec As tPageType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@GroupID1", adInteger, adParamInput, vbNull, CLng(bvGroupID1))
      .Parameters.Append .CreateParameter("@GroupID2", adInteger, adParamInput, vbNull, CLng(bvGroupID2))
      .Parameters.Append .CreateParameter("@GroupID3", adInteger, adParamInput, vbNull, CLng(bvGroupID3))
      .Parameters.Append .CreateParameter("@PageType", adInteger, adParamInput, vbNull, CLng(bvPageType))
      .Parameters.Append .CreateParameter("@Category", adVarWChar, adParamInput, 20, bvCategory)
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Page_ListPageCategory")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.PageID = moUtil.FetchLong(.Fields.Item("PageID").Value)
            vRec.PageName = moUtil.FetchString(.Fields.Item("PageName").Value)
            vRec.Category = moUtil.FetchString(.Fields.Item("Category").Value)
            vRec.Subject = moUtil.FetchString(.Fields.Item("Subject").Value)
            vRec.Fields = moUtil.FetchString(.Fields.Item("Fields").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListPageCategory = vRecs

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
   ByRef brRec As tPageType, _ 
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
      .Parameters.Append .CreateParameter("@PageID", adInteger, adParamInput, vbNull, CLng(brRec.PageID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@PageName", adVarWChar, adParamInput, 60, brRec.PageName)
      .Parameters.Append .CreateParameter("@Category", adVarWChar, adParamInput, 20, brRec.Category)
      .Parameters.Append .CreateParameter("@PageType", adInteger, adParamInput, vbNull, CLng(brRec.PageType))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Language", adVarWChar, adParamInput, 6, brRec.Language)
      .Parameters.Append .CreateParameter("@IsPrivate", adSmallInt, adParamInput, vbNull, CInt(brRec.IsPrivate))
      .Parameters.Append .CreateParameter("@Form", adInteger, adParamInput, vbNull, CLng(brRec.Form))
      .Parameters.Append .CreateParameter("@Fields", adVarWChar, adParamInput, 1000, brRec.Fields)
      .Parameters.Append .CreateParameter("@IsShare", adSmallInt, adParamInput, vbNull, CInt(brRec.IsShare))
      .Parameters.Append .CreateParameter("@Subject", adVarWChar, adParamInput, 80, brRec.Subject)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Page_Update"

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
   ByRef brRec As tPageType, _ 
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
         .PageID = moUtil.EditLong(.PageID, "PageID", True, , 1) 
      End If
      .CompanyID = moUtil.EditLong(.CompanyID, "CompanyID", False) 
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", False) 
      .PageName = moUtil.EditString(.PageName, "PageName", True, , 1, 60) 
      .Category = moUtil.EditString(.Category, "Category", False, , 1, 20) 
      .PageType = moUtil.EditLong(.PageType, "PageType", False) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .Language = moUtil.EditString(.Language, "Language", False, , 1, 6) 
      .IsPrivate = moUtil.EditInteger(.IsPrivate, "IsPrivate", False, 0, 0, 1) 
      .Form = moUtil.EditLong(.Form, "Form", False) 
      .Fields = moUtil.EditString(.Fields, "Fields", False) 
      .IsShare = moUtil.EditInteger(.IsShare, "IsShare", False, 0, 0, 1) 
      .Subject = moUtil.EditString(.Subject, "Subject", False, , 1, 80) 
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