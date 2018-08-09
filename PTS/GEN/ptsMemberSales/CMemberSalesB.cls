VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CMemberSalesB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CMemberSales"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tMemberSalesType
   MemberSalesID As String
   MemberID As String
   CompanyID As String
   TitleName As String
   SalesDate As String
   Title As String
   PV As String
   GV As String
   PV2 As String
   GV2 As String
End Type

Public Sub Add( _ 
   ByRef brRec As tMemberSalesType, _ 
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
      .Parameters.Append .CreateParameter("@MemberSalesID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@SalesDate", adDate, adParamInput, vbNull, CDate(brRec.SalesDate))
      .Parameters.Append .CreateParameter("@Title", adInteger, adParamInput, vbNull, CLng(brRec.Title))
      .Parameters.Append .CreateParameter("@PV", adCurrency, adParamInput, vbNull, CCur(brRec.PV))
      .Parameters.Append .CreateParameter("@GV", adCurrency, adParamInput, vbNull, CCur(brRec.GV))
      .Parameters.Append .CreateParameter("@PV2", adCurrency, adParamInput, vbNull, CCur(brRec.PV2))
      .Parameters.Append .CreateParameter("@GV2", adCurrency, adParamInput, vbNull, CCur(brRec.GV2))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MemberSales_Add"

   '-----get return values
   With brRec
      .MemberSalesID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberSalesID").Value)
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
   ByRef brRec As tMemberSalesType, _ 
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
      .MemberSalesID = moUtil.EditLong(.MemberSalesID, "MemberSalesID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberSalesID", adInteger, adParamInput, vbNull, CLng(brRec.MemberSalesID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MemberSales_Delete"

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
   ByRef brRec As tMemberSalesType, _ 
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
      .MemberSalesID = moUtil.EditLong(.MemberSalesID, "MemberSalesID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberSalesID", adInteger, adParamInput, vbNull, CLng(brRec.MemberSalesID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@TitleName", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@SalesDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Title", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PV", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@GV", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PV2", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@GV2", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MemberSales_Fetch"

   '-----get return values
   With brRec
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .CompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@CompanyID").Value)
      .TitleName = moUtil.FetchString(oCmd.Parameters.Item("@TitleName").Value)
      .SalesDate = moUtil.FetchDate(oCmd.Parameters.Item("@SalesDate").Value)
      .Title = moUtil.FetchLong(oCmd.Parameters.Item("@Title").Value)
      .PV = moUtil.FetchCurrency(oCmd.Parameters.Item("@PV").Value)
      .GV = moUtil.FetchCurrency(oCmd.Parameters.Item("@GV").Value)
      .PV2 = moUtil.FetchCurrency(oCmd.Parameters.Item("@PV2").Value)
      .GV2 = moUtil.FetchCurrency(oCmd.Parameters.Item("@GV2").Value)
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

Public Function ListMember( _ 
   ByVal bvMemberID As Long) As tMemberSalesType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tMemberSalesType
   Dim vRec As tMemberSalesType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MemberSales_ListMember")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.MemberSalesID = moUtil.FetchLong(.Fields.Item("MemberSalesID").Value)
            vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
            vRec.SalesDate = moUtil.FetchDate(.Fields.Item("SalesDate").Value)
            vRec.Title = moUtil.FetchLong(.Fields.Item("Title").Value)
            vRec.TitleName = moUtil.FetchString(.Fields.Item("TitleName").Value)
            vRec.PV = moUtil.FetchCurrency(.Fields.Item("PV").Value)
            vRec.GV = moUtil.FetchCurrency(.Fields.Item("GV").Value)
            vRec.PV2 = moUtil.FetchCurrency(.Fields.Item("PV2").Value)
            vRec.GV2 = moUtil.FetchCurrency(.Fields.Item("GV2").Value)
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

Public Sub Update( _ 
   ByRef brRec As tMemberSalesType, _ 
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
      .Parameters.Append .CreateParameter("@MemberSalesID", adInteger, adParamInput, vbNull, CLng(brRec.MemberSalesID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@SalesDate", adDate, adParamInput, vbNull, CDate(brRec.SalesDate))
      .Parameters.Append .CreateParameter("@Title", adInteger, adParamInput, vbNull, CLng(brRec.Title))
      .Parameters.Append .CreateParameter("@PV", adCurrency, adParamInput, vbNull, CCur(brRec.PV))
      .Parameters.Append .CreateParameter("@GV", adCurrency, adParamInput, vbNull, CCur(brRec.GV))
      .Parameters.Append .CreateParameter("@PV2", adCurrency, adParamInput, vbNull, CCur(brRec.PV2))
      .Parameters.Append .CreateParameter("@GV2", adCurrency, adParamInput, vbNull, CCur(brRec.GV2))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_MemberSales_Update"

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
   ByRef brRec As tMemberSalesType, _ 
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
         .MemberSalesID = moUtil.EditLong(.MemberSalesID, "MemberSalesID", True, , 1) 
      End If
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", False) 
      .CompanyID = moUtil.EditLong(.CompanyID, "CompanyID", False) 
      .SalesDate = moUtil.EditDate(.SalesDate, "SalesDate", False) 
      .Title = moUtil.EditLong(.Title, "Title", False) 
      .PV = moUtil.EditCurrency(.PV, "PV", False, , 0, 999999999.99) 
      .GV = moUtil.EditCurrency(.GV, "GV", False, , 0, 999999999.99) 
      .PV2 = moUtil.EditCurrency(.PV2, "PV2", False, , 0, 999999999.99) 
      .GV2 = moUtil.EditCurrency(.GV2, "GV2", False, , 0, 999999999.99) 
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