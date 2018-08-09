VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CProductB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CProduct"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tProductType
   ProductID As String
   CompanyID As String
   ProductTypeID As String
   ProductTypeName As String
   ProductName As String
   Image As String
   Price As String
   OriginalPrice As String
   IsTaxable As String
   TaxRate As String
   Tax As String
   Description As String
   Seq As String
   IsActive As String
   IsPrivate As String
   IsPublic As String
   NoQty As String
   Data As String
   Email As String
   InputOptions As String
   Ship1 As String
   Ship2 As String
   Ship3 As String
   Ship4 As String
   Ship1a As String
   Ship2a As String
   Ship3a As String
   Ship4a As String
   Fulfill As String
   Recur As String
   RecurTerm As String
   CommPlan As String
   BV As String
   QV As String
   Code As String
   Inventory As String
   InStock As String
   ReOrder As String
   IsShip As String
   OrderMin As String
   OrderMax As String
   OrderMul As String
   OrderGrp As String
   Attribute1 As String
   Attribute2 As String
   Attribute3 As String
   Levels As String
   FulFillInfo As String
   FromDate As String
   ToDate As String
End Type

Public Sub Add( _ 
   ByRef brRec As tProductType, _ 
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
      .Parameters.Append .CreateParameter("@ProductID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@ProductTypeID", adInteger, adParamInput, vbNull, CLng(brRec.ProductTypeID))
      .Parameters.Append .CreateParameter("@ProductName", adVarWChar, adParamInput, 40, brRec.ProductName)
      .Parameters.Append .CreateParameter("@Image", adVarWChar, adParamInput, 40, brRec.Image)
      .Parameters.Append .CreateParameter("@Price", adCurrency, adParamInput, vbNull, CCur(brRec.Price))
      .Parameters.Append .CreateParameter("@OriginalPrice", adCurrency, adParamInput, vbNull, CCur(brRec.OriginalPrice))
      .Parameters.Append .CreateParameter("@IsTaxable", adSmallInt, adParamInput, vbNull, CInt(brRec.IsTaxable))
      .Parameters.Append .CreateParameter("@TaxRate", adCurrency, adParamInput, vbNull, CCur(brRec.TaxRate))
      .Parameters.Append .CreateParameter("@Tax", adCurrency, adParamInput, vbNull, CCur(brRec.Tax))
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 2000, brRec.Description)
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@IsActive", adSmallInt, adParamInput, vbNull, CInt(brRec.IsActive))
      .Parameters.Append .CreateParameter("@IsPrivate", adSmallInt, adParamInput, vbNull, CInt(brRec.IsPrivate))
      .Parameters.Append .CreateParameter("@IsPublic", adSmallInt, adParamInput, vbNull, CInt(brRec.IsPublic))
      .Parameters.Append .CreateParameter("@NoQty", adSmallInt, adParamInput, vbNull, CInt(brRec.NoQty))
      .Parameters.Append .CreateParameter("@Data", adVarWChar, adParamInput, 80, brRec.Data)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@InputOptions", adVarWChar, adParamInput, 2000, brRec.InputOptions)
      .Parameters.Append .CreateParameter("@Ship1", adCurrency, adParamInput, vbNull, CCur(brRec.Ship1))
      .Parameters.Append .CreateParameter("@Ship2", adCurrency, adParamInput, vbNull, CCur(brRec.Ship2))
      .Parameters.Append .CreateParameter("@Ship3", adCurrency, adParamInput, vbNull, CCur(brRec.Ship3))
      .Parameters.Append .CreateParameter("@Ship4", adCurrency, adParamInput, vbNull, CCur(brRec.Ship4))
      .Parameters.Append .CreateParameter("@Ship1a", adCurrency, adParamInput, vbNull, CCur(brRec.Ship1a))
      .Parameters.Append .CreateParameter("@Ship2a", adCurrency, adParamInput, vbNull, CCur(brRec.Ship2a))
      .Parameters.Append .CreateParameter("@Ship3a", adCurrency, adParamInput, vbNull, CCur(brRec.Ship3a))
      .Parameters.Append .CreateParameter("@Ship4a", adCurrency, adParamInput, vbNull, CCur(brRec.Ship4a))
      .Parameters.Append .CreateParameter("@Fulfill", adInteger, adParamInput, vbNull, CLng(brRec.Fulfill))
      .Parameters.Append .CreateParameter("@Recur", adInteger, adParamInput, vbNull, CLng(brRec.Recur))
      .Parameters.Append .CreateParameter("@RecurTerm", adVarWChar, adParamInput, 10, brRec.RecurTerm)
      .Parameters.Append .CreateParameter("@CommPlan", adInteger, adParamInput, vbNull, CLng(brRec.CommPlan))
      .Parameters.Append .CreateParameter("@BV", adCurrency, adParamInput, vbNull, CCur(brRec.BV))
      .Parameters.Append .CreateParameter("@QV", adCurrency, adParamInput, vbNull, CCur(brRec.QV))
      .Parameters.Append .CreateParameter("@Code", adVarWChar, adParamInput, 10, brRec.Code)
      .Parameters.Append .CreateParameter("@Inventory", adInteger, adParamInput, vbNull, CLng(brRec.Inventory))
      .Parameters.Append .CreateParameter("@InStock", adInteger, adParamInput, vbNull, CLng(brRec.InStock))
      .Parameters.Append .CreateParameter("@ReOrder", adInteger, adParamInput, vbNull, CLng(brRec.ReOrder))
      .Parameters.Append .CreateParameter("@IsShip", adSmallInt, adParamInput, vbNull, CInt(brRec.IsShip))
      .Parameters.Append .CreateParameter("@OrderMin", adInteger, adParamInput, vbNull, CLng(brRec.OrderMin))
      .Parameters.Append .CreateParameter("@OrderMax", adInteger, adParamInput, vbNull, CLng(brRec.OrderMax))
      .Parameters.Append .CreateParameter("@OrderMul", adInteger, adParamInput, vbNull, CLng(brRec.OrderMul))
      .Parameters.Append .CreateParameter("@OrderGrp", adVarWChar, adParamInput, 10, brRec.OrderGrp)
      .Parameters.Append .CreateParameter("@Attribute1", adVarWChar, adParamInput, 15, brRec.Attribute1)
      .Parameters.Append .CreateParameter("@Attribute2", adVarWChar, adParamInput, 15, brRec.Attribute2)
      .Parameters.Append .CreateParameter("@Attribute3", adVarWChar, adParamInput, 15, brRec.Attribute3)
      .Parameters.Append .CreateParameter("@Levels", adVarWChar, adParamInput, 5, brRec.Levels)
      .Parameters.Append .CreateParameter("@FulFillInfo", adVarWChar, adParamInput, 100, brRec.FulFillInfo)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Product_Add"

   '-----get return values
   With brRec
      .ProductID = moUtil.FetchLong(oCmd.Parameters.Item("@ProductID").Value)
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

Public Sub Copy( _ 
   ByRef brRec As tProductType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Copy the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Copy"
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
      .Parameters.Append .CreateParameter("@ProductID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CopyProductID", adInteger, adParamInput, vbNull, CLng(brRec.ProductID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Product_Copy"

   '-----get return values
   With brRec
      .ProductID = moUtil.FetchLong(oCmd.Parameters.Item("@ProductID").Value)
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

Public Function CheckInventory( _ 
   ByRef brRec As tProductType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CheckInventory"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProductID", adInteger, adParamInput, vbNull, CLng(brRec.ProductID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Product_CheckInventory"

   '-----get return values
   CheckInventory = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function UpdateInventory( _ 
   ByRef brRec As tProductType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "UpdateInventory"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProductID", adInteger, adParamInput, vbNull, CLng(brRec.ProductID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Product_UpdateInventory"

   '-----get return values
   UpdateInventory = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

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
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Product_Count"

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
   ByRef brRec As tProductType, _ 
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
      .ProductID = moUtil.EditLong(.ProductID, "ProductID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProductID", adInteger, adParamInput, vbNull, CLng(brRec.ProductID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Product_Delete"

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

Public Function EnumProductType( _ 
   ByVal bvProductTypeID As Long, _ 
   ByVal bvSecurityToken As Long) As tProductType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns an enumerated list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EnumProductType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProductType
   Dim vRec As tProductType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProductTypeID", adInteger, adParamInput, vbNull, CLng(bvProductTypeID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Product_EnumProductType")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProductID = moUtil.FetchLong(.Fields.Item("ID").Value)
            vRec.ProductName = moUtil.FetchString(.Fields.Item("Name").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   EnumProductType = vRecs

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

Public Sub Fetch( _ 
   ByRef brRec As tProductType, _ 
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
      .ProductID = moUtil.EditLong(.ProductID, "ProductID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProductID", adInteger, adParamInput, vbNull, CLng(brRec.ProductID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ProductTypeID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ProductTypeName", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@ProductName", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@Image", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@Price", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@OriginalPrice", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsTaxable", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@TaxRate", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Tax", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamOutput, 2000, vbNull)
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsActive", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsPrivate", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsPublic", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@NoQty", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Data", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@InputOptions", adVarWChar, adParamOutput, 2000, vbNull)
      .Parameters.Append .CreateParameter("@Ship1", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Ship2", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Ship3", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Ship4", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Ship1a", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Ship2a", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Ship3a", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Ship4a", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Fulfill", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Recur", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@RecurTerm", adVarWChar, adParamOutput, 10, vbNull)
      .Parameters.Append .CreateParameter("@CommPlan", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BV", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@QV", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Code", adVarWChar, adParamOutput, 10, vbNull)
      .Parameters.Append .CreateParameter("@Inventory", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@InStock", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ReOrder", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsShip", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@OrderMin", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@OrderMax", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@OrderMul", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@OrderGrp", adVarWChar, adParamOutput, 10, vbNull)
      .Parameters.Append .CreateParameter("@Attribute1", adVarWChar, adParamOutput, 15, vbNull)
      .Parameters.Append .CreateParameter("@Attribute2", adVarWChar, adParamOutput, 15, vbNull)
      .Parameters.Append .CreateParameter("@Attribute3", adVarWChar, adParamOutput, 15, vbNull)
      .Parameters.Append .CreateParameter("@Levels", adVarWChar, adParamOutput, 5, vbNull)
      .Parameters.Append .CreateParameter("@FulFillInfo", adVarWChar, adParamOutput, 100, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Product_Fetch"

   '-----get return values
   With brRec
      .CompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@CompanyID").Value)
      .ProductTypeID = moUtil.FetchLong(oCmd.Parameters.Item("@ProductTypeID").Value)
      .ProductTypeName = moUtil.FetchString(oCmd.Parameters.Item("@ProductTypeName").Value)
      .ProductName = moUtil.FetchString(oCmd.Parameters.Item("@ProductName").Value)
      .Image = moUtil.FetchString(oCmd.Parameters.Item("@Image").Value)
      .Price = moUtil.FetchCurrency(oCmd.Parameters.Item("@Price").Value)
      .OriginalPrice = moUtil.FetchCurrency(oCmd.Parameters.Item("@OriginalPrice").Value)
      .IsTaxable = moUtil.FetchInteger(oCmd.Parameters.Item("@IsTaxable").Value)
      .TaxRate = moUtil.FetchCurrency(oCmd.Parameters.Item("@TaxRate").Value)
      .Tax = moUtil.FetchCurrency(oCmd.Parameters.Item("@Tax").Value)
      .Description = moUtil.FetchString(oCmd.Parameters.Item("@Description").Value)
      .Seq = moUtil.FetchLong(oCmd.Parameters.Item("@Seq").Value)
      .IsActive = moUtil.FetchInteger(oCmd.Parameters.Item("@IsActive").Value)
      .IsPrivate = moUtil.FetchInteger(oCmd.Parameters.Item("@IsPrivate").Value)
      .IsPublic = moUtil.FetchInteger(oCmd.Parameters.Item("@IsPublic").Value)
      .NoQty = moUtil.FetchInteger(oCmd.Parameters.Item("@NoQty").Value)
      .Data = moUtil.FetchString(oCmd.Parameters.Item("@Data").Value)
      .Email = moUtil.FetchString(oCmd.Parameters.Item("@Email").Value)
      .InputOptions = moUtil.FetchString(oCmd.Parameters.Item("@InputOptions").Value)
      .Ship1 = moUtil.FetchCurrency(oCmd.Parameters.Item("@Ship1").Value)
      .Ship2 = moUtil.FetchCurrency(oCmd.Parameters.Item("@Ship2").Value)
      .Ship3 = moUtil.FetchCurrency(oCmd.Parameters.Item("@Ship3").Value)
      .Ship4 = moUtil.FetchCurrency(oCmd.Parameters.Item("@Ship4").Value)
      .Ship1a = moUtil.FetchCurrency(oCmd.Parameters.Item("@Ship1a").Value)
      .Ship2a = moUtil.FetchCurrency(oCmd.Parameters.Item("@Ship2a").Value)
      .Ship3a = moUtil.FetchCurrency(oCmd.Parameters.Item("@Ship3a").Value)
      .Ship4a = moUtil.FetchCurrency(oCmd.Parameters.Item("@Ship4a").Value)
      .Fulfill = moUtil.FetchLong(oCmd.Parameters.Item("@Fulfill").Value)
      .Recur = moUtil.FetchLong(oCmd.Parameters.Item("@Recur").Value)
      .RecurTerm = moUtil.FetchString(oCmd.Parameters.Item("@RecurTerm").Value)
      .CommPlan = moUtil.FetchLong(oCmd.Parameters.Item("@CommPlan").Value)
      .BV = moUtil.FetchCurrency(oCmd.Parameters.Item("@BV").Value)
      .QV = moUtil.FetchCurrency(oCmd.Parameters.Item("@QV").Value)
      .Code = moUtil.FetchString(oCmd.Parameters.Item("@Code").Value)
      .Inventory = moUtil.FetchLong(oCmd.Parameters.Item("@Inventory").Value)
      .InStock = moUtil.FetchLong(oCmd.Parameters.Item("@InStock").Value)
      .ReOrder = moUtil.FetchLong(oCmd.Parameters.Item("@ReOrder").Value)
      .IsShip = moUtil.FetchInteger(oCmd.Parameters.Item("@IsShip").Value)
      .OrderMin = moUtil.FetchLong(oCmd.Parameters.Item("@OrderMin").Value)
      .OrderMax = moUtil.FetchLong(oCmd.Parameters.Item("@OrderMax").Value)
      .OrderMul = moUtil.FetchLong(oCmd.Parameters.Item("@OrderMul").Value)
      .OrderGrp = moUtil.FetchString(oCmd.Parameters.Item("@OrderGrp").Value)
      .Attribute1 = moUtil.FetchString(oCmd.Parameters.Item("@Attribute1").Value)
      .Attribute2 = moUtil.FetchString(oCmd.Parameters.Item("@Attribute2").Value)
      .Attribute3 = moUtil.FetchString(oCmd.Parameters.Item("@Attribute3").Value)
      .Levels = moUtil.FetchString(oCmd.Parameters.Item("@Levels").Value)
      .FulFillInfo = moUtil.FetchString(oCmd.Parameters.Item("@FulFillInfo").Value)
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

Public Sub FetchCode( _ 
   ByRef brRec As tProductType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FetchCode"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .CompanyID = moUtil.EditLong(.CompanyID, "CompanyID", True, 0) 
      .Code = moUtil.EditString(.Code, "Code", True, "", 1, 10) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@Code", adVarWChar, adParamInput, 10, brRec.Code)
      .Parameters.Append .CreateParameter("@ProductID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Price", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BV", adCurrency, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Product_FetchCode"

   '-----get return values
   With brRec
      .ProductID = moUtil.FetchLong(oCmd.Parameters.Item("@ProductID").Value)
      .Price = moUtil.FetchCurrency(oCmd.Parameters.Item("@Price").Value)
      .BV = moUtil.FetchCurrency(oCmd.Parameters.Item("@BV").Value)
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
   Optional ByVal bvSecurityToken As Long = 0) As tProductType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProductType
   Dim vRec As tProductType
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
      Case cptsProductFindProductName
         sProc = "pts_Product_FindProductName"
         MaxBookMark = 50
      Case cptsProductFindProductTypeName
         sProc = "pts_Product_FindProductTypeName"
         MaxBookMark = 50
      Case cptsProductFindCode
         sProc = "pts_Product_FindCode"
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
               vRec.ProductID = moUtil.FetchLong(.Fields.Item("ProductID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.ProductTypeID = moUtil.FetchLong(.Fields.Item("ProductTypeID").Value)
               vRec.ProductTypeName = moUtil.FetchString(.Fields.Item("ProductTypeName").Value)
               vRec.ProductName = moUtil.FetchString(.Fields.Item("ProductName").Value)
               vRec.Image = moUtil.FetchString(.Fields.Item("Image").Value)
               vRec.Price = moUtil.FetchCurrency(.Fields.Item("Price").Value)
               vRec.OriginalPrice = moUtil.FetchCurrency(.Fields.Item("OriginalPrice").Value)
               vRec.IsTaxable = moUtil.FetchInteger(.Fields.Item("IsTaxable").Value)
               vRec.TaxRate = moUtil.FetchCurrency(.Fields.Item("TaxRate").Value)
               vRec.Tax = moUtil.FetchCurrency(.Fields.Item("Tax").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Seq = moUtil.FetchLong(.Fields.Item("Seq").Value)
               vRec.IsActive = moUtil.FetchInteger(.Fields.Item("IsActive").Value)
               vRec.IsPrivate = moUtil.FetchInteger(.Fields.Item("IsPrivate").Value)
               vRec.IsPublic = moUtil.FetchInteger(.Fields.Item("IsPublic").Value)
               vRec.NoQty = moUtil.FetchInteger(.Fields.Item("NoQty").Value)
               vRec.Data = moUtil.FetchString(.Fields.Item("Data").Value)
               vRec.Email = moUtil.FetchString(.Fields.Item("Email").Value)
               vRec.InputOptions = moUtil.FetchString(.Fields.Item("InputOptions").Value)
               vRec.Ship1 = moUtil.FetchCurrency(.Fields.Item("Ship1").Value)
               vRec.Ship2 = moUtil.FetchCurrency(.Fields.Item("Ship2").Value)
               vRec.Ship3 = moUtil.FetchCurrency(.Fields.Item("Ship3").Value)
               vRec.Ship4 = moUtil.FetchCurrency(.Fields.Item("Ship4").Value)
               vRec.Ship1a = moUtil.FetchCurrency(.Fields.Item("Ship1a").Value)
               vRec.Ship2a = moUtil.FetchCurrency(.Fields.Item("Ship2a").Value)
               vRec.Ship3a = moUtil.FetchCurrency(.Fields.Item("Ship3a").Value)
               vRec.Ship4a = moUtil.FetchCurrency(.Fields.Item("Ship4a").Value)
               vRec.Fulfill = moUtil.FetchLong(.Fields.Item("Fulfill").Value)
               vRec.Recur = moUtil.FetchLong(.Fields.Item("Recur").Value)
               vRec.RecurTerm = moUtil.FetchString(.Fields.Item("RecurTerm").Value)
               vRec.CommPlan = moUtil.FetchLong(.Fields.Item("CommPlan").Value)
               vRec.BV = moUtil.FetchCurrency(.Fields.Item("BV").Value)
               vRec.QV = moUtil.FetchCurrency(.Fields.Item("QV").Value)
               vRec.Code = moUtil.FetchString(.Fields.Item("Code").Value)
               vRec.Inventory = moUtil.FetchLong(.Fields.Item("Inventory").Value)
               vRec.InStock = moUtil.FetchLong(.Fields.Item("InStock").Value)
               vRec.ReOrder = moUtil.FetchLong(.Fields.Item("ReOrder").Value)
               vRec.IsShip = moUtil.FetchInteger(.Fields.Item("IsShip").Value)
               vRec.OrderMin = moUtil.FetchLong(.Fields.Item("OrderMin").Value)
               vRec.OrderMax = moUtil.FetchLong(.Fields.Item("OrderMax").Value)
               vRec.OrderMul = moUtil.FetchLong(.Fields.Item("OrderMul").Value)
               vRec.OrderGrp = moUtil.FetchString(.Fields.Item("OrderGrp").Value)
               vRec.Attribute1 = moUtil.FetchString(.Fields.Item("Attribute1").Value)
               vRec.Attribute2 = moUtil.FetchString(.Fields.Item("Attribute2").Value)
               vRec.Attribute3 = moUtil.FetchString(.Fields.Item("Attribute3").Value)
               vRec.Levels = moUtil.FetchString(.Fields.Item("Levels").Value)
               vRec.FulFillInfo = moUtil.FetchString(.Fields.Item("FulFillInfo").Value)
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

Public Function ListProductType( _ 
   ByVal bvProductTypeID As Long, _ 
   ByVal bvLevels As String) As tProductType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListProductType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProductType
   Dim vRec As tProductType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProductTypeID", adInteger, adParamInput, vbNull, CLng(bvProductTypeID))
      .Parameters.Append .CreateParameter("@Levels", adVarWChar, adParamInput, 5, bvLevels)
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Product_ListProductType")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProductID = moUtil.FetchLong(.Fields.Item("ProductID").Value)
            vRec.ProductName = moUtil.FetchString(.Fields.Item("ProductName").Value)
            vRec.Price = moUtil.FetchCurrency(.Fields.Item("Price").Value)
            vRec.OriginalPrice = moUtil.FetchCurrency(.Fields.Item("OriginalPrice").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Image = moUtil.FetchString(.Fields.Item("Image").Value)
            vRec.BV = moUtil.FetchCurrency(.Fields.Item("BV").Value)
            vRec.QV = moUtil.FetchCurrency(.Fields.Item("QV").Value)
            vRec.Data = moUtil.FetchString(.Fields.Item("Data").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListProductType = vRecs

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

Public Function ListProductPriceLow( _ 
   ByVal bvProductTypeID As Long, _ 
   ByVal bvLevels As String) As tProductType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListProductPriceLow"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProductType
   Dim vRec As tProductType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProductTypeID", adInteger, adParamInput, vbNull, CLng(bvProductTypeID))
      .Parameters.Append .CreateParameter("@Levels", adVarWChar, adParamInput, 5, bvLevels)
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Product_ListProductPriceLow")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProductID = moUtil.FetchLong(.Fields.Item("ProductID").Value)
            vRec.ProductName = moUtil.FetchString(.Fields.Item("ProductName").Value)
            vRec.Price = moUtil.FetchCurrency(.Fields.Item("Price").Value)
            vRec.OriginalPrice = moUtil.FetchCurrency(.Fields.Item("OriginalPrice").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Image = moUtil.FetchString(.Fields.Item("Image").Value)
            vRec.BV = moUtil.FetchCurrency(.Fields.Item("BV").Value)
            vRec.QV = moUtil.FetchCurrency(.Fields.Item("QV").Value)
            vRec.Data = moUtil.FetchString(.Fields.Item("Data").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListProductPriceLow = vRecs

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

Public Function ListProductPriceHigh( _ 
   ByVal bvProductTypeID As Long, _ 
   ByVal bvLevels As String) As tProductType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListProductPriceHigh"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProductType
   Dim vRec As tProductType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProductTypeID", adInteger, adParamInput, vbNull, CLng(bvProductTypeID))
      .Parameters.Append .CreateParameter("@Levels", adVarWChar, adParamInput, 5, bvLevels)
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Product_ListProductPriceHigh")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProductID = moUtil.FetchLong(.Fields.Item("ProductID").Value)
            vRec.ProductName = moUtil.FetchString(.Fields.Item("ProductName").Value)
            vRec.Price = moUtil.FetchCurrency(.Fields.Item("Price").Value)
            vRec.OriginalPrice = moUtil.FetchCurrency(.Fields.Item("OriginalPrice").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Image = moUtil.FetchString(.Fields.Item("Image").Value)
            vRec.BV = moUtil.FetchCurrency(.Fields.Item("BV").Value)
            vRec.QV = moUtil.FetchCurrency(.Fields.Item("QV").Value)
            vRec.Data = moUtil.FetchString(.Fields.Item("Data").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListProductPriceHigh = vRecs

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

Public Function ListProductName( _ 
   ByVal bvProductTypeID As Long, _ 
   ByVal bvLevels As String) As tProductType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListProductName"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProductType
   Dim vRec As tProductType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProductTypeID", adInteger, adParamInput, vbNull, CLng(bvProductTypeID))
      .Parameters.Append .CreateParameter("@Levels", adVarWChar, adParamInput, 5, bvLevels)
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Product_ListProductName")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProductID = moUtil.FetchLong(.Fields.Item("ProductID").Value)
            vRec.ProductName = moUtil.FetchString(.Fields.Item("ProductName").Value)
            vRec.Price = moUtil.FetchCurrency(.Fields.Item("Price").Value)
            vRec.OriginalPrice = moUtil.FetchCurrency(.Fields.Item("OriginalPrice").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Image = moUtil.FetchString(.Fields.Item("Image").Value)
            vRec.BV = moUtil.FetchCurrency(.Fields.Item("BV").Value)
            vRec.QV = moUtil.FetchCurrency(.Fields.Item("QV").Value)
            vRec.Data = moUtil.FetchString(.Fields.Item("Data").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListProductName = vRecs

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

Public Function ListProductTypePublic( _ 
   ByVal bvProductTypeID As Long) As tProductType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListProductTypePublic"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProductType
   Dim vRec As tProductType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProductTypeID", adInteger, adParamInput, vbNull, CLng(bvProductTypeID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Product_ListProductTypePublic")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProductID = moUtil.FetchLong(.Fields.Item("ProductID").Value)
            vRec.ProductName = moUtil.FetchString(.Fields.Item("ProductName").Value)
            vRec.Price = moUtil.FetchCurrency(.Fields.Item("Price").Value)
            vRec.OriginalPrice = moUtil.FetchCurrency(.Fields.Item("OriginalPrice").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Image = moUtil.FetchString(.Fields.Item("Image").Value)
            vRec.BV = moUtil.FetchCurrency(.Fields.Item("BV").Value)
            vRec.QV = moUtil.FetchCurrency(.Fields.Item("QV").Value)
            vRec.Data = moUtil.FetchString(.Fields.Item("Data").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListProductTypePublic = vRecs

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

Public Function ListProductPriceLowPublic( _ 
   ByVal bvProductTypeID As Long) As tProductType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListProductPriceLowPublic"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProductType
   Dim vRec As tProductType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProductTypeID", adInteger, adParamInput, vbNull, CLng(bvProductTypeID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Product_ListProductPriceLowPublic")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProductID = moUtil.FetchLong(.Fields.Item("ProductID").Value)
            vRec.ProductName = moUtil.FetchString(.Fields.Item("ProductName").Value)
            vRec.Price = moUtil.FetchCurrency(.Fields.Item("Price").Value)
            vRec.OriginalPrice = moUtil.FetchCurrency(.Fields.Item("OriginalPrice").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Image = moUtil.FetchString(.Fields.Item("Image").Value)
            vRec.BV = moUtil.FetchCurrency(.Fields.Item("BV").Value)
            vRec.QV = moUtil.FetchCurrency(.Fields.Item("QV").Value)
            vRec.Data = moUtil.FetchString(.Fields.Item("Data").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListProductPriceLowPublic = vRecs

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

Public Function ListProductPriceHighPublic( _ 
   ByVal bvProductTypeID As Long) As tProductType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListProductPriceHighPublic"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProductType
   Dim vRec As tProductType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProductTypeID", adInteger, adParamInput, vbNull, CLng(bvProductTypeID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Product_ListProductPriceHighPublic")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProductID = moUtil.FetchLong(.Fields.Item("ProductID").Value)
            vRec.ProductName = moUtil.FetchString(.Fields.Item("ProductName").Value)
            vRec.Price = moUtil.FetchCurrency(.Fields.Item("Price").Value)
            vRec.OriginalPrice = moUtil.FetchCurrency(.Fields.Item("OriginalPrice").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Image = moUtil.FetchString(.Fields.Item("Image").Value)
            vRec.BV = moUtil.FetchCurrency(.Fields.Item("BV").Value)
            vRec.QV = moUtil.FetchCurrency(.Fields.Item("QV").Value)
            vRec.Data = moUtil.FetchString(.Fields.Item("Data").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListProductPriceHighPublic = vRecs

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

Public Function ListProductNamePublic( _ 
   ByVal bvProductTypeID As Long) As tProductType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListProductNamePublic"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProductType
   Dim vRec As tProductType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProductTypeID", adInteger, adParamInput, vbNull, CLng(bvProductTypeID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Product_ListProductNamePublic")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProductID = moUtil.FetchLong(.Fields.Item("ProductID").Value)
            vRec.ProductName = moUtil.FetchString(.Fields.Item("ProductName").Value)
            vRec.Price = moUtil.FetchCurrency(.Fields.Item("Price").Value)
            vRec.OriginalPrice = moUtil.FetchCurrency(.Fields.Item("OriginalPrice").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Image = moUtil.FetchString(.Fields.Item("Image").Value)
            vRec.BV = moUtil.FetchCurrency(.Fields.Item("BV").Value)
            vRec.QV = moUtil.FetchCurrency(.Fields.Item("QV").Value)
            vRec.Data = moUtil.FetchString(.Fields.Item("Data").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListProductNamePublic = vRecs

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

Public Function Summary( _ 
   ByVal bvProductID As Long, _ 
   ByVal bvProductTypeID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date) As tProductType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Summary"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tProductType
   Dim vRec As tProductType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ProductID", adInteger, adParamInput, vbNull, CLng(bvProductID))
      .Parameters.Append .CreateParameter("@ProductTypeID", adInteger, adParamInput, vbNull, CLng(bvProductTypeID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Product_Summary")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ProductID = moUtil.FetchLong(.Fields.Item("ProductID").Value)
            vRec.ProductName = moUtil.FetchString(.Fields.Item("ProductName").Value)
            vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
            vRec.CommPlan = moUtil.FetchLong(.Fields.Item("CommPlan").Value)
            vRec.ReOrder = moUtil.FetchLong(.Fields.Item("ReOrder").Value)
            vRec.Inventory = moUtil.FetchLong(.Fields.Item("Inventory").Value)
            vRec.InStock = moUtil.FetchLong(.Fields.Item("InStock").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   Summary = vRecs

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
   ByRef brRec As tProductType, _ 
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
      .Parameters.Append .CreateParameter("@ProductID", adInteger, adParamInput, vbNull, CLng(brRec.ProductID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@ProductTypeID", adInteger, adParamInput, vbNull, CLng(brRec.ProductTypeID))
      .Parameters.Append .CreateParameter("@ProductName", adVarWChar, adParamInput, 40, brRec.ProductName)
      .Parameters.Append .CreateParameter("@Image", adVarWChar, adParamInput, 40, brRec.Image)
      .Parameters.Append .CreateParameter("@Price", adCurrency, adParamInput, vbNull, CCur(brRec.Price))
      .Parameters.Append .CreateParameter("@OriginalPrice", adCurrency, adParamInput, vbNull, CCur(brRec.OriginalPrice))
      .Parameters.Append .CreateParameter("@IsTaxable", adSmallInt, adParamInput, vbNull, CInt(brRec.IsTaxable))
      .Parameters.Append .CreateParameter("@TaxRate", adCurrency, adParamInput, vbNull, CCur(brRec.TaxRate))
      .Parameters.Append .CreateParameter("@Tax", adCurrency, adParamInput, vbNull, CCur(brRec.Tax))
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 2000, brRec.Description)
      .Parameters.Append .CreateParameter("@Seq", adInteger, adParamInput, vbNull, CLng(brRec.Seq))
      .Parameters.Append .CreateParameter("@IsActive", adSmallInt, adParamInput, vbNull, CInt(brRec.IsActive))
      .Parameters.Append .CreateParameter("@IsPrivate", adSmallInt, adParamInput, vbNull, CInt(brRec.IsPrivate))
      .Parameters.Append .CreateParameter("@IsPublic", adSmallInt, adParamInput, vbNull, CInt(brRec.IsPublic))
      .Parameters.Append .CreateParameter("@NoQty", adSmallInt, adParamInput, vbNull, CInt(brRec.NoQty))
      .Parameters.Append .CreateParameter("@Data", adVarWChar, adParamInput, 80, brRec.Data)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@InputOptions", adVarWChar, adParamInput, 2000, brRec.InputOptions)
      .Parameters.Append .CreateParameter("@Ship1", adCurrency, adParamInput, vbNull, CCur(brRec.Ship1))
      .Parameters.Append .CreateParameter("@Ship2", adCurrency, adParamInput, vbNull, CCur(brRec.Ship2))
      .Parameters.Append .CreateParameter("@Ship3", adCurrency, adParamInput, vbNull, CCur(brRec.Ship3))
      .Parameters.Append .CreateParameter("@Ship4", adCurrency, adParamInput, vbNull, CCur(brRec.Ship4))
      .Parameters.Append .CreateParameter("@Ship1a", adCurrency, adParamInput, vbNull, CCur(brRec.Ship1a))
      .Parameters.Append .CreateParameter("@Ship2a", adCurrency, adParamInput, vbNull, CCur(brRec.Ship2a))
      .Parameters.Append .CreateParameter("@Ship3a", adCurrency, adParamInput, vbNull, CCur(brRec.Ship3a))
      .Parameters.Append .CreateParameter("@Ship4a", adCurrency, adParamInput, vbNull, CCur(brRec.Ship4a))
      .Parameters.Append .CreateParameter("@Fulfill", adInteger, adParamInput, vbNull, CLng(brRec.Fulfill))
      .Parameters.Append .CreateParameter("@Recur", adInteger, adParamInput, vbNull, CLng(brRec.Recur))
      .Parameters.Append .CreateParameter("@RecurTerm", adVarWChar, adParamInput, 10, brRec.RecurTerm)
      .Parameters.Append .CreateParameter("@CommPlan", adInteger, adParamInput, vbNull, CLng(brRec.CommPlan))
      .Parameters.Append .CreateParameter("@BV", adCurrency, adParamInput, vbNull, CCur(brRec.BV))
      .Parameters.Append .CreateParameter("@QV", adCurrency, adParamInput, vbNull, CCur(brRec.QV))
      .Parameters.Append .CreateParameter("@Code", adVarWChar, adParamInput, 10, brRec.Code)
      .Parameters.Append .CreateParameter("@Inventory", adInteger, adParamInput, vbNull, CLng(brRec.Inventory))
      .Parameters.Append .CreateParameter("@InStock", adInteger, adParamInput, vbNull, CLng(brRec.InStock))
      .Parameters.Append .CreateParameter("@ReOrder", adInteger, adParamInput, vbNull, CLng(brRec.ReOrder))
      .Parameters.Append .CreateParameter("@IsShip", adSmallInt, adParamInput, vbNull, CInt(brRec.IsShip))
      .Parameters.Append .CreateParameter("@OrderMin", adInteger, adParamInput, vbNull, CLng(brRec.OrderMin))
      .Parameters.Append .CreateParameter("@OrderMax", adInteger, adParamInput, vbNull, CLng(brRec.OrderMax))
      .Parameters.Append .CreateParameter("@OrderMul", adInteger, adParamInput, vbNull, CLng(brRec.OrderMul))
      .Parameters.Append .CreateParameter("@OrderGrp", adVarWChar, adParamInput, 10, brRec.OrderGrp)
      .Parameters.Append .CreateParameter("@Attribute1", adVarWChar, adParamInput, 15, brRec.Attribute1)
      .Parameters.Append .CreateParameter("@Attribute2", adVarWChar, adParamInput, 15, brRec.Attribute2)
      .Parameters.Append .CreateParameter("@Attribute3", adVarWChar, adParamInput, 15, brRec.Attribute3)
      .Parameters.Append .CreateParameter("@Levels", adVarWChar, adParamInput, 5, brRec.Levels)
      .Parameters.Append .CreateParameter("@FulFillInfo", adVarWChar, adParamInput, 100, brRec.FulFillInfo)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Product_Update"

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
   ByRef brRec As tProductType, _ 
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
         .ProductID = moUtil.EditLong(.ProductID, "ProductID", True, , 1) 
      End If
      .CompanyID = moUtil.EditLong(.CompanyID, "CompanyID", True) 
      .ProductTypeID = moUtil.EditLong(.ProductTypeID, "ProductTypeID", False) 
      .ProductName = moUtil.EditString(.ProductName, "ProductName", True, , 1, 40) 
      .Image = moUtil.EditString(.Image, "Image", False, , 1, 40) 
      .Price = moUtil.EditCurrency(.Price, "Price", False, , 0, 999999.99) 
      .OriginalPrice = moUtil.EditCurrency(.OriginalPrice, "OriginalPrice", False, , 0, 999999.99) 
      .IsTaxable = moUtil.EditInteger(.IsTaxable, "IsTaxable", False, 0, 0, 1) 
      .TaxRate = moUtil.EditCurrency(.TaxRate, "TaxRate", False, , 0, 999999.9999) 
      .Tax = moUtil.EditCurrency(.Tax, "Tax", False, , 0, 999999.99) 
      .Description = moUtil.EditString(.Description, "Description", False, , 1, 2000) 
      .Seq = moUtil.EditLong(.Seq, "Seq", False, , 1) 
      .IsActive = moUtil.EditInteger(.IsActive, "IsActive", False, 0, 0, 1) 
      .IsPrivate = moUtil.EditInteger(.IsPrivate, "IsPrivate", False, 0, 0, 1) 
      .IsPublic = moUtil.EditInteger(.IsPublic, "IsPublic", False, 0, 0, 1) 
      .NoQty = moUtil.EditInteger(.NoQty, "NoQty", False, 0, 0, 1) 
      .Data = moUtil.EditString(.Data, "Data", False, , 1, 80) 
      .Email = moUtil.EditString(.Email, "Email", False, , 1, 80) 
      .InputOptions = moUtil.EditString(.InputOptions, "InputOptions", False, , 1, 2000) 
      .Ship1 = moUtil.EditCurrency(.Ship1, "Ship1", False, , 0, 999999.99) 
      .Ship2 = moUtil.EditCurrency(.Ship2, "Ship2", False, , 0, 999999.99) 
      .Ship3 = moUtil.EditCurrency(.Ship3, "Ship3", False, , 0, 999999.99) 
      .Ship4 = moUtil.EditCurrency(.Ship4, "Ship4", False, , 0, 999999.99) 
      .Ship1a = moUtil.EditCurrency(.Ship1a, "Ship1a", False, , 0, 999999.99) 
      .Ship2a = moUtil.EditCurrency(.Ship2a, "Ship2a", False, , 0, 999999.99) 
      .Ship3a = moUtil.EditCurrency(.Ship3a, "Ship3a", False, , 0, 999999.99) 
      .Ship4a = moUtil.EditCurrency(.Ship4a, "Ship4a", False, , 0, 999999.99) 
      .Fulfill = moUtil.EditLong(.Fulfill, "Fulfill", False) 
      .Recur = moUtil.EditLong(.Recur, "Recur", False) 
      .RecurTerm = moUtil.EditString(.RecurTerm, "RecurTerm", False, , 1, 10) 
      .CommPlan = moUtil.EditLong(.CommPlan, "CommPlan", False) 
      .BV = moUtil.EditCurrency(.BV, "BV", False, , 0, 999999.99) 
      .QV = moUtil.EditCurrency(.QV, "QV", False, , 0, 999999.99) 
      .Code = moUtil.EditString(.Code, "Code", False, , 1, 10) 
      .Inventory = moUtil.EditLong(.Inventory, "Inventory", False) 
      .InStock = moUtil.EditLong(.InStock, "InStock", False) 
      .ReOrder = moUtil.EditLong(.ReOrder, "ReOrder", False) 
      .IsShip = moUtil.EditInteger(.IsShip, "IsShip", False, 0, 0, 1) 
      .OrderMin = moUtil.EditLong(.OrderMin, "OrderMin", False) 
      .OrderMax = moUtil.EditLong(.OrderMax, "OrderMax", False) 
      .OrderMul = moUtil.EditLong(.OrderMul, "OrderMul", False) 
      .OrderGrp = moUtil.EditString(.OrderGrp, "OrderGrp", False) 
      .Attribute1 = moUtil.EditString(.Attribute1, "Attribute1", False) 
      .Attribute2 = moUtil.EditString(.Attribute2, "Attribute2", False) 
      .Attribute3 = moUtil.EditString(.Attribute3, "Attribute3", False) 
      .Levels = moUtil.EditString(.Levels, "Levels", False) 
      .FulFillInfo = moUtil.EditString(.FulFillInfo, "FulFillInfo", False) 
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