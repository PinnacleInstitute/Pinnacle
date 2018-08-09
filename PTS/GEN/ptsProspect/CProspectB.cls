VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CProspectB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CProspect"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tProspectType
   ProspectID As String
   CompanyID As String
   MemberID As String
   SalesCampaignID As String
   LeadCampaignID As String
   PresentID As String
   ProspectTypeID As String
   EmailID As String
   AffiliateID As String
   NewsLetterID As String
   MemberName As String
   StatusName As String
   IsBoard As String
   SalesCampaignName As String
   ProspectTypeName As String
   IsCopyURL As String
   Result As String
   ProspectName As String
   Website As String
   Description As String
   Representing As String
   Potential As String
   NameLast As String
   NameFirst As String
   ContactName As String
   Title As String
   Email As String
   Phone1 As String
   Phone2 As String
   Street As String
   Unit As String
   City As String
   State As String
   Zip As String
   Country As String
   Status As String
   NextEvent As String
   NextDate As String
   NextTime As String
   CreateDate As String
   FBDate As String
   CloseDate As String
   DeadDate As String
   Date1 As String
   Date2 As String
   Date3 As String
   Date4 As String
   Date5 As String
   Date6 As String
   Date7 As String
   Date8 As String
   Date9 As String
   Date10 As String
   ChangeDate As String
   ChangeStatus As String
   EmailDate As String
   RSVP As String
   EmailStatus As String
   LeadViews As String
   LeadPages As String
   LeadReplies As String
   PresentViews As String
   PresentPages As String
   NoDistribute As String
   DistributorID As String
   DistributeDate As String
   Priority As String
   InputValues As String
   Source As String
   Code As String
   Reminder As String
   RemindDate As String
   TimeZone As String
   BestTime As String
   ReportFromDate As String
   ReportToDate As String
   Count As String
   InputOptions As String
   IsMsg As String
   Email2 As String
   FolderID As String
End Type

Public Sub Add( _ 
   ByRef brRec As tProspectType, _ 
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
      .Parameters.Append .CreateParameter("@ProspectID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@SalesCampaignID", adInteger, adParamInput, vbNull, CLng(brRec.SalesCampaignID))
      .Parameters.Append .CreateParameter("@LeadCampaignID", adInteger, adParamInput, vbNull, CLng(brRec.LeadCampaignID))
      .Parameters.Append .CreateParameter("@PresentID", adInteger, adParamInput, vbNull, CLng(brRec.PresentID))
      .Parameters.Append .CreateParameter("@ProspectTypeID", adInteger, adParamInput, vbNull, CLng(brRec.ProspectTypeID))
      .Parameters.Append .CreateParameter("@EmailID", adInteger, adParamInput, vbNull, CLng(brRec.EmailID))
      .Parameters.Append .CreateParameter("@AffiliateID", adInteger, adParamInput, vbNull, CLng(brRec.AffiliateID))
      .Parameters.Append .CreateParameter("@NewsLetterID", adInteger, adParamInput, vbNull, CLng(brRec.NewsLetterID))
      .Parameters.Append .CreateParameter("@ProspectName", adVarWChar, adParamInput, 60, brRec.ProspectName)
      .Parameters.Append .CreateParameter("@Website", adVarWChar, adParamInput, 80, brRec.Website)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 2000, brRec.Description)
      .Parameters.Append .CreateParameter("@Representing", adVarWChar, adParamInput, 20, brRec.Representing)
      .Parameters.Append .CreateParameter("@Potential", adCurrency, adParamInput, vbNull, CCur(brRec.Potential))
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamInput, 30, brRec.NameLast)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamInput, 30, brRec.NameFirst)
      .Parameters.Append .CreateParameter("@Title", adVarWChar, adParamInput, 30, brRec.Title)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@Phone1", adVarWChar, adParamInput, 30, brRec.Phone1)
      .Parameters.Append .CreateParameter("@Phone2", adVarWChar, adParamInput, 30, brRec.Phone2)
      .Parameters.Append .CreateParameter("@Street", adVarWChar, adParamInput, 60, brRec.Street)
      .Parameters.Append .CreateParameter("@Unit", adVarWChar, adParamInput, 40, brRec.Unit)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamInput, 30, brRec.City)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamInput, 30, brRec.State)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamInput, 20, brRec.Zip)
      .Parameters.Append .CreateParameter("@Country", adVarWChar, adParamInput, 30, brRec.Country)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@NextEvent", adInteger, adParamInput, vbNull, CLng(brRec.NextEvent))
      .Parameters.Append .CreateParameter("@NextDate", adDate, adParamInput, vbNull, CDate(brRec.NextDate))
      .Parameters.Append .CreateParameter("@NextTime", adVarWChar, adParamInput, 8, brRec.NextTime)
      .Parameters.Append .CreateParameter("@CreateDate", adDate, adParamInput, vbNull, CDate(brRec.CreateDate))
      .Parameters.Append .CreateParameter("@FBDate", adDate, adParamInput, vbNull, CDate(brRec.FBDate))
      .Parameters.Append .CreateParameter("@CloseDate", adDate, adParamInput, vbNull, CDate(brRec.CloseDate))
      .Parameters.Append .CreateParameter("@DeadDate", adDate, adParamInput, vbNull, CDate(brRec.DeadDate))
      .Parameters.Append .CreateParameter("@Date1", adDate, adParamInput, vbNull, CDate(brRec.Date1))
      .Parameters.Append .CreateParameter("@Date2", adDate, adParamInput, vbNull, CDate(brRec.Date2))
      .Parameters.Append .CreateParameter("@Date3", adDate, adParamInput, vbNull, CDate(brRec.Date3))
      .Parameters.Append .CreateParameter("@Date4", adDate, adParamInput, vbNull, CDate(brRec.Date4))
      .Parameters.Append .CreateParameter("@Date5", adDate, adParamInput, vbNull, CDate(brRec.Date5))
      .Parameters.Append .CreateParameter("@Date6", adDate, adParamInput, vbNull, CDate(brRec.Date6))
      .Parameters.Append .CreateParameter("@Date7", adDate, adParamInput, vbNull, CDate(brRec.Date7))
      .Parameters.Append .CreateParameter("@Date8", adDate, adParamInput, vbNull, CDate(brRec.Date8))
      .Parameters.Append .CreateParameter("@Date9", adDate, adParamInput, vbNull, CDate(brRec.Date9))
      .Parameters.Append .CreateParameter("@Date10", adDate, adParamInput, vbNull, CDate(brRec.Date10))
      .Parameters.Append .CreateParameter("@ChangeDate", adDate, adParamInput, vbNull, CDate(brRec.ChangeDate))
      .Parameters.Append .CreateParameter("@ChangeStatus", adInteger, adParamInput, vbNull, CLng(brRec.ChangeStatus))
      .Parameters.Append .CreateParameter("@EmailDate", adDate, adParamInput, vbNull, CDate(brRec.EmailDate))
      .Parameters.Append .CreateParameter("@RSVP", adInteger, adParamInput, vbNull, CLng(brRec.RSVP))
      .Parameters.Append .CreateParameter("@EmailStatus", adInteger, adParamInput, vbNull, CLng(brRec.EmailStatus))
      .Parameters.Append .CreateParameter("@LeadViews", adInteger, adParamInput, vbNull, CLng(brRec.LeadViews))
      .Parameters.Append .CreateParameter("@LeadPages", adVarWChar, adParamInput, 10, brRec.LeadPages)
      .Parameters.Append .CreateParameter("@LeadReplies", adInteger, adParamInput, vbNull, CLng(brRec.LeadReplies))
      .Parameters.Append .CreateParameter("@PresentViews", adInteger, adParamInput, vbNull, CLng(brRec.PresentViews))
      .Parameters.Append .CreateParameter("@PresentPages", adVarWChar, adParamInput, 40, brRec.PresentPages)
      .Parameters.Append .CreateParameter("@NoDistribute", adSmallInt, adParamInput, vbNull, CInt(brRec.NoDistribute))
      .Parameters.Append .CreateParameter("@DistributorID", adInteger, adParamInput, vbNull, CLng(brRec.DistributorID))
      .Parameters.Append .CreateParameter("@DistributeDate", adDate, adParamInput, vbNull, CDate(brRec.DistributeDate))
      .Parameters.Append .CreateParameter("@Priority", adVarWChar, adParamInput, 4, brRec.Priority)
      .Parameters.Append .CreateParameter("@InputValues", adVarWChar, adParamInput, 1000, brRec.InputValues)
      .Parameters.Append .CreateParameter("@Source", adVarWChar, adParamInput, 20, brRec.Source)
      .Parameters.Append .CreateParameter("@Code", adInteger, adParamInput, vbNull, CLng(brRec.Code))
      .Parameters.Append .CreateParameter("@Reminder", adInteger, adParamInput, vbNull, CLng(brRec.Reminder))
      .Parameters.Append .CreateParameter("@RemindDate", adDate, adParamInput, vbNull, CDate(brRec.RemindDate))
      .Parameters.Append .CreateParameter("@TimeZone", adInteger, adParamInput, vbNull, CLng(brRec.TimeZone))
      .Parameters.Append .CreateParameter("@BestTime", adInteger, adParamInput, vbNull, CLng(brRec.BestTime))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Prospect_Add"

   '-----get return values
   With brRec
      .ProspectID = moUtil.FetchLong(oCmd.Parameters.Item("@ProspectID").Value)
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

