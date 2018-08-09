VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CGovidB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CGovid"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tGovidType
   GovidID As String
   MemberID As String
   CountryID As String
   GType As String
   GNumber As String
   Issuer As String
   IssueDate As String
   ExpDate As String
End Type

Public Sub Add( _ 
   ByRef brRec As tGovidType, _ 
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
      .Parameters.Append .CreateParameter("@GovidID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamInput, vbNull, CLng(brRec.CountryID))
      .Parameters.Append .CreateParameter("@GType", adInteger, adParamInput, vbNull, CLng(brRec.GType))
      .Parameters.Append .CreateParameter("@GNumber", adVarWChar, adParamInput, 50, brRec.GNumber)
      .Parameters.Append .CreateParameter("@Issuer", adVarWChar, adParamInput, 2, brRec.Issuer)
      .Parameters.Append .CreateParameter("@IssueDate", adDate, adParamInput, vbNull, CDate(brRec.IssueDate))
      .Parameters.Append .CreateParameter("@ExpDate", adDate, adParamInput, vbNull, CDate(brRec.ExpDate))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Govid_Add"

   '-----get return values
   With brRec
      .GovidID = moUtil.FetchLong(oCmd.Parameters.Item("@GovidID").Value)
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
   ByRef brRec As tGovidType, _ 
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
      .GovidID = moUtil.EditLong(.GovidID, "GovidID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@GovidID", adInteger, adParamInput, vbNull, CLng(brRec.GovidID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Govid_Delete"

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
   ByRef brRec As tGovidType, _ 
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
      .GovidID = moUtil.EditLong(.GovidID, "GovidID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@GovidID", adInteger, adParamInput, vbNull, CLng(brRec.GovidID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@GType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@GNumber", adVarWChar, adParamOutput, 50, vbNull)
      .Parameters.Append .CreateParameter("@Issuer", adVarWChar, adParamOutput, 2, vbNull)
      .Parameters.Append .CreateParameter("@IssueDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ExpDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Govid_Fetch"

   '-----get return values
   With brRec
      .MemberID = moUtil.FetchLong(oCmd.Parameters.Item("@MemberID").Value)
      .CountryID = moUtil.FetchLong(oCmd.Parameters.Item("@CountryID").Value)
      .GType = moUtil.FetchLong(oCmd.Parameters.Item("@GType").Value)
      .GNumber = moUtil.FetchString(oCmd.Parameters.Item("@GNumber").Value)
      .Issuer = moUtil.FetchString(oCmd.Parameters.Item("@Issuer").Value)
      .IssueDate = moUtil.FetchDate(oCmd.Parameters.Item("@IssueDate").Value)
      .ExpDate = moUtil.FetchDate(oCmd.Parameters.Item("@ExpDate").Value)
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

Public Sub FetchMember( _ 
   ByRef brRec As tGovidType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FetchMember"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", True, 0) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@GovidID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@GType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@GNumber", adVarWChar, adParamOutput, 50, vbNull)
      .Parameters.Append .CreateParameter("@Issuer", adVarWChar, adParamOutput, 2, vbNull)
      .Parameters.Append .CreateParameter("@IssueDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@ExpDate", adDate, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Govid_FetchMember"

   '-----get return values
   With brRec
      .GovidID = moUtil.FetchLong(oCmd.Parameters.Item("@GovidID").Value)
      .CountryID = moUtil.FetchLong(oCmd.Parameters.Item("@CountryID").Value)
      .GType = moUtil.FetchLong(oCmd.Parameters.Item("@GType").Value)
      .GNumber = moUtil.FetchString(oCmd.Parameters.Item("@GNumber").Value)
      .Issuer = moUtil.FetchString(oCmd.Parameters.Item("@Issuer").Value)
      .IssueDate = moUtil.FetchDate(oCmd.Parameters.Item("@IssueDate").Value)
      .ExpDate = moUtil.FetchDate(oCmd.Parameters.Item("@ExpDate").Value)
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

Public Function List( _ 
   ByVal bvMemberID As Long) As tGovidType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "List"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tGovidType
   Dim vRec As tGovidType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters
      bvMemberID = moUtil.EditLong(bvMemberID, "MemberID", True, 0) 

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(bvMemberID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Govid_List")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.GovidID = moUtil.FetchLong(.Fields.Item("GovidID").Value)
            vRec.GType = moUtil.FetchLong(.Fields.Item("GType").Value)
            vRec.GNumber = moUtil.FetchString(.Fields.Item("GNumber").Value)
            vRec.Issuer = moUtil.FetchString(.Fields.Item("Issuer").Value)
            vRec.IssueDate = moUtil.FetchDate(.Fields.Item("IssueDate").Value)
            vRec.ExpDate = moUtil.FetchDate(.Fields.Item("ExpDate").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   List = vRecs

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
   ByRef brRec As tGovidType, _ 
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
      .Parameters.Append .CreateParameter("@GovidID", adInteger, adParamInput, vbNull, CLng(brRec.GovidID))
      .Parameters.Append .CreateParameter("@MemberID", adInteger, adParamInput, vbNull, CLng(brRec.MemberID))
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamInput, vbNull, CLng(brRec.CountryID))
      .Parameters.Append .CreateParameter("@GType", adInteger, adParamInput, vbNull, CLng(brRec.GType))
      .Parameters.Append .CreateParameter("@GNumber", adVarWChar, adParamInput, 50, brRec.GNumber)
      .Parameters.Append .CreateParameter("@Issuer", adVarWChar, adParamInput, 2, brRec.Issuer)
      .Parameters.Append .CreateParameter("@IssueDate", adDate, adParamInput, vbNull, CDate(brRec.IssueDate))
      .Parameters.Append .CreateParameter("@ExpDate", adDate, adParamInput, vbNull, CDate(brRec.ExpDate))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Govid_Update"

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
   ByRef brRec As tGovidType, _ 
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
         .GovidID = moUtil.EditLong(.GovidID, "GovidID", True, , 1) 
      End If
      .MemberID = moUtil.EditLong(.MemberID, "MemberID", True) 
      .CountryID = moUtil.EditLong(.CountryID, "CountryID", False) 
      .GType = moUtil.EditLong(.GType, "GType", False) 
      .GNumber = moUtil.EditString(.GNumber, "GNumber", False, , 1, 50) 
      .Issuer = moUtil.EditString(.Issuer, "Issuer", False, , 1, 2) 
      .IssueDate = moUtil.EditDate(.IssueDate, "IssueDate", False) 
      .ExpDate = moUtil.EditDate(.ExpDate, "ExpDate", False) 
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