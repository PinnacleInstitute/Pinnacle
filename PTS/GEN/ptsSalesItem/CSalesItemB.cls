VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CSalesItemB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CSalesItem"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tSalesItemType
   SalesItemID As String
   SalesOrderID As String
   ProductID As String
   CompanyID As String
   OrderDate As String
   ProductName As String
   Image As String
   InputOptions As String
   Quantity As String
   Price As String
   OptionPrice As String
   Tax As String
   InputValues As String
   Reference As String
   Status As String
   BillDate As String
   EndDate As String
   Locks As String
   BV As String
   Valid As String
   Invalid As String
End Type

Public Sub Add( _ 
   ByRef brRec As tSalesItemType, _ 
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
      .Parameters.Append .CreateParameter("@SalesItemID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@SalesOrderID", adInteger, adParamInput, vbNull, CLng(brRec.SalesOrderID))
      .Parameters.Append .CreateParameter("@ProductID", adInteger, adParamInput, vbNull, CLng(brRec.ProductID))
      .Parameters.Append .CreateParameter("@Quantity", adInteger, adParamInput, vbNull, CLng(brRec.Quantity))
      .Parameters.Append .CreateParameter("@Price", adCurrency, adParamInput, vbNull, CCur(brRec.Price))
      .Parameters.Append .CreateParameter("@OptionPrice", adCurrency, adParamInput, vbNull, CCur(brRec.OptionPrice))
      .Parameters.Append .CreateParameter("@Tax", adCurrency, adParamInput, vbNull, CCur(brRec.Tax))
      .Parameters.Append .CreateParameter("@InputValues", adVarWChar, adParamInput, 500, brRec.InputValues)
      .Parameters.Append .CreateParameter("@Reference", adVarWChar, adParamInput, 50, brRec.Reference)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@BillDate", adDate, adParamInput, vbNull, CDate(brRec.BillDate))
      .Parameters.Append .CreateParameter("@EndDate", adDate, adParamInput, vbNull, CDate(brRec.EndDate))
      .Parameters.Append .CreateParameter("@Locks", adInteger, adParamInput, vbNull, CLng(brRec.Locks))
      .Parameters.Append .CreateParameter("@BV", adCurrency, adParamInput, vbNull, CCur(brRec.BV))
      .Parameters.Append .CreateParameter("@Valid", adInteger, adParamInput, vbNull, CLng(brRec.Valid))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesItem_Add"

   '-----get return values
   With brRec
      .SalesItemID = moUtil.FetchLong(oCmd.Parameters.Item("@SalesItemID").Value)
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

Public Function DuplicateProduct( _ 
   ByRef brRec As tSalesItemType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "DuplicateProduct"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .SalesOrderID = moUtil.EditLong(.SalesOrderID, "SalesOrderID", True, 0, 1) 
      .ProductID = moUtil.EditLong(.ProductID, "ProductID", True, 0, 1) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SalesOrderID", adInteger, adParamInput, vbNull, CLng(brRec.SalesOrderID))
      .Parameters.Append .CreateParameter("@ProductID", adInteger, adParamInput, vbNull, CLng(brRec.ProductID))
      .Parameters.Append .CreateParameter("@SalesItemID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesItem_DuplicateProduct"

   '-----get return values
   DuplicateProduct = moUtil.FetchLong(oCmd.Parameters.Item("@SalesItemID").Value)

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
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesItem_Count"

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
   ByRef brRec As tSalesItemType, _ 
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
      .SalesItemID = moUtil.EditLong(.SalesItemID, "SalesItemID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SalesItemID", adInteger, adParamInput, vbNull, CLng(brRec.SalesItemID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesItem_Delete"

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
   ByRef brRec As tSalesItemType, _ 
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
      .SalesItemID = moUtil.EditLong(.SalesItemID, "SalesItemID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SalesItemID", adInteger, adParamInput, vbNull, CLng(brRec.SalesItemID))
      .Parameters.Append .CreateParameter("@SalesOrderID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ProductID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@OrderDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ProductName", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@Image", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@InputOptions", adVarWChar, adParamOutput, 1000, vbNull)
      .Parameters.Append .CreateParameter("@Quantity", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Price", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@OptionPrice", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Tax", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@InputValues", adVarWChar, adParamOutput, 500, vbNull)
      .Parameters.Append .CreateParameter("@Reference", adVarWChar, adParamOutput, 50, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BillDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@EndDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Locks", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BV", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Valid", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesItem_Fetch"

   '-----get return values
   With brRec
      .SalesOrderID = moUtil.FetchLong(oCmd.Parameters.Item("@SalesOrderID").Value)
      .ProductID = moUtil.FetchLong(oCmd.Parameters.Item("@ProductID").Value)
      .CompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@CompanyID").Value)
      .OrderDate = moUtil.FetchDate(oCmd.Parameters.Item("@OrderDate").Value)
      .ProductName = moUtil.FetchString(oCmd.Parameters.Item("@ProductName").Value)
      .Image = moUtil.FetchString(oCmd.Parameters.Item("@Image").Value)
      .InputOptions = moUtil.FetchString(oCmd.Parameters.Item("@InputOptions").Value)
      .Quantity = moUtil.FetchLong(oCmd.Parameters.Item("@Quantity").Value)
      .Price = moUtil.FetchCurrency(oCmd.Parameters.Item("@Price").Value)
      .OptionPrice = moUtil.FetchCurrency(oCmd.Parameters.Item("@OptionPrice").Value)
      .Tax = moUtil.FetchCurrency(oCmd.Parameters.Item("@Tax").Value)
      .InputValues = moUtil.FetchString(oCmd.Parameters.Item("@InputValues").Value)
      .Reference = moUtil.FetchString(oCmd.Parameters.Item("@Reference").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .BillDate = moUtil.FetchDate(oCmd.Parameters.Item("@BillDate").Value)
      .EndDate = moUtil.FetchDate(oCmd.Parameters.Item("@EndDate").Value)
      .Locks = moUtil.FetchLong(oCmd.Parameters.Item("@Locks").Value)
      .BV = moUtil.FetchCurrency(oCmd.Parameters.Item("@BV").Value)
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
   Optional ByVal bvSecurityToken As Long = 0) As tSalesItemType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSalesItemType
   Dim vRec As tSalesItemType
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
      Case cptsSalesItemFindOrderDate
         sProc = "pts_SalesItem_FindOrderDate"
         MaxBookMark = 30
      Case cptsSalesItemFindProductName
         sProc = "pts_SalesItem_FindProductName"
         MaxBookMark = 50
      Case cptsSalesItemFindStatus
         sProc = "pts_SalesItem_FindStatus"
         MaxBookMark = 20
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
               vRec.SalesItemID = moUtil.FetchLong(.Fields.Item("SalesItemID").Value)
               vRec.SalesOrderID = moUtil.FetchLong(.Fields.Item("SalesOrderID").Value)
               vRec.ProductID = moUtil.FetchLong(.Fields.Item("ProductID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.OrderDate = moUtil.FetchDate(.Fields.Item("OrderDate").Value)
               vRec.ProductName = moUtil.FetchString(.Fields.Item("ProductName").Value)
               vRec.Image = moUtil.FetchString(.Fields.Item("Image").Value)
               vRec.InputOptions = moUtil.FetchString(.Fields.Item("InputOptions").Value)
               vRec.Quantity = moUtil.FetchLong(.Fields.Item("Quantity").Value)
               vRec.Price = moUtil.FetchCurrency(.Fields.Item("Price").Value)
               vRec.OptionPrice = moUtil.FetchCurrency(.Fields.Item("OptionPrice").Value)
               vRec.Tax = moUtil.FetchCurrency(.Fields.Item("Tax").Value)
               vRec.InputValues = moUtil.FetchString(.Fields.Item("InputValues").Value)
               vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.BillDate = moUtil.FetchDate(.Fields.Item("BillDate").Value)
               vRec.EndDate = moUtil.FetchDate(.Fields.Item("EndDate").Value)
               vRec.Locks = moUtil.FetchLong(.Fields.Item("Locks").Value)
               vRec.BV = moUtil.FetchCurrency(.Fields.Item("BV").Value)
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

Public Function ListSalesOrder( _ 
   ByVal bvSalesOrderID As Long) As tSalesItemType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListSalesOrder"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tSalesItemType
   Dim vRec As tSalesItemType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvSalesOrderID = moUtil.EditLong(bvSalesOrderID, "SalesOrderID", True, 0, 1) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SalesOrderID", adInteger, adParamInput, vbNull, CLng(bvSalesOrderID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesItem_ListSalesOrder")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.SalesItemID = moUtil.FetchLong(.Fields.Item("SalesItemID").Value)
            vRec.ProductID = moUtil.FetchLong(.Fields.Item("ProductID").Value)
            vRec.ProductName = moUtil.FetchString(.Fields.Item("ProductName").Value)
            vRec.Image = moUtil.FetchString(.Fields.Item("Image").Value)
            vRec.Quantity = moUtil.FetchLong(.Fields.Item("Quantity").Value)
            vRec.Price = moUtil.FetchCurrency(.Fields.Item("Price").Value)
            vRec.OptionPrice = moUtil.FetchCurrency(.Fields.Item("OptionPrice").Value)
            vRec.Tax = moUtil.FetchCurrency(.Fields.Item("Tax").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.InputOptions = moUtil.FetchString(.Fields.Item("InputOptions").Value)
            vRec.InputValues = moUtil.FetchString(.Fields.Item("InputValues").Value)
            vRec.BillDate = moUtil.FetchDate(.Fields.Item("BillDate").Value)
            vRec.Locks = moUtil.FetchLong(.Fields.Item("Locks").Value)
            vRec.Valid = moUtil.FetchLong(.Fields.Item("Valid").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListSalesOrder = vRecs

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
   ByRef brRec As tSalesItemType, _ 
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
      .Parameters.Append .CreateParameter("@SalesItemID", adInteger, adParamInput, vbNull, CLng(brRec.SalesItemID))
      .Parameters.Append .CreateParameter("@SalesOrderID", adInteger, adParamInput, vbNull, CLng(brRec.SalesOrderID))
      .Parameters.Append .CreateParameter("@ProductID", adInteger, adParamInput, vbNull, CLng(brRec.ProductID))
      .Parameters.Append .CreateParameter("@Quantity", adInteger, adParamInput, vbNull, CLng(brRec.Quantity))
      .Parameters.Append .CreateParameter("@Price", adCurrency, adParamInput, vbNull, CCur(brRec.Price))
      .Parameters.Append .CreateParameter("@OptionPrice", adCurrency, adParamInput, vbNull, CCur(brRec.OptionPrice))
      .Parameters.Append .CreateParameter("@Tax", adCurrency, adParamInput, vbNull, CCur(brRec.Tax))
      .Parameters.Append .CreateParameter("@InputValues", adVarWChar, adParamInput, 500, brRec.InputValues)
      .Parameters.Append .CreateParameter("@Reference", adVarWChar, adParamInput, 50, brRec.Reference)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@BillDate", adDate, adParamInput, vbNull, CDate(brRec.BillDate))
      .Parameters.Append .CreateParameter("@EndDate", adDate, adParamInput, vbNull, CDate(brRec.EndDate))
      .Parameters.Append .CreateParameter("@Locks", adInteger, adParamInput, vbNull, CLng(brRec.Locks))
      .Parameters.Append .CreateParameter("@BV", adCurrency, adParamInput, vbNull, CCur(brRec.BV))
      .Parameters.Append .CreateParameter("@Valid", adInteger, adParamInput, vbNull, CLng(brRec.Valid))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_SalesItem_Update"

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
   ByRef brRec As tSalesItemType, _ 
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
         .SalesItemID = moUtil.EditLong(.SalesItemID, "SalesItemID", True, , 1) 
      End If
      .SalesOrderID = moUtil.EditLong(.SalesOrderID, "SalesOrderID", True, , 1) 
      .ProductID = moUtil.EditLong(.ProductID, "ProductID", False, , 1) 
      .Quantity = moUtil.EditLong(.Quantity, "Quantity", True, , 1, 999999999) 
      .Price = moUtil.EditCurrency(.Price, "Price", False, , -999999.99, 999999.99) 
      .OptionPrice = moUtil.EditCurrency(.OptionPrice, "OptionPrice", False, , -999999.99, 999999.99) 
      .Tax = moUtil.EditCurrency(.Tax, "Tax", False, , 0, 999999.99) 
      .InputValues = moUtil.EditString(.InputValues, "InputValues", False, , 1, 500) 
      .Reference = moUtil.EditString(.Reference, "Reference", False) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .BillDate = moUtil.EditDate(.BillDate, "BillDate", False) 
      .EndDate = moUtil.EditDate(.EndDate, "EndDate", False) 
      .Locks = moUtil.EditLong(.Locks, "Locks", False) 
      .BV = moUtil.EditCurrency(.BV, "BV", False, , 0, 999999.99) 
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