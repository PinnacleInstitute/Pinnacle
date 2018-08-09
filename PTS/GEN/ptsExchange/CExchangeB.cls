VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CExchangeB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CExchange"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tExchangeType
   ExchangeID As String
   CountryID As String
   CountryName As String
   ExchangeName As String
   NameLast As String
   NameFirst As String
   Email As String
   Phone As String
   Skype As String
   Status As String
   Street1 As String
   Street2 As String
   City As String
   State As String
   Zip As String
   ActiveDate As String
   Payment As String
End Type

Public Sub Add( _ 
   ByRef brRec As tExchangeType, _ 
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
      .Parameters.Append .CreateParameter("@ExchangeID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamInput, vbNull, CLng(brRec.CountryID))
      .Parameters.Append .CreateParameter("@ExchangeName", adVarWChar, adParamInput, 80, brRec.ExchangeName)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamInput, 30, brRec.NameLast)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamInput, 30, brRec.NameFirst)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@Phone", adVarWChar, adParamInput, 30, brRec.Phone)
      .Parameters.Append .CreateParameter("@Skype", adVarWChar, adParamInput, 30, brRec.Skype)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Street1", adVarWChar, adParamInput, 60, brRec.Street1)
      .Parameters.Append .CreateParameter("@Street2", adVarWChar, adParamInput, 60, brRec.Street2)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamInput, 30, brRec.City)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamInput, 30, brRec.State)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamInput, 20, brRec.Zip)
      .Parameters.Append .CreateParameter("@ActiveDate", adDate, adParamInput, vbNull, CDate(brRec.ActiveDate))
      .Parameters.Append .CreateParameter("@Payment", adVarWChar, adParamInput, 100, brRec.Payment)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Exchange_Add"

   '-----get return values
   With brRec
      .ExchangeID = moUtil.FetchLong(oCmd.Parameters.Item("@ExchangeID").Value)
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
   ByRef brRec As tExchangeType, _ 
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
      .ExchangeID = moUtil.EditLong(.ExchangeID, "ExchangeID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ExchangeID", adInteger, adParamInput, vbNull, CLng(brRec.ExchangeID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Exchange_Delete"

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
   ByRef brRec As tExchangeType, _ 
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
      .ExchangeID = moUtil.EditLong(.ExchangeID, "ExchangeID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@ExchangeID", adInteger, adParamInput, vbNull, CLng(brRec.ExchangeID))
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CountryName", adVarWChar, adParamOutput, 50, vbNull)
      .Parameters.Append .CreateParameter("@ExchangeName", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamOutput, 80, vbNull)
      .Parameters.Append .CreateParameter("@Phone", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Skype", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Street1", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Street2", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@ActiveDate", adDate, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Payment", adVarWChar, adParamOutput, 100, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Exchange_Fetch"

   '-----get return values
   With brRec
      .CountryID = moUtil.FetchLong(oCmd.Parameters.Item("@CountryID").Value)
      .CountryName = moUtil.FetchString(oCmd.Parameters.Item("@CountryName").Value)
      .ExchangeName = moUtil.FetchString(oCmd.Parameters.Item("@ExchangeName").Value)
      .NameLast = moUtil.FetchString(oCmd.Parameters.Item("@NameLast").Value)
      .NameFirst = moUtil.FetchString(oCmd.Parameters.Item("@NameFirst").Value)
      .Email = moUtil.FetchString(oCmd.Parameters.Item("@Email").Value)
      .Phone = moUtil.FetchString(oCmd.Parameters.Item("@Phone").Value)
      .Skype = moUtil.FetchString(oCmd.Parameters.Item("@Skype").Value)
      .Status = moUtil.FetchLong(oCmd.Parameters.Item("@Status").Value)
      .Street1 = moUtil.FetchString(oCmd.Parameters.Item("@Street1").Value)
      .Street2 = moUtil.FetchString(oCmd.Parameters.Item("@Street2").Value)
      .City = moUtil.FetchString(oCmd.Parameters.Item("@City").Value)
      .State = moUtil.FetchString(oCmd.Parameters.Item("@State").Value)
      .Zip = moUtil.FetchString(oCmd.Parameters.Item("@Zip").Value)
      .ActiveDate = moUtil.FetchDate(oCmd.Parameters.Item("@ActiveDate").Value)
      .Payment = moUtil.FetchString(oCmd.Parameters.Item("@Payment").Value)
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
   ByVal bvSecurityToken As Long) As tExchangeType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "List"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tExchangeType
   Dim vRec As tExchangeType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler

   '-----edit the input parameters

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvSecurityToken))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Exchange_List")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.ExchangeID = moUtil.FetchLong(.Fields.Item("ExchangeID").Value)
            vRec.ExchangeName = moUtil.FetchString(.Fields.Item("ExchangeName").Value)
            vRec.NameFirst = moUtil.FetchString(.Fields.Item("NameFirst").Value)
            vRec.NameLast = moUtil.FetchString(.Fields.Item("NameLast").Value)
            vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
            vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
            vRec.CountryName = moUtil.FetchString(.Fields.Item("CountryName").Value)
            vRec.Status = moUtil.FetchLong(.Fields.Item("Status").Value)
            vRec.ActiveDate = moUtil.FetchDate(.Fields.Item("ActiveDate").Value)
            vRec.Payment = moUtil.FetchString(.Fields.Item("Payment").Value)
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
   ByRef brRec As tExchangeType, _ 
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
      .Parameters.Append .CreateParameter("@ExchangeID", adInteger, adParamInput, vbNull, CLng(brRec.ExchangeID))
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamInput, vbNull, CLng(brRec.CountryID))
      .Parameters.Append .CreateParameter("@ExchangeName", adVarWChar, adParamInput, 80, brRec.ExchangeName)
      .Parameters.Append .CreateParameter("@NameLast", adVarWChar, adParamInput, 30, brRec.NameLast)
      .Parameters.Append .CreateParameter("@NameFirst", adVarWChar, adParamInput, 30, brRec.NameFirst)
      .Parameters.Append .CreateParameter("@Email", adVarWChar, adParamInput, 80, brRec.Email)
      .Parameters.Append .CreateParameter("@Phone", adVarWChar, adParamInput, 30, brRec.Phone)
      .Parameters.Append .CreateParameter("@Skype", adVarWChar, adParamInput, 30, brRec.Skype)
      .Parameters.Append .CreateParameter("@Status", adInteger, adParamInput, vbNull, CLng(brRec.Status))
      .Parameters.Append .CreateParameter("@Street1", adVarWChar, adParamInput, 60, brRec.Street1)
      .Parameters.Append .CreateParameter("@Street2", adVarWChar, adParamInput, 60, brRec.Street2)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamInput, 30, brRec.City)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamInput, 30, brRec.State)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamInput, 20, brRec.Zip)
      .Parameters.Append .CreateParameter("@ActiveDate", adDate, adParamInput, vbNull, CDate(brRec.ActiveDate))
      .Parameters.Append .CreateParameter("@Payment", adVarWChar, adParamInput, 100, brRec.Payment)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Exchange_Update"

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
   ByRef brRec As tExchangeType, _ 
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
         .ExchangeID = moUtil.EditLong(.ExchangeID, "ExchangeID", True, , 1) 
      End If
      .CountryID = moUtil.EditLong(.CountryID, "CountryID", False) 
      .ExchangeName = moUtil.EditString(.ExchangeName, "ExchangeName", True, , 1, 80) 
      .NameLast = moUtil.EditString(.NameLast, "NameLast", False, , 1, 30) 
      .NameFirst = moUtil.EditString(.NameFirst, "NameFirst", False, , 1, 30) 
      .Email = moUtil.EditString(.Email, "Email", False, , 1, 80) 
      .Phone = moUtil.EditString(.Phone, "Phone", False, , 1, 30) 
      .Skype = moUtil.EditString(.Skype, "Skype", False, , 1, 30) 
      .Status = moUtil.EditLong(.Status, "Status", False) 
      .Street1 = moUtil.EditString(.Street1, "Street1", False, , 1, 60) 
      .Street2 = moUtil.EditString(.Street2, "Street2", False, , 1, 60) 
      .City = moUtil.EditString(.City, "City", False, , 1, 30) 
      .State = moUtil.EditString(.State, "State", False, , 1, 30) 
      .Zip = moUtil.EditString(.Zip, "Zip", False, , 1, 20) 
      .ActiveDate = moUtil.EditDate(.ActiveDate, "ActiveDate", False) 
      .Payment = moUtil.EditString(.Payment, "Payment", False) 
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