VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CBarterAdB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CBarterAd"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tBarterAdType
   BarterAdID As String
   ConsumerID As String
   BarterArea1ID As String
   BarterArea2ID As String
   BarterCategoryID As String
   Title As String
   Status As String
   PostDate As String
   UpdateDate As String
   EndDate As String
   Price As String
   Location As String
   Zip As String
   Description As String
   Language As String
   ContactName As String
   ContactEmail As String
   ContactPhone As String
   IsEmail As String
   IsPhone As String
   IsText As String
   IsMore As String
   IsMap As String
   IsContact As String
   IsDealer As String
   MapStreet1 As String
   MapStreet2 As String
   MapCity As String
   MapZip As String
   Options As String
   Payments As String
   Condition As String
   Images As String
   GeoCode As String
   T1 As String
   T2 As String
   T3 As String
   T4 As String
   T5 As String
   N1 As String
   N2 As String
   N3 As String
   N4 As String
   N5 As String
   L1 As String
   L2 As String
   L3 As String
   L4 As String
   L5 As String
   L6 As String
   L7 As String
   L8 As String
   L9 As String
   L10 As String
   Y1 As String
   Y2 As String
   Y3 As String
   Y4 As String
   Y5 As String
   Y6 As String
   Y7 As String
   Y8 As String
   Y9 As String
   Y10 As String
   D1 As String
   D2 As String
   D3 As String
   D4 As String
   D5 As String
   Image As String
   MainCategoryID As String
End Type

