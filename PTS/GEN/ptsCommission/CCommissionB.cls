VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CCommissionB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CCommission"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tCommissionType
   CommissionID As String
   CompanyID As String
   OwnerType As String
   OwnerID As String
   PayoutID As String
   RefID As String
   CommTypeName As String
   CommDate As String
   Status As String
   CommType As String
   Amount As String
   Total As String
   Charge As String
   Description As String
   Notes As String
   Show As String
   FromDate As String
   ToDate As String
End Type

Public Sub Add( _ 
   ByRef brRec As tCommissionType, _ 
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
      .Parameters.Append .CreateParameter("@CommissionID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamInput, vbNull, CLng(brRec.OwnerType))
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamInput, vbNull, CLng(brRec.OwnerID))
      .Parameters.Append .CreateParameter("@PayoutID", adInteger, adParamInput, vbNull, CLng(brRec.PayoutID))
      .Parameters.Append .CreateParameter("@RefID", adInteger, adParamInput, vbNull, CLng(brRec.RefID))
      .Parameters.Append .CreateParameter("@CommDate", adDate, adParamInput, vbNull, CDate(brRec.CommDate))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@CommType", adInteger, adParamInput, vbNull, CLng(brRec.CommType))
      .Parameters.Append .CreateParameter("@Amount", adCurrency, adParamInput, vbNull, CCur(brRec.Amount))
      .Parameters.Append .CreateParameter("@Total", adCurrency, adParamInput, vbNull, CCur(brRec.Total))
      .Parameters.Append .CreateParameter("@Charge", adCurrency, adParamInput, vbNull, CCur(brRec.Charge))
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 100, brRec.Description)
      .Parameters.Append .CreateParameter("@Notes", adVarWChar, adParamInput, 500, brRec.Notes)
      .Parameters.Append .CreateParameter("@Show", adInteger, adParamInput, vbNull, CLng(brRec.Show))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Commission_Add"

   '-----get return values
   With brRec
      .CommissionID = moUtil.FetchLong(oCmd.Parameters.Item("@CommissionID").Value)
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

