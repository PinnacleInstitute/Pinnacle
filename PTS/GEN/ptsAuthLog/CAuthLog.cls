VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 0
END
Attribute VB_Name = "CAuthLog"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CAuthLog"
Private Const cEntityID As Long = 71
Private Const cDefaultLanguage As String = "en"
'-----properties
Private mDataRec As CAuthLogB.tAuthLogType
Private mSecurityToken As Long
Private mCurrentLanguage As String
'-----enumerators
Public Enum ptsAuthLogEnumConstants
   ptsAuthLogEnumStatus = cptsAuthLogEnumStatus
End Enum

Public Enum ptsAuthLogStatusConstants
   ptsAuthLogStatusAllow = cptsAuthLogStatusAllow
   ptsAuthLogStatusDisallow = cptsAuthLogStatusDisallow
   ptsAuthLogStatusOverride = cptsAuthLogStatusOverride
End Enum

Public Function Add( _ 
   Optional ByVal bvSecurityToken As Long = 0) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Adds a new record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Add"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   BusnService.Add mDataRec, mSecurityToken

   '-----return the new item
   Add = mDataRec.AuthLogID

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Private Function BusnService() As CAuthLogB
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a reference to the object's business service object.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "BusnService"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Set BusnService = New CAuthLogB

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Sub Delete( _ 
   Optional ByVal bvAuthLogID As Long = 0, _ 
   Optional ByVal bvSecurityToken As Long = 0)
   '------------------------------------------------------------------------------------------------------------------------
   '   Deletes the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Delete"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   '-----initialize the ID if provided
   If bvAuthLogID > 0 Then AuthLogID = bvAuthLogID

   BusnService.Delete mDataRec, mSecurityToken

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Property Get EnumItems( _ 
   ByVal bvType As ptsAuthLogEnumConstants) As wtSystem.CEnumItems
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns an enumerated list of items.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EnumItems"
   '------------------------------------------------------------------------------------------------------------------------
   Dim oEnums As wtSystem.CEnumItems

   On Error GoTo ErrorHandler

   Set oEnums = New wtSystem.CEnumItems

   Select Case bvType
      Case cptsAuthLogEnumStatus
         oEnums.Add cptsAuthLogStatusAllow, "Allow"
         oEnums.Add cptsAuthLogStatusDisallow, "Disallow"
         oEnums.Add cptsAuthLogStatusOverride, "Override"
   End Select

   Set EnumItems = oEnums
   Set oEnums = Nothing

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Sub Load( _ 
   Optional ByVal bvAuthLogID As Long = 0, _ 
   Optional ByVal bvSecurityToken As Long = 0)
   '------------------------------------------------------------------------------------------------------------------------
   '   Retrieves the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Load"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   '-----initialize the ID if provided
   If bvAuthLogID > 0 Then AuthLogID = bvAuthLogID

   BusnService.Fetch mDataRec, mSecurityToken

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Function LogAuthUser( _ 
   ByVal bvAuthUserID As Long, _ 
   ByVal bvIP As String, _ 
   ByVal bvTotal As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition. 
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "LogAuthUser"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   '-----set parameter properties
   If bvAuthUserID <> 0 Then AuthUserID = bvAuthUserID
   If bvIP <> "" Then IP = bvIP
   If bvTotal <> 0 Then Total = bvTotal

   LogAuthUser = BusnService.LogAuthUser(mDataRec, mSecurityToken)

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function LogIP( _ 
   ByVal bvIP As String) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition. 
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "LogIP"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   '-----set parameter properties
   If bvIP <> "" Then IP = bvIP

   LogIP = BusnService.LogIP(mDataRec, mSecurityToken)

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function LogLead( _ 
   ByVal bvIP As String, _ 
   ByVal bvAuthUserID As Long) As Long
   '------------------------------------------------------------------------------------------------------------------------
   '   Checks a condition. 
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "LogLead"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   '-----set parameter properties
   If bvIP <> "" Then IP = bvIP
   If bvAuthUserID <> 0 Then AuthUserID = bvAuthUserID

   LogLead = BusnService.LogLead(mDataRec, mSecurityToken)

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Sub Save( _ 
   Optional ByVal bvSecurityToken As Long = 0)
   '------------------------------------------------------------------------------------------------------------------------
   '   Adds or updates the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Save"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   BusnService.Update mDataRec, mSecurityToken

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub Validate( _ 
   Optional ByVal bvNew As Integer = 0, _ 
   Optional ByVal bvSecurityToken As Long = 0)
   '------------------------------------------------------------------------------------------------------------------------
   '   Validates the record.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Validate"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   '-----set the security token
   If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken

   BusnService.Validate mDataRec, mSecurityToken, bvNew

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Function XML( _ 
   Optional ByVal bvOption As Integer = 1000, _
   Optional ByVal bvElementName As String = "AuthLog") As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the XML for the item.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "XML"
   '------------------------------------------------------------------------------------------------------------------------
   Dim sChildren As String
   Dim sAttributes As String
   Dim sValue As String
   Dim sOption As String
   Dim bLookup As Integer
   Dim bFilter As Integer
   Dim bStatic As Integer
   Dim bAttrib As Integer

   On Error GoTo ErrorHandler

   'Handle Common Options for item classes
   Select Case bvOption
      Case 2: bvOption = 1111    ' attributes with all enums
      Case 3: bvOption = 1001    ' attributes with static enums only
   End Select
   sOption = Format(bvOption, "0000")
   bAttrib = (Mid(sOption, 1, 1) = "1")
   bFilter = (Mid(sOption, 2, 1) = "1")
   bLookup = (Mid(sOption, 3, 1) = "1")
   bStatic = (Mid(sOption, 4, 1) = "1")

   '-----create the XML for the children
   sChildren = ""
   If bStatic Then
      If IsNumeric(Status) Then
         sChildren = sChildren + EnumItems(7107).XML("ptsStatuss", Status)
      Else
         sChildren = sChildren + EnumItems (7107).XML("ptsStatuss")
      End If

   End If
   '-----create the XML for the attributes
   sAttributes = ""

   If bAttrib Then
      If (Len(AuthLogID) > 0) Then sAttributes = sAttributes + XMLAttribute("AuthLogID", AuthLogID, False)
      If (Len(AuthUserID) > 0) Then sAttributes = sAttributes + XMLAttribute("AuthUserID", AuthUserID, False)
      If (Len(IP) > 0) Then sAttributes = sAttributes + XMLAttribute("IP", IP, False)
      If (Len(LogDate) > 0) And (LogDate <> "0") Then sAttributes = sAttributes + XMLAttribute("LogDate", Format$(LogDate, "m-d-yy h:mm am/pm"), False)
      If (Len(LastDate) > 0) And (LastDate <> "0") Then sAttributes = sAttributes + XMLAttribute("LastDate", Format$(LastDate, "m-d-yy h:mm am/pm"), False)
      If (Len(Total) > 0) Then sAttributes = sAttributes + XMLAttribute("Total", Total, False)
      If (Len(Status) > 0) Then sAttributes = sAttributes + XMLAttribute("Status", Status, False)
   End If
   '-----create the XML for the value
   sValue = ""

   '-----create the XML for the object
   If bAttrib Then
      XML = XMLElement("pts" + bvElementName, sAttributes, sValue, sChildren)
   Else
      XML = sChildren
   End If

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Friend Property Get DataRec() As CAuthLogB.tAuthLogType
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "DataRec_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   DataRec = mDataRec

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Friend Property Let DataRec( _ 
   ByRef brDataRec As CAuthLogB.tAuthLogType)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "DataRec_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec = brDataRec

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let SysCurrentLanguage(ByVal bvLanguage As String)
   mCurrentLanguage = bvLanguage
End Property


Public Property Get AuthLogID() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "AuthLogID_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   AuthLogID = mDataRec.AuthLogID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let AuthLogID( _ 
   ByVal bvAuthLogID As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "AuthLogID_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.AuthLogID = bvAuthLogID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get AuthUserID() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "AuthUserID_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   AuthUserID = mDataRec.AuthUserID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let AuthUserID( _ 
   ByVal bvAuthUserID As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "AuthUserID_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.AuthUserID = bvAuthUserID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get IP() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "IP_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   IP = mDataRec.IP

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let IP( _ 
   ByVal bvIP As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "IP_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.IP = bvIP

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get LogDate() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "LogDate_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   If IsDate(mDataRec.LogDate) Then LogDate = mDataRec.LogDate Else LogDate = 0
   If mDataRec.LogDate = "1/1/1900" Then LogDate = 0

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let LogDate( _ 
   ByVal bvLogDate As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "LogDate_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.LogDate = bvLogDate

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get LastDate() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "LastDate_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   If IsDate(mDataRec.LastDate) Then LastDate = mDataRec.LastDate Else LastDate = 0
   If mDataRec.LastDate = "1/1/1900" Then LastDate = 0

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let LastDate( _ 
   ByVal bvLastDate As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "LastDate_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.LastDate = bvLastDate

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Total() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Total_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Total = mDataRec.Total

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Total( _ 
   ByVal bvTotal As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Total_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Total = bvTotal

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Status() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Status_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Status = mDataRec.Status

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Status( _ 
   ByVal bvStatus As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Status_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Status = bvStatus

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Private Sub Class_Initialize()
   mCurrentLanguage = cDefaultLanguage
End Sub