Public Sub Add( _ 
   ByRef brRec As tBarterAdType, _ 
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
      .Parameters.Append .CreateParameter("@BarterAdID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ConsumerID", adInteger, adParamInput, vbNull, CLng(brRec.ConsumerID))
      .Parameters.Append .CreateParameter("@BarterArea1ID", adInteger, adParamInput, vbNull, CLng(brRec.BarterArea1ID))
      .Parameters.Append .CreateParameter("@BarterArea2ID", adInteger, adParamInput, vbNull, CLng(brRec.BarterArea2ID))
      .Parameters.Append .CreateParameter("@BarterCategoryID", adInteger, adParamInput, vbNull, CLng(brRec.BarterCategoryID))
      .Parameters.Append .CreateParameter("@Title", adVarWChar, adParamInput, 100, brRec.Title)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@PostDate", adDate, adParamInput, vbNull, CDate(brRec.PostDate))
      .Parameters.Append .CreateParameter("@UpdateDate", adDate, adParamInput, vbNull, CDate(brRec.UpdateDate))
      .Parameters.Append .CreateParameter("@EndDate", adDate, adParamInput, vbNull, CDate(brRec.EndDate))
      .Parameters.Append .CreateParameter("@Price", adCurrency, adParamInput, vbNull, CCur(brRec.Price))
      .Parameters.Append .CreateParameter("@Location", adVarWChar, adParamInput, 40, brRec.Location)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamInput, 10, brRec.Zip)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 4000, brRec.Description)
      .Parameters.Append .CreateParameter("@Language", adVarWChar, adParamInput, 10, brRec.Language)
      .Parameters.Append .CreateParameter("@ContactName", adVarWChar, adParamInput, 40, brRec.ContactName)
      .Parameters.Append .CreateParameter("@ContactEmail", adVarWChar, adParamInput, 80, brRec.ContactEmail)
      .Parameters.Append .CreateParameter("@ContactPhone", adVarWChar, adParamInput, 40, brRec.ContactPhone)
      .Parameters.Append .CreateParameter("@IsEmail", adSmallInt, adParamInput, vbNull, CInt(brRec.IsEmail))
      .Parameters.Append .CreateParameter("@IsPhone", adSmallInt, adParamInput, vbNull, CInt(brRec.IsPhone))
      .Parameters.Append .CreateParameter("@IsText", adSmallInt, adParamInput, vbNull, CInt(brRec.IsText))
      .Parameters.Append .CreateParameter("@IsMore", adSmallInt, adParamInput, vbNull, CInt(brRec.IsMore))
      .Parameters.Append .CreateParameter("@IsMap", adSmallInt, adParamInput, vbNull, CInt(brRec.IsMap))
      .Parameters.Append .CreateParameter("@IsContact", adSmallInt, adParamInput, vbNull, CInt(brRec.IsContact))
      .Parameters.Append .CreateParameter("@IsDealer", adSmallInt, adParamInput, vbNull, CInt(brRec.IsDealer))
      .Parameters.Append .CreateParameter("@MapStreet1", adVarWChar, adParamInput, 60, brRec.MapStreet1)
      .Parameters.Append .CreateParameter("@MapStreet2", adVarWChar, adParamInput, 60, brRec.MapStreet2)
      .Parameters.Append .CreateParameter("@MapCity", adVarWChar, adParamInput, 30, brRec.MapCity)
      .Parameters.Append .CreateParameter("@MapZip", adVarWChar, adParamInput, 10, brRec.MapZip)
      .Parameters.Append .CreateParameter("@Options", adVarWChar, adParamInput, 20, brRec.Options)
      .Parameters.Append .CreateParameter("@Payments", adVarWChar, adParamInput, 20, brRec.Payments)
      .Parameters.Append .CreateParameter("@Condition", adInteger, adParamInput, vbNull, CLng(brRec.Condition))
      .Parameters.Append .CreateParameter("@Images", adInteger, adParamInput, vbNull, CLng(brRec.Images))
      .Parameters.Append .CreateParameter("@GeoCode", adVarWChar, adParamInput, 30, brRec.GeoCode)
      .Parameters.Append .CreateParameter("@T1", adVarWChar, adParamInput, 40, brRec.T1)
      .Parameters.Append .CreateParameter("@T2", adVarWChar, adParamInput, 40, brRec.T2)
      .Parameters.Append .CreateParameter("@T3", adVarWChar, adParamInput, 40, brRec.T3)
      .Parameters.Append .CreateParameter("@T4", adVarWChar, adParamInput, 40, brRec.T4)
      .Parameters.Append .CreateParameter("@T5", adVarWChar, adParamInput, 40, brRec.T5)
      .Parameters.Append .CreateParameter("@N1", adInteger, adParamInput, vbNull, CLng(brRec.N1))
      .Parameters.Append .CreateParameter("@N2", adInteger, adParamInput, vbNull, CLng(brRec.N2))
      .Parameters.Append .CreateParameter("@N3", adInteger, adParamInput, vbNull, CLng(brRec.N3))
      .Parameters.Append .CreateParameter("@N4", adInteger, adParamInput, vbNull, CLng(brRec.N4))
      .Parameters.Append .CreateParameter("@N5", adInteger, adParamInput, vbNull, CLng(brRec.N5))
      .Parameters.Append .CreateParameter("@L1", adUnsignedTinyInt, adParamInput, vbNull, CByte(brRec.L1))
      .Parameters.Append .CreateParameter("@L2", adUnsignedTinyInt, adParamInput, vbNull, CByte(brRec.L2))
      .Parameters.Append .CreateParameter("@L3", adUnsignedTinyInt, adParamInput, vbNull, CByte(brRec.L3))
      .Parameters.Append .CreateParameter("@L4", adUnsignedTinyInt, adParamInput, vbNull, CByte(brRec.L4))
      .Parameters.Append .CreateParameter("@L5", adUnsignedTinyInt, adParamInput, vbNull, CByte(brRec.L5))
      .Parameters.Append .CreateParameter("@L6", adUnsignedTinyInt, adParamInput, vbNull, CByte(brRec.L6))
      .Parameters.Append .CreateParameter("@L7", adUnsignedTinyInt, adParamInput, vbNull, CByte(brRec.L7))
      .Parameters.Append .CreateParameter("@L8", adUnsignedTinyInt, adParamInput, vbNull, CByte(brRec.L8))
      .Parameters.Append .CreateParameter("@L9", adUnsignedTinyInt, adParamInput, vbNull, CByte(brRec.L9))
      .Parameters.Append .CreateParameter("@L10", adUnsignedTinyInt, adParamInput, vbNull, CByte(brRec.L10))
      .Parameters.Append .CreateParameter("@Y1", adSmallInt, adParamInput, vbNull, CInt(brRec.Y1))
      .Parameters.Append .CreateParameter("@Y2", adSmallInt, adParamInput, vbNull, CInt(brRec.Y2))
      .Parameters.Append .CreateParameter("@Y3", adSmallInt, adParamInput, vbNull, CInt(brRec.Y3))
      .Parameters.Append .CreateParameter("@Y4", adSmallInt, adParamInput, vbNull, CInt(brRec.Y4))
      .Parameters.Append .CreateParameter("@Y5", adSmallInt, adParamInput, vbNull, CInt(brRec.Y5))
      .Parameters.Append .CreateParameter("@Y6", adSmallInt, adParamInput, vbNull, CInt(brRec.Y6))
      .Parameters.Append .CreateParameter("@Y7", adSmallInt, adParamInput, vbNull, CInt(brRec.Y7))
      .Parameters.Append .CreateParameter("@Y8", adSmallInt, adParamInput, vbNull, CInt(brRec.Y8))
      .Parameters.Append .CreateParameter("@Y9", adSmallInt, adParamInput, vbNull, CInt(brRec.Y9))
      .Parameters.Append .CreateParameter("@Y10", adSmallInt, adParamInput, vbNull, CInt(brRec.Y10))
      .Parameters.Append .CreateParameter("@D1", adDate, adParamInput, vbNull, CDate(brRec.D1))
      .Parameters.Append .CreateParameter("@D2", adDate, adParamInput, vbNull, CDate(brRec.D2))
      .Parameters.Append .CreateParameter("@D3", adDate, adParamInput, vbNull, CDate(brRec.D3))
      .Parameters.Append .CreateParameter("@D4", adDate, adParamInput, vbNull, CDate(brRec.D4))
      .Parameters.Append .CreateParameter("@D5", adDate, adParamInput, vbNull, CDate(brRec.D5))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_BarterAd_Add"

   '-----get return values
   With brRec
      .BarterAdID = moUtil.FetchLong(oCmd.Parameters.Item("@BarterAdID").Value)
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
   ByRef brRec As tBarterAdType, _ 
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
      .Parameters.Append .CreateParameter("@BarterAdID", adInteger, adParamInput, vbNull, CLng(brRec.BarterAdID))
      .Parameters.Append .CreateParameter("@Title", adVarWChar, adParamInput, 100, brRec.Title)
      .Parameters.Append .CreateParameter("@Location", adVarWChar, adParamInput, 40, brRec.Location)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamInput, 10, brRec.Zip)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 4000, brRec.Description)
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_BarterAd_UpdateFT"

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

