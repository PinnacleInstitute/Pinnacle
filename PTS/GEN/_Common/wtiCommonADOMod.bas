Attribute VB_Name = "wtiCommonADOMod"
Option Explicit
Private Const cModName As String = "wtiCommonADOMod"

Public Sub RunSP( _
   ByVal bvCmd As ADODB.Command, _
   ByVal bvConnect As String, _
   ByVal bvProcName As String, _
   Optional ByVal bvProc As Boolean = True)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Runs the specified action query.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "RunSP"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler
    
   If bvConnect = "" Then
      Err.Raise -1, cProcName, "Oops, Missing Connect String for Data Access! (" + bvProcName + ")"
   End If
   
   With bvCmd
      '-----initialize the ADO objects and stored procedure parameters
      .ActiveConnection = bvConnect
      .CommandText = bvProcName
      If bvProc Then
         .CommandType = adCmdStoredProc
      Else
         .CommandType = adCmdText
      End If
      '-----execute the query
      .Execute , , adExecuteNoRecords
      
      .ActiveConnection.Close
      Set .ActiveConnection = Nothing
   End With
    
   Exit Sub
 
ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName, , bvCmd
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Function RunSPRecordset( _
   ByVal bvCmd As ADODB.Command, _
   ByVal bvConnect As String, _
   ByVal bvProcName As String, _
   Optional ByVal bvProc As Boolean = True) As ADODB.Recordset
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Runs the specified query and returns a disconnected recordset
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "RunSPRecordset"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim oRs As New ADODB.Recordset

   On Error GoTo ErrorHandler

   If bvConnect = "" Then
      Err.Raise -1, cProcName, "Oops, Missing Connect String for Data Access! (" + bvProcName + ")"
   End If
   
   With bvCmd
      '-----initialize the ADO objects and stored procedure parameters
      .ActiveConnection = bvConnect
      .CommandText = bvProcName
      If bvProc Then
         .CommandType = adCmdStoredProc
      Else
         .CommandType = adCmdText
      End If
      .Prepared = False
      '-----execute the query and create the recordset
      With oRs
         .CursorLocation = adUseClient
         .Open bvCmd, , adOpenForwardOnly, adLockReadOnly
         '-----disconnect the recordset
         Set .ActiveConnection = Nothing
      End With
   End With

   '-----return the recordset
   Set RunSPRecordset = oRs

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   Set oRs = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

