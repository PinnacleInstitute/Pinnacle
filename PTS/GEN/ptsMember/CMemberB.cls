VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CMemberB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CMember"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tMemberType
   MemberID As String
   AuthUserID As String
   WebsiteID As String
   CompanyID As String
   PromoID As String
   BillingID As String
   PayID As String
   ReferralID As String
   SponsorID As String
   Sponsor2ID As String
   Sponsor3ID As String
   MentorID As String
   UserGroup As String
   UserStatus As String
   Logon As String
   CompanyName As String
   NameLast As String
   NameFirst As String
   MemberName As String
   BV As String
   QV As String
   BV2 As String
   QV2 As String
   BV3 As String
   QV3 As String
   BV4 As String
   QV4 As String
   Qualify As String
   QualifyDate As String
   Email As String
   Email2 As String
   Phone1 As String
   Phone2 As String
   Fax As String
   Status As String
   Level As String
   Newsletter As String
   EnrollDate As String
   EndDate As String
   InitPrice As String
   Price As String
   Retail As String
   BusAccts As String
   BusAcctPrice As String
   BusAcctRetail As String
   IsDiscount As String
   Discount As String
   IsCompany As String
   Billing As String
   AccessLimit As String
   QuizLimit As String
   Reference As String
   Referral As String
   TrialDays As String
   MasterID As String
   IsIncluded As String
   IsMaster As String
   MasterPrice As String
   MasterMembers As String
   MaxMembers As String
   VisitDate As String
   TaxIDType As String
   TaxID As String
   AutoShipDate As String
   PaidDate As String
   StatusDate As String
   StatusChange As String
   LevelChange As String
   IsRemoved As String
   GroupID As String
   Role As String
   Secure As String
   Options As String
   Options2 As String
   Pos As String
   Signature As String
   SocNet As String
   ConfLine As String
   NotifyMentor As String
   Image As String
   Identification As String
   Title As String
   Title2 As String
   MinTitle As String
   TitleDate As String
   InputValues As String
   Icons As String
   IsMsg As String
   Timezone As String
   Process As String
   NewLogon As String
   NewPassword As String
   ReportFromDate As String
   ReportToDate As String
   Quantity As String
   Amount As String
   OrgID As String
   InputOptions As String
   Unit As String
End Type

Public Sub Add( _ 
   ByRef brRec As tMemberType, _ 
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
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@WebsiteID", adInteger, adParamInput, vbNull, CLng(brRec.WebsiteID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@PromoID", adInteger, adParamInput, vbNull, CLng(brRec.PromoID))
      .Parameters.Append .CreateParameter("@BillingID", adInteger, adParamInput, vbNull, CLng(brRec.BillingID))
      .Parameters.Append .CreateParameter("@PayID", adInteger, adParamInput, vbNull, CLng(brRec.PayID))
      .Parameters.Append .CreateParameter("@ReferralID", adInteger, adParamInput, vbNull, CLng(brRec.ReferralID))
      .Parameters.Append .CreateParameter("@SponsorID", adInteger, adParamInput, vbNull, CLng(brRec.SponsorID))
      .Parameters.Append .CreateParameter("@Sponsor2ID", adInteger, adParamInput, vbNull, CLng(brRec.Sponsor2ID))
      .Parameters.Append .CreateParameter("@Sponsor3ID", adInteger, adParamInput, vbNull, CLng(brRec.Sponsor3ID))
      .Parameters.Append .CreateParameter("@MentorID", adInteger, adParamInput, vbNull, CLng(brRec.MentorID))
      .Parameters.Append .CreateParameter("@UserGroup", adInteger, adParamInput, vbNull, CLng(brRec.UserGroup))
      .Parameters.Append .CreateParameter("@UserStatus", adInteger, adParamInput, vbNull, CLng(brRec.UserStatus))
      .Parameters.Append .CreateParameter("@CompanyName", adVarWChar, adParamInput, 60, brRec.CompanyName)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamInput, 30, brRec.NameLast)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamInput, 30, brRec.NameFirst)
      .Parameters.Append .CreateParameter("@BV", adCurrency, adParamInput, vbNull, CCur(brRec.BV))
      .Parameters.Append .CreateParameter("@QV", adCurrency, adParamInput, vbNull, CCur(brRec.QV))
      .Parameters.Append .CreateParameter("@BV2", adCurrency, adParamInput, vbNull, CCur(brRec.BV2))
      .Parameters.Append .CreateParameter("@QV2", adCurrency, adParamInput, vbNull, CCur(brRec.QV2))
      .Parameters.Append .CreateParameter("@BV3", adCurrency, adParamInput, vbNull, CCur(brRec.BV3))
      .Parameters.Append .CreateParameter("@QV3", adCurrency, adParamInput, vbNull, CCur(brRec.QV3))
      .Parameters.Append .CreateParameter("@BV4", adCurrency, adParamInput, vbNull, CCur(brRec.BV4))
      .Parameters.Append .CreateParameter("@QV4", adCurrency, adParamInput, vbNull, CCur(brRec.QV4))
      .Parameters.Append .CreateParameter("@Qualify", adInteger, adParamInput, vbNull, CLng(brRec.Qualify))
      .Parameters.Append .CreateParameter("@QualifyDate", adDate, adParamInput, vbNull, CDate(brRec.QualifyDate))
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@Email2", adVarWChar, adParamInput, 80, brRec.Email2)
      .Parameters.Append .CreateParameter("@Phone1", adVarWChar, adParamInput, 30, brRec.Phone1)
      .Parameters.Append .CreateParameter("@Phone2", adVarWChar, adParamInput, 30, brRec.Phone2)
      .Parameters.Append .CreateParameter("@Fax", adVarWChar, adParamInput, 30, brRec.Fax)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Level", adInteger, adParamInput, vbNull, CLng(brRec.Level))
      .Parameters.Append .CreateParameter("@Newsletter", adInteger, adParamInput, vbNull, CLng(brRec.Newsletter))
      .Parameters.Append .CreateParameter("@EnrollDate", adDate, adParamInput, vbNull, CDate(brRec.EnrollDate))
      .Parameters.Append .CreateParameter("@EndDate", adDate, adParamInput, vbNull, CDate(brRec.EndDate))
      .Parameters.Append .CreateParameter("@InitPrice", adCurrency, adParamInput, vbNull, CCur(brRec.InitPrice))
      .Parameters.Append .CreateParameter("@Price", adCurrency, adParamInput, vbNull, CCur(brRec.Price))
      .Parameters.Append .CreateParameter("@Retail", adCurrency, adParamInput, vbNull, CCur(brRec.Retail))
      .Parameters.Append .CreateParameter("@BusAccts", adInteger, adParamInput, vbNull, CLng(brRec.BusAccts))
      .Parameters.Append .CreateParameter("@BusAcctPrice", adCurrency, adParamInput, vbNull, CCur(brRec.BusAcctPrice))
      .Parameters.Append .CreateParameter("@BusAcctRetail", adCurrency, adParamInput, vbNull, CCur(brRec.BusAcctRetail))
      .Parameters.Append .CreateParameter("@IsDiscount", adSmallInt, adParamInput, vbNull, CInt(brRec.IsDiscount))
      .Parameters.Append .CreateParameter("@Discount", adCurrency, adParamInput, vbNull, CCur(brRec.Discount))
      .Parameters.Append .CreateParameter("@IsCompany", adSmallInt, adParamInput, vbNull, CInt(brRec.IsCompany))
      .Parameters.Append .CreateParameter("@Billing", adInteger, adParamInput, vbNull, CLng(brRec.Billing))
      .Parameters.Append .CreateParameter("@AccessLimit", adVarWChar, adParamInput, 50, brRec.AccessLimit)
      .Parameters.Append .CreateParameter("@QuizLimit", adInteger, adParamInput, vbNull, CLng(brRec.QuizLimit))
      .Parameters.Append .CreateParameter("@Reference", adVarWChar, adParamInput, 15, brRec.Reference)
      .Parameters.Append .CreateParameter("@Referral", adVarWChar, adParamInput, 15, brRec.Referral)
      .Parameters.Append .CreateParameter("@TrialDays", adInteger, adParamInput, vbNull, CLng(brRec.TrialDays))
      .Parameters.Append .CreateParameter("@MasterID", adInteger, adParamInput, vbNull, CLng(brRec.MasterID))
      .Parameters.Append .CreateParameter("@IsIncluded", adSmallInt, adParamInput, vbNull, CInt(brRec.IsIncluded))
      .Parameters.Append .CreateParameter("@IsMaster", adSmallInt, adParamInput, vbNull, CInt(brRec.IsMaster))
      .Parameters.Append .CreateParameter("@MasterPrice", adCurrency, adParamInput, vbNull, CCur(brRec.MasterPrice))
      .Parameters.Append .CreateParameter("@MasterMembers", adInteger, adParamInput, vbNull, CLng(brRec.MasterMembers))
      .Parameters.Append .CreateParameter("@MaxMembers", adInteger, adParamInput, vbNull, CLng(brRec.MaxMembers))
      .Parameters.Append .CreateParameter("@VisitDate", adDate, adParamInput, vbNull, CDate(brRec.VisitDate))
      .Parameters.Append .CreateParameter("@TaxIDType", adInteger, adParamInput, vbNull, CLng(brRec.TaxIDType))
      .Parameters.Append .CreateParameter("@TaxID", adVarWChar, adParamInput, 15, brRec.TaxID)
      .Parameters.Append .CreateParameter("@AutoShipDate", adDate, adParamInput, vbNull, CDate(brRec.AutoShipDate))
      .Parameters.Append .CreateParameter("@PaidDate", adDate, adParamInput, vbNull, CDate(brRec.PaidDate))
      .Parameters.Append .CreateParameter("@StatusDate", adDate, adParamInput, vbNull, CDate(brRec.StatusDate))
      .Parameters.Append .CreateParameter("@StatusChange", adInteger, adParamInput, vbNull, CLng(brRec.StatusChange))
      .Parameters.Append .CreateParameter("@LevelChange", adInteger, adParamInput, vbNull, CLng(brRec.LevelChange))
      .Parameters.Append .CreateParameter("@IsRemoved", adSmallInt, adParamInput, vbNull, CInt(brRec.IsRemoved))
      .Parameters.Append .CreateParameter("@GroupID", adInteger, adParamInput, vbNull, CLng(brRec.GroupID))
      .Parameters.Append .CreateParameter("@Role", adVarWChar, adParamInput, 15, brRec.Role)
      .Parameters.Append .CreateParameter("@Secure", adInteger, adParamInput, vbNull, CLng(brRec.Secure))
      .Parameters.Append .CreateParameter("@Options", adVarWChar, adParamInput, 20, brRec.Options)
      .Parameters.Append .CreateParameter("@Options2", adVarWChar, adParamInput, 40, brRec.Options2)
      .Parameters.Append .CreateParameter("@Pos", adInteger, adParamInput, vbNull, CLng(brRec.Pos))
      .Parameters.Append .CreateParameter("@Signature", adVarWChar, adParamInput, 1000, brRec.Signature)
      .Parameters.Append .CreateParameter("@SocNet", adVarWChar, adParamInput, 200, brRec.SocNet)
      .Parameters.Append .CreateParameter("@ConfLine", adVarWChar, adParamInput, 40, brRec.ConfLine)
      .Parameters.Append .CreateParameter("@NotifyMentor", adVarWChar, adParamInput, 10, brRec.NotifyMentor)
      .Parameters.Append .CreateParameter("@Image", adVarWChar, adParamInput, 15, brRec.Image)
      .Parameters.Append .CreateParameter("@Identification", adVarWChar, adParamInput, 150, brRec.Identification)
      .Parameters.Append .CreateParameter("@Title", adInteger, adParamInput, vbNull, CLng(brRec.Title))
      .Parameters.Append .CreateParameter("@Title2", adInteger, adParamInput, vbNull, CLng(brRec.Title2))
      .Parameters.Append .CreateParameter("@MinTitle", adInteger, adParamInput, vbNull, CLng(brRec.MinTitle))
      .Parameters.Append .CreateParameter("@TitleDate", adDate, adParamInput, vbNull, CDate(brRec.TitleDate))
      .Parameters.Append .CreateParameter("@InputValues", adVarWChar, adParamInput, 1000, brRec.InputValues)
      .Parameters.Append .CreateParameter("@Icons", adVarWChar, adParamInput, 20, brRec.Icons)
      .Parameters.Append .CreateParameter("@IsMsg", adInteger, adParamInput, vbNull, CLng(brRec.IsMsg))
      .Parameters.Append .CreateParameter("@Timezone", adInteger, adParamInput, vbNull, CLng(brRec.Timezone))
      .Parameters.Append .CreateParameter("@Process", adInteger, adParamInput, vbNull, CLng(brRec.Process))
      .Parameters.Append .CreateParameter("@NewLogon", adVarWChar, adParamInput, 80, brRec.NewLogon)
      .Parameters.Append .CreateParameter("@NewPassword", adVarWChar, adParamInput, 30, brRec.NewPassword)
      .Parameters.Append .CreateParameter("@Unit", adVarWChar, adParamInput, 40, brRec.Unit)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_Add"

   '-----get return values
   With brRec
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .AuthUserID = moUtil.FetchLong(oCmd.Parameters.Item("@AuthUserID").Value)
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

