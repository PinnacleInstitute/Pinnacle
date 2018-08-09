VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CMerchantB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CMerchant"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tMerchantType
   MerchantID As String
   MemberID As String
   BillingID As String
   PayoutID As String
   CountryID As String
   SweepID As String
   MemberNameLast As String
   MemberNameFirst As String
   MemberName As String
   CountryName As String
   MerchantName As String
   NameLast As String
   NameFirst As String
   Email As String
   Email2 As String
   Email3 As String
   Phone As String
   Phone2 As String
   Password As String
   Password2 As String
   Password3 As String
   Password4 As String
   Status As String
   Street1 As String
   Street2 As String
   City As String
   State As String
   Zip As String
   Referrals As String
   Referrals2 As String
   VisitDate As String
   IsOrg As String
   IsAwards As String
   EnrollDate As String
   BillDate As String
   BillDays As String
   Image As String
   Description As String
   Terms As String
   Options As String
   StoreOptions As String
   Colors As String
   Rating As String
   CurrencyCode As String
   Processor As String
   Payment As String
   UserKey As String
   UserKey3 As String
   UserKey4 As String
   UserCode As String
   Access As String
   PromoLimit As String
   SweepRate As String
   TimeZone As String
   GeoCode As String
   ReferRate As String
   Target As String
   RewardAmt As String
   RewardDesc As String
   RewardCap As String
End Type

Public Sub Add( _ 
   ByRef brRec As tMerchantType, _ 
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
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@BillingID", adInteger, adParamInput, vbNull, CLng(brRec.BillingID))
      .Parameters.Append .CreateParameter("@PayoutID", adInteger, adParamInput, vbNull, CLng(brRec.PayoutID))
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamInput, vbNull, CLng(brRec.CountryID))
      .Parameters.Append .CreateParameter("@SweepID", adInteger, adParamInput, vbNull, CLng(brRec.SweepID))
      .Parameters.Append .CreateParameter("@MerchantName", adVarWChar, adParamInput, 80, brRec.MerchantName)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamInput, 30, brRec.NameLast)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamInput, 30, brRec.NameFirst)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@Email2", adVarWChar, adParamInput, 80, brRec.Email2)
      .Parameters.Append .CreateParameter("@Email3", adVarWChar, adParamInput, 80, brRec.Email3)
      .Parameters.Append .CreateParameter("@Phone", adVarWChar, adParamInput, 30, brRec.Phone)
      .Parameters.Append .CreateParameter("@Phone2", adVarWChar, adParamInput, 30, brRec.Phone2)
      .Parameters.Append .CreateParameter("@Password", adVarWChar, adParamInput, 20, brRec.Password)
      .Parameters.Append .CreateParameter("@Password2", adVarWChar, adParamInput, 20, brRec.Password2)
      .Parameters.Append .CreateParameter("@Password3", adVarWChar, adParamInput, 20, brRec.Password3)
      .Parameters.Append .CreateParameter("@Password4", adVarWChar, adParamInput, 20, brRec.Password4)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Street1", adVarWChar, adParamInput, 60, brRec.Street1)
      .Parameters.Append .CreateParameter("@Street2", adVarWChar, adParamInput, 60, brRec.Street2)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamInput, 30, brRec.City)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamInput, 30, brRec.State)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamInput, 20, brRec.Zip)
      .Parameters.Append .CreateParameter("@Referrals", adInteger, adParamInput, vbNull, CLng(brRec.Referrals))
      .Parameters.Append .CreateParameter("@Referrals2", adInteger, adParamInput, vbNull, CLng(brRec.Referrals2))
      .Parameters.Append .CreateParameter("@VisitDate", adDate, adParamInput, vbNull, CDate(brRec.VisitDate))
      .Parameters.Append .CreateParameter("@IsOrg", adSmallInt, adParamInput, vbNull, CInt(brRec.IsOrg))
      .Parameters.Append .CreateParameter("@IsAwards", adSmallInt, adParamInput, vbNull, CInt(brRec.IsAwards))
      .Parameters.Append .CreateParameter("@EnrollDate", adDate, adParamInput, vbNull, CDate(brRec.EnrollDate))
      .Parameters.Append .CreateParameter("@BillDate", adDate, adParamInput, vbNull, CDate(brRec.BillDate))
      .Parameters.Append .CreateParameter("@BillDays", adInteger, adParamInput, vbNull, CLng(brRec.BillDays))
      .Parameters.Append .CreateParameter("@Image", adVarWChar, adParamInput, 40, brRec.Image)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 2000, brRec.Description)
      .Parameters.Append .CreateParameter("@Terms", adVarWChar, adParamInput, 100, brRec.Terms)
      .Parameters.Append .CreateParameter("@Options", adVarWChar, adParamInput, 20, brRec.Options)
      .Parameters.Append .CreateParameter("@StoreOptions", adVarWChar, adParamInput, 20, brRec.StoreOptions)
      .Parameters.Append .CreateParameter("@Colors", adVarWChar, adParamInput, 100, brRec.Colors)
      .Parameters.Append .CreateParameter("@Rating", adInteger, adParamInput, vbNull, CLng(brRec.Rating))
      .Parameters.Append .CreateParameter("@CurrencyCode", adVarWChar, adParamInput, 3, brRec.CurrencyCode)
      .Parameters.Append .CreateParameter("@Processor", adInteger, adParamInput, vbNull, CLng(brRec.Processor))
      .Parameters.Append .CreateParameter("@Payment", adVarWChar, adParamInput, 1000, brRec.Payment)
      .Parameters.Append .CreateParameter("@UserKey", adVarWChar, adParamInput, 40, brRec.UserKey)
      .Parameters.Append .CreateParameter("@UserKey3", adVarWChar, adParamInput, 40, brRec.UserKey3)
      .Parameters.Append .CreateParameter("@UserKey4", adVarWChar, adParamInput, 40, brRec.UserKey4)
      .Parameters.Append .CreateParameter("@UserCode", adVarWChar, adParamInput, 10, brRec.UserCode)
      .Parameters.Append .CreateParameter("@Access", adVarWChar, adParamInput, 80, brRec.Access)
      .Parameters.Append .CreateParameter("@PromoLimit", adInteger, adParamInput, vbNull, CLng(brRec.PromoLimit))
      .Parameters.Append .CreateParameter("@SweepRate", adInteger, adParamInput, vbNull, CLng(brRec.SweepRate))
      .Parameters.Append .CreateParameter("@TimeZone", adInteger, adParamInput, vbNull, CLng(brRec.TimeZone))
      .Parameters.Append .CreateParameter("@GeoCode", adVarWChar, adParamInput, 30, brRec.GeoCode)
      .Parameters.Append .CreateParameter("@ReferRate", adInteger, adParamInput, vbNull, CLng(brRec.ReferRate))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Merchant_Add"

   '-----get return values
   With brRec
      .MerchantID = moUtil.FetchLong(oCmd.Parameters.Item("@MerchantID").Value)
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

