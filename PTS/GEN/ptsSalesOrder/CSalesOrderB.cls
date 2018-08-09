VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CSalesOrderB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CSalesOrder"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tSalesOrderType
   SalesOrderID As String
   CompanyID As String
   MemberID As String
   ProspectID As String
   AffiliateID As String
   PromotionID As String
   PartyID As String
   AddressID As String
   NameLast As String
   NameFirst As String
   MemberName As String
   ProspectName As String
   PromotionName As String
   OrderDate As String
   Amount As String
   Tax As String
   Total As String
   Status As String
   Notes As String
   Discount As String
   Shipping As String
   Ship As String
   IsTaxable As String
   IsRecur As String
   PinnDate As String
   PinnAmount As String
   CommDate As String
   CommAmount As String
   AutoShip As String
   IsActive As String
   BV As String
   Track As String
   Valid As String
   Result As String
   Quantity As String
   ReportFromDate As String
   ReportToDate As String
End Type

Public Sub Add( _ 
   ByRef brRec As tSalesOrderType, _ 
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
      .Parameters.Append .CreateParameter("@SalesOrderID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@ProspectID", adInteger, adParamInput, vbNull, CLng(brRec.ProspectID))
      .Parameters.Append .CreateParameter("@AffiliateID", adInteger, adParamInput, vbNull, CLng(brRec.AffiliateID))
      .Parameters.Append .CreateParameter("@PromotionID", adInteger, adParamInput, vbNull, CLng(brRec.PromotionID))
      .Parameters.Append .CreateParameter("@PartyID", adInteger, adParamInput, vbNull, CLng(brRec.PartyID))
      .Parameters.Append .CreateParameter("@AddressID", adInteger, adParamInput, vbNull, CLng(brRec.AddressID))
      .Parameters.Append .CreateParameter("@OrderDate", adDate, adParamInput, vbNull, CDate(brRec.OrderDate))
      .Parameters.Append .CreateParameter("@Amount", adCurrency, adParamInput, vbNull, CCur(brRec.Amount))
      .Parameters.Append .CreateParameter("@Tax", adCurrency, adParamInput, vbNull, CCur(brRec.Tax))
      .Parameters.Append .CreateParameter("@Total", adCurrency, adParamInput, vbNull, CCur(brRec.Total))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Notes", adVarWChar, adParamInput, 1000, brRec.Notes)
      .Parameters.Append .CreateParameter("@Discount", adCurrency, adParamInput, vbNull, CCur(brRec.Discount))
      .Parameters.Append .CreateParameter("@Shipping", adCurrency, adParamInput, vbNull, CCur(brRec.Shipping))
      .Parameters.Append .CreateParameter("@Ship", adInteger, adParamInput, vbNull, CLng(brRec.Ship))
      .Parameters.Append .CreateParameter("@IsTaxable", adSmallInt, adParamInput, vbNull, CInt(brRec.IsTaxable))
      .Parameters.Append .CreateParameter("@IsRecur", adSmallInt, adParamInput, vbNull, CInt(brRec.IsRecur))
      .Parameters.Append .CreateParameter("@PinnDate", adDate, adParamInput, vbNull, CDate(brRec.PinnDate))
      .Parameters.Append .CreateParameter("@PinnAmount", adCurrency, adParamInput, vbNull, CCur(brRec.PinnAmount))
      .Parameters.Append .CreateParameter("@CommDate", adDate, adParamInput, vbNull, CDate(brRec.CommDate))
      .Parameters.Append .CreateParameter("@CommAmount", adCurrency, adParamInput, vbNull, CCur(brRec.CommAmount))
      .Parameters.Append .CreateParameter("@AutoShip", adInteger, adParamInput, vbNull, CLng(brRec.AutoShip))
      .Parameters.Append .CreateParameter("@IsActive", adSmallInt, adParamInput, vbNull, CInt(brRec.IsActive))
      .Parameters.Append .CreateParameter("@BV", adCurrency, adParamInput, vbNull, CCur(brRec.BV))
      .Parameters.Append .CreateParameter("@Track", adVarWChar, adParamInput, 40, brRec.Track)
      .Parameters.Append .CreateParameter("@Valid", adInteger, adParamInput, vbNull, CLng(brRec.Valid))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesOrder_Add"

   '-----get return values
   With brRec
      .SalesOrderID = moUtil.FetchLong(oCmd.Parameters.Item("@SalesOrderID").Value)
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

Public Function GetPromotion( _ 
   ByRef brRec As tSalesOrderType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "GetPromotion"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SalesOrderID", adInteger, adParamInput, vbNull, CLng(brRec.SalesOrderID))
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamInput, 30, brRec.NameLast)
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesOrder_GetPromotion"

   '-----get return values
   GetPromotion = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function ProductEmails( _ 
   ByRef brRec As tSalesOrderType, _ 
   ByVal bvUserID As Long) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ProductEmails"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SalesOrderID", adInteger, adParamInput, vbNull, CLng(brRec.SalesOrderID))
      .Parameters.Append .CreateParameter("@Result", adVarWChar, adParamOutput, 500, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesOrder_ProductEmails"

   '-----get return values
   ProductEmails = moUtil.FetchString(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function ProductFulfillment( _ 
   ByRef brRec As tSalesOrderType, _ 
   ByVal bvUserID As Long) As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ProductFulfillment"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SalesOrderID", adInteger, adParamInput, vbNull, CLng(brRec.SalesOrderID))
      .Parameters.Append .CreateParameter("@Quantity", adInteger, adParamInput, vbNull, CLng(brRec.Quantity))
      .Parameters.Append .CreateParameter("@Result", adVarWChar, adParamOutput, 500, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesOrder_ProductFulfillment"

   '-----get return values
   ProductFulfillment = moUtil.FetchString(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function GetShipping( _ 
   ByRef brRec As tSalesOrderType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "GetShipping"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SalesOrderID", adInteger, adParamInput, vbNull, CLng(brRec.SalesOrderID))
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesOrder_GetShipping"

   '-----get return values
   GetShipping = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function UpdateRecurring( _ 
   ByRef brRec As tSalesOrderType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "UpdateRecurring"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@OrderDate", adDate, adParamInput, vbNull, CDate(brRec.OrderDate))
      .Parameters.Append .CreateParameter("@SalesOrderID", adInteger, adParamInput, vbNull, CLng(brRec.SalesOrderID))
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesOrder_UpdateRecurring"

   '-----get return values
   UpdateRecurring = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function SetAutoShip( _ 
   ByRef brRec As tSalesOrderType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "SetAutoShip"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@SalesOrderID", adInteger, adParamInput, vbNull, CLng(brRec.SalesOrderID))
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesOrder_SetAutoShip"

   '-----get return values
   SetAutoShip = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Sub Custom( _ 
   ByRef brRec As tSalesOrderType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Execute a Command
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Custom"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@SalesOrderID", adInteger, adParamInput, vbNull, CLng(brRec.SalesOrderID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesOrder_Custom"

   '-----clean up
   Set oCmd = Nothing

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub Custom2( _ 
   ByRef brRec As tSalesOrderType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Execute a Command
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Custom2"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@OrderDate", adDate, adParamInput, vbNull, CDate(brRec.OrderDate))
      .Parameters.Append .CreateParameter("@Quantity", adInteger, adParamInput, vbNull, CLng(brRec.Quantity))
      .Parameters.Append .CreateParameter("@Amount", adCurrency, adParamInput, vbNull, CCur(brRec.Amount))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesOrder_Custom2"

   '-----clean up
   Set oCmd = Nothing

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub DeleteAbandoned( _ 
   ByRef brRec As tSalesOrderType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Execute a Command
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "DeleteAbandoned"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesOrder_DeleteAbandoned"

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
   ByRef brRec As tSalesOrderType, _ 
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
      .SalesOrderID = moUtil.EditLong(.SalesOrderID, "SalesOrderID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SalesOrderID", adInteger, adParamInput, vbNull, CLng(brRec.SalesOrderID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesOrder_Delete"

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
   ByRef brRec As tSalesOrderType, _ 
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
      .SalesOrderID = moUtil.EditLong(.SalesOrderID, "SalesOrderID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SalesOrderID", adInteger, adParamInput, vbNull, CLng(brRec.SalesOrderID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ProspectID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AffiliateID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PromotionID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PartyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AddressID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@MemberName", adVarWChar, adParamOutput, 62, vbNull)
      .Parameters.Append .CreateParameter("@ProspectName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@PromotionName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@OrderDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Amount", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Tax", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Total", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Notes", adVarWChar, adParamOutput, 1000, vbNull)
      .Parameters.Append .CreateParameter("@Discount", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Shipping", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Ship", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsTaxable", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsRecur", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PinnDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PinnAmount", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CommDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CommAmount", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@AutoShip", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsActive", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BV", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Track", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@Valid", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesOrder_Fetch"

   '-----get return values
   With brRec
      .CompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@CompanyID").Value)
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .ProspectID = moUtil.FetchLong(oCmd.Parameters.Item("@ProspectID").Value)
      .AffiliateID = moUtil.FetchLong(oCmd.Parameters.Item("@AffiliateID").Value)
      .PromotionID = moUtil.FetchLong(oCmd.Parameters.Item("@PromotionID").Value)
      .PartyID = moUtil.FetchLong(oCmd.Parameters.Item("@PartyID").Value)
      .AddressID = moUtil.FetchLong(oCmd.Parameters.Item("@AddressID").Value)
      .NameLast = moUtil.FetchString(oCmd.Parameters.Item("@NameLast").Value)
      .NameFirst = moUtil.FetchString(oCmd.Parameters.Item("@NameFirst").Value)
      .MemberName = moUtil.FetchString(oCmd.Parameters.Item("@MemberName").Value)
      .ProspectName = moUtil.FetchString(oCmd.Parameters.Item("@ProspectName").Value)
      .PromotionName = moUtil.FetchString(oCmd.Parameters.Item("@PromotionName").Value)
      .OrderDate = moUtil.FetchDate(oCmd.Parameters.Item("@OrderDate").Value)
      .Amount = moUtil.FetchCurrency(oCmd.Parameters.Item("@Amount").Value)
      .Tax = moUtil.FetchCurrency(oCmd.Parameters.Item("@Tax").Value)
      .Total = moUtil.FetchCurrency(oCmd.Parameters.Item("@Total").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .Notes = moUtil.FetchString(oCmd.Parameters.Item("@Notes").Value)
      .Discount = moUtil.FetchCurrency(oCmd.Parameters.Item("@Discount").Value)
      .Shipping = moUtil.FetchCurrency(oCmd.Parameters.Item("@Shipping").Value)
      .Ship = moUtil.FetchLong(oCmd.Parameters.Item("@Ship").Value)
      .IsTaxable = moUtil.FetchInteger(oCmd.Parameters.Item("@IsTaxable").Value)
      .IsRecur = moUtil.FetchInteger(oCmd.Parameters.Item("@IsRecur").Value)
      .PinnDate = moUtil.FetchDate(oCmd.Parameters.Item("@PinnDate").Value)
      .PinnAmount = moUtil.FetchCurrency(oCmd.Parameters.Item("@PinnAmount").Value)
      .CommDate = moUtil.FetchDate(oCmd.Parameters.Item("@CommDate").Value)
      .CommAmount = moUtil.FetchCurrency(oCmd.Parameters.Item("@CommAmount").Value)
      .AutoShip = moUtil.FetchLong(oCmd.Parameters.Item("@AutoShip").Value)
      .IsActive = moUtil.FetchInteger(oCmd.Parameters.Item("@IsActive").Value)
      .BV = moUtil.FetchCurrency(oCmd.Parameters.Item("@BV").Value)
      .Track = moUtil.FetchString(oCmd.Parameters.Item("@Track").Value)
      .Valid = moUtil.FetchLong(oCmd.Parameters.Item("@Valid").Value)
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
   Optional ByVal bvSecurityToken As Long = 0) As tSalesOrderType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSalesOrderType
   Dim vRec As tSalesOrderType
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
      Case cptsSalesOrderFindOrderDate
         sProc = "pts_SalesOrder_FindOrderDate"
         MaxBookMark = 30
      Case cptsSalesOrderFindMemberName
         sProc = "pts_SalesOrder_FindMemberName"
         MaxBookMark = 72
      Case cptsSalesOrderFindProspectName
         sProc = "pts_SalesOrder_FindProspectName"
         MaxBookMark = 70
      Case cptsSalesOrderFindSalesOrderID
         sProc = "pts_SalesOrder_FindSalesOrderID"
         MaxBookMark = 20
      Case cptsSalesOrderFindAffiliateID
         sProc = "pts_SalesOrder_FindAffiliateID"
         MaxBookMark = 20
      Case cptsSalesOrderFindPromotionID
         sProc = "pts_SalesOrder_FindPromotionID"
         MaxBookMark = 20
      Case cptsSalesOrderFindAmount
         sProc = "pts_SalesOrder_FindAmount"
         MaxBookMark = 30
      Case cptsSalesOrderFindPinnAmount
         sProc = "pts_SalesOrder_FindPinnAmount"
         MaxBookMark = 30
      Case cptsSalesOrderFindCommAmount
         sProc = "pts_SalesOrder_FindCommAmount"
         MaxBookMark = 30
      Case cptsSalesOrderFindNotes
         sProc = "pts_SalesOrder_FindNotes"
         MaxBookMark = 1010
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
               vRec.SalesOrderID = moUtil.FetchLong(.Fields.Item("SalesOrderID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
               vRec.AffiliateID = moUtil.FetchLong(.Fields.Item("AffiliateID").Value)
               vRec.PromotionID = moUtil.FetchLong(.Fields.Item("PromotionID").Value)
               vRec.PartyID = moUtil.FetchLong(.Fields.Item("PartyID").Value)
               vRec.AddressID = moUtil.FetchLong(.Fields.Item("AddressID").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
               vRec.PromotionName = moUtil.FetchString(.Fields.Item("PromotionName").Value)
               vRec.OrderDate = moUtil.FetchDate(.Fields.Item("OrderDate").Value)
               vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
               vRec.Tax = moUtil.FetchCurrency(.Fields.Item("Tax").Value)
               vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
               vRec.Discount = moUtil.FetchCurrency(.Fields.Item("Discount").Value)
               vRec.Shipping = moUtil.FetchCurrency(.Fields.Item("Shipping").Value)
               vRec.Ship = moUtil.FetchLong(.Fields.Item("Ship").Value)
               vRec.IsTaxable = moUtil.FetchInteger(.Fields.Item("IsTaxable").Value)
               vRec.IsRecur = moUtil.FetchInteger(.Fields.Item("IsRecur").Value)
               vRec.PinnDate = moUtil.FetchDate(.Fields.Item("PinnDate").Value)
               vRec.PinnAmount = moUtil.FetchCurrency(.Fields.Item("PinnAmount").Value)
               vRec.CommDate = moUtil.FetchDate(.Fields.Item("CommDate").Value)
               vRec.CommAmount = moUtil.FetchCurrency(.Fields.Item("CommAmount").Value)
               vRec.AutoShip = moUtil.FetchLong(.Fields.Item("AutoShip").Value)
               vRec.IsActive = moUtil.FetchInteger(.Fields.Item("IsActive").Value)
               vRec.BV = moUtil.FetchCurrency(.Fields.Item("BV").Value)
               vRec.Track = moUtil.FetchString(.Fields.Item("Track").Value)
               vRec.Valid = moUtil.FetchLong(.Fields.Item("Valid").Value)
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
   ByVal bvCompanyID As Long, _ 
   ByVal bvStatus As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tSalesOrderType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindStatus"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSalesOrderType
   Dim vRec As tSalesOrderType
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
      Case cptsSalesOrderFindOrderDate
         sProc = "pts_SalesOrder_FindStatusOrderDate"
         MaxBookMark = 30
      Case cptsSalesOrderFindMemberName
         sProc = "pts_SalesOrder_FindStatusMemberName"
         MaxBookMark = 72
      Case cptsSalesOrderFindProspectName
         sProc = "pts_SalesOrder_FindStatusProspectName"
         MaxBookMark = 70
      Case cptsSalesOrderFindSalesOrderID
         sProc = "pts_SalesOrder_FindStatusSalesOrderID"
         MaxBookMark = 20
      Case cptsSalesOrderFindAffiliateID
         sProc = "pts_SalesOrder_FindStatusAffiliateID"
         MaxBookMark = 20
      Case cptsSalesOrderFindPromotionID
         sProc = "pts_SalesOrder_FindStatusPromotionID"
         MaxBookMark = 20
      Case cptsSalesOrderFindAmount
         sProc = "pts_SalesOrder_FindStatusAmount"
         MaxBookMark = 30
      Case cptsSalesOrderFindPinnAmount
         sProc = "pts_SalesOrder_FindStatusPinnAmount"
         MaxBookMark = 30
      Case cptsSalesOrderFindCommAmount
         sProc = "pts_SalesOrder_FindStatusCommAmount"
         MaxBookMark = 30
      Case cptsSalesOrderFindNotes
         sProc = "pts_SalesOrder_FindStatusNotes"
         MaxBookMark = 1010
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
               vRec.SalesOrderID = moUtil.FetchLong(.Fields.Item("SalesOrderID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
               vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
               vRec.AffiliateID = moUtil.FetchLong(.Fields.Item("AffiliateID").Value)
               vRec.PromotionID = moUtil.FetchLong(.Fields.Item("PromotionID").Value)
               vRec.PartyID = moUtil.FetchLong(.Fields.Item("PartyID").Value)
               vRec.AddressID = moUtil.FetchLong(.Fields.Item("AddressID").Value)
               vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
               vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
               vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
               vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
               vRec.PromotionName = moUtil.FetchString(.Fields.Item("PromotionName").Value)
               vRec.OrderDate = moUtil.FetchDate(.Fields.Item("OrderDate").Value)
               vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
               vRec.Tax = moUtil.FetchCurrency(.Fields.Item("Tax").Value)
               vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
               vRec.Discount = moUtil.FetchCurrency(.Fields.Item("Discount").Value)
               vRec.Shipping = moUtil.FetchCurrency(.Fields.Item("Shipping").Value)
               vRec.Ship = moUtil.FetchLong(.Fields.Item("Ship").Value)
               vRec.IsTaxable = moUtil.FetchInteger(.Fields.Item("IsTaxable").Value)
               vRec.IsRecur = moUtil.FetchInteger(.Fields.Item("IsRecur").Value)
               vRec.PinnDate = moUtil.FetchDate(.Fields.Item("PinnDate").Value)
               vRec.PinnAmount = moUtil.FetchCurrency(.Fields.Item("PinnAmount").Value)
               vRec.CommDate = moUtil.FetchDate(.Fields.Item("CommDate").Value)
               vRec.CommAmount = moUtil.FetchCurrency(.Fields.Item("CommAmount").Value)
               vRec.AutoShip = moUtil.FetchLong(.Fields.Item("AutoShip").Value)
               vRec.IsActive = moUtil.FetchInteger(.Fields.Item("IsActive").Value)
               vRec.BV = moUtil.FetchCurrency(.Fields.Item("BV").Value)
               vRec.Track = moUtil.FetchString(.Fields.Item("Track").Value)
               vRec.Valid = moUtil.FetchLong(.Fields.Item("Valid").Value)
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

Public Function ListDate( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvOrderDate As Date) As tSalesOrderType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListDate"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSalesOrderType
   Dim vRec As tSalesOrderType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvCompanyID = moUtil.EditLong(bvCompanyID, "CompanyID", True, 0) 
      bvOrderDate = moUtil.EditDate(bvOrderDate, "OrderDate", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@OrderDate", adDate, adParamInput, vbNull, CDate(bvOrderDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesOrder_ListDate")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SalesOrderID = moUtil.FetchLong(.Fields.Item("SalesOrderID").Value)
            vRec.OrderDate = moUtil.FetchDate(.Fields.Item("OrderDate").Value)
            vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
            vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
            vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
            vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListDate = vRecs

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

Public Function ListMember( _ 
   ByVal bvMemberID As Long) As tSalesOrderType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSalesOrderType
   Dim vRec As tSalesOrderType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesOrder_ListMember")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SalesOrderID = moUtil.FetchLong(.Fields.Item("SalesOrderID").Value)
            vRec.OrderDate = moUtil.FetchDate(.Fields.Item("OrderDate").Value)
            vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
            vRec.BV = moUtil.FetchCurrency(.Fields.Item("BV").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
            vRec.IsRecur = moUtil.FetchInteger(.Fields.Item("IsRecur").Value)
            vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
            vRec.ProspectName = moUtil.FetchString(.Fields.Item("ProspectName").Value)
            vRec.Track = moUtil.FetchString(.Fields.Item("Track").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListMember = vRecs

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

Public Function ListParty( _ 
   ByVal bvPartyID As Long) As tSalesOrderType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListParty"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSalesOrderType
   Dim vRec As tSalesOrderType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvPartyID = moUtil.EditLong(bvPartyID, "PartyID", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@PartyID", adInteger, adParamInput, vbNull, CLng(bvPartyID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesOrder_ListParty")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SalesOrderID = moUtil.FetchLong(.Fields.Item("SalesOrderID").Value)
            vRec.OrderDate = moUtil.FetchDate(.Fields.Item("OrderDate").Value)
            vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
            vRec.BV = moUtil.FetchCurrency(.Fields.Item("BV").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
            vRec.IsRecur = moUtil.FetchInteger(.Fields.Item("IsRecur").Value)
            vRec.ProspectID = moUtil.FetchLong(.Fields.Item("ProspectID").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListParty = vRecs

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

Public Function ListProspect( _ 
   ByVal bvProspectID As Long) As tSalesOrderType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListProspect"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSalesOrderType
   Dim vRec As tSalesOrderType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvProspectID = moUtil.EditLong(bvProspectID, "ProspectID", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProspectID", adInteger, adParamInput, vbNull, CLng(bvProspectID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesOrder_ListProspect")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SalesOrderID = moUtil.FetchLong(.Fields.Item("SalesOrderID").Value)
            vRec.OrderDate = moUtil.FetchDate(.Fields.Item("OrderDate").Value)
            vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
            vRec.BV = moUtil.FetchCurrency(.Fields.Item("BV").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
            vRec.IsRecur = moUtil.FetchInteger(.Fields.Item("IsRecur").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListProspect = vRecs

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

Public Function ListAutoShip( _ 
   ByVal bvMemberID As Long) As tSalesOrderType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListAutoShip"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSalesOrderType
   Dim vRec As tSalesOrderType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesOrder_ListAutoShip")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SalesOrderID = moUtil.FetchLong(.Fields.Item("SalesOrderID").Value)
            vRec.OrderDate = moUtil.FetchDate(.Fields.Item("OrderDate").Value)
            vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
            vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
            vRec.IsActive = moUtil.FetchInteger(.Fields.Item("IsActive").Value)
            vRec.Valid = moUtil.FetchLong(.Fields.Item("Valid").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListAutoShip = vRecs

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

Public Function ListPromotion( _ 
   ByVal bvPromotionID As Long) As tSalesOrderType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListPromotion"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSalesOrderType
   Dim vRec As tSalesOrderType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvPromotionID = moUtil.EditLong(bvPromotionID, "PromotionID", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@PromotionID", adInteger, adParamInput, vbNull, CLng(bvPromotionID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesOrder_ListPromotion")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SalesOrderID = moUtil.FetchLong(.Fields.Item("SalesOrderID").Value)
            vRec.OrderDate = moUtil.FetchDate(.Fields.Item("OrderDate").Value)
            vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
            vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
            vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
            vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListPromotion = vRecs

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
   ByVal bvCompanyID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date) As tSalesOrderType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportCompany"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSalesOrderType
   Dim vRec As tSalesOrderType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvCompanyID = moUtil.EditLong(bvCompanyID, "CompanyID", True, 0) 
      bvReportFromDate = moUtil.EditDate(bvReportFromDate, "ReportFromDate", True, 0) 
      bvReportToDate = moUtil.EditDate(bvReportToDate, "ReportToDate", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(bvReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(bvReportToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesOrder_ReportCompany")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SalesOrderID = moUtil.FetchLong(.Fields.Item("SalesOrderID").Value)
            vRec.OrderDate = moUtil.FetchDate(.Fields.Item("OrderDate").Value)
            vRec.MemberID = moUtil.FetchLong(.Fields.Item("MemberID").Value)
            vRec.MemberName = moUtil.FetchString(.Fields.Item("MemberName").Value)
            vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
            vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
            vRec.Shipping = moUtil.FetchCurrency(.Fields.Item("Shipping").Value)
            vRec.Tax = moUtil.FetchCurrency(.Fields.Item("Tax").Value)
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

Public Function ReportAffiliate( _ 
   ByVal bvAffiliateID As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date) As tSalesOrderType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReportAffiliate"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSalesOrderType
   Dim vRec As tSalesOrderType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvAffiliateID = moUtil.EditLong(bvAffiliateID, "AffiliateID", True, 0) 
      bvReportFromDate = moUtil.EditDate(bvReportFromDate, "ReportFromDate", True, 0) 
      bvReportToDate = moUtil.EditDate(bvReportToDate, "ReportToDate", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AffiliateID", adInteger, adParamInput, vbNull, CLng(bvAffiliateID))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(bvReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(bvReportToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesOrder_ReportAffiliate")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SalesOrderID = moUtil.FetchLong(.Fields.Item("SalesOrderID").Value)
            vRec.OrderDate = moUtil.FetchDate(.Fields.Item("OrderDate").Value)
            vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
            vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
            vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
            vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
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

Public Function CustomList( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvStatus As Long, _ 
   ByVal bvOrderDate As Date, _ 
   ByVal bvQuantity As Long, _ 
   ByVal bvAmount As Currency) As tSalesOrderType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CustomList"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSalesOrderType
   Dim vRec As tSalesOrderType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
      .Parameters.Append .CreateParameter("@OrderDate", adDate, adParamInput, vbNull, CDate(bvOrderDate))
      .Parameters.Append .CreateParameter("@Quantity", adInteger, adParamInput, vbNull, CLng(bvQuantity))
      .Parameters.Append .CreateParameter("@Amount", adCurrency, adParamInput, vbNull, CCur(bvAmount))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesOrder_CustomList")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SalesOrderID = moUtil.FetchLong(.Fields.Item("SalesOrderID").Value)
            vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
            vRec.Result = moUtil.FetchString(.Fields.Item("Result").Value)
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

Public Function CustomList2( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvStatus As Long, _ 
   ByVal bvReportFromDate As Date, _ 
   ByVal bvReportToDate As Date, _ 
   ByVal bvQuantity As Long, _ 
   ByVal bvAmount As Currency) As tSalesOrderType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CustomList2"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSalesOrderType
   Dim vRec As tSalesOrderType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(bvStatus))
      .Parameters.Append .CreateParameter("@ReportFromDate", adDate, adParamInput, vbNull, CDate(bvReportFromDate))
      .Parameters.Append .CreateParameter("@ReportToDate", adDate, adParamInput, vbNull, CDate(bvReportToDate))
      .Parameters.Append .CreateParameter("@Quantity", adInteger, adParamInput, vbNull, CLng(bvQuantity))
      .Parameters.Append .CreateParameter("@Amount", adCurrency, adParamInput, vbNull, CCur(bvAmount))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesOrder_CustomList2")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SalesOrderID = moUtil.FetchLong(.Fields.Item("SalesOrderID").Value)
            vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
            vRec.Result = moUtil.FetchString(.Fields.Item("Result").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   CustomList2 = vRecs

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
   ByRef brRec As tSalesOrderType, _ 
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
      .Parameters.Append .CreateParameter("@SalesOrderID", adInteger, adParamInput, vbNull, CLng(brRec.SalesOrderID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@ProspectID", adInteger, adParamInput, vbNull, CLng(brRec.ProspectID))
      .Parameters.Append .CreateParameter("@AffiliateID", adInteger, adParamInput, vbNull, CLng(brRec.AffiliateID))
      .Parameters.Append .CreateParameter("@PromotionID", adInteger, adParamInput, vbNull, CLng(brRec.PromotionID))
      .Parameters.Append .CreateParameter("@PartyID", adInteger, adParamInput, vbNull, CLng(brRec.PartyID))
      .Parameters.Append .CreateParameter("@AddressID", adInteger, adParamInput, vbNull, CLng(brRec.AddressID))
      .Parameters.Append .CreateParameter("@OrderDate", adDate, adParamInput, vbNull, CDate(brRec.OrderDate))
      .Parameters.Append .CreateParameter("@Amount", adCurrency, adParamInput, vbNull, CCur(brRec.Amount))
      .Parameters.Append .CreateParameter("@Tax", adCurrency, adParamInput, vbNull, CCur(brRec.Tax))
      .Parameters.Append .CreateParameter("@Total", adCurrency, adParamInput, vbNull, CCur(brRec.Total))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Notes", adVarWChar, adParamInput, 1000, brRec.Notes)
      .Parameters.Append .CreateParameter("@Discount", adCurrency, adParamInput, vbNull, CCur(brRec.Discount))
      .Parameters.Append .CreateParameter("@Shipping", adCurrency, adParamInput, vbNull, CCur(brRec.Shipping))
      .Parameters.Append .CreateParameter("@Ship", adInteger, adParamInput, vbNull, CLng(brRec.Ship))
      .Parameters.Append .CreateParameter("@IsTaxable", adSmallInt, adParamInput, vbNull, CInt(brRec.IsTaxable))
      .Parameters.Append .CreateParameter("@IsRecur", adSmallInt, adParamInput, vbNull, CInt(brRec.IsRecur))
      .Parameters.Append .CreateParameter("@PinnDate", adDate, adParamInput, vbNull, CDate(brRec.PinnDate))
      .Parameters.Append .CreateParameter("@PinnAmount", adCurrency, adParamInput, vbNull, CCur(brRec.PinnAmount))
      .Parameters.Append .CreateParameter("@CommDate", adDate, adParamInput, vbNull, CDate(brRec.CommDate))
      .Parameters.Append .CreateParameter("@CommAmount", adCurrency, adParamInput, vbNull, CCur(brRec.CommAmount))
      .Parameters.Append .CreateParameter("@AutoShip", adInteger, adParamInput, vbNull, CLng(brRec.AutoShip))
      .Parameters.Append .CreateParameter("@IsActive", adSmallInt, adParamInput, vbNull, CInt(brRec.IsActive))
      .Parameters.Append .CreateParameter("@BV", adCurrency, adParamInput, vbNull, CCur(brRec.BV))
      .Parameters.Append .CreateParameter("@Track", adVarWChar, adParamInput, 40, brRec.Track)
      .Parameters.Append .CreateParameter("@Valid", adInteger, adParamInput, vbNull, CLng(brRec.Valid))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesOrder_Update"

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
   ByRef brRec As tSalesOrderType, _ 
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
         .SalesOrderID = moUtil.EditLong(.SalesOrderID, "SalesOrderID", True, , 1) 
      End If
      .CompanyID = moUtil.EditLong(.CompanyID, "CompanyID", False) 
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", False) 
      .ProspectID = moUtil.EditLong(.ProspectID, "ProspectID", False) 
      .AffiliateID = moUtil.EditLong(.AffiliateID, "AffiliateID", False) 
      .PromotionID = moUtil.EditLong(.PromotionID, "PromotionID", False) 
      .PartyID = moUtil.EditLong(.PartyID, "PartyID", False) 
      .AddressID = moUtil.EditLong(.AddressID, "AddressID", False) 
      .OrderDate = moUtil.EditDate(.OrderDate, "OrderDate", False) 
      .Amount = moUtil.EditCurrency(.Amount, "Amount", False, , 0, 99999999.99) 
      .Tax = moUtil.EditCurrency(.Tax, "Tax", False, , 0, 999999.99) 
      .Total = moUtil.EditCurrency(.Total, "Total", False, , 0, 99999999.99) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .Notes = moUtil.EditString(.Notes, "Notes", False, , 1, 1000) 
      .Discount = moUtil.EditCurrency(.Discount, "Discount", False, , 0, 999999.99) 
      .Shipping = moUtil.EditCurrency(.Shipping, "Shipping", False, , 0, 999999.99) 
      .Ship = moUtil.EditLong(.Ship, "Ship", False) 
      .IsTaxable = moUtil.EditInteger(.IsTaxable, "IsTaxable", False, 0, 0, 1) 
      .IsRecur = moUtil.EditInteger(.IsRecur, "IsRecur", False, 0, 0, 1) 
      .PinnDate = moUtil.EditDate(.PinnDate, "PinnDate", False) 
      .PinnAmount = moUtil.EditCurrency(.PinnAmount, "PinnAmount", False, , 0, 999999.99) 
      .CommDate = moUtil.EditDate(.CommDate, "CommDate", False) 
      .CommAmount = moUtil.EditCurrency(.CommAmount, "CommAmount", False, , 0, 999999.99) 
      .AutoShip = moUtil.EditLong(.AutoShip, "AutoShip", False) 
      .IsActive = moUtil.EditInteger(.IsActive, "IsActive", False, 0, 0, 1) 
      .BV = moUtil.EditCurrency(.BV, "BV", False, , 0, 99999999.99) 
      .Track = moUtil.EditString(.Track, "Track", False, , 1, 40) 
      .Valid = moUtil.EditLong(.Valid, "Valid", False) 
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