Public Function ReportCompany( _ 
   ByRef brRec As tProspectType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportCompany"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@LeadCampaignID", adInteger, adParamInput, vbNull, CLng(brRec.LeadCampaignID))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(brRec.ReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(brRec.ReportToDate))
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Prospect_ReportCompany"

   '-----get return values
   ReportCompany = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function ReportMember( _ 
   ByRef brRec As tProspectType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@LeadCampaignID", adInteger, adParamInput, vbNull, CLng(brRec.LeadCampaignID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(brRec.ReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(brRec.ReportToDate))
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Prospect_ReportMember"

   '-----get return values
   ReportMember = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function ReportAffiliate( _ 
   ByRef brRec As tProspectType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportAffiliate"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@LeadCampaignID", adInteger, adParamInput, vbNull, CLng(brRec.LeadCampaignID))
      .Parameters.Append .CreateParameter("@AffiliateID", adInteger, adParamInput, vbNull, CLng(brRec.AffiliateID))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(brRec.ReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(brRec.ReportToDate))
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Prospect_ReportAffiliate"

   '-----get return values
   ReportAffiliate = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function ContactCount( _ 
   ByRef brRec As tProspectType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ContactCount"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Prospect_ContactCount"

   '-----get return values
   ContactCount = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Sub NewStatus( _ 
   ByRef brRec As tProspectType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Execute a Command
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "NewStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .ProspectID = moUtil.EditLong(.ProspectID, "ProspectID", True, 0, 1) 
      .Status = moUtil.EditLong(.Status, "Status", True, 0) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProspectID", adInteger, adParamInput, vbNull, CLng(brRec.ProspectID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Prospect_NewStatus"

   '-----clean up
   Set oCmd = Nothing

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub NewStep( _ 
   ByRef brRec As tProspectType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Execute a Command
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "NewStep"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .ProspectID = moUtil.EditLong(.ProspectID, "ProspectID", True, 0, 1) 
      .Status = moUtil.EditLong(.Status, "Status", True, 0) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProspectID", adInteger, adParamInput, vbNull, CLng(brRec.ProspectID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Prospect_NewStep"

   '-----clean up
   Set oCmd = Nothing

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub UpdateCode( _ 
   ByRef brRec As tProspectType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Execute a Command
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "UpdateCode"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .ProspectID = moUtil.EditLong(.ProspectID, "ProspectID", True, 0, 1) 
      .Code = moUtil.EditLong(.Code, "Code", False, 0) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProspectID", adInteger, adParamInput, vbNull, CLng(brRec.ProspectID))
      .Parameters.Append .CreateParameter("@Code", adInteger, adParamInput, vbNull, CLng(brRec.Code))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Prospect_UpdateCode"

   '-----clean up
   Set oCmd = Nothing

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub ClearReminder( _ 
   ByRef brRec As tProspectType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Execute a Command
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ClearReminder"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProspectID", adInteger, adParamInput, vbNull, CLng(brRec.ProspectID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Prospect_ClearReminder"

   '-----clean up
   Set oCmd = Nothing

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
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
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Prospect_Count"

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
   ByRef brRec As tProspectType, _ 
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
      .ProspectID = moUtil.EditLong(.ProspectID, "ProspectID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProspectID", adInteger, adParamInput, vbNull, CLng(brRec.ProspectID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Prospect_Delete"

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
   ByRef brRec As tProspectType, _ 
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
      .ProspectID = moUtil.EditLong(.ProspectID, "ProspectID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProspectID", adInteger, adParamInput, vbNull, CLng(brRec.ProspectID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SalesCampaignID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@LeadCampaignID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PresentID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ProspectTypeID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@EmailID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AffiliateID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NewsLetterID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@StatusName", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@IsBoard", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@SalesCampaignName", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@ProspectTypeName", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@IsCopyURL", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Result", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@ProspectName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Website", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamOutput, 2000, vbNull)
      .Parameters.Append .CreateParameter("@Representing", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@Potential", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@ContactName", adVarWChar, adParamOutput, 62, vbNull)
      .Parameters.Append .CreateParameter("@Title", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@Phone1", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Phone2", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Street", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Unit", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@Country", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NextEvent", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NextDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NextTime", adVarWChar, adParamOutput, 8, vbNull)
      .Parameters.Append .CreateParameter("@CreateDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@FBDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CloseDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@DeadDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Date1", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Date2", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Date3", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Date4", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Date5", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Date6", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Date7", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Date8", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Date9", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Date10", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ChangeDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ChangeStatus", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@EmailDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@RSVP", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@EmailStatus", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@LeadViews", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@LeadPages", adVarWChar, adParamOutput, 10, vbNull)
      .Parameters.Append .CreateParameter("@LeadReplies", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PresentViews", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PresentPages", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@NoDistribute", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@DistributorID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@DistributeDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Priority", adVarWChar, adParamOutput, 4, vbNull)
      .Parameters.Append .CreateParameter("@InputValues", adVarWChar, adParamOutput, 1000, vbNull)
      .Parameters.Append .CreateParameter("@Source", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@Code", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Reminder", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@RemindDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@TimeZone", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BestTime", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Prospect_Fetch"

   '-----get return values
   With brRec
      .CompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@CompanyID").Value)
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .SalesCampaignID = moUtil.FetchLong(oCmd.Parameters.Item("@SalesCampaignID").Value)
      .LeadCampaignID = moUtil.FetchLong(oCmd.Parameters.Item("@LeadCampaignID").Value)
      .PresentID = moUtil.FetchLong(oCmd.Parameters.Item("@PresentID").Value)
      .ProspectTypeID = moUtil.FetchLong(oCmd.Parameters.Item("@ProspectTypeID").Value)
      .EmailID = moUtil.FetchLong(oCmd.Parameters.Item("@EmailID").Value)
      .AffiliateID = moUtil.FetchLong(oCmd.Parameters.Item("@AffiliateID").Value)
      .NewsLetterID = moUtil.FetchLong(oCmd.Parameters.Item("@NewsLetterID").Value)
      .MemberName = moUtil.FetchString(oCmd.Parameters.Item("@MemberName").Value)
      .StatusName = moUtil.FetchString(oCmd.Parameters.Item("@StatusName").Value)
      .IsBoard = moUtil.FetchString(oCmd.Parameters.Item("@IsBoard").Value)
      .SalesCampaignName = moUtil.FetchString(oCmd.Parameters.Item("@SalesCampaignName").Value)
      .ProspectTypeName = moUtil.FetchString(oCmd.Parameters.Item("@ProspectTypeName").Value)
      .IsCopyURL = moUtil.FetchInteger(oCmd.Parameters.Item("@IsCopyURL").Value)
      .Result = moUtil.FetchString(oCmd.Parameters.Item("@Result").Value)
      .ProspectName = moUtil.FetchString(oCmd.Parameters.Item("@ProspectName").Value)
      .Website = moUtil.FetchString(oCmd.Parameters.Item("@Website").Value)
      .Description = moUtil.FetchString(oCmd.Parameters.Item("@Description").Value)
      .Representing = moUtil.FetchString(oCmd.Parameters.Item("@Representing").Value)
      .Potential = moUtil.FetchCurrency(oCmd.Parameters.Item("@Potential").Value)
      .NameLast = moUtil.FetchString(oCmd.Parameters.Item("@NameLast").Value)
      .NameFirst = moUtil.FetchString(oCmd.Parameters.Item("@NameFirst").Value)
      .ContactName = moUtil.FetchString(oCmd.Parameters.Item("@ContactName").Value)
      .Title = moUtil.FetchString(oCmd.Parameters.Item("@Title").Value)
      .Email = moUtil.FetchString(oCmd.Parameters.Item("@Email").Value)
      .Phone1 = moUtil.FetchString(oCmd.Parameters.Item("@Phone1").Value)
      .Phone2 = moUtil.FetchString(oCmd.Parameters.Item("@Phone2").Value)
      .Street = moUtil.FetchString(oCmd.Parameters.Item("@Street").Value)
      .Unit = moUtil.FetchString(oCmd.Parameters.Item("@Unit").Value)
      .City = moUtil.FetchString(oCmd.Parameters.Item("@City").Value)
      .State = moUtil.FetchString(oCmd.Parameters.Item("@State").Value)
      .Zip = moUtil.FetchString(oCmd.Parameters.Item("@Zip").Value)
      .Country = moUtil.FetchString(oCmd.Parameters.Item("@Country").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .NextEvent = moUtil.FetchLong(oCmd.Parameters.Item("@NextEvent").Value)
      .NextDate = moUtil.FetchDate(oCmd.Parameters.Item("@NextDate").Value)
      .NextTime = moUtil.FetchString(oCmd.Parameters.Item("@NextTime").Value)
      .CreateDate = moUtil.FetchDate(oCmd.Parameters.Item("@CreateDate").Value)
      .FBDate = moUtil.FetchDate(oCmd.Parameters.Item("@FBDate").Value)
      .CloseDate = moUtil.FetchDate(oCmd.Parameters.Item("@CloseDate").Value)
      .DeadDate = moUtil.FetchDate(oCmd.Parameters.Item("@DeadDate").Value)
      .Date1 = moUtil.FetchDate(oCmd.Parameters.Item("@Date1").Value)
      .Date2 = moUtil.FetchDate(oCmd.Parameters.Item("@Date2").Value)
      .Date3 = moUtil.FetchDate(oCmd.Parameters.Item("@Date3").Value)
      .Date4 = moUtil.FetchDate(oCmd.Parameters.Item("@Date4").Value)
      .Date5 = moUtil.FetchDate(oCmd.Parameters.Item("@Date5").Value)
      .Date6 = moUtil.FetchDate(oCmd.Parameters.Item("@Date6").Value)
      .Date7 = moUtil.FetchDate(oCmd.Parameters.Item("@Date7").Value)
      .Date8 = moUtil.FetchDate(oCmd.Parameters.Item("@Date8").Value)
      .Date9 = moUtil.FetchDate(oCmd.Parameters.Item("@Date9").Value)
      .Date10 = moUtil.FetchDate(oCmd.Parameters.Item("@Date10").Value)
      .ChangeDate = moUtil.FetchDate(oCmd.Parameters.Item("@ChangeDate").Value)
      .ChangeStatus = moUtil.FetchLong(oCmd.Parameters.Item("@ChangeStatus").Value)
      .EmailDate = moUtil.FetchDate(oCmd.Parameters.Item("@EmailDate").Value)
      .RSVP = moUtil.FetchLong(oCmd.Parameters.Item("@RSVP").Value)
      .EmailStatus = moUtil.FetchLong(oCmd.Parameters.Item("@EmailStatus").Value)
      .LeadViews = moUtil.FetchLong(oCmd.Parameters.Item("@LeadViews").Value)
      .LeadPages = moUtil.FetchString(oCmd.Parameters.Item("@LeadPages").Value)
      .LeadReplies = moUtil.FetchLong(oCmd.Parameters.Item("@LeadReplies").Value)
      .PresentViews = moUtil.FetchLong(oCmd.Parameters.Item("@PresentViews").Value)
      .PresentPages = moUtil.FetchString(oCmd.Parameters.Item("@PresentPages").Value)
      .NoDistribute = moUtil.FetchInteger(oCmd.Parameters.Item("@NoDistribute").Value)
      .DistributorID = moUtil.FetchLong(oCmd.Parameters.Item("@DistributorID").Value)
      .DistributeDate = moUtil.FetchDate(oCmd.Parameters.Item("@DistributeDate").Value)
      .Priority = moUtil.FetchString(oCmd.Parameters.Item("@Priority").Value)
      .InputValues = moUtil.FetchString(oCmd.Parameters.Item("@InputValues").Value)
      .Source = moUtil.FetchString(oCmd.Parameters.Item("@Source").Value)
      .Code = moUtil.FetchLong(oCmd.Parameters.Item("@Code").Value)
      .Reminder = moUtil.FetchLong(oCmd.Parameters.Item("@Reminder").Value)
      .RemindDate = moUtil.FetchDate(oCmd.Parameters.Item("@RemindDate").Value)
      .TimeZone = moUtil.FetchLong(oCmd.Parameters.Item("@TimeZone").Value)
      .BestTime = moUtil.FetchLong(oCmd.Parameters.Item("@BestTime").Value)
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

Public Function FindUnassigned( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindUnassigned"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
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
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsProspectFindProspectName
         sProc = "pts_Prospect_FindUnassignedProspectName"
         MaxBookMark = 70
      Case cptsProspectFindContactName
         sProc = "pts_Prospect_FindUnassignedContactName"
         MaxBookMark = 72
      Case cptsProspectFindCreateDate
         sProc = "pts_Prospect_FindUnassignedCreateDate"
         MaxBookMark = 30
      Case cptsProspectFindPriority
         sProc = "pts_Prospect_FindUnassignedPriority"
         MaxBookMark = 14
      Case cptsProspectFindSource
         sProc = "pts_Prospect_FindUnassignedSource"
         MaxBookMark = 30
      Case cptsProspectFindRepresenting
         sProc = "pts_Prospect_FindUnassignedRepresenting"
         MaxBookMark = 30
      Case cptsProspectFindProspectID
         sProc = "pts_Prospect_FindUnassignedProspectID"
         MaxBookMark = 20
      Case cptsProspectFindEmail
         sProc = "pts_Prospect_FindUnassignedEmail"
         MaxBookMark = 90
      Case cptsProspectFindPhone1
         sProc = "pts_Prospect_FindUnassignedPhone1"
         MaxBookMark = 40
      Case cptsProspectFindLeadCampaignID
         sProc = "pts_Prospect_FindUnassignedLeadCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindSalesCampaignID
         sProc = "pts_Prospect_FindUnassignedSalesCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindDescription
         sProc = "pts_Prospect_FindUnassignedDescription"
         MaxBookMark = 2010
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
               vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.SalesCampaignID = moUtil.FetchLong(.Fields.Item("SalesCampaignID").Value)
               vRec.LeadCampaignID = moUtil.FetchLong(.Fields.Item("LeadCampaignID").Value)
               vRec.PresentID = moUtil.FetchLong(.Fields.Item("PresentID").Value)
               vRec.ProspectTypeID = moUtil.FetchLong(.Fields.Item("ProspectTypeID").Value)
               vRec.EmailID = moUtil.FetchLong(.Fields.Item("EmailID").Value)
               vRec.AffiliateID = moUtil.FetchLong(.Fields.Item("AffiliateID").Value)
               vRec.NewsLetterID = moUtil.FetchLong(.Fields.Item("NewsLetterID").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.StatusName = moUtil.FetchString(.Fields.Item("StatusName").Value)
               vRec.IsBoard = moUtil.FetchString(.Fields.Item("IsBoard").Value)
               vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
               vRec.ProspectTypeName = moUtil.FetchString(.Fields.Item("ProspectTypeName").Value)
               vRec.IsCopyURL = moUtil.FetchInteger(.Fields.Item("IsCopyURL").Value)
               vRec.Result = moUtil.FetchString(.Fields.Item("Result").Value)
               vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
               vRec.Website = moUtil.FetchString(.Fields.Item("Website").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Representing = moUtil.FetchString(.Fields.Item("Representing").Value)
               vRec.Potential = moUtil.FetchCurrency(.Fields.Item("Potential").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.ContactName = moUtil.FetchString(.Fields.Item("ContactName").Value)
               vRec.Title = moUtil.FetchString(.Fields.Item("Title").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.NextEvent = moUtil.FetchLong(.Fields.Item("NextEvent").Value)
               vRec.NextDate = moUtil.FetchDate(.Fields.Item("NextDate").Value)
               vRec.NextTime = moUtil.FetchString(.Fields.Item("NextTime").Value)
               vRec.CreateDate = moUtil.FetchDate(.Fields.Item("CreateDate").Value)
               vRec.FBDate = moUtil.FetchDate(.Fields.Item("FBDate").Value)
               vRec.CloseDate = moUtil.FetchDate(.Fields.Item("CloseDate").Value)
               vRec.DeadDate = moUtil.FetchDate(.Fields.Item("DeadDate").Value)
               vRec.Date1 = moUtil.FetchDate(.Fields.Item("Date1").Value)
               vRec.Date2 = moUtil.FetchDate(.Fields.Item("Date2").Value)
               vRec.Date3 = moUtil.FetchDate(.Fields.Item("Date3").Value)
               vRec.Date4 = moUtil.FetchDate(.Fields.Item("Date4").Value)
               vRec.Date5 = moUtil.FetchDate(.Fields.Item("Date5").Value)
               vRec.Date6 = moUtil.FetchDate(.Fields.Item("Date6").Value)
               vRec.Date7 = moUtil.FetchDate(.Fields.Item("Date7").Value)
               vRec.Date8 = moUtil.FetchDate(.Fields.Item("Date8").Value)
               vRec.Date9 = moUtil.FetchDate(.Fields.Item("Date9").Value)
               vRec.Date10 = moUtil.FetchDate(.Fields.Item("Date10").Value)
               vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
               vRec.ChangeStatus = moUtil.FetchLong(.Fields.Item("ChangeStatus").Value)
               vRec.EmailDate = moUtil.FetchDate(.Fields.Item("EmailDate").Value)
               vRec.RSVP = moUtil.FetchLong(.Fields.Item("RSVP").Value)
               vRec.EmailStatus = moUtil.FetchLong(.Fields.Item("EmailStatus").Value)
               vRec.LeadViews = moUtil.FetchLong(.Fields.Item("LeadViews").Value)
               vRec.LeadPages = moUtil.FetchString(.Fields.Item("LeadPages").Value)
               vRec.LeadReplies = moUtil.FetchLong(.Fields.Item("LeadReplies").Value)
               vRec.PresentViews = moUtil.FetchLong(.Fields.Item("PresentViews").Value)
               vRec.PresentPages = moUtil.FetchString(.Fields.Item("PresentPages").Value)
               vRec.NoDistribute = moUtil.FetchInteger(.Fields.Item("NoDistribute").Value)
               vRec.DistributorID = moUtil.FetchLong(.Fields.Item("DistributorID").Value)
               vRec.DistributeDate = moUtil.FetchDate(.Fields.Item("DistributeDate").Value)
               vRec.Priority = moUtil.FetchString(.Fields.Item("Priority").Value)
               vRec.InputValues = moUtil.FetchString(.Fields.Item("InputValues").Value)
               vRec.Source = moUtil.FetchString(.Fields.Item("Source").Value)
               vRec.Code = moUtil.FetchLong(.Fields.Item("Code").Value)
               vRec.Reminder = moUtil.FetchLong(.Fields.Item("Reminder").Value)
               vRec.RemindDate = moUtil.FetchDate(.Fields.Item("RemindDate").Value)
               vRec.TimeZone = moUtil.FetchLong(.Fields.Item("TimeZone").Value)
               vRec.BestTime = moUtil.FetchLong(.Fields.Item("BestTime").Value)
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
   FindUnassigned = vRecs

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
   Optional ByVal bvSecurityToken As Long = 0) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindCompany"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
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
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsProspectFindProspectName
         sProc = "pts_Prospect_FindCompanyProspectName"
         MaxBookMark = 70
      Case cptsProspectFindContactName
         sProc = "pts_Prospect_FindCompanyContactName"
         MaxBookMark = 72
      Case cptsProspectFindCreateDate
         sProc = "pts_Prospect_FindCompanyCreateDate"
         MaxBookMark = 30
      Case cptsProspectFindPriority
         sProc = "pts_Prospect_FindCompanyPriority"
         MaxBookMark = 14
      Case cptsProspectFindSource
         sProc = "pts_Prospect_FindCompanySource"
         MaxBookMark = 30
      Case cptsProspectFindRepresenting
         sProc = "pts_Prospect_FindCompanyRepresenting"
         MaxBookMark = 30
      Case cptsProspectFindProspectID
         sProc = "pts_Prospect_FindCompanyProspectID"
         MaxBookMark = 20
      Case cptsProspectFindEmail
         sProc = "pts_Prospect_FindCompanyEmail"
         MaxBookMark = 90
      Case cptsProspectFindPhone1
         sProc = "pts_Prospect_FindCompanyPhone1"
         MaxBookMark = 40
      Case cptsProspectFindLeadCampaignID
         sProc = "pts_Prospect_FindCompanyLeadCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindSalesCampaignID
         sProc = "pts_Prospect_FindCompanySalesCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindDescription
         sProc = "pts_Prospect_FindCompanyDescription"
         MaxBookMark = 2010
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
               vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.SalesCampaignID = moUtil.FetchLong(.Fields.Item("SalesCampaignID").Value)
               vRec.LeadCampaignID = moUtil.FetchLong(.Fields.Item("LeadCampaignID").Value)
               vRec.PresentID = moUtil.FetchLong(.Fields.Item("PresentID").Value)
               vRec.ProspectTypeID = moUtil.FetchLong(.Fields.Item("ProspectTypeID").Value)
               vRec.EmailID = moUtil.FetchLong(.Fields.Item("EmailID").Value)
               vRec.AffiliateID = moUtil.FetchLong(.Fields.Item("AffiliateID").Value)
               vRec.NewsLetterID = moUtil.FetchLong(.Fields.Item("NewsLetterID").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.StatusName = moUtil.FetchString(.Fields.Item("StatusName").Value)
               vRec.IsBoard = moUtil.FetchString(.Fields.Item("IsBoard").Value)
               vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
               vRec.ProspectTypeName = moUtil.FetchString(.Fields.Item("ProspectTypeName").Value)
               vRec.IsCopyURL = moUtil.FetchInteger(.Fields.Item("IsCopyURL").Value)
               vRec.Result = moUtil.FetchString(.Fields.Item("Result").Value)
               vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
               vRec.Website = moUtil.FetchString(.Fields.Item("Website").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Representing = moUtil.FetchString(.Fields.Item("Representing").Value)
               vRec.Potential = moUtil.FetchCurrency(.Fields.Item("Potential").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.ContactName = moUtil.FetchString(.Fields.Item("ContactName").Value)
               vRec.Title = moUtil.FetchString(.Fields.Item("Title").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.NextEvent = moUtil.FetchLong(.Fields.Item("NextEvent").Value)
               vRec.NextDate = moUtil.FetchDate(.Fields.Item("NextDate").Value)
               vRec.NextTime = moUtil.FetchString(.Fields.Item("NextTime").Value)
               vRec.CreateDate = moUtil.FetchDate(.Fields.Item("CreateDate").Value)
               vRec.FBDate = moUtil.FetchDate(.Fields.Item("FBDate").Value)
               vRec.CloseDate = moUtil.FetchDate(.Fields.Item("CloseDate").Value)
               vRec.DeadDate = moUtil.FetchDate(.Fields.Item("DeadDate").Value)
               vRec.Date1 = moUtil.FetchDate(.Fields.Item("Date1").Value)
               vRec.Date2 = moUtil.FetchDate(.Fields.Item("Date2").Value)
               vRec.Date3 = moUtil.FetchDate(.Fields.Item("Date3").Value)
               vRec.Date4 = moUtil.FetchDate(.Fields.Item("Date4").Value)
               vRec.Date5 = moUtil.FetchDate(.Fields.Item("Date5").Value)
               vRec.Date6 = moUtil.FetchDate(.Fields.Item("Date6").Value)
               vRec.Date7 = moUtil.FetchDate(.Fields.Item("Date7").Value)
               vRec.Date8 = moUtil.FetchDate(.Fields.Item("Date8").Value)
               vRec.Date9 = moUtil.FetchDate(.Fields.Item("Date9").Value)
               vRec.Date10 = moUtil.FetchDate(.Fields.Item("Date10").Value)
               vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
               vRec.ChangeStatus = moUtil.FetchLong(.Fields.Item("ChangeStatus").Value)
               vRec.EmailDate = moUtil.FetchDate(.Fields.Item("EmailDate").Value)
               vRec.RSVP = moUtil.FetchLong(.Fields.Item("RSVP").Value)
               vRec.EmailStatus = moUtil.FetchLong(.Fields.Item("EmailStatus").Value)
               vRec.LeadViews = moUtil.FetchLong(.Fields.Item("LeadViews").Value)
               vRec.LeadPages = moUtil.FetchString(.Fields.Item("LeadPages").Value)
               vRec.LeadReplies = moUtil.FetchLong(.Fields.Item("LeadReplies").Value)
               vRec.PresentViews = moUtil.FetchLong(.Fields.Item("PresentViews").Value)
               vRec.PresentPages = moUtil.FetchString(.Fields.Item("PresentPages").Value)
               vRec.NoDistribute = moUtil.FetchInteger(.Fields.Item("NoDistribute").Value)
               vRec.DistributorID = moUtil.FetchLong(.Fields.Item("DistributorID").Value)
               vRec.DistributeDate = moUtil.FetchDate(.Fields.Item("DistributeDate").Value)
               vRec.Priority = moUtil.FetchString(.Fields.Item("Priority").Value)
               vRec.InputValues = moUtil.FetchString(.Fields.Item("InputValues").Value)
               vRec.Source = moUtil.FetchString(.Fields.Item("Source").Value)
               vRec.Code = moUtil.FetchLong(.Fields.Item("Code").Value)
               vRec.Reminder = moUtil.FetchLong(.Fields.Item("Reminder").Value)
               vRec.RemindDate = moUtil.FetchDate(.Fields.Item("RemindDate").Value)
               vRec.TimeZone = moUtil.FetchLong(.Fields.Item("TimeZone").Value)
               vRec.BestTime = moUtil.FetchLong(.Fields.Item("BestTime").Value)
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

Public Function FindCompanyStatus( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindCompanyStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
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
   bvStatus = moUtil.EditLong(bvStatus, "Status", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsProspectFindProspectName
         sProc = "pts_Prospect_FindCompanyStatusProspectName"
         MaxBookMark = 70
      Case cptsProspectFindContactName
         sProc = "pts_Prospect_FindCompanyStatusContactName"
         MaxBookMark = 72
      Case cptsProspectFindCreateDate
         sProc = "pts_Prospect_FindCompanyStatusCreateDate"
         MaxBookMark = 30
      Case cptsProspectFindPriority
         sProc = "pts_Prospect_FindCompanyStatusPriority"
         MaxBookMark = 14
      Case cptsProspectFindSource
         sProc = "pts_Prospect_FindCompanyStatusSource"
         MaxBookMark = 30
      Case cptsProspectFindRepresenting
         sProc = "pts_Prospect_FindCompanyStatusRepresenting"
         MaxBookMark = 30
      Case cptsProspectFindProspectID
         sProc = "pts_Prospect_FindCompanyStatusProspectID"
         MaxBookMark = 20
      Case cptsProspectFindEmail
         sProc = "pts_Prospect_FindCompanyStatusEmail"
         MaxBookMark = 90
      Case cptsProspectFindPhone1
         sProc = "pts_Prospect_FindCompanyStatusPhone1"
         MaxBookMark = 40
      Case cptsProspectFindLeadCampaignID
         sProc = "pts_Prospect_FindCompanyStatusLeadCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindSalesCampaignID
         sProc = "pts_Prospect_FindCompanyStatusSalesCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindDescription
         sProc = "pts_Prospect_FindCompanyStatusDescription"
         MaxBookMark = 2010
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
               vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.SalesCampaignID = moUtil.FetchLong(.Fields.Item("SalesCampaignID").Value)
               vRec.LeadCampaignID = moUtil.FetchLong(.Fields.Item("LeadCampaignID").Value)
               vRec.PresentID = moUtil.FetchLong(.Fields.Item("PresentID").Value)
               vRec.ProspectTypeID = moUtil.FetchLong(.Fields.Item("ProspectTypeID").Value)
               vRec.EmailID = moUtil.FetchLong(.Fields.Item("EmailID").Value)
               vRec.AffiliateID = moUtil.FetchLong(.Fields.Item("AffiliateID").Value)
               vRec.NewsLetterID = moUtil.FetchLong(.Fields.Item("NewsLetterID").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.StatusName = moUtil.FetchString(.Fields.Item("StatusName").Value)
               vRec.IsBoard = moUtil.FetchString(.Fields.Item("IsBoard").Value)
               vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
               vRec.ProspectTypeName = moUtil.FetchString(.Fields.Item("ProspectTypeName").Value)
               vRec.IsCopyURL = moUtil.FetchInteger(.Fields.Item("IsCopyURL").Value)
               vRec.Result = moUtil.FetchString(.Fields.Item("Result").Value)
               vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
               vRec.Website = moUtil.FetchString(.Fields.Item("Website").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Representing = moUtil.FetchString(.Fields.Item("Representing").Value)
               vRec.Potential = moUtil.FetchCurrency(.Fields.Item("Potential").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.ContactName = moUtil.FetchString(.Fields.Item("ContactName").Value)
               vRec.Title = moUtil.FetchString(.Fields.Item("Title").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.NextEvent = moUtil.FetchLong(.Fields.Item("NextEvent").Value)
               vRec.NextDate = moUtil.FetchDate(.Fields.Item("NextDate").Value)
               vRec.NextTime = moUtil.FetchString(.Fields.Item("NextTime").Value)
               vRec.CreateDate = moUtil.FetchDate(.Fields.Item("CreateDate").Value)
               vRec.FBDate = moUtil.FetchDate(.Fields.Item("FBDate").Value)
               vRec.CloseDate = moUtil.FetchDate(.Fields.Item("CloseDate").Value)
               vRec.DeadDate = moUtil.FetchDate(.Fields.Item("DeadDate").Value)
               vRec.Date1 = moUtil.FetchDate(.Fields.Item("Date1").Value)
               vRec.Date2 = moUtil.FetchDate(.Fields.Item("Date2").Value)
               vRec.Date3 = moUtil.FetchDate(.Fields.Item("Date3").Value)
               vRec.Date4 = moUtil.FetchDate(.Fields.Item("Date4").Value)
               vRec.Date5 = moUtil.FetchDate(.Fields.Item("Date5").Value)
               vRec.Date6 = moUtil.FetchDate(.Fields.Item("Date6").Value)
               vRec.Date7 = moUtil.FetchDate(.Fields.Item("Date7").Value)
               vRec.Date8 = moUtil.FetchDate(.Fields.Item("Date8").Value)
               vRec.Date9 = moUtil.FetchDate(.Fields.Item("Date9").Value)
               vRec.Date10 = moUtil.FetchDate(.Fields.Item("Date10").Value)
               vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
               vRec.ChangeStatus = moUtil.FetchLong(.Fields.Item("ChangeStatus").Value)
               vRec.EmailDate = moUtil.FetchDate(.Fields.Item("EmailDate").Value)
               vRec.RSVP = moUtil.FetchLong(.Fields.Item("RSVP").Value)
               vRec.EmailStatus = moUtil.FetchLong(.Fields.Item("EmailStatus").Value)
               vRec.LeadViews = moUtil.FetchLong(.Fields.Item("LeadViews").Value)
               vRec.LeadPages = moUtil.FetchString(.Fields.Item("LeadPages").Value)
               vRec.LeadReplies = moUtil.FetchLong(.Fields.Item("LeadReplies").Value)
               vRec.PresentViews = moUtil.FetchLong(.Fields.Item("PresentViews").Value)
               vRec.PresentPages = moUtil.FetchString(.Fields.Item("PresentPages").Value)
               vRec.NoDistribute = moUtil.FetchInteger(.Fields.Item("NoDistribute").Value)
               vRec.DistributorID = moUtil.FetchLong(.Fields.Item("DistributorID").Value)
               vRec.DistributeDate = moUtil.FetchDate(.Fields.Item("DistributeDate").Value)
               vRec.Priority = moUtil.FetchString(.Fields.Item("Priority").Value)
               vRec.InputValues = moUtil.FetchString(.Fields.Item("InputValues").Value)
               vRec.Source = moUtil.FetchString(.Fields.Item("Source").Value)
               vRec.Code = moUtil.FetchLong(.Fields.Item("Code").Value)
               vRec.Reminder = moUtil.FetchLong(.Fields.Item("Reminder").Value)
               vRec.RemindDate = moUtil.FetchDate(.Fields.Item("RemindDate").Value)
               vRec.TimeZone = moUtil.FetchLong(.Fields.Item("TimeZone").Value)
               vRec.BestTime = moUtil.FetchLong(.Fields.Item("BestTime").Value)
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

Public Function FindCompanyActive( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindCompanyActive"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
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
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsProspectFindProspectName
         sProc = "pts_Prospect_FindCompanyActiveProspectName"
         MaxBookMark = 70
      Case cptsProspectFindContactName
         sProc = "pts_Prospect_FindCompanyActiveContactName"
         MaxBookMark = 72
      Case cptsProspectFindCreateDate
         sProc = "pts_Prospect_FindCompanyActiveCreateDate"
         MaxBookMark = 30
      Case cptsProspectFindPriority
         sProc = "pts_Prospect_FindCompanyActivePriority"
         MaxBookMark = 14
      Case cptsProspectFindSource
         sProc = "pts_Prospect_FindCompanyActiveSource"
         MaxBookMark = 30
      Case cptsProspectFindRepresenting
         sProc = "pts_Prospect_FindCompanyActiveRepresenting"
         MaxBookMark = 30
      Case cptsProspectFindProspectID
         sProc = "pts_Prospect_FindCompanyActiveProspectID"
         MaxBookMark = 20
      Case cptsProspectFindEmail
         sProc = "pts_Prospect_FindCompanyActiveEmail"
         MaxBookMark = 90
      Case cptsProspectFindPhone1
         sProc = "pts_Prospect_FindCompanyActivePhone1"
         MaxBookMark = 40
      Case cptsProspectFindLeadCampaignID
         sProc = "pts_Prospect_FindCompanyActiveLeadCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindSalesCampaignID
         sProc = "pts_Prospect_FindCompanyActiveSalesCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindDescription
         sProc = "pts_Prospect_FindCompanyActiveDescription"
         MaxBookMark = 2010
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
               vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.SalesCampaignID = moUtil.FetchLong(.Fields.Item("SalesCampaignID").Value)
               vRec.LeadCampaignID = moUtil.FetchLong(.Fields.Item("LeadCampaignID").Value)
               vRec.PresentID = moUtil.FetchLong(.Fields.Item("PresentID").Value)
               vRec.ProspectTypeID = moUtil.FetchLong(.Fields.Item("ProspectTypeID").Value)
               vRec.EmailID = moUtil.FetchLong(.Fields.Item("EmailID").Value)
               vRec.AffiliateID = moUtil.FetchLong(.Fields.Item("AffiliateID").Value)
               vRec.NewsLetterID = moUtil.FetchLong(.Fields.Item("NewsLetterID").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.StatusName = moUtil.FetchString(.Fields.Item("StatusName").Value)
               vRec.IsBoard = moUtil.FetchString(.Fields.Item("IsBoard").Value)
               vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
               vRec.ProspectTypeName = moUtil.FetchString(.Fields.Item("ProspectTypeName").Value)
               vRec.IsCopyURL = moUtil.FetchInteger(.Fields.Item("IsCopyURL").Value)
               vRec.Result = moUtil.FetchString(.Fields.Item("Result").Value)
               vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
               vRec.Website = moUtil.FetchString(.Fields.Item("Website").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Representing = moUtil.FetchString(.Fields.Item("Representing").Value)
               vRec.Potential = moUtil.FetchCurrency(.Fields.Item("Potential").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.ContactName = moUtil.FetchString(.Fields.Item("ContactName").Value)
               vRec.Title = moUtil.FetchString(.Fields.Item("Title").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.NextEvent = moUtil.FetchLong(.Fields.Item("NextEvent").Value)
               vRec.NextDate = moUtil.FetchDate(.Fields.Item("NextDate").Value)
               vRec.NextTime = moUtil.FetchString(.Fields.Item("NextTime").Value)
               vRec.CreateDate = moUtil.FetchDate(.Fields.Item("CreateDate").Value)
               vRec.FBDate = moUtil.FetchDate(.Fields.Item("FBDate").Value)
               vRec.CloseDate = moUtil.FetchDate(.Fields.Item("CloseDate").Value)
               vRec.DeadDate = moUtil.FetchDate(.Fields.Item("DeadDate").Value)
               vRec.Date1 = moUtil.FetchDate(.Fields.Item("Date1").Value)
               vRec.Date2 = moUtil.FetchDate(.Fields.Item("Date2").Value)
               vRec.Date3 = moUtil.FetchDate(.Fields.Item("Date3").Value)
               vRec.Date4 = moUtil.FetchDate(.Fields.Item("Date4").Value)
               vRec.Date5 = moUtil.FetchDate(.Fields.Item("Date5").Value)
               vRec.Date6 = moUtil.FetchDate(.Fields.Item("Date6").Value)
               vRec.Date7 = moUtil.FetchDate(.Fields.Item("Date7").Value)
               vRec.Date8 = moUtil.FetchDate(.Fields.Item("Date8").Value)
               vRec.Date9 = moUtil.FetchDate(.Fields.Item("Date9").Value)
               vRec.Date10 = moUtil.FetchDate(.Fields.Item("Date10").Value)
               vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
               vRec.ChangeStatus = moUtil.FetchLong(.Fields.Item("ChangeStatus").Value)
               vRec.EmailDate = moUtil.FetchDate(.Fields.Item("EmailDate").Value)
               vRec.RSVP = moUtil.FetchLong(.Fields.Item("RSVP").Value)
               vRec.EmailStatus = moUtil.FetchLong(.Fields.Item("EmailStatus").Value)
               vRec.LeadViews = moUtil.FetchLong(.Fields.Item("LeadViews").Value)
               vRec.LeadPages = moUtil.FetchString(.Fields.Item("LeadPages").Value)
               vRec.LeadReplies = moUtil.FetchLong(.Fields.Item("LeadReplies").Value)
               vRec.PresentViews = moUtil.FetchLong(.Fields.Item("PresentViews").Value)
               vRec.PresentPages = moUtil.FetchString(.Fields.Item("PresentPages").Value)
               vRec.NoDistribute = moUtil.FetchInteger(.Fields.Item("NoDistribute").Value)
               vRec.DistributorID = moUtil.FetchLong(.Fields.Item("DistributorID").Value)
               vRec.DistributeDate = moUtil.FetchDate(.Fields.Item("DistributeDate").Value)
               vRec.Priority = moUtil.FetchString(.Fields.Item("Priority").Value)
               vRec.InputValues = moUtil.FetchString(.Fields.Item("InputValues").Value)
               vRec.Source = moUtil.FetchString(.Fields.Item("Source").Value)
               vRec.Code = moUtil.FetchLong(.Fields.Item("Code").Value)
               vRec.Reminder = moUtil.FetchLong(.Fields.Item("Reminder").Value)
               vRec.RemindDate = moUtil.FetchDate(.Fields.Item("RemindDate").Value)
               vRec.TimeZone = moUtil.FetchLong(.Fields.Item("TimeZone").Value)
               vRec.BestTime = moUtil.FetchLong(.Fields.Item("BestTime").Value)
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
   FindCompanyActive = vRecs

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

Public Function FindCompanyLive( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindCompanyLive"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
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
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsProspectFindProspectName
         sProc = "pts_Prospect_FindCompanyLiveProspectName"
         MaxBookMark = 70
      Case cptsProspectFindContactName
         sProc = "pts_Prospect_FindCompanyLiveContactName"
         MaxBookMark = 72
      Case cptsProspectFindCreateDate
         sProc = "pts_Prospect_FindCompanyLiveCreateDate"
         MaxBookMark = 30
      Case cptsProspectFindPriority
         sProc = "pts_Prospect_FindCompanyLivePriority"
         MaxBookMark = 14
      Case cptsProspectFindSource
         sProc = "pts_Prospect_FindCompanyLiveSource"
         MaxBookMark = 30
      Case cptsProspectFindRepresenting
         sProc = "pts_Prospect_FindCompanyLiveRepresenting"
         MaxBookMark = 30
      Case cptsProspectFindProspectID
         sProc = "pts_Prospect_FindCompanyLiveProspectID"
         MaxBookMark = 20
      Case cptsProspectFindEmail
         sProc = "pts_Prospect_FindCompanyLiveEmail"
         MaxBookMark = 90
      Case cptsProspectFindPhone1
         sProc = "pts_Prospect_FindCompanyLivePhone1"
         MaxBookMark = 40
      Case cptsProspectFindLeadCampaignID
         sProc = "pts_Prospect_FindCompanyLiveLeadCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindSalesCampaignID
         sProc = "pts_Prospect_FindCompanyLiveSalesCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindDescription
         sProc = "pts_Prospect_FindCompanyLiveDescription"
         MaxBookMark = 2010
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
               vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.SalesCampaignID = moUtil.FetchLong(.Fields.Item("SalesCampaignID").Value)
               vRec.LeadCampaignID = moUtil.FetchLong(.Fields.Item("LeadCampaignID").Value)
               vRec.PresentID = moUtil.FetchLong(.Fields.Item("PresentID").Value)
               vRec.ProspectTypeID = moUtil.FetchLong(.Fields.Item("ProspectTypeID").Value)
               vRec.EmailID = moUtil.FetchLong(.Fields.Item("EmailID").Value)
               vRec.AffiliateID = moUtil.FetchLong(.Fields.Item("AffiliateID").Value)
               vRec.NewsLetterID = moUtil.FetchLong(.Fields.Item("NewsLetterID").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.StatusName = moUtil.FetchString(.Fields.Item("StatusName").Value)
               vRec.IsBoard = moUtil.FetchString(.Fields.Item("IsBoard").Value)
               vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
               vRec.ProspectTypeName = moUtil.FetchString(.Fields.Item("ProspectTypeName").Value)
               vRec.IsCopyURL = moUtil.FetchInteger(.Fields.Item("IsCopyURL").Value)
               vRec.Result = moUtil.FetchString(.Fields.Item("Result").Value)
               vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
               vRec.Website = moUtil.FetchString(.Fields.Item("Website").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Representing = moUtil.FetchString(.Fields.Item("Representing").Value)
               vRec.Potential = moUtil.FetchCurrency(.Fields.Item("Potential").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.ContactName = moUtil.FetchString(.Fields.Item("ContactName").Value)
               vRec.Title = moUtil.FetchString(.Fields.Item("Title").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.NextEvent = moUtil.FetchLong(.Fields.Item("NextEvent").Value)
               vRec.NextDate = moUtil.FetchDate(.Fields.Item("NextDate").Value)
               vRec.NextTime = moUtil.FetchString(.Fields.Item("NextTime").Value)
               vRec.CreateDate = moUtil.FetchDate(.Fields.Item("CreateDate").Value)
               vRec.FBDate = moUtil.FetchDate(.Fields.Item("FBDate").Value)
               vRec.CloseDate = moUtil.FetchDate(.Fields.Item("CloseDate").Value)
               vRec.DeadDate = moUtil.FetchDate(.Fields.Item("DeadDate").Value)
               vRec.Date1 = moUtil.FetchDate(.Fields.Item("Date1").Value)
               vRec.Date2 = moUtil.FetchDate(.Fields.Item("Date2").Value)
               vRec.Date3 = moUtil.FetchDate(.Fields.Item("Date3").Value)
               vRec.Date4 = moUtil.FetchDate(.Fields.Item("Date4").Value)
               vRec.Date5 = moUtil.FetchDate(.Fields.Item("Date5").Value)
               vRec.Date6 = moUtil.FetchDate(.Fields.Item("Date6").Value)
               vRec.Date7 = moUtil.FetchDate(.Fields.Item("Date7").Value)
               vRec.Date8 = moUtil.FetchDate(.Fields.Item("Date8").Value)
               vRec.Date9 = moUtil.FetchDate(.Fields.Item("Date9").Value)
               vRec.Date10 = moUtil.FetchDate(.Fields.Item("Date10").Value)
               vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
               vRec.ChangeStatus = moUtil.FetchLong(.Fields.Item("ChangeStatus").Value)
               vRec.EmailDate = moUtil.FetchDate(.Fields.Item("EmailDate").Value)
               vRec.RSVP = moUtil.FetchLong(.Fields.Item("RSVP").Value)
               vRec.EmailStatus = moUtil.FetchLong(.Fields.Item("EmailStatus").Value)
               vRec.LeadViews = moUtil.FetchLong(.Fields.Item("LeadViews").Value)
               vRec.LeadPages = moUtil.FetchString(.Fields.Item("LeadPages").Value)
               vRec.LeadReplies = moUtil.FetchLong(.Fields.Item("LeadReplies").Value)
               vRec.PresentViews = moUtil.FetchLong(.Fields.Item("PresentViews").Value)
               vRec.PresentPages = moUtil.FetchString(.Fields.Item("PresentPages").Value)
               vRec.NoDistribute = moUtil.FetchInteger(.Fields.Item("NoDistribute").Value)
               vRec.DistributorID = moUtil.FetchLong(.Fields.Item("DistributorID").Value)
               vRec.DistributeDate = moUtil.FetchDate(.Fields.Item("DistributeDate").Value)
               vRec.Priority = moUtil.FetchString(.Fields.Item("Priority").Value)
               vRec.InputValues = moUtil.FetchString(.Fields.Item("InputValues").Value)
               vRec.Source = moUtil.FetchString(.Fields.Item("Source").Value)
               vRec.Code = moUtil.FetchLong(.Fields.Item("Code").Value)
               vRec.Reminder = moUtil.FetchLong(.Fields.Item("Reminder").Value)
               vRec.RemindDate = moUtil.FetchDate(.Fields.Item("RemindDate").Value)
               vRec.TimeZone = moUtil.FetchLong(.Fields.Item("TimeZone").Value)
               vRec.BestTime = moUtil.FetchLong(.Fields.Item("BestTime").Value)
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
   FindCompanyLive = vRecs

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
   Optional ByVal bvSecurityToken As Long = 0) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
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
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsProspectFindProspectName
         sProc = "pts_Prospect_FindMemberProspectName"
         MaxBookMark = 70
      Case cptsProspectFindContactName
         sProc = "pts_Prospect_FindMemberContactName"
         MaxBookMark = 72
      Case cptsProspectFindCreateDate
         sProc = "pts_Prospect_FindMemberCreateDate"
         MaxBookMark = 30
      Case cptsProspectFindPriority
         sProc = "pts_Prospect_FindMemberPriority"
         MaxBookMark = 14
      Case cptsProspectFindSource
         sProc = "pts_Prospect_FindMemberSource"
         MaxBookMark = 30
      Case cptsProspectFindRepresenting
         sProc = "pts_Prospect_FindMemberRepresenting"
         MaxBookMark = 30
      Case cptsProspectFindProspectID
         sProc = "pts_Prospect_FindMemberProspectID"
         MaxBookMark = 20
      Case cptsProspectFindEmail
         sProc = "pts_Prospect_FindMemberEmail"
         MaxBookMark = 90
      Case cptsProspectFindPhone1
         sProc = "pts_Prospect_FindMemberPhone1"
         MaxBookMark = 40
      Case cptsProspectFindLeadCampaignID
         sProc = "pts_Prospect_FindMemberLeadCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindSalesCampaignID
         sProc = "pts_Prospect_FindMemberSalesCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindDescription
         sProc = "pts_Prospect_FindMemberDescription"
         MaxBookMark = 2010
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
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
               vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.SalesCampaignID = moUtil.FetchLong(.Fields.Item("SalesCampaignID").Value)
               vRec.LeadCampaignID = moUtil.FetchLong(.Fields.Item("LeadCampaignID").Value)
               vRec.PresentID = moUtil.FetchLong(.Fields.Item("PresentID").Value)
               vRec.ProspectTypeID = moUtil.FetchLong(.Fields.Item("ProspectTypeID").Value)
               vRec.EmailID = moUtil.FetchLong(.Fields.Item("EmailID").Value)
               vRec.AffiliateID = moUtil.FetchLong(.Fields.Item("AffiliateID").Value)
               vRec.NewsLetterID = moUtil.FetchLong(.Fields.Item("NewsLetterID").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.StatusName = moUtil.FetchString(.Fields.Item("StatusName").Value)
               vRec.IsBoard = moUtil.FetchString(.Fields.Item("IsBoard").Value)
               vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
               vRec.ProspectTypeName = moUtil.FetchString(.Fields.Item("ProspectTypeName").Value)
               vRec.IsCopyURL = moUtil.FetchInteger(.Fields.Item("IsCopyURL").Value)
               vRec.Result = moUtil.FetchString(.Fields.Item("Result").Value)
               vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
               vRec.Website = moUtil.FetchString(.Fields.Item("Website").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Representing = moUtil.FetchString(.Fields.Item("Representing").Value)
               vRec.Potential = moUtil.FetchCurrency(.Fields.Item("Potential").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.ContactName = moUtil.FetchString(.Fields.Item("ContactName").Value)
               vRec.Title = moUtil.FetchString(.Fields.Item("Title").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.NextEvent = moUtil.FetchLong(.Fields.Item("NextEvent").Value)
               vRec.NextDate = moUtil.FetchDate(.Fields.Item("NextDate").Value)
               vRec.NextTime = moUtil.FetchString(.Fields.Item("NextTime").Value)
               vRec.CreateDate = moUtil.FetchDate(.Fields.Item("CreateDate").Value)
               vRec.FBDate = moUtil.FetchDate(.Fields.Item("FBDate").Value)
               vRec.CloseDate = moUtil.FetchDate(.Fields.Item("CloseDate").Value)
               vRec.DeadDate = moUtil.FetchDate(.Fields.Item("DeadDate").Value)
               vRec.Date1 = moUtil.FetchDate(.Fields.Item("Date1").Value)
               vRec.Date2 = moUtil.FetchDate(.Fields.Item("Date2").Value)
               vRec.Date3 = moUtil.FetchDate(.Fields.Item("Date3").Value)
               vRec.Date4 = moUtil.FetchDate(.Fields.Item("Date4").Value)
               vRec.Date5 = moUtil.FetchDate(.Fields.Item("Date5").Value)
               vRec.Date6 = moUtil.FetchDate(.Fields.Item("Date6").Value)
               vRec.Date7 = moUtil.FetchDate(.Fields.Item("Date7").Value)
               vRec.Date8 = moUtil.FetchDate(.Fields.Item("Date8").Value)
               vRec.Date9 = moUtil.FetchDate(.Fields.Item("Date9").Value)
               vRec.Date10 = moUtil.FetchDate(.Fields.Item("Date10").Value)
               vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
               vRec.ChangeStatus = moUtil.FetchLong(.Fields.Item("ChangeStatus").Value)
               vRec.EmailDate = moUtil.FetchDate(.Fields.Item("EmailDate").Value)
               vRec.RSVP = moUtil.FetchLong(.Fields.Item("RSVP").Value)
               vRec.EmailStatus = moUtil.FetchLong(.Fields.Item("EmailStatus").Value)
               vRec.LeadViews = moUtil.FetchLong(.Fields.Item("LeadViews").Value)
               vRec.LeadPages = moUtil.FetchString(.Fields.Item("LeadPages").Value)
               vRec.LeadReplies = moUtil.FetchLong(.Fields.Item("LeadReplies").Value)
               vRec.PresentViews = moUtil.FetchLong(.Fields.Item("PresentViews").Value)
               vRec.PresentPages = moUtil.FetchString(.Fields.Item("PresentPages").Value)
               vRec.NoDistribute = moUtil.FetchInteger(.Fields.Item("NoDistribute").Value)
               vRec.DistributorID = moUtil.FetchLong(.Fields.Item("DistributorID").Value)
               vRec.DistributeDate = moUtil.FetchDate(.Fields.Item("DistributeDate").Value)
               vRec.Priority = moUtil.FetchString(.Fields.Item("Priority").Value)
               vRec.InputValues = moUtil.FetchString(.Fields.Item("InputValues").Value)
               vRec.Source = moUtil.FetchString(.Fields.Item("Source").Value)
               vRec.Code = moUtil.FetchLong(.Fields.Item("Code").Value)
               vRec.Reminder = moUtil.FetchLong(.Fields.Item("Reminder").Value)
               vRec.RemindDate = moUtil.FetchDate(.Fields.Item("RemindDate").Value)
               vRec.TimeZone = moUtil.FetchLong(.Fields.Item("TimeZone").Value)
               vRec.BestTime = moUtil.FetchLong(.Fields.Item("BestTime").Value)
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

Public Function FindMemberStatus( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindMemberStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
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
   bvStatus = moUtil.EditLong(bvStatus, "Status", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsProspectFindProspectName
         sProc = "pts_Prospect_FindMemberStatusProspectName"
         MaxBookMark = 70
      Case cptsProspectFindContactName
         sProc = "pts_Prospect_FindMemberStatusContactName"
         MaxBookMark = 72
      Case cptsProspectFindCreateDate
         sProc = "pts_Prospect_FindMemberStatusCreateDate"
         MaxBookMark = 30
      Case cptsProspectFindPriority
         sProc = "pts_Prospect_FindMemberStatusPriority"
         MaxBookMark = 14
      Case cptsProspectFindSource
         sProc = "pts_Prospect_FindMemberStatusSource"
         MaxBookMark = 30
      Case cptsProspectFindRepresenting
         sProc = "pts_Prospect_FindMemberStatusRepresenting"
         MaxBookMark = 30
      Case cptsProspectFindProspectID
         sProc = "pts_Prospect_FindMemberStatusProspectID"
         MaxBookMark = 20
      Case cptsProspectFindEmail
         sProc = "pts_Prospect_FindMemberStatusEmail"
         MaxBookMark = 90
      Case cptsProspectFindPhone1
         sProc = "pts_Prospect_FindMemberStatusPhone1"
         MaxBookMark = 40
      Case cptsProspectFindLeadCampaignID
         sProc = "pts_Prospect_FindMemberStatusLeadCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindSalesCampaignID
         sProc = "pts_Prospect_FindMemberStatusSalesCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindDescription
         sProc = "pts_Prospect_FindMemberStatusDescription"
         MaxBookMark = 2010
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
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
               vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.SalesCampaignID = moUtil.FetchLong(.Fields.Item("SalesCampaignID").Value)
               vRec.LeadCampaignID = moUtil.FetchLong(.Fields.Item("LeadCampaignID").Value)
               vRec.PresentID = moUtil.FetchLong(.Fields.Item("PresentID").Value)
               vRec.ProspectTypeID = moUtil.FetchLong(.Fields.Item("ProspectTypeID").Value)
               vRec.EmailID = moUtil.FetchLong(.Fields.Item("EmailID").Value)
               vRec.AffiliateID = moUtil.FetchLong(.Fields.Item("AffiliateID").Value)
               vRec.NewsLetterID = moUtil.FetchLong(.Fields.Item("NewsLetterID").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.StatusName = moUtil.FetchString(.Fields.Item("StatusName").Value)
               vRec.IsBoard = moUtil.FetchString(.Fields.Item("IsBoard").Value)
               vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
               vRec.ProspectTypeName = moUtil.FetchString(.Fields.Item("ProspectTypeName").Value)
               vRec.IsCopyURL = moUtil.FetchInteger(.Fields.Item("IsCopyURL").Value)
               vRec.Result = moUtil.FetchString(.Fields.Item("Result").Value)
               vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
               vRec.Website = moUtil.FetchString(.Fields.Item("Website").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Representing = moUtil.FetchString(.Fields.Item("Representing").Value)
               vRec.Potential = moUtil.FetchCurrency(.Fields.Item("Potential").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.ContactName = moUtil.FetchString(.Fields.Item("ContactName").Value)
               vRec.Title = moUtil.FetchString(.Fields.Item("Title").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.NextEvent = moUtil.FetchLong(.Fields.Item("NextEvent").Value)
               vRec.NextDate = moUtil.FetchDate(.Fields.Item("NextDate").Value)
               vRec.NextTime = moUtil.FetchString(.Fields.Item("NextTime").Value)
               vRec.CreateDate = moUtil.FetchDate(.Fields.Item("CreateDate").Value)
               vRec.FBDate = moUtil.FetchDate(.Fields.Item("FBDate").Value)
               vRec.CloseDate = moUtil.FetchDate(.Fields.Item("CloseDate").Value)
               vRec.DeadDate = moUtil.FetchDate(.Fields.Item("DeadDate").Value)
               vRec.Date1 = moUtil.FetchDate(.Fields.Item("Date1").Value)
               vRec.Date2 = moUtil.FetchDate(.Fields.Item("Date2").Value)
               vRec.Date3 = moUtil.FetchDate(.Fields.Item("Date3").Value)
               vRec.Date4 = moUtil.FetchDate(.Fields.Item("Date4").Value)
               vRec.Date5 = moUtil.FetchDate(.Fields.Item("Date5").Value)
               vRec.Date6 = moUtil.FetchDate(.Fields.Item("Date6").Value)
               vRec.Date7 = moUtil.FetchDate(.Fields.Item("Date7").Value)
               vRec.Date8 = moUtil.FetchDate(.Fields.Item("Date8").Value)
               vRec.Date9 = moUtil.FetchDate(.Fields.Item("Date9").Value)
               vRec.Date10 = moUtil.FetchDate(.Fields.Item("Date10").Value)
               vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
               vRec.ChangeStatus = moUtil.FetchLong(.Fields.Item("ChangeStatus").Value)
               vRec.EmailDate = moUtil.FetchDate(.Fields.Item("EmailDate").Value)
               vRec.RSVP = moUtil.FetchLong(.Fields.Item("RSVP").Value)
               vRec.EmailStatus = moUtil.FetchLong(.Fields.Item("EmailStatus").Value)
               vRec.LeadViews = moUtil.FetchLong(.Fields.Item("LeadViews").Value)
               vRec.LeadPages = moUtil.FetchString(.Fields.Item("LeadPages").Value)
               vRec.LeadReplies = moUtil.FetchLong(.Fields.Item("LeadReplies").Value)
               vRec.PresentViews = moUtil.FetchLong(.Fields.Item("PresentViews").Value)
               vRec.PresentPages = moUtil.FetchString(.Fields.Item("PresentPages").Value)
               vRec.NoDistribute = moUtil.FetchInteger(.Fields.Item("NoDistribute").Value)
               vRec.DistributorID = moUtil.FetchLong(.Fields.Item("DistributorID").Value)
               vRec.DistributeDate = moUtil.FetchDate(.Fields.Item("DistributeDate").Value)
               vRec.Priority = moUtil.FetchString(.Fields.Item("Priority").Value)
               vRec.InputValues = moUtil.FetchString(.Fields.Item("InputValues").Value)
               vRec.Source = moUtil.FetchString(.Fields.Item("Source").Value)
               vRec.Code = moUtil.FetchLong(.Fields.Item("Code").Value)
               vRec.Reminder = moUtil.FetchLong(.Fields.Item("Reminder").Value)
               vRec.RemindDate = moUtil.FetchDate(.Fields.Item("RemindDate").Value)
               vRec.TimeZone = moUtil.FetchLong(.Fields.Item("TimeZone").Value)
               vRec.BestTime = moUtil.FetchLong(.Fields.Item("BestTime").Value)
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
   FindMemberStatus = vRecs

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

Public Function FindMemberActive( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindMemberActive"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
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
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsProspectFindProspectName
         sProc = "pts_Prospect_FindMemberActiveProspectName"
         MaxBookMark = 70
      Case cptsProspectFindContactName
         sProc = "pts_Prospect_FindMemberActiveContactName"
         MaxBookMark = 72
      Case cptsProspectFindCreateDate
         sProc = "pts_Prospect_FindMemberActiveCreateDate"
         MaxBookMark = 30
      Case cptsProspectFindPriority
         sProc = "pts_Prospect_FindMemberActivePriority"
         MaxBookMark = 14
      Case cptsProspectFindSource
         sProc = "pts_Prospect_FindMemberActiveSource"
         MaxBookMark = 30
      Case cptsProspectFindRepresenting
         sProc = "pts_Prospect_FindMemberActiveRepresenting"
         MaxBookMark = 30
      Case cptsProspectFindProspectID
         sProc = "pts_Prospect_FindMemberActiveProspectID"
         MaxBookMark = 20
      Case cptsProspectFindEmail
         sProc = "pts_Prospect_FindMemberActiveEmail"
         MaxBookMark = 90
      Case cptsProspectFindPhone1
         sProc = "pts_Prospect_FindMemberActivePhone1"
         MaxBookMark = 40
      Case cptsProspectFindLeadCampaignID
         sProc = "pts_Prospect_FindMemberActiveLeadCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindSalesCampaignID
         sProc = "pts_Prospect_FindMemberActiveSalesCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindDescription
         sProc = "pts_Prospect_FindMemberActiveDescription"
         MaxBookMark = 2010
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
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
               vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.SalesCampaignID = moUtil.FetchLong(.Fields.Item("SalesCampaignID").Value)
               vRec.LeadCampaignID = moUtil.FetchLong(.Fields.Item("LeadCampaignID").Value)
               vRec.PresentID = moUtil.FetchLong(.Fields.Item("PresentID").Value)
               vRec.ProspectTypeID = moUtil.FetchLong(.Fields.Item("ProspectTypeID").Value)
               vRec.EmailID = moUtil.FetchLong(.Fields.Item("EmailID").Value)
               vRec.AffiliateID = moUtil.FetchLong(.Fields.Item("AffiliateID").Value)
               vRec.NewsLetterID = moUtil.FetchLong(.Fields.Item("NewsLetterID").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.StatusName = moUtil.FetchString(.Fields.Item("StatusName").Value)
               vRec.IsBoard = moUtil.FetchString(.Fields.Item("IsBoard").Value)
               vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
               vRec.ProspectTypeName = moUtil.FetchString(.Fields.Item("ProspectTypeName").Value)
               vRec.IsCopyURL = moUtil.FetchInteger(.Fields.Item("IsCopyURL").Value)
               vRec.Result = moUtil.FetchString(.Fields.Item("Result").Value)
               vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
               vRec.Website = moUtil.FetchString(.Fields.Item("Website").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Representing = moUtil.FetchString(.Fields.Item("Representing").Value)
               vRec.Potential = moUtil.FetchCurrency(.Fields.Item("Potential").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.ContactName = moUtil.FetchString(.Fields.Item("ContactName").Value)
               vRec.Title = moUtil.FetchString(.Fields.Item("Title").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.NextEvent = moUtil.FetchLong(.Fields.Item("NextEvent").Value)
               vRec.NextDate = moUtil.FetchDate(.Fields.Item("NextDate").Value)
               vRec.NextTime = moUtil.FetchString(.Fields.Item("NextTime").Value)
               vRec.CreateDate = moUtil.FetchDate(.Fields.Item("CreateDate").Value)
               vRec.FBDate = moUtil.FetchDate(.Fields.Item("FBDate").Value)
               vRec.CloseDate = moUtil.FetchDate(.Fields.Item("CloseDate").Value)
               vRec.DeadDate = moUtil.FetchDate(.Fields.Item("DeadDate").Value)
               vRec.Date1 = moUtil.FetchDate(.Fields.Item("Date1").Value)
               vRec.Date2 = moUtil.FetchDate(.Fields.Item("Date2").Value)
               vRec.Date3 = moUtil.FetchDate(.Fields.Item("Date3").Value)
               vRec.Date4 = moUtil.FetchDate(.Fields.Item("Date4").Value)
               vRec.Date5 = moUtil.FetchDate(.Fields.Item("Date5").Value)
               vRec.Date6 = moUtil.FetchDate(.Fields.Item("Date6").Value)
               vRec.Date7 = moUtil.FetchDate(.Fields.Item("Date7").Value)
               vRec.Date8 = moUtil.FetchDate(.Fields.Item("Date8").Value)
               vRec.Date9 = moUtil.FetchDate(.Fields.Item("Date9").Value)
               vRec.Date10 = moUtil.FetchDate(.Fields.Item("Date10").Value)
               vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
               vRec.ChangeStatus = moUtil.FetchLong(.Fields.Item("ChangeStatus").Value)
               vRec.EmailDate = moUtil.FetchDate(.Fields.Item("EmailDate").Value)
               vRec.RSVP = moUtil.FetchLong(.Fields.Item("RSVP").Value)
               vRec.EmailStatus = moUtil.FetchLong(.Fields.Item("EmailStatus").Value)
               vRec.LeadViews = moUtil.FetchLong(.Fields.Item("LeadViews").Value)
               vRec.LeadPages = moUtil.FetchString(.Fields.Item("LeadPages").Value)
               vRec.LeadReplies = moUtil.FetchLong(.Fields.Item("LeadReplies").Value)
               vRec.PresentViews = moUtil.FetchLong(.Fields.Item("PresentViews").Value)
               vRec.PresentPages = moUtil.FetchString(.Fields.Item("PresentPages").Value)
               vRec.NoDistribute = moUtil.FetchInteger(.Fields.Item("NoDistribute").Value)
               vRec.DistributorID = moUtil.FetchLong(.Fields.Item("DistributorID").Value)
               vRec.DistributeDate = moUtil.FetchDate(.Fields.Item("DistributeDate").Value)
               vRec.Priority = moUtil.FetchString(.Fields.Item("Priority").Value)
               vRec.InputValues = moUtil.FetchString(.Fields.Item("InputValues").Value)
               vRec.Source = moUtil.FetchString(.Fields.Item("Source").Value)
               vRec.Code = moUtil.FetchLong(.Fields.Item("Code").Value)
               vRec.Reminder = moUtil.FetchLong(.Fields.Item("Reminder").Value)
               vRec.RemindDate = moUtil.FetchDate(.Fields.Item("RemindDate").Value)
               vRec.TimeZone = moUtil.FetchLong(.Fields.Item("TimeZone").Value)
               vRec.BestTime = moUtil.FetchLong(.Fields.Item("BestTime").Value)
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
   FindMemberActive = vRecs

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

Public Function FindMemberLive( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindMemberLive"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
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
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsProspectFindProspectName
         sProc = "pts_Prospect_FindMemberLiveProspectName"
         MaxBookMark = 70
      Case cptsProspectFindContactName
         sProc = "pts_Prospect_FindMemberLiveContactName"
         MaxBookMark = 72
      Case cptsProspectFindCreateDate
         sProc = "pts_Prospect_FindMemberLiveCreateDate"
         MaxBookMark = 30
      Case cptsProspectFindPriority
         sProc = "pts_Prospect_FindMemberLivePriority"
         MaxBookMark = 14
      Case cptsProspectFindSource
         sProc = "pts_Prospect_FindMemberLiveSource"
         MaxBookMark = 30
      Case cptsProspectFindRepresenting
         sProc = "pts_Prospect_FindMemberLiveRepresenting"
         MaxBookMark = 30
      Case cptsProspectFindProspectID
         sProc = "pts_Prospect_FindMemberLiveProspectID"
         MaxBookMark = 20
      Case cptsProspectFindEmail
         sProc = "pts_Prospect_FindMemberLiveEmail"
         MaxBookMark = 90
      Case cptsProspectFindPhone1
         sProc = "pts_Prospect_FindMemberLivePhone1"
         MaxBookMark = 40
      Case cptsProspectFindLeadCampaignID
         sProc = "pts_Prospect_FindMemberLiveLeadCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindSalesCampaignID
         sProc = "pts_Prospect_FindMemberLiveSalesCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindDescription
         sProc = "pts_Prospect_FindMemberLiveDescription"
         MaxBookMark = 2010
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
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
               vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.SalesCampaignID = moUtil.FetchLong(.Fields.Item("SalesCampaignID").Value)
               vRec.LeadCampaignID = moUtil.FetchLong(.Fields.Item("LeadCampaignID").Value)
               vRec.PresentID = moUtil.FetchLong(.Fields.Item("PresentID").Value)
               vRec.ProspectTypeID = moUtil.FetchLong(.Fields.Item("ProspectTypeID").Value)
               vRec.EmailID = moUtil.FetchLong(.Fields.Item("EmailID").Value)
               vRec.AffiliateID = moUtil.FetchLong(.Fields.Item("AffiliateID").Value)
               vRec.NewsLetterID = moUtil.FetchLong(.Fields.Item("NewsLetterID").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.StatusName = moUtil.FetchString(.Fields.Item("StatusName").Value)
               vRec.IsBoard = moUtil.FetchString(.Fields.Item("IsBoard").Value)
               vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
               vRec.ProspectTypeName = moUtil.FetchString(.Fields.Item("ProspectTypeName").Value)
               vRec.IsCopyURL = moUtil.FetchInteger(.Fields.Item("IsCopyURL").Value)
               vRec.Result = moUtil.FetchString(.Fields.Item("Result").Value)
               vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
               vRec.Website = moUtil.FetchString(.Fields.Item("Website").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Representing = moUtil.FetchString(.Fields.Item("Representing").Value)
               vRec.Potential = moUtil.FetchCurrency(.Fields.Item("Potential").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.ContactName = moUtil.FetchString(.Fields.Item("ContactName").Value)
               vRec.Title = moUtil.FetchString(.Fields.Item("Title").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.NextEvent = moUtil.FetchLong(.Fields.Item("NextEvent").Value)
               vRec.NextDate = moUtil.FetchDate(.Fields.Item("NextDate").Value)
               vRec.NextTime = moUtil.FetchString(.Fields.Item("NextTime").Value)
               vRec.CreateDate = moUtil.FetchDate(.Fields.Item("CreateDate").Value)
               vRec.FBDate = moUtil.FetchDate(.Fields.Item("FBDate").Value)
               vRec.CloseDate = moUtil.FetchDate(.Fields.Item("CloseDate").Value)
               vRec.DeadDate = moUtil.FetchDate(.Fields.Item("DeadDate").Value)
               vRec.Date1 = moUtil.FetchDate(.Fields.Item("Date1").Value)
               vRec.Date2 = moUtil.FetchDate(.Fields.Item("Date2").Value)
               vRec.Date3 = moUtil.FetchDate(.Fields.Item("Date3").Value)
               vRec.Date4 = moUtil.FetchDate(.Fields.Item("Date4").Value)
               vRec.Date5 = moUtil.FetchDate(.Fields.Item("Date5").Value)
               vRec.Date6 = moUtil.FetchDate(.Fields.Item("Date6").Value)
               vRec.Date7 = moUtil.FetchDate(.Fields.Item("Date7").Value)
               vRec.Date8 = moUtil.FetchDate(.Fields.Item("Date8").Value)
               vRec.Date9 = moUtil.FetchDate(.Fields.Item("Date9").Value)
               vRec.Date10 = moUtil.FetchDate(.Fields.Item("Date10").Value)
               vRec.ChangeDate = moUtil.FetchDate(.Fields.Item("ChangeDate").Value)
               vRec.ChangeStatus = moUtil.FetchLong(.Fields.Item("ChangeStatus").Value)
               vRec.EmailDate = moUtil.FetchDate(.Fields.Item("EmailDate").Value)
               vRec.RSVP = moUtil.FetchLong(.Fields.Item("RSVP").Value)
               vRec.EmailStatus = moUtil.FetchLong(.Fields.Item("EmailStatus").Value)
               vRec.LeadViews = moUtil.FetchLong(.Fields.Item("LeadViews").Value)
               vRec.LeadPages = moUtil.FetchString(.Fields.Item("LeadPages").Value)
               vRec.LeadReplies = moUtil.FetchLong(.Fields.Item("LeadReplies").Value)
               vRec.PresentViews = moUtil.FetchLong(.Fields.Item("PresentViews").Value)
               vRec.PresentPages = moUtil.FetchString(.Fields.Item("PresentPages").Value)
               vRec.NoDistribute = moUtil.FetchInteger(.Fields.Item("NoDistribute").Value)
               vRec.DistributorID = moUtil.FetchLong(.Fields.Item("DistributorID").Value)
               vRec.DistributeDate = moUtil.FetchDate(.Fields.Item("DistributeDate").Value)
               vRec.Priority = moUtil.FetchString(.Fields.Item("Priority").Value)
               vRec.InputValues = moUtil.FetchString(.Fields.Item("InputValues").Value)
               vRec.Source = moUtil.FetchString(.Fields.Item("Source").Value)
               vRec.Code = moUtil.FetchLong(.Fields.Item("Code").Value)
               vRec.Reminder = moUtil.FetchLong(.Fields.Item("Reminder").Value)
               vRec.RemindDate = moUtil.FetchDate(.Fields.Item("RemindDate").Value)
               vRec.TimeZone = moUtil.FetchLong(.Fields.Item("TimeZone").Value)
               vRec.BestTime = moUtil.FetchLong(.Fields.Item("BestTime").Value)
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
   FindMemberLive = vRecs

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

Public Function FindLead( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindLead"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
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
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsProspectFindProspectName
         sProc = "pts_Prospect_FindLeadProspectName"
         MaxBookMark = 70
      Case cptsProspectFindContactName
         sProc = "pts_Prospect_FindLeadContactName"
         MaxBookMark = 72
      Case cptsProspectFindCreateDate
         sProc = "pts_Prospect_FindLeadCreateDate"
         MaxBookMark = 30
      Case cptsProspectFindPriority
         sProc = "pts_Prospect_FindLeadPriority"
         MaxBookMark = 14
      Case cptsProspectFindSource
         sProc = "pts_Prospect_FindLeadSource"
         MaxBookMark = 30
      Case cptsProspectFindRepresenting
         sProc = "pts_Prospect_FindLeadRepresenting"
         MaxBookMark = 30
      Case cptsProspectFindProspectID
         sProc = "pts_Prospect_FindLeadProspectID"
         MaxBookMark = 20
      Case cptsProspectFindEmail
         sProc = "pts_Prospect_FindLeadEmail"
         MaxBookMark = 90
      Case cptsProspectFindPhone1
         sProc = "pts_Prospect_FindLeadPhone1"
         MaxBookMark = 40
      Case cptsProspectFindLeadCampaignID
         sProc = "pts_Prospect_FindLeadLeadCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindSalesCampaignID
         sProc = "pts_Prospect_FindLeadSalesCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindDescription
         sProc = "pts_Prospect_FindLeadDescription"
         MaxBookMark = 2010
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
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
               vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
               vRec.ProspectTypeName = moUtil.FetchString(.Fields.Item("ProspectTypeName").Value)
               vRec.ContactName = moUtil.FetchString(.Fields.Item("ContactName").Value)
               vRec.Representing = moUtil.FetchString(.Fields.Item("Representing").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Priority = moUtil.FetchString(.Fields.Item("Priority").Value)
               vRec.CreateDate = moUtil.FetchDate(.Fields.Item("CreateDate").Value)
               vRec.Source = moUtil.FetchString(.Fields.Item("Source").Value)
               vRec.NextEvent = moUtil.FetchLong(.Fields.Item("NextEvent").Value)
               vRec.NextDate = moUtil.FetchDate(.Fields.Item("NextDate").Value)
               vRec.NextTime = moUtil.FetchString(.Fields.Item("NextTime").Value)
               vRec.TimeZone = moUtil.FetchLong(.Fields.Item("TimeZone").Value)
               vRec.BestTime = moUtil.FetchLong(.Fields.Item("BestTime").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
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
   FindLead = vRecs

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

Public Function FindLeadStatus( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindLeadStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
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
   bvStatus = moUtil.EditLong(bvStatus, "Status", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsProspectFindProspectName
         sProc = "pts_Prospect_FindLeadStatusProspectName"
         MaxBookMark = 70
      Case cptsProspectFindContactName
         sProc = "pts_Prospect_FindLeadStatusContactName"
         MaxBookMark = 72
      Case cptsProspectFindCreateDate
         sProc = "pts_Prospect_FindLeadStatusCreateDate"
         MaxBookMark = 30
      Case cptsProspectFindPriority
         sProc = "pts_Prospect_FindLeadStatusPriority"
         MaxBookMark = 14
      Case cptsProspectFindSource
         sProc = "pts_Prospect_FindLeadStatusSource"
         MaxBookMark = 30
      Case cptsProspectFindRepresenting
         sProc = "pts_Prospect_FindLeadStatusRepresenting"
         MaxBookMark = 30
      Case cptsProspectFindProspectID
         sProc = "pts_Prospect_FindLeadStatusProspectID"
         MaxBookMark = 20
      Case cptsProspectFindEmail
         sProc = "pts_Prospect_FindLeadStatusEmail"
         MaxBookMark = 90
      Case cptsProspectFindPhone1
         sProc = "pts_Prospect_FindLeadStatusPhone1"
         MaxBookMark = 40
      Case cptsProspectFindLeadCampaignID
         sProc = "pts_Prospect_FindLeadStatusLeadCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindSalesCampaignID
         sProc = "pts_Prospect_FindLeadStatusSalesCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindDescription
         sProc = "pts_Prospect_FindLeadStatusDescription"
         MaxBookMark = 2010
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
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
               vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
               vRec.ProspectTypeName = moUtil.FetchString(.Fields.Item("ProspectTypeName").Value)
               vRec.ContactName = moUtil.FetchString(.Fields.Item("ContactName").Value)
               vRec.Representing = moUtil.FetchString(.Fields.Item("Representing").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Priority = moUtil.FetchString(.Fields.Item("Priority").Value)
               vRec.CreateDate = moUtil.FetchDate(.Fields.Item("CreateDate").Value)
               vRec.Source = moUtil.FetchString(.Fields.Item("Source").Value)
               vRec.NextEvent = moUtil.FetchLong(.Fields.Item("NextEvent").Value)
               vRec.NextDate = moUtil.FetchDate(.Fields.Item("NextDate").Value)
               vRec.NextTime = moUtil.FetchString(.Fields.Item("NextTime").Value)
               vRec.TimeZone = moUtil.FetchLong(.Fields.Item("TimeZone").Value)
               vRec.BestTime = moUtil.FetchLong(.Fields.Item("BestTime").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
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
   FindLeadStatus = vRecs

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

Public Function FindLeadActive( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindLeadActive"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
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
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsProspectFindProspectName
         sProc = "pts_Prospect_FindLeadActiveProspectName"
         MaxBookMark = 70
      Case cptsProspectFindContactName
         sProc = "pts_Prospect_FindLeadActiveContactName"
         MaxBookMark = 72
      Case cptsProspectFindCreateDate
         sProc = "pts_Prospect_FindLeadActiveCreateDate"
         MaxBookMark = 30
      Case cptsProspectFindPriority
         sProc = "pts_Prospect_FindLeadActivePriority"
         MaxBookMark = 14
      Case cptsProspectFindSource
         sProc = "pts_Prospect_FindLeadActiveSource"
         MaxBookMark = 30
      Case cptsProspectFindRepresenting
         sProc = "pts_Prospect_FindLeadActiveRepresenting"
         MaxBookMark = 30
      Case cptsProspectFindProspectID
         sProc = "pts_Prospect_FindLeadActiveProspectID"
         MaxBookMark = 20
      Case cptsProspectFindEmail
         sProc = "pts_Prospect_FindLeadActiveEmail"
         MaxBookMark = 90
      Case cptsProspectFindPhone1
         sProc = "pts_Prospect_FindLeadActivePhone1"
         MaxBookMark = 40
      Case cptsProspectFindLeadCampaignID
         sProc = "pts_Prospect_FindLeadActiveLeadCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindSalesCampaignID
         sProc = "pts_Prospect_FindLeadActiveSalesCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindDescription
         sProc = "pts_Prospect_FindLeadActiveDescription"
         MaxBookMark = 2010
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
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
               vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
               vRec.ProspectTypeName = moUtil.FetchString(.Fields.Item("ProspectTypeName").Value)
               vRec.ContactName = moUtil.FetchString(.Fields.Item("ContactName").Value)
               vRec.Representing = moUtil.FetchString(.Fields.Item("Representing").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Priority = moUtil.FetchString(.Fields.Item("Priority").Value)
               vRec.CreateDate = moUtil.FetchDate(.Fields.Item("CreateDate").Value)
               vRec.Source = moUtil.FetchString(.Fields.Item("Source").Value)
               vRec.NextEvent = moUtil.FetchLong(.Fields.Item("NextEvent").Value)
               vRec.NextDate = moUtil.FetchDate(.Fields.Item("NextDate").Value)
               vRec.NextTime = moUtil.FetchString(.Fields.Item("NextTime").Value)
               vRec.TimeZone = moUtil.FetchLong(.Fields.Item("TimeZone").Value)
               vRec.BestTime = moUtil.FetchLong(.Fields.Item("BestTime").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
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
   FindLeadActive = vRecs

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

Public Function FindLeadLive( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindLeadLive"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
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
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsProspectFindProspectName
         sProc = "pts_Prospect_FindLeadLiveProspectName"
         MaxBookMark = 70
      Case cptsProspectFindContactName
         sProc = "pts_Prospect_FindLeadLiveContactName"
         MaxBookMark = 72
      Case cptsProspectFindCreateDate
         sProc = "pts_Prospect_FindLeadLiveCreateDate"
         MaxBookMark = 30
      Case cptsProspectFindPriority
         sProc = "pts_Prospect_FindLeadLivePriority"
         MaxBookMark = 14
      Case cptsProspectFindSource
         sProc = "pts_Prospect_FindLeadLiveSource"
         MaxBookMark = 30
      Case cptsProspectFindRepresenting
         sProc = "pts_Prospect_FindLeadLiveRepresenting"
         MaxBookMark = 30
      Case cptsProspectFindProspectID
         sProc = "pts_Prospect_FindLeadLiveProspectID"
         MaxBookMark = 20
      Case cptsProspectFindEmail
         sProc = "pts_Prospect_FindLeadLiveEmail"
         MaxBookMark = 90
      Case cptsProspectFindPhone1
         sProc = "pts_Prospect_FindLeadLivePhone1"
         MaxBookMark = 40
      Case cptsProspectFindLeadCampaignID
         sProc = "pts_Prospect_FindLeadLiveLeadCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindSalesCampaignID
         sProc = "pts_Prospect_FindLeadLiveSalesCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindDescription
         sProc = "pts_Prospect_FindLeadLiveDescription"
         MaxBookMark = 2010
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
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
               vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
               vRec.ProspectTypeName = moUtil.FetchString(.Fields.Item("ProspectTypeName").Value)
               vRec.ContactName = moUtil.FetchString(.Fields.Item("ContactName").Value)
               vRec.Representing = moUtil.FetchString(.Fields.Item("Representing").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Priority = moUtil.FetchString(.Fields.Item("Priority").Value)
               vRec.CreateDate = moUtil.FetchDate(.Fields.Item("CreateDate").Value)
               vRec.Source = moUtil.FetchString(.Fields.Item("Source").Value)
               vRec.NextEvent = moUtil.FetchLong(.Fields.Item("NextEvent").Value)
               vRec.NextDate = moUtil.FetchDate(.Fields.Item("NextDate").Value)
               vRec.NextTime = moUtil.FetchString(.Fields.Item("NextTime").Value)
               vRec.TimeZone = moUtil.FetchLong(.Fields.Item("TimeZone").Value)
               vRec.BestTime = moUtil.FetchLong(.Fields.Item("BestTime").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
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
   FindLeadLive = vRecs

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

Public Function FindFolder( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvFolderID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindFolder"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
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
   bvFolderID = moUtil.EditLong(bvFolderID, "FolderID", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsProspectFindProspectName
         sProc = "pts_Prospect_FindFolderProspectName"
         MaxBookMark = 70
      Case cptsProspectFindContactName
         sProc = "pts_Prospect_FindFolderContactName"
         MaxBookMark = 72
      Case cptsProspectFindCreateDate
         sProc = "pts_Prospect_FindFolderCreateDate"
         MaxBookMark = 30
      Case cptsProspectFindPriority
         sProc = "pts_Prospect_FindFolderPriority"
         MaxBookMark = 14
      Case cptsProspectFindSource
         sProc = "pts_Prospect_FindFolderSource"
         MaxBookMark = 30
      Case cptsProspectFindRepresenting
         sProc = "pts_Prospect_FindFolderRepresenting"
         MaxBookMark = 30
      Case cptsProspectFindProspectID
         sProc = "pts_Prospect_FindFolderProspectID"
         MaxBookMark = 20
      Case cptsProspectFindEmail
         sProc = "pts_Prospect_FindFolderEmail"
         MaxBookMark = 90
      Case cptsProspectFindPhone1
         sProc = "pts_Prospect_FindFolderPhone1"
         MaxBookMark = 40
      Case cptsProspectFindLeadCampaignID
         sProc = "pts_Prospect_FindFolderLeadCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindSalesCampaignID
         sProc = "pts_Prospect_FindFolderSalesCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindDescription
         sProc = "pts_Prospect_FindFolderDescription"
         MaxBookMark = 2010
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@FolderID", adInteger, adParamInput, vbNull, CLng(bvFolderID))
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
               vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
               vRec.ProspectTypeName = moUtil.FetchString(.Fields.Item("ProspectTypeName").Value)
               vRec.ContactName = moUtil.FetchString(.Fields.Item("ContactName").Value)
               vRec.Representing = moUtil.FetchString(.Fields.Item("Representing").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Priority = moUtil.FetchString(.Fields.Item("Priority").Value)
               vRec.CreateDate = moUtil.FetchDate(.Fields.Item("CreateDate").Value)
               vRec.Source = moUtil.FetchString(.Fields.Item("Source").Value)
               vRec.NextEvent = moUtil.FetchLong(.Fields.Item("NextEvent").Value)
               vRec.NextDate = moUtil.FetchDate(.Fields.Item("NextDate").Value)
               vRec.NextTime = moUtil.FetchString(.Fields.Item("NextTime").Value)
               vRec.TimeZone = moUtil.FetchLong(.Fields.Item("TimeZone").Value)
               vRec.BestTime = moUtil.FetchLong(.Fields.Item("BestTime").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
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
   FindFolder = vRecs

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

Public Function FindMemCust( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindMemCust"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
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
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsProspectFindProspectName
         sProc = "pts_Prospect_FindMemCustProspectName"
         MaxBookMark = 70
      Case cptsProspectFindContactName
         sProc = "pts_Prospect_FindMemCustContactName"
         MaxBookMark = 72
      Case cptsProspectFindCreateDate
         sProc = "pts_Prospect_FindMemCustCreateDate"
         MaxBookMark = 30
      Case cptsProspectFindPriority
         sProc = "pts_Prospect_FindMemCustPriority"
         MaxBookMark = 14
      Case cptsProspectFindSource
         sProc = "pts_Prospect_FindMemCustSource"
         MaxBookMark = 30
      Case cptsProspectFindRepresenting
         sProc = "pts_Prospect_FindMemCustRepresenting"
         MaxBookMark = 30
      Case cptsProspectFindProspectID
         sProc = "pts_Prospect_FindMemCustProspectID"
         MaxBookMark = 20
      Case cptsProspectFindEmail
         sProc = "pts_Prospect_FindMemCustEmail"
         MaxBookMark = 90
      Case cptsProspectFindPhone1
         sProc = "pts_Prospect_FindMemCustPhone1"
         MaxBookMark = 40
      Case cptsProspectFindLeadCampaignID
         sProc = "pts_Prospect_FindMemCustLeadCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindSalesCampaignID
         sProc = "pts_Prospect_FindMemCustSalesCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindDescription
         sProc = "pts_Prospect_FindMemCustDescription"
         MaxBookMark = 2010
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
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
               vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
               vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
               vRec.ProspectTypeName = moUtil.FetchString(.Fields.Item("ProspectTypeName").Value)
               vRec.CloseDate = moUtil.FetchDate(.Fields.Item("CloseDate").Value)
               vRec.Representing = moUtil.FetchString(.Fields.Item("Representing").Value)
               vRec.Priority = moUtil.FetchString(.Fields.Item("Priority").Value)
               vRec.Source = moUtil.FetchString(.Fields.Item("Source").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
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
   FindMemCust = vRecs

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

Public Function FindMemCustCamp( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvSalesCampaignID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindMemCustCamp"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
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
   bvSalesCampaignID = moUtil.EditLong(bvSalesCampaignID, "SalesCampaignID", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsProspectFindProspectName
         sProc = "pts_Prospect_FindMemCustCampProspectName"
         MaxBookMark = 70
      Case cptsProspectFindContactName
         sProc = "pts_Prospect_FindMemCustCampContactName"
         MaxBookMark = 72
      Case cptsProspectFindCreateDate
         sProc = "pts_Prospect_FindMemCustCampCreateDate"
         MaxBookMark = 30
      Case cptsProspectFindPriority
         sProc = "pts_Prospect_FindMemCustCampPriority"
         MaxBookMark = 14
      Case cptsProspectFindSource
         sProc = "pts_Prospect_FindMemCustCampSource"
         MaxBookMark = 30
      Case cptsProspectFindRepresenting
         sProc = "pts_Prospect_FindMemCustCampRepresenting"
         MaxBookMark = 30
      Case cptsProspectFindProspectID
         sProc = "pts_Prospect_FindMemCustCampProspectID"
         MaxBookMark = 20
      Case cptsProspectFindEmail
         sProc = "pts_Prospect_FindMemCustCampEmail"
         MaxBookMark = 90
      Case cptsProspectFindPhone1
         sProc = "pts_Prospect_FindMemCustCampPhone1"
         MaxBookMark = 40
      Case cptsProspectFindLeadCampaignID
         sProc = "pts_Prospect_FindMemCustCampLeadCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindSalesCampaignID
         sProc = "pts_Prospect_FindMemCustCampSalesCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindDescription
         sProc = "pts_Prospect_FindMemCustCampDescription"
         MaxBookMark = 2010
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@SalesCampaignID", adInteger, adParamInput, vbNull, CLng(bvSalesCampaignID))
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
               vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
               vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
               vRec.ProspectTypeName = moUtil.FetchString(.Fields.Item("ProspectTypeName").Value)
               vRec.CloseDate = moUtil.FetchDate(.Fields.Item("CloseDate").Value)
               vRec.Representing = moUtil.FetchString(.Fields.Item("Representing").Value)
               vRec.Priority = moUtil.FetchString(.Fields.Item("Priority").Value)
               vRec.Source = moUtil.FetchString(.Fields.Item("Source").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
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
   FindMemCustCamp = vRecs

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

Public Function FindMemCustType( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvProspectTypeID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindMemCustType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
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
   bvProspectTypeID = moUtil.EditLong(bvProspectTypeID, "ProspectTypeID", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsProspectFindProspectName
         sProc = "pts_Prospect_FindMemCustTypeProspectName"
         MaxBookMark = 70
      Case cptsProspectFindContactName
         sProc = "pts_Prospect_FindMemCustTypeContactName"
         MaxBookMark = 72
      Case cptsProspectFindCreateDate
         sProc = "pts_Prospect_FindMemCustTypeCreateDate"
         MaxBookMark = 30
      Case cptsProspectFindPriority
         sProc = "pts_Prospect_FindMemCustTypePriority"
         MaxBookMark = 14
      Case cptsProspectFindSource
         sProc = "pts_Prospect_FindMemCustTypeSource"
         MaxBookMark = 30
      Case cptsProspectFindRepresenting
         sProc = "pts_Prospect_FindMemCustTypeRepresenting"
         MaxBookMark = 30
      Case cptsProspectFindProspectID
         sProc = "pts_Prospect_FindMemCustTypeProspectID"
         MaxBookMark = 20
      Case cptsProspectFindEmail
         sProc = "pts_Prospect_FindMemCustTypeEmail"
         MaxBookMark = 90
      Case cptsProspectFindPhone1
         sProc = "pts_Prospect_FindMemCustTypePhone1"
         MaxBookMark = 40
      Case cptsProspectFindLeadCampaignID
         sProc = "pts_Prospect_FindMemCustTypeLeadCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindSalesCampaignID
         sProc = "pts_Prospect_FindMemCustTypeSalesCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindDescription
         sProc = "pts_Prospect_FindMemCustTypeDescription"
         MaxBookMark = 2010
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@ProspectTypeID", adInteger, adParamInput, vbNull, CLng(bvProspectTypeID))
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
               vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
               vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
               vRec.ProspectTypeName = moUtil.FetchString(.Fields.Item("ProspectTypeName").Value)
               vRec.CloseDate = moUtil.FetchDate(.Fields.Item("CloseDate").Value)
               vRec.Representing = moUtil.FetchString(.Fields.Item("Representing").Value)
               vRec.Priority = moUtil.FetchString(.Fields.Item("Priority").Value)
               vRec.Source = moUtil.FetchString(.Fields.Item("Source").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
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
   FindMemCustType = vRecs

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

Public Function FindMemCustCampType( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvSalesCampaignID As Long, _ 
   ByVal bvProspectTypeID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindMemCustCampType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
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
   bvSalesCampaignID = moUtil.EditLong(bvSalesCampaignID, "SalesCampaignID", True) 
   bvProspectTypeID = moUtil.EditLong(bvProspectTypeID, "ProspectTypeID", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsProspectFindProspectName
         sProc = "pts_Prospect_FindMemCustCampTypeProspectName"
         MaxBookMark = 70
      Case cptsProspectFindContactName
         sProc = "pts_Prospect_FindMemCustCampTypeContactName"
         MaxBookMark = 72
      Case cptsProspectFindCreateDate
         sProc = "pts_Prospect_FindMemCustCampTypeCreateDate"
         MaxBookMark = 30
      Case cptsProspectFindPriority
         sProc = "pts_Prospect_FindMemCustCampTypePriority"
         MaxBookMark = 14
      Case cptsProspectFindSource
         sProc = "pts_Prospect_FindMemCustCampTypeSource"
         MaxBookMark = 30
      Case cptsProspectFindRepresenting
         sProc = "pts_Prospect_FindMemCustCampTypeRepresenting"
         MaxBookMark = 30
      Case cptsProspectFindProspectID
         sProc = "pts_Prospect_FindMemCustCampTypeProspectID"
         MaxBookMark = 20
      Case cptsProspectFindEmail
         sProc = "pts_Prospect_FindMemCustCampTypeEmail"
         MaxBookMark = 90
      Case cptsProspectFindPhone1
         sProc = "pts_Prospect_FindMemCustCampTypePhone1"
         MaxBookMark = 40
      Case cptsProspectFindLeadCampaignID
         sProc = "pts_Prospect_FindMemCustCampTypeLeadCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindSalesCampaignID
         sProc = "pts_Prospect_FindMemCustCampTypeSalesCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindDescription
         sProc = "pts_Prospect_FindMemCustCampTypeDescription"
         MaxBookMark = 2010
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@SalesCampaignID", adInteger, adParamInput, vbNull, CLng(bvSalesCampaignID))
      .Parameters.Append .CreateParameter("@ProspectTypeID", adInteger, adParamInput, vbNull, CLng(bvProspectTypeID))
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
               vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
               vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
               vRec.ProspectTypeName = moUtil.FetchString(.Fields.Item("ProspectTypeName").Value)
               vRec.CloseDate = moUtil.FetchDate(.Fields.Item("CloseDate").Value)
               vRec.Representing = moUtil.FetchString(.Fields.Item("Representing").Value)
               vRec.Priority = moUtil.FetchString(.Fields.Item("Priority").Value)
               vRec.Source = moUtil.FetchString(.Fields.Item("Source").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
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
   FindMemCustCampType = vRecs

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

Public Function FindComCust( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindComCust"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
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
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsProspectFindProspectName
         sProc = "pts_Prospect_FindComCustProspectName"
         MaxBookMark = 70
      Case cptsProspectFindContactName
         sProc = "pts_Prospect_FindComCustContactName"
         MaxBookMark = 72
      Case cptsProspectFindCreateDate
         sProc = "pts_Prospect_FindComCustCreateDate"
         MaxBookMark = 30
      Case cptsProspectFindPriority
         sProc = "pts_Prospect_FindComCustPriority"
         MaxBookMark = 14
      Case cptsProspectFindSource
         sProc = "pts_Prospect_FindComCustSource"
         MaxBookMark = 30
      Case cptsProspectFindRepresenting
         sProc = "pts_Prospect_FindComCustRepresenting"
         MaxBookMark = 30
      Case cptsProspectFindProspectID
         sProc = "pts_Prospect_FindComCustProspectID"
         MaxBookMark = 20
      Case cptsProspectFindEmail
         sProc = "pts_Prospect_FindComCustEmail"
         MaxBookMark = 90
      Case cptsProspectFindPhone1
         sProc = "pts_Prospect_FindComCustPhone1"
         MaxBookMark = 40
      Case cptsProspectFindLeadCampaignID
         sProc = "pts_Prospect_FindComCustLeadCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindSalesCampaignID
         sProc = "pts_Prospect_FindComCustSalesCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindDescription
         sProc = "pts_Prospect_FindComCustDescription"
         MaxBookMark = 2010
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
               vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
               vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
               vRec.ProspectTypeName = moUtil.FetchString(.Fields.Item("ProspectTypeName").Value)
               vRec.CloseDate = moUtil.FetchDate(.Fields.Item("CloseDate").Value)
               vRec.Representing = moUtil.FetchString(.Fields.Item("Representing").Value)
               vRec.Priority = moUtil.FetchString(.Fields.Item("Priority").Value)
               vRec.Source = moUtil.FetchString(.Fields.Item("Source").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
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
   FindComCust = vRecs

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

Public Function FindComCustCamp( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvSalesCampaignID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindComCustCamp"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
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
   bvSalesCampaignID = moUtil.EditLong(bvSalesCampaignID, "SalesCampaignID", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsProspectFindProspectName
         sProc = "pts_Prospect_FindComCustCampProspectName"
         MaxBookMark = 70
      Case cptsProspectFindContactName
         sProc = "pts_Prospect_FindComCustCampContactName"
         MaxBookMark = 72
      Case cptsProspectFindCreateDate
         sProc = "pts_Prospect_FindComCustCampCreateDate"
         MaxBookMark = 30
      Case cptsProspectFindPriority
         sProc = "pts_Prospect_FindComCustCampPriority"
         MaxBookMark = 14
      Case cptsProspectFindSource
         sProc = "pts_Prospect_FindComCustCampSource"
         MaxBookMark = 30
      Case cptsProspectFindRepresenting
         sProc = "pts_Prospect_FindComCustCampRepresenting"
         MaxBookMark = 30
      Case cptsProspectFindProspectID
         sProc = "pts_Prospect_FindComCustCampProspectID"
         MaxBookMark = 20
      Case cptsProspectFindEmail
         sProc = "pts_Prospect_FindComCustCampEmail"
         MaxBookMark = 90
      Case cptsProspectFindPhone1
         sProc = "pts_Prospect_FindComCustCampPhone1"
         MaxBookMark = 40
      Case cptsProspectFindLeadCampaignID
         sProc = "pts_Prospect_FindComCustCampLeadCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindSalesCampaignID
         sProc = "pts_Prospect_FindComCustCampSalesCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindDescription
         sProc = "pts_Prospect_FindComCustCampDescription"
         MaxBookMark = 2010
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@SalesCampaignID", adInteger, adParamInput, vbNull, CLng(bvSalesCampaignID))
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
               vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
               vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
               vRec.ProspectTypeName = moUtil.FetchString(.Fields.Item("ProspectTypeName").Value)
               vRec.CloseDate = moUtil.FetchDate(.Fields.Item("CloseDate").Value)
               vRec.Representing = moUtil.FetchString(.Fields.Item("Representing").Value)
               vRec.Priority = moUtil.FetchString(.Fields.Item("Priority").Value)
               vRec.Source = moUtil.FetchString(.Fields.Item("Source").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
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
   FindComCustCamp = vRecs

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

Public Function FindComCustType( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvProspectTypeID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindComCustType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
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
   bvProspectTypeID = moUtil.EditLong(bvProspectTypeID, "ProspectTypeID", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsProspectFindProspectName
         sProc = "pts_Prospect_FindComCustTypeProspectName"
         MaxBookMark = 70
      Case cptsProspectFindContactName
         sProc = "pts_Prospect_FindComCustTypeContactName"
         MaxBookMark = 72
      Case cptsProspectFindCreateDate
         sProc = "pts_Prospect_FindComCustTypeCreateDate"
         MaxBookMark = 30
      Case cptsProspectFindPriority
         sProc = "pts_Prospect_FindComCustTypePriority"
         MaxBookMark = 14
      Case cptsProspectFindSource
         sProc = "pts_Prospect_FindComCustTypeSource"
         MaxBookMark = 30
      Case cptsProspectFindRepresenting
         sProc = "pts_Prospect_FindComCustTypeRepresenting"
         MaxBookMark = 30
      Case cptsProspectFindProspectID
         sProc = "pts_Prospect_FindComCustTypeProspectID"
         MaxBookMark = 20
      Case cptsProspectFindEmail
         sProc = "pts_Prospect_FindComCustTypeEmail"
         MaxBookMark = 90
      Case cptsProspectFindPhone1
         sProc = "pts_Prospect_FindComCustTypePhone1"
         MaxBookMark = 40
      Case cptsProspectFindLeadCampaignID
         sProc = "pts_Prospect_FindComCustTypeLeadCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindSalesCampaignID
         sProc = "pts_Prospect_FindComCustTypeSalesCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindDescription
         sProc = "pts_Prospect_FindComCustTypeDescription"
         MaxBookMark = 2010
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@ProspectTypeID", adInteger, adParamInput, vbNull, CLng(bvProspectTypeID))
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
               vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
               vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
               vRec.ProspectTypeName = moUtil.FetchString(.Fields.Item("ProspectTypeName").Value)
               vRec.CloseDate = moUtil.FetchDate(.Fields.Item("CloseDate").Value)
               vRec.Representing = moUtil.FetchString(.Fields.Item("Representing").Value)
               vRec.Priority = moUtil.FetchString(.Fields.Item("Priority").Value)
               vRec.Source = moUtil.FetchString(.Fields.Item("Source").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
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
   FindComCustType = vRecs

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

Public Function FindComCustCampType( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvSalesCampaignID As Long, _ 
   ByVal bvProspectTypeID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindComCustCampType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
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
   bvSalesCampaignID = moUtil.EditLong(bvSalesCampaignID, "SalesCampaignID", True) 
   bvProspectTypeID = moUtil.EditLong(bvProspectTypeID, "ProspectTypeID", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsProspectFindProspectName
         sProc = "pts_Prospect_FindComCustCampTypeProspectName"
         MaxBookMark = 70
      Case cptsProspectFindContactName
         sProc = "pts_Prospect_FindComCustCampTypeContactName"
         MaxBookMark = 72
      Case cptsProspectFindCreateDate
         sProc = "pts_Prospect_FindComCustCampTypeCreateDate"
         MaxBookMark = 30
      Case cptsProspectFindPriority
         sProc = "pts_Prospect_FindComCustCampTypePriority"
         MaxBookMark = 14
      Case cptsProspectFindSource
         sProc = "pts_Prospect_FindComCustCampTypeSource"
         MaxBookMark = 30
      Case cptsProspectFindRepresenting
         sProc = "pts_Prospect_FindComCustCampTypeRepresenting"
         MaxBookMark = 30
      Case cptsProspectFindProspectID
         sProc = "pts_Prospect_FindComCustCampTypeProspectID"
         MaxBookMark = 20
      Case cptsProspectFindEmail
         sProc = "pts_Prospect_FindComCustCampTypeEmail"
         MaxBookMark = 90
      Case cptsProspectFindPhone1
         sProc = "pts_Prospect_FindComCustCampTypePhone1"
         MaxBookMark = 40
      Case cptsProspectFindLeadCampaignID
         sProc = "pts_Prospect_FindComCustCampTypeLeadCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindSalesCampaignID
         sProc = "pts_Prospect_FindComCustCampTypeSalesCampaignID"
         MaxBookMark = 20
      Case cptsProspectFindDescription
         sProc = "pts_Prospect_FindComCustCampTypeDescription"
         MaxBookMark = 2010
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@SalesCampaignID", adInteger, adParamInput, vbNull, CLng(bvSalesCampaignID))
      .Parameters.Append .CreateParameter("@ProspectTypeID", adInteger, adParamInput, vbNull, CLng(bvProspectTypeID))
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
               vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
               vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
               vRec.ProspectTypeName = moUtil.FetchString(.Fields.Item("ProspectTypeName").Value)
               vRec.CloseDate = moUtil.FetchDate(.Fields.Item("CloseDate").Value)
               vRec.Representing = moUtil.FetchString(.Fields.Item("Representing").Value)
               vRec.Priority = moUtil.FetchString(.Fields.Item("Priority").Value)
               vRec.Source = moUtil.FetchString(.Fields.Item("Source").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
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
   FindComCustCampType = vRecs

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

Public Function ExpMember( _ 
   ByVal bvFindType As Long, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvMemberID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ExpMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
   Dim idxRec As Integer
   Dim sProc As String
   Dim MaxLen As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   bvFindType = moUtil.EditLong(bvFindType, "Find Type", True, , 1) 
   bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsProspectFindProspectName
         sProc = "pts_Prospect_ExpMemberProspectName"
         MaxLen = 60
      Case cptsProspectFindContactName
         sProc = "pts_Prospect_ExpMemberContactName"
         MaxLen = 62
      Case cptsProspectFindCreateDate
         sProc = "pts_Prospect_ExpMemberCreateDate"
         MaxLen = 20
      Case cptsProspectFindPriority
         sProc = "pts_Prospect_ExpMemberPriority"
         MaxLen = 4
      Case cptsProspectFindSource
         sProc = "pts_Prospect_ExpMemberSource"
         MaxLen = 20
      Case cptsProspectFindRepresenting
         sProc = "pts_Prospect_ExpMemberRepresenting"
         MaxLen = 20
      Case cptsProspectFindProspectID
         sProc = "pts_Prospect_ExpMemberProspectID"
         MaxLen = 10
      Case cptsProspectFindEmail
         sProc = "pts_Prospect_ExpMemberEmail"
         MaxLen = 80
      Case cptsProspectFindPhone1
         sProc = "pts_Prospect_ExpMemberPhone1"
         MaxLen = 30
      Case cptsProspectFindLeadCampaignID
         sProc = "pts_Prospect_ExpMemberLeadCampaignID"
         MaxLen = 10
      Case cptsProspectFindSalesCampaignID
         sProc = "pts_Prospect_ExpMemberSalesCampaignID"
         MaxLen = 10
      Case cptsProspectFindDescription
         sProc = "pts_Prospect_ExpMemberDescription"
         MaxLen = 2000
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxLen, bvSearchText)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), sProc)

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
               vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
               vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
               vRec.ProspectTypeName = moUtil.FetchString(.Fields.Item("ProspectTypeName").Value)
               vRec.StatusName = moUtil.FetchString(.Fields.Item("StatusName").Value)
               vRec.NextEvent = moUtil.FetchLong(.Fields.Item("NextEvent").Value)
               vRec.NextDate = moUtil.FetchDate(.Fields.Item("NextDate").Value)
               vRec.NextTime = moUtil.FetchString(.Fields.Item("NextTime").Value)
               vRec.Representing = moUtil.FetchString(.Fields.Item("Representing").Value)
               vRec.Priority = moUtil.FetchString(.Fields.Item("Priority").Value)
               vRec.Source = moUtil.FetchString(.Fields.Item("Source").Value)
               vRec.Title = moUtil.FetchString(.Fields.Item("Title").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ExpMember = vRecs

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

Public Function ExpMemberStatus( _ 
   ByVal bvFindType As Long, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ExpMemberStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
   Dim idxRec As Integer
   Dim sProc As String
   Dim MaxLen As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   bvFindType = moUtil.EditLong(bvFindType, "Find Type", True, , 1) 
   bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True) 
   bvStatus = moUtil.EditLong(bvStatus, "Status", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsProspectFindProspectName
         sProc = "pts_Prospect_ExpMemberStatusProspectName"
         MaxLen = 60
      Case cptsProspectFindContactName
         sProc = "pts_Prospect_ExpMemberStatusContactName"
         MaxLen = 62
      Case cptsProspectFindCreateDate
         sProc = "pts_Prospect_ExpMemberStatusCreateDate"
         MaxLen = 20
      Case cptsProspectFindPriority
         sProc = "pts_Prospect_ExpMemberStatusPriority"
         MaxLen = 4
      Case cptsProspectFindSource
         sProc = "pts_Prospect_ExpMemberStatusSource"
         MaxLen = 20
      Case cptsProspectFindRepresenting
         sProc = "pts_Prospect_ExpMemberStatusRepresenting"
         MaxLen = 20
      Case cptsProspectFindProspectID
         sProc = "pts_Prospect_ExpMemberStatusProspectID"
         MaxLen = 10
      Case cptsProspectFindEmail
         sProc = "pts_Prospect_ExpMemberStatusEmail"
         MaxLen = 80
      Case cptsProspectFindPhone1
         sProc = "pts_Prospect_ExpMemberStatusPhone1"
         MaxLen = 30
      Case cptsProspectFindLeadCampaignID
         sProc = "pts_Prospect_ExpMemberStatusLeadCampaignID"
         MaxLen = 10
      Case cptsProspectFindSalesCampaignID
         sProc = "pts_Prospect_ExpMemberStatusSalesCampaignID"
         MaxLen = 10
      Case cptsProspectFindDescription
         sProc = "pts_Prospect_ExpMemberStatusDescription"
         MaxLen = 2000
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxLen, bvSearchText)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), sProc)

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
               vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
               vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
               vRec.ProspectTypeName = moUtil.FetchString(.Fields.Item("ProspectTypeName").Value)
               vRec.StatusName = moUtil.FetchString(.Fields.Item("StatusName").Value)
               vRec.NextEvent = moUtil.FetchLong(.Fields.Item("NextEvent").Value)
               vRec.NextDate = moUtil.FetchDate(.Fields.Item("NextDate").Value)
               vRec.NextTime = moUtil.FetchString(.Fields.Item("NextTime").Value)
               vRec.Representing = moUtil.FetchString(.Fields.Item("Representing").Value)
               vRec.Priority = moUtil.FetchString(.Fields.Item("Priority").Value)
               vRec.Source = moUtil.FetchString(.Fields.Item("Source").Value)
               vRec.Title = moUtil.FetchString(.Fields.Item("Title").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ExpMemberStatus = vRecs

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

Public Function ExpMemberActive( _ 
   ByVal bvFindType As Long, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvMemberID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ExpMemberActive"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
   Dim idxRec As Integer
   Dim sProc As String
   Dim MaxLen As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   bvFindType = moUtil.EditLong(bvFindType, "Find Type", True, , 1) 
   bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsProspectFindProspectName
         sProc = "pts_Prospect_ExpMemberActiveProspectName"
         MaxLen = 60
      Case cptsProspectFindContactName
         sProc = "pts_Prospect_ExpMemberActiveContactName"
         MaxLen = 62
      Case cptsProspectFindCreateDate
         sProc = "pts_Prospect_ExpMemberActiveCreateDate"
         MaxLen = 20
      Case cptsProspectFindPriority
         sProc = "pts_Prospect_ExpMemberActivePriority"
         MaxLen = 4
      Case cptsProspectFindSource
         sProc = "pts_Prospect_ExpMemberActiveSource"
         MaxLen = 20
      Case cptsProspectFindRepresenting
         sProc = "pts_Prospect_ExpMemberActiveRepresenting"
         MaxLen = 20
      Case cptsProspectFindProspectID
         sProc = "pts_Prospect_ExpMemberActiveProspectID"
         MaxLen = 10
      Case cptsProspectFindEmail
         sProc = "pts_Prospect_ExpMemberActiveEmail"
         MaxLen = 80
      Case cptsProspectFindPhone1
         sProc = "pts_Prospect_ExpMemberActivePhone1"
         MaxLen = 30
      Case cptsProspectFindLeadCampaignID
         sProc = "pts_Prospect_ExpMemberActiveLeadCampaignID"
         MaxLen = 10
      Case cptsProspectFindSalesCampaignID
         sProc = "pts_Prospect_ExpMemberActiveSalesCampaignID"
         MaxLen = 10
      Case cptsProspectFindDescription
         sProc = "pts_Prospect_ExpMemberActiveDescription"
         MaxLen = 2000
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxLen, bvSearchText)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), sProc)

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
               vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
               vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
               vRec.ProspectTypeName = moUtil.FetchString(.Fields.Item("ProspectTypeName").Value)
               vRec.StatusName = moUtil.FetchString(.Fields.Item("StatusName").Value)
               vRec.NextEvent = moUtil.FetchLong(.Fields.Item("NextEvent").Value)
               vRec.NextDate = moUtil.FetchDate(.Fields.Item("NextDate").Value)
               vRec.NextTime = moUtil.FetchString(.Fields.Item("NextTime").Value)
               vRec.Representing = moUtil.FetchString(.Fields.Item("Representing").Value)
               vRec.Priority = moUtil.FetchString(.Fields.Item("Priority").Value)
               vRec.Source = moUtil.FetchString(.Fields.Item("Source").Value)
               vRec.Title = moUtil.FetchString(.Fields.Item("Title").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ExpMemberActive = vRecs

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

Public Function ExpMemberLive( _ 
   ByVal bvFindType As Long, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvMemberID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ExpMemberLive"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
   Dim idxRec As Integer
   Dim sProc As String
   Dim MaxLen As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   bvFindType = moUtil.EditLong(bvFindType, "Find Type", True, , 1) 
   bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsProspectFindProspectName
         sProc = "pts_Prospect_ExpMemberLiveProspectName"
         MaxLen = 60
      Case cptsProspectFindContactName
         sProc = "pts_Prospect_ExpMemberLiveContactName"
         MaxLen = 62
      Case cptsProspectFindCreateDate
         sProc = "pts_Prospect_ExpMemberLiveCreateDate"
         MaxLen = 20
      Case cptsProspectFindPriority
         sProc = "pts_Prospect_ExpMemberLivePriority"
         MaxLen = 4
      Case cptsProspectFindSource
         sProc = "pts_Prospect_ExpMemberLiveSource"
         MaxLen = 20
      Case cptsProspectFindRepresenting
         sProc = "pts_Prospect_ExpMemberLiveRepresenting"
         MaxLen = 20
      Case cptsProspectFindProspectID
         sProc = "pts_Prospect_ExpMemberLiveProspectID"
         MaxLen = 10
      Case cptsProspectFindEmail
         sProc = "pts_Prospect_ExpMemberLiveEmail"
         MaxLen = 80
      Case cptsProspectFindPhone1
         sProc = "pts_Prospect_ExpMemberLivePhone1"
         MaxLen = 30
      Case cptsProspectFindLeadCampaignID
         sProc = "pts_Prospect_ExpMemberLiveLeadCampaignID"
         MaxLen = 10
      Case cptsProspectFindSalesCampaignID
         sProc = "pts_Prospect_ExpMemberLiveSalesCampaignID"
         MaxLen = 10
      Case cptsProspectFindDescription
         sProc = "pts_Prospect_ExpMemberLiveDescription"
         MaxLen = 2000
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxLen, bvSearchText)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), sProc)

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
               vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
               vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
               vRec.ProspectTypeName = moUtil.FetchString(.Fields.Item("ProspectTypeName").Value)
               vRec.StatusName = moUtil.FetchString(.Fields.Item("StatusName").Value)
               vRec.NextEvent = moUtil.FetchLong(.Fields.Item("NextEvent").Value)
               vRec.NextDate = moUtil.FetchDate(.Fields.Item("NextDate").Value)
               vRec.NextTime = moUtil.FetchString(.Fields.Item("NextTime").Value)
               vRec.Representing = moUtil.FetchString(.Fields.Item("Representing").Value)
               vRec.Priority = moUtil.FetchString(.Fields.Item("Priority").Value)
               vRec.Source = moUtil.FetchString(.Fields.Item("Source").Value)
               vRec.Title = moUtil.FetchString(.Fields.Item("Title").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ExpMemberLive = vRecs

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

Public Function ExpMemberService( _ 
   ByVal bvFindType As Long, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvSalesCampaignID As Long, _ 
   ByVal bvProspectTypeID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ExpMemberService"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
   Dim idxRec As Integer
   Dim sProc As String
   Dim MaxLen As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   bvFindType = moUtil.EditLong(bvFindType, "Find Type", True, , 1) 
   bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsProspectFindProspectName
         sProc = "pts_Prospect_ExpMemberServiceProspectName"
         MaxLen = 60
      Case cptsProspectFindContactName
         sProc = "pts_Prospect_ExpMemberServiceContactName"
         MaxLen = 62
      Case cptsProspectFindCreateDate
         sProc = "pts_Prospect_ExpMemberServiceCreateDate"
         MaxLen = 20
      Case cptsProspectFindPriority
         sProc = "pts_Prospect_ExpMemberServicePriority"
         MaxLen = 4
      Case cptsProspectFindSource
         sProc = "pts_Prospect_ExpMemberServiceSource"
         MaxLen = 20
      Case cptsProspectFindRepresenting
         sProc = "pts_Prospect_ExpMemberServiceRepresenting"
         MaxLen = 20
      Case cptsProspectFindProspectID
         sProc = "pts_Prospect_ExpMemberServiceProspectID"
         MaxLen = 10
      Case cptsProspectFindEmail
         sProc = "pts_Prospect_ExpMemberServiceEmail"
         MaxLen = 80
      Case cptsProspectFindPhone1
         sProc = "pts_Prospect_ExpMemberServicePhone1"
         MaxLen = 30
      Case cptsProspectFindLeadCampaignID
         sProc = "pts_Prospect_ExpMemberServiceLeadCampaignID"
         MaxLen = 10
      Case cptsProspectFindSalesCampaignID
         sProc = "pts_Prospect_ExpMemberServiceSalesCampaignID"
         MaxLen = 10
      Case cptsProspectFindDescription
         sProc = "pts_Prospect_ExpMemberServiceDescription"
         MaxLen = 2000
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxLen, bvSearchText)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@SalesCampaignID", adInteger, adParamInput, vbNull, CLng(bvSalesCampaignID))
      .Parameters.Append .CreateParameter("@ProspectTypeID", adInteger, adParamInput, vbNull, CLng(bvProspectTypeID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), sProc)

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
               vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
               vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
               vRec.ProspectTypeName = moUtil.FetchString(.Fields.Item("ProspectTypeName").Value)
               vRec.Representing = moUtil.FetchString(.Fields.Item("Representing").Value)
               vRec.Priority = moUtil.FetchString(.Fields.Item("Priority").Value)
               vRec.Source = moUtil.FetchString(.Fields.Item("Source").Value)
               vRec.Title = moUtil.FetchString(.Fields.Item("Title").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ExpMemberService = vRecs

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

Public Function ScheduleCompany( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ScheduleCompany"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(bvReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(bvReportToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Prospect_ScheduleCompany")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.StatusName = moUtil.FetchString(.Fields.Item("StatusName").Value)
            vRec.NextDate = moUtil.FetchDate(.Fields.Item("NextDate").Value)
            vRec.NextTime = moUtil.FetchString(.Fields.Item("NextTime").Value)
            vRec.NextEvent = moUtil.FetchLong(.Fields.Item("NextEvent").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ScheduleCompany = vRecs

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

Public Function ScheduleMember( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ScheduleMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(bvReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(bvReportToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Prospect_ScheduleMember")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.StatusName = moUtil.FetchString(.Fields.Item("StatusName").Value)
            vRec.NextDate = moUtil.FetchDate(.Fields.Item("NextDate").Value)
            vRec.NextTime = moUtil.FetchString(.Fields.Item("NextTime").Value)
            vRec.NextEvent = moUtil.FetchLong(.Fields.Item("NextEvent").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ScheduleMember = vRecs

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

Public Function BoardCompany( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvSalesCampaignID As Long) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "BoardCompany"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@SalesCampaignID", adInteger, adParamInput, vbNull, CLng(bvSalesCampaignID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Prospect_BoardCompany")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.Potential = moUtil.FetchCurrency(.Fields.Item("Potential").Value)
            vRec.NextDate = moUtil.FetchDate(.Fields.Item("NextDate").Value)
            vRec.NextTime = moUtil.FetchString(.Fields.Item("NextTime").Value)
            vRec.NextEvent = moUtil.FetchLong(.Fields.Item("NextEvent").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   BoardCompany = vRecs

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

Public Function BoardMember( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvSalesCampaignID As Long) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "BoardMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@SalesCampaignID", adInteger, adParamInput, vbNull, CLng(bvSalesCampaignID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Prospect_BoardMember")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.Potential = moUtil.FetchCurrency(.Fields.Item("Potential").Value)
            vRec.NextDate = moUtil.FetchDate(.Fields.Item("NextDate").Value)
            vRec.NextTime = moUtil.FetchString(.Fields.Item("NextTime").Value)
            vRec.NextEvent = moUtil.FetchLong(.Fields.Item("NextEvent").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   BoardMember = vRecs

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

Public Function BoardGroup( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvSalesCampaignID As Long) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "BoardGroup"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@SalesCampaignID", adInteger, adParamInput, vbNull, CLng(bvSalesCampaignID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Prospect_BoardGroup")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.Potential = moUtil.FetchCurrency(.Fields.Item("Potential").Value)
            vRec.NextDate = moUtil.FetchDate(.Fields.Item("NextDate").Value)
            vRec.NextTime = moUtil.FetchString(.Fields.Item("NextTime").Value)
            vRec.NextEvent = moUtil.FetchLong(.Fields.Item("NextEvent").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   BoardGroup = vRecs

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

Public Function FallbackCompany( _ 
   ByVal bvCompanyID As Long) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FallbackCompany"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Prospect_FallbackCompany")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.FBDate = moUtil.FetchDate(.Fields.Item("FBDate").Value)
            vRec.Potential = moUtil.FetchCurrency(.Fields.Item("Potential").Value)
            vRec.NextDate = moUtil.FetchDate(.Fields.Item("NextDate").Value)
            vRec.NextTime = moUtil.FetchString(.Fields.Item("NextTime").Value)
            vRec.NextEvent = moUtil.FetchLong(.Fields.Item("NextEvent").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   FallbackCompany = vRecs

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

Public Function FallbackMember( _ 
   ByVal bvMemberID As Long) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FallbackMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Prospect_FallbackMember")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.FBDate = moUtil.FetchDate(.Fields.Item("FBDate").Value)
            vRec.Potential = moUtil.FetchCurrency(.Fields.Item("Potential").Value)
            vRec.NextDate = moUtil.FetchDate(.Fields.Item("NextDate").Value)
            vRec.NextTime = moUtil.FetchString(.Fields.Item("NextTime").Value)
            vRec.NextEvent = moUtil.FetchLong(.Fields.Item("NextEvent").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   FallbackMember = vRecs

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

Public Function ClosedCompany( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ClosedCompany"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(bvReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(bvReportToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Prospect_ClosedCompany")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.CloseDate = moUtil.FetchDate(.Fields.Item("CloseDate").Value)
            vRec.Potential = moUtil.FetchCurrency(.Fields.Item("Potential").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ClosedCompany = vRecs

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

Public Function ClosedMember( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ClosedMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(bvReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(bvReportToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Prospect_ClosedMember")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.CloseDate = moUtil.FetchDate(.Fields.Item("CloseDate").Value)
            vRec.Potential = moUtil.FetchCurrency(.Fields.Item("Potential").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ClosedMember = vRecs

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

Public Function FACompany( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FACompany"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(bvReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(bvReportToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Prospect_FACompany")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.Date1 = moUtil.FetchDate(.Fields.Item("Date1").Value)
            vRec.Potential = moUtil.FetchCurrency(.Fields.Item("Potential").Value)
            vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   FACompany = vRecs

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

Public Function FAMember( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FAMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(bvReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(bvReportToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Prospect_FAMember")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.Date1 = moUtil.FetchDate(.Fields.Item("Date1").Value)
            vRec.Potential = moUtil.FetchCurrency(.Fields.Item("Potential").Value)
            vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   FAMember = vRecs

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

Public Function MemberDate( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvCreateDate As Date) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "MemberDate"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@CreateDate", adDate, adParamInput, vbNull, CDate(bvCreateDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Prospect_MemberDate")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
            vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
            vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
            vRec.CreateDate = moUtil.FetchDate(.Fields.Item("CreateDate").Value)
            vRec.Potential = moUtil.FetchCurrency(.Fields.Item("Potential").Value)
            vRec.NextDate = moUtil.FetchDate(.Fields.Item("NextDate").Value)
            vRec.NextTime = moUtil.FetchString(.Fields.Item("NextTime").Value)
            vRec.NextEvent = moUtil.FetchLong(.Fields.Item("NextEvent").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   MemberDate = vRecs

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

Public Function MemberActive( _ 
   ByVal bvMemberID As Long) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "MemberActive"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Prospect_MemberActive")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
            vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
            vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
            vRec.CreateDate = moUtil.FetchDate(.Fields.Item("CreateDate").Value)
            vRec.Potential = moUtil.FetchCurrency(.Fields.Item("Potential").Value)
            vRec.NextDate = moUtil.FetchDate(.Fields.Item("NextDate").Value)
            vRec.NextTime = moUtil.FetchString(.Fields.Item("NextTime").Value)
            vRec.NextEvent = moUtil.FetchLong(.Fields.Item("NextEvent").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   MemberActive = vRecs

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

Public Function ListEmail( _ 
   ByVal bvEmailID As Long) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListEmail"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@EmailID", adInteger, adParamInput, vbNull, CLng(bvEmailID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Prospect_ListEmail")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
            vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
            vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
            vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
            vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListEmail = vRecs

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

Public Function ListNewsLetter( _ 
   ByVal bvNewsLetterID As Long) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListNewsLetter"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@NewsLetterID", adInteger, adParamInput, vbNull, CLng(bvNewsLetterID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Prospect_ListNewsLetter")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
            vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
            vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListNewsLetter = vRecs

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

Public Function Distribution( _ 
   ByVal bvMemberID As Long) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Distribution"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Prospect_Distribution")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
            vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
            vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
            vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
            vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
            vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
            vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   Distribution = vRecs

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

Public Function DistributionProgram( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvLeadCampaignID As Long) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "DistributionProgram"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@LeadCampaignID", adInteger, adParamInput, vbNull, CLng(bvLeadCampaignID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Prospect_DistributionProgram")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
            vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
            vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
            vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
            vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
            vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
            vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   DistributionProgram = vRecs

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

Public Function Distributed( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Distributed"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(bvReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(bvReportToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Prospect_Distributed")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.Count = moUtil.FetchLong(.Fields.Item("Count").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   Distributed = vRecs

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

Public Function ListCustomers( _ 
   ByVal bvMemberID As Long) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListCustomers"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Prospect_ListCustomers")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
            vRec.Result = moUtil.FetchString(.Fields.Item("Result").Value)
            vRec.SalesCampaignName = moUtil.FetchString(.Fields.Item("SalesCampaignName").Value)
            vRec.ProspectTypeName = moUtil.FetchString(.Fields.Item("ProspectTypeName").Value)
            vRec.CloseDate = moUtil.FetchDate(.Fields.Item("CloseDate").Value)
            vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
            vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
            vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
            vRec.Title = moUtil.FetchString(.Fields.Item("Title").Value)
            vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
            vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
            vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
            vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
            vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
            vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
            vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
            vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
            vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListCustomers = vRecs

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

Public Function ListReminder( _ 
   ByVal bvUserID As Long) As tProspectType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListReminder"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProspectType
   Dim vRec As tProspectType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Prospect_ListReminder")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
            vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
            vRec.NextEvent = moUtil.FetchLong(.Fields.Item("NextEvent").Value)
            vRec.NextDate = moUtil.FetchDate(.Fields.Item("NextDate").Value)
            vRec.NextTime = moUtil.FetchString(.Fields.Item("NextTime").Value)
            vRec.Email2 = moUtil.FetchString(.Fields.Item("Email2").Value)
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.IsMsg = moUtil.FetchInteger(.Fields.Item("IsMsg").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListReminder = vRecs

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
   ByRef brRec As tProspectType, _ 
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
      .Parameters.Append .CreateParameter("@ProspectID", adInteger, adParamInput, vbNull, CLng(brRec.ProspectID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@SalesCampaignID", adInteger, adParamInput, vbNull, CLng(brRec.SalesCampaignID))
      .Parameters.Append .CreateParameter("@LeadCampaignID", adInteger, adParamInput, vbNull, CLng(brRec.LeadCampaignID))
      .Parameters.Append .CreateParameter("@PresentID", adInteger, adParamInput, vbNull, CLng(brRec.PresentID))
      .Parameters.Append .CreateParameter("@ProspectTypeID", adInteger, adParamInput, vbNull, CLng(brRec.ProspectTypeID))
      .Parameters.Append .CreateParameter("@EmailID", adInteger, adParamInput, vbNull, CLng(brRec.EmailID))
      .Parameters.Append .CreateParameter("@AffiliateID", adInteger, adParamInput, vbNull, CLng(brRec.AffiliateID))
      .Parameters.Append .CreateParameter("@NewsLetterID", adInteger, adParamInput, vbNull, CLng(brRec.NewsLetterID))
      .Parameters.Append .CreateParameter("@ProspectName", adVarWChar, adParamInput, 60, brRec.ProspectName)
      .Parameters.Append .CreateParameter("@Website", adVarWChar, adParamInput, 80, brRec.Website)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 2000, brRec.Description)
      .Parameters.Append .CreateParameter("@Representing", adVarWChar, adParamInput, 20, brRec.Representing)
      .Parameters.Append .CreateParameter("@Potential", adCurrency, adParamInput, vbNull, CCur(brRec.Potential))
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamInput, 30, brRec.NameLast)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamInput, 30, brRec.NameFirst)
      .Parameters.Append .CreateParameter("@Title", adVarWChar, adParamInput, 30, brRec.Title)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@Phone1", adVarWChar, adParamInput, 30, brRec.Phone1)
      .Parameters.Append .CreateParameter("@Phone2", adVarWChar, adParamInput, 30, brRec.Phone2)
      .Parameters.Append .CreateParameter("@Street", adVarWChar, adParamInput, 60, brRec.Street)
      .Parameters.Append .CreateParameter("@Unit", adVarWChar, adParamInput, 40, brRec.Unit)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamInput, 30, brRec.City)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamInput, 30, brRec.State)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamInput, 20, brRec.Zip)
      .Parameters.Append .CreateParameter("@Country", adVarWChar, adParamInput, 30, brRec.Country)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@NextEvent", adInteger, adParamInput, vbNull, CLng(brRec.NextEvent))
      .Parameters.Append .CreateParameter("@NextDate", adDate, adParamInput, vbNull, CDate(brRec.NextDate))
      .Parameters.Append .CreateParameter("@NextTime", adVarWChar, adParamInput, 8, brRec.NextTime)
      .Parameters.Append .CreateParameter("@CreateDate", adDate, adParamInput, vbNull, CDate(brRec.CreateDate))
      .Parameters.Append .CreateParameter("@FBDate", adDate, adParamInput, vbNull, CDate(brRec.FBDate))
      .Parameters.Append .CreateParameter("@CloseDate", adDate, adParamInput, vbNull, CDate(brRec.CloseDate))
      .Parameters.Append .CreateParameter("@DeadDate", adDate, adParamInput, vbNull, CDate(brRec.DeadDate))
      .Parameters.Append .CreateParameter("@Date1", adDate, adParamInput, vbNull, CDate(brRec.Date1))
      .Parameters.Append .CreateParameter("@Date2", adDate, adParamInput, vbNull, CDate(brRec.Date2))
      .Parameters.Append .CreateParameter("@Date3", adDate, adParamInput, vbNull, CDate(brRec.Date3))
      .Parameters.Append .CreateParameter("@Date4", adDate, adParamInput, vbNull, CDate(brRec.Date4))
      .Parameters.Append .CreateParameter("@Date5", adDate, adParamInput, vbNull, CDate(brRec.Date5))
      .Parameters.Append .CreateParameter("@Date6", adDate, adParamInput, vbNull, CDate(brRec.Date6))
      .Parameters.Append .CreateParameter("@Date7", adDate, adParamInput, vbNull, CDate(brRec.Date7))
      .Parameters.Append .CreateParameter("@Date8", adDate, adParamInput, vbNull, CDate(brRec.Date8))
      .Parameters.Append .CreateParameter("@Date9", adDate, adParamInput, vbNull, CDate(brRec.Date9))
      .Parameters.Append .CreateParameter("@Date10", adDate, adParamInput, vbNull, CDate(brRec.Date10))
      .Parameters.Append .CreateParameter("@ChangeDate", adDate, adParamInput, vbNull, CDate(brRec.ChangeDate))
      .Parameters.Append .CreateParameter("@ChangeStatus", adInteger, adParamInput, vbNull, CLng(brRec.ChangeStatus))
      .Parameters.Append .CreateParameter("@EmailDate", adDate, adParamInput, vbNull, CDate(brRec.EmailDate))
      .Parameters.Append .CreateParameter("@RSVP", adInteger, adParamInput, vbNull, CLng(brRec.RSVP))
      .Parameters.Append .CreateParameter("@EmailStatus", adInteger, adParamInput, vbNull, CLng(brRec.EmailStatus))
      .Parameters.Append .CreateParameter("@LeadViews", adInteger, adParamInput, vbNull, CLng(brRec.LeadViews))
      .Parameters.Append .CreateParameter("@LeadPages", adVarWChar, adParamInput, 10, brRec.LeadPages)
      .Parameters.Append .CreateParameter("@LeadReplies", adInteger, adParamInput, vbNull, CLng(brRec.LeadReplies))
      .Parameters.Append .CreateParameter("@PresentViews", adInteger, adParamInput, vbNull, CLng(brRec.PresentViews))
      .Parameters.Append .CreateParameter("@PresentPages", adVarWChar, adParamInput, 40, brRec.PresentPages)
      .Parameters.Append .CreateParameter("@NoDistribute", adSmallInt, adParamInput, vbNull, CInt(brRec.NoDistribute))
      .Parameters.Append .CreateParameter("@DistributorID", adInteger, adParamInput, vbNull, CLng(brRec.DistributorID))
      .Parameters.Append .CreateParameter("@DistributeDate", adDate, adParamInput, vbNull, CDate(brRec.DistributeDate))
      .Parameters.Append .CreateParameter("@Priority", adVarWChar, adParamInput, 4, brRec.Priority)
      .Parameters.Append .CreateParameter("@InputValues", adVarWChar, adParamInput, 1000, brRec.InputValues)
      .Parameters.Append .CreateParameter("@Source", adVarWChar, adParamInput, 20, brRec.Source)
      .Parameters.Append .CreateParameter("@Code", adInteger, adParamInput, vbNull, CLng(brRec.Code))
      .Parameters.Append .CreateParameter("@Reminder", adInteger, adParamInput, vbNull, CLng(brRec.Reminder))
      .Parameters.Append .CreateParameter("@RemindDate", adDate, adParamInput, vbNull, CDate(brRec.RemindDate))
      .Parameters.Append .CreateParameter("@TimeZone", adInteger, adParamInput, vbNull, CLng(brRec.TimeZone))
      .Parameters.Append .CreateParameter("@BestTime", adInteger, adParamInput, vbNull, CLng(brRec.BestTime))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Prospect_Update"

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
   ByRef brRec As tProspectType, _ 
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
         .ProspectID = moUtil.EditLong(.ProspectID, "ProspectID", True, , 1) 
      End If
      .CompanyID = moUtil.EditLong(.CompanyID, "CompanyID", False) 
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", False) 
      .SalesCampaignID = moUtil.EditLong(.SalesCampaignID, "SalesCampaignID", False) 
      .LeadCampaignID = moUtil.EditLong(.LeadCampaignID, "LeadCampaignID", False) 
      .PresentID = moUtil.EditLong(.PresentID, "PresentID", False) 
      .ProspectTypeID = moUtil.EditLong(.ProspectTypeID, "ProspectTypeID", False) 
      .EmailID = moUtil.EditLong(.EmailID, "EmailID", False) 
      .AffiliateID = moUtil.EditLong(.AffiliateID, "AffiliateID", False) 
      .NewsLetterID = moUtil.EditLong(.NewsLetterID, "NewsLetterID", False) 
      .ProspectName = moUtil.EditString(.ProspectName, "ProspectName", True, , 1, 60) 
      .Website = moUtil.EditString(.Website, "Website", False, , 1, 80) 
      .Description = moUtil.EditString(.Description, "Description", False, , 1, 2000) 
      .Representing = moUtil.EditString(.Representing, "Representing", False, , 1, 20) 
      .Potential = moUtil.EditCurrency(.Potential, "Potential", False, , 0, 99999999.99) 
      .NameLast = moUtil.EditString(.NameLast, "NameLast", False, , 1, 30) 
      .NameFirst = moUtil.EditString(.NameFirst, "NameFirst", False, , 1, 30) 
      .Title = moUtil.EditString(.Title, "Title", False, , 1, 30) 
      .Email = moUtil.EditString(.Email, "Email", False, , 1, 80) 
      .Phone1 = moUtil.EditString(.Phone1, "Phone1", False, , 1, 30) 
      .Phone2 = moUtil.EditString(.Phone2, "Phone2", False, , 1, 30) 
      .Street = moUtil.EditString(.Street, "Street", False, , 1, 60) 
      .Unit = moUtil.EditString(.Unit, "Unit", False, , 1, 40) 
      .City = moUtil.EditString(.City, "City", False, , 1, 30) 
      .State = moUtil.EditString(.State, "State", False, , 1, 30) 
      .Zip = moUtil.EditString(.Zip, "Zip", False, , 1, 20) 
      .Country = moUtil.EditString(.Country, "Country", False, , 1, 30) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .NextEvent = moUtil.EditLong(.NextEvent, "NextEvent", False) 
      .NextDate = moUtil.EditDate(.NextDate, "NextDate", False) 
      .NextTime = moUtil.EditString(.NextTime, "NextTime", False, , 1, 8) 
      .CreateDate = moUtil.EditDate(.CreateDate, "CreateDate", False) 
      .FBDate = moUtil.EditDate(.FBDate, "FBDate", False) 
      .CloseDate = moUtil.EditDate(.CloseDate, "CloseDate", False) 
      .DeadDate = moUtil.EditDate(.DeadDate, "DeadDate", False) 
      .Date1 = moUtil.EditDate(.Date1, "Date1", False) 
      .Date2 = moUtil.EditDate(.Date2, "Date2", False) 
      .Date3 = moUtil.EditDate(.Date3, "Date3", False) 
      .Date4 = moUtil.EditDate(.Date4, "Date4", False) 
      .Date5 = moUtil.EditDate(.Date5, "Date5", False) 
      .Date6 = moUtil.EditDate(.Date6, "Date6", False) 
      .Date7 = moUtil.EditDate(.Date7, "Date7", False) 
      .Date8 = moUtil.EditDate(.Date8, "Date8", False) 
      .Date9 = moUtil.EditDate(.Date9, "Date9", False) 
      .Date10 = moUtil.EditDate(.Date10, "Date10", False) 
      .ChangeDate = moUtil.EditDate(.ChangeDate, "ChangeDate", False) 
      .ChangeStatus = moUtil.EditLong(.ChangeStatus, "ChangeStatus", False) 
      .EmailDate = moUtil.EditDate(.EmailDate, "EmailDate", False) 
      .RSVP = moUtil.EditLong(.RSVP, "RSVP", False) 
      .EmailStatus = moUtil.EditLong(.EmailStatus, "EmailStatus", False) 
      .LeadViews = moUtil.EditLong(.LeadViews, "LeadViews", False) 
      .LeadPages = moUtil.EditString(.LeadPages, "LeadPages", False, , 1, 10) 
      .LeadReplies = moUtil.EditLong(.LeadReplies, "LeadReplies", False) 
      .PresentViews = moUtil.EditLong(.PresentViews, "PresentViews", False) 
      .PresentPages = moUtil.EditString(.PresentPages, "PresentPages", False, , 1, 40) 
      .NoDistribute = moUtil.EditInteger(.NoDistribute, "NoDistribute", False, 0, 0, 1) 
      .DistributorID = moUtil.EditLong(.DistributorID, "DistributorID", False) 
      .DistributeDate = moUtil.EditDate(.DistributeDate, "DistributeDate", False) 
      .Priority = moUtil.EditString(.Priority, "Priority", False) 
      .InputValues = moUtil.EditString(.InputValues, "InputValues", False, , 1, 1000) 
      .Source = moUtil.EditString(.Source, "Source", False, , 1, 20) 
      .Code = moUtil.EditLong(.Code, "Code", False) 
      .Reminder = moUtil.EditLong(.Reminder, "Reminder", False) 
      .RemindDate = moUtil.EditDate(.RemindDate, "RemindDate", False) 
      .TimeZone = moUtil.EditLong(.TimeZone, "TimeZone", False) 
      .BestTime = moUtil.EditLong(.BestTime, "BestTime", False) 
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