Public Function AddOrgMember( _ 
   ByRef brRec As tMemberType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "AddOrgMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", True, 0, 1) 
      .OrgID = moUtil.EditLong(.OrgID, "OrgID", True, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@OrgID", adInteger, adParamInput, vbNull, CLng(brRec.OrgID))
      .Parameters.Append .CreateParameter("@Exists", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_AddOrgMember"

   '-----get return values
   AddOrgMember = moUtil.FetchLong(oCmd.Parameters.Item("@Exists").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function CheckMaster( _ 
   ByRef brRec As tMemberType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CheckMaster"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MasterID", adInteger, adParamInput, vbNull, CLng(brRec.MasterID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_CheckMaster"

   '-----get return values
   CheckMaster = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function ActiveCount( _ 
   ByRef brRec As tMemberType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ActiveCount"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@MasterID", adInteger, adParamInput, vbNull, CLng(brRec.MasterID))
      .Parameters.Append .CreateParameter("@MasterMembers", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_ActiveCount"

   '-----get return values
   ActiveCount = moUtil.FetchLong(oCmd.Parameters.Item("@MasterMembers").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function MaxCount( _ 
   ByRef brRec As tMemberType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "MaxCount"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MasterID", adInteger, adParamInput, vbNull, CLng(brRec.MasterID))
      .Parameters.Append .CreateParameter("@MaxMembers", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_MaxCount"

   '-----get return values
   MaxCount = moUtil.FetchLong(oCmd.Parameters.Item("@MaxMembers").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function ExistEmail( _ 
   ByRef brRec As tMemberType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ExistEmail"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_ExistEmail"

   '-----get return values
   ExistEmail = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function RefRef( _ 
   ByRef brRec As tMemberType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "RefRef"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@Reference", adVarWChar, adParamInput, 15, brRec.Reference)
      .Parameters.Append .CreateParameter("@ReferralID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_RefRef"

   '-----get return values
   RefRef = moUtil.FetchLong(oCmd.Parameters.Item("@ReferralID").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function TBCount( _ 
   ByRef brRec As tMemberType, _ 
   ByVal bvUserID As Long) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "TBCount"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@VisitDate", adDate, adParamInput, vbNull, CDate(brRec.VisitDate))
      .Parameters.Append .CreateParameter("@Result", adVarWChar, adParamOutput, 1000, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_TBCount"

   '-----get return values
   TBCount = moUtil.FetchString(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function Dashboard( _ 
   ByRef brRec As tMemberType, _ 
   ByVal bvUserID As Long) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Dashboard"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamInput, vbNull, CLng(brRec.AuthUserID))
      .Parameters.Append .CreateParameter("@VisitDate", adDate, adParamInput, vbNull, CDate(brRec.VisitDate))
      .Parameters.Append .CreateParameter("@CompanyName", adVarWChar, adParamInput, 60, brRec.CompanyName)
      .Parameters.Append .CreateParameter("@Result", adVarWChar, adParamOutput, 1000, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_Dashboard"

   '-----get return values
   Dashboard = moUtil.FetchString(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function Performance( _ 
   ByRef brRec As tMemberType, _ 
   ByVal bvUserID As Long) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Performance"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(brRec.ReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(brRec.ReportToDate))
      .Parameters.Append .CreateParameter("@CompanyName", adVarWChar, adParamInput, 60, brRec.CompanyName)
      .Parameters.Append .CreateParameter("@Result", adVarWChar, adParamOutput, 1000, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_Performance"

   '-----get return values
   Performance = moUtil.FetchString(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function GetSignature( _ 
   ByRef brRec As tMemberType, _ 
   ByVal bvUserID As Long) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "GetSignature"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@Quantity", adInteger, adParamInput, vbNull, CLng(brRec.Quantity))
      .Parameters.Append .CreateParameter("@Amount", adInteger, adParamInput, vbNull, CLng(brRec.Amount))
      .Parameters.Append .CreateParameter("@Fax", adVarWChar, adParamInput, 30, brRec.Fax)
      .Parameters.Append .CreateParameter("@Result", adVarWChar, adParamOutput, 3000, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_GetSignature"

   '-----get return values
   GetSignature = moUtil.FetchString(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function GetIsMsg( _ 
   ByRef brRec As tMemberType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "GetIsMsg"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_GetIsMsg"

   '-----get return values
   GetIsMsg = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function Custom( _ 
   ByRef brRec As tMemberType, _ 
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
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Result", adVarWChar, adParamOutput, 1000, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_Custom"

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

Public Function SearchDownline( _ 
   ByRef brRec As tMemberType, _ 
   ByVal bvUserID As Long) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "SearchDownline"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@SponsorID", adInteger, adParamInput, vbNull, CLng(brRec.SponsorID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@CompanyName", adVarWChar, adParamInput, 60, brRec.CompanyName)
      .Parameters.Append .CreateParameter("@Level", adInteger, adParamInput, vbNull, CLng(brRec.Level))
      .Parameters.Append .CreateParameter("@Result", adVarWChar, adParamOutput, 100, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_SearchDownline"

   '-----get return values
   SearchDownline = moUtil.FetchString(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function CheckUpline( _ 
   ByRef brRec As tMemberType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CheckUpline"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SponsorID", adInteger, adParamInput, vbNull, CLng(brRec.SponsorID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_CheckUpline"

   '-----get return values
   CheckUpline = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function TotalCustomers( _ 
   ByRef brRec As tMemberType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "TotalCustomers"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_TotalCustomers"

   '-----get return values
   TotalCustomers = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Sub DeleteOrgMember( _ 
   ByRef brRec As tMemberType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Execute a Command
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "DeleteOrgMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", True, 0, 1) 
      .OrgID = moUtil.EditLong(.OrgID, "OrgID", False, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@OrgID", adInteger, adParamInput, vbNull, CLng(brRec.OrgID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_DeleteOrgMember"

   '-----clean up
   Set oCmd = Nothing

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub CalcMasterPrice( _ 
   ByRef brRec As tMemberType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Execute a Command
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CalcMasterPrice"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_CalcMasterPrice"

   '-----clean up
   Set oCmd = Nothing

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub DeleteMaster( _ 
   ByRef brRec As tMemberType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Execute a Command
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "DeleteMaster"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_DeleteMaster"

   '-----clean up
   Set oCmd = Nothing

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub RemoveMember( _ 
   ByRef brRec As tMemberType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Execute a Command
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "RemoveMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", True, 0, 1) 
      .Status = moUtil.EditLong(.Status, "Status", True, 0) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_RemoveMember"

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
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_Count"

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
   ByRef brRec As tMemberType, _ 
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
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_Delete"

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
   ByRef brRec As tMemberType, _ 
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
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@WebsiteID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PromoID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BillingID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PayID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ReferralID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SponsorID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Sponsor2ID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Sponsor3ID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MentorID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserGroup", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserStatus", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Logon", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@CompanyName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@MemberName", adVarWChar, adParamOutput, 62, vbNull)
      .Parameters.Append .CreateParameter("@BV", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@QV", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BV2", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@QV2", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BV3", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@QV3", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BV4", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@QV4", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Qualify", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@QualifyDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@Email2", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@Phone1", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Phone2", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Fax", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Level", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Newsletter", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@EnrollDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@EndDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@InitPrice", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Price", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Retail", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BusAccts", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BusAcctPrice", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BusAcctRetail", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsDiscount", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Discount", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsCompany", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Billing", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AccessLimit", adVarWChar, adParamOutput, 50, vbNull)
      .Parameters.Append .CreateParameter("@QuizLimit", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Reference", adVarWChar, adParamOutput, 15, vbNull)
      .Parameters.Append .CreateParameter("@Referral", adVarWChar, adParamOutput, 15, vbNull)
      .Parameters.Append .CreateParameter("@TrialDays", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MasterID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsIncluded", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsMaster", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MasterPrice", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MasterMembers", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MaxMembers", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@VisitDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@TaxIDType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@TaxID", adVarWChar, adParamOutput, 15, vbNull)
      .Parameters.Append .CreateParameter("@AutoShipDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PaidDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@StatusDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@StatusChange", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@LevelChange", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsRemoved", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@GroupID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Role", adVarWChar, adParamOutput, 15, vbNull)
      .Parameters.Append .CreateParameter("@Secure", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Options", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@Options2", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@Pos", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Signature", adVarWChar, adParamOutput, 1000, vbNull)
      .Parameters.Append .CreateParameter("@SocNet", adVarWChar, adParamOutput, 200, vbNull)
      .Parameters.Append .CreateParameter("@ConfLine", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@NotifyMentor", adVarWChar, adParamOutput, 10, vbNull)
      .Parameters.Append .CreateParameter("@Image", adVarWChar, adParamOutput, 15, vbNull)
      .Parameters.Append .CreateParameter("@Identification", adVarWChar, adParamOutput, 150, vbNull)
      .Parameters.Append .CreateParameter("@Title", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Title2", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MinTitle", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@TitleDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@InputValues", adVarWChar, adParamOutput, 1000, vbNull)
      .Parameters.Append .CreateParameter("@Icons", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@IsMsg", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Timezone", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Process", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_Fetch"

   '-----get return values
   With brRec
      .AuthUserID = moUtil.FetchLong(oCmd.Parameters.Item("@AuthUserID").Value)
      .WebsiteID = moUtil.FetchLong(oCmd.Parameters.Item("@WebsiteID").Value)
      .CompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@CompanyID").Value)
      .PromoID = moUtil.FetchLong(oCmd.Parameters.Item("@PromoID").Value)
      .BillingID = moUtil.FetchLong(oCmd.Parameters.Item("@BillingID").Value)
      .PayID = moUtil.FetchLong(oCmd.Parameters.Item("@PayID").Value)
      .ReferralID = moUtil.FetchLong(oCmd.Parameters.Item("@ReferralID").Value)
      .SponsorID = moUtil.FetchLong(oCmd.Parameters.Item("@SponsorID").Value)
      .Sponsor2ID = moUtil.FetchLong(oCmd.Parameters.Item("@Sponsor2ID").Value)
      .Sponsor3ID = moUtil.FetchLong(oCmd.Parameters.Item("@Sponsor3ID").Value)
      .MentorID = moUtil.FetchLong(oCmd.Parameters.Item("@MentorID").Value)
      .UserGroup = moUtil.FetchLong(oCmd.Parameters.Item("@UserGroup").Value)
      .UserStatus = moUtil.FetchLong(oCmd.Parameters.Item("@UserStatus").Value)
      .Logon = moUtil.FetchString(oCmd.Parameters.Item("@Logon").Value)
      .CompanyName = moUtil.FetchString(oCmd.Parameters.Item("@CompanyName").Value)
      .NameLast = moUtil.FetchString(oCmd.Parameters.Item("@NameLast").Value)
      .NameFirst = moUtil.FetchString(oCmd.Parameters.Item("@NameFirst").Value)
      .MemberName = moUtil.FetchString(oCmd.Parameters.Item("@MemberName").Value)
      .BV = moUtil.FetchCurrency(oCmd.Parameters.Item("@BV").Value)
      .QV = moUtil.FetchCurrency(oCmd.Parameters.Item("@QV").Value)
      .BV2 = moUtil.FetchCurrency(oCmd.Parameters.Item("@BV2").Value)
      .QV2 = moUtil.FetchCurrency(oCmd.Parameters.Item("@QV2").Value)
      .BV3 = moUtil.FetchCurrency(oCmd.Parameters.Item("@BV3").Value)
      .QV3 = moUtil.FetchCurrency(oCmd.Parameters.Item("@QV3").Value)
      .BV4 = moUtil.FetchCurrency(oCmd.Parameters.Item("@BV4").Value)
      .QV4 = moUtil.FetchCurrency(oCmd.Parameters.Item("@QV4").Value)
      .Qualify = moUtil.FetchLong(oCmd.Parameters.Item("@Qualify").Value)
      .QualifyDate = moUtil.FetchDate(oCmd.Parameters.Item("@QualifyDate").Value)
      .Email = moUtil.FetchString(oCmd.Parameters.Item("@Email").Value)
      .Email2 = moUtil.FetchString(oCmd.Parameters.Item("@Email2").Value)
      .Phone1 = moUtil.FetchString(oCmd.Parameters.Item("@Phone1").Value)
      .Phone2 = moUtil.FetchString(oCmd.Parameters.Item("@Phone2").Value)
      .Fax = moUtil.FetchString(oCmd.Parameters.Item("@Fax").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .Level = moUtil.FetchLong(oCmd.Parameters.Item("@Level").Value)
      .Newsletter = moUtil.FetchLong(oCmd.Parameters.Item("@Newsletter").Value)
      .EnrollDate = moUtil.FetchDate(oCmd.Parameters.Item("@EnrollDate").Value)
      .EndDate = moUtil.FetchDate(oCmd.Parameters.Item("@EndDate").Value)
      .InitPrice = moUtil.FetchCurrency(oCmd.Parameters.Item("@InitPrice").Value)
      .Price = moUtil.FetchCurrency(oCmd.Parameters.Item("@Price").Value)
      .Retail = moUtil.FetchCurrency(oCmd.Parameters.Item("@Retail").Value)
      .BusAccts = moUtil.FetchLong(oCmd.Parameters.Item("@BusAccts").Value)
      .BusAcctPrice = moUtil.FetchCurrency(oCmd.Parameters.Item("@BusAcctPrice").Value)
      .BusAcctRetail = moUtil.FetchCurrency(oCmd.Parameters.Item("@BusAcctRetail").Value)
      .IsDiscount = moUtil.FetchInteger(oCmd.Parameters.Item("@IsDiscount").Value)
      .Discount = moUtil.FetchCurrency(oCmd.Parameters.Item("@Discount").Value)
      .IsCompany = moUtil.FetchInteger(oCmd.Parameters.Item("@IsCompany").Value)
      .Billing = moUtil.FetchLong(oCmd.Parameters.Item("@Billing").Value)
      .AccessLimit = moUtil.FetchString(oCmd.Parameters.Item("@AccessLimit").Value)
      .QuizLimit = moUtil.FetchLong(oCmd.Parameters.Item("@QuizLimit").Value)
      .Reference = moUtil.FetchString(oCmd.Parameters.Item("@Reference").Value)
      .Referral = moUtil.FetchString(oCmd.Parameters.Item("@Referral").Value)
      .TrialDays = moUtil.FetchLong(oCmd.Parameters.Item("@TrialDays").Value)
      .MasterID = moUtil.FetchLong(oCmd.Parameters.Item("@MasterID").Value)
      .IsIncluded = moUtil.FetchInteger(oCmd.Parameters.Item("@IsIncluded").Value)
      .IsMaster = moUtil.FetchInteger(oCmd.Parameters.Item("@IsMaster").Value)
      .MasterPrice = moUtil.FetchCurrency(oCmd.Parameters.Item("@MasterPrice").Value)
      .MasterMembers = moUtil.FetchLong(oCmd.Parameters.Item("@MasterMembers").Value)
      .MaxMembers = moUtil.FetchLong(oCmd.Parameters.Item("@MaxMembers").Value)
      .VisitDate = moUtil.FetchDate(oCmd.Parameters.Item("@VisitDate").Value)
      .TaxIDType = moUtil.FetchLong(oCmd.Parameters.Item("@TaxIDType").Value)
      .TaxID = moUtil.FetchString(oCmd.Parameters.Item("@TaxID").Value)
      .AutoShipDate = moUtil.FetchDate(oCmd.Parameters.Item("@AutoShipDate").Value)
      .PaidDate = moUtil.FetchDate(oCmd.Parameters.Item("@PaidDate").Value)
      .StatusDate = moUtil.FetchDate(oCmd.Parameters.Item("@StatusDate").Value)
      .StatusChange = moUtil.FetchLong(oCmd.Parameters.Item("@StatusChange").Value)
      .LevelChange = moUtil.FetchLong(oCmd.Parameters.Item("@LevelChange").Value)
      .IsRemoved = moUtil.FetchInteger(oCmd.Parameters.Item("@IsRemoved").Value)
      .GroupID = moUtil.FetchLong(oCmd.Parameters.Item("@GroupID").Value)
      .Role = moUtil.FetchString(oCmd.Parameters.Item("@Role").Value)
      .Secure = moUtil.FetchLong(oCmd.Parameters.Item("@Secure").Value)
      .Options = moUtil.FetchString(oCmd.Parameters.Item("@Options").Value)
      .Options2 = moUtil.FetchString(oCmd.Parameters.Item("@Options2").Value)
      .Pos = moUtil.FetchLong(oCmd.Parameters.Item("@Pos").Value)
      .Signature = moUtil.FetchString(oCmd.Parameters.Item("@Signature").Value)
      .SocNet = moUtil.FetchString(oCmd.Parameters.Item("@SocNet").Value)
      .ConfLine = moUtil.FetchString(oCmd.Parameters.Item("@ConfLine").Value)
      .NotifyMentor = moUtil.FetchString(oCmd.Parameters.Item("@NotifyMentor").Value)
      .Image = moUtil.FetchString(oCmd.Parameters.Item("@Image").Value)
      .Identification = moUtil.FetchString(oCmd.Parameters.Item("@Identification").Value)
      .Title = moUtil.FetchLong(oCmd.Parameters.Item("@Title").Value)
      .Title2 = moUtil.FetchLong(oCmd.Parameters.Item("@Title2").Value)
      .MinTitle = moUtil.FetchLong(oCmd.Parameters.Item("@MinTitle").Value)
      .TitleDate = moUtil.FetchDate(oCmd.Parameters.Item("@TitleDate").Value)
      .InputValues = moUtil.FetchString(oCmd.Parameters.Item("@InputValues").Value)
      .Icons = moUtil.FetchString(oCmd.Parameters.Item("@Icons").Value)
      .IsMsg = moUtil.FetchLong(oCmd.Parameters.Item("@IsMsg").Value)
      .Timezone = moUtil.FetchLong(oCmd.Parameters.Item("@Timezone").Value)
      .Process = moUtil.FetchLong(oCmd.Parameters.Item("@Process").Value)
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

Public Sub FetchAuthUserID( _ 
   ByRef brRec As tMemberType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FetchAuthUserID"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", True, 0, 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_FetchAuthUserID"

   '-----get return values
   With brRec
      .AuthUserID = moUtil.FetchLong(oCmd.Parameters.Item("@AuthUserID").Value)
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

Public Sub FetchRef( _ 
   ByRef brRec As tMemberType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FetchRef"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .CompanyID = moUtil.EditLong(.CompanyID, "CompanyID", True, 0) 
      .Reference = moUtil.EditString(.Reference, "Reference", True, "", 1, 15) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@Reference", adVarWChar, adParamInput, 15, brRec.Reference)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_FetchRef"

   '-----get return values
   With brRec
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .AuthUserID = moUtil.FetchLong(oCmd.Parameters.Item("@AuthUserID").Value)
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

Public Sub FetchMasterID( _ 
   ByRef brRec As tMemberType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FetchMasterID"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", True, 0, 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
      .Parameters.Append .CreateParameter("@MasterID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_FetchMasterID"

   '-----get return values
   With brRec
      .MasterID = moUtil.FetchLong(oCmd.Parameters.Item("@MasterID").Value)
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

Public Sub FetchLogon( _ 
   ByRef brRec As tMemberType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FetchLogon"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .Logon = moUtil.EditString(.Logon, "Logon", True, "") 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Logon", adVarWChar, adParamInput, 80, brRec.Logon)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Level", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@GroupID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_FetchLogon"

   '-----get return values
   With brRec
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .Level = moUtil.FetchLong(oCmd.Parameters.Item("@Level").Value)
      .GroupID = moUtil.FetchLong(oCmd.Parameters.Item("@GroupID").Value)
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

Public Sub LoadAuthUser( _ 
   ByRef brRec As tMemberType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "LoadAuthUser"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamInput, vbNull, CLng(brRec.AuthUserID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_LoadAuthUser"

   '-----get return values
   With brRec
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
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

Public Function FindSponsor( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvSponsorID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tMemberType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindSponsor"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberType
   Dim vRec As tMemberType
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
   bvSponsorID = moUtil.EditLong(bvSponsorID, "SponsorID", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsMemberFindMemberName
         sProc = "pts_Member_FindSponsorMemberName"
         MaxBookMark = 72
      Case cptsMemberFindMemberID
         sProc = "pts_Member_FindSponsorMemberID"
         MaxBookMark = 20
      Case cptsMemberFindEnrollDate
         sProc = "pts_Member_FindSponsorEnrollDate"
         MaxBookMark = 30
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SponsorID", adInteger, adParamInput, vbNull, CLng(bvSponsorID))
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
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.Title = moUtil.FetchLong(.Fields.Item("Title").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.EnrollDate = moUtil.FetchDate(.Fields.Item("EnrollDate").Value)
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
   FindSponsor = vRecs

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

Public Function FindSponsor2( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvSponsor2ID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tMemberType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindSponsor2"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberType
   Dim vRec As tMemberType
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
   bvSponsor2ID = moUtil.EditLong(bvSponsor2ID, "Sponsor2ID", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsMemberFindMemberName
         sProc = "pts_Member_FindSponsor2MemberName"
         MaxBookMark = 72
      Case cptsMemberFindMemberID
         sProc = "pts_Member_FindSponsor2MemberID"
         MaxBookMark = 20
      Case cptsMemberFindEnrollDate
         sProc = "pts_Member_FindSponsor2EnrollDate"
         MaxBookMark = 30
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Sponsor2ID", adInteger, adParamInput, vbNull, CLng(bvSponsor2ID))
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
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.Title = moUtil.FetchLong(.Fields.Item("Title").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.EnrollDate = moUtil.FetchDate(.Fields.Item("EnrollDate").Value)
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
   FindSponsor2 = vRecs

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

Public Function FindSponsor3( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvSponsor3ID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tMemberType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindSponsor3"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberType
   Dim vRec As tMemberType
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
   bvSponsor3ID = moUtil.EditLong(bvSponsor3ID, "Sponsor3ID", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsMemberFindMemberName
         sProc = "pts_Member_FindSponsor3MemberName"
         MaxBookMark = 72
      Case cptsMemberFindMemberID
         sProc = "pts_Member_FindSponsor3MemberID"
         MaxBookMark = 20
      Case cptsMemberFindEnrollDate
         sProc = "pts_Member_FindSponsor3EnrollDate"
         MaxBookMark = 30
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Sponsor3ID", adInteger, adParamInput, vbNull, CLng(bvSponsor3ID))
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
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.Title = moUtil.FetchLong(.Fields.Item("Title").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.EnrollDate = moUtil.FetchDate(.Fields.Item("EnrollDate").Value)
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
   FindSponsor3 = vRecs

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

Public Function Find( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tMemberType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberType
   Dim vRec As tMemberType
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
      Case cptsMemberFindMemberName
         sProc = "pts_Member_FindMemberName"
         MaxBookMark = 72
      Case cptsMemberFindCompanyName
         sProc = "pts_Member_FindCompanyName"
         MaxBookMark = 70
      Case cptsMemberFindEnrollDate
         sProc = "pts_Member_FindEnrollDate"
         MaxBookMark = 30
      Case cptsMemberFindMemberID
         sProc = "pts_Member_FindMemberID"
         MaxBookMark = 20
      Case cptsMemberFindReference
         sProc = "pts_Member_FindReference"
         MaxBookMark = 25
      Case cptsMemberFindPhone1
         sProc = "pts_Member_FindPhone1"
         MaxBookMark = 40
      Case cptsMemberFindStatus
         sProc = "pts_Member_FindStatus"
         MaxBookMark = 20
      Case cptsMemberFindEmail
         sProc = "pts_Member_FindEmail"
         MaxBookMark = 90
      Case cptsMemberFindMasterID
         sProc = "pts_Member_FindMasterID"
         MaxBookMark = 20
      Case cptsMemberFindGroupID
         sProc = "pts_Member_FindGroupID"
         MaxBookMark = 20
      Case cptsMemberFindRole
         sProc = "pts_Member_FindRole"
         MaxBookMark = 25
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
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.AuthUserID = moUtil.FetchLong(.Fields.Item("AuthUserID").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Level = moUtil.FetchLong(.Fields.Item("Level").Value)
               vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
               vRec.VisitDate = moUtil.FetchDate(.Fields.Item("VisitDate").Value)
               vRec.EnrollDate = moUtil.FetchDate(.Fields.Item("EnrollDate").Value)
               vRec.Billing = moUtil.FetchLong(.Fields.Item("Billing").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Fax = moUtil.FetchString(.Fields.Item("Fax").Value)
               vRec.IsCompany = moUtil.FetchInteger(.Fields.Item("IsCompany").Value)
               vRec.CompanyName = moUtil.FetchString(.Fields.Item("CompanyName").Value)
               vRec.GroupID = moUtil.FetchLong(.Fields.Item("GroupID").Value)
               vRec.Title = moUtil.FetchLong(.Fields.Item("Title").Value)
               vRec.Qualify = moUtil.FetchLong(.Fields.Item("Qualify").Value)
               vRec.IsIncluded = moUtil.FetchInteger(.Fields.Item("IsIncluded").Value)
               vRec.IsMaster = moUtil.FetchInteger(.Fields.Item("IsMaster").Value)
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

Public Function FindOwner( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvCompanyID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tMemberType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindOwner"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberType
   Dim vRec As tMemberType
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
      Case cptsMemberFindMemberName
         sProc = "pts_Member_FindOwnerMemberName"
         MaxBookMark = 72
      Case cptsMemberFindCompanyName
         sProc = "pts_Member_FindOwnerCompanyName"
         MaxBookMark = 70
      Case cptsMemberFindEnrollDate
         sProc = "pts_Member_FindOwnerEnrollDate"
         MaxBookMark = 30
      Case cptsMemberFindMemberID
         sProc = "pts_Member_FindOwnerMemberID"
         MaxBookMark = 20
      Case cptsMemberFindReference
         sProc = "pts_Member_FindOwnerReference"
         MaxBookMark = 25
      Case cptsMemberFindPhone1
         sProc = "pts_Member_FindOwnerPhone1"
         MaxBookMark = 40
      Case cptsMemberFindStatus
         sProc = "pts_Member_FindOwnerStatus"
         MaxBookMark = 20
      Case cptsMemberFindEmail
         sProc = "pts_Member_FindOwnerEmail"
         MaxBookMark = 90
      Case cptsMemberFindMasterID
         sProc = "pts_Member_FindOwnerMasterID"
         MaxBookMark = 20
      Case cptsMemberFindGroupID
         sProc = "pts_Member_FindOwnerGroupID"
         MaxBookMark = 20
      Case cptsMemberFindRole
         sProc = "pts_Member_FindOwnerRole"
         MaxBookMark = 25
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
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.AuthUserID = moUtil.FetchLong(.Fields.Item("AuthUserID").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Level = moUtil.FetchLong(.Fields.Item("Level").Value)
               vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
               vRec.VisitDate = moUtil.FetchDate(.Fields.Item("VisitDate").Value)
               vRec.EnrollDate = moUtil.FetchDate(.Fields.Item("EnrollDate").Value)
               vRec.PaidDate = moUtil.FetchDate(.Fields.Item("PaidDate").Value)
               vRec.Billing = moUtil.FetchLong(.Fields.Item("Billing").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Fax = moUtil.FetchString(.Fields.Item("Fax").Value)
               vRec.IsCompany = moUtil.FetchInteger(.Fields.Item("IsCompany").Value)
               vRec.CompanyName = moUtil.FetchString(.Fields.Item("CompanyName").Value)
               vRec.GroupID = moUtil.FetchLong(.Fields.Item("GroupID").Value)
               vRec.Title = moUtil.FetchLong(.Fields.Item("Title").Value)
               vRec.ReferralID = moUtil.FetchLong(.Fields.Item("ReferralID").Value)
               vRec.SponsorID = moUtil.FetchLong(.Fields.Item("SponsorID").Value)
               vRec.Sponsor2ID = moUtil.FetchLong(.Fields.Item("Sponsor2ID").Value)
               vRec.Sponsor3ID = moUtil.FetchLong(.Fields.Item("Sponsor3ID").Value)
               vRec.Qualify = moUtil.FetchLong(.Fields.Item("Qualify").Value)
               vRec.IsIncluded = moUtil.FetchInteger(.Fields.Item("IsIncluded").Value)
               vRec.IsMaster = moUtil.FetchInteger(.Fields.Item("IsMaster").Value)
               vRec.Price = moUtil.FetchCurrency(.Fields.Item("Price").Value)
               vRec.Process = moUtil.FetchLong(.Fields.Item("Process").Value)
               vRec.Role = moUtil.FetchString(.Fields.Item("Role").Value)
               vRec.PromoID = moUtil.FetchLong(.Fields.Item("PromoID").Value)
               vRec.BV = moUtil.FetchCurrency(.Fields.Item("BV").Value)
               vRec.QV = moUtil.FetchCurrency(.Fields.Item("QV").Value)
               vRec.BV2 = moUtil.FetchCurrency(.Fields.Item("BV2").Value)
               vRec.QV2 = moUtil.FetchCurrency(.Fields.Item("QV2").Value)
               vRec.BV3 = moUtil.FetchCurrency(.Fields.Item("BV3").Value)
               vRec.QV3 = moUtil.FetchCurrency(.Fields.Item("QV3").Value)
               vRec.BV4 = moUtil.FetchCurrency(.Fields.Item("BV4").Value)
               vRec.QV4 = moUtil.FetchCurrency(.Fields.Item("QV4").Value)
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
   FindOwner = vRecs

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
   ByVal bvCompanyID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tMemberType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindOrg"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberType
   Dim vRec As tMemberType
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
      Case cptsMemberFindMemberName
         sProc = "pts_Member_FindOrgMemberName"
         MaxBookMark = 72
      Case cptsMemberFindCompanyName
         sProc = "pts_Member_FindOrgCompanyName"
         MaxBookMark = 70
      Case cptsMemberFindEnrollDate
         sProc = "pts_Member_FindOrgEnrollDate"
         MaxBookMark = 30
      Case cptsMemberFindMemberID
         sProc = "pts_Member_FindOrgMemberID"
         MaxBookMark = 20
      Case cptsMemberFindReference
         sProc = "pts_Member_FindOrgReference"
         MaxBookMark = 25
      Case cptsMemberFindPhone1
         sProc = "pts_Member_FindOrgPhone1"
         MaxBookMark = 40
      Case cptsMemberFindStatus
         sProc = "pts_Member_FindOrgStatus"
         MaxBookMark = 20
      Case cptsMemberFindEmail
         sProc = "pts_Member_FindOrgEmail"
         MaxBookMark = 90
      Case cptsMemberFindMasterID
         sProc = "pts_Member_FindOrgMasterID"
         MaxBookMark = 20
      Case cptsMemberFindGroupID
         sProc = "pts_Member_FindOrgGroupID"
         MaxBookMark = 20
      Case cptsMemberFindRole
         sProc = "pts_Member_FindOrgRole"
         MaxBookMark = 25
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
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.AuthUserID = moUtil.FetchLong(.Fields.Item("AuthUserID").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Level = moUtil.FetchLong(.Fields.Item("Level").Value)
               vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
               vRec.VisitDate = moUtil.FetchDate(.Fields.Item("VisitDate").Value)
               vRec.EnrollDate = moUtil.FetchDate(.Fields.Item("EnrollDate").Value)
               vRec.Billing = moUtil.FetchLong(.Fields.Item("Billing").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Fax = moUtil.FetchString(.Fields.Item("Fax").Value)
               vRec.IsCompany = moUtil.FetchInteger(.Fields.Item("IsCompany").Value)
               vRec.CompanyName = moUtil.FetchString(.Fields.Item("CompanyName").Value)
               vRec.GroupID = moUtil.FetchLong(.Fields.Item("GroupID").Value)
               vRec.Title = moUtil.FetchLong(.Fields.Item("Title").Value)
               vRec.Qualify = moUtil.FetchLong(.Fields.Item("Qualify").Value)
               vRec.IsIncluded = moUtil.FetchInteger(.Fields.Item("IsIncluded").Value)
               vRec.IsMaster = moUtil.FetchInteger(.Fields.Item("IsMaster").Value)
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

Public Function FindMaster( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMasterID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tMemberType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindMaster"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberType
   Dim vRec As tMemberType
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
   bvMasterID = moUtil.EditLong(bvMasterID, "MasterID", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsMemberFindMemberName
         sProc = "pts_Member_FindMasterMemberName"
         MaxBookMark = 72
      Case cptsMemberFindCompanyName
         sProc = "pts_Member_FindMasterCompanyName"
         MaxBookMark = 70
      Case cptsMemberFindEnrollDate
         sProc = "pts_Member_FindMasterEnrollDate"
         MaxBookMark = 30
      Case cptsMemberFindMemberID
         sProc = "pts_Member_FindMasterMemberID"
         MaxBookMark = 20
      Case cptsMemberFindReference
         sProc = "pts_Member_FindMasterReference"
         MaxBookMark = 25
      Case cptsMemberFindPhone1
         sProc = "pts_Member_FindMasterPhone1"
         MaxBookMark = 40
      Case cptsMemberFindStatus
         sProc = "pts_Member_FindMasterStatus"
         MaxBookMark = 20
      Case cptsMemberFindEmail
         sProc = "pts_Member_FindMasterEmail"
         MaxBookMark = 90
      Case cptsMemberFindMasterID
         sProc = "pts_Member_FindMasterMasterID"
         MaxBookMark = 20
      Case cptsMemberFindGroupID
         sProc = "pts_Member_FindMasterGroupID"
         MaxBookMark = 20
      Case cptsMemberFindRole
         sProc = "pts_Member_FindMasterRole"
         MaxBookMark = 25
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MasterID", adInteger, adParamInput, vbNull, CLng(bvMasterID))
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
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.AuthUserID = moUtil.FetchLong(.Fields.Item("AuthUserID").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Level = moUtil.FetchLong(.Fields.Item("Level").Value)
               vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
               vRec.VisitDate = moUtil.FetchDate(.Fields.Item("VisitDate").Value)
               vRec.EnrollDate = moUtil.FetchDate(.Fields.Item("EnrollDate").Value)
               vRec.Billing = moUtil.FetchLong(.Fields.Item("Billing").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Fax = moUtil.FetchString(.Fields.Item("Fax").Value)
               vRec.IsCompany = moUtil.FetchInteger(.Fields.Item("IsCompany").Value)
               vRec.CompanyName = moUtil.FetchString(.Fields.Item("CompanyName").Value)
               vRec.GroupID = moUtil.FetchLong(.Fields.Item("GroupID").Value)
               vRec.Role = moUtil.FetchString(.Fields.Item("Role").Value)
               vRec.Title = moUtil.FetchLong(.Fields.Item("Title").Value)
               vRec.Qualify = moUtil.FetchLong(.Fields.Item("Qualify").Value)
               vRec.IsMaster = moUtil.FetchInteger(.Fields.Item("IsMaster").Value)
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
   FindMaster = vRecs

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

Public Function FindGroup( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvGroupID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tMemberType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindGroup"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberType
   Dim vRec As tMemberType
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
   bvGroupID = moUtil.EditLong(bvGroupID, "GroupID", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsMemberFindMemberName
         sProc = "pts_Member_FindGroupMemberName"
         MaxBookMark = 72
      Case cptsMemberFindCompanyName
         sProc = "pts_Member_FindGroupCompanyName"
         MaxBookMark = 70
      Case cptsMemberFindEnrollDate
         sProc = "pts_Member_FindGroupEnrollDate"
         MaxBookMark = 30
      Case cptsMemberFindMemberID
         sProc = "pts_Member_FindGroupMemberID"
         MaxBookMark = 20
      Case cptsMemberFindReference
         sProc = "pts_Member_FindGroupReference"
         MaxBookMark = 25
      Case cptsMemberFindPhone1
         sProc = "pts_Member_FindGroupPhone1"
         MaxBookMark = 40
      Case cptsMemberFindStatus
         sProc = "pts_Member_FindGroupStatus"
         MaxBookMark = 20
      Case cptsMemberFindEmail
         sProc = "pts_Member_FindGroupEmail"
         MaxBookMark = 90
      Case cptsMemberFindMasterID
         sProc = "pts_Member_FindGroupMasterID"
         MaxBookMark = 20
      Case cptsMemberFindGroupID
         sProc = "pts_Member_FindGroupGroupID"
         MaxBookMark = 20
      Case cptsMemberFindRole
         sProc = "pts_Member_FindGroupRole"
         MaxBookMark = 25
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@GroupID", adInteger, adParamInput, vbNull, CLng(bvGroupID))
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
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.AuthUserID = moUtil.FetchLong(.Fields.Item("AuthUserID").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Level = moUtil.FetchLong(.Fields.Item("Level").Value)
               vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
               vRec.VisitDate = moUtil.FetchDate(.Fields.Item("VisitDate").Value)
               vRec.EnrollDate = moUtil.FetchDate(.Fields.Item("EnrollDate").Value)
               vRec.Billing = moUtil.FetchLong(.Fields.Item("Billing").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Fax = moUtil.FetchString(.Fields.Item("Fax").Value)
               vRec.IsCompany = moUtil.FetchInteger(.Fields.Item("IsCompany").Value)
               vRec.CompanyName = moUtil.FetchString(.Fields.Item("CompanyName").Value)
               vRec.GroupID = moUtil.FetchLong(.Fields.Item("GroupID").Value)
               vRec.Role = moUtil.FetchString(.Fields.Item("Role").Value)
               vRec.Title = moUtil.FetchLong(.Fields.Item("Title").Value)
               vRec.Qualify = moUtil.FetchLong(.Fields.Item("Qualify").Value)
               vRec.IsMaster = moUtil.FetchInteger(.Fields.Item("IsMaster").Value)
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
   FindGroup = vRecs

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

Public Function FindCustomer( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tMemberType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindCustomer"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberType
   Dim vRec As tMemberType
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
   bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True, , 1) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsMemberFindMemberName
         sProc = "pts_Member_FindCustomerMemberName"
         MaxBookMark = 72
      Case cptsMemberFindEmail
         sProc = "pts_Member_FindCustomerEmail"
         MaxBookMark = 90
      Case cptsMemberFindInitPrice
         sProc = "pts_Member_FindCustomerInitPrice"
         MaxBookMark = 30
      Case cptsMemberFindOptions2
         sProc = "pts_Member_FindCustomerOptions2"
         MaxBookMark = 50
      Case cptsMemberFindEnrollDate
         sProc = "pts_Member_FindCustomerEnrollDate"
         MaxBookMark = 30
      Case cptsMemberFindMemberID
         sProc = "pts_Member_FindCustomerMemberID"
         MaxBookMark = 20
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
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.AuthUserID = moUtil.FetchLong(.Fields.Item("AuthUserID").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Level = moUtil.FetchLong(.Fields.Item("Level").Value)
               vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
               vRec.VisitDate = moUtil.FetchDate(.Fields.Item("VisitDate").Value)
               vRec.EnrollDate = moUtil.FetchDate(.Fields.Item("EnrollDate").Value)
               vRec.Billing = moUtil.FetchLong(.Fields.Item("Billing").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Fax = moUtil.FetchString(.Fields.Item("Fax").Value)
               vRec.IsCompany = moUtil.FetchInteger(.Fields.Item("IsCompany").Value)
               vRec.CompanyName = moUtil.FetchString(.Fields.Item("CompanyName").Value)
               vRec.GroupID = moUtil.FetchLong(.Fields.Item("GroupID").Value)
               vRec.Role = moUtil.FetchString(.Fields.Item("Role").Value)
               vRec.Title = moUtil.FetchLong(.Fields.Item("Title").Value)
               vRec.Qualify = moUtil.FetchLong(.Fields.Item("Qualify").Value)
               vRec.IsMaster = moUtil.FetchInteger(.Fields.Item("IsMaster").Value)
               vRec.Price = moUtil.FetchCurrency(.Fields.Item("Price").Value)
               vRec.InitPrice = moUtil.FetchCurrency(.Fields.Item("InitPrice").Value)
               vRec.Options2 = moUtil.FetchString(.Fields.Item("Options2").Value)
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
   FindCustomer = vRecs

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
   ByVal bvCompanyID As Long) As tMemberType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListOrg"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberType
   Dim vRec As tMemberType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvCompanyID = moUtil.EditLong(bvCompanyID, "CompanyID", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_ListOrg")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.CompanyName = moUtil.FetchString(.Fields.Item("CompanyName").Value)
            vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
            vRec.EnrollDate = moUtil.FetchDate(.Fields.Item("EnrollDate").Value)
            vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
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

Public Function ListReferral( _ 
   ByVal bvReferralID As Long) As tMemberType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListReferral"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberType
   Dim vRec As tMemberType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvReferralID = moUtil.EditLong(bvReferralID, "ReferralID", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ReferralID", adInteger, adParamInput, vbNull, CLng(bvReferralID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_ListReferral")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
            vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.Level = moUtil.FetchLong(.Fields.Item("Level").Value)
            vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
            vRec.EnrollDate = moUtil.FetchDate(.Fields.Item("EnrollDate").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListReferral = vRecs

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
   ByVal bvMemberID As Long) As tMemberType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListCustomers"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberType
   Dim vRec As tMemberType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True, 0, 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_ListCustomers")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
            vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.Level = moUtil.FetchLong(.Fields.Item("Level").Value)
            vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
            vRec.EnrollDate = moUtil.FetchDate(.Fields.Item("EnrollDate").Value)
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

Public Function ListMentor( _ 
   ByVal bvMentorID As Long, _ 
   ByVal bvVisitDate As Date) As tMemberType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMentor"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberType
   Dim vRec As tMemberType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvMentorID = moUtil.EditLong(bvMentorID, "MentorID", True, 0) 
      bvVisitDate = moUtil.EditDate(bvVisitDate, "VisitDate", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MentorID", adInteger, adParamInput, vbNull, CLng(bvMentorID))
      .Parameters.Append .CreateParameter("@VisitDate", adDate, adParamInput, vbNull, CDate(bvVisitDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_ListMentor")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
            vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
            vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
            vRec.VisitDate = moUtil.FetchDate(.Fields.Item("VisitDate").Value)
            vRec.EnrollDate = moUtil.FetchDate(.Fields.Item("EnrollDate").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
            vRec.Options = moUtil.FetchString(.Fields.Item("Options").Value)
            vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
            vRec.NotifyMentor = moUtil.FetchString(.Fields.Item("NotifyMentor").Value)
            vRec.Quantity = moUtil.FetchLong(.Fields.Item("Quantity").Value)
            vRec.Image = moUtil.FetchString(.Fields.Item("Image").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListMentor = vRecs

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

Public Function ReportMembership( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date) As tMemberType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportMembership"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberType
   Dim vRec As tMemberType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(bvReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(bvReportToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_ReportMembership")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
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
   ReportMembership = vRecs

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

Public Function ReportNewEnrollment( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date, _ 
   ByVal bvUnit As String) As tMemberType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportNewEnrollment"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberType
   Dim vRec As tMemberType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(bvReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(bvReportToDate))
      .Parameters.Append .CreateParameter("@Unit", adVarWChar, adParamInput, 40, bvUnit)
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_ReportNewEnrollment")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.EnrollDate = moUtil.FetchDate(.Fields.Item("EnrollDate").Value)
            vRec.Quantity = moUtil.FetchLong(.Fields.Item("Quantity").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ReportNewEnrollment = vRecs

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

Public Function ReportTotalEnrollment( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date, _ 
   ByVal bvUnit As String) As tMemberType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportTotalEnrollment"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberType
   Dim vRec As tMemberType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(bvReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(bvReportToDate))
      .Parameters.Append .CreateParameter("@Unit", adVarWChar, adParamInput, 40, bvUnit)
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_ReportTotalEnrollment")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.EnrollDate = moUtil.FetchDate(.Fields.Item("EnrollDate").Value)
            vRec.Quantity = moUtil.FetchLong(.Fields.Item("Quantity").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ReportTotalEnrollment = vRecs

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

Public Function ReportBilling( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date) As tMemberType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportBilling"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberType
   Dim vRec As tMemberType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(bvReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(bvReportToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_ReportBilling")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.Billing = moUtil.FetchLong(.Fields.Item("Billing").Value)
            vRec.Quantity = moUtil.FetchLong(.Fields.Item("Quantity").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ReportBilling = vRecs

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

Public Function ReportVisit( _ 
   ByVal bvCompanyID As Long) As tMemberType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportVisit"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberType
   Dim vRec As tMemberType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_ReportVisit")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.Amount = moUtil.FetchLong(.Fields.Item("Amount").Value)
            vRec.Quantity = moUtil.FetchLong(.Fields.Item("Quantity").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ReportVisit = vRecs

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

Public Function ReportVisitStatus( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvStatus As Long) As tMemberType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportVisitStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberType
   Dim vRec As tMemberType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_ReportVisitStatus")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.Amount = moUtil.FetchLong(.Fields.Item("Amount").Value)
            vRec.Quantity = moUtil.FetchLong(.Fields.Item("Quantity").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ReportVisitStatus = vRecs

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

Public Function ReportAuthLog( _ 
   ByVal bvCompanyID As Long) As tMemberType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportAuthLog"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberType
   Dim vRec As tMemberType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_ReportAuthLog")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.CompanyName = moUtil.FetchString(.Fields.Item("CompanyName").Value)
            vRec.Quantity = moUtil.FetchLong(.Fields.Item("Quantity").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ReportAuthLog = vRecs

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

Public Function ReportMembershipDetail( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date, _ 
   ByVal bvStatus As Long) As tMemberType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportMembershipDetail"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberType
   Dim vRec As tMemberType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(bvReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(bvReportToDate))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_ReportMembershipDetail")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.CompanyName = moUtil.FetchString(.Fields.Item("CompanyName").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ReportMembershipDetail = vRecs

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

Public Function ReportBillingDetail( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date, _ 
   ByVal bvBilling As Long) As tMemberType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportBillingDetail"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberType
   Dim vRec As tMemberType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(bvReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(bvReportToDate))
      .Parameters.Append .CreateParameter("@Billing", adInteger, adParamInput, vbNull, CLng(bvBilling))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_ReportBillingDetail")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.CompanyName = moUtil.FetchString(.Fields.Item("CompanyName").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ReportBillingDetail = vRecs

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

Public Function ReportVisitDetail( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvQuantity As Long) As tMemberType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportVisitDetail"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberType
   Dim vRec As tMemberType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@Quantity", adInteger, adParamInput, vbNull, CLng(bvQuantity))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_ReportVisitDetail")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.CompanyName = moUtil.FetchString(.Fields.Item("CompanyName").Value)
            vRec.VisitDate = moUtil.FetchDate(.Fields.Item("VisitDate").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ReportVisitDetail = vRecs

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

Public Function ReportVisitDetailStatus( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvQuantity As Long, _ 
   ByVal bvStatus As Long) As tMemberType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportVisitDetailStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberType
   Dim vRec As tMemberType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@Quantity", adInteger, adParamInput, vbNull, CLng(bvQuantity))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_ReportVisitDetailStatus")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.CompanyName = moUtil.FetchString(.Fields.Item("CompanyName").Value)
            vRec.VisitDate = moUtil.FetchDate(.Fields.Item("VisitDate").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ReportVisitDetailStatus = vRecs

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
   ByVal bvMemberID As Long) As tMemberType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListNewsLetter"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberType
   Dim vRec As tMemberType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_ListNewsLetter")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
            vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
            vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
            vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
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

Public Function Genealogy( _ 
   ByVal bvMemberID As Long, _ 
   ByVal bvStatus As Long, _ 
   ByVal bvLevel As Long, _ 
   ByVal bvTitle As Long, _ 
   ByVal bvQV As Currency) As tMemberType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Genealogy"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberType
   Dim vRec As tMemberType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
      .Parameters.Append .CreateParameter("@Level", adInteger, adParamInput, vbNull, CLng(bvLevel))
      .Parameters.Append .CreateParameter("@Title", adInteger, adParamInput, vbNull, CLng(bvTitle))
      .Parameters.Append .CreateParameter("@QV", adCurrency, adParamInput, vbNull, CCur(bvQV))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_Genealogy")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.SponsorID = moUtil.FetchLong(.Fields.Item("SponsorID").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.EnrollDate = moUtil.FetchDate(.Fields.Item("EnrollDate").Value)
            vRec.VisitDate = moUtil.FetchDate(.Fields.Item("VisitDate").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.Title = moUtil.FetchLong(.Fields.Item("Title").Value)
            vRec.BV = moUtil.FetchCurrency(.Fields.Item("BV").Value)
            vRec.QV = moUtil.FetchCurrency(.Fields.Item("QV").Value)
            vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
            vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
            vRec.Identification = moUtil.FetchString(.Fields.Item("Identification").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   Genealogy = vRecs

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
   ByVal bvCompanyID As Long, _ 
   ByVal bvEmail As String) As tMemberType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListEmail"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberType
   Dim vRec As tMemberType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, bvEmail)
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_ListEmail")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
            vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
            vRec.EnrollDate = moUtil.FetchDate(.Fields.Item("EnrollDate").Value)
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

Public Function NewMembers( _ 
   ByVal bvCompanyID As Long) As tMemberType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "NewMembers"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberType
   Dim vRec As tMemberType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_NewMembers")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.Identification = moUtil.FetchString(.Fields.Item("Identification").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   NewMembers = vRecs

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

Public Function FundRaisingSummary( _ 
   ByVal bvMemberID As Long) As tMemberType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FundRaisingSummary"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberType
   Dim vRec As tMemberType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_FundRaisingSummary")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
            vRec.Quantity = moUtil.FetchLong(.Fields.Item("Quantity").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   FundRaisingSummary = vRecs

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

Public Function FundRaisingDetail( _ 
   ByVal bvMemberID As Long) As tMemberType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FundRaisingDetail"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberType
   Dim vRec As tMemberType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_FundRaisingDetail")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.CompanyName = moUtil.FetchString(.Fields.Item("CompanyName").Value)
            vRec.EnrollDate = moUtil.FetchDate(.Fields.Item("EnrollDate").Value)
            vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   FundRaisingDetail = vRecs

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

Public Function CustomList( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvStatus As Long, _ 
   ByVal bvLevel As Long) As tMemberType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CustomList"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberType
   Dim vRec As tMemberType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
      .Parameters.Append .CreateParameter("@Level", adInteger, adParamInput, vbNull, CLng(bvLevel))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_CustomList")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.Level = moUtil.FetchLong(.Fields.Item("Level").Value)
            vRec.Signature = moUtil.FetchString(.Fields.Item("Signature").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   CustomList = vRecs

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
   ByRef brRec As tMemberType, _ 
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
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamInput, vbNull, CLng(brRec.AuthUserID))
      .Parameters.Append .CreateParameter("@WebsiteID", adInteger, adParamInput, vbNull, CLng(brRec.WebsiteID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@PromoID", adInteger, adParamInput, vbNull, CLng(brRec.PromoID))
      .Parameters.Append .CreateParameter("@BillingID", adInteger, adParamInput, vbNull, CLng(brRec.BillingID))
      .Parameters.Append .CreateParameter("@PayID", adInteger, adParamInput, vbNull, CLng(brRec.PayID))
      .Parameters.Append .CreateParameter("@ReferralID", adInteger, adParamInput, vbNull, CLng(brRec.ReferralID))
      .Parameters.Append .CreateParameter("@SponsorID", adInteger, adParamInput, vbNull, CLng(brRec.SponsorID))
      .Parameters.Append .CreateParameter("@Sponsor2ID", adInteger, adParamInput, vbNull, CLng(brRec.Sponsor2ID))
      .Parameters.Append .CreateParameter("@Sponsor3ID", adInteger, adParamInput, vbNull, CLng(brRec.Sponsor3ID))
      .Parameters.Append .CreateParameter("@MentorID", adInteger, adParamInput, vbNull, CLng(brRec.MentorID))
      .Parameters.Append .CreateParameter("@UserGroup", adInteger, adParamInput, vbNull, CLng(brRec.UserGroup))
      .Parameters.Append .CreateParameter("@UserStatus", adInteger, adParamInput, vbNull, CLng(brRec.UserStatus))
      .Parameters.Append .CreateParameter("@CompanyName", adVarWChar, adParamInput, 60, brRec.CompanyName)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamInput, 30, brRec.NameLast)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamInput, 30, brRec.NameFirst)
      .Parameters.Append .CreateParameter("@BV", adCurrency, adParamInput, vbNull, CCur(brRec.BV))
      .Parameters.Append .CreateParameter("@QV", adCurrency, adParamInput, vbNull, CCur(brRec.QV))
      .Parameters.Append .CreateParameter("@BV2", adCurrency, adParamInput, vbNull, CCur(brRec.BV2))
      .Parameters.Append .CreateParameter("@QV2", adCurrency, adParamInput, vbNull, CCur(brRec.QV2))
      .Parameters.Append .CreateParameter("@BV3", adCurrency, adParamInput, vbNull, CCur(brRec.BV3))
      .Parameters.Append .CreateParameter("@QV3", adCurrency, adParamInput, vbNull, CCur(brRec.QV3))
      .Parameters.Append .CreateParameter("@BV4", adCurrency, adParamInput, vbNull, CCur(brRec.BV4))
      .Parameters.Append .CreateParameter("@QV4", adCurrency, adParamInput, vbNull, CCur(brRec.QV4))
      .Parameters.Append .CreateParameter("@Qualify", adInteger, adParamInput, vbNull, CLng(brRec.Qualify))
      .Parameters.Append .CreateParameter("@QualifyDate", adDate, adParamInput, vbNull, CDate(brRec.QualifyDate))
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@Email2", adVarWChar, adParamInput, 80, brRec.Email2)
      .Parameters.Append .CreateParameter("@Phone1", adVarWChar, adParamInput, 30, brRec.Phone1)
      .Parameters.Append .CreateParameter("@Phone2", adVarWChar, adParamInput, 30, brRec.Phone2)
      .Parameters.Append .CreateParameter("@Fax", adVarWChar, adParamInput, 30, brRec.Fax)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Level", adInteger, adParamInput, vbNull, CLng(brRec.Level))
      .Parameters.Append .CreateParameter("@Newsletter", adInteger, adParamInput, vbNull, CLng(brRec.Newsletter))
      .Parameters.Append .CreateParameter("@EnrollDate", adDate, adParamInput, vbNull, CDate(brRec.EnrollDate))
      .Parameters.Append .CreateParameter("@EndDate", adDate, adParamInput, vbNull, CDate(brRec.EndDate))
      .Parameters.Append .CreateParameter("@InitPrice", adCurrency, adParamInput, vbNull, CCur(brRec.InitPrice))
      .Parameters.Append .CreateParameter("@Price", adCurrency, adParamInput, vbNull, CCur(brRec.Price))
      .Parameters.Append .CreateParameter("@Retail", adCurrency, adParamInput, vbNull, CCur(brRec.Retail))
      .Parameters.Append .CreateParameter("@BusAccts", adInteger, adParamInput, vbNull, CLng(brRec.BusAccts))
      .Parameters.Append .CreateParameter("@BusAcctPrice", adCurrency, adParamInput, vbNull, CCur(brRec.BusAcctPrice))
      .Parameters.Append .CreateParameter("@BusAcctRetail", adCurrency, adParamInput, vbNull, CCur(brRec.BusAcctRetail))
      .Parameters.Append .CreateParameter("@IsDiscount", adSmallInt, adParamInput, vbNull, CInt(brRec.IsDiscount))
      .Parameters.Append .CreateParameter("@Discount", adCurrency, adParamInput, vbNull, CCur(brRec.Discount))
      .Parameters.Append .CreateParameter("@IsCompany", adSmallInt, adParamInput, vbNull, CInt(brRec.IsCompany))
      .Parameters.Append .CreateParameter("@Billing", adInteger, adParamInput, vbNull, CLng(brRec.Billing))
      .Parameters.Append .CreateParameter("@AccessLimit", adVarWChar, adParamInput, 50, brRec.AccessLimit)
      .Parameters.Append .CreateParameter("@QuizLimit", adInteger, adParamInput, vbNull, CLng(brRec.QuizLimit))
      .Parameters.Append .CreateParameter("@Reference", adVarWChar, adParamInput, 15, brRec.Reference)
      .Parameters.Append .CreateParameter("@Referral", adVarWChar, adParamInput, 15, brRec.Referral)
      .Parameters.Append .CreateParameter("@TrialDays", adInteger, adParamInput, vbNull, CLng(brRec.TrialDays))
      .Parameters.Append .CreateParameter("@MasterID", adInteger, adParamInput, vbNull, CLng(brRec.MasterID))
      .Parameters.Append .CreateParameter("@IsIncluded", adSmallInt, adParamInput, vbNull, CInt(brRec.IsIncluded))
      .Parameters.Append .CreateParameter("@IsMaster", adSmallInt, adParamInput, vbNull, CInt(brRec.IsMaster))
      .Parameters.Append .CreateParameter("@MasterPrice", adCurrency, adParamInput, vbNull, CCur(brRec.MasterPrice))
      .Parameters.Append .CreateParameter("@MasterMembers", adInteger, adParamInput, vbNull, CLng(brRec.MasterMembers))
      .Parameters.Append .CreateParameter("@MaxMembers", adInteger, adParamInput, vbNull, CLng(brRec.MaxMembers))
      .Parameters.Append .CreateParameter("@VisitDate", adDate, adParamInput, vbNull, CDate(brRec.VisitDate))
      .Parameters.Append .CreateParameter("@TaxIDType", adInteger, adParamInput, vbNull, CLng(brRec.TaxIDType))
      .Parameters.Append .CreateParameter("@TaxID", adVarWChar, adParamInput, 15, brRec.TaxID)
      .Parameters.Append .CreateParameter("@AutoShipDate", adDate, adParamInput, vbNull, CDate(brRec.AutoShipDate))
      .Parameters.Append .CreateParameter("@PaidDate", adDate, adParamInput, vbNull, CDate(brRec.PaidDate))
      .Parameters.Append .CreateParameter("@StatusDate", adDate, adParamInput, vbNull, CDate(brRec.StatusDate))
      .Parameters.Append .CreateParameter("@StatusChange", adInteger, adParamInput, vbNull, CLng(brRec.StatusChange))
      .Parameters.Append .CreateParameter("@LevelChange", adInteger, adParamInput, vbNull, CLng(brRec.LevelChange))
      .Parameters.Append .CreateParameter("@IsRemoved", adSmallInt, adParamInput, vbNull, CInt(brRec.IsRemoved))
      .Parameters.Append .CreateParameter("@GroupID", adInteger, adParamInput, vbNull, CLng(brRec.GroupID))
      .Parameters.Append .CreateParameter("@Role", adVarWChar, adParamInput, 15, brRec.Role)
      .Parameters.Append .CreateParameter("@Secure", adInteger, adParamInput, vbNull, CLng(brRec.Secure))
      .Parameters.Append .CreateParameter("@Options", adVarWChar, adParamInput, 20, brRec.Options)
      .Parameters.Append .CreateParameter("@Options2", adVarWChar, adParamInput, 40, brRec.Options2)
      .Parameters.Append .CreateParameter("@Pos", adInteger, adParamInput, vbNull, CLng(brRec.Pos))
      .Parameters.Append .CreateParameter("@Signature", adVarWChar, adParamInput, 1000, brRec.Signature)
      .Parameters.Append .CreateParameter("@SocNet", adVarWChar, adParamInput, 200, brRec.SocNet)
      .Parameters.Append .CreateParameter("@ConfLine", adVarWChar, adParamInput, 40, brRec.ConfLine)
      .Parameters.Append .CreateParameter("@NotifyMentor", adVarWChar, adParamInput, 10, brRec.NotifyMentor)
      .Parameters.Append .CreateParameter("@Image", adVarWChar, adParamInput, 15, brRec.Image)
      .Parameters.Append .CreateParameter("@Identification", adVarWChar, adParamInput, 150, brRec.Identification)
      .Parameters.Append .CreateParameter("@Title", adInteger, adParamInput, vbNull, CLng(brRec.Title))
      .Parameters.Append .CreateParameter("@Title2", adInteger, adParamInput, vbNull, CLng(brRec.Title2))
      .Parameters.Append .CreateParameter("@MinTitle", adInteger, adParamInput, vbNull, CLng(brRec.MinTitle))
      .Parameters.Append .CreateParameter("@TitleDate", adDate, adParamInput, vbNull, CDate(brRec.TitleDate))
      .Parameters.Append .CreateParameter("@InputValues", adVarWChar, adParamInput, 1000, brRec.InputValues)
      .Parameters.Append .CreateParameter("@Icons", adVarWChar, adParamInput, 20, brRec.Icons)
      .Parameters.Append .CreateParameter("@IsMsg", adInteger, adParamInput, vbNull, CLng(brRec.IsMsg))
      .Parameters.Append .CreateParameter("@Timezone", adInteger, adParamInput, vbNull, CLng(brRec.Timezone))
      .Parameters.Append .CreateParameter("@Process", adInteger, adParamInput, vbNull, CLng(brRec.Process))
      .Parameters.Append .CreateParameter("@NewLogon", adVarWChar, adParamInput, 80, brRec.NewLogon)
      .Parameters.Append .CreateParameter("@NewPassword", adVarWChar, adParamInput, 30, brRec.NewPassword)
      .Parameters.Append .CreateParameter("@Unit", adVarWChar, adParamInput, 40, brRec.Unit)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Member_Update"

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
   ByRef brRec As tMemberType, _ 
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
         .MemberID = moUtil.EditLong(.MemberID, "MemberID", True, , 1) 
      End If
      .AuthUserID = moUtil.EditLong(.AuthUserID, "AuthUserID", False) 
      .WebsiteID = moUtil.EditLong(.WebsiteID, "WebsiteID", False) 
      .CompanyID = moUtil.EditLong(.CompanyID, "CompanyID", False) 
      .PromoID = moUtil.EditLong(.PromoID, "PromoID", False) 
      .BillingID = moUtil.EditLong(.BillingID, "BillingID", False) 
      .PayID = moUtil.EditLong(.PayID, "PayID", False) 
      .ReferralID = moUtil.EditLong(.ReferralID, "ReferralID", False) 
      .SponsorID = moUtil.EditLong(.SponsorID, "SponsorID", False) 
      .Sponsor2ID = moUtil.EditLong(.Sponsor2ID, "Sponsor2ID", False) 
      .Sponsor3ID = moUtil.EditLong(.Sponsor3ID, "Sponsor3ID", False) 
      .MentorID = moUtil.EditLong(.MentorID, "MentorID", False) 
      .CompanyName = moUtil.EditString(.CompanyName, "CompanyName", False, , 1, 60) 
      .NameLast = moUtil.EditString(.NameLast, "NameLast", True, , 1, 30) 
      .NameFirst = moUtil.EditString(.NameFirst, "NameFirst", True, , 1, 30) 
      .BV = moUtil.EditCurrency(.BV, "BV", False, , -999999.99, 999999.99) 
      .QV = moUtil.EditCurrency(.QV, "QV", False, , -999999.99, 999999.99) 
      .BV2 = moUtil.EditCurrency(.BV2, "BV2", False, , -999999.99, 999999.99) 
      .QV2 = moUtil.EditCurrency(.QV2, "QV2", False, , -999999.99, 999999.99) 
      .BV3 = moUtil.EditCurrency(.BV3, "BV3", False, , -999999.99, 999999.99) 
      .QV3 = moUtil.EditCurrency(.QV3, "QV3", False, , -999999.99, 999999.99) 
      .BV4 = moUtil.EditCurrency(.BV4, "BV4", False, , -999999.99, 999999.99) 
      .QV4 = moUtil.EditCurrency(.QV4, "QV4", False, , -999999.99, 999999.99) 
      .Qualify = moUtil.EditLong(.Qualify, "Qualify", False) 
      .QualifyDate = moUtil.EditDate(.QualifyDate, "QualifyDate", False) 
      .Email = moUtil.EditString(.Email, "Email", True, , 1, 80) 
      .Email2 = moUtil.EditString(.Email2, "Email2", False, , 1, 80) 
      .Phone1 = moUtil.EditString(.Phone1, "Phone1", False, , 1, 30) 
      .Phone2 = moUtil.EditString(.Phone2, "Phone2", False, , 1, 30) 
      .Fax = moUtil.EditString(.Fax, "Fax", False, , 1, 30) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .Level = moUtil.EditLong(.Level, "Level", False) 
      .Newsletter = moUtil.EditLong(.Newsletter, "Newsletter", False) 
      .EnrollDate = moUtil.EditDate(.EnrollDate, "EnrollDate", True) 
      .EndDate = moUtil.EditDate(.EndDate, "EndDate", False) 
      .InitPrice = moUtil.EditCurrency(.InitPrice, "InitPrice", False) 
      .Price = moUtil.EditCurrency(.Price, "Price", False) 
      .Retail = moUtil.EditCurrency(.Retail, "Retail", False) 
      .BusAccts = moUtil.EditLong(.BusAccts, "BusAccts", False) 
      .BusAcctPrice = moUtil.EditCurrency(.BusAcctPrice, "BusAcctPrice", False) 
      .BusAcctRetail = moUtil.EditCurrency(.BusAcctRetail, "BusAcctRetail", False) 
      .IsDiscount = moUtil.EditInteger(.IsDiscount, "IsDiscount", False, 0, 0, 1) 
      .Discount = moUtil.EditCurrency(.Discount, "Discount", False) 
      .IsCompany = moUtil.EditInteger(.IsCompany, "IsCompany", False, 0, 0, 1) 
      .Billing = moUtil.EditLong(.Billing, "Billing", False) 
      .AccessLimit = moUtil.EditString(.AccessLimit, "AccessLimit", False, , 1, 50) 
      .QuizLimit = moUtil.EditLong(.QuizLimit, "QuizLimit", False) 
      .Reference = moUtil.EditString(.Reference, "Reference", False, , 1, 15) 
      .Referral = moUtil.EditString(.Referral, "Referral", False, , 1, 15) 
      .TrialDays = moUtil.EditLong(.TrialDays, "TrialDays", False) 
      .MasterID = moUtil.EditLong(.MasterID, "MasterID", False) 
      .IsIncluded = moUtil.EditInteger(.IsIncluded, "IsIncluded", False, 0, 0, 1) 
      .IsMaster = moUtil.EditInteger(.IsMaster, "IsMaster", False, 0, 0, 1) 
      .MasterPrice = moUtil.EditCurrency(.MasterPrice, "MasterPrice", False) 
      .MasterMembers = moUtil.EditLong(.MasterMembers, "MasterMembers", False) 
      .MaxMembers = moUtil.EditLong(.MaxMembers, "MaxMembers", False) 
      .VisitDate = moUtil.EditDate(.VisitDate, "VisitDate", False) 
      .TaxIDType = moUtil.EditLong(.TaxIDType, "TaxIDType", False) 
      .TaxID = moUtil.EditString(.TaxID, "TaxID", False, , 1, 15) 
      .AutoShipDate = moUtil.EditDate(.AutoShipDate, "AutoShipDate", False) 
      .PaidDate = moUtil.EditDate(.PaidDate, "PaidDate", False) 
      .StatusDate = moUtil.EditDate(.StatusDate, "StatusDate", False) 
      .StatusChange = moUtil.EditLong(.StatusChange, "StatusChange", False) 
      .LevelChange = moUtil.EditLong(.LevelChange, "LevelChange", False) 
      .IsRemoved = moUtil.EditInteger(.IsRemoved, "IsRemoved", False, 0, 0, 1) 
      .GroupID = moUtil.EditLong(.GroupID, "GroupID", False) 
      .Role = moUtil.EditString(.Role, "Role", False, , 1, 15) 
      .Secure = moUtil.EditLong(.Secure, "Secure", False) 
      .Options = moUtil.EditString(.Options, "Options", False) 
      .Options2 = moUtil.EditString(.Options2, "Options2", False, , 1, 40) 
      .Pos = moUtil.EditLong(.Pos, "Pos", False) 
      .Signature = moUtil.EditString(.Signature, "Signature", False, , 1, 1000) 
      .SocNet = moUtil.EditString(.SocNet, "SocNet", False, , 1, 200) 
      .ConfLine = moUtil.EditString(.ConfLine, "ConfLine", False, , 1, 40) 
      .NotifyMentor = moUtil.EditString(.NotifyMentor, "NotifyMentor", False, , 1, 10) 
      .Image = moUtil.EditString(.Image, "Image", False, , 1, 15) 
      .Identification = moUtil.EditString(.Identification, "Identification", False) 
      .Title = moUtil.EditLong(.Title, "Title", False) 
      .Title2 = moUtil.EditLong(.Title2, "Title2", False) 
      .MinTitle = moUtil.EditLong(.MinTitle, "MinTitle", False) 
      .TitleDate = moUtil.EditDate(.TitleDate, "TitleDate", False) 
      .InputValues = moUtil.EditString(.InputValues, "InputValues", False, , 1, 1000) 
      .Icons = moUtil.EditString(.Icons, "Icons", False, , 1, 20) 
      .IsMsg = moUtil.EditLong(.IsMsg, "IsMsg", False) 
      .Timezone = moUtil.EditLong(.Timezone, "Timezone", False) 
      .Process = moUtil.EditLong(.Process, "Process", False) 
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