Public Function TrainerScores( _ 
   ByRef brRec As tCommissionType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "TrainerScores"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@Count", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Commission_TrainerScores"

   '-----get return values
   TrainerScores = moUtil.FetchLong(oCmd.Parameters.Item("@Count").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function CreateCommissions( _ 
   ByRef brRec As tCommissionType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CreateCommissions"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CommDate", adDate, adParamInput, vbNull, CDate(brRec.CommDate))
      .Parameters.Append .CreateParameter("@Count", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Commission_CreateCommissions"

   '-----get return values
   CreateCommissions = moUtil.FetchLong(oCmd.Parameters.Item("@Count").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function CompanyCommissions( _ 
   ByRef brRec As tCommissionType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CompanyCommissions"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@CommType", adInteger, adParamInput, vbNull, CLng(brRec.CommType))
      .Parameters.Append .CreateParameter("@CommDate", adDate, adParamInput, vbNull, CDate(brRec.CommDate))
      .Parameters.Append .CreateParameter("@Count", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Commission_CompanyCommissions"

   '-----get return values
   CompanyCommissions = moUtil.FetchLong(oCmd.Parameters.Item("@Count").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function CustomCommissions( _ 
   ByRef brRec As tCommissionType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CustomCommissions"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@CommType", adInteger, adParamInput, vbNull, CLng(brRec.CommType))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(brRec.FromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(brRec.ToDate))
      .Parameters.Append .CreateParameter("@Count", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Commission_CustomCommissions"

   '-----get return values
   CustomCommissions = moUtil.FetchLong(oCmd.Parameters.Item("@Count").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function TotalCommissions( _ 
   ByRef brRec As tCommissionType, _ 
   ByVal bvUserID As Long) As Currency
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "TotalCommissions"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(brRec.FromDate))
      .Parameters.Append .CreateParameter("@Amount", adCurrency, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Commission_TotalCommissions"

   '-----get return values
   TotalCommissions = moUtil.FetchCurrency(oCmd.Parameters.Item("@Amount").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function SubmitCommissions( _ 
   ByRef brRec As tCommissionType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "SubmitCommissions"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(brRec.FromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(brRec.ToDate))
      .Parameters.Append .CreateParameter("@Count", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Commission_SubmitCommissions"

   '-----get return values
   SubmitCommissions = moUtil.FetchLong(oCmd.Parameters.Item("@Count").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function CalcAdvancement( _ 
   ByRef brRec As tCommissionType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CalcAdvancement"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamInput, vbNull, CLng(brRec.OwnerID))
      .Parameters.Append .CreateParameter("@Count", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Commission_CalcAdvancement"

   '-----get return values
   CalcAdvancement = moUtil.FetchLong(oCmd.Parameters.Item("@Count").Value)

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
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Commission_Count"

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
   ByRef brRec As tCommissionType, _ 
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
      .CommissionID = moUtil.EditLong(.CommissionID, "CommissionID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CommissionID", adInteger, adParamInput, vbNull, CLng(brRec.CommissionID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Commission_Delete"

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
   ByRef brRec As tCommissionType, _ 
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
      .CommissionID = moUtil.EditLong(.CommissionID, "CommissionID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CommissionID", adInteger, adParamInput, vbNull, CLng(brRec.CommissionID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PayoutID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@RefID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CommTypeName", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@CommDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CommType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Amount", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Total", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Charge", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamOutput, 100, vbNull)
      .Parameters.Append .CreateParameter("@Notes", adVarWChar, adParamOutput, 500, vbNull)
      .Parameters.Append .CreateParameter("@Show", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Commission_Fetch"

   '-----get return values
   With brRec
      .CompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@CompanyID").Value)
      .OwnerType = moUtil.FetchLong(oCmd.Parameters.Item("@OwnerType").Value)
      .OwnerID = moUtil.FetchLong(oCmd.Parameters.Item("@OwnerID").Value)
      .PayoutID = moUtil.FetchLong(oCmd.Parameters.Item("@PayoutID").Value)
      .RefID = moUtil.FetchLong(oCmd.Parameters.Item("@RefID").Value)
      .CommTypeName = moUtil.FetchString(oCmd.Parameters.Item("@CommTypeName").Value)
      .CommDate = moUtil.FetchDate(oCmd.Parameters.Item("@CommDate").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .CommType = moUtil.FetchLong(oCmd.Parameters.Item("@CommType").Value)
      .Amount = moUtil.FetchCurrency(oCmd.Parameters.Item("@Amount").Value)
      .Total = moUtil.FetchCurrency(oCmd.Parameters.Item("@Total").Value)
      .Charge = moUtil.FetchCurrency(oCmd.Parameters.Item("@Charge").Value)
      .Description = moUtil.FetchString(oCmd.Parameters.Item("@Description").Value)
      .Notes = moUtil.FetchString(oCmd.Parameters.Item("@Notes").Value)
      .Show = moUtil.FetchLong(oCmd.Parameters.Item("@Show").Value)
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
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tCommissionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Find"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tCommissionType
   Dim vRec As tCommissionType
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
      Case cptsCommissionFindCommDate
         sProc = "pts_Commission_FindCommDate"
         MaxBookMark = 30
      Case cptsCommissionFindCommTypeName
         sProc = "pts_Commission_FindCommTypeName"
         MaxBookMark = 50
      Case cptsCommissionFindCommissionID
         sProc = "pts_Commission_FindCommissionID"
         MaxBookMark = 20
      Case cptsCommissionFindAmount
         sProc = "pts_Commission_FindAmount"
         MaxBookMark = 30
      Case cptsCommissionFindDescription
         sProc = "pts_Commission_FindDescription"
         MaxBookMark = 110
      Case cptsCommissionFindOwnerID
         sProc = "pts_Commission_FindOwnerID"
         MaxBookMark = 20
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
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
               vRec.CommissionID = moUtil.FetchLong(.Fields.Item("CommissionID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.OwnerType = moUtil.FetchLong(.Fields.Item("OwnerType").Value)
               vRec.OwnerID = moUtil.FetchLong(.Fields.Item("OwnerID").Value)
               vRec.PayoutID = moUtil.FetchLong(.Fields.Item("PayoutID").Value)
               vRec.RefID = moUtil.FetchLong(.Fields.Item("RefID").Value)
               vRec.CommTypeName = moUtil.FetchString(.Fields.Item("CommTypeName").Value)
               vRec.CommDate = moUtil.FetchDate(.Fields.Item("CommDate").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.CommType = moUtil.FetchLong(.Fields.Item("CommType").Value)
               vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
               vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
               vRec.Charge = moUtil.FetchCurrency(.Fields.Item("Charge").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
               vRec.Show = moUtil.FetchLong(.Fields.Item("Show").Value)
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

Public Function FindOwner( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvOwnerType As Long, _ 
   ByVal bvOwnerID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tCommissionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindOwner"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tCommissionType
   Dim vRec As tCommissionType
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
      Case cptsCommissionFindCommDate
         sProc = "pts_Commission_FindOwnerCommDate"
         MaxBookMark = 30
      Case cptsCommissionFindCommTypeName
         sProc = "pts_Commission_FindOwnerCommTypeName"
         MaxBookMark = 50
      Case cptsCommissionFindCommissionID
         sProc = "pts_Commission_FindOwnerCommissionID"
         MaxBookMark = 20
      Case cptsCommissionFindAmount
         sProc = "pts_Commission_FindOwnerAmount"
         MaxBookMark = 30
      Case cptsCommissionFindDescription
         sProc = "pts_Commission_FindOwnerDescription"
         MaxBookMark = 110
      Case cptsCommissionFindOwnerID
         sProc = "pts_Commission_FindOwnerOwnerID"
         MaxBookMark = 20
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamInput, vbNull, CLng(bvOwnerType))
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamInput, vbNull, CLng(bvOwnerID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
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
               vRec.CommissionID = moUtil.FetchLong(.Fields.Item("CommissionID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.OwnerType = moUtil.FetchLong(.Fields.Item("OwnerType").Value)
               vRec.OwnerID = moUtil.FetchLong(.Fields.Item("OwnerID").Value)
               vRec.PayoutID = moUtil.FetchLong(.Fields.Item("PayoutID").Value)
               vRec.RefID = moUtil.FetchLong(.Fields.Item("RefID").Value)
               vRec.CommTypeName = moUtil.FetchString(.Fields.Item("CommTypeName").Value)
               vRec.CommDate = moUtil.FetchDate(.Fields.Item("CommDate").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.CommType = moUtil.FetchLong(.Fields.Item("CommType").Value)
               vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
               vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
               vRec.Charge = moUtil.FetchCurrency(.Fields.Item("Charge").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
               vRec.Show = moUtil.FetchLong(.Fields.Item("Show").Value)
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
   FindOwner = vRecs

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

Public Function FindOwnerShow( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvOwnerType As Long, _ 
   ByVal bvOwnerID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date, _ 
   ByVal bvShow As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tCommissionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindOwnerShow"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tCommissionType
   Dim vRec As tCommissionType
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
      Case cptsCommissionFindCommDate
         sProc = "pts_Commission_FindOwnerShowCommDate"
         MaxBookMark = 30
      Case cptsCommissionFindCommTypeName
         sProc = "pts_Commission_FindOwnerShowCommTypeName"
         MaxBookMark = 50
      Case cptsCommissionFindCommissionID
         sProc = "pts_Commission_FindOwnerShowCommissionID"
         MaxBookMark = 20
      Case cptsCommissionFindAmount
         sProc = "pts_Commission_FindOwnerShowAmount"
         MaxBookMark = 30
      Case cptsCommissionFindDescription
         sProc = "pts_Commission_FindOwnerShowDescription"
         MaxBookMark = 110
      Case cptsCommissionFindOwnerID
         sProc = "pts_Commission_FindOwnerShowOwnerID"
         MaxBookMark = 20
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamInput, vbNull, CLng(bvOwnerType))
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamInput, vbNull, CLng(bvOwnerID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
      .Parameters.Append .CreateParameter("@Show", adInteger, adParamInput, vbNull, CLng(bvShow))
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
               vRec.CommissionID = moUtil.FetchLong(.Fields.Item("CommissionID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.OwnerType = moUtil.FetchLong(.Fields.Item("OwnerType").Value)
               vRec.OwnerID = moUtil.FetchLong(.Fields.Item("OwnerID").Value)
               vRec.PayoutID = moUtil.FetchLong(.Fields.Item("PayoutID").Value)
               vRec.RefID = moUtil.FetchLong(.Fields.Item("RefID").Value)
               vRec.CommTypeName = moUtil.FetchString(.Fields.Item("CommTypeName").Value)
               vRec.CommDate = moUtil.FetchDate(.Fields.Item("CommDate").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.CommType = moUtil.FetchLong(.Fields.Item("CommType").Value)
               vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
               vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
               vRec.Charge = moUtil.FetchCurrency(.Fields.Item("Charge").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
               vRec.Show = moUtil.FetchLong(.Fields.Item("Show").Value)
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
   FindOwnerShow = vRecs

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

Public Function FindPayout( _ 
   ByVal bvFindType As Long, _ 
   ByRef brBookMark As String, _ 
   ByVal bvSearchText As String, _ 
   ByVal bvDirection As wtSystem.WTBookmarkConstants, _ 
   ByVal bvPayoutID As Long, _ 
   ByVal bvCommType As Long, _ 
   Optional ByVal bvSecurityToken As Long = 0) As tCommissionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of records which match the specified search criteria.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FindPayout"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tCommissionType
   Dim vRec As tCommissionType
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
      Case cptsCommissionFindCommDate
         sProc = "pts_Commission_FindPayoutCommDate"
         MaxBookMark = 30
      Case cptsCommissionFindCommTypeName
         sProc = "pts_Commission_FindPayoutCommTypeName"
         MaxBookMark = 50
      Case cptsCommissionFindCommissionID
         sProc = "pts_Commission_FindPayoutCommissionID"
         MaxBookMark = 20
      Case cptsCommissionFindAmount
         sProc = "pts_Commission_FindPayoutAmount"
         MaxBookMark = 30
      Case cptsCommissionFindDescription
         sProc = "pts_Commission_FindPayoutDescription"
         MaxBookMark = 110
      Case cptsCommissionFindOwnerID
         sProc = "pts_Commission_FindPayoutOwnerID"
         MaxBookMark = 20
   End Select

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@SearchText", adVarWChar, adParamInput, MaxBookMark, oBookMark.SearchText)
      .Parameters.Append .CreateParameter("@Bookmark", adVarWChar, adParamInput, MaxBookMark, oBookMark.CurrentBookmark)
      .Parameters.Append .CreateParameter("@MaxRows", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PayoutID", adInteger, adParamInput, vbNull, CLng(bvPayoutID))
      .Parameters.Append .CreateParameter("@CommType", adInteger, adParamInput, vbNull, CLng(bvCommType))
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
               vRec.CommissionID = moUtil.FetchLong(.Fields.Item("CommissionID").Value)
               vRec.CompanyID = moUtil.FetchLong(.Fields.Item("CompanyID").Value)
               vRec.OwnerType = moUtil.FetchLong(.Fields.Item("OwnerType").Value)
               vRec.OwnerID = moUtil.FetchLong(.Fields.Item("OwnerID").Value)
               vRec.PayoutID = moUtil.FetchLong(.Fields.Item("PayoutID").Value)
               vRec.RefID = moUtil.FetchLong(.Fields.Item("RefID").Value)
               vRec.CommTypeName = moUtil.FetchString(.Fields.Item("CommTypeName").Value)
               vRec.CommDate = moUtil.FetchDate(.Fields.Item("CommDate").Value)
               vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
               vRec.CommType = moUtil.FetchLong(.Fields.Item("CommType").Value)
               vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
               vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
               vRec.Charge = moUtil.FetchCurrency(.Fields.Item("Charge").Value)
               vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
               vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
               vRec.Show = moUtil.FetchLong(.Fields.Item("Show").Value)
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
   FindPayout = vRecs

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

Public Function ListPayout( _ 
   ByVal bvPayoutID As Long, _ 
   ByVal bvCommType As Long) As tCommissionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListPayout"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tCommissionType
   Dim vRec As tCommissionType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@PayoutID", adInteger, adParamInput, vbNull, CLng(bvPayoutID))
      .Parameters.Append .CreateParameter("@CommType", adInteger, adParamInput, vbNull, CLng(bvCommType))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Commission_ListPayout")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.CommissionID = moUtil.FetchLong(.Fields.Item("CommissionID").Value)
            vRec.PayoutID = moUtil.FetchLong(.Fields.Item("PayoutID").Value)
            vRec.RefID = moUtil.FetchLong(.Fields.Item("RefID").Value)
            vRec.CommDate = moUtil.FetchDate(.Fields.Item("CommDate").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.CommType = moUtil.FetchLong(.Fields.Item("CommType").Value)
            vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
            vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
            vRec.Charge = moUtil.FetchCurrency(.Fields.Item("Charge").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListPayout = vRecs

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

Public Function ListPayoutSummary( _ 
   ByVal bvPayoutID As Long) As tCommissionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListPayoutSummary"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tCommissionType
   Dim vRec As tCommissionType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@PayoutID", adInteger, adParamInput, vbNull, CLng(bvPayoutID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Commission_ListPayoutSummary")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.CommissionID = moUtil.FetchLong(.Fields.Item("CommissionID").Value)
            vRec.CommType = moUtil.FetchLong(.Fields.Item("CommType").Value)
            vRec.CommTypeName = moUtil.FetchString(.Fields.Item("CommTypeName").Value)
            vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListPayoutSummary = vRecs

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

Public Function Report( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date) As tCommissionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Report"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tCommissionType
   Dim vRec As tCommissionType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Commission_Report")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.CommissionID = moUtil.FetchLong(.Fields.Item("CommissionID").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Amount = moUtil.FetchCurrency(.Fields.Item("Amount").Value)
            vRec.CommTypeName = moUtil.FetchString(.Fields.Item("CommTypeName").Value)
            vRec.CommDate = moUtil.FetchDate(.Fields.Item("CommDate").Value)
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
   Report = vRecs

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

Public Function Email( _ 
   ByVal bvCompanyID As Long, _ 
   ByVal bvRefID As Long, _ 
   ByVal bvFromDate As Date, _ 
   ByVal bvToDate As Date) As tCommissionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Email"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tCommissionType
   Dim vRec As tCommissionType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(bvCompanyID))
      .Parameters.Append .CreateParameter("@RefID", adInteger, adParamInput, vbNull, CLng(bvRefID))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(bvFromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(bvToDate))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Commission_Email")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.CommissionID = moUtil.FetchLong(.Fields.Item("CommissionID").Value)
            vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   Email = vRecs

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

Public Function ListRef( _ 
   ByVal bvRefID As Long) As tCommissionType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListRef"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tCommissionType
   Dim vRec As tCommissionType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@RefID", adInteger, adParamInput, vbNull, CLng(bvRefID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Commission_ListRef")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.CommissionID = moUtil.FetchLong(.Fields.Item("CommissionID").Value)
            vRec.CommType = moUtil.FetchLong(.Fields.Item("CommType").Value)
            vRec.CommTypeName = moUtil.FetchString(.Fields.Item("CommTypeName").Value)
            vRec.Notes = moUtil.FetchString(.Fields.Item("Notes").Value)
            vRec.Description = moUtil.FetchString(.Fields.Item("Description").Value)
            vRec.CommDate = moUtil.FetchDate(.Fields.Item("CommDate").Value)
            vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListRef = vRecs

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
   ByRef brRec As tCommissionType, _ 
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
      .Parameters.Append .CreateParameter("@CommissionID", adInteger, adParamInput, vbNull, CLng(brRec.CommissionID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamInput, vbNull, CLng(brRec.OwnerType))
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamInput, vbNull, CLng(brRec.OwnerID))
      .Parameters.Append .CreateParameter("@PayoutID", adInteger, adParamInput, vbNull, CLng(brRec.PayoutID))
      .Parameters.Append .CreateParameter("@RefID", adInteger, adParamInput, vbNull, CLng(brRec.RefID))
      .Parameters.Append .CreateParameter("@CommDate", adDate, adParamInput, vbNull, CDate(brRec.CommDate))
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@CommType", adInteger, adParamInput, vbNull, CLng(brRec.CommType))
      .Parameters.Append .CreateParameter("@Amount", adCurrency, adParamInput, vbNull, CCur(brRec.Amount))
      .Parameters.Append .CreateParameter("@Total", adCurrency, adParamInput, vbNull, CCur(brRec.Total))
      .Parameters.Append .CreateParameter("@Charge", adCurrency, adParamInput, vbNull, CCur(brRec.Charge))
      .Parameters.Append .CreateParameter("@Description", adVarWChar, adParamInput, 100, brRec.Description)
      .Parameters.Append .CreateParameter("@Notes", adVarWChar, adParamInput, 500, brRec.Notes)
      .Parameters.Append .CreateParameter("@Show", adInteger, adParamInput, vbNull, CLng(brRec.Show))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Commission_Update"

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
   ByRef brRec As tCommissionType, _ 
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
         .CommissionID = moUtil.EditLong(.CommissionID, "CommissionID", True, , 1) 
      End If
      .CompanyID = moUtil.EditLong(.CompanyID, "CompanyID", False, , 1) 
      .OwnerType = moUtil.EditLong(.OwnerType, "OwnerType", False, , 1) 
      .OwnerID = moUtil.EditLong(.OwnerID, "OwnerID", False, , 1) 
      .PayoutID = moUtil.EditLong(.PayoutID, "PayoutID", False) 
      .RefID = moUtil.EditLong(.RefID, "RefID", False) 
      .CommDate = moUtil.EditDate(.CommDate, "CommDate", False) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .CommType = moUtil.EditLong(.CommType, "CommType", False) 
      .Amount = moUtil.EditCurrency(.Amount, "Amount", False, , -9999999.99, 9999999.99) 
      .Total = moUtil.EditCurrency(.Total, "Total", False, , -9999999.99, 9999999.99) 
      .Charge = moUtil.EditCurrency(.Charge, "Charge", False, , -9999999.99, 9999999.99) 
      .Description = moUtil.EditString(.Description, "Description", True, , 1, 100) 
      .Notes = moUtil.EditString(.Notes, "Notes", False, , 1, 500) 
      .Show = moUtil.EditLong(.Show, "Show", False) 
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