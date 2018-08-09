VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CAffiliateB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CAffiliate"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tAffiliateType
   AffiliateID As String
   AuthUserID As String
   CompanyID As String
   MemberID As String
   SponsorID As String
   UserGroup As String
   UserStatus As String
   Logon As String
   AffiliateName As String
   NameLast As String
   NameFirst As String
   ContactName As String
   Street As String
   Unit As String
   City As String
   State As String
   Zip As String
   Country As String
   Email As String
   Phone1 As String
   Phone2 As String
   Fax As String
   SSN As String
   Status As String
   EnrollDate As String
   Website As String
   Terms As String
   LeadCampaigns As String
   NewLogon As String
   NewPassword As String
End Type

Public Sub Add( _ 
   ByRef brRec As tAffiliateType, _ 
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
      .Parameters.Append .CreateParameter("@AffiliateID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@SponsorID", adInteger, adParamInput, vbNull, CLng(brRec.SponsorID))
      .Parameters.Append .CreateParameter("@UserGroup", adInteger, adParamInput, vbNull, CLng(brRec.UserGroup))
      .Parameters.Append .CreateParameter("@UserStatus", adInteger, adParamInput, vbNull, CLng(brRec.UserStatus))
      .Parameters.Append .CreateParameter("@AffiliateName", adVarWChar, adParamInput, 60, brRec.AffiliateName)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamInput, 30, brRec.NameLast)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamInput, 30, brRec.NameFirst)
      .Parameters.Append .CreateParameter("@Street", adVarWChar, adParamInput, 60, brRec.Street)
      .Parameters.Append .CreateParameter("@Unit", adVarWChar, adParamInput, 40, brRec.Unit)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamInput, 30, brRec.City)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamInput, 30, brRec.State)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamInput, 20, brRec.Zip)
      .Parameters.Append .CreateParameter("@Country", adVarWChar, adParamInput, 30, brRec.Country)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@Phone1", adVarWChar, adParamInput, 30, brRec.Phone1)
      .Parameters.Append .CreateParameter("@Phone2", adVarWChar, adParamInput, 30, brRec.Phone2)
      .Parameters.Append .CreateParameter("@Fax", adVarWChar, adParamInput, 30, brRec.Fax)
      .Parameters.Append .CreateParameter("@SSN", adVarWChar, adParamInput, 18, brRec.SSN)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@EnrollDate", adDate, adParamInput, vbNull, CDate(brRec.EnrollDate))
      .Parameters.Append .CreateParameter("@Website", adVarWChar, adParamInput, 80, brRec.Website)
      .Parameters.Append .CreateParameter("@Terms", adVarWChar, adParamInput, 1000, brRec.Terms)
      .Parameters.Append .CreateParameter("@LeadCampaigns", adVarWChar, adParamInput, 50, brRec.LeadCampaigns)
      .Parameters.Append .CreateParameter("@NewLogon", adVarWChar, adParamInput, 80, brRec.NewLogon)
      .Parameters.Append .CreateParameter("@NewPassword", adVarWChar, adParamInput, 30, brRec.NewPassword)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Affiliate_Add"

   '-----get return values
   With brRec
      .AffiliateID = moUtil.FetchLong(oCmd.Parameters.Item("@AffiliateID").Value)
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
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Affiliate_Count"

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
   ByRef brRec As tAffiliateType, _ 
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
      .AffiliateID = moUtil.EditLong(.AffiliateID, "AffiliateID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AffiliateID", adInteger, adParamInput, vbNull, CLng(brRec.AffiliateID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Affiliate_Delete"

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
   ByRef brRec As tAffiliateType, _ 
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
      .AffiliateID = moUtil.EditLong(.AffiliateID, "AffiliateID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AffiliateID", adInteger, adParamInput, vbNull, CLng(brRec.AffiliateID))
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SponsorID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserGroup", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserStatus", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Logon", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@AffiliateName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@ContactName", adVarWChar, adParamOutput, 62, vbNull)
      .Parameters.Append .CreateParameter("@Street", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Unit", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@Country", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@Phone1", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Phone2", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Fax", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@SSN", adVarWChar, adParamOutput, 18, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@EnrollDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Website", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@Terms", adVarWChar, adParamOutput, 1000, vbNull)
      .Parameters.Append .CreateParameter("@LeadCampaigns", adVarWChar, adParamOutput, 50, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Affiliate_Fetch"

   '-----get return values
   With brRec
      .AuthUserID = moUtil.FetchLong(oCmd.Parameters.Item("@AuthUserID").Value)
      .CompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@CompanyID").Value)
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .SponsorID = moUtil.FetchLong(oCmd.Parameters.Item("@SponsorID").Value)
      .UserGroup = moUtil.FetchLong(oCmd.Parameters.Item("@UserGroup").Value)
      .UserStatus = moUtil.FetchLong(oCmd.Parameters.Item("@UserStatus").Value)
      .Logon = moUtil.FetchString(oCmd.Parameters.Item("@Logon").Value)
      .AffiliateName = moUtil.FetchString(oCmd.Parameters.Item("@AffiliateName").Value)
      .NameLast = moUtil.FetchString(oCmd.Parameters.Item("@NameLast").Value)
      .NameFirst = moUtil.FetchString(oCmd.Parameters.Item("@NameFirst").Value)
      .ContactName = moUtil.FetchString(oCmd.Parameters.Item("@ContactName").Value)
      .Street = moUtil.FetchString(oCmd.Parameters.Item("@Street").Value)
      .Unit = moUtil.FetchString(oCmd.Parameters.Item("@Unit").Value)
      .City = moUtil.FetchString(oCmd.Parameters.Item("@City").Value)
      .State = moUtil.FetchString(oCmd.Parameters.Item("@State").Value)
      .Zip = moUtil.FetchString(oCmd.Parameters.Item("@Zip").Value)
      .Country = moUtil.FetchString(oCmd.Parameters.Item("@Country").Value)
      .Email = moUtil.FetchString(oCmd.Parameters.Item("@Email").Value)
      .Phone1 = moUtil.FetchString(oCmd.Parameters.Item("@Phone1").Value)
      .Phone2 = moUtil.FetchString(oCmd.Parameters.Item("@Phone2").Value)
      .Fax = moUtil.FetchString(oCmd.Parameters.Item("@Fax").Value)
      .SSN = moUtil.FetchString(oCmd.Parameters.Item("@SSN").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .EnrollDate = moUtil.FetchDate(oCmd.Parameters.Item("@EnrollDate").Value)
      .Website = moUtil.FetchString(oCmd.Parameters.Item("@Website").Value)
      .Terms = moUtil.FetchString(oCmd.Parameters.Item("@Terms").Value)
      .LeadCampaigns = moUtil.FetchString(oCmd.Parameters.Item("@LeadCampaigns").Value)
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

Public Sub FetchIDs( _ 
   ByRef brRec As tAffiliateType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FetchIDs"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .AffiliateID = moUtil.EditLong(.AffiliateID, "AffiliateID", True, 0, 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AffiliateID", adInteger, adParamInput, vbNull, CLng(brRec.AffiliateID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Affiliate_FetchIDs"

   '-----get return values
   With brRec
      .AuthUserID = moUtil.FetchLong(oCmd.Parameters.Item("@AuthUserID").Value)
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

Public Sub LoadAuthUser( _ 
   ByRef brRec As tAffiliateType, _ 
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
      .Parameters.Append .CreateParameter("@AffiliateID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Affiliate_LoadAuthUser"

   '-----get return values
   With brRec
      .AffiliateID = moUtil.FetchLong(oCmd.Parameters.Item("@AffiliateID").Value)
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

Public Sub LoadLogon( _ 
   ByRef brRec As tAffiliateType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "LoadLogon"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Logon", adVarWChar, adParamInput, 80, brRec.Logon)
      .Parameters.Append .CreateParameter("@AffiliateID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AffiliateName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Phone1", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamOutput, 80, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Affiliate_LoadLogon"

   '-----get return values
   With brRec
      .AffiliateID = moUtil.FetchLong(oCmd.Parameters.Item("@AffiliateID").Value)
      .AffiliateName = moUtil.FetchString(oCmd.Parameters.Item("@AffiliateName").Value)
      .CompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@CompanyID").Value)
      .NameLast = moUtil.FetchString(oCmd.Parameters.Item("@NameLast").Value)
      .NameFirst = moUtil.FetchString(oCmd.Parameters.Item("@NameFirst").Value)
      .Phone1 = moUtil.FetchString(oCmd.Parameters.Item("@Phone1").Value)
      .Email = moUtil.FetchString(oCmd.Parameters.Item("@Email").Value)
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
   Optional ByVal bvSecurityToken As Long = 0) As tAffiliateType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAffiliateType
   Dim vRec As tAffiliateType
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
      Case cptsAffiliateFindAffiliateName
         sProc = "pts_Affiliate_FindAffiliateName"
         MaxBookMark = 70
      Case cptsAffiliateFindContactName
         sProc = "pts_Affiliate_FindContactName"
         MaxBookMark = 72
      Case cptsAffiliateFindAffiliateID
         sProc = "pts_Affiliate_FindAffiliateID"
         MaxBookMark = 20
      Case cptsAffiliateFindEmail
         sProc = "pts_Affiliate_FindEmail"
         MaxBookMark = 90
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
               vRec.AffiliateID = moUtil.FetchLong(.Fields.Item("AffiliateID").Value)
               vRec.AuthUserID = moUtil.FetchLong(.Fields.Item("AuthUserID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.SponsorID = moUtil.FetchLong(.Fields.Item("SponsorID").Value)
               vRec.UserGroup = moUtil.FetchLong(.Fields.Item("UserGroup").Value)
               vRec.UserStatus = moUtil.FetchLong(.Fields.Item("UserStatus").Value)
               vRec.Logon = moUtil.FetchString(.Fields.Item("Logon").Value)
               vRec.AffiliateName = moUtil.FetchString(.Fields.Item("AffiliateName").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.ContactName = moUtil.FetchString(.Fields.Item("ContactName").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Fax = moUtil.FetchString(.Fields.Item("Fax").Value)
               vRec.SSN = moUtil.FetchString(.Fields.Item("SSN").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.EnrollDate = moUtil.FetchDate(.Fields.Item("EnrollDate").Value)
               vRec.Website = moUtil.FetchString(.Fields.Item("Website").Value)
               vRec.Terms = moUtil.FetchString(.Fields.Item("Terms").Value)
               vRec.LeadCampaigns = moUtil.FetchString(.Fields.Item("LeadCampaigns").Value)
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

Public Function FindMember( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tAffiliateType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAffiliateType
   Dim vRec As tAffiliateType
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
      Case cptsAffiliateFindAffiliateName
         sProc = "pts_Affiliate_FindMemberAffiliateName"
         MaxBookMark = 70
      Case cptsAffiliateFindContactName
         sProc = "pts_Affiliate_FindMemberContactName"
         MaxBookMark = 72
      Case cptsAffiliateFindAffiliateID
         sProc = "pts_Affiliate_FindMemberAffiliateID"
         MaxBookMark = 20
      Case cptsAffiliateFindEmail
         sProc = "pts_Affiliate_FindMemberEmail"
         MaxBookMark = 90
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
               vRec.AffiliateID = moUtil.FetchLong(.Fields.Item("AffiliateID").Value)
               vRec.AuthUserID = moUtil.FetchLong(.Fields.Item("AuthUserID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.SponsorID = moUtil.FetchLong(.Fields.Item("SponsorID").Value)
               vRec.UserGroup = moUtil.FetchLong(.Fields.Item("UserGroup").Value)
               vRec.UserStatus = moUtil.FetchLong(.Fields.Item("UserStatus").Value)
               vRec.Logon = moUtil.FetchString(.Fields.Item("Logon").Value)
               vRec.AffiliateName = moUtil.FetchString(.Fields.Item("AffiliateName").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.ContactName = moUtil.FetchString(.Fields.Item("ContactName").Value)
               vRec.Street = moUtil.FetchString(.Fields.Item("Street").Value)
               vRec.Unit = moUtil.FetchString(.Fields.Item("Unit").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Country = moUtil.FetchString(.Fields.Item("Country").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Phone1 = moUtil.FetchString(.Fields.Item("Phone1").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Fax = moUtil.FetchString(.Fields.Item("Fax").Value)
               vRec.SSN = moUtil.FetchString(.Fields.Item("SSN").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.EnrollDate = moUtil.FetchDate(.Fields.Item("EnrollDate").Value)
               vRec.Website = moUtil.FetchString(.Fields.Item("Website").Value)
               vRec.Terms = moUtil.FetchString(.Fields.Item("Terms").Value)
               vRec.LeadCampaigns = moUtil.FetchString(.Fields.Item("LeadCampaigns").Value)
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

Public Sub Update( _ 
   ByRef brRec As tAffiliateType, _ 
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
      .Parameters.Append .CreateParameter("@AffiliateID", adInteger, adParamInput, vbNull, CLng(brRec.AffiliateID))
      .Parameters.Append .CreateParameter("@AuthUserID", adInteger, adParamInput, vbNull, CLng(brRec.AuthUserID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@SponsorID", adInteger, adParamInput, vbNull, CLng(brRec.SponsorID))
      .Parameters.Append .CreateParameter("@UserGroup", adInteger, adParamInput, vbNull, CLng(brRec.UserGroup))
      .Parameters.Append .CreateParameter("@UserStatus", adInteger, adParamInput, vbNull, CLng(brRec.UserStatus))
      .Parameters.Append .CreateParameter("@AffiliateName", adVarWChar, adParamInput, 60, brRec.AffiliateName)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamInput, 30, brRec.NameLast)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamInput, 30, brRec.NameFirst)
      .Parameters.Append .CreateParameter("@Street", adVarWChar, adParamInput, 60, brRec.Street)
      .Parameters.Append .CreateParameter("@Unit", adVarWChar, adParamInput, 40, brRec.Unit)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamInput, 30, brRec.City)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamInput, 30, brRec.State)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamInput, 20, brRec.Zip)
      .Parameters.Append .CreateParameter("@Country", adVarWChar, adParamInput, 30, brRec.Country)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@Phone1", adVarWChar, adParamInput, 30, brRec.Phone1)
      .Parameters.Append .CreateParameter("@Phone2", adVarWChar, adParamInput, 30, brRec.Phone2)
      .Parameters.Append .CreateParameter("@Fax", adVarWChar, adParamInput, 30, brRec.Fax)
      .Parameters.Append .CreateParameter("@SSN", adVarWChar, adParamInput, 18, brRec.SSN)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@EnrollDate", adDate, adParamInput, vbNull, CDate(brRec.EnrollDate))
      .Parameters.Append .CreateParameter("@Website", adVarWChar, adParamInput, 80, brRec.Website)
      .Parameters.Append .CreateParameter("@Terms", adVarWChar, adParamInput, 1000, brRec.Terms)
      .Parameters.Append .CreateParameter("@LeadCampaigns", adVarWChar, adParamInput, 50, brRec.LeadCampaigns)
      .Parameters.Append .CreateParameter("@NewLogon", adVarWChar, adParamInput, 80, brRec.NewLogon)
      .Parameters.Append .CreateParameter("@NewPassword", adVarWChar, adParamInput, 30, brRec.NewPassword)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Affiliate_Update"

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
   ByRef brRec As tAffiliateType, _ 
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
         .AffiliateID = moUtil.EditLong(.AffiliateID, "AffiliateID", True, , 1) 
      End If
      .AuthUserID = moUtil.EditLong(.AuthUserID, "AuthUserID", False) 
      .CompanyID = moUtil.EditLong(.CompanyID, "CompanyID", False) 
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", False) 
      .SponsorID = moUtil.EditLong(.SponsorID, "SponsorID", False) 
      .AffiliateName = moUtil.EditString(.AffiliateName, "AffiliateName", True, , 1, 60) 
      .NameLast = moUtil.EditString(.NameLast, "NameLast", False, , 1, 30) 
      .NameFirst = moUtil.EditString(.NameFirst, "NameFirst", False, , 1, 30) 
      .Street = moUtil.EditString(.Street, "Street", False, , 1, 60) 
      .Unit = moUtil.EditString(.Unit, "Unit", False, , 1, 40) 
      .City = moUtil.EditString(.City, "City", False, , 1, 30) 
      .State = moUtil.EditString(.State, "State", False, , 1, 30) 
      .Zip = moUtil.EditString(.Zip, "Zip", False, , 1, 20) 
      .Country = moUtil.EditString(.Country, "Country", False, , 1, 30) 
      .Email = moUtil.EditString(.Email, "Email", False, , 1, 80) 
      .Phone1 = moUtil.EditString(.Phone1, "Phone1", False, , 1, 30) 
      .Phone2 = moUtil.EditString(.Phone2, "Phone2", False, , 1, 30) 
      .Fax = moUtil.EditString(.Fax, "Fax", False, , 1, 30) 
      .SSN = moUtil.EditString(.SSN, "SSN", False, , 1, 18) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .EnrollDate = moUtil.EditDate(.EnrollDate, "EnrollDate", False) 
      .Website = moUtil.EditString(.Website, "Website", False, , 1, 80) 
      .Terms = moUtil.EditString(.Terms, "Terms", False, , 1, 1000) 
      .LeadCampaigns = moUtil.EditString(.LeadCampaigns, "LeadCampaigns", False, , 1, 50) 
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