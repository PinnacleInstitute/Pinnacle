VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CLeadPageB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CLeadPage"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tLeadPageType
   LeadPageID As String
   LeadCampaignID As String
   LeadPageName As String
   Status As String
   Seq As String
   IsInput As String
   IsCapture As String
   IsProspect As String
   IsNext As String
   NextCaption As String
   Inputs As String
   Language As String
   IsLeadURL As String
   IsRedirectURL As String
   LeadURL As String
   RedirectURL As String
   TopCode As String
   ReportFromDate As String
   ReportToDate As String
   MemberID As String
   AffiliateID As String
End Type

Public Sub Add( _ 
   ByRef brRec As tLeadPageType, _ 
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
      .Parameters.Append .CreateParameter("@LeadPageID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@LeadCampaignID", adInteger, adParamInput, vbNull, CLng(brRec.LeadCampaignID))
      .Parameters.Append .CreateParameter("@LeadPageName", adVarWChar, adParamInput, 60, brRec.LeadPageName)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@IsInput", adSmallInt, adParamInput, vbNull, CInt(brRec.IsInput))
      .Parameters.Append .CreateParameter("@IsCapture", adSmallInt, adParamInput, vbNull, CInt(brRec.IsCapture))
      .Parameters.Append .CreateParameter("@IsProspect", adSmallInt, adParamInput, vbNull, CInt(brRec.IsProspect))
      .Parameters.Append .CreateParameter("@IsNext", adSmallInt, adParamInput, vbNull, CInt(brRec.IsNext))
      .Parameters.Append .CreateParameter("@NextCaption", adVarWChar, adParamInput, 40, brRec.NextCaption)
      .Parameters.Append .CreateParameter("@Inputs", adVarWChar, adParamInput, 1000, brRec.Inputs)
      .Parameters.Append .CreateParameter("@Language", adVarWChar, adParamInput, 6, brRec.Language)
      .Parameters.Append .CreateParameter("@IsLeadURL", adSmallInt, adParamInput, vbNull, CInt(brRec.IsLeadURL))
      .Parameters.Append .CreateParameter("@IsRedirectURL", adSmallInt, adParamInput, vbNull, CInt(brRec.IsRedirectURL))
      .Parameters.Append .CreateParameter("@LeadURL", adVarWChar, adParamInput, 200, brRec.LeadURL)
      .Parameters.Append .CreateParameter("@RedirectURL", adVarWChar, adParamInput, 200, brRec.RedirectURL)
      .Parameters.Append .CreateParameter("@TopCode", adVarWChar, adParamInput, 500, brRec.TopCode)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_LeadPage_Add"

   '-----get return values
   With brRec
      .LeadPageID = moUtil.FetchLong(oCmd.Parameters.Item("@LeadPageID").Value)
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

Public Function NextPage( _ 
   ByRef brRec As tLeadPageType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "NextPage"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@LeadCampaignID", adInteger, adParamInput, vbNull, CLng(brRec.LeadCampaignID))
      .Parameters.Append .CreateParameter("@LeadPageID", adInteger, adParamInput, vbNull, CLng(brRec.LeadPageID))
      .Parameters.Append .CreateParameter("@Language", adVarWChar, adParamInput, 6, brRec.Language)
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_LeadPage_NextPage"

   '-----get return values
   NextPage = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function GetSeq( _ 
   ByRef brRec As tLeadPageType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "GetSeq"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@LeadCampaignID", adInteger, adParamInput, vbNull, CLng(brRec.LeadCampaignID))
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@Language", adVarWChar, adParamInput, 6, brRec.Language)
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_LeadPage_GetSeq"

   '-----get return values
   GetSeq = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function ThanksPage( _ 
   ByRef brRec As tLeadPageType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ThanksPage"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@LeadCampaignID", adInteger, adParamInput, vbNull, CLng(brRec.LeadCampaignID))
      .Parameters.Append .CreateParameter("@Language", adVarWChar, adParamInput, 6, brRec.Language)
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_LeadPage_ThanksPage"

   '-----get return values
   ThanksPage = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

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
   ByRef brRec As tLeadPageType, _ 
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
      .LeadPageID = moUtil.EditLong(.LeadPageID, "LeadPageID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@LeadPageID", adInteger, adParamInput, vbNull, CLng(brRec.LeadPageID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_LeadPage_Delete"

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
   ByRef brRec As tLeadPageType, _ 
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
      .LeadPageID = moUtil.EditLong(.LeadPageID, "LeadPageID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@LeadPageID", adInteger, adParamInput, vbNull, CLng(brRec.LeadPageID))
      .Parameters.Append .CreateParameter("@LeadCampaignID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@LeadPageName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsInput", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsCapture", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsProspect", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsNext", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NextCaption", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@Inputs", adVarWChar, adParamOutput, 1000, vbNull)
      .Parameters.Append .CreateParameter("@Language", adVarWChar, adParamOutput, 6, vbNull)
      .Parameters.Append .CreateParameter("@IsLeadURL", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsRedirectURL", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@LeadURL", adVarWChar, adParamOutput, 200, vbNull)
      .Parameters.Append .CreateParameter("@RedirectURL", adVarWChar, adParamOutput, 200, vbNull)
      .Parameters.Append .CreateParameter("@TopCode", adVarWChar, adParamOutput, 500, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_LeadPage_Fetch"

   '-----get return values
   With brRec
      .LeadCampaignID = moUtil.FetchLong(oCmd.Parameters.Item("@LeadCampaignID").Value)
      .LeadPageName = moUtil.FetchString(oCmd.Parameters.Item("@LeadPageName").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .Seq = moUtil.FetchLong(oCmd.Parameters.Item("@Seq").Value)
      .IsInput = moUtil.FetchInteger(oCmd.Parameters.Item("@IsInput").Value)
      .IsCapture = moUtil.FetchInteger(oCmd.Parameters.Item("@IsCapture").Value)
      .IsProspect = moUtil.FetchInteger(oCmd.Parameters.Item("@IsProspect").Value)
      .IsNext = moUtil.FetchInteger(oCmd.Parameters.Item("@IsNext").Value)
      .NextCaption = moUtil.FetchString(oCmd.Parameters.Item("@NextCaption").Value)
      .Inputs = moUtil.FetchString(oCmd.Parameters.Item("@Inputs").Value)
      .Language = moUtil.FetchString(oCmd.Parameters.Item("@Language").Value)
      .IsLeadURL = moUtil.FetchInteger(oCmd.Parameters.Item("@IsLeadURL").Value)
      .IsRedirectURL = moUtil.FetchInteger(oCmd.Parameters.Item("@IsRedirectURL").Value)
      .LeadURL = moUtil.FetchString(oCmd.Parameters.Item("@LeadURL").Value)
      .RedirectURL = moUtil.FetchString(oCmd.Parameters.Item("@RedirectURL").Value)
      .TopCode = moUtil.FetchString(oCmd.Parameters.Item("@TopCode").Value)
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

Public Sub FetchEmail( _ 
   ByRef brRec As tLeadPageType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FetchEmail"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .LeadCampaignID = moUtil.EditLong(.LeadCampaignID, "LeadCampaignID", True, 0) 
      .Language = moUtil.EditString(.Language, "Language", True, "", 1, 6) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@LeadCampaignID", adInteger, adParamInput, vbNull, CLng(brRec.LeadCampaignID))
      .Parameters.Append .CreateParameter("@Language", adVarWChar, adParamInput, 6, brRec.Language)
      .Parameters.Append .CreateParameter("@LeadPageID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@LeadPageName", adVarWChar, adParamOutput, 60, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_LeadPage_FetchEmail"

   '-----get return values
   With brRec
      .LeadPageID = moUtil.FetchLong(oCmd.Parameters.Item("@LeadPageID").Value)
      .LeadPageName = moUtil.FetchString(oCmd.Parameters.Item("@LeadPageName").Value)
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

Public Function List( _ 
   ByVal bvLeadCampaignID As Long) As tLeadPageType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "List"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tLeadPageType
   Dim vRec As tLeadPageType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@LeadCampaignID", adInteger, adParamInput, vbNull, CLng(bvLeadCampaignID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_LeadPage_List")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.LeadPageID = moUtil.FetchLong(.Fields.Item("LeadPageID").Value)
            vRec.LeadPageName = moUtil.FetchString(.Fields.Item("LeadPageName").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
            vRec.IsInput = moUtil.FetchInteger(.Fields.Item("IsInput").Value)
            vRec.IsCapture = moUtil.FetchInteger(.Fields.Item("IsCapture").Value)
            vRec.IsProspect = moUtil.FetchInteger(.Fields.Item("IsProspect").Value)
            vRec.IsNext = moUtil.FetchInteger(.Fields.Item("IsNext").Value)
            vRec.NextCaption = moUtil.FetchString(.Fields.Item("NextCaption").Value)
            vRec.Inputs = moUtil.FetchString(.Fields.Item("Inputs").Value)
            vRec.Language = moUtil.FetchString(.Fields.Item("Language").Value)
            vRec.IsLeadURL = moUtil.FetchInteger(.Fields.Item("IsLeadURL").Value)
            vRec.IsRedirectURL = moUtil.FetchInteger(.Fields.Item("IsRedirectURL").Value)
            vRec.LeadURL = moUtil.FetchString(.Fields.Item("LeadURL").Value)
            vRec.RedirectURL = moUtil.FetchString(.Fields.Item("RedirectURL").Value)
            vRec.TopCode = moUtil.FetchString(.Fields.Item("TopCode").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   List = vRecs

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

Public Function ViewPages( _ 
   ByVal bvLeadCampaignID As Long, _ 
   ByVal bvLanguage As String) As tLeadPageType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ViewPages"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tLeadPageType
   Dim vRec As tLeadPageType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvLeadCampaignID = moUtil.EditLong(bvLeadCampaignID, "LeadCampaignID", True, 0) 
      bvLanguage = moUtil.EditString(bvLanguage, "Language", True, "", 1, 6) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@LeadCampaignID", adInteger, adParamInput, vbNull, CLng(bvLeadCampaignID))
      .Parameters.Append .CreateParameter("@Language", adVarWChar, adParamInput, 6, bvLanguage)
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_LeadPage_ViewPages")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.LeadPageID = moUtil.FetchLong(.Fields.Item("LeadPageID").Value)
            vRec.LeadPageName = moUtil.FetchString(.Fields.Item("LeadPageName").Value)
            vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ViewPages = vRecs

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

Public Function ReportCompany( _ 
   ByVal bvLeadCampaignID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date) As tLeadPageType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportCompany"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tLeadPageType
   Dim vRec As tLeadPageType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvLeadCampaignID = moUtil.EditLong(bvLeadCampaignID, "LeadCampaignID", True, 0) 
      bvReportFromDate = moUtil.EditDate(bvReportFromDate, "ReportFromDate", True, 0) 
      bvReportToDate = moUtil.EditDate(bvReportToDate, "ReportToDate", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@LeadCampaignID", adInteger, adParamInput, vbNull, CLng(bvLeadCampaignID))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(bvReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(bvReportToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_LeadPage_ReportCompany")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.LeadPageID = moUtil.FetchLong(.Fields.Item("LeadPageID").Value)
            vRec.LeadPageName = moUtil.FetchString(.Fields.Item("LeadPageName").Value)
            vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ReportCompany = vRecs

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

Public Function ReportMember( _ 
   ByVal bvLeadCampaignID As Long, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date) As tLeadPageType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tLeadPageType
   Dim vRec As tLeadPageType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvLeadCampaignID = moUtil.EditLong(bvLeadCampaignID, "LeadCampaignID", True, 0) 
      bvReportFromDate = moUtil.EditDate(bvReportFromDate, "ReportFromDate", True, 0) 
      bvReportToDate = moUtil.EditDate(bvReportToDate, "ReportToDate", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@LeadCampaignID", adInteger, adParamInput, vbNull, CLng(bvLeadCampaignID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(bvReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(bvReportToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_LeadPage_ReportMember")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.LeadPageID = moUtil.FetchLong(.Fields.Item("LeadPageID").Value)
            vRec.LeadPageName = moUtil.FetchString(.Fields.Item("LeadPageName").Value)
            vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ReportMember = vRecs

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

Public Function ReportAffiliate( _ 
   ByVal bvLeadCampaignID As Long, _ 
   ByVal bvAffiliateID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date) As tLeadPageType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportAffiliate"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tLeadPageType
   Dim vRec As tLeadPageType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvLeadCampaignID = moUtil.EditLong(bvLeadCampaignID, "LeadCampaignID", True, 0) 
      bvReportFromDate = moUtil.EditDate(bvReportFromDate, "ReportFromDate", True, 0) 
      bvReportToDate = moUtil.EditDate(bvReportToDate, "ReportToDate", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@LeadCampaignID", adInteger, adParamInput, vbNull, CLng(bvLeadCampaignID))
      .Parameters.Append .CreateParameter("@AffiliateID", adInteger, adParamInput, vbNull, CLng(bvAffiliateID))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(bvReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(bvReportToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_LeadPage_ReportAffiliate")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.LeadPageID = moUtil.FetchLong(.Fields.Item("LeadPageID").Value)
            vRec.LeadPageName = moUtil.FetchString(.Fields.Item("LeadPageName").Value)
            vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ReportAffiliate = vRecs

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

Public Function Languages( _ 
   ByVal bvLeadCampaignID As Long) As tLeadPageType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Languages"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tLeadPageType
   Dim vRec As tLeadPageType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@LeadCampaignID", adInteger, adParamInput, vbNull, CLng(bvLeadCampaignID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_LeadPage_Languages")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.LeadPageID = moUtil.FetchLong(.Fields.Item("LeadPageID").Value)
            vRec.LeadPageName = moUtil.FetchString(.Fields.Item("LeadPageName").Value)
            vRec.Language = moUtil.FetchString(.Fields.Item("Language").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   Languages = vRecs

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
   ByRef brRec As tLeadPageType, _ 
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
      .Parameters.Append .CreateParameter("@LeadPageID", adInteger, adParamInput, vbNull, CLng(brRec.LeadPageID))
      .Parameters.Append .CreateParameter("@LeadCampaignID", adInteger, adParamInput, vbNull, CLng(brRec.LeadCampaignID))
      .Parameters.Append .CreateParameter("@LeadPageName", adVarWChar, adParamInput, 60, brRec.LeadPageName)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@IsInput", adSmallInt, adParamInput, vbNull, CInt(brRec.IsInput))
      .Parameters.Append .CreateParameter("@IsCapture", adSmallInt, adParamInput, vbNull, CInt(brRec.IsCapture))
      .Parameters.Append .CreateParameter("@IsProspect", adSmallInt, adParamInput, vbNull, CInt(brRec.IsProspect))
      .Parameters.Append .CreateParameter("@IsNext", adSmallInt, adParamInput, vbNull, CInt(brRec.IsNext))
      .Parameters.Append .CreateParameter("@NextCaption", adVarWChar, adParamInput, 40, brRec.NextCaption)
      .Parameters.Append .CreateParameter("@Inputs", adVarWChar, adParamInput, 1000, brRec.Inputs)
      .Parameters.Append .CreateParameter("@Language", adVarWChar, adParamInput, 6, brRec.Language)
      .Parameters.Append .CreateParameter("@IsLeadURL", adSmallInt, adParamInput, vbNull, CInt(brRec.IsLeadURL))
      .Parameters.Append .CreateParameter("@IsRedirectURL", adSmallInt, adParamInput, vbNull, CInt(brRec.IsRedirectURL))
      .Parameters.Append .CreateParameter("@LeadURL", adVarWChar, adParamInput, 200, brRec.LeadURL)
      .Parameters.Append .CreateParameter("@RedirectURL", adVarWChar, adParamInput, 200, brRec.RedirectURL)
      .Parameters.Append .CreateParameter("@TopCode", adVarWChar, adParamInput, 500, brRec.TopCode)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_LeadPage_Update"

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
   ByRef brRec As tLeadPageType, _ 
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
         .LeadPageID = moUtil.EditLong(.LeadPageID, "LeadPageID", True, , 1) 
      End If
      .LeadCampaignID = moUtil.EditLong(.LeadCampaignID, "LeadCampaignID", True) 
      .LeadPageName = moUtil.EditString(.LeadPageName, "LeadPageName", True, , 1, 60) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .Seq = moUtil.EditLong(.Seq, "Seq", False, , 1) 
      .IsInput = moUtil.EditInteger(.IsInput, "IsInput", False, 0, 0, 1) 
      .IsCapture = moUtil.EditInteger(.IsCapture, "IsCapture", False, 0, 0, 1) 
      .IsProspect = moUtil.EditInteger(.IsProspect, "IsProspect", False, 0, 0, 1) 
      .IsNext = moUtil.EditInteger(.IsNext, "IsNext", False, 0, 0, 1) 
      .NextCaption = moUtil.EditString(.NextCaption, "NextCaption", False) 
      .Inputs = moUtil.EditString(.Inputs, "Inputs", False) 
      .Language = moUtil.EditString(.Language, "Language", False, , 1, 6) 
      .IsLeadURL = moUtil.EditInteger(.IsLeadURL, "IsLeadURL", False, 0, 0, 1) 
      .IsRedirectURL = moUtil.EditInteger(.IsRedirectURL, "IsRedirectURL", False, 0, 0, 1) 
      .LeadURL = moUtil.EditString(.LeadURL, "LeadURL", False) 
      .RedirectURL = moUtil.EditString(.RedirectURL, "RedirectURL", False) 
      .TopCode = moUtil.EditString(.TopCode, "TopCode", False) 
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