Public Function Logon( _ 
   ByRef brRec As tMerchantType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Logon"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .Email = moUtil.EditString(.Email, "Email", True, "", 1, 80) 
      .Password = moUtil.EditString(.Password, "Password", True, "", 1, 20) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@Password", adVarWChar, adParamInput, 20, brRec.Password)
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Merchant_Logon"

   '-----get return values
   Logon = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function Logon2( _ 
   ByRef brRec As tMerchantType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Logon2"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .Email = moUtil.EditString(.Email, "Email", True, "", 1, 80) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Merchant_Logon2"

   '-----get return values
   Logon2 = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

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
   ByRef brRec As tMerchantType, _ 
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
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamInput, vbNull, CLng(brRec.MerchantID))
      .Parameters.Append .CreateParameter("@MerchantName", adVarWChar, adParamInput, 80, brRec.MerchantName)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamInput, 30, brRec.City)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamInput, 30, brRec.State)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamInput, 20, brRec.Zip)
      .Parameters.Append .CreateParameter("@CountryName", adVarWChar, adParamInput, 50, brRec.CountryName)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 2000, brRec.Description)
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Merchant_UpdateFT"

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

Public Function Custom( _ 
   ByRef brRec As tMerchantType, _ 
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
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamInput, vbNull, CLng(brRec.MerchantID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@BillingID", adInteger, adParamInput, vbNull, CLng(brRec.BillingID))
      .Parameters.Append .CreateParameter("@EnrollDate", adDate, adParamInput, vbNull, CDate(brRec.EnrollDate))
      .Parameters.Append .CreateParameter("@Access", adVarWChar, adParamInput, 80, brRec.Access)
      .Parameters.Append .CreateParameter("@Result", adVarWChar, adParamOutput, 1000, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Merchant_Custom"

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

Public Function CountMarket( _ 
   ByRef brRec As tMerchantType, _ 
   ByVal bvUserID As Long) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CountMarket"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .Target = moUtil.EditString(.Target, "Target", True, "", 1, 200) 
      .CountryID = moUtil.EditLong(.CountryID, "CountryID", True, 0) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Target", adVarWChar, adParamInput, 200, brRec.Target)
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamInput, vbNull, CLng(brRec.CountryID))
      .Parameters.Append .CreateParameter("@Result", adVarWChar, adParamOutput, 100, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Merchant_CountMarket"

   '-----get return values
   CountMarket = moUtil.FetchString(oCmd.Parameters.Item("@Result").Value)

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
   ByRef brRec As tMerchantType, _ 
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
      .MerchantID = moUtil.EditLong(.MerchantID, "MerchantID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamInput, vbNull, CLng(brRec.MerchantID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Merchant_Delete"

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
   ByRef brRec As tMerchantType, _ 
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
      .MerchantID = moUtil.EditLong(.MerchantID, "MerchantID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamInput, vbNull, CLng(brRec.MerchantID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BillingID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PayoutID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SweepID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberNameLast", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@MemberNameFirst", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@MemberName", adVarWChar, adParamOutput, 61, vbNull)
      .Parameters.Append .CreateParameter("@CountryName", adVarWChar, adParamOutput, 50, vbNull)
      .Parameters.Append .CreateParameter("@MerchantName", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@Email2", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@Email3", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@Phone", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Phone2", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Password", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@Password2", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@Password3", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@Password4", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Street1", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Street2", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@Referrals", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Referrals2", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@VisitDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsOrg", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsAwards", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@EnrollDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BillDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BillDays", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Image", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamOutput, 2000, vbNull)
      .Parameters.Append .CreateParameter("@Terms", adVarWChar, adParamOutput, 100, vbNull)
      .Parameters.Append .CreateParameter("@Options", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@StoreOptions", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@Colors", adVarWChar, adParamOutput, 100, vbNull)
      .Parameters.Append .CreateParameter("@Rating", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CurrencyCode", adVarWChar, adParamOutput, 3, vbNull)
      .Parameters.Append .CreateParameter("@Processor", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Payment", adVarWChar, adParamOutput, 1000, vbNull)
      .Parameters.Append .CreateParameter("@UserKey", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@UserKey3", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@UserKey4", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@UserCode", adVarWChar, adParamOutput, 10, vbNull)
      .Parameters.Append .CreateParameter("@Access", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@PromoLimit", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SweepRate", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@TimeZone", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@GeoCode", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@ReferRate", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Merchant_Fetch"

   '-----get return values
   With brRec
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .BillingID = moUtil.FetchLong(oCmd.Parameters.Item("@BillingID").Value)
      .PayoutID = moUtil.FetchLong(oCmd.Parameters.Item("@PayoutID").Value)
      .CountryID = moUtil.FetchLong(oCmd.Parameters.Item("@CountryID").Value)
      .SweepID = moUtil.FetchLong(oCmd.Parameters.Item("@SweepID").Value)
      .MemberNameLast = moUtil.FetchString(oCmd.Parameters.Item("@MemberNameLast").Value)
      .MemberNameFirst = moUtil.FetchString(oCmd.Parameters.Item("@MemberNameFirst").Value)
      .MemberName = moUtil.FetchString(oCmd.Parameters.Item("@MemberName").Value)
      .CountryName = moUtil.FetchString(oCmd.Parameters.Item("@CountryName").Value)
      .MerchantName = moUtil.FetchString(oCmd.Parameters.Item("@MerchantName").Value)
      .NameLast = moUtil.FetchString(oCmd.Parameters.Item("@NameLast").Value)
      .NameFirst = moUtil.FetchString(oCmd.Parameters.Item("@NameFirst").Value)
      .Email = moUtil.FetchString(oCmd.Parameters.Item("@Email").Value)
      .Email2 = moUtil.FetchString(oCmd.Parameters.Item("@Email2").Value)
      .Email3 = moUtil.FetchString(oCmd.Parameters.Item("@Email3").Value)
      .Phone = moUtil.FetchString(oCmd.Parameters.Item("@Phone").Value)
      .Phone2 = moUtil.FetchString(oCmd.Parameters.Item("@Phone2").Value)
      .Password = moUtil.FetchString(oCmd.Parameters.Item("@Password").Value)
      .Password2 = moUtil.FetchString(oCmd.Parameters.Item("@Password2").Value)
      .Password3 = moUtil.FetchString(oCmd.Parameters.Item("@Password3").Value)
      .Password4 = moUtil.FetchString(oCmd.Parameters.Item("@Password4").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .Street1 = moUtil.FetchString(oCmd.Parameters.Item("@Street1").Value)
      .Street2 = moUtil.FetchString(oCmd.Parameters.Item("@Street2").Value)
      .City = moUtil.FetchString(oCmd.Parameters.Item("@City").Value)
      .State = moUtil.FetchString(oCmd.Parameters.Item("@State").Value)
      .Zip = moUtil.FetchString(oCmd.Parameters.Item("@Zip").Value)
      .Referrals = moUtil.FetchLong(oCmd.Parameters.Item("@Referrals").Value)
      .Referrals2 = moUtil.FetchLong(oCmd.Parameters.Item("@Referrals2").Value)
      .VisitDate = moUtil.FetchDate(oCmd.Parameters.Item("@VisitDate").Value)
      .IsOrg = moUtil.FetchInteger(oCmd.Parameters.Item("@IsOrg").Value)
      .IsAwards = moUtil.FetchInteger(oCmd.Parameters.Item("@IsAwards").Value)
      .EnrollDate = moUtil.FetchDate(oCmd.Parameters.Item("@EnrollDate").Value)
      .BillDate = moUtil.FetchDate(oCmd.Parameters.Item("@BillDate").Value)
      .BillDays = moUtil.FetchLong(oCmd.Parameters.Item("@BillDays").Value)
      .Image = moUtil.FetchString(oCmd.Parameters.Item("@Image").Value)
      .Description = moUtil.FetchString(oCmd.Parameters.Item("@Description").Value)
      .Terms = moUtil.FetchString(oCmd.Parameters.Item("@Terms").Value)
      .Options = moUtil.FetchString(oCmd.Parameters.Item("@Options").Value)
      .StoreOptions = moUtil.FetchString(oCmd.Parameters.Item("@StoreOptions").Value)
      .Colors = moUtil.FetchString(oCmd.Parameters.Item("@Colors").Value)
      .Rating = moUtil.FetchLong(oCmd.Parameters.Item("@Rating").Value)
      .CurrencyCode = moUtil.FetchString(oCmd.Parameters.Item("@CurrencyCode").Value)
      .Processor = moUtil.FetchLong(oCmd.Parameters.Item("@Processor").Value)
      .Payment = moUtil.FetchString(oCmd.Parameters.Item("@Payment").Value)
      .UserKey = moUtil.FetchString(oCmd.Parameters.Item("@UserKey").Value)
      .UserKey3 = moUtil.FetchString(oCmd.Parameters.Item("@UserKey3").Value)
      .UserKey4 = moUtil.FetchString(oCmd.Parameters.Item("@UserKey4").Value)
      .UserCode = moUtil.FetchString(oCmd.Parameters.Item("@UserCode").Value)
      .Access = moUtil.FetchString(oCmd.Parameters.Item("@Access").Value)
      .PromoLimit = moUtil.FetchLong(oCmd.Parameters.Item("@PromoLimit").Value)
      .SweepRate = moUtil.FetchLong(oCmd.Parameters.Item("@SweepRate").Value)
      .TimeZone = moUtil.FetchLong(oCmd.Parameters.Item("@TimeZone").Value)
      .GeoCode = moUtil.FetchString(oCmd.Parameters.Item("@GeoCode").Value)
      .ReferRate = moUtil.FetchLong(oCmd.Parameters.Item("@ReferRate").Value)
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
   ByRef brRec As tMerchantType, _ 
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
      .Email = moUtil.EditString(.Email, "Email", True, "", 1, 80) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Merchant_FetchEmail"

   '-----get return values
   With brRec
      .MerchantID = moUtil.FetchLong(oCmd.Parameters.Item("@MerchantID").Value)
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
   Optional ByVal bvSecurityToken As Long = 0) As tMerchantType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMerchantType
   Dim vRec As tMerchantType
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
      Case cptsMerchantFindMerchantName
         sProc = "pts_Merchant_FindMerchantName"
         MaxBookMark = 90
      Case cptsMerchantFindMerchantID
         sProc = "pts_Merchant_FindMerchantID"
         MaxBookMark = 20
      Case cptsMerchantFindNameLast
         sProc = "pts_Merchant_FindNameLast"
         MaxBookMark = 40
      Case cptsMerchantFindNameFirst
         sProc = "pts_Merchant_FindNameFirst"
         MaxBookMark = 40
      Case cptsMerchantFindEmail
         sProc = "pts_Merchant_FindEmail"
         MaxBookMark = 90
      Case cptsMerchantFindZip
         sProc = "pts_Merchant_FindZip"
         MaxBookMark = 30
      Case cptsMerchantFindCity
         sProc = "pts_Merchant_FindCity"
         MaxBookMark = 40
      Case cptsMerchantFindState
         sProc = "pts_Merchant_FindState"
         MaxBookMark = 40
      Case cptsMerchantFindMemberID
         sProc = "pts_Merchant_FindMemberID"
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
               vRec.MerchantID = moUtil.FetchLong(.Fields.Item("MerchantID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.BillingID = moUtil.FetchLong(.Fields.Item("BillingID").Value)
               vRec.PayoutID = moUtil.FetchLong(.Fields.Item("PayoutID").Value)
               vRec.CountryID = moUtil.FetchLong(.Fields.Item("CountryID").Value)
               vRec.SweepID = moUtil.FetchLong(.Fields.Item("SweepID").Value)
               vRec.MemberNameLast = moUtil.FetchString(.Fields.Item("MemberNameLast").Value)
               vRec.MemberNameFirst = moUtil.FetchString(.Fields.Item("MemberNameFirst").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.CountryName = moUtil.FetchString(.Fields.Item("CountryName").Value)
               vRec.MerchantName = moUtil.FetchString(.Fields.Item("MerchantName").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Email2 = moUtil.FetchString(.Fields.Item("Email2").Value)
               vRec.Email3 = moUtil.FetchString(.Fields.Item("Email3").Value)
               vRec.Phone = moUtil.FetchString(.Fields.Item("Phone").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Password = moUtil.FetchString(.Fields.Item("Password").Value)
               vRec.Password2 = moUtil.FetchString(.Fields.Item("Password2").Value)
               vRec.Password3 = moUtil.FetchString(.Fields.Item("Password3").Value)
               vRec.Password4 = moUtil.FetchString(.Fields.Item("Password4").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Street1 = moUtil.FetchString(.Fields.Item("Street1").Value)
               vRec.Street2 = moUtil.FetchString(.Fields.Item("Street2").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Referrals = moUtil.FetchLong(.Fields.Item("Referrals").Value)
               vRec.Referrals2 = moUtil.FetchLong(.Fields.Item("Referrals2").Value)
               vRec.VisitDate = moUtil.FetchDate(.Fields.Item("VisitDate").Value)
               vRec.IsOrg = moUtil.FetchInteger(.Fields.Item("IsOrg").Value)
               vRec.IsAwards = moUtil.FetchInteger(.Fields.Item("IsAwards").Value)
               vRec.EnrollDate = moUtil.FetchDate(.Fields.Item("EnrollDate").Value)
               vRec.BillDate = moUtil.FetchDate(.Fields.Item("BillDate").Value)
               vRec.BillDays = moUtil.FetchLong(.Fields.Item("BillDays").Value)
               vRec.Image = moUtil.FetchString(.Fields.Item("Image").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Terms = moUtil.FetchString(.Fields.Item("Terms").Value)
               vRec.Options = moUtil.FetchString(.Fields.Item("Options").Value)
               vRec.StoreOptions = moUtil.FetchString(.Fields.Item("StoreOptions").Value)
               vRec.Colors = moUtil.FetchString(.Fields.Item("Colors").Value)
               vRec.Rating = moUtil.FetchLong(.Fields.Item("Rating").Value)
               vRec.CurrencyCode = moUtil.FetchString(.Fields.Item("CurrencyCode").Value)
               vRec.Processor = moUtil.FetchLong(.Fields.Item("Processor").Value)
               vRec.Payment = moUtil.FetchString(.Fields.Item("Payment").Value)
               vRec.UserKey = moUtil.FetchString(.Fields.Item("UserKey").Value)
               vRec.UserKey3 = moUtil.FetchString(.Fields.Item("UserKey3").Value)
               vRec.UserKey4 = moUtil.FetchString(.Fields.Item("UserKey4").Value)
               vRec.UserCode = moUtil.FetchString(.Fields.Item("UserCode").Value)
               vRec.Access = moUtil.FetchString(.Fields.Item("Access").Value)
               vRec.PromoLimit = moUtil.FetchLong(.Fields.Item("PromoLimit").Value)
               vRec.SweepRate = moUtil.FetchLong(.Fields.Item("SweepRate").Value)
               vRec.TimeZone = moUtil.FetchLong(.Fields.Item("TimeZone").Value)
               vRec.GeoCode = moUtil.FetchString(.Fields.Item("GeoCode").Value)
               vRec.ReferRate = moUtil.FetchLong(.Fields.Item("ReferRate").Value)
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
   Optional ByVal bvSecurityToken As Long = 0) As tMerchantType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMerchantType
   Dim vRec As tMerchantType
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
      Case cptsMerchantFindMerchantName
         sProc = "pts_Merchant_FindMemberMerchantName"
         MaxBookMark = 90
      Case cptsMerchantFindMerchantID
         sProc = "pts_Merchant_FindMemberMerchantID"
         MaxBookMark = 20
      Case cptsMerchantFindNameLast
         sProc = "pts_Merchant_FindMemberNameLast"
         MaxBookMark = 40
      Case cptsMerchantFindNameFirst
         sProc = "pts_Merchant_FindMemberNameFirst"
         MaxBookMark = 40
      Case cptsMerchantFindEmail
         sProc = "pts_Merchant_FindMemberEmail"
         MaxBookMark = 90
      Case cptsMerchantFindZip
         sProc = "pts_Merchant_FindMemberZip"
         MaxBookMark = 30
      Case cptsMerchantFindCity
         sProc = "pts_Merchant_FindMemberCity"
         MaxBookMark = 40
      Case cptsMerchantFindState
         sProc = "pts_Merchant_FindMemberState"
         MaxBookMark = 40
      Case cptsMerchantFindMemberID
         sProc = "pts_Merchant_FindMemberMemberID"
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
               vRec.MerchantID = moUtil.FetchLong(.Fields.Item("MerchantID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.BillingID = moUtil.FetchLong(.Fields.Item("BillingID").Value)
               vRec.PayoutID = moUtil.FetchLong(.Fields.Item("PayoutID").Value)
               vRec.CountryID = moUtil.FetchLong(.Fields.Item("CountryID").Value)
               vRec.SweepID = moUtil.FetchLong(.Fields.Item("SweepID").Value)
               vRec.MemberNameLast = moUtil.FetchString(.Fields.Item("MemberNameLast").Value)
               vRec.MemberNameFirst = moUtil.FetchString(.Fields.Item("MemberNameFirst").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.CountryName = moUtil.FetchString(.Fields.Item("CountryName").Value)
               vRec.MerchantName = moUtil.FetchString(.Fields.Item("MerchantName").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Email2 = moUtil.FetchString(.Fields.Item("Email2").Value)
               vRec.Email3 = moUtil.FetchString(.Fields.Item("Email3").Value)
               vRec.Phone = moUtil.FetchString(.Fields.Item("Phone").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Password = moUtil.FetchString(.Fields.Item("Password").Value)
               vRec.Password2 = moUtil.FetchString(.Fields.Item("Password2").Value)
               vRec.Password3 = moUtil.FetchString(.Fields.Item("Password3").Value)
               vRec.Password4 = moUtil.FetchString(.Fields.Item("Password4").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Street1 = moUtil.FetchString(.Fields.Item("Street1").Value)
               vRec.Street2 = moUtil.FetchString(.Fields.Item("Street2").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Referrals = moUtil.FetchLong(.Fields.Item("Referrals").Value)
               vRec.Referrals2 = moUtil.FetchLong(.Fields.Item("Referrals2").Value)
               vRec.VisitDate = moUtil.FetchDate(.Fields.Item("VisitDate").Value)
               vRec.IsOrg = moUtil.FetchInteger(.Fields.Item("IsOrg").Value)
               vRec.IsAwards = moUtil.FetchInteger(.Fields.Item("IsAwards").Value)
               vRec.EnrollDate = moUtil.FetchDate(.Fields.Item("EnrollDate").Value)
               vRec.BillDate = moUtil.FetchDate(.Fields.Item("BillDate").Value)
               vRec.BillDays = moUtil.FetchLong(.Fields.Item("BillDays").Value)
               vRec.Image = moUtil.FetchString(.Fields.Item("Image").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Terms = moUtil.FetchString(.Fields.Item("Terms").Value)
               vRec.Options = moUtil.FetchString(.Fields.Item("Options").Value)
               vRec.StoreOptions = moUtil.FetchString(.Fields.Item("StoreOptions").Value)
               vRec.Colors = moUtil.FetchString(.Fields.Item("Colors").Value)
               vRec.Rating = moUtil.FetchLong(.Fields.Item("Rating").Value)
               vRec.CurrencyCode = moUtil.FetchString(.Fields.Item("CurrencyCode").Value)
               vRec.Processor = moUtil.FetchLong(.Fields.Item("Processor").Value)
               vRec.Payment = moUtil.FetchString(.Fields.Item("Payment").Value)
               vRec.UserKey = moUtil.FetchString(.Fields.Item("UserKey").Value)
               vRec.UserKey3 = moUtil.FetchString(.Fields.Item("UserKey3").Value)
               vRec.UserKey4 = moUtil.FetchString(.Fields.Item("UserKey4").Value)
               vRec.UserCode = moUtil.FetchString(.Fields.Item("UserCode").Value)
               vRec.Access = moUtil.FetchString(.Fields.Item("Access").Value)
               vRec.PromoLimit = moUtil.FetchLong(.Fields.Item("PromoLimit").Value)
               vRec.SweepRate = moUtil.FetchLong(.Fields.Item("SweepRate").Value)
               vRec.TimeZone = moUtil.FetchLong(.Fields.Item("TimeZone").Value)
               vRec.GeoCode = moUtil.FetchString(.Fields.Item("GeoCode").Value)
               vRec.ReferRate = moUtil.FetchLong(.Fields.Item("ReferRate").Value)
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

Public Function FindOrg( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMemberID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tMerchantType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindOrg"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMerchantType
   Dim vRec As tMerchantType
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
      Case cptsMerchantFindMerchantName
         sProc = "pts_Merchant_FindOrgMerchantName"
         MaxBookMark = 90
      Case cptsMerchantFindMerchantID
         sProc = "pts_Merchant_FindOrgMerchantID"
         MaxBookMark = 20
      Case cptsMerchantFindNameLast
         sProc = "pts_Merchant_FindOrgNameLast"
         MaxBookMark = 40
      Case cptsMerchantFindNameFirst
         sProc = "pts_Merchant_FindOrgNameFirst"
         MaxBookMark = 40
      Case cptsMerchantFindEmail
         sProc = "pts_Merchant_FindOrgEmail"
         MaxBookMark = 90
      Case cptsMerchantFindZip
         sProc = "pts_Merchant_FindOrgZip"
         MaxBookMark = 30
      Case cptsMerchantFindCity
         sProc = "pts_Merchant_FindOrgCity"
         MaxBookMark = 40
      Case cptsMerchantFindState
         sProc = "pts_Merchant_FindOrgState"
         MaxBookMark = 40
      Case cptsMerchantFindMemberID
         sProc = "pts_Merchant_FindOrgMemberID"
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
               vRec.MerchantID = moUtil.FetchLong(.Fields.Item("MerchantID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.BillingID = moUtil.FetchLong(.Fields.Item("BillingID").Value)
               vRec.PayoutID = moUtil.FetchLong(.Fields.Item("PayoutID").Value)
               vRec.CountryID = moUtil.FetchLong(.Fields.Item("CountryID").Value)
               vRec.SweepID = moUtil.FetchLong(.Fields.Item("SweepID").Value)
               vRec.MemberNameLast = moUtil.FetchString(.Fields.Item("MemberNameLast").Value)
               vRec.MemberNameFirst = moUtil.FetchString(.Fields.Item("MemberNameFirst").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.CountryName = moUtil.FetchString(.Fields.Item("CountryName").Value)
               vRec.MerchantName = moUtil.FetchString(.Fields.Item("MerchantName").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Email2 = moUtil.FetchString(.Fields.Item("Email2").Value)
               vRec.Email3 = moUtil.FetchString(.Fields.Item("Email3").Value)
               vRec.Phone = moUtil.FetchString(.Fields.Item("Phone").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Password = moUtil.FetchString(.Fields.Item("Password").Value)
               vRec.Password2 = moUtil.FetchString(.Fields.Item("Password2").Value)
               vRec.Password3 = moUtil.FetchString(.Fields.Item("Password3").Value)
               vRec.Password4 = moUtil.FetchString(.Fields.Item("Password4").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Street1 = moUtil.FetchString(.Fields.Item("Street1").Value)
               vRec.Street2 = moUtil.FetchString(.Fields.Item("Street2").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.Referrals = moUtil.FetchLong(.Fields.Item("Referrals").Value)
               vRec.Referrals2 = moUtil.FetchLong(.Fields.Item("Referrals2").Value)
               vRec.VisitDate = moUtil.FetchDate(.Fields.Item("VisitDate").Value)
               vRec.IsOrg = moUtil.FetchInteger(.Fields.Item("IsOrg").Value)
               vRec.IsAwards = moUtil.FetchInteger(.Fields.Item("IsAwards").Value)
               vRec.EnrollDate = moUtil.FetchDate(.Fields.Item("EnrollDate").Value)
               vRec.BillDate = moUtil.FetchDate(.Fields.Item("BillDate").Value)
               vRec.BillDays = moUtil.FetchLong(.Fields.Item("BillDays").Value)
               vRec.Image = moUtil.FetchString(.Fields.Item("Image").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Terms = moUtil.FetchString(.Fields.Item("Terms").Value)
               vRec.Options = moUtil.FetchString(.Fields.Item("Options").Value)
               vRec.StoreOptions = moUtil.FetchString(.Fields.Item("StoreOptions").Value)
               vRec.Colors = moUtil.FetchString(.Fields.Item("Colors").Value)
               vRec.Rating = moUtil.FetchLong(.Fields.Item("Rating").Value)
               vRec.CurrencyCode = moUtil.FetchString(.Fields.Item("CurrencyCode").Value)
               vRec.Processor = moUtil.FetchLong(.Fields.Item("Processor").Value)
               vRec.Payment = moUtil.FetchString(.Fields.Item("Payment").Value)
               vRec.UserKey = moUtil.FetchString(.Fields.Item("UserKey").Value)
               vRec.UserKey3 = moUtil.FetchString(.Fields.Item("UserKey3").Value)
               vRec.UserKey4 = moUtil.FetchString(.Fields.Item("UserKey4").Value)
               vRec.UserCode = moUtil.FetchString(.Fields.Item("UserCode").Value)
               vRec.Access = moUtil.FetchString(.Fields.Item("Access").Value)
               vRec.PromoLimit = moUtil.FetchLong(.Fields.Item("PromoLimit").Value)
               vRec.SweepRate = moUtil.FetchLong(.Fields.Item("SweepRate").Value)
               vRec.TimeZone = moUtil.FetchLong(.Fields.Item("TimeZone").Value)
               vRec.GeoCode = moUtil.FetchString(.Fields.Item("GeoCode").Value)
               vRec.ReferRate = moUtil.FetchLong(.Fields.Item("ReferRate").Value)
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

Public Function Search( _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants) As tMerchantType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Search"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMerchantType
   Dim vRec As tMerchantType
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
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Merchant_Search")

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
               vRec.MerchantID = moUtil.FetchLong(.Fields.Item("MerchantID").Value)
               vRec.MerchantName = moUtil.FetchString(.Fields.Item("MerchantName").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.Email2 = moUtil.FetchString(.Fields.Item("Email2").Value)
               vRec.Phone2 = moUtil.FetchString(.Fields.Item("Phone2").Value)
               vRec.Street1 = moUtil.FetchString(.Fields.Item("Street1").Value)
               vRec.Street2 = moUtil.FetchString(.Fields.Item("Street2").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.EnrollDate = moUtil.FetchDate(.Fields.Item("EnrollDate").Value)
               vRec.CountryName = moUtil.FetchString(.Fields.Item("CountryName").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.StoreOptions = moUtil.FetchString(.Fields.Item("StoreOptions").Value)
               vRec.Colors = moUtil.FetchString(.Fields.Item("Colors").Value)
               vRec.Rating = moUtil.FetchLong(.Fields.Item("Rating").Value)
               vRec.CurrencyCode = moUtil.FetchString(.Fields.Item("CurrencyCode").Value)
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

Public Function ListMarket( _ 
   ByVal bvTarget As String, _ 
   ByVal bvCountryID As Long) As tMerchantType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMarket"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMerchantType
   Dim vRec As tMerchantType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvTarget = moUtil.EditString(bvTarget, "Target", True, "", 1, 200) 
      bvCountryID = moUtil.EditLong(bvCountryID, "CountryID", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Target", adVarWChar, adParamInput, 200, bvTarget)
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamInput, vbNull, CLng(bvCountryID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Merchant_ListMarket")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MerchantID = moUtil.FetchLong(.Fields.Item("MerchantID").Value)
            vRec.MerchantName = moUtil.FetchString(.Fields.Item("MerchantName").Value)
            vRec.Phone = moUtil.FetchString(.Fields.Item("Phone").Value)
            vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
            vRec.Street1 = moUtil.FetchString(.Fields.Item("Street1").Value)
            vRec.Street2 = moUtil.FetchString(.Fields.Item("Street2").Value)
            vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
            vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
            vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Rating = moUtil.FetchLong(.Fields.Item("Rating").Value)
            vRec.CurrencyCode = moUtil.FetchString(.Fields.Item("CurrencyCode").Value)
            vRec.EnrollDate = moUtil.FetchDate(.Fields.Item("EnrollDate").Value)
            vRec.IsOrg = moUtil.FetchInteger(.Fields.Item("IsOrg").Value)
            vRec.Options = moUtil.FetchString(.Fields.Item("Options").Value)
            vRec.StoreOptions = moUtil.FetchString(.Fields.Item("StoreOptions").Value)
            vRec.GeoCode = moUtil.FetchString(.Fields.Item("GeoCode").Value)
            vRec.RewardAmt = moUtil.FetchCurrency(.Fields.Item("RewardAmt").Value)
            vRec.RewardDesc = moUtil.FetchString(.Fields.Item("RewardDesc").Value)
            vRec.RewardCap = moUtil.FetchCurrency(.Fields.Item("RewardCap").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListMarket = vRecs

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
   ByRef brRec As tMerchantType, _ 
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
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamInput, vbNull, CLng(brRec.MerchantID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@BillingID", adInteger, adParamInput, vbNull, CLng(brRec.BillingID))
      .Parameters.Append .CreateParameter("@PayoutID", adInteger, adParamInput, vbNull, CLng(brRec.PayoutID))
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamInput, vbNull, CLng(brRec.CountryID))
      .Parameters.Append .CreateParameter("@SweepID", adInteger, adParamInput, vbNull, CLng(brRec.SweepID))
      .Parameters.Append .CreateParameter("@MerchantName", adVarWChar, adParamInput, 80, brRec.MerchantName)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamInput, 30, brRec.NameLast)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamInput, 30, brRec.NameFirst)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@Email2", adVarWChar, adParamInput, 80, brRec.Email2)
      .Parameters.Append .CreateParameter("@Email3", adVarWChar, adParamInput, 80, brRec.Email3)
      .Parameters.Append .CreateParameter("@Phone", adVarWChar, adParamInput, 30, brRec.Phone)
      .Parameters.Append .CreateParameter("@Phone2", adVarWChar, adParamInput, 30, brRec.Phone2)
      .Parameters.Append .CreateParameter("@Password", adVarWChar, adParamInput, 20, brRec.Password)
      .Parameters.Append .CreateParameter("@Password2", adVarWChar, adParamInput, 20, brRec.Password2)
      .Parameters.Append .CreateParameter("@Password3", adVarWChar, adParamInput, 20, brRec.Password3)
      .Parameters.Append .CreateParameter("@Password4", adVarWChar, adParamInput, 20, brRec.Password4)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Street1", adVarWChar, adParamInput, 60, brRec.Street1)
      .Parameters.Append .CreateParameter("@Street2", adVarWChar, adParamInput, 60, brRec.Street2)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamInput, 30, brRec.City)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamInput, 30, brRec.State)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamInput, 20, brRec.Zip)
      .Parameters.Append .CreateParameter("@Referrals", adInteger, adParamInput, vbNull, CLng(brRec.Referrals))
      .Parameters.Append .CreateParameter("@Referrals2", adInteger, adParamInput, vbNull, CLng(brRec.Referrals2))
      .Parameters.Append .CreateParameter("@VisitDate", adDate, adParamInput, vbNull, CDate(brRec.VisitDate))
      .Parameters.Append .CreateParameter("@IsOrg", adSmallInt, adParamInput, vbNull, CInt(brRec.IsOrg))
      .Parameters.Append .CreateParameter("@IsAwards", adSmallInt, adParamInput, vbNull, CInt(brRec.IsAwards))
      .Parameters.Append .CreateParameter("@EnrollDate", adDate, adParamInput, vbNull, CDate(brRec.EnrollDate))
      .Parameters.Append .CreateParameter("@BillDate", adDate, adParamInput, vbNull, CDate(brRec.BillDate))
      .Parameters.Append .CreateParameter("@BillDays", adInteger, adParamInput, vbNull, CLng(brRec.BillDays))
      .Parameters.Append .CreateParameter("@Image", adVarWChar, adParamInput, 40, brRec.Image)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 2000, brRec.Description)
      .Parameters.Append .CreateParameter("@Terms", adVarWChar, adParamInput, 100, brRec.Terms)
      .Parameters.Append .CreateParameter("@Options", adVarWChar, adParamInput, 20, brRec.Options)
      .Parameters.Append .CreateParameter("@StoreOptions", adVarWChar, adParamInput, 20, brRec.StoreOptions)
      .Parameters.Append .CreateParameter("@Colors", adVarWChar, adParamInput, 100, brRec.Colors)
      .Parameters.Append .CreateParameter("@Rating", adInteger, adParamInput, vbNull, CLng(brRec.Rating))
      .Parameters.Append .CreateParameter("@CurrencyCode", adVarWChar, adParamInput, 3, brRec.CurrencyCode)
      .Parameters.Append .CreateParameter("@Processor", adInteger, adParamInput, vbNull, CLng(brRec.Processor))
      .Parameters.Append .CreateParameter("@Payment", adVarWChar, adParamInput, 1000, brRec.Payment)
      .Parameters.Append .CreateParameter("@UserKey", adVarWChar, adParamInput, 40, brRec.UserKey)
      .Parameters.Append .CreateParameter("@UserKey3", adVarWChar, adParamInput, 40, brRec.UserKey3)
      .Parameters.Append .CreateParameter("@UserKey4", adVarWChar, adParamInput, 40, brRec.UserKey4)
      .Parameters.Append .CreateParameter("@UserCode", adVarWChar, adParamInput, 10, brRec.UserCode)
      .Parameters.Append .CreateParameter("@Access", adVarWChar, adParamInput, 80, brRec.Access)
      .Parameters.Append .CreateParameter("@PromoLimit", adInteger, adParamInput, vbNull, CLng(brRec.PromoLimit))
      .Parameters.Append .CreateParameter("@SweepRate", adInteger, adParamInput, vbNull, CLng(brRec.SweepRate))
      .Parameters.Append .CreateParameter("@TimeZone", adInteger, adParamInput, vbNull, CLng(brRec.TimeZone))
      .Parameters.Append .CreateParameter("@GeoCode", adVarWChar, adParamInput, 30, brRec.GeoCode)
      .Parameters.Append .CreateParameter("@ReferRate", adInteger, adParamInput, vbNull, CLng(brRec.ReferRate))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Merchant_Update"

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
   ByRef brRec As tMerchantType, _ 
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
         .MerchantID = moUtil.EditLong(.MerchantID, "MerchantID", True, , 1) 
      End If
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", False) 
      .BillingID = moUtil.EditLong(.BillingID, "BillingID", False) 
      .PayoutID = moUtil.EditLong(.PayoutID, "PayoutID", False) 
      .CountryID = moUtil.EditLong(.CountryID, "CountryID", False) 
      .SweepID = moUtil.EditLong(.SweepID, "SweepID", False) 
      .MerchantName = moUtil.EditString(.MerchantName, "MerchantName", True, , 1, 80) 
      .NameLast = moUtil.EditString(.NameLast, "NameLast", True, , 1, 30) 
      .NameFirst = moUtil.EditString(.NameFirst, "NameFirst", True, , 1, 30) 
      .Email = moUtil.EditString(.Email, "Email", True, , 1, 80) 
      .Email2 = moUtil.EditString(.Email2, "Email2", False, , 1, 80) 
      .Email3 = moUtil.EditString(.Email3, "Email3", False, , 1, 80) 
      .Phone = moUtil.EditString(.Phone, "Phone", False, , 1, 30) 
      .Phone2 = moUtil.EditString(.Phone2, "Phone2", False, , 1, 30) 
      .Password = moUtil.EditString(.Password, "Password", True, , 1, 20) 
      .Password2 = moUtil.EditString(.Password2, "Password2", True, , 1, 20) 
      .Password3 = moUtil.EditString(.Password3, "Password3", False, , 1, 20) 
      .Password4 = moUtil.EditString(.Password4, "Password4", False, , 1, 20) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .Street1 = moUtil.EditString(.Street1, "Street1", True, , 1, 60) 
      .Street2 = moUtil.EditString(.Street2, "Street2", False, , 1, 60) 
      .City = moUtil.EditString(.City, "City", True, , 1, 30) 
      .State = moUtil.EditString(.State, "State", True, , 1, 30) 
      .Zip = moUtil.EditString(.Zip, "Zip", True, , 1, 20) 
      .Referrals = moUtil.EditLong(.Referrals, "Referrals", False) 
      .Referrals2 = moUtil.EditLong(.Referrals2, "Referrals2", False) 
      .VisitDate = moUtil.EditDate(.VisitDate, "VisitDate", False) 
      .IsOrg = moUtil.EditInteger(.IsOrg, "IsOrg", False, 0, 0, 1) 
      .IsAwards = moUtil.EditInteger(.IsAwards, "IsAwards", False, 0, 0, 1) 
      .EnrollDate = moUtil.EditDate(.EnrollDate, "EnrollDate", False) 
      .BillDate = moUtil.EditDate(.BillDate, "BillDate", False) 
      .BillDays = moUtil.EditLong(.BillDays, "BillDays", False) 
      .Image = moUtil.EditString(.Image, "Image", False, , 1, 40) 
      .Description = moUtil.EditString(.Description, "Description", False, , 1, 2000) 
      .Terms = moUtil.EditString(.Terms, "Terms", False, , 1, 100) 
      .Options = moUtil.EditString(.Options, "Options", False) 
      .StoreOptions = moUtil.EditString(.StoreOptions, "StoreOptions", False) 
      .Colors = moUtil.EditString(.Colors, "Colors", False) 
      .Rating = moUtil.EditLong(.Rating, "Rating", False) 
      .CurrencyCode = moUtil.EditString(.CurrencyCode, "CurrencyCode", False, , 1, 3) 
      .Processor = moUtil.EditLong(.Processor, "Processor", False) 
      .Payment = moUtil.EditString(.Payment, "Payment", False) 
      .UserKey = moUtil.EditString(.UserKey, "UserKey", False, , 1, 40) 
      .UserKey3 = moUtil.EditString(.UserKey3, "UserKey3", False, , 1, 40) 
      .UserKey4 = moUtil.EditString(.UserKey4, "UserKey4", False, , 1, 40) 
      .UserCode = moUtil.EditString(.UserCode, "UserCode", False, , 1, 10) 
      .Access = moUtil.EditString(.Access, "Access", False, , 1, 80) 
      .PromoLimit = moUtil.EditLong(.PromoLimit, "PromoLimit", False) 
      .SweepRate = moUtil.EditLong(.SweepRate, "SweepRate", False) 
      .TimeZone = moUtil.EditLong(.TimeZone, "TimeZone", False) 
      .GeoCode = moUtil.EditString(.GeoCode, "GeoCode", False, , 1, 30) 
      .ReferRate = moUtil.EditLong(.ReferRate, "ReferRate", False) 
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