Public Sub Delete( _ 
   ByRef brRec As tBarterAdType, _ 
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
      .BarterAdID = moUtil.EditLong(.BarterAdID, "BarterAdID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@BarterAdID", adInteger, adParamInput, vbNull, CLng(brRec.BarterAdID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_BarterAd_Delete"

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
   ByRef brRec As tBarterAdType, _ 
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
      .BarterAdID = moUtil.EditLong(.BarterAdID, "BarterAdID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@BarterAdID", adInteger, adParamInput, vbNull, CLng(brRec.BarterAdID))
      .Parameters.Append .CreateParameter("@ConsumerID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BarterArea1ID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BarterArea2ID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BarterCategoryID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Title", adVarWChar, adParamOutput, 100, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PostDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UpdateDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@EndDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Price", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Location", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamOutput, 10, vbNull)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamOutput, 4000, vbNull)
      .Parameters.Append .CreateParameter("@Language", adVarWChar, adParamOutput, 10, vbNull)
      .Parameters.Append .CreateParameter("@ContactName", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@ContactEmail", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@ContactPhone", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@IsEmail", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsPhone", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsText", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsMore", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsMap", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsContact", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsDealer", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MapStreet1", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@MapStreet2", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@MapCity", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@MapZip", adVarWChar, adParamOutput, 10, vbNull)
      .Parameters.Append .CreateParameter("@Options", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@Payments", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@Condition", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Images", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@GeoCode", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@T1", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@T2", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@T3", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@T4", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@T5", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@N1", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@N2", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@N3", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@N4", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@N5", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@L1", adUnsignedTinyInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@L2", adUnsignedTinyInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@L3", adUnsignedTinyInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@L4", adUnsignedTinyInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@L5", adUnsignedTinyInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@L6", adUnsignedTinyInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@L7", adUnsignedTinyInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@L8", adUnsignedTinyInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@L9", adUnsignedTinyInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@L10", adUnsignedTinyInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Y1", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Y2", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Y3", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Y4", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Y5", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Y6", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Y7", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Y8", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Y9", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Y10", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@D1", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@D2", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@D3", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@D4", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@D5", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_BarterAd_Fetch"

   '-----get return values
   With brRec
      .ConsumerID = moUtil.FetchLong(oCmd.Parameters.Item("@ConsumerID").Value)
      .BarterArea1ID = moUtil.FetchLong(oCmd.Parameters.Item("@BarterArea1ID").Value)
      .BarterArea2ID = moUtil.FetchLong(oCmd.Parameters.Item("@BarterArea2ID").Value)
      .BarterCategoryID = moUtil.FetchLong(oCmd.Parameters.Item("@BarterCategoryID").Value)
      .Title = moUtil.FetchString(oCmd.Parameters.Item("@Title").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .PostDate = moUtil.FetchDate(oCmd.Parameters.Item("@PostDate").Value)
      .UpdateDate = moUtil.FetchDate(oCmd.Parameters.Item("@UpdateDate").Value)
      .EndDate = moUtil.FetchDate(oCmd.Parameters.Item("@EndDate").Value)
      .Price = moUtil.FetchCurrency(oCmd.Parameters.Item("@Price").Value)
      .Location = moUtil.FetchString(oCmd.Parameters.Item("@Location").Value)
      .Zip = moUtil.FetchString(oCmd.Parameters.Item("@Zip").Value)
      .Description = moUtil.FetchString(oCmd.Parameters.Item("@Description").Value)
      .Language = moUtil.FetchString(oCmd.Parameters.Item("@Language").Value)
      .ContactName = moUtil.FetchString(oCmd.Parameters.Item("@ContactName").Value)
      .ContactEmail = moUtil.FetchString(oCmd.Parameters.Item("@ContactEmail").Value)
      .ContactPhone = moUtil.FetchString(oCmd.Parameters.Item("@ContactPhone").Value)
      .IsEmail = moUtil.FetchInteger(oCmd.Parameters.Item("@IsEmail").Value)
      .IsPhone = moUtil.FetchInteger(oCmd.Parameters.Item("@IsPhone").Value)
      .IsText = moUtil.FetchInteger(oCmd.Parameters.Item("@IsText").Value)
      .IsMore = moUtil.FetchInteger(oCmd.Parameters.Item("@IsMore").Value)
      .IsMap = moUtil.FetchInteger(oCmd.Parameters.Item("@IsMap").Value)
      .IsContact = moUtil.FetchInteger(oCmd.Parameters.Item("@IsContact").Value)
      .IsDealer = moUtil.FetchInteger(oCmd.Parameters.Item("@IsDealer").Value)
      .MapStreet1 = moUtil.FetchString(oCmd.Parameters.Item("@MapStreet1").Value)
      .MapStreet2 = moUtil.FetchString(oCmd.Parameters.Item("@MapStreet2").Value)
      .MapCity = moUtil.FetchString(oCmd.Parameters.Item("@MapCity").Value)
      .MapZip = moUtil.FetchString(oCmd.Parameters.Item("@MapZip").Value)
      .Options = moUtil.FetchString(oCmd.Parameters.Item("@Options").Value)
      .Payments = moUtil.FetchString(oCmd.Parameters.Item("@Payments").Value)
      .Condition = moUtil.FetchLong(oCmd.Parameters.Item("@Condition").Value)
      .Images = moUtil.FetchLong(oCmd.Parameters.Item("@Images").Value)
      .GeoCode = moUtil.FetchString(oCmd.Parameters.Item("@GeoCode").Value)
      .T1 = moUtil.FetchString(oCmd.Parameters.Item("@T1").Value)
      .T2 = moUtil.FetchString(oCmd.Parameters.Item("@T2").Value)
      .T3 = moUtil.FetchString(oCmd.Parameters.Item("@T3").Value)
      .T4 = moUtil.FetchString(oCmd.Parameters.Item("@T4").Value)
      .T5 = moUtil.FetchString(oCmd.Parameters.Item("@T5").Value)
      .N1 = moUtil.FetchLong(oCmd.Parameters.Item("@N1").Value)
      .N2 = moUtil.FetchLong(oCmd.Parameters.Item("@N2").Value)
      .N3 = moUtil.FetchLong(oCmd.Parameters.Item("@N3").Value)
      .N4 = moUtil.FetchLong(oCmd.Parameters.Item("@N4").Value)
      .N5 = moUtil.FetchLong(oCmd.Parameters.Item("@N5").Value)
      .L1 = moUtil.FetchByte(oCmd.Parameters.Item("@L1").Value)
      .L2 = moUtil.FetchByte(oCmd.Parameters.Item("@L2").Value)
      .L3 = moUtil.FetchByte(oCmd.Parameters.Item("@L3").Value)
      .L4 = moUtil.FetchByte(oCmd.Parameters.Item("@L4").Value)
      .L5 = moUtil.FetchByte(oCmd.Parameters.Item("@L5").Value)
      .L6 = moUtil.FetchByte(oCmd.Parameters.Item("@L6").Value)
      .L7 = moUtil.FetchByte(oCmd.Parameters.Item("@L7").Value)
      .L8 = moUtil.FetchByte(oCmd.Parameters.Item("@L8").Value)
      .L9 = moUtil.FetchByte(oCmd.Parameters.Item("@L9").Value)
      .L10 = moUtil.FetchByte(oCmd.Parameters.Item("@L10").Value)
      .Y1 = moUtil.FetchInteger(oCmd.Parameters.Item("@Y1").Value)
      .Y2 = moUtil.FetchInteger(oCmd.Parameters.Item("@Y2").Value)
      .Y3 = moUtil.FetchInteger(oCmd.Parameters.Item("@Y3").Value)
      .Y4 = moUtil.FetchInteger(oCmd.Parameters.Item("@Y4").Value)
      .Y5 = moUtil.FetchInteger(oCmd.Parameters.Item("@Y5").Value)
      .Y6 = moUtil.FetchInteger(oCmd.Parameters.Item("@Y6").Value)
      .Y7 = moUtil.FetchInteger(oCmd.Parameters.Item("@Y7").Value)
      .Y8 = moUtil.FetchInteger(oCmd.Parameters.Item("@Y8").Value)
      .Y9 = moUtil.FetchInteger(oCmd.Parameters.Item("@Y9").Value)
      .Y10 = moUtil.FetchInteger(oCmd.Parameters.Item("@Y10").Value)
      .D1 = moUtil.FetchDate(oCmd.Parameters.Item("@D1").Value)
      .D2 = moUtil.FetchDate(oCmd.Parameters.Item("@D2").Value)
      .D3 = moUtil.FetchDate(oCmd.Parameters.Item("@D3").Value)
      .D4 = moUtil.FetchDate(oCmd.Parameters.Item("@D4").Value)
      .D5 = moUtil.FetchDate(oCmd.Parameters.Item("@D5").Value)
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
   Optional ByVal bvSecurityToken As Long = 0) As tBarterAdType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tBarterAdType
   Dim vRec As tBarterAdType
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
      Case cptsBarterAdFindPostDate
         sProc = "pts_BarterAd_FindPostDate"
         MaxBookMark = 30
      Case cptsBarterAdFindUpdateDate
         sProc = "pts_BarterAd_FindUpdateDate"
         MaxBookMark = 30
      Case cptsBarterAdFindTitle
         sProc = "pts_BarterAd_FindTitle"
         MaxBookMark = 110
      Case cptsBarterAdFindBarterAdID
         sProc = "pts_BarterAd_FindBarterAdID"
         MaxBookMark = 20
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
               vRec.BarterAdID = moUtil.FetchLong(.Fields.Item("BarterAdID").Value)
               vRec.Title = moUtil.FetchString(.Fields.Item("Title").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Price = moUtil.FetchCurrency(.Fields.Item("Price").Value)
               vRec.Condition = moUtil.FetchLong(.Fields.Item("Condition").Value)
               vRec.PostDate = moUtil.FetchDate(.Fields.Item("PostDate").Value)
               vRec.UpdateDate = moUtil.FetchDate(.Fields.Item("UpdateDate").Value)
               vRec.Images = moUtil.FetchLong(.Fields.Item("Images").Value)
               vRec.Options = moUtil.FetchString(.Fields.Item("Options").Value)
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
   Optional ByVal bvSecurityToken As Long = 0) As tBarterAdType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tBarterAdType
   Dim vRec As tBarterAdType
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
      Case cptsBarterAdFindPostDate
         sProc = "pts_BarterAd_FindStatusPostDate"
         MaxBookMark = 30
      Case cptsBarterAdFindUpdateDate
         sProc = "pts_BarterAd_FindStatusUpdateDate"
         MaxBookMark = 30
      Case cptsBarterAdFindTitle
         sProc = "pts_BarterAd_FindStatusTitle"
         MaxBookMark = 110
      Case cptsBarterAdFindBarterAdID
         sProc = "pts_BarterAd_FindStatusBarterAdID"
         MaxBookMark = 20
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
               vRec.BarterAdID = moUtil.FetchLong(.Fields.Item("BarterAdID").Value)
               vRec.Title = moUtil.FetchString(.Fields.Item("Title").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Price = moUtil.FetchCurrency(.Fields.Item("Price").Value)
               vRec.Condition = moUtil.FetchLong(.Fields.Item("Condition").Value)
               vRec.PostDate = moUtil.FetchDate(.Fields.Item("PostDate").Value)
               vRec.UpdateDate = moUtil.FetchDate(.Fields.Item("UpdateDate").Value)
               vRec.Images = moUtil.FetchLong(.Fields.Item("Images").Value)
               vRec.Options = moUtil.FetchString(.Fields.Item("Options").Value)
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

Public Function Search( _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvStatus As Long, _ 
   ByVal bvBarterArea1ID As Long, _ 
   ByVal bvBarterArea2ID As Long, _ 
   ByVal bvMainCategoryID As Long, _ 
   ByVal bvBarterCategoryID As Long, _ 
   ByVal bvImages As Long, _ 
   ByVal bvDescription As String) As tBarterAdType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Search"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tBarterAdType
   Dim vRec As tBarterAdType
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
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, 20, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
      .Parameters.Append .CreateParameter("@BarterArea1ID", adInteger, adParamInput, vbNull, CLng(bvBarterArea1ID))
      .Parameters.Append .CreateParameter("@BarterArea2ID", adInteger, adParamInput, vbNull, CLng(bvBarterArea2ID))
      .Parameters.Append .CreateParameter("@MainCategoryID", adInteger, adParamInput, vbNull, CLng(bvMainCategoryID))
      .Parameters.Append .CreateParameter("@BarterCategoryID", adInteger, adParamInput, vbNull, CLng(bvBarterCategoryID))
      .Parameters.Append .CreateParameter("@Images", adInteger, adParamInput, vbNull, CLng(bvImages))
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 4000, bvDescription)
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_BarterAd_Search")

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
               vRec.BarterAdID = moUtil.FetchLong(.Fields.Item("BarterAdID").Value)
               vRec.BarterArea1ID = moUtil.FetchLong(.Fields.Item("BarterArea1ID").Value)
               vRec.BarterArea2ID = moUtil.FetchLong(.Fields.Item("BarterArea2ID").Value)
               vRec.BarterCategoryID = moUtil.FetchLong(.Fields.Item("BarterCategoryID").Value)
               vRec.Title = moUtil.FetchString(.Fields.Item("Title").Value)
               vRec.Price = moUtil.FetchCurrency(.Fields.Item("Price").Value)
               vRec.Location = moUtil.FetchString(.Fields.Item("Location").Value)
               vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
               vRec.PostDate = moUtil.FetchDate(.Fields.Item("PostDate").Value)
               vRec.UpdateDate = moUtil.FetchDate(.Fields.Item("UpdateDate").Value)
               vRec.Image = moUtil.FetchString(.Fields.Item("Image").Value)
               vRec.Images = moUtil.FetchLong(.Fields.Item("Images").Value)
               vRec.IsMap = moUtil.FetchInteger(.Fields.Item("IsMap").Value)
               vRec.Language = moUtil.FetchString(.Fields.Item("Language").Value)
               vRec.MapStreet1 = moUtil.FetchString(.Fields.Item("MapStreet1").Value)
               vRec.MapStreet2 = moUtil.FetchString(.Fields.Item("MapStreet2").Value)
               vRec.Options = moUtil.FetchString(.Fields.Item("Options").Value)
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

Public Sub Update( _ 
   ByRef brRec As tBarterAdType, _ 
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
      .Parameters.Append .CreateParameter("@BarterAdID", adInteger, adParamInput, vbNull, CLng(brRec.BarterAdID))
      .Parameters.Append .CreateParameter("@ConsumerID", adInteger, adParamInput, vbNull, CLng(brRec.ConsumerID))
      .Parameters.Append .CreateParameter("@BarterArea1ID", adInteger, adParamInput, vbNull, CLng(brRec.BarterArea1ID))
      .Parameters.Append .CreateParameter("@BarterArea2ID", adInteger, adParamInput, vbNull, CLng(brRec.BarterArea2ID))
      .Parameters.Append .CreateParameter("@BarterCategoryID", adInteger, adParamInput, vbNull, CLng(brRec.BarterCategoryID))
      .Parameters.Append .CreateParameter("@Title", adVarWChar, adParamInput, 100, brRec.Title)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@PostDate", adDate, adParamInput, vbNull, CDate(brRec.PostDate))
      .Parameters.Append .CreateParameter("@UpdateDate", adDate, adParamInput, vbNull, CDate(brRec.UpdateDate))
      .Parameters.Append .CreateParameter("@EndDate", adDate, adParamInput, vbNull, CDate(brRec.EndDate))
      .Parameters.Append .CreateParameter("@Price", adCurrency, adParamInput, vbNull, CCur(brRec.Price))
      .Parameters.Append .CreateParameter("@Location", adVarWChar, adParamInput, 40, brRec.Location)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamInput, 10, brRec.Zip)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 4000, brRec.Description)
      .Parameters.Append .CreateParameter("@Language", adVarWChar, adParamInput, 10, brRec.Language)
      .Parameters.Append .CreateParameter("@ContactName", adVarWChar, adParamInput, 40, brRec.ContactName)
      .Parameters.Append .CreateParameter("@ContactEmail", adVarWChar, adParamInput, 80, brRec.ContactEmail)
      .Parameters.Append .CreateParameter("@ContactPhone", adVarWChar, adParamInput, 40, brRec.ContactPhone)
      .Parameters.Append .CreateParameter("@IsEmail", adSmallInt, adParamInput, vbNull, CInt(brRec.IsEmail))
      .Parameters.Append .CreateParameter("@IsPhone", adSmallInt, adParamInput, vbNull, CInt(brRec.IsPhone))
      .Parameters.Append .CreateParameter("@IsText", adSmallInt, adParamInput, vbNull, CInt(brRec.IsText))
      .Parameters.Append .CreateParameter("@IsMore", adSmallInt, adParamInput, vbNull, CInt(brRec.IsMore))
      .Parameters.Append .CreateParameter("@IsMap", adSmallInt, adParamInput, vbNull, CInt(brRec.IsMap))
      .Parameters.Append .CreateParameter("@IsContact", adSmallInt, adParamInput, vbNull, CInt(brRec.IsContact))
      .Parameters.Append .CreateParameter("@IsDealer", adSmallInt, adParamInput, vbNull, CInt(brRec.IsDealer))
      .Parameters.Append .CreateParameter("@MapStreet1", adVarWChar, adParamInput, 60, brRec.MapStreet1)
      .Parameters.Append .CreateParameter("@MapStreet2", adVarWChar, adParamInput, 60, brRec.MapStreet2)
      .Parameters.Append .CreateParameter("@MapCity", adVarWChar, adParamInput, 30, brRec.MapCity)
      .Parameters.Append .CreateParameter("@MapZip", adVarWChar, adParamInput, 10, brRec.MapZip)
      .Parameters.Append .CreateParameter("@Options", adVarWChar, adParamInput, 20, brRec.Options)
      .Parameters.Append .CreateParameter("@Payments", adVarWChar, adParamInput, 20, brRec.Payments)
      .Parameters.Append .CreateParameter("@Condition", adInteger, adParamInput, vbNull, CLng(brRec.Condition))
      .Parameters.Append .CreateParameter("@Images", adInteger, adParamInput, vbNull, CLng(brRec.Images))
      .Parameters.Append .CreateParameter("@GeoCode", adVarWChar, adParamInput, 30, brRec.GeoCode)
      .Parameters.Append .CreateParameter("@T1", adVarWChar, adParamInput, 40, brRec.T1)
      .Parameters.Append .CreateParameter("@T2", adVarWChar, adParamInput, 40, brRec.T2)
      .Parameters.Append .CreateParameter("@T3", adVarWChar, adParamInput, 40, brRec.T3)
      .Parameters.Append .CreateParameter("@T4", adVarWChar, adParamInput, 40, brRec.T4)
      .Parameters.Append .CreateParameter("@T5", adVarWChar, adParamInput, 40, brRec.T5)
      .Parameters.Append .CreateParameter("@N1", adInteger, adParamInput, vbNull, CLng(brRec.N1))
      .Parameters.Append .CreateParameter("@N2", adInteger, adParamInput, vbNull, CLng(brRec.N2))
      .Parameters.Append .CreateParameter("@N3", adInteger, adParamInput, vbNull, CLng(brRec.N3))
      .Parameters.Append .CreateParameter("@N4", adInteger, adParamInput, vbNull, CLng(brRec.N4))
      .Parameters.Append .CreateParameter("@N5", adInteger, adParamInput, vbNull, CLng(brRec.N5))
      .Parameters.Append .CreateParameter("@L1", adUnsignedTinyInt, adParamInput, vbNull, CByte(brRec.L1))
      .Parameters.Append .CreateParameter("@L2", adUnsignedTinyInt, adParamInput, vbNull, CByte(brRec.L2))
      .Parameters.Append .CreateParameter("@L3", adUnsignedTinyInt, adParamInput, vbNull, CByte(brRec.L3))
      .Parameters.Append .CreateParameter("@L4", adUnsignedTinyInt, adParamInput, vbNull, CByte(brRec.L4))
      .Parameters.Append .CreateParameter("@L5", adUnsignedTinyInt, adParamInput, vbNull, CByte(brRec.L5))
      .Parameters.Append .CreateParameter("@L6", adUnsignedTinyInt, adParamInput, vbNull, CByte(brRec.L6))
      .Parameters.Append .CreateParameter("@L7", adUnsignedTinyInt, adParamInput, vbNull, CByte(brRec.L7))
      .Parameters.Append .CreateParameter("@L8", adUnsignedTinyInt, adParamInput, vbNull, CByte(brRec.L8))
      .Parameters.Append .CreateParameter("@L9", adUnsignedTinyInt, adParamInput, vbNull, CByte(brRec.L9))
      .Parameters.Append .CreateParameter("@L10", adUnsignedTinyInt, adParamInput, vbNull, CByte(brRec.L10))
      .Parameters.Append .CreateParameter("@Y1", adSmallInt, adParamInput, vbNull, CInt(brRec.Y1))
      .Parameters.Append .CreateParameter("@Y2", adSmallInt, adParamInput, vbNull, CInt(brRec.Y2))
      .Parameters.Append .CreateParameter("@Y3", adSmallInt, adParamInput, vbNull, CInt(brRec.Y3))
      .Parameters.Append .CreateParameter("@Y4", adSmallInt, adParamInput, vbNull, CInt(brRec.Y4))
      .Parameters.Append .CreateParameter("@Y5", adSmallInt, adParamInput, vbNull, CInt(brRec.Y5))
      .Parameters.Append .CreateParameter("@Y6", adSmallInt, adParamInput, vbNull, CInt(brRec.Y6))
      .Parameters.Append .CreateParameter("@Y7", adSmallInt, adParamInput, vbNull, CInt(brRec.Y7))
      .Parameters.Append .CreateParameter("@Y8", adSmallInt, adParamInput, vbNull, CInt(brRec.Y8))
      .Parameters.Append .CreateParameter("@Y9", adSmallInt, adParamInput, vbNull, CInt(brRec.Y9))
      .Parameters.Append .CreateParameter("@Y10", adSmallInt, adParamInput, vbNull, CInt(brRec.Y10))
      .Parameters.Append .CreateParameter("@D1", adDate, adParamInput, vbNull, CDate(brRec.D1))
      .Parameters.Append .CreateParameter("@D2", adDate, adParamInput, vbNull, CDate(brRec.D2))
      .Parameters.Append .CreateParameter("@D3", adDate, adParamInput, vbNull, CDate(brRec.D3))
      .Parameters.Append .CreateParameter("@D4", adDate, adParamInput, vbNull, CDate(brRec.D4))
      .Parameters.Append .CreateParameter("@D5", adDate, adParamInput, vbNull, CDate(brRec.D5))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_BarterAd_Update"

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
   ByRef brRec As tBarterAdType, _ 
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
         .BarterAdID = moUtil.EditLong(.BarterAdID, "BarterAdID", True, , 1) 
      End If
      .ConsumerID = moUtil.EditLong(.ConsumerID, "ConsumerID", False) 
      .BarterArea1ID = moUtil.EditLong(.BarterArea1ID, "BarterArea1ID", False) 
      .BarterArea2ID = moUtil.EditLong(.BarterArea2ID, "BarterArea2ID", False) 
      .BarterCategoryID = moUtil.EditLong(.BarterCategoryID, "BarterCategoryID", False) 
      .Title = moUtil.EditString(.Title, "Title", False) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .PostDate = moUtil.EditDate(.PostDate, "PostDate", False) 
      .UpdateDate = moUtil.EditDate(.UpdateDate, "UpdateDate", False) 
      .EndDate = moUtil.EditDate(.EndDate, "EndDate", False) 
      .Price = moUtil.EditCurrency(.Price, "Price", False) 
      .Location = moUtil.EditString(.Location, "Location", False) 
      .Zip = moUtil.EditString(.Zip, "Zip", False) 
      .Description = moUtil.EditString(.Description, "Description", False, , 1, 4000) 
      .Language = moUtil.EditString(.Language, "Language", False) 
      .ContactName = moUtil.EditString(.ContactName, "ContactName", False) 
      .ContactEmail = moUtil.EditString(.ContactEmail, "ContactEmail", False) 
      .ContactPhone = moUtil.EditString(.ContactPhone, "ContactPhone", False) 
      .IsEmail = moUtil.EditInteger(.IsEmail, "IsEmail", False, 0, 0, 1) 
      .IsPhone = moUtil.EditInteger(.IsPhone, "IsPhone", False, 0, 0, 1) 
      .IsText = moUtil.EditInteger(.IsText, "IsText", False, 0, 0, 1) 
      .IsMore = moUtil.EditInteger(.IsMore, "IsMore", False, 0, 0, 1) 
      .IsMap = moUtil.EditInteger(.IsMap, "IsMap", False, 0, 0, 1) 
      .IsContact = moUtil.EditInteger(.IsContact, "IsContact", False, 0, 0, 1) 
      .IsDealer = moUtil.EditInteger(.IsDealer, "IsDealer", False, 0, 0, 1) 
      .MapStreet1 = moUtil.EditString(.MapStreet1, "MapStreet1", False, , 1, 60) 
      .MapStreet2 = moUtil.EditString(.MapStreet2, "MapStreet2", False, , 1, 60) 
      .MapCity = moUtil.EditString(.MapCity, "MapCity", False, , 1, 30) 
      .MapZip = moUtil.EditString(.MapZip, "MapZip", False, , 1, 10) 
      .Options = moUtil.EditString(.Options, "Options", False, , 1, 20) 
      .Payments = moUtil.EditString(.Payments, "Payments", False, , 1, 20) 
      .Condition = moUtil.EditLong(.Condition, "Condition", False) 
      .Images = moUtil.EditLong(.Images, "Images", False) 
      .GeoCode = moUtil.EditString(.GeoCode, "GeoCode", False, , 1, 30) 
      .T1 = moUtil.EditString(.T1, "T1", False, , 1, 40) 
      .T2 = moUtil.EditString(.T2, "T2", False, , 1, 40) 
      .T3 = moUtil.EditString(.T3, "T3", False, , 1, 40) 
      .T4 = moUtil.EditString(.T4, "T4", False, , 1, 40) 
      .T5 = moUtil.EditString(.T5, "T5", False, , 1, 40) 
      .N1 = moUtil.EditLong(.N1, "N1", False) 
      .N2 = moUtil.EditLong(.N2, "N2", False) 
      .N3 = moUtil.EditLong(.N3, "N3", False) 
      .N4 = moUtil.EditLong(.N4, "N4", False) 
      .N5 = moUtil.EditLong(.N5, "N5", False) 
      .L1 = moUtil.EditByte(.L1, "L1", False) 
      .L2 = moUtil.EditByte(.L2, "L2", False) 
      .L3 = moUtil.EditByte(.L3, "L3", False) 
      .L4 = moUtil.EditByte(.L4, "L4", False) 
      .L5 = moUtil.EditByte(.L5, "L5", False) 
      .L6 = moUtil.EditByte(.L6, "L6", False) 
      .L7 = moUtil.EditByte(.L7, "L7", False) 
      .L8 = moUtil.EditByte(.L8, "L8", False) 
      .L9 = moUtil.EditByte(.L9, "L9", False) 
      .L10 = moUtil.EditByte(.L10, "L10", False) 
      .Y1 = moUtil.EditInteger(.Y1, "Y1", False, 0, 0, 1) 
      .Y2 = moUtil.EditInteger(.Y2, "Y2", False, 0, 0, 1) 
      .Y3 = moUtil.EditInteger(.Y3, "Y3", False, 0, 0, 1) 
      .Y4 = moUtil.EditInteger(.Y4, "Y4", False, 0, 0, 1) 
      .Y5 = moUtil.EditInteger(.Y5, "Y5", False, 0, 0, 1) 
      .Y6 = moUtil.EditInteger(.Y6, "Y6", False, 0, 0, 1) 
      .Y7 = moUtil.EditInteger(.Y7, "Y7", False, 0, 0, 1) 
      .Y8 = moUtil.EditInteger(.Y8, "Y8", False, 0, 0, 1) 
      .Y9 = moUtil.EditInteger(.Y9, "Y9", False, 0, 0, 1) 
      .Y10 = moUtil.EditInteger(.Y10, "Y10", False, 0, 0, 1) 
      .D1 = moUtil.EditDate(.D1, "D1", False) 
      .D2 = moUtil.EditDate(.D2, "D2", False) 
      .D3 = moUtil.EditDate(.D3, "D3", False) 
      .D4 = moUtil.EditDate(.D4, "D4", False) 
      .D5 = moUtil.EditDate(.D5, "D5", False) 
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