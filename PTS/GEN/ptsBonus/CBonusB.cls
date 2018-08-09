VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CBonusB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CBonus"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tBonusType
   BonusID As String
   CompanyID As String
   MemberID As String
   TitleName As String
   BonusDate As String
   Title As String
   BV As String
   QV As String
   Total As String
   PaidDate As String
   Reference As String
   IsPrivate As String
   FromDate As String
   ToDate As String
End Type

Public Sub Add( _ 
   ByRef brRec As tBonusType, _ 
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
      .Parameters.Append .CreateParameter("@BonusID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@BonusDate", adDate, adParamInput, vbNull, CDate(brRec.BonusDate))
      .Parameters.Append .CreateParameter("@Title", adInteger, adParamInput, vbNull, CLng(brRec.Title))
      .Parameters.Append .CreateParameter("@BV", adCurrency, adParamInput, vbNull, CCur(brRec.BV))
      .Parameters.Append .CreateParameter("@QV", adCurrency, adParamInput, vbNull, CCur(brRec.QV))
      .Parameters.Append .CreateParameter("@Total", adCurrency, adParamInput, vbNull, CCur(brRec.Total))
      .Parameters.Append .CreateParameter("@PaidDate", adDate, adParamInput, vbNull, CDate(brRec.PaidDate))
      .Parameters.Append .CreateParameter("@Reference", adVarWChar, adParamInput, 20, brRec.Reference)
      .Parameters.Append .CreateParameter("@IsPrivate", adSmallInt, adParamInput, vbNull, CInt(brRec.IsPrivate))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Bonus_Add"

   '-----get return values
   With brRec
      .BonusID = moUtil.FetchLong(oCmd.Parameters.Item("@BonusID").Value)
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

Public Function CreateBonuses( _ 
   ByRef brRec As tBonusType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CreateBonuses"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@BonusDate", adDate, adParamInput, vbNull, CDate(brRec.BonusDate))
      .Parameters.Append .CreateParameter("@FromDate", adDate, adParamInput, vbNull, CDate(brRec.FromDate))
      .Parameters.Append .CreateParameter("@ToDate", adDate, adParamInput, vbNull, CDate(brRec.ToDate))
      .Parameters.Append .CreateParameter("@Count", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Bonus_CreateBonuses"

   '-----get return values
   CreateBonuses = moUtil.FetchLong(oCmd.Parameters.Item("@Count").Value)

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
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Bonus_Count"

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
   ByRef brRec As tBonusType, _ 
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
      .BonusID = moUtil.EditLong(.BonusID, "BonusID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@BonusID", adInteger, adParamInput, vbNull, CLng(brRec.BonusID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Bonus_Delete"

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
   ByRef brRec As tBonusType, _ 
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
      .BonusID = moUtil.EditLong(.BonusID, "BonusID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@BonusID", adInteger, adParamInput, vbNull, CLng(brRec.BonusID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@TitleName", adVarWChar, adParamOutput, 40, vbNull)
      .Parameters.Append .CreateParameter("@BonusDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Title", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@BV", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@QV", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Total", adCurrency, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@PaidDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Reference", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@IsPrivate", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Bonus_Fetch"

   '-----get return values
   With brRec
      .CompanyID = moUtil.FetchLong(oCmd.Parameters.Item("@CompanyID").Value)
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .TitleName = moUtil.FetchString(oCmd.Parameters.Item("@TitleName").Value)
      .BonusDate = moUtil.FetchDate(oCmd.Parameters.Item("@BonusDate").Value)
      .Title = moUtil.FetchLong(oCmd.Parameters.Item("@Title").Value)
      .BV = moUtil.FetchCurrency(oCmd.Parameters.Item("@BV").Value)
      .QV = moUtil.FetchCurrency(oCmd.Parameters.Item("@QV").Value)
      .Total = moUtil.FetchCurrency(oCmd.Parameters.Item("@Total").Value)
      .PaidDate = moUtil.FetchDate(oCmd.Parameters.Item("@PaidDate").Value)
      .Reference = moUtil.FetchString(oCmd.Parameters.Item("@Reference").Value)
      .IsPrivate = moUtil.FetchInteger(oCmd.Parameters.Item("@IsPrivate").Value)
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
   ByVal bvMemberID As Long) As tBonusType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tBonusType
   Dim vRec As tBonusType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Bonus_ListMember")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.BonusID = moUtil.FetchLong(.Fields.Item("BonusID").Value)
            vRec.BonusDate = moUtil.FetchDate(.Fields.Item("BonusDate").Value)
            vRec.TitleName = moUtil.FetchString(.Fields.Item("TitleName").Value)
            vRec.BV = moUtil.FetchCurrency(.Fields.Item("BV").Value)
            vRec.QV = moUtil.FetchCurrency(.Fields.Item("QV").Value)
            vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
            vRec.PaidDate = moUtil.FetchDate(.Fields.Item("PaidDate").Value)
            vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
            vRec.IsPrivate = moUtil.FetchInteger(.Fields.Item("IsPrivate").Value)
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

Public Function ListMemberAll( _ 
   ByVal bvMemberID As Long) As tBonusType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListMemberAll"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tBonusType
   Dim vRec As tBonusType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Bonus_ListMemberAll")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.BonusID = moUtil.FetchLong(.Fields.Item("BonusID").Value)
            vRec.BonusDate = moUtil.FetchDate(.Fields.Item("BonusDate").Value)
            vRec.TitleName = moUtil.FetchString(.Fields.Item("TitleName").Value)
            vRec.BV = moUtil.FetchCurrency(.Fields.Item("BV").Value)
            vRec.QV = moUtil.FetchCurrency(.Fields.Item("QV").Value)
            vRec.Total = moUtil.FetchCurrency(.Fields.Item("Total").Value)
            vRec.PaidDate = moUtil.FetchDate(.Fields.Item("PaidDate").Value)
            vRec.Reference = moUtil.FetchString(.Fields.Item("Reference").Value)
            vRec.IsPrivate = moUtil.FetchInteger(.Fields.Item("IsPrivate").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListMemberAll = vRecs

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
   ByRef brRec As tBonusType, _ 
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
      .Parameters.Append .CreateParameter("@BonusID", adInteger, adParamInput, vbNull, CLng(brRec.BonusID))
      .Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamInput, vbNull, CLng(brRec.CompanyID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@BonusDate", adDate, adParamInput, vbNull, CDate(brRec.BonusDate))
      .Parameters.Append .CreateParameter("@Title", adInteger, adParamInput, vbNull, CLng(brRec.Title))
      .Parameters.Append .CreateParameter("@BV", adCurrency, adParamInput, vbNull, CCur(brRec.BV))
      .Parameters.Append .CreateParameter("@QV", adCurrency, adParamInput, vbNull, CCur(brRec.QV))
      .Parameters.Append .CreateParameter("@Total", adCurrency, adParamInput, vbNull, CCur(brRec.Total))
      .Parameters.Append .CreateParameter("@PaidDate", adDate, adParamInput, vbNull, CDate(brRec.PaidDate))
      .Parameters.Append .CreateParameter("@Reference", adVarWChar, adParamInput, 20, brRec.Reference)
      .Parameters.Append .CreateParameter("@IsPrivate", adSmallInt, adParamInput, vbNull, CInt(brRec.IsPrivate))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Bonus_Update"

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
   ByRef brRec As tBonusType, _ 
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
         .BonusID = moUtil.EditLong(.BonusID, "BonusID", True, , 1) 
      End If
      .CompanyID = moUtil.EditLong(.CompanyID, "CompanyID", False, , 1) 
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", False, , 1) 
      .BonusDate = moUtil.EditDate(.BonusDate, "BonusDate", False) 
      .Title = moUtil.EditLong(.Title, "Title", False) 
      .BV = moUtil.EditCurrency(.BV, "BV", False, , 0, 999999.99) 
      .QV = moUtil.EditCurrency(.QV, "QV", False, , 0, 999999.99) 
      .Total = moUtil.EditCurrency(.Total, "Total", False, , -9999999.99, 9999999.99) 
      .PaidDate = moUtil.EditDate(.PaidDate, "PaidDate", False) 
      .Reference = moUtil.EditString(.Reference, "Reference", False) 
      .IsPrivate = moUtil.EditInteger(.IsPrivate, "IsPrivate", False, 0, 0, 1) 
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