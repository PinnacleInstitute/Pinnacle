VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CCoptionB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CCoption"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tCoptionType
   CoptionID As String
   CompanyID As String
   InitPrice As String
   Price As String
   Price2 As String
   Price3 As String
   Discount As String
   Retail As String
   Retail2 As String
   Retail3 As String
   BusPrice As String
   BusRetail As String
   BusAccts As String
   BusAcctPrice As String
   BusAcctRetail As String
   IsCatalog As String
   IsDiscount As String
   Billing As String
   CommRate As String
   PromoCode As String
   AccessLimit As String
   QuizLimit As String
   MemberLimit As String
   TrialDays As String
   IsTrialPayment As String
   IsSignIn As String
   IsJoinNow As String
   IsNewEmail As String
   IsBusAcct As String
   IsFree As String
   RefName As String
   NewMemberOrgs As String
   TBPage As String
   Languages As String
   UploadURL As String
   SetupFee As String
   IsSalesDefault As String
   ProjectsDefault As String
   DocSizeLimit As String
   FreeOptions As String
   EasyOptions As String
   Options As String
   Options2 As String
   Options3 As String
   Options4 As String
   Options5 As String
   Options6 As String
   Options7 As String
   Options8 As String
   FreeName As String
   PaidName As String
   PaidName2 As String
   PaidName3 As String
   Identify As String
   Identification As String
   MerchantCardType As String
   MerchantCheckType As String
   MerchantCardAcct As String
   MerchantCheckAcct As String
   WalletType As String
   WalletAcct As String
   PayoutProcessors As String
   PaymentOptions As String
   MiscPay1 As String
   MiscPay2 As String
   MiscPay3 As String
   IPLimit As String
   InputOptions As String
   GAAcct As String
   Countries As String
   MenuColors As String
   Portal As String
   Shopping As String
End Type

Public Sub Add( _ 
   ByRef brRec As tCoptionType, _ 
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
      .Parameters.Append .CreateParameter("@CoptionID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@InitPrice", adCurrency, adParamInput, vbNull, CCur(brRec.InitPrice))
      .Parameters.Append .CreateParameter("@Price", adCurrency, adParamInput, vbNull, CCur(brRec.Price))
      .Parameters.Append .CreateParameter("@Price2", adCurrency, adParamInput, vbNull, CCur(brRec.Price2))
      .Parameters.Append .CreateParameter("@Price3", adCurrency, adParamInput, vbNull, CCur(brRec.Price3))
      .Parameters.Append .CreateParameter("@Discount", adCurrency, adParamInput, vbNull, CCur(brRec.Discount))
      .Parameters.Append .CreateParameter("@Retail", adCurrency, adParamInput, vbNull, CCur(brRec.Retail))
      .Parameters.Append .CreateParameter("@Retail2", adCurrency, adParamInput, vbNull, CCur(brRec.Retail2))
      .Parameters.Append .CreateParameter("@Retail3", adCurrency, adParamInput, vbNull, CCur(brRec.Retail3))
      .Parameters.Append .CreateParameter("@BusPrice", adCurrency, adParamInput, vbNull, CCur(brRec.BusPrice))
      .Parameters.Append .CreateParameter("@BusRetail", adCurrency, adParamInput, vbNull, CCur(brRec.BusRetail))
      .Parameters.Append .CreateParameter("@BusAccts", adInteger, adParamInput, vbNull, CLng(brRec.BusAccts))
      .Parameters.Append .CreateParameter("@BusAcctPrice", adCurrency, adParamInput, vbNull, CCur(brRec.BusAcctPrice))
      .Parameters.Append .CreateParameter("@BusAcctRetail", adCurrency, adParamInput, vbNull, CCur(brRec.BusAcctRetail))
      .Parameters.Append .CreateParameter("@IsCatalog", adSmallInt, adParamInput, vbNull, CInt(brRec.IsCatalog))
      .Parameters.Append .CreateParameter("@IsDiscount", adSmallInt, adParamInput, vbNull, CInt(brRec.IsDiscount))
      .Parameters.Append .CreateParameter("@Billing", adInteger, adParamInput, vbNull, CLng(brRec.Billing))
      .Parameters.Append .CreateParameter("@CommRate", adCurrency, adParamInput, vbNull, CCur(brRec.CommRate))
      .Parameters.Append .CreateParameter("@PromoCode", adInteger, adParamInput, vbNull, CLng(brRec.PromoCode))
      .Parameters.Append .CreateParameter("@AccessLimit", adVarWChar, adParamInput, 50, brRec.AccessLimit)
      .Parameters.Append .CreateParameter("@QuizLimit", adInteger, adParamInput, vbNull, CLng(brRec.QuizLimit))
      .Parameters.Append .CreateParameter("@MemberLimit", adInteger, adParamInput, vbNull, CLng(brRec.MemberLimit))
      .Parameters.Append .CreateParameter("@TrialDays", adInteger, adParamInput, vbNull, CLng(brRec.TrialDays))
      .Parameters.Append .CreateParameter("@IsTrialPayment", adSmallInt, adParamInput, vbNull, CInt(brRec.IsTrialPayment))
      .Parameters.Append .CreateParameter("@IsSignIn", adSmallInt, adParamInput, vbNull, CInt(brRec.IsSignIn))
      .Parameters.Append .CreateParameter("@IsJoinNow", adSmallInt, adParamInput, vbNull, CInt(brRec.IsJoinNow))
      .Parameters.Append .CreateParameter("@IsNewEmail", adSmallInt, adParamInput, vbNull, CInt(brRec.IsNewEmail))
      .Parameters.Append .CreateParameter("@IsBusAcct", adSmallInt, adParamInput, vbNull, CInt(brRec.IsBusAcct))
      .Parameters.Append .CreateParameter("@IsFree", adSmallInt, adParamInput, vbNull, CInt(brRec.IsFree))
      .Parameters.Append .CreateParameter("@RefName", adVarWChar, adParamInput, 20, brRec.RefName)
      .Parameters.Append .CreateParameter("@NewMemberOrgs", adVarWChar, adParamInput, 20, brRec.NewMemberOrgs)
      .Parameters.Append .CreateParameter("@TBPage", adVarWChar, adParamInput, 20, brRec.TBPage)
      .Parameters.Append .CreateParameter("@Languages", adVarWChar, adParamInput, 200, brRec.Languages)
      .Parameters.Append .CreateParameter("@UploadURL", adVarWChar, adParamInput, 40, brRec.UploadURL)
      .Parameters.Append .CreateParameter("@SetupFee", adCurrency, adParamInput, vbNull, CCur(brRec.SetupFee))
      .Parameters.Append .CreateParameter("@IsSalesDefault", adSmallInt, adParamInput, vbNull, CInt(brRec.IsSalesDefault))
      .Parameters.Append .CreateParameter("@ProjectsDefault", adInteger, adParamInput, vbNull, CLng(brRec.ProjectsDefault))
      .Parameters.Append .CreateParameter("@DocSizeLimit", adInteger, adParamInput, vbNull, CLng(brRec.DocSizeLimit))
      .Parameters.Append .CreateParameter("@FreeOptions", adVarWChar, adParamInput, 40, brRec.FreeOptions)
      .Parameters.Append .CreateParameter("@EasyOptions", adVarWChar, adParamInput, 40, brRec.EasyOptions)
      .Parameters.Append .CreateParameter("@Options", adVarWChar, adParamInput, 50, brRec.Options)
      .Parameters.Append .CreateParameter("@Options2", adVarWChar, adParamInput, 50, brRec.Options2)
      .Parameters.Append .CreateParameter("@Options3", adVarWChar, adParamInput, 50, brRec.Options3)
      .Parameters.Append .CreateParameter("@Options4", adVarWChar, adParamInput, 40, brRec.Options4)
      .Parameters.Append .CreateParameter("@Options5", adVarWChar, adParamInput, 40, brRec.Options5)
      .Parameters.Append .CreateParameter("@Options6", adVarWChar, adParamInput, 40, brRec.Options6)
      .Parameters.Append .CreateParameter("@Options7", adVarWChar, adParamInput, 40, brRec.Options7)
      .Parameters.Append .CreateParameter("@Options8", adVarWChar, adParamInput, 40, brRec.Options8)
      .Parameters.Append .CreateParameter("@FreeName", adVarWChar, adParamInput, 40, brRec.FreeName)
      .Parameters.Append .CreateParameter("@PaidName", adVarWChar, adParamInput, 40, brRec.PaidName)
      .Parameters.Append .CreateParameter("@PaidName2", adVarWChar, adParamInput, 40, brRec.PaidName2)
      .Parameters.Append .CreateParameter("@PaidName3", adVarWChar, adParamInput, 40, brRec.PaidName3)
      .Parameters.Append .CreateParameter("@Identify", adInteger, adParamInput, vbNull, CLng(brRec.Identify))
      .Parameters.Append .CreateParameter("@Identification", adVarWChar, adParamInput, 500, brRec.Identification)
      .Parameters.Append .CreateParameter("@MerchantCardType", adInteger, adParamInput, vbNull, CLng(brRec.MerchantCardType))
      .Parameters.Append .CreateParameter("@MerchantCheckType", adInteger, adParamInput, vbNull, CLng(brRec.MerchantCheckType))
      .Parameters.Append .CreateParameter("@MerchantCardAcct", adVarWChar, adParamInput, 100, brRec.MerchantCardAcct)
      .Parameters.Append .CreateParameter("@MerchantCheckAcct", adVarWChar, adParamInput, 100, brRec.MerchantCheckAcct)
      .Parameters.Append .CreateParameter("@WalletType", adVarWChar, adParamInput, 20, brRec.WalletType)
      .Parameters.Append .CreateParameter("@WalletAcct", adVarWChar, adParamInput, 100, brRec.WalletAcct)
      .Parameters.Append .CreateParameter("@PayoutProcessors", adVarWChar, adParamInput, 20, brRec.PayoutProcessors)
      .Parameters.Append .CreateParameter("@PaymentOptions", adVarWChar, adParamInput, 15, brRec.PaymentOptions)
      .Parameters.Append .CreateParameter("@MiscPay1", adVarWChar, adParamInput, 30, brRec.MiscPay1)
      .Parameters.Append .CreateParameter("@MiscPay2", adVarWChar, adParamInput, 30, brRec.MiscPay2)
      .Parameters.Append .CreateParameter("@MiscPay3", adVarWChar, adParamInput, 30, brRec.MiscPay3)
      .Parameters.Append .CreateParameter("@IPLimit", adInteger, adParamInput, vbNull, CLng(brRec.IPLimit))
      .Parameters.Append .CreateParameter("@InputOptions", adVarWChar, adParamInput, 1000, brRec.InputOptions)
      .Parameters.Append .CreateParameter("@GAAcct", adVarWChar, adParamInput, 50, brRec.GAAcct)
      .Parameters.Append .CreateParameter("@Countries", adVarWChar, adParamInput, 100, brRec.Countries)
      .Parameters.Append .CreateParameter("@MenuColors", adVarWChar, adParamInput, 200, brRec.MenuColors)
      .Parameters.Append .CreateParameter("@Portal", adVarWChar, adParamInput, 20, brRec.Portal)
      .Parameters.Append .CreateParameter("@Shopping", adVarWChar, adParamInput, 20, brRec.Shopping)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Coption_Add"

   '-----get return values
   With brRec
      .CoptionID = moUtil.FetchLong(oCmd.Parameters.Item("@CoptionID").Value)
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
   ByRef brRec As tCoptionType, _ 
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
      .CoptionID = moUtil.EditLong(.CoptionID, "CoptionID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CoptionID", adInteger, adParamInput, vbNull, CLng(brRec.CoptionID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Coption_Delete"

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
   ByRef brRec As tCoptionType, _ 
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
      .CoptionID = moUtil.EditLong(.CoptionID, "CoptionID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CoptionID", adInteger, adParamInput, vbNull, CLng(brRec.CoptionID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@InitPrice", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Price", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Price2", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Price3", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Discount", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Retail", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Retail2", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Retail3", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BusPrice", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BusRetail", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BusAccts", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BusAcctPrice", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BusAcctRetail", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsCatalog", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsDiscount", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Billing", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CommRate", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PromoCode", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AccessLimit", adVarWChar, adParamOutput, 50, vbNull)
      .Parameters.Append .CreateParameter("@QuizLimit", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberLimit", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@TrialDays", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsTrialPayment", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsSignIn", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsJoinNow", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsNewEmail", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsBusAcct", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsFree", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@RefName", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@NewMemberOrgs", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@TBPage", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@Languages", adVarWChar, adParamOutput, 200, vbNull)
      .Parameters.Append .CreateParameter("@UploadURL", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@SetupFee", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsSalesDefault", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ProjectsDefault", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@DocSizeLimit", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@FreeOptions", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@EasyOptions", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@Options", adVarWChar, adParamOutput, 50, vbNull)
      .Parameters.Append .CreateParameter("@Options2", adVarWChar, adParamOutput, 50, vbNull)
      .Parameters.Append .CreateParameter("@Options3", adVarWChar, adParamOutput, 50, vbNull)
      .Parameters.Append .CreateParameter("@Options4", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@Options5", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@Options6", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@Options7", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@Options8", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@FreeName", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@PaidName", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@PaidName2", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@PaidName3", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@Identify", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Identification", adVarWChar, adParamOutput, 500, vbNull)
      .Parameters.Append .CreateParameter("@MerchantCardType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MerchantCheckType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MerchantCardAcct", adVarWChar, adParamOutput, 100, vbNull)
      .Parameters.Append .CreateParameter("@MerchantCheckAcct", adVarWChar, adParamOutput, 100, vbNull)
      .Parameters.Append .CreateParameter("@WalletType", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@WalletAcct", adVarWChar, adParamOutput, 100, vbNull)
      .Parameters.Append .CreateParameter("@PayoutProcessors", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@PaymentOptions", adVarWChar, adParamOutput, 15, vbNull)
      .Parameters.Append .CreateParameter("@MiscPay1", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@MiscPay2", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@MiscPay3", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@IPLimit", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@InputOptions", adVarWChar, adParamOutput, 1000, vbNull)
      .Parameters.Append .CreateParameter("@GAAcct", adVarWChar, adParamOutput, 50, vbNull)
      .Parameters.Append .CreateParameter("@Countries", adVarWChar, adParamOutput, 100, vbNull)
      .Parameters.Append .CreateParameter("@MenuColors", adVarWChar, adParamOutput, 200, vbNull)
      .Parameters.Append .CreateParameter("@Portal", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@Shopping", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Coption_Fetch"

   '-----get return values
   With brRec
      .CompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@CompanyID").Value)
      .InitPrice = moUtil.FetchCurrency(oCmd.Parameters.Item("@InitPrice").Value)
      .Price = moUtil.FetchCurrency(oCmd.Parameters.Item("@Price").Value)
      .Price2 = moUtil.FetchCurrency(oCmd.Parameters.Item("@Price2").Value)
      .Price3 = moUtil.FetchCurrency(oCmd.Parameters.Item("@Price3").Value)
      .Discount = moUtil.FetchCurrency(oCmd.Parameters.Item("@Discount").Value)
      .Retail = moUtil.FetchCurrency(oCmd.Parameters.Item("@Retail").Value)
      .Retail2 = moUtil.FetchCurrency(oCmd.Parameters.Item("@Retail2").Value)
      .Retail3 = moUtil.FetchCurrency(oCmd.Parameters.Item("@Retail3").Value)
      .BusPrice = moUtil.FetchCurrency(oCmd.Parameters.Item("@BusPrice").Value)
      .BusRetail = moUtil.FetchCurrency(oCmd.Parameters.Item("@BusRetail").Value)
      .BusAccts = moUtil.FetchLong(oCmd.Parameters.Item("@BusAccts").Value)
      .BusAcctPrice = moUtil.FetchCurrency(oCmd.Parameters.Item("@BusAcctPrice").Value)
      .BusAcctRetail = moUtil.FetchCurrency(oCmd.Parameters.Item("@BusAcctRetail").Value)
      .IsCatalog = moUtil.FetchInteger(oCmd.Parameters.Item("@IsCatalog").Value)
      .IsDiscount = moUtil.FetchInteger(oCmd.Parameters.Item("@IsDiscount").Value)
      .Billing = moUtil.FetchLong(oCmd.Parameters.Item("@Billing").Value)
      .CommRate = moUtil.FetchCurrency(oCmd.Parameters.Item("@CommRate").Value)
      .PromoCode = moUtil.FetchLong(oCmd.Parameters.Item("@PromoCode").Value)
      .AccessLimit = moUtil.FetchString(oCmd.Parameters.Item("@AccessLimit").Value)
      .QuizLimit = moUtil.FetchLong(oCmd.Parameters.Item("@QuizLimit").Value)
      .MemberLimit = moUtil.FetchLong(oCmd.Parameters.Item("@MemberLimit").Value)
      .TrialDays = moUtil.FetchLong(oCmd.Parameters.Item("@TrialDays").Value)
      .IsTrialPayment = moUtil.FetchInteger(oCmd.Parameters.Item("@IsTrialPayment").Value)
      .IsSignIn = moUtil.FetchInteger(oCmd.Parameters.Item("@IsSignIn").Value)
      .IsJoinNow = moUtil.FetchInteger(oCmd.Parameters.Item("@IsJoinNow").Value)
      .IsNewEmail = moUtil.FetchInteger(oCmd.Parameters.Item("@IsNewEmail").Value)
      .IsBusAcct = moUtil.FetchInteger(oCmd.Parameters.Item("@IsBusAcct").Value)
      .IsFree = moUtil.FetchInteger(oCmd.Parameters.Item("@IsFree").Value)
      .RefName = moUtil.FetchString(oCmd.Parameters.Item("@RefName").Value)
      .NewMemberOrgs = moUtil.FetchString(oCmd.Parameters.Item("@NewMemberOrgs").Value)
      .TBPage = moUtil.FetchString(oCmd.Parameters.Item("@TBPage").Value)
      .Languages = moUtil.FetchString(oCmd.Parameters.Item("@Languages").Value)
      .UploadURL = moUtil.FetchString(oCmd.Parameters.Item("@UploadURL").Value)
      .SetupFee = moUtil.FetchCurrency(oCmd.Parameters.Item("@SetupFee").Value)
      .IsSalesDefault = moUtil.FetchInteger(oCmd.Parameters.Item("@IsSalesDefault").Value)
      .ProjectsDefault = moUtil.FetchLong(oCmd.Parameters.Item("@ProjectsDefault").Value)
      .DocSizeLimit = moUtil.FetchLong(oCmd.Parameters.Item("@DocSizeLimit").Value)
      .FreeOptions = moUtil.FetchString(oCmd.Parameters.Item("@FreeOptions").Value)
      .EasyOptions = moUtil.FetchString(oCmd.Parameters.Item("@EasyOptions").Value)
      .Options = moUtil.FetchString(oCmd.Parameters.Item("@Options").Value)
      .Options2 = moUtil.FetchString(oCmd.Parameters.Item("@Options2").Value)
      .Options3 = moUtil.FetchString(oCmd.Parameters.Item("@Options3").Value)
      .Options4 = moUtil.FetchString(oCmd.Parameters.Item("@Options4").Value)
      .Options5 = moUtil.FetchString(oCmd.Parameters.Item("@Options5").Value)
      .Options6 = moUtil.FetchString(oCmd.Parameters.Item("@Options6").Value)
      .Options7 = moUtil.FetchString(oCmd.Parameters.Item("@Options7").Value)
      .Options8 = moUtil.FetchString(oCmd.Parameters.Item("@Options8").Value)
      .FreeName = moUtil.FetchString(oCmd.Parameters.Item("@FreeName").Value)
      .PaidName = moUtil.FetchString(oCmd.Parameters.Item("@PaidName").Value)
      .PaidName2 = moUtil.FetchString(oCmd.Parameters.Item("@PaidName2").Value)
      .PaidName3 = moUtil.FetchString(oCmd.Parameters.Item("@PaidName3").Value)
      .Identify = moUtil.FetchLong(oCmd.Parameters.Item("@Identify").Value)
      .Identification = moUtil.FetchString(oCmd.Parameters.Item("@Identification").Value)
      .MerchantCardType = moUtil.FetchLong(oCmd.Parameters.Item("@MerchantCardType").Value)
      .MerchantCheckType = moUtil.FetchLong(oCmd.Parameters.Item("@MerchantCheckType").Value)
      .MerchantCardAcct = moUtil.FetchString(oCmd.Parameters.Item("@MerchantCardAcct").Value)
      .MerchantCheckAcct = moUtil.FetchString(oCmd.Parameters.Item("@MerchantCheckAcct").Value)
      .WalletType = moUtil.FetchString(oCmd.Parameters.Item("@WalletType").Value)
      .WalletAcct = moUtil.FetchString(oCmd.Parameters.Item("@WalletAcct").Value)
      .PayoutProcessors = moUtil.FetchString(oCmd.Parameters.Item("@PayoutProcessors").Value)
      .PaymentOptions = moUtil.FetchString(oCmd.Parameters.Item("@PaymentOptions").Value)
      .MiscPay1 = moUtil.FetchString(oCmd.Parameters.Item("@MiscPay1").Value)
      .MiscPay2 = moUtil.FetchString(oCmd.Parameters.Item("@MiscPay2").Value)
      .MiscPay3 = moUtil.FetchString(oCmd.Parameters.Item("@MiscPay3").Value)
      .IPLimit = moUtil.FetchLong(oCmd.Parameters.Item("@IPLimit").Value)
      .InputOptions = moUtil.FetchString(oCmd.Parameters.Item("@InputOptions").Value)
      .GAAcct = moUtil.FetchString(oCmd.Parameters.Item("@GAAcct").Value)
      .Countries = moUtil.FetchString(oCmd.Parameters.Item("@Countries").Value)
      .MenuColors = moUtil.FetchString(oCmd.Parameters.Item("@MenuColors").Value)
      .Portal = moUtil.FetchString(oCmd.Parameters.Item("@Portal").Value)
      .Shopping = moUtil.FetchString(oCmd.Parameters.Item("@Shopping").Value)
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

Public Sub FetchCompany( _ 
   ByRef brRec As tCoptionType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FetchCompany"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .CompanyID = moUtil.EditLong(.CompanyID, "CompanyID", True, 0) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@CoptionID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Coption_FetchCompany"

   '-----get return values
   With brRec
      .CoptionID = moUtil.FetchLong(oCmd.Parameters.Item("@CoptionID").Value)
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

Public Sub Update( _ 
   ByRef brRec As tCoptionType, _ 
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
      .Parameters.Append .CreateParameter("@CoptionID", adInteger, adParamInput, vbNull, CLng(brRec.CoptionID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@InitPrice", adCurrency, adParamInput, vbNull, CCur(brRec.InitPrice))
      .Parameters.Append .CreateParameter("@Price", adCurrency, adParamInput, vbNull, CCur(brRec.Price))
      .Parameters.Append .CreateParameter("@Price2", adCurrency, adParamInput, vbNull, CCur(brRec.Price2))
      .Parameters.Append .CreateParameter("@Price3", adCurrency, adParamInput, vbNull, CCur(brRec.Price3))
      .Parameters.Append .CreateParameter("@Discount", adCurrency, adParamInput, vbNull, CCur(brRec.Discount))
      .Parameters.Append .CreateParameter("@Retail", adCurrency, adParamInput, vbNull, CCur(brRec.Retail))
      .Parameters.Append .CreateParameter("@Retail2", adCurrency, adParamInput, vbNull, CCur(brRec.Retail2))
      .Parameters.Append .CreateParameter("@Retail3", adCurrency, adParamInput, vbNull, CCur(brRec.Retail3))
      .Parameters.Append .CreateParameter("@BusPrice", adCurrency, adParamInput, vbNull, CCur(brRec.BusPrice))
      .Parameters.Append .CreateParameter("@BusRetail", adCurrency, adParamInput, vbNull, CCur(brRec.BusRetail))
      .Parameters.Append .CreateParameter("@BusAccts", adInteger, adParamInput, vbNull, CLng(brRec.BusAccts))
      .Parameters.Append .CreateParameter("@BusAcctPrice", adCurrency, adParamInput, vbNull, CCur(brRec.BusAcctPrice))
      .Parameters.Append .CreateParameter("@BusAcctRetail", adCurrency, adParamInput, vbNull, CCur(brRec.BusAcctRetail))
      .Parameters.Append .CreateParameter("@IsCatalog", adSmallInt, adParamInput, vbNull, CInt(brRec.IsCatalog))
      .Parameters.Append .CreateParameter("@IsDiscount", adSmallInt, adParamInput, vbNull, CInt(brRec.IsDiscount))
      .Parameters.Append .CreateParameter("@Billing", adInteger, adParamInput, vbNull, CLng(brRec.Billing))
      .Parameters.Append .CreateParameter("@CommRate", adCurrency, adParamInput, vbNull, CCur(brRec.CommRate))
      .Parameters.Append .CreateParameter("@PromoCode", adInteger, adParamInput, vbNull, CLng(brRec.PromoCode))
      .Parameters.Append .CreateParameter("@AccessLimit", adVarWChar, adParamInput, 50, brRec.AccessLimit)
      .Parameters.Append .CreateParameter("@QuizLimit", adInteger, adParamInput, vbNull, CLng(brRec.QuizLimit))
      .Parameters.Append .CreateParameter("@MemberLimit", adInteger, adParamInput, vbNull, CLng(brRec.MemberLimit))
      .Parameters.Append .CreateParameter("@TrialDays", adInteger, adParamInput, vbNull, CLng(brRec.TrialDays))
      .Parameters.Append .CreateParameter("@IsTrialPayment", adSmallInt, adParamInput, vbNull, CInt(brRec.IsTrialPayment))
      .Parameters.Append .CreateParameter("@IsSignIn", adSmallInt, adParamInput, vbNull, CInt(brRec.IsSignIn))
      .Parameters.Append .CreateParameter("@IsJoinNow", adSmallInt, adParamInput, vbNull, CInt(brRec.IsJoinNow))
      .Parameters.Append .CreateParameter("@IsNewEmail", adSmallInt, adParamInput, vbNull, CInt(brRec.IsNewEmail))
      .Parameters.Append .CreateParameter("@IsBusAcct", adSmallInt, adParamInput, vbNull, CInt(brRec.IsBusAcct))
      .Parameters.Append .CreateParameter("@IsFree", adSmallInt, adParamInput, vbNull, CInt(brRec.IsFree))
      .Parameters.Append .CreateParameter("@RefName", adVarWChar, adParamInput, 20, brRec.RefName)
      .Parameters.Append .CreateParameter("@NewMemberOrgs", adVarWChar, adParamInput, 20, brRec.NewMemberOrgs)
      .Parameters.Append .CreateParameter("@TBPage", adVarWChar, adParamInput, 20, brRec.TBPage)
      .Parameters.Append .CreateParameter("@Languages", adVarWChar, adParamInput, 200, brRec.Languages)
      .Parameters.Append .CreateParameter("@UploadURL", adVarWChar, adParamInput, 40, brRec.UploadURL)
      .Parameters.Append .CreateParameter("@SetupFee", adCurrency, adParamInput, vbNull, CCur(brRec.SetupFee))
      .Parameters.Append .CreateParameter("@IsSalesDefault", adSmallInt, adParamInput, vbNull, CInt(brRec.IsSalesDefault))
      .Parameters.Append .CreateParameter("@ProjectsDefault", adInteger, adParamInput, vbNull, CLng(brRec.ProjectsDefault))
      .Parameters.Append .CreateParameter("@DocSizeLimit", adInteger, adParamInput, vbNull, CLng(brRec.DocSizeLimit))
      .Parameters.Append .CreateParameter("@FreeOptions", adVarWChar, adParamInput, 40, brRec.FreeOptions)
      .Parameters.Append .CreateParameter("@EasyOptions", adVarWChar, adParamInput, 40, brRec.EasyOptions)
      .Parameters.Append .CreateParameter("@Options", adVarWChar, adParamInput, 50, brRec.Options)
      .Parameters.Append .CreateParameter("@Options2", adVarWChar, adParamInput, 50, brRec.Options2)
      .Parameters.Append .CreateParameter("@Options3", adVarWChar, adParamInput, 50, brRec.Options3)
      .Parameters.Append .CreateParameter("@Options4", adVarWChar, adParamInput, 40, brRec.Options4)
      .Parameters.Append .CreateParameter("@Options5", adVarWChar, adParamInput, 40, brRec.Options5)
      .Parameters.Append .CreateParameter("@Options6", adVarWChar, adParamInput, 40, brRec.Options6)
      .Parameters.Append .CreateParameter("@Options7", adVarWChar, adParamInput, 40, brRec.Options7)
      .Parameters.Append .CreateParameter("@Options8", adVarWChar, adParamInput, 40, brRec.Options8)
      .Parameters.Append .CreateParameter("@FreeName", adVarWChar, adParamInput, 40, brRec.FreeName)
      .Parameters.Append .CreateParameter("@PaidName", adVarWChar, adParamInput, 40, brRec.PaidName)
      .Parameters.Append .CreateParameter("@PaidName2", adVarWChar, adParamInput, 40, brRec.PaidName2)
      .Parameters.Append .CreateParameter("@PaidName3", adVarWChar, adParamInput, 40, brRec.PaidName3)
      .Parameters.Append .CreateParameter("@Identify", adInteger, adParamInput, vbNull, CLng(brRec.Identify))
      .Parameters.Append .CreateParameter("@Identification", adVarWChar, adParamInput, 500, brRec.Identification)
      .Parameters.Append .CreateParameter("@MerchantCardType", adInteger, adParamInput, vbNull, CLng(brRec.MerchantCardType))
      .Parameters.Append .CreateParameter("@MerchantCheckType", adInteger, adParamInput, vbNull, CLng(brRec.MerchantCheckType))
      .Parameters.Append .CreateParameter("@MerchantCardAcct", adVarWChar, adParamInput, 100, brRec.MerchantCardAcct)
      .Parameters.Append .CreateParameter("@MerchantCheckAcct", adVarWChar, adParamInput, 100, brRec.MerchantCheckAcct)
      .Parameters.Append .CreateParameter("@WalletType", adVarWChar, adParamInput, 20, brRec.WalletType)
      .Parameters.Append .CreateParameter("@WalletAcct", adVarWChar, adParamInput, 100, brRec.WalletAcct)
      .Parameters.Append .CreateParameter("@PayoutProcessors", adVarWChar, adParamInput, 20, brRec.PayoutProcessors)
      .Parameters.Append .CreateParameter("@PaymentOptions", adVarWChar, adParamInput, 15, brRec.PaymentOptions)
      .Parameters.Append .CreateParameter("@MiscPay1", adVarWChar, adParamInput, 30, brRec.MiscPay1)
      .Parameters.Append .CreateParameter("@MiscPay2", adVarWChar, adParamInput, 30, brRec.MiscPay2)
      .Parameters.Append .CreateParameter("@MiscPay3", adVarWChar, adParamInput, 30, brRec.MiscPay3)
      .Parameters.Append .CreateParameter("@IPLimit", adInteger, adParamInput, vbNull, CLng(brRec.IPLimit))
      .Parameters.Append .CreateParameter("@InputOptions", adVarWChar, adParamInput, 1000, brRec.InputOptions)
      .Parameters.Append .CreateParameter("@GAAcct", adVarWChar, adParamInput, 50, brRec.GAAcct)
      .Parameters.Append .CreateParameter("@Countries", adVarWChar, adParamInput, 100, brRec.Countries)
      .Parameters.Append .CreateParameter("@MenuColors", adVarWChar, adParamInput, 200, brRec.MenuColors)
      .Parameters.Append .CreateParameter("@Portal", adVarWChar, adParamInput, 20, brRec.Portal)
      .Parameters.Append .CreateParameter("@Shopping", adVarWChar, adParamInput, 20, brRec.Shopping)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Coption_Update"

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
   ByRef brRec As tCoptionType, _ 
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
         .CoptionID = moUtil.EditLong(.CoptionID, "CoptionID", True, , 1) 
      End If
      .CompanyID = moUtil.EditLong(.CompanyID, "CompanyID", False) 
      .InitPrice = moUtil.EditCurrency(.InitPrice, "InitPrice", False) 
      .Price = moUtil.EditCurrency(.Price, "Price", False) 
      .Price2 = moUtil.EditCurrency(.Price2, "Price2", False) 
      .Price3 = moUtil.EditCurrency(.Price3, "Price3", False) 
      .Discount = moUtil.EditCurrency(.Discount, "Discount", False) 
      .Retail = moUtil.EditCurrency(.Retail, "Retail", False) 
      .Retail2 = moUtil.EditCurrency(.Retail2, "Retail2", False) 
      .Retail3 = moUtil.EditCurrency(.Retail3, "Retail3", False) 
      .BusPrice = moUtil.EditCurrency(.BusPrice, "BusPrice", False) 
      .BusRetail = moUtil.EditCurrency(.BusRetail, "BusRetail", False) 
      .BusAccts = moUtil.EditLong(.BusAccts, "BusAccts", False) 
      .BusAcctPrice = moUtil.EditCurrency(.BusAcctPrice, "BusAcctPrice", False) 
      .BusAcctRetail = moUtil.EditCurrency(.BusAcctRetail, "BusAcctRetail", False) 
      .IsCatalog = moUtil.EditInteger(.IsCatalog, "IsCatalog", False, 0, 0, 1) 
      .IsDiscount = moUtil.EditInteger(.IsDiscount, "IsDiscount", False, 0, 0, 1) 
      .Billing = moUtil.EditLong(.Billing, "Billing", False) 
      .CommRate = moUtil.EditCurrency(.CommRate, "CommRate", False, , -999999.9999, 999999.9999) 
      .PromoCode = moUtil.EditLong(.PromoCode, "PromoCode", False) 
      .AccessLimit = moUtil.EditString(.AccessLimit, "AccessLimit", False, , 1, 50) 
      .QuizLimit = moUtil.EditLong(.QuizLimit, "QuizLimit", False) 
      .MemberLimit = moUtil.EditLong(.MemberLimit, "MemberLimit", False) 
      .TrialDays = moUtil.EditLong(.TrialDays, "TrialDays", False) 
      .IsTrialPayment = moUtil.EditInteger(.IsTrialPayment, "IsTrialPayment", False, 0, 0, 1) 
      .IsSignIn = moUtil.EditInteger(.IsSignIn, "IsSignIn", False, 0, 0, 1) 
      .IsJoinNow = moUtil.EditInteger(.IsJoinNow, "IsJoinNow", False, 0, 0, 1) 
      .IsNewEmail = moUtil.EditInteger(.IsNewEmail, "IsNewEmail", False, 0, 0, 1) 
      .IsBusAcct = moUtil.EditInteger(.IsBusAcct, "IsBusAcct", False, 0, 0, 1) 
      .IsFree = moUtil.EditInteger(.IsFree, "IsFree", False, 0, 0, 1) 
      .RefName = moUtil.EditString(.RefName, "RefName", False) 
      .NewMemberOrgs = moUtil.EditString(.NewMemberOrgs, "NewMemberOrgs", False) 
      .TBPage = moUtil.EditString(.TBPage, "TBPage", False) 
      .Languages = moUtil.EditString(.Languages, "Languages", False) 
      .UploadURL = moUtil.EditString(.UploadURL, "UploadURL", False) 
      .SetupFee = moUtil.EditCurrency(.SetupFee, "SetupFee", False) 
      .IsSalesDefault = moUtil.EditInteger(.IsSalesDefault, "IsSalesDefault", False, 0, 0, 1) 
      .ProjectsDefault = moUtil.EditLong(.ProjectsDefault, "ProjectsDefault", False) 
      .DocSizeLimit = moUtil.EditLong(.DocSizeLimit, "DocSizeLimit", False) 
      .FreeOptions = moUtil.EditString(.FreeOptions, "FreeOptions", False) 
      .EasyOptions = moUtil.EditString(.EasyOptions, "EasyOptions", False) 
      .Options = moUtil.EditString(.Options, "Options", False) 
      .Options2 = moUtil.EditString(.Options2, "Options2", False) 
      .Options3 = moUtil.EditString(.Options3, "Options3", False) 
      .Options4 = moUtil.EditString(.Options4, "Options4", False) 
      .Options5 = moUtil.EditString(.Options5, "Options5", False) 
      .Options6 = moUtil.EditString(.Options6, "Options6", False) 
      .Options7 = moUtil.EditString(.Options7, "Options7", False) 
      .Options8 = moUtil.EditString(.Options8, "Options8", False) 
      .FreeName = moUtil.EditString(.FreeName, "FreeName", False) 
      .PaidName = moUtil.EditString(.PaidName, "PaidName", False) 
      .PaidName2 = moUtil.EditString(.PaidName2, "PaidName2", False) 
      .PaidName3 = moUtil.EditString(.PaidName3, "PaidName3", False) 
      .Identify = moUtil.EditLong(.Identify, "Identify", False) 
      .Identification = moUtil.EditString(.Identification, "Identification", False) 
      .MerchantCardType = moUtil.EditLong(.MerchantCardType, "MerchantCardType", False) 
      .MerchantCheckType = moUtil.EditLong(.MerchantCheckType, "MerchantCheckType", False) 
      .MerchantCardAcct = moUtil.EditString(.MerchantCardAcct, "MerchantCardAcct", False) 
      .MerchantCheckAcct = moUtil.EditString(.MerchantCheckAcct, "MerchantCheckAcct", False) 
      .WalletType = moUtil.EditString(.WalletType, "WalletType", False) 
      .WalletAcct = moUtil.EditString(.WalletAcct, "WalletAcct", False) 
      .PayoutProcessors = moUtil.EditString(.PayoutProcessors, "PayoutProcessors", False) 
      .PaymentOptions = moUtil.EditString(.PaymentOptions, "PaymentOptions", False) 
      .MiscPay1 = moUtil.EditString(.MiscPay1, "MiscPay1", False, , 1, 30) 
      .MiscPay2 = moUtil.EditString(.MiscPay2, "MiscPay2", False, , 1, 30) 
      .MiscPay3 = moUtil.EditString(.MiscPay3, "MiscPay3", False, , 1, 30) 
      .IPLimit = moUtil.EditLong(.IPLimit, "IPLimit", False) 
      .InputOptions = moUtil.EditString(.InputOptions, "InputOptions", False, , 1, 1000) 
      .GAAcct = moUtil.EditString(.GAAcct, "GAAcct", False) 
      .Countries = moUtil.EditString(.Countries, "Countries", False) 
      .MenuColors = moUtil.EditString(.MenuColors, "MenuColors", False) 
      .Portal = moUtil.EditString(.Portal, "Portal", False) 
      .Shopping = moUtil.EditString(.Shopping, "Shopping", False) 
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