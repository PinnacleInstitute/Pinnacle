VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 2
END
Attribute VB_Name = "CAddressB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CAddress"
'-----objects
Private moSys As wtSystem.CSystem
Private moUtil As wtSystem.CUtility
'-----properties
Public Type tAddressType
   AddressID As String
   OwnerType As String
   OwnerID As String
   CountryID As String
   CountryName As String
   AddressType As String
   IsActive As String
   Street1 As String
   Street2 As String
   City As String
   State As String
   Zip As String
   CopyID As String
End Type

Public Sub Add( _ 
   ByRef brRec As tAddressType, _ 
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
      .Parameters.Append .CreateParameter("@AddressID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamInput, vbNull, CLng(brRec.OwnerType))
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamInput, vbNull, CLng(brRec.OwnerID))
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamInput, vbNull, CLng(brRec.CountryID))
      .Parameters.Append .CreateParameter("@AddressType", adInteger, adParamInput, vbNull, CLng(brRec.AddressType))
      .Parameters.Append .CreateParameter("@IsActive", adSmallInt, adParamInput, vbNull, CInt(brRec.IsActive))
      .Parameters.Append .CreateParameter("@Street1", adVarWChar, adParamInput, 60, brRec.Street1)
      .Parameters.Append .CreateParameter("@Street2", adVarWChar, adParamInput, 60, brRec.Street2)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamInput, 30, brRec.City)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamInput, 30, brRec.State)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamInput, 20, brRec.Zip)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Address_Add"

   '-----get return values
   With brRec
      .AddressID = moUtil.FetchLong(oCmd.Parameters.Item("@AddressID").Value)
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

Public Function Copy( _ 
   ByRef brRec As tAddressType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Copy"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AddressID", adInteger, adParamInput, vbNull, CLng(brRec.AddressID))
      .Parameters.Append .CreateParameter("@AddressType", adInteger, adParamInput, vbNull, CLng(brRec.AddressType))
      .Parameters.Append .CreateParameter("@CopyID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Address_Copy"

   '-----get return values
   Copy = moUtil.FetchLong(oCmd.Parameters.Item("@CopyID").Value)

   '-----clean up
   Set oCmd = Nothing

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , oCmd
   If Err.Number = 0 Then Resume Next
   Set oCmd = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function Activate( _ 
   ByRef brRec As tAddressType, _ 
   ByVal bvUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Activate"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamInput, vbNull, CLng(brRec.OwnerType))
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamInput, vbNull, CLng(brRec.OwnerID))
      .Parameters.Append .CreateParameter("@AddressType", adInteger, adParamInput, vbNull, CLng(brRec.AddressType))
      .Parameters.Append .CreateParameter("@AddressID", adInteger, adParamInput, vbNull, CLng(brRec.AddressID))
      .Parameters.Append .CreateParameter("@CopyID", adInteger, adParamOutput, vbNull, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Address_Activate"

   '-----get return values
   Activate = moUtil.FetchLong(oCmd.Parameters.Item("@CopyID").Value)

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
   ByRef brRec As tAddressType, _ 
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
      .AddressID = moUtil.EditLong(.AddressID, "AddressID", True, , 1) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AddressID", adInteger, adParamInput, vbNull, CLng(brRec.AddressID))
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Address_Delete"

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
   ByRef brRec As tAddressType, _ 
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
      .AddressID = moUtil.EditLong(.AddressID, "AddressID", False, 0, 0) 
      bvUserID = moUtil.EditLong(bvUserID, "User ID", True, , 1) 
   End With

   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@AddressID", adInteger, adParamInput, vbNull, CLng(brRec.AddressID))
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CountryName", adVarWChar, adParamOutput, 50, vbNull)
      .Parameters.Append .CreateParameter("@AddressType", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@IsActive", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Street1", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Street2", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamOutput, 20, vbNull)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Address_Fetch"

   '-----get return values
   With brRec
      .OwnerType = moUtil.FetchLong(oCmd.Parameters.Item("@OwnerType").Value)
      .OwnerID = moUtil.FetchLong(oCmd.Parameters.Item("@OwnerID").Value)
      .CountryID = moUtil.FetchLong(oCmd.Parameters.Item("@CountryID").Value)
      .CountryName = moUtil.FetchString(oCmd.Parameters.Item("@CountryName").Value)
      .AddressType = moUtil.FetchLong(oCmd.Parameters.Item("@AddressType").Value)
      .IsActive = moUtil.FetchInteger(oCmd.Parameters.Item("@IsActive").Value)
      .Street1 = moUtil.FetchString(oCmd.Parameters.Item("@Street1").Value)
      .Street2 = moUtil.FetchString(oCmd.Parameters.Item("@Street2").Value)
      .City = moUtil.FetchString(oCmd.Parameters.Item("@City").Value)
      .State = moUtil.FetchString(oCmd.Parameters.Item("@State").Value)
      .Zip = moUtil.FetchString(oCmd.Parameters.Item("@Zip").Value)
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

Public Sub FetchOwner( _ 
   ByRef brRec As tAddressType, _ 
   ByVal bvUserID As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FetchOwner"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command

   On Error GoTo ErrorHandler

   '-----edit the input parameters
   With brRec
      .OwnerType = moUtil.EditLong(.OwnerType, "OwnerType", True, 0) 
      .OwnerID = moUtil.EditLong(.OwnerID, "OwnerID", True, 0) 
      .AddressType = moUtil.EditLong(.AddressType, "AddressType", True, 0) 
   End With


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamInput, vbNull, CLng(brRec.OwnerType))
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamInput, vbNull, CLng(brRec.OwnerID))
      .Parameters.Append .CreateParameter("@AddressType", adInteger, adParamInput, vbNull, CLng(brRec.AddressType))
      .Parameters.Append .CreateParameter("@AddressID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@CountryName", adVarWChar, adParamOutput, 50, vbNull)
      .Parameters.Append .CreateParameter("@IsActive", adSmallInt, adParamOutput, vbNull, vbNull)
      .Parameters.Append .CreateParameter("@Street1", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@Street2", adVarWChar, adParamOutput, 60, vbNull)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamOutput, 30, vbNull)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamOutput, 20, vbNull)
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Address_FetchOwner"

   '-----get return values
   With brRec
      .AddressID = moUtil.FetchLong(oCmd.Parameters.Item("@AddressID").Value)
      .CountryID = moUtil.FetchLong(oCmd.Parameters.Item("@CountryID").Value)
      .CountryName = moUtil.FetchString(oCmd.Parameters.Item("@CountryName").Value)
      .IsActive = moUtil.FetchInteger(oCmd.Parameters.Item("@IsActive").Value)
      .Street1 = moUtil.FetchString(oCmd.Parameters.Item("@Street1").Value)
      .Street2 = moUtil.FetchString(oCmd.Parameters.Item("@Street2").Value)
      .City = moUtil.FetchString(oCmd.Parameters.Item("@City").Value)
      .State = moUtil.FetchString(oCmd.Parameters.Item("@State").Value)
      .Zip = moUtil.FetchString(oCmd.Parameters.Item("@Zip").Value)
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

Public Function ListOwner( _ 
   ByVal bvOwnerType As Long, _ 
   ByVal bvOwnerID As Long) As tAddressType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListOwner"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAddressType
   Dim vRec As tAddressType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamInput, vbNull, CLng(bvOwnerType))
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamInput, vbNull, CLng(bvOwnerID))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Address_ListOwner")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.AddressID = moUtil.FetchLong(.Fields.Item("AddressID").Value)
            vRec.AddressType = moUtil.FetchLong(.Fields.Item("AddressType").Value)
            vRec.IsActive = moUtil.FetchInteger(.Fields.Item("IsActive").Value)
            vRec.Street1 = moUtil.FetchString(.Fields.Item("Street1").Value)
            vRec.Street2 = moUtil.FetchString(.Fields.Item("Street2").Value)
            vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
            vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
            vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
            vRec.CountryName = moUtil.FetchString(.Fields.Item("CountryName").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListOwner = vRecs

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

Public Function ListOwnerType( _ 
   ByVal bvOwnerType As Long, _ 
   ByVal bvOwnerID As Long, _ 
   ByVal bvAddressType As Long) As tAddressType()
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ListOwnerType"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oCmd As New ADODB.Command
   Dim oRecs As ADODB.Recordset
   Dim vRecs() As tAddressType
   Dim vRec As tAddressType
   Dim idxRec As Integer

   On Error GoTo ErrorHandler


   '-----populate the parameters for the procedure call
   With oCmd
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamInput, vbNull, CLng(bvOwnerType))
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamInput, vbNull, CLng(bvOwnerID))
      .Parameters.Append .CreateParameter("@AddressType", adInteger, adParamInput, vbNull, CLng(bvAddressType))
   End With

   '-----execute the command
   Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Address_ListOwnerType")

   '-----populate the record from the recordset
   With oRecs
      If oRecs.EOF = True Then
         ReDim vRecs(0 To 0)
      Else
         .MoveFirst
         idxRec = 0
         Do While .EOF = False
            vRec.AddressID = moUtil.FetchLong(.Fields.Item("AddressID").Value)
            vRec.AddressType = moUtil.FetchLong(.Fields.Item("AddressType").Value)
            vRec.IsActive = moUtil.FetchInteger(.Fields.Item("IsActive").Value)
            vRec.Street1 = moUtil.FetchString(.Fields.Item("Street1").Value)
            vRec.Street2 = moUtil.FetchString(.Fields.Item("Street2").Value)
            vRec.City = moUtil.FetchString(.Fields.Item("City").Value)
            vRec.State = moUtil.FetchString(.Fields.Item("State").Value)
            vRec.Zip = moUtil.FetchString(.Fields.Item("Zip").Value)
            vRec.CountryName = moUtil.FetchString(.Fields.Item("CountryName").Value)
            idxRec = idxRec + 1
            ReDim Preserve vRecs(0 To idxRec)
            vRecs(idxRec) = vRec
            .MoveNext
         Loop
      End If
   End With

   '-----return the results
   ListOwnerType = vRecs

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
   ByRef brRec As tAddressType, _ 
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
      .Parameters.Append .CreateParameter("@AddressID", adInteger, adParamInput, vbNull, CLng(brRec.AddressID))
      .Parameters.Append .CreateParameter("@OwnerType", adInteger, adParamInput, vbNull, CLng(brRec.OwnerType))
      .Parameters.Append .CreateParameter("@OwnerID", adInteger, adParamInput, vbNull, CLng(brRec.OwnerID))
      .Parameters.Append .CreateParameter("@CountryID", adInteger, adParamInput, vbNull, CLng(brRec.CountryID))
      .Parameters.Append .CreateParameter("@AddressType", adInteger, adParamInput, vbNull, CLng(brRec.AddressType))
      .Parameters.Append .CreateParameter("@IsActive", adSmallInt, adParamInput, vbNull, CInt(brRec.IsActive))
      .Parameters.Append .CreateParameter("@Street1", adVarWChar, adParamInput, 60, brRec.Street1)
      .Parameters.Append .CreateParameter("@Street2", adVarWChar, adParamInput, 60, brRec.Street2)
      .Parameters.Append .CreateParameter("@City", adVarWChar, adParamInput, 30, brRec.City)
      .Parameters.Append .CreateParameter("@State", adVarWChar, adParamInput, 30, brRec.State)
      .Parameters.Append .CreateParameter("@Zip", adVarWChar, adParamInput, 20, brRec.Zip)
      .Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, vbNull, CLng(bvUserID))
   End With

   '-----execute the command
   RunSP oCmd, moSys.ConnectString("Pinnacle", "pts"), "pts_Address_Update"

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
   ByRef brRec As tAddressType, _ 
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
         .AddressID = moUtil.EditLong(.AddressID, "AddressID", True, , 1) 
      End If
      .OwnerType = moUtil.EditLong(.OwnerType, "OwnerType", False) 
      .OwnerID = moUtil.EditLong(.OwnerID, "OwnerID", False) 
      .CountryID = moUtil.EditLong(.CountryID, "CountryID", True) 
      .AddressType = moUtil.EditLong(.AddressType, "AddressType", True) 
      .IsActive = moUtil.EditInteger(.IsActive, "IsActive", False, 0, 0, 1) 
      .Street1 = moUtil.EditString(.Street1, "Street1", True, , 1, 60) 
      .Street2 = moUtil.EditString(.Street2, "Street2", False, , 1, 60) 
      .City = moUtil.EditString(.City, "City", True, , 1, 30) 
      .State = moUtil.EditString(.State, "State", True, , 1, 30) 
      .Zip = moUtil.EditString(.Zip, "Zip", True, , 1, 20) 
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