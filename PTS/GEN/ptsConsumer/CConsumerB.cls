VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CConsumerB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CConsumer"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tConsumerType
   ConsumerID As String
   MemberID As String
   MerchantID As String
   ReferID As String
   CountryID As String
   CountryID2 As String
   AffiliateID As String
   CountryName As String
   NameLast As String
   NameFirst As String
   ConsumerName As String
   Email As String
   Email2 As String
   Phone As String
   Provider As String
   Password As String
   Status As String
   Messages As String
   Street1 As String
   Street2 As String
   City As String
   State As String
   Zip As String
   City2 As String
   State2 As String
   Zip2 As String
   Referrals As String
   Cash As String
   Points As String
   VisitDate As String
   EnrollDate As String
   UserKey As String
   Barter As String
   CompanyID As String
   TargetArea As String
   TargetType As String
   TargetDays As String
   Target As String
End Type

Public Sub Add( _ 
   ByRef brRec As tConsumerType, _ 
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
      .Parameters.Append .CreateParameter("@ConsumerID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamInput, vbNull, CLng(brRec.MerchantID))
      .Parameters.Append .CreateParameter("@ReferID", adInteger, adParamInput, vbNull, CLng(brRec.ReferID))
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamInput, vbNull, CLng(brRec.CountryID))
      .Parameters.Append .CreateParameter("@CountryID2", adInteger, adParamInput, vbNull, CLng(brRec.CountryID2))
      .Parameters.Append .CreateParameter("@AffiliateID", adInteger, adParamInput, vbNull, CLng(brRec.AffiliateID))
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamInput, 30, brRec.NameLast)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamInput, 30, brRec.NameFirst)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@Email2", adVarWChar, adParamInput, 80, brRec.Email2)
      .Parameters.Append .CreateParameter("@Phone", adVarWChar, adParamInput, 20, brRec.Phone)
      .Parameters.Append .CreateParameter("@Provider", adInteger, adParamInput, vbNull, CLng(brRec.Provider))
      .Parameters.Append .CreateParameter("@Password", adVarWChar, adParamInput, 20, brRec.Password)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Messages", adInteger, adParamInput, vbNull, CLng(brRec.Messages))
      .Parameters.Append .CreateParameter("@Street1", adVarWChar, adParamInput, 60, brRec.Street1)
      .Parameters.Append .CreateParameter("@Street2", adVarWChar, adParamInput, 60, brRec.Street2)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamInput, 30, brRec.City)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamInput, 30, brRec.State)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamInput, 20, brRec.Zip)
      .Parameters.Append .CreateParameter("@City2", adVarWChar, adParamInput, 30, brRec.City2)
      .Parameters.Append .CreateParameter("@State2", adVarWChar, adParamInput, 30, brRec.State2)
      .Parameters.Append .CreateParameter("@Zip2", adVarWChar, adParamInput, 20, brRec.Zip2)
      .Parameters.Append .CreateParameter("@Referrals", adInteger, adParamInput, vbNull, CLng(brRec.Referrals))
      .Parameters.Append .CreateParameter("@Cash", adCurrency, adParamInput, vbNull, CCur(brRec.Cash))
      .Parameters.Append .CreateParameter("@Points", adCurrency, adParamInput, vbNull, CCur(brRec.Points))
      .Parameters.Append .CreateParameter("@VisitDate", adDate, adParamInput, vbNull, CDate(brRec.VisitDate))
      .Parameters.Append .CreateParameter("@EnrollDate", adDate, adParamInput, vbNull, CDate(brRec.EnrollDate))
      .Parameters.Append .CreateParameter("@UserKey", adVarWChar, adParamInput, 40, brRec.UserKey)
      .Parameters.Append .CreateParameter("@Barter", adVarWChar, adParamInput, 100, brRec.Barter)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Consumer_Add"

   '-----get return values
   With brRec
      .ConsumerID = moUtil.FetchLong(oCmd.Parameters.Item("@ConsumerID").Value)
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
   ByRef brRec As tConsumerType, _ 
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
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Consumer_Logon"

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
   ByRef brRec As tConsumerType, _ 
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
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Consumer_Logon2"

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

Public Function CountEmail( _ 
   ByRef brRec As tConsumerType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CountEmail"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .MerchantID = moUtil.EditLong(.MerchantID, "MerchantID", True, 0) 
      .TargetArea = moUtil.EditLong(.TargetArea, "TargetArea", True, 0) 
      .TargetType = moUtil.EditLong(.TargetType, "TargetType", True, 0) 
      .TargetDays = moUtil.EditLong(.TargetDays, "TargetDays", True, 0) 
      .Target = moUtil.EditString(.Target, "Target", True, "", 1, 200) 
      .CountryID = moUtil.EditLong(.CountryID, "CountryID", True, 0) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamInput, vbNull, CLng(brRec.MerchantID))
      .Parameters.Append .CreateParameter("@TargetArea", adInteger, adParamInput, vbNull, CLng(brRec.TargetArea))
      .Parameters.Append .CreateParameter("@TargetType", adInteger, adParamInput, vbNull, CLng(brRec.TargetType))
      .Parameters.Append .CreateParameter("@TargetDays", adInteger, adParamInput, vbNull, CLng(brRec.TargetDays))
      .Parameters.Append .CreateParameter("@Target", adVarWChar, adParamInput, 200, brRec.Target)
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamInput, vbNull, CLng(brRec.CountryID))
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Consumer_CountEmail"

   '-----get return values
   CountEmail = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function CountMarketEmail( _ 
   ByRef brRec As tConsumerType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CountMarketEmail"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .CompanyID = moUtil.EditLong(.CompanyID, "CompanyID", True, 0) 
      .Target = moUtil.EditString(.Target, "Target", True, "", 1, 200) 
      .CountryID = moUtil.EditLong(.CountryID, "CountryID", True, 0) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@Target", adVarWChar, adParamInput, 200, brRec.Target)
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamInput, vbNull, CLng(brRec.CountryID))
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Consumer_CountMarketEmail"

   '-----get return values
   CountMarketEmail = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

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
   ByRef brRec As tConsumerType, _ 
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
      .Parameters.Append .CreateParameter("@ConsumerID", adInteger, adParamInput, vbNull, CLng(brRec.ConsumerID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@EnrollDate", adDate, adParamInput, vbNull, CDate(brRec.EnrollDate))
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@Result", adVarWChar, adParamOutput, 1000, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Consumer_Custom"

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

Public Sub SetReferral( _ 
   ByRef brRec As tConsumerType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Execute a Command
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "SetReferral"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .ConsumerID = moUtil.EditLong(.ConsumerID, "ConsumerID", True, 0, 1) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ConsumerID", adInteger, adParamInput, vbNull, CLng(brRec.ConsumerID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Consumer_SetReferral"

   '-----clean up
   Set oCmd = Nothing

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub SetReferrals( _ 
   ByRef brRec As tConsumerType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Execute a Command
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "SetReferrals"
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
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Consumer_SetReferrals"

   '-----clean up
   Set oCmd = Nothing

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub Delete( _ 
   ByRef brRec As tConsumerType, _ 
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
      .ConsumerID = moUtil.EditLong(.ConsumerID, "ConsumerID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ConsumerID", adInteger, adParamInput, vbNull, CLng(brRec.ConsumerID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Consumer_Delete"

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
   ByRef brRec As tConsumerType, _ 
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
      .ConsumerID = moUtil.EditLong(.ConsumerID, "ConsumerID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ConsumerID", adInteger, adParamInput, vbNull, CLng(brRec.ConsumerID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ReferID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CountryID2", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AffiliateID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CountryName", adVarWChar, adParamOutput, 50, vbNull)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@ConsumerName", adVarWChar, adParamOutput, 62, vbNull)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@Email2", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@Phone", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@Provider", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Password", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Messages", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Street1", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Street2", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@City2", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@State2", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Zip2", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@Referrals", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Cash", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Points", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@VisitDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@EnrollDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserKey", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@Barter", adVarWChar, adParamOutput, 100, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Consumer_Fetch"

   '-----get return values
   With brRec
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .MerchantID = moUtil.FetchLong(oCmd.Parameters.Item("@MerchantID").Value)
      .ReferID = moUtil.FetchLong(oCmd.Parameters.Item("@ReferID").Value)
      .CountryID = moUtil.FetchLong(oCmd.Parameters.Item("@CountryID").Value)
      .CountryID2 = moUtil.FetchLong(oCmd.Parameters.Item("@CountryID2").Value)
      .AffiliateID = moUtil.FetchLong(oCmd.Parameters.Item("@AffiliateID").Value)
      .CountryName = moUtil.FetchString(oCmd.Parameters.Item("@CountryName").Value)
      .NameLast = moUtil.FetchString(oCmd.Parameters.Item("@NameLast").Value)
      .NameFirst = moUtil.FetchString(oCmd.Parameters.Item("@NameFirst").Value)
      .ConsumerName = moUtil.FetchString(oCmd.Parameters.Item("@ConsumerName").Value)
      .Email = moUtil.FetchString(oCmd.Parameters.Item("@Email").Value)
      .Email2 = moUtil.FetchString(oCmd.Parameters.Item("@Email2").Value)
      .Phone = moUtil.FetchString(oCmd.Parameters.Item("@Phone").Value)
      .Provider = moUtil.FetchLong(oCmd.Parameters.Item("@Provider").Value)
      .Password = moUtil.FetchString(oCmd.Parameters.Item("@Password").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .Messages = moUtil.FetchLong(oCmd.Parameters.Item("@Messages").Value)
      .Street1 = moUtil.FetchString(oCmd.Parameters.Item("@Street1").Value)
      .Street2 = moUtil.FetchString(oCmd.Parameters.Item("@Street2").Value)
      .City = moUtil.FetchString(oCmd.Parameters.Item("@City").Value)
      .State = moUtil.FetchString(oCmd.Parameters.Item("@State").Value)
      .Zip = moUtil.FetchString(oCmd.Parameters.Item("@Zip").Value)
      .City2 = moUtil.FetchString(oCmd.Parameters.Item("@City2").Value)
      .State2 = moUtil.FetchString(oCmd.Parameters.Item("@State2").Value)
      .Zip2 = moUtil.FetchString(oCmd.Parameters.Item("@Zip2").Value)
      .Referrals = moUtil.FetchLong(oCmd.Parameters.Item("@Referrals").Value)
      .Cash = moUtil.FetchCurrency(oCmd.Parameters.Item("@Cash").Value)
      .Points = moUtil.FetchCurrency(oCmd.Parameters.Item("@Points").Value)
      .VisitDate = moUtil.FetchDate(oCmd.Parameters.Item("@VisitDate").Value)
      .EnrollDate = moUtil.FetchDate(oCmd.Parameters.Item("@EnrollDate").Value)
      .UserKey = moUtil.FetchString(oCmd.Parameters.Item("@UserKey").Value)
      .Barter = moUtil.FetchString(oCmd.Parameters.Item("@Barter").Value)
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
   ByRef brRec As tConsumerType, _ 
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
      .Parameters.Append .CreateParameter("@ConsumerID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Consumer_FetchEmail"

   '-----get return values
   With brRec
      .ConsumerID = moUtil.FetchLong(oCmd.Parameters.Item("@ConsumerID").Value)
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

Public Sub FetchPhone( _ 
   ByRef brRec As tConsumerType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FetchPhone"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .Phone = moUtil.EditString(.Phone, "Phone", True, "", 1, 20) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Phone", adVarWChar, adParamInput, 20, brRec.Phone)
      .Parameters.Append .CreateParameter("@ConsumerID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Consumer_FetchPhone"

   '-----get return values
   With brRec
      .ConsumerID = moUtil.FetchLong(oCmd.Parameters.Item("@ConsumerID").Value)
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
   Optional ByVal bvSecurityToken As Long = 0) As tConsumerType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tConsumerType
   Dim vRec As tConsumerType
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
      Case cptsConsumerFindConsumerName
         sProc = "pts_Consumer_FindConsumerName"
         MaxBookMark = 72
      Case cptsConsumerFindNameFirst
         sProc = "pts_Consumer_FindNameFirst"
         MaxBookMark = 40
      Case cptsConsumerFindEmail
         sProc = "pts_Consumer_FindEmail"
         MaxBookMark = 90
      Case cptsConsumerFindPhone
         sProc = "pts_Consumer_FindPhone"
         MaxBookMark = 30
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
               vRec.ConsumerID = moUtil.FetchLong(.Fields.Item("ConsumerID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.MerchantID = moUtil.FetchLong(.Fields.Item("MerchantID").Value)
               vRec.ReferID = moUtil.FetchLong(.Fields.Item("ReferID").Value)
               vRec.CountryID = moUtil.FetchLong(.Fields.Item("CountryID").Value)
               vRec.CountryID2 = moUtil.FetchLong(.Fields.Item("CountryID2").Value)
               vRec.AffiliateID = moUtil.FetchLong(.Fields.Item("AffiliateID").Value)
               vRec.CountryName = moUtil.FetchString(.Fields.Item("CountryName").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.ConsumerName = moUtil.FetchString(.Fields.Item("ConsumerName").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Email2 = moUtil.FetchString(.Fields.Item("Email2").Value)
               vRec.Phone = moUtil.FetchString(.Fields.Item("Phone").Value)
               vRec.Provider = moUtil.FetchLong(.Fields.Item("Provider").Value)
               vRec.Password = moUtil.FetchString(.Fields.Item("Password").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Messages = moUtil.FetchLong(.Fields.Item("Messages").Value)
               vRec.Street1 = moUtil.FetchString(.Fields.Item("Street1").Value)
               vRec.Street2 = moUtil.FetchString(.Fields.Item("Street2").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.City2 = moUtil.FetchString(.Fields.Item("City2").Value)
               vRec.State2 = moUtil.FetchString(.Fields.Item("State2").Value)
               vRec.Zip2 = moUtil.FetchString(.Fields.Item("Zip2").Value)
               vRec.Referrals = moUtil.FetchLong(.Fields.Item("Referrals").Value)
               vRec.Cash = moUtil.FetchCurrency(.Fields.Item("Cash").Value)
               vRec.Points = moUtil.FetchCurrency(.Fields.Item("Points").Value)
               vRec.VisitDate = moUtil.FetchDate(.Fields.Item("VisitDate").Value)
               vRec.EnrollDate = moUtil.FetchDate(.Fields.Item("EnrollDate").Value)
               vRec.UserKey = moUtil.FetchString(.Fields.Item("UserKey").Value)
               vRec.Barter = moUtil.FetchString(.Fields.Item("Barter").Value)
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

Public Function FindMerchant( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvMerchantID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tConsumerType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindMerchant"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tConsumerType
   Dim vRec As tConsumerType
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
   bvMerchantID = moUtil.EditLong(bvMerchantID, "MerchantID", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsConsumerFindConsumerName
         sProc = "pts_Consumer_FindMerchantConsumerName"
         MaxBookMark = 72
      Case cptsConsumerFindNameFirst
         sProc = "pts_Consumer_FindMerchantNameFirst"
         MaxBookMark = 40
      Case cptsConsumerFindEmail
         sProc = "pts_Consumer_FindMerchantEmail"
         MaxBookMark = 90
      Case cptsConsumerFindPhone
         sProc = "pts_Consumer_FindMerchantPhone"
         MaxBookMark = 30
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamInput, vbNull, CLng(bvMerchantID))
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
               vRec.ConsumerID = moUtil.FetchLong(.Fields.Item("ConsumerID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.MerchantID = moUtil.FetchLong(.Fields.Item("MerchantID").Value)
               vRec.ReferID = moUtil.FetchLong(.Fields.Item("ReferID").Value)
               vRec.CountryID = moUtil.FetchLong(.Fields.Item("CountryID").Value)
               vRec.CountryID2 = moUtil.FetchLong(.Fields.Item("CountryID2").Value)
               vRec.AffiliateID = moUtil.FetchLong(.Fields.Item("AffiliateID").Value)
               vRec.CountryName = moUtil.FetchString(.Fields.Item("CountryName").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.ConsumerName = moUtil.FetchString(.Fields.Item("ConsumerName").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Email2 = moUtil.FetchString(.Fields.Item("Email2").Value)
               vRec.Phone = moUtil.FetchString(.Fields.Item("Phone").Value)
               vRec.Provider = moUtil.FetchLong(.Fields.Item("Provider").Value)
               vRec.Password = moUtil.FetchString(.Fields.Item("Password").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Messages = moUtil.FetchLong(.Fields.Item("Messages").Value)
               vRec.Street1 = moUtil.FetchString(.Fields.Item("Street1").Value)
               vRec.Street2 = moUtil.FetchString(.Fields.Item("Street2").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.City2 = moUtil.FetchString(.Fields.Item("City2").Value)
               vRec.State2 = moUtil.FetchString(.Fields.Item("State2").Value)
               vRec.Zip2 = moUtil.FetchString(.Fields.Item("Zip2").Value)
               vRec.Referrals = moUtil.FetchLong(.Fields.Item("Referrals").Value)
               vRec.Cash = moUtil.FetchCurrency(.Fields.Item("Cash").Value)
               vRec.Points = moUtil.FetchCurrency(.Fields.Item("Points").Value)
               vRec.VisitDate = moUtil.FetchDate(.Fields.Item("VisitDate").Value)
               vRec.EnrollDate = moUtil.FetchDate(.Fields.Item("EnrollDate").Value)
               vRec.UserKey = moUtil.FetchString(.Fields.Item("UserKey").Value)
               vRec.Barter = moUtil.FetchString(.Fields.Item("Barter").Value)
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
   FindMerchant = vRecs

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
   Optional ByVal bvSecurityToken As Long = 0) As tConsumerType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tConsumerType
   Dim vRec As tConsumerType
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
      Case cptsConsumerFindConsumerName
         sProc = "pts_Consumer_FindMemberConsumerName"
         MaxBookMark = 72
      Case cptsConsumerFindNameFirst
         sProc = "pts_Consumer_FindMemberNameFirst"
         MaxBookMark = 40
      Case cptsConsumerFindEmail
         sProc = "pts_Consumer_FindMemberEmail"
         MaxBookMark = 90
      Case cptsConsumerFindPhone
         sProc = "pts_Consumer_FindMemberPhone"
         MaxBookMark = 30
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
               vRec.ConsumerID = moUtil.FetchLong(.Fields.Item("ConsumerID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.MerchantID = moUtil.FetchLong(.Fields.Item("MerchantID").Value)
               vRec.ReferID = moUtil.FetchLong(.Fields.Item("ReferID").Value)
               vRec.CountryID = moUtil.FetchLong(.Fields.Item("CountryID").Value)
               vRec.CountryID2 = moUtil.FetchLong(.Fields.Item("CountryID2").Value)
               vRec.AffiliateID = moUtil.FetchLong(.Fields.Item("AffiliateID").Value)
               vRec.CountryName = moUtil.FetchString(.Fields.Item("CountryName").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.ConsumerName = moUtil.FetchString(.Fields.Item("ConsumerName").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Email2 = moUtil.FetchString(.Fields.Item("Email2").Value)
               vRec.Phone = moUtil.FetchString(.Fields.Item("Phone").Value)
               vRec.Provider = moUtil.FetchLong(.Fields.Item("Provider").Value)
               vRec.Password = moUtil.FetchString(.Fields.Item("Password").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Messages = moUtil.FetchLong(.Fields.Item("Messages").Value)
               vRec.Street1 = moUtil.FetchString(.Fields.Item("Street1").Value)
               vRec.Street2 = moUtil.FetchString(.Fields.Item("Street2").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.City2 = moUtil.FetchString(.Fields.Item("City2").Value)
               vRec.State2 = moUtil.FetchString(.Fields.Item("State2").Value)
               vRec.Zip2 = moUtil.FetchString(.Fields.Item("Zip2").Value)
               vRec.Referrals = moUtil.FetchLong(.Fields.Item("Referrals").Value)
               vRec.Cash = moUtil.FetchCurrency(.Fields.Item("Cash").Value)
               vRec.Points = moUtil.FetchCurrency(.Fields.Item("Points").Value)
               vRec.VisitDate = moUtil.FetchDate(.Fields.Item("VisitDate").Value)
               vRec.EnrollDate = moUtil.FetchDate(.Fields.Item("EnrollDate").Value)
               vRec.UserKey = moUtil.FetchString(.Fields.Item("UserKey").Value)
               vRec.Barter = moUtil.FetchString(.Fields.Item("Barter").Value)
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

Public Function FindRefer( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvReferID As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tConsumerType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindRefer"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tConsumerType
   Dim vRec As tConsumerType
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
   bvReferID = moUtil.EditLong(bvReferID, "ReferID", True) 
   bvSecurityToken = moUtil.EditLong(bvSecurityToken, "User ID", True, , 1) 

   '-----set the stored procedure name
   Select Case bvFindType
      Case cptsConsumerFindConsumerName
         sProc = "pts_Consumer_FindReferConsumerName"
         MaxBookMark = 72
      Case cptsConsumerFindNameFirst
         sProc = "pts_Consumer_FindReferNameFirst"
         MaxBookMark = 40
      Case cptsConsumerFindEmail
         sProc = "pts_Consumer_FindReferEmail"
         MaxBookMark = 90
      Case cptsConsumerFindPhone
         sProc = "pts_Consumer_FindReferPhone"
         MaxBookMark = 30
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ReferID", adInteger, adParamInput, vbNull, CLng(bvReferID))
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
               vRec.ConsumerID = moUtil.FetchLong(.Fields.Item("ConsumerID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.MerchantID = moUtil.FetchLong(.Fields.Item("MerchantID").Value)
               vRec.ReferID = moUtil.FetchLong(.Fields.Item("ReferID").Value)
               vRec.CountryID = moUtil.FetchLong(.Fields.Item("CountryID").Value)
               vRec.CountryID2 = moUtil.FetchLong(.Fields.Item("CountryID2").Value)
               vRec.AffiliateID = moUtil.FetchLong(.Fields.Item("AffiliateID").Value)
               vRec.CountryName = moUtil.FetchString(.Fields.Item("CountryName").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.ConsumerName = moUtil.FetchString(.Fields.Item("ConsumerName").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.Email2 = moUtil.FetchString(.Fields.Item("Email2").Value)
               vRec.Phone = moUtil.FetchString(.Fields.Item("Phone").Value)
               vRec.Provider = moUtil.FetchLong(.Fields.Item("Provider").Value)
               vRec.Password = moUtil.FetchString(.Fields.Item("Password").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Messages = moUtil.FetchLong(.Fields.Item("Messages").Value)
               vRec.Street1 = moUtil.FetchString(.Fields.Item("Street1").Value)
               vRec.Street2 = moUtil.FetchString(.Fields.Item("Street2").Value)
               vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
               vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.City2 = moUtil.FetchString(.Fields.Item("City2").Value)
               vRec.State2 = moUtil.FetchString(.Fields.Item("State2").Value)
               vRec.Zip2 = moUtil.FetchString(.Fields.Item("Zip2").Value)
               vRec.Referrals = moUtil.FetchLong(.Fields.Item("Referrals").Value)
               vRec.Cash = moUtil.FetchCurrency(.Fields.Item("Cash").Value)
               vRec.Points = moUtil.FetchCurrency(.Fields.Item("Points").Value)
               vRec.VisitDate = moUtil.FetchDate(.Fields.Item("VisitDate").Value)
               vRec.EnrollDate = moUtil.FetchDate(.Fields.Item("EnrollDate").Value)
               vRec.UserKey = moUtil.FetchString(.Fields.Item("UserKey").Value)
               vRec.Barter = moUtil.FetchString(.Fields.Item("Barter").Value)
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
   FindRefer = vRecs

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
   ByVal bvMerchantID As Long, _ 
   ByVal bvTargetArea As Long, _ 
   ByVal bvTargetType As Long, _ 
   ByVal bvTargetDays As Long, _ 
   ByVal bvTarget As String, _ 
   ByVal bvCountryID As Long) As tConsumerType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListEmail"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tConsumerType
   Dim vRec As tConsumerType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvMerchantID = moUtil.EditLong(bvMerchantID, "MerchantID", True, 0) 
      bvTargetArea = moUtil.EditLong(bvTargetArea, "TargetArea", True, 0) 
      bvTargetType = moUtil.EditLong(bvTargetType, "TargetType", True, 0) 
      bvTargetDays = moUtil.EditLong(bvTargetDays, "TargetDays", True, 0) 
      bvTarget = moUtil.EditString(bvTarget, "Target", True, "", 1, 200) 
      bvCountryID = moUtil.EditLong(bvCountryID, "CountryID", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamInput, vbNull, CLng(bvMerchantID))
      .Parameters.Append .CreateParameter("@TargetArea", adInteger, adParamInput, vbNull, CLng(bvTargetArea))
      .Parameters.Append .CreateParameter("@TargetType", adInteger, adParamInput, vbNull, CLng(bvTargetType))
      .Parameters.Append .CreateParameter("@TargetDays", adInteger, adParamInput, vbNull, CLng(bvTargetDays))
      .Parameters.Append .CreateParameter("@Target", adVarWChar, adParamInput, 200, bvTarget)
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamInput, vbNull, CLng(bvCountryID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Consumer_ListEmail")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ConsumerID = moUtil.FetchLong(.Fields.Item("ConsumerID").Value)
            vRec.Email2 = moUtil.FetchString(.Fields.Item("Email2").Value)
            vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
            vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
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

Public Function ListMarketEmail( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvTarget As String, _ 
   ByVal bvCountryID As Long) As tConsumerType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMarketEmail"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tConsumerType
   Dim vRec As tConsumerType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvCompanyID = moUtil.EditLong(bvCompanyID, "CompanyID", True, 0) 
      bvTarget = moUtil.EditString(bvTarget, "Target", True, "", 1, 200) 
      bvCountryID = moUtil.EditLong(bvCountryID, "CountryID", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@Target", adVarWChar, adParamInput, 200, bvTarget)
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamInput, vbNull, CLng(bvCountryID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Consumer_ListMarketEmail")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ConsumerID = moUtil.FetchLong(.Fields.Item("ConsumerID").Value)
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
            vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
            vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListMarketEmail = vRecs

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
   ByRef brRec As tConsumerType, _ 
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
      .Parameters.Append .CreateParameter("@ConsumerID", adInteger, adParamInput, vbNull, CLng(brRec.ConsumerID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@MerchantID", adInteger, adParamInput, vbNull, CLng(brRec.MerchantID))
      .Parameters.Append .CreateParameter("@ReferID", adInteger, adParamInput, vbNull, CLng(brRec.ReferID))
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamInput, vbNull, CLng(brRec.CountryID))
      .Parameters.Append .CreateParameter("@CountryID2", adInteger, adParamInput, vbNull, CLng(brRec.CountryID2))
      .Parameters.Append .CreateParameter("@AffiliateID", adInteger, adParamInput, vbNull, CLng(brRec.AffiliateID))
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamInput, 30, brRec.NameLast)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamInput, 30, brRec.NameFirst)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@Email2", adVarWChar, adParamInput, 80, brRec.Email2)
      .Parameters.Append .CreateParameter("@Phone", adVarWChar, adParamInput, 20, brRec.Phone)
      .Parameters.Append .CreateParameter("@Provider", adInteger, adParamInput, vbNull, CLng(brRec.Provider))
      .Parameters.Append .CreateParameter("@Password", adVarWChar, adParamInput, 20, brRec.Password)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Messages", adInteger, adParamInput, vbNull, CLng(brRec.Messages))
      .Parameters.Append .CreateParameter("@Street1", adVarWChar, adParamInput, 60, brRec.Street1)
      .Parameters.Append .CreateParameter("@Street2", adVarWChar, adParamInput, 60, brRec.Street2)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamInput, 30, brRec.City)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamInput, 30, brRec.State)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamInput, 20, brRec.Zip)
      .Parameters.Append .CreateParameter("@City2", adVarWChar, adParamInput, 30, brRec.City2)
      .Parameters.Append .CreateParameter("@State2", adVarWChar, adParamInput, 30, brRec.State2)
      .Parameters.Append .CreateParameter("@Zip2", adVarWChar, adParamInput, 20, brRec.Zip2)
      .Parameters.Append .CreateParameter("@Referrals", adInteger, adParamInput, vbNull, CLng(brRec.Referrals))
      .Parameters.Append .CreateParameter("@Cash", adCurrency, adParamInput, vbNull, CCur(brRec.Cash))
      .Parameters.Append .CreateParameter("@Points", adCurrency, adParamInput, vbNull, CCur(brRec.Points))
      .Parameters.Append .CreateParameter("@VisitDate", adDate, adParamInput, vbNull, CDate(brRec.VisitDate))
      .Parameters.Append .CreateParameter("@EnrollDate", adDate, adParamInput, vbNull, CDate(brRec.EnrollDate))
      .Parameters.Append .CreateParameter("@UserKey", adVarWChar, adParamInput, 40, brRec.UserKey)
      .Parameters.Append .CreateParameter("@Barter", adVarWChar, adParamInput, 100, brRec.Barter)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Consumer_Update"

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
   ByRef brRec As tConsumerType, _ 
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
         .ConsumerID = moUtil.EditLong(.ConsumerID, "ConsumerID", True, , 1) 
      End If
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", False) 
      .MerchantID = moUtil.EditLong(.MerchantID, "MerchantID", False) 
      .ReferID = moUtil.EditLong(.ReferID, "ReferID", False) 
      .CountryID = moUtil.EditLong(.CountryID, "CountryID", False) 
      .CountryID2 = moUtil.EditLong(.CountryID2, "CountryID2", False) 
      .AffiliateID = moUtil.EditLong(.AffiliateID, "AffiliateID", False) 
      .NameLast = moUtil.EditString(.NameLast, "NameLast", False, , 1, 30) 
      .NameFirst = moUtil.EditString(.NameFirst, "NameFirst", False, , 1, 30) 
      .Email = moUtil.EditString(.Email, "Email", False, , 1, 80) 
      .Email2 = moUtil.EditString(.Email2, "Email2", False, , 1, 80) 
      .Phone = moUtil.EditString(.Phone, "Phone", False, , 1, 20) 
      .Provider = moUtil.EditLong(.Provider, "Provider", False) 
      .Password = moUtil.EditString(.Password, "Password", False, , 1, 20) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .Messages = moUtil.EditLong(.Messages, "Messages", False) 
      .Street1 = moUtil.EditString(.Street1, "Street1", False, , 1, 60) 
      .Street2 = moUtil.EditString(.Street2, "Street2", False, , 1, 60) 
      .City = moUtil.EditString(.City, "City", False, , 1, 30) 
      .State = moUtil.EditString(.State, "State", False, , 1, 30) 
      .Zip = moUtil.EditString(.Zip, "Zip", False, , 1, 20) 
      .City2 = moUtil.EditString(.City2, "City2", False, , 1, 30) 
      .State2 = moUtil.EditString(.State2, "State2", False, , 1, 30) 
      .Zip2 = moUtil.EditString(.Zip2, "Zip2", False, , 1, 20) 
      .Referrals = moUtil.EditLong(.Referrals, "Referrals", False) 
      .Cash = moUtil.EditCurrency(.Cash, "Cash", False, , -999999.99, 999999.99) 
      .Points = moUtil.EditCurrency(.Points, "Points", False, , -999999.99, 999999.99) 
      .VisitDate = moUtil.EditDate(.VisitDate, "VisitDate", False) 
      .EnrollDate = moUtil.EditDate(.EnrollDate, "EnrollDate", False) 
      .UserKey = moUtil.EditString(.UserKey, "UserKey", False, , 1, 40) 
      .Barter = moUtil.EditString(.Barter, "Barter", False, , 1, 100) 
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