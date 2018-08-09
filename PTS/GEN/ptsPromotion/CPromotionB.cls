VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CPromotionB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CPromotion"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tPromotionType
   PromotionID As String
   CompanyID As String
   ProductID As String
   PromotionName As String
   Description As String
   Code As String
   Amount As String
   Rate As String
   StartDate As String
   EndDate As String
   Qty As String
   Used As String
   Products As String
End Type

Public Sub Add( _ 
   ByRef brRec As tPromotionType, _ 
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
      .Parameters.Append .CreateParameter("@PromotionID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@ProductID", adInteger, adParamInput, vbNull, CLng(brRec.ProductID))
      .Parameters.Append .CreateParameter("@PromotionName", adVarWChar, adParamInput, 60, brRec.PromotionName)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 500, brRec.Description)
      .Parameters.Append .CreateParameter("@Code", adVarWChar, adParamInput, 6, brRec.Code)
      .Parameters.Append .CreateParameter("@Amount", adCurrency, adParamInput, vbNull, CCur(brRec.Amount))
      .Parameters.Append .CreateParameter("@Rate", adCurrency, adParamInput, vbNull, CCur(brRec.Rate))
      .Parameters.Append .CreateParameter("@StartDate", adDate, adParamInput, vbNull, CDate(brRec.StartDate))
      .Parameters.Append .CreateParameter("@EndDate", adDate, adParamInput, vbNull, CDate(brRec.EndDate))
      .Parameters.Append .CreateParameter("@Qty", adInteger, adParamInput, vbNull, CLng(brRec.Qty))
      .Parameters.Append .CreateParameter("@Used", adInteger, adParamInput, vbNull, CLng(brRec.Used))
      .Parameters.Append .CreateParameter("@Products", adVarWChar, adParamInput, 50, brRec.Products)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Promotion_Add"

   '-----get return values
   With brRec
      .PromotionID = moUtil.FetchLong(oCmd.Parameters.Item("@PromotionID").Value)
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

Public Function GetUsed( _ 
   ByRef brRec As tPromotionType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "GetUsed"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@PromotionID", adInteger, adParamInput, vbNull, CLng(brRec.PromotionID))
      .Parameters.Append .CreateParameter("@Result", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Promotion_GetUsed"

   '-----get return values
   GetUsed = moUtil.FetchLong(oCmd.Parameters.Item("@Result").Value)

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
   ByRef brRec As tPromotionType, _ 
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
      .PromotionID = moUtil.EditLong(.PromotionID, "PromotionID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@PromotionID", adInteger, adParamInput, vbNull, CLng(brRec.PromotionID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Promotion_Delete"

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
   ByRef brRec As tPromotionType, _ 
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
      .PromotionID = moUtil.EditLong(.PromotionID, "PromotionID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@PromotionID", adInteger, adParamInput, vbNull, CLng(brRec.PromotionID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ProductID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PromotionName", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamOutput, 500, vbNull)
      .Parameters.Append .CreateParameter("@Code", adVarWChar, adParamOutput, 6, vbNull)
      .Parameters.Append .CreateParameter("@Amount", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Rate", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@StartDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@EndDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Qty", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Used", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Products", adVarWChar, adParamOutput, 50, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Promotion_Fetch"

   '-----get return values
   With brRec
      .CompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@CompanyID").Value)
      .ProductID = moUtil.FetchLong(oCmd.Parameters.Item("@ProductID").Value)
      .PromotionName = moUtil.FetchString(oCmd.Parameters.Item("@PromotionName").Value)
      .Description = moUtil.FetchString(oCmd.Parameters.Item("@Description").Value)
      .Code = moUtil.FetchString(oCmd.Parameters.Item("@Code").Value)
      .Amount = moUtil.FetchCurrency(oCmd.Parameters.Item("@Amount").Value)
      .Rate = moUtil.FetchCurrency(oCmd.Parameters.Item("@Rate").Value)
      .StartDate = moUtil.FetchDate(oCmd.Parameters.Item("@StartDate").Value)
      .EndDate = moUtil.FetchDate(oCmd.Parameters.Item("@EndDate").Value)
      .Qty = moUtil.FetchLong(oCmd.Parameters.Item("@Qty").Value)
      .Used = moUtil.FetchLong(oCmd.Parameters.Item("@Used").Value)
      .Products = moUtil.FetchString(oCmd.Parameters.Item("@Products").Value)
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
   Optional ByVal bvSecurityToken As Long = 0) As tPromotionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tPromotionType
   Dim vRec As tPromotionType
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
      Case cptsPromotionFindPromotionName
         sProc = "pts_Promotion_FindPromotionName"
         MaxBookMark = 70
      Case cptsPromotionFindCode
         sProc = "pts_Promotion_FindCode"
         MaxBookMark = 16
      Case cptsPromotionFindDescription
         sProc = "pts_Promotion_FindDescription"
         MaxBookMark = 510
      Case cptsPromotionFindPromotionID
         sProc = "pts_Promotion_FindPromotionID"
         MaxBookMark = 20
      Case cptsPromotionFindProductID
         sProc = "pts_Promotion_FindProductID"
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
               vRec.PromotionID = moUtil.FetchLong(.Fields.Item("PromotionID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.ProductID = moUtil.FetchLong(.Fields.Item("ProductID").Value)
               vRec.PromotionName = moUtil.FetchString(.Fields.Item("PromotionName").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Code = moUtil.FetchString(.Fields.Item("Code").Value)
               vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
               vRec.Rate = moUtil.FetchCurrency(.Fields.Item("Rate").Value)
               vRec.StartDate = moUtil.FetchDate(.Fields.Item("StartDate").Value)
               vRec.EndDate = moUtil.FetchDate(.Fields.Item("EndDate").Value)
               vRec.Qty = moUtil.FetchLong(.Fields.Item("Qty").Value)
               vRec.Used = moUtil.FetchLong(.Fields.Item("Used").Value)
               vRec.Products = moUtil.FetchString(.Fields.Item("Products").Value)
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

Public Sub Update( _ 
   ByRef brRec As tPromotionType, _ 
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
      .Parameters.Append .CreateParameter("@PromotionID", adInteger, adParamInput, vbNull, CLng(brRec.PromotionID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@ProductID", adInteger, adParamInput, vbNull, CLng(brRec.ProductID))
      .Parameters.Append .CreateParameter("@PromotionName", adVarWChar, adParamInput, 60, brRec.PromotionName)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 500, brRec.Description)
      .Parameters.Append .CreateParameter("@Code", adVarWChar, adParamInput, 6, brRec.Code)
      .Parameters.Append .CreateParameter("@Amount", adCurrency, adParamInput, vbNull, CCur(brRec.Amount))
      .Parameters.Append .CreateParameter("@Rate", adCurrency, adParamInput, vbNull, CCur(brRec.Rate))
      .Parameters.Append .CreateParameter("@StartDate", adDate, adParamInput, vbNull, CDate(brRec.StartDate))
      .Parameters.Append .CreateParameter("@EndDate", adDate, adParamInput, vbNull, CDate(brRec.EndDate))
      .Parameters.Append .CreateParameter("@Qty", adInteger, adParamInput, vbNull, CLng(brRec.Qty))
      .Parameters.Append .CreateParameter("@Used", adInteger, adParamInput, vbNull, CLng(brRec.Used))
      .Parameters.Append .CreateParameter("@Products", adVarWChar, adParamInput, 50, brRec.Products)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Promotion_Update"

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
   ByRef brRec As tPromotionType, _ 
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
         .PromotionID = moUtil.EditLong(.PromotionID, "PromotionID", True, , 1) 
      End If
      .CompanyID = moUtil.EditLong(.CompanyID, "CompanyID", False) 
      .ProductID = moUtil.EditLong(.ProductID, "ProductID", False) 
      .PromotionName = moUtil.EditString(.PromotionName, "PromotionName", True, , 1, 60) 
      .Description = moUtil.EditString(.Description, "Description", False, , 1, 500) 
      .Code = moUtil.EditString(.Code, "Code", False, , 1, 6) 
      .Amount = moUtil.EditCurrency(.Amount, "Amount", False, , 0, 999999.99) 
      .Rate = moUtil.EditCurrency(.Rate, "Rate", False, , 0, 999.999) 
      .StartDate = moUtil.EditDate(.StartDate, "StartDate", False) 
      .EndDate = moUtil.EditDate(.EndDate, "EndDate", False) 
      .Qty = moUtil.EditLong(.Qty, "Qty", False) 
      .Used = moUtil.EditLong(.Used, "Used", False) 
      .Products = moUtil.EditString(.Products, "Products", False, , 1, 50) 
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