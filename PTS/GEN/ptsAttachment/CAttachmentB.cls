VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CAttachmentB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CAttachment"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tAttachmentType
   AttachmentID As String
   CompanyID As String
   ParentID As String
   AuthUserID As String
   RefID As String
   AttachName As String
   FileName As String
   Description As String
   ParentType As String
   AttachSize As String
   AttachDate As String
   ExpireDate As String
   Status As String
   IsLink As String
   Secure As String
   Score As String
End Type

Public Sub Add( _ 
   ByRef brRec As tAttachmentType, _ 
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
      .Parameters.Append .CreateParameter("@AttachmentID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamInput, vbNull, CLng(brRec.ParentID))
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamInput, vbNull, CLng(brRec.AuthUserID))
      .Parameters.Append .CreateParameter("@RefID", adInteger, adParamInput, vbNull, CLng(brRec.RefID))
      .Parameters.Append .CreateParameter("@AttachName", adVarWChar, adParamInput, 60, brRec.AttachName)
      .Parameters.Append .CreateParameter("@FileName", adVarWChar, adParamInput, 100, brRec.FileName)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 3000, brRec.Description)
      .Parameters.Append .CreateParameter("@ParentType", adInteger, adParamInput, vbNull, CLng(brRec.ParentType))
      .Parameters.Append .CreateParameter("@AttachSize", adInteger, adParamInput, vbNull, CLng(brRec.AttachSize))
      .Parameters.Append .CreateParameter("@AttachDate", adDate, adParamInput, vbNull, CDate(brRec.AttachDate))
      .Parameters.Append .CreateParameter("@ExpireDate", adDate, adParamInput, vbNull, CDate(brRec.ExpireDate))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@IsLink", adSmallInt, adParamInput, vbNull, CInt(brRec.IsLink))
      .Parameters.Append .CreateParameter("@Secure", adInteger, adParamInput, vbNull, CLng(brRec.Secure))
      .Parameters.Append .CreateParameter("@Score", adInteger, adParamInput, vbNull, CLng(brRec.Score))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Attachment_Add"

   '-----get return values
   With brRec
      .AttachmentID = moUtil.FetchLong(oCmd.Parameters.Item("@AttachmentID").Value)
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

Public Function GetCompanyID( _ 
   ByRef brRec As tAttachmentType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "GetCompanyID"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ParentType", adInteger, adParamInput, vbNull, CLng(brRec.ParentType))
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamInput, vbNull, CLng(brRec.ParentID))
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Attachment_GetCompanyID"

   '-----get return values
   GetCompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function UpdateCompanyID( _ 
   ByRef brRec As tAttachmentType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "UpdateCompanyID"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ParentType", adInteger, adParamInput, vbNull, CLng(brRec.ParentType))
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamInput, vbNull, CLng(brRec.ParentID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Attachment_UpdateCompanyID"

   '-----get return values
   UpdateCompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function CountParent( _ 
   ByRef brRec As tAttachmentType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CountParent"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ParentType", adInteger, adParamInput, vbNull, CLng(brRec.ParentType))
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamInput, vbNull, CLng(brRec.ParentID))
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Attachment_CountParent"

   '-----get return values
   CountParent = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function CheckFile( _ 
   ByRef brRec As tAttachmentType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CheckFile"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ParentType", adInteger, adParamInput, vbNull, CLng(brRec.ParentType))
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamInput, vbNull, CLng(brRec.ParentID))
      .Parameters.Append .CreateParameter("@FileName", adVarWChar, adParamInput, 100, brRec.FileName)
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Attachment_CheckFile"

   '-----get return values
   CheckFile = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function UpdateFT( _ 
   ByRef brRec As tAttachmentType, _ 
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
      .Parameters.Append .CreateParameter("@AttachmentID", adInteger, adParamInput, vbNull, CLng(brRec.AttachmentID))
      .Parameters.Append .CreateParameter("@AttachName", adVarWChar, adParamInput, 60, brRec.AttachName)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 3000, brRec.Description)
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Attachment_UpdateFT"

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
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Attachment_Count"

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
   ByRef brRec As tAttachmentType, _ 
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
      .AttachmentID = moUtil.EditLong(.AttachmentID, "AttachmentID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AttachmentID", adInteger, adParamInput, vbNull, CLng(brRec.AttachmentID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Attachment_Delete"

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
   ByRef brRec As tAttachmentType, _ 
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
      .AttachmentID = moUtil.EditLong(.AttachmentID, "AttachmentID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AttachmentID", adInteger, adParamInput, vbNull, CLng(brRec.AttachmentID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@RefID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AttachName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@FileName", adVarWChar, adParamOutput, 100, vbNull)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamOutput, 3000, vbNull)
      .Parameters.Append .CreateParameter("@ParentType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AttachSize", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AttachDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ExpireDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsLink", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Secure", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Score", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Attachment_Fetch"

   '-----get return values
   With brRec
      .CompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@CompanyID").Value)
      .ParentID = moUtil.FetchLong(oCmd.Parameters.Item("@ParentID").Value)
      .AuthUserID = moUtil.FetchLong(oCmd.Parameters.Item("@AuthUserID").Value)
      .RefID = moUtil.FetchLong(oCmd.Parameters.Item("@RefID").Value)
      .AttachName = moUtil.FetchString(oCmd.Parameters.Item("@AttachName").Value)
      .FileName = moUtil.FetchString(oCmd.Parameters.Item("@FileName").Value)
      .Description = moUtil.FetchString(oCmd.Parameters.Item("@Description").Value)
      .ParentType = moUtil.FetchLong(oCmd.Parameters.Item("@ParentType").Value)
      .AttachSize = moUtil.FetchLong(oCmd.Parameters.Item("@AttachSize").Value)
      .AttachDate = moUtil.FetchDate(oCmd.Parameters.Item("@AttachDate").Value)
      .ExpireDate = moUtil.FetchDate(oCmd.Parameters.Item("@ExpireDate").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .IsLink = moUtil.FetchInteger(oCmd.Parameters.Item("@IsLink").Value)
      .Secure = moUtil.FetchLong(oCmd.Parameters.Item("@Secure").Value)
      .Score = moUtil.FetchLong(oCmd.Parameters.Item("@Score").Value)
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
   ByVal bvParentID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tAttachmentType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindCompany"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAttachmentType
   Dim vRec As tAttachmentType
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
   bvParentID = moUtil.EditLong(bvParentID, "ParentID", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsAttachmentFindAttachName
         sProc = "pts_Attachment_FindCompanyAttachName"
         MaxBookMark = 70
      Case cptsAttachmentFindDescription
         sProc = "pts_Attachment_FindCompanyDescription"
         MaxBookMark = 3010
      Case cptsAttachmentFindFileName
         sProc = "pts_Attachment_FindCompanyFileName"
         MaxBookMark = 110
      Case cptsAttachmentFindAttachDate
         sProc = "pts_Attachment_FindCompanyAttachDate"
         MaxBookMark = 30
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamInput, vbNull, CLng(bvParentID))
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
               vRec.AttachmentID = moUtil.FetchLong(.Fields.Item("AttachmentID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
               vRec.AuthUserID = moUtil.FetchLong(.Fields.Item("AuthUserID").Value)
               vRec.RefID = moUtil.FetchLong(.Fields.Item("RefID").Value)
               vRec.AttachName = moUtil.FetchString(.Fields.Item("AttachName").Value)
               vRec.FileName = moUtil.FetchString(.Fields.Item("FileName").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.ParentType = moUtil.FetchLong(.Fields.Item("ParentType").Value)
               vRec.AttachSize = moUtil.FetchLong(.Fields.Item("AttachSize").Value)
               vRec.AttachDate = moUtil.FetchDate(.Fields.Item("AttachDate").Value)
               vRec.ExpireDate = moUtil.FetchDate(.Fields.Item("ExpireDate").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.IsLink = moUtil.FetchInteger(.Fields.Item("IsLink").Value)
               vRec.Secure = moUtil.FetchLong(.Fields.Item("Secure").Value)
               vRec.Score = moUtil.FetchLong(.Fields.Item("Score").Value)
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

Public Function FindTrainer( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvParentID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tAttachmentType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindTrainer"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAttachmentType
   Dim vRec As tAttachmentType
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
   bvParentID = moUtil.EditLong(bvParentID, "ParentID", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsAttachmentFindAttachName
         sProc = "pts_Attachment_FindTrainerAttachName"
         MaxBookMark = 70
      Case cptsAttachmentFindDescription
         sProc = "pts_Attachment_FindTrainerDescription"
         MaxBookMark = 3010
      Case cptsAttachmentFindFileName
         sProc = "pts_Attachment_FindTrainerFileName"
         MaxBookMark = 110
      Case cptsAttachmentFindAttachDate
         sProc = "pts_Attachment_FindTrainerAttachDate"
         MaxBookMark = 30
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamInput, vbNull, CLng(bvParentID))
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
               vRec.AttachmentID = moUtil.FetchLong(.Fields.Item("AttachmentID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
               vRec.AuthUserID = moUtil.FetchLong(.Fields.Item("AuthUserID").Value)
               vRec.RefID = moUtil.FetchLong(.Fields.Item("RefID").Value)
               vRec.AttachName = moUtil.FetchString(.Fields.Item("AttachName").Value)
               vRec.FileName = moUtil.FetchString(.Fields.Item("FileName").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.ParentType = moUtil.FetchLong(.Fields.Item("ParentType").Value)
               vRec.AttachSize = moUtil.FetchLong(.Fields.Item("AttachSize").Value)
               vRec.AttachDate = moUtil.FetchDate(.Fields.Item("AttachDate").Value)
               vRec.ExpireDate = moUtil.FetchDate(.Fields.Item("ExpireDate").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.IsLink = moUtil.FetchInteger(.Fields.Item("IsLink").Value)
               vRec.Secure = moUtil.FetchLong(.Fields.Item("Secure").Value)
               vRec.Score = moUtil.FetchLong(.Fields.Item("Score").Value)
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

Public Function FindCourse( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvParentID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tAttachmentType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindCourse"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAttachmentType
   Dim vRec As tAttachmentType
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
   bvParentID = moUtil.EditLong(bvParentID, "ParentID", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsAttachmentFindAttachName
         sProc = "pts_Attachment_FindCourseAttachName"
         MaxBookMark = 70
      Case cptsAttachmentFindDescription
         sProc = "pts_Attachment_FindCourseDescription"
         MaxBookMark = 3010
      Case cptsAttachmentFindFileName
         sProc = "pts_Attachment_FindCourseFileName"
         MaxBookMark = 110
      Case cptsAttachmentFindAttachDate
         sProc = "pts_Attachment_FindCourseAttachDate"
         MaxBookMark = 30
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamInput, vbNull, CLng(bvParentID))
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
               vRec.AttachmentID = moUtil.FetchLong(.Fields.Item("AttachmentID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
               vRec.AuthUserID = moUtil.FetchLong(.Fields.Item("AuthUserID").Value)
               vRec.RefID = moUtil.FetchLong(.Fields.Item("RefID").Value)
               vRec.AttachName = moUtil.FetchString(.Fields.Item("AttachName").Value)
               vRec.FileName = moUtil.FetchString(.Fields.Item("FileName").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.ParentType = moUtil.FetchLong(.Fields.Item("ParentType").Value)
               vRec.AttachSize = moUtil.FetchLong(.Fields.Item("AttachSize").Value)
               vRec.AttachDate = moUtil.FetchDate(.Fields.Item("AttachDate").Value)
               vRec.ExpireDate = moUtil.FetchDate(.Fields.Item("ExpireDate").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.IsLink = moUtil.FetchInteger(.Fields.Item("IsLink").Value)
               vRec.Secure = moUtil.FetchLong(.Fields.Item("Secure").Value)
               vRec.Score = moUtil.FetchLong(.Fields.Item("Score").Value)
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
   FindCourse = vRecs

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
   ByVal bvSecure As Long) As tAttachmentType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Search"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAttachmentType
   Dim vRec As tAttachmentType
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
      .Parameters.Append .CreateParameter("@Secure", adInteger, adParamInput, vbNull, CLng(bvSecure))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Attachment_Search")

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
               vRec.AttachmentID = moUtil.FetchLong(.Fields.Item("AttachmentID").Value)
               vRec.ParentType = moUtil.FetchLong(.Fields.Item("ParentType").Value)
               vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
               vRec.AttachName = moUtil.FetchString(.Fields.Item("AttachName").Value)
               vRec.FileName = moUtil.FetchString(.Fields.Item("FileName").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.AttachSize = moUtil.FetchLong(.Fields.Item("AttachSize").Value)
               vRec.AttachDate = moUtil.FetchDate(.Fields.Item("AttachDate").Value)
               vRec.IsLink = moUtil.FetchInteger(.Fields.Item("IsLink").Value)
               vRec.Secure = moUtil.FetchLong(.Fields.Item("Secure").Value)
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

Public Function SearchDate( _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvSecure As Long) As tAttachmentType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "SearchDate"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAttachmentType
   Dim vRec As tAttachmentType
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
      .Parameters.Append .CreateParameter("@Secure", adInteger, adParamInput, vbNull, CLng(bvSecure))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Attachment_SearchDate")

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
               vRec.AttachmentID = moUtil.FetchLong(.Fields.Item("AttachmentID").Value)
               vRec.ParentType = moUtil.FetchLong(.Fields.Item("ParentType").Value)
               vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
               vRec.AttachName = moUtil.FetchString(.Fields.Item("AttachName").Value)
               vRec.FileName = moUtil.FetchString(.Fields.Item("FileName").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.AttachSize = moUtil.FetchLong(.Fields.Item("AttachSize").Value)
               vRec.AttachDate = moUtil.FetchDate(.Fields.Item("AttachDate").Value)
               vRec.IsLink = moUtil.FetchInteger(.Fields.Item("IsLink").Value)
               vRec.Secure = moUtil.FetchLong(.Fields.Item("Secure").Value)
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
   SearchDate = vRecs

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
   ByVal bvParentID As Long, _ 
   ByVal bvSecure As Long) As tAttachmentType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListOrg"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAttachmentType
   Dim vRec As tAttachmentType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamInput, vbNull, CLng(bvParentID))
      .Parameters.Append .CreateParameter("@Secure", adInteger, adParamInput, vbNull, CLng(bvSecure))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Attachment_ListOrg")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.AttachmentID = moUtil.FetchLong(.Fields.Item("AttachmentID").Value)
            vRec.AuthUserID = moUtil.FetchLong(.Fields.Item("AuthUserID").Value)
            vRec.AttachName = moUtil.FetchString(.Fields.Item("AttachName").Value)
            vRec.FileName = moUtil.FetchString(.Fields.Item("FileName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.ParentType = moUtil.FetchLong(.Fields.Item("ParentType").Value)
            vRec.ParentID = moUtil.FetchLong(.Fields.Item("ParentID").Value)
            vRec.AttachSize = moUtil.FetchLong(.Fields.Item("AttachSize").Value)
            vRec.AttachDate = moUtil.FetchDate(.Fields.Item("AttachDate").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.IsLink = moUtil.FetchInteger(.Fields.Item("IsLink").Value)
            vRec.Secure = moUtil.FetchLong(.Fields.Item("Secure").Value)
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

Public Function ListAttachments( _ 
   ByVal bvParentID As Long, _ 
   ByVal bvParentType As Long, _ 
   ByVal bvUserID As Long) As tAttachmentType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListAttachments"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAttachmentType
   Dim vRec As tAttachmentType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamInput, vbNull, CLng(bvParentID))
      .Parameters.Append .CreateParameter("@ParentType", adInteger, adParamInput, vbNull, CLng(bvParentType))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Attachment_ListAttachments")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.AttachmentID = moUtil.FetchLong(.Fields.Item("AttachmentID").Value)
            vRec.AuthUserID = moUtil.FetchLong(.Fields.Item("AuthUserID").Value)
            vRec.AttachName = moUtil.FetchString(.Fields.Item("AttachName").Value)
            vRec.FileName = moUtil.FetchString(.Fields.Item("FileName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.ParentType = moUtil.FetchLong(.Fields.Item("ParentType").Value)
            vRec.AttachSize = moUtil.FetchLong(.Fields.Item("AttachSize").Value)
            vRec.AttachDate = moUtil.FetchDate(.Fields.Item("AttachDate").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.IsLink = moUtil.FetchInteger(.Fields.Item("IsLink").Value)
            vRec.Secure = moUtil.FetchLong(.Fields.Item("Secure").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListAttachments = vRecs

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

Public Function ListActiveAttachments( _ 
   ByVal bvParentID As Long, _ 
   ByVal bvParentType As Long, _ 
   ByVal bvSecure As Long, _ 
   ByVal bvUserID As Long) As tAttachmentType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListActiveAttachments"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAttachmentType
   Dim vRec As tAttachmentType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamInput, vbNull, CLng(bvParentID))
      .Parameters.Append .CreateParameter("@ParentType", adInteger, adParamInput, vbNull, CLng(bvParentType))
      .Parameters.Append .CreateParameter("@Secure", adInteger, adParamInput, vbNull, CLng(bvSecure))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Attachment_ListActiveAttachments")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.AttachmentID = moUtil.FetchLong(.Fields.Item("AttachmentID").Value)
            vRec.AuthUserID = moUtil.FetchLong(.Fields.Item("AuthUserID").Value)
            vRec.AttachName = moUtil.FetchString(.Fields.Item("AttachName").Value)
            vRec.FileName = moUtil.FetchString(.Fields.Item("FileName").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.AttachSize = moUtil.FetchLong(.Fields.Item("AttachSize").Value)
            vRec.AttachDate = moUtil.FetchDate(.Fields.Item("AttachDate").Value)
            vRec.IsLink = moUtil.FetchInteger(.Fields.Item("IsLink").Value)
            vRec.Secure = moUtil.FetchLong(.Fields.Item("Secure").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListActiveAttachments = vRecs

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

Public Function ListCompanyAttachments( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvUserID As Long) As tAttachmentType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListCompanyAttachments"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAttachmentType
   Dim vRec As tAttachmentType
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
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Attachment_ListCompanyAttachments")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.AttachmentID = moUtil.FetchLong(.Fields.Item("AttachmentID").Value)
            vRec.AttachName = moUtil.FetchString(.Fields.Item("AttachName").Value)
            vRec.FileName = moUtil.FetchString(.Fields.Item("FileName").Value)
            vRec.AttachDate = moUtil.FetchDate(.Fields.Item("AttachDate").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListCompanyAttachments = vRecs

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
   ByRef brRec As tAttachmentType, _ 
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
      .Parameters.Append .CreateParameter("@AttachmentID", adInteger, adParamInput, vbNull, CLng(brRec.AttachmentID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@ParentID", adInteger, adParamInput, vbNull, CLng(brRec.ParentID))
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamInput, vbNull, CLng(brRec.AuthUserID))
      .Parameters.Append .CreateParameter("@RefID", adInteger, adParamInput, vbNull, CLng(brRec.RefID))
      .Parameters.Append .CreateParameter("@AttachName", adVarWChar, adParamInput, 60, brRec.AttachName)
      .Parameters.Append .CreateParameter("@FileName", adVarWChar, adParamInput, 100, brRec.FileName)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 3000, brRec.Description)
      .Parameters.Append .CreateParameter("@ParentType", adInteger, adParamInput, vbNull, CLng(brRec.ParentType))
      .Parameters.Append .CreateParameter("@AttachSize", adInteger, adParamInput, vbNull, CLng(brRec.AttachSize))
      .Parameters.Append .CreateParameter("@AttachDate", adDate, adParamInput, vbNull, CDate(brRec.AttachDate))
      .Parameters.Append .CreateParameter("@ExpireDate", adDate, adParamInput, vbNull, CDate(brRec.ExpireDate))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@IsLink", adSmallInt, adParamInput, vbNull, CInt(brRec.IsLink))
      .Parameters.Append .CreateParameter("@Secure", adInteger, adParamInput, vbNull, CLng(brRec.Secure))
      .Parameters.Append .CreateParameter("@Score", adInteger, adParamInput, vbNull, CLng(brRec.Score))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Attachment_Update"

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
   ByRef brRec As tAttachmentType, _ 
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
         .AttachmentID = moUtil.EditLong(.AttachmentID, "AttachmentID", True, , 1) 
      End If
      .CompanyID = moUtil.EditLong(.CompanyID, "CompanyID", False) 
      .ParentID = moUtil.EditLong(.ParentID, "ParentID", False) 
      .AuthUserID = moUtil.EditLong(.AuthUserID, "AuthUserID", False) 
      .RefID = moUtil.EditLong(.RefID, "RefID", False) 
      .AttachName = moUtil.EditString(.AttachName, "AttachName", True, , 1, 60) 
      .FileName = moUtil.EditString(.FileName, "FileName", False, , 1, 100) 
      .Description = moUtil.EditString(.Description, "Description", False, , 1, 3000) 
      .ParentType = moUtil.EditLong(.ParentType, "ParentType", False) 
      .AttachSize = moUtil.EditLong(.AttachSize, "AttachSize", False) 
      .AttachDate = moUtil.EditDate(.AttachDate, "AttachDate", False) 
      .ExpireDate = moUtil.EditDate(.ExpireDate, "ExpireDate", False) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .IsLink = moUtil.EditInteger(.IsLink, "IsLink", False, 0, 0, 1) 
      .Secure = moUtil.EditLong(.Secure, "Secure", False) 
      .Score = moUtil.EditLong(.Score, "Score", False) 
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