VERSION 1.0 CLASS
BEGIN
   MultiUse = -1
   Persistable = 0
   DataBindingBehavior = 0
   DataSourceBehavior = 0
   MTSTransactionMode = 0
END
Attribute VB_Name = "CLead"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'-----constants
Private Const cModName As String = "CLead"
Private Const cEntityID As Long = 22
Private Const cDefaultLanguage As String = "en"
'-----properties
Private mDataRec As CLeadB.tLeadType
Private mSecurityToken As Long
Private mCurrentLanguage As String
'-----enumerators
Public Enum ptsLeadEnumConstants
   ptsLeadEnumStatus = cptsLeadEnumStatus
   ptsLeadEnumTimeZone = cptsLeadEnumTimeZone
   ptsLeadEnumBestTime = cptsLeadEnumBestTime
End Enum

Public Enum ptsLeadStatusConstants
   ptsLeadStatusNew = cptsLeadStatusNew
   ptsLeadStatusContact1 = cptsLeadStatusContact1
   ptsLeadStatusContact2 = cptsLeadStatusContact2
   ptsLeadStatusContact3 = cptsLeadStatusContact3
   ptsLeadStatusNoContact = cptsLeadStatusNoContact
   ptsLeadStatusCallBack = cptsLeadStatusCallBack
   ptsLeadStatusDead = cptsLeadStatusDead
End Enum

Public Enum ptsLeadTimeZoneConstants
   ptsLeadTimeZoneGMTm12 = cptsLeadTimeZoneGMTm12
   ptsLeadTimeZoneGMTm11 = cptsLeadTimeZoneGMTm11
   ptsLeadTimeZoneGMTm10 = cptsLeadTimeZoneGMTm10
   ptsLeadTimeZoneGMTm9 = cptsLeadTimeZoneGMTm9
   ptsLeadTimeZoneGMTm8 = cptsLeadTimeZoneGMTm8
   ptsLeadTimeZoneGMTm7 = cptsLeadTimeZoneGMTm7
   ptsLeadTimeZoneGMTm6 = cptsLeadTimeZoneGMTm6
   ptsLeadTimeZoneGMTm5 = cptsLeadTimeZoneGMTm5
   ptsLeadTimeZoneGMTm4 = cptsLeadTimeZoneGMTm4
   ptsLeadTimeZoneGMTm3 = cptsLeadTimeZoneGMTm3
   ptsLeadTimeZoneGMTm2 = cptsLeadTimeZoneGMTm2
   ptsLeadTimeZoneGMTm1 = cptsLeadTimeZoneGMTm1
   ptsLeadTimeZoneGMT = cptsLeadTimeZoneGMT
   ptsLeadTimeZoneGMTp1 = cptsLeadTimeZoneGMTp1
   ptsLeadTimeZoneGMTp2 = cptsLeadTimeZoneGMTp2
   ptsLeadTimeZoneGMTp3 = cptsLeadTimeZoneGMTp3
   ptsLeadTimeZoneGMTp4 = cptsLeadTimeZoneGMTp4
   ptsLeadTimeZoneGMTp5 = cptsLeadTimeZoneGMTp5
   ptsLeadTimeZoneGMTp6 = cptsLeadTimeZoneGMTp6
   ptsLeadTimeZoneGMTp7 = cptsLeadTimeZoneGMTp7
   ptsLeadTimeZoneGMTp8 = cptsLeadTimeZoneGMTp8
   ptsLeadTimeZoneGMTp9 = cptsLeadTimeZoneGMTp9
   ptsLeadTimeZoneGMTp10 = cptsLeadTimeZoneGMTp10
   ptsLeadTimeZoneGMTp11 = cptsLeadTimeZoneGMTp11
   ptsLeadTimeZoneGMTp12 = cptsLeadTimeZoneGMTp12
End Enum

Public Enum ptsLeadBestTimeConstants
   ptsLeadBestTimeMorning = cptsLeadBestTimeMorning
   ptsLeadBestTimeAfternoon = cptsLeadBestTimeAfternoon
   ptsLeadBestTimeEvening = cptsLeadBestTimeEvening
   ptsLeadBestTimeWeekend = cptsLeadBestTimeWeekend
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
   Add = mDataRec.LeadID

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Private Function BusnService() As CLeadB
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns a reference to the object's business service object.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "BusnService"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Set BusnService = New CLeadB

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Sub Delete( _ 
   Optional ByVal bvLeadID As Long = 0, _ 
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
   If bvLeadID > 0 Then LeadID = bvLeadID

   BusnService.Delete mDataRec, mSecurityToken

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Property Get EnumItems( _ 
   ByVal bvType As ptsLeadEnumConstants) As wtSystem.CEnumItems
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
      Case cptsLeadEnumStatus
         oEnums.Add cptsLeadStatusNew, "New"
         oEnums.Add cptsLeadStatusContact1, "Contact1"
         oEnums.Add cptsLeadStatusContact2, "Contact2"
         oEnums.Add cptsLeadStatusContact3, "Contact3"
         oEnums.Add cptsLeadStatusNoContact, "NoContact"
         oEnums.Add cptsLeadStatusCallBack, "CallBack"
         oEnums.Add cptsLeadStatusDead, "Dead"
      Case cptsLeadEnumTimeZone
         oEnums.Add cptsLeadTimeZoneGMTm12, "GMTm12"
         oEnums.Add cptsLeadTimeZoneGMTm11, "GMTm11"
         oEnums.Add cptsLeadTimeZoneGMTm10, "GMTm10"
         oEnums.Add cptsLeadTimeZoneGMTm9, "GMTm9"
         oEnums.Add cptsLeadTimeZoneGMTm8, "GMTm8"
         oEnums.Add cptsLeadTimeZoneGMTm7, "GMTm7"
         oEnums.Add cptsLeadTimeZoneGMTm6, "GMTm6"
         oEnums.Add cptsLeadTimeZoneGMTm5, "GMTm5"
         oEnums.Add cptsLeadTimeZoneGMTm4, "GMTm4"
         oEnums.Add cptsLeadTimeZoneGMTm3, "GMTm3"
         oEnums.Add cptsLeadTimeZoneGMTm2, "GMTm2"
         oEnums.Add cptsLeadTimeZoneGMTm1, "GMTm1"
         oEnums.Add cptsLeadTimeZoneGMT, "GMT"
         oEnums.Add cptsLeadTimeZoneGMTp1, "GMTp1"
         oEnums.Add cptsLeadTimeZoneGMTp2, "GMTp2"
         oEnums.Add cptsLeadTimeZoneGMTp3, "GMTp3"
         oEnums.Add cptsLeadTimeZoneGMTp4, "GMTp4"
         oEnums.Add cptsLeadTimeZoneGMTp5, "GMTp5"
         oEnums.Add cptsLeadTimeZoneGMTp6, "GMTp6"
         oEnums.Add cptsLeadTimeZoneGMTp7, "GMTp7"
         oEnums.Add cptsLeadTimeZoneGMTp8, "GMTp8"
         oEnums.Add cptsLeadTimeZoneGMTp9, "GMTp9"
         oEnums.Add cptsLeadTimeZoneGMTp10, "GMTp10"
         oEnums.Add cptsLeadTimeZoneGMTp11, "GMTp11"
         oEnums.Add cptsLeadTimeZoneGMTp12, "GMTp12"
      Case cptsLeadEnumBestTime
         oEnums.Add cptsLeadBestTimeMorning, "Morning"
         oEnums.Add cptsLeadBestTimeAfternoon, "Afternoon"
         oEnums.Add cptsLeadBestTimeEvening, "Evening"
         oEnums.Add cptsLeadBestTimeWeekend, "Weekend"
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
   Optional ByVal bvLeadID As Long = 0, _ 
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
   If bvLeadID > 0 Then LeadID = bvLeadID

   BusnService.Fetch mDataRec, mSecurityToken

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub UpdateCode( _ 
   ByVal bvLeadID As Long, _ 
   ByVal bvCode As Long)
   '------------------------------------------------------------------------------------------------------------------------
   '   Executes a Command. 
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "UpdateCode"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   '-----set parameter properties
   If bvLeadID <> 0 Then LeadID = bvLeadID
   Code = bvCode

   BusnService.UpdateCode mDataRec, mSecurityToken

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

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
   Optional ByVal bvElementName As String = "Lead") As String
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
         sChildren = sChildren + EnumItems(2225).XML("ptsStatuss", Status)
      Else
         sChildren = sChildren + EnumItems (2225).XML("ptsStatuss")
      End If

      If IsNumeric(TimeZone) Then
         sChildren = sChildren + EnumItems(2229).XML("ptsTimeZones", TimeZone, 0)
      Else
         sChildren = sChildren + EnumItems (2229).XML("ptsTimeZones", , 0)
      End If

      If IsNumeric(BestTime) Then
         sChildren = sChildren + EnumItems(2230).XML("ptsBestTimes", BestTime)
      Else
         sChildren = sChildren + EnumItems (2230).XML("ptsBestTimes")
      End If

   End If
   '-----create the XML for the attributes
   sAttributes = ""

   If bAttrib Then
      If (Len(LeadID) > 0) Then sAttributes = sAttributes + XMLAttribute("LeadID", LeadID, False)
      If (Len(MemberID) > 0) Then sAttributes = sAttributes + XMLAttribute("MemberID", MemberID, False)
      If (Len(SalesCampaignID) > 0) Then sAttributes = sAttributes + XMLAttribute("SalesCampaignID", SalesCampaignID, False)
      If (Len(ProspectTypeID) > 0) Then sAttributes = sAttributes + XMLAttribute("ProspectTypeID", ProspectTypeID, False)
      If (Len(SalesCampaignName) > 0) Then sAttributes = sAttributes + XMLAttribute("SalesCampaignName", SalesCampaignName, False)
      If (Len(ProspectTypeName) > 0) Then sAttributes = sAttributes + XMLAttribute("ProspectTypeName", ProspectTypeName, False)
      If (Len(NameLast) > 0) Then sAttributes = sAttributes + XMLAttribute("NameLast", NameLast, False)
      If (Len(NameFirst) > 0) Then sAttributes = sAttributes + XMLAttribute("NameFirst", NameFirst, False)
      If (Len(LeadName) > 0) Then sAttributes = sAttributes + XMLAttribute("LeadName", LeadName, False)
      If (Len(LeadDate) > 0) And (LeadDate <> "0") Then sAttributes = sAttributes + XMLAttribute("LeadDate", Format$(LeadDate, "m/d/yyyy"), False)
      If (Len(Email) > 0) Then sAttributes = sAttributes + XMLAttribute("Email", Email, False)
      If (Len(Phone1) > 0) Then sAttributes = sAttributes + XMLAttribute("Phone1", Phone1, False)
      If (Len(Phone2) > 0) Then sAttributes = sAttributes + XMLAttribute("Phone2", Phone2, False)
      If (Len(Street) > 0) Then sAttributes = sAttributes + XMLAttribute("Street", Street, False)
      If (Len(Unit) > 0) Then sAttributes = sAttributes + XMLAttribute("Unit", Unit, False)
      If (Len(City) > 0) Then sAttributes = sAttributes + XMLAttribute("City", City, False)
      If (Len(State) > 0) Then sAttributes = sAttributes + XMLAttribute("State", State, False)
      If (Len(Zip) > 0) Then sAttributes = sAttributes + XMLAttribute("Zip", Zip, False)
      If (Len(Country) > 0) Then sAttributes = sAttributes + XMLAttribute("Country", Country, False)
      If (Len(Comment) > 0) Then sAttributes = sAttributes + XMLAttribute("Comment", Comment, False)
      If (Len(Source) > 0) Then sAttributes = sAttributes + XMLAttribute("Source", Source, False)
      If (Len(Status) > 0) Then sAttributes = sAttributes + XMLAttribute("Status", Status, False)
      If (Len(Priority) > 0) Then sAttributes = sAttributes + XMLAttribute("Priority", Priority, False)
      If (Len(CallBackDate) > 0) And (CallBackDate <> "0") Then sAttributes = sAttributes + XMLAttribute("CallBackDate", Format$(CallBackDate, "m/d/yyyy"), False)
      If (Len(CallBackTime) > 0) Then sAttributes = sAttributes + XMLAttribute("CallBackTime", CallBackTime, False)
      If (Len(TimeZone) > 0) Then sAttributes = sAttributes + XMLAttribute("TimeZone", TimeZone, False)
      If (Len(BestTime) > 0) Then sAttributes = sAttributes + XMLAttribute("BestTime", BestTime, False)
      If (Len(DistributorID) > 0) Then sAttributes = sAttributes + XMLAttribute("DistributorID", DistributorID, False)
      If (Len(DistributeDate) > 0) And (DistributeDate <> "0") Then sAttributes = sAttributes + XMLAttribute("DistributeDate", Format$(DistributeDate, "m/d/yyyy"), False)
      If (Len(Code) > 0) Then sAttributes = sAttributes + XMLAttribute("Code", Code, False)
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

Public Function XMLExport( _ 
   Optional ByVal bvOption As Integer = 1000, _
   Optional ByVal bvElementName As String = "Lead") As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the XML for the item.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "XMLExport"
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
   If bLookup Then
   End If
   If bStatic Then
      If IsNumeric(Status) Then
         sChildren = sChildren + EnumItems(2225).XML("ptsStatuss", Status)
      Else
         sChildren = sChildren + EnumItems (2225).XML("ptsStatuss")
      End If

      If IsNumeric(TimeZone) Then
         sChildren = sChildren + EnumItems(2229).XML("ptsTimeZones", TimeZone, 0)
      Else
         sChildren = sChildren + EnumItems (2229).XML("ptsTimeZones", , 0)
      End If

      If IsNumeric(BestTime) Then
         sChildren = sChildren + EnumItems(2230).XML("ptsBestTimes", BestTime)
      Else
         sChildren = sChildren + EnumItems (2230).XML("ptsBestTimes")
      End If

   End If
   If bFilter Then
   End If

   '-----create the XML for the attributes
   sAttributes = ""
   If bAttrib Then
      If (Len(LeadID) > 0) Then sAttributes = sAttributes + XMLAttribute("LeadID", LeadID, False)
      If (Len(NameFirst) > 0) Then sAttributes = sAttributes + XMLAttribute("NameFirst", NameFirst, False)
      If (Len(NameLast) > 0) Then sAttributes = sAttributes + XMLAttribute("NameLast", NameLast, False)
      If (Len(SalesCampaignName) > 0) Then sAttributes = sAttributes + XMLAttribute("SalesCampaignName", SalesCampaignName, False)
      If (Len(ProspectTypeName) > 0) Then sAttributes = sAttributes + XMLAttribute("ProspectTypeName", ProspectTypeName, False)
      If (Len(Status) > 0) Then sAttributes = sAttributes + XMLAttribute("Status", Status, False)
      If (Len(Priority) > 0) Then sAttributes = sAttributes + XMLAttribute("Priority", Priority, False)
      If (Len(LeadDate) > 0) And (LeadDate <> "0") Then sAttributes = sAttributes + XMLAttribute("LeadDate", Format$(LeadDate, "m/d/yyyy"), False)
      If (Len(Source) > 0) Then sAttributes = sAttributes + XMLAttribute("Source", Source, False)
      If (Len(CallBackDate) > 0) And (CallBackDate <> "0") Then sAttributes = sAttributes + XMLAttribute("CallBackDate", Format$(CallBackDate, "m/d/yyyy"), False)
      If (Len(CallBackTime) > 0) Then sAttributes = sAttributes + XMLAttribute("CallBackTime", CallBackTime, False)
      If (Len(TimeZone) > 0) Then sAttributes = sAttributes + XMLAttribute("TimeZone", TimeZone, False)
      If (Len(BestTime) > 0) Then sAttributes = sAttributes + XMLAttribute("BestTime", BestTime, False)
      If (Len(Email) > 0) Then sAttributes = sAttributes + XMLAttribute("Email", Email, False)
      If (Len(Phone1) > 0) Then sAttributes = sAttributes + XMLAttribute("Phone1", Phone1, False)
      If (Len(Phone2) > 0) Then sAttributes = sAttributes + XMLAttribute("Phone2", Phone2, False)
      If (Len(Street) > 0) Then sAttributes = sAttributes + XMLAttribute("Street", Street, False)
      If (Len(Unit) > 0) Then sAttributes = sAttributes + XMLAttribute("Unit", Unit, False)
      If (Len(City) > 0) Then sAttributes = sAttributes + XMLAttribute("City", City, False)
      If (Len(State) > 0) Then sAttributes = sAttributes + XMLAttribute("State", State, False)
      If (Len(Zip) > 0) Then sAttributes = sAttributes + XMLAttribute("Zip", Zip, False)
      If (Len(Country) > 0) Then sAttributes = sAttributes + XMLAttribute("Country", Country, False)
   End If

   '-----create the XML for the value
   sValue = ""

   '-----create the XML for the object
   If bAttrib Then
      XMLExport = XMLElement("pts" + bvElementName + "", sAttributes, sValue, sChildren)
   Else
      XMLExport = sChildren
   End If

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Friend Property Get DataRec() As CLeadB.tLeadType
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
   ByRef brDataRec As CLeadB.tLeadType)
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


Public Property Get LeadID() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "LeadID_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   LeadID = mDataRec.LeadID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let LeadID( _ 
   ByVal bvLeadID As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "LeadID_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.LeadID = bvLeadID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get MemberID() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "MemberID_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   MemberID = mDataRec.MemberID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let MemberID( _ 
   ByVal bvMemberID As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "MemberID_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.MemberID = bvMemberID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get SalesCampaignID() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "SalesCampaignID_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   SalesCampaignID = mDataRec.SalesCampaignID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let SalesCampaignID( _ 
   ByVal bvSalesCampaignID As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "SalesCampaignID_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.SalesCampaignID = bvSalesCampaignID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get ProspectTypeID() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ProspectTypeID_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   ProspectTypeID = mDataRec.ProspectTypeID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let ProspectTypeID( _ 
   ByVal bvProspectTypeID As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ProspectTypeID_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.ProspectTypeID = bvProspectTypeID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get SalesCampaignName() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "SalesCampaignName_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   SalesCampaignName = mDataRec.SalesCampaignName

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let SalesCampaignName( _ 
   ByVal bvSalesCampaignName As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "SalesCampaignName_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.SalesCampaignName = bvSalesCampaignName

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get ProspectTypeName() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ProspectTypeName_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   ProspectTypeName = mDataRec.ProspectTypeName

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let ProspectTypeName( _ 
   ByVal bvProspectTypeName As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ProspectTypeName_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.ProspectTypeName = bvProspectTypeName

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get NameLast() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "NameLast_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   NameLast = mDataRec.NameLast

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let NameLast( _ 
   ByVal bvNameLast As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "NameLast_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.NameLast = bvNameLast

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get NameFirst() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "NameFirst_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   NameFirst = mDataRec.NameFirst

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let NameFirst( _ 
   ByVal bvNameFirst As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "NameFirst_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.NameFirst = bvNameFirst

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get LeadName() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "LeadName_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   LeadName = mDataRec.LeadName

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get LeadDate() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "LeadDate_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   If IsDate(mDataRec.LeadDate) Then LeadDate = mDataRec.LeadDate Else LeadDate = 0
   If mDataRec.LeadDate = "1/1/1900" Then LeadDate = 0

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let LeadDate( _ 
   ByVal bvLeadDate As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "LeadDate_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.LeadDate = bvLeadDate

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Email() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Email_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Email = mDataRec.Email

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Email( _ 
   ByVal bvEmail As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Email_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Email = bvEmail

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Phone1() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Phone1_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Phone1 = mDataRec.Phone1

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Phone1( _ 
   ByVal bvPhone1 As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Phone1_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Phone1 = bvPhone1

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Phone2() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Phone2_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Phone2 = mDataRec.Phone2

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Phone2( _ 
   ByVal bvPhone2 As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Phone2_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Phone2 = bvPhone2

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Street() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Street_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Street = mDataRec.Street

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Street( _ 
   ByVal bvStreet As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Street_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Street = bvStreet

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Unit() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Unit_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Unit = mDataRec.Unit

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Unit( _ 
   ByVal bvUnit As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Unit_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Unit = bvUnit

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get City() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "City_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   City = mDataRec.City

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let City( _ 
   ByVal bvCity As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "City_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.City = bvCity

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get State() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "State_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   State = mDataRec.State

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let State( _ 
   ByVal bvState As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "State_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.State = bvState

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Zip() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Zip_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Zip = mDataRec.Zip

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Zip( _ 
   ByVal bvZip As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Zip_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Zip = bvZip

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Country() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Country_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Country = mDataRec.Country

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Country( _ 
   ByVal bvCountry As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Country_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Country = bvCountry

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Comment() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Comment_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Comment = mDataRec.Comment

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Comment( _ 
   ByVal bvComment As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Comment_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Comment = bvComment

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Source() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Source_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Source = mDataRec.Source

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Source( _ 
   ByVal bvSource As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Source_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Source = bvSource

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

Public Property Get Priority() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Priority_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Priority = mDataRec.Priority

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Priority( _ 
   ByVal bvPriority As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Priority_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Priority = bvPriority

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get CallBackDate() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CallBackDate_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   If IsDate(mDataRec.CallBackDate) Then CallBackDate = mDataRec.CallBackDate Else CallBackDate = 0
   If mDataRec.CallBackDate = "1/1/1900" Then CallBackDate = 0

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let CallBackDate( _ 
   ByVal bvCallBackDate As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CallBackDate_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.CallBackDate = bvCallBackDate

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get CallBackTime() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CallBackTime_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   CallBackTime = mDataRec.CallBackTime

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let CallBackTime( _ 
   ByVal bvCallBackTime As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CallBackTime_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.CallBackTime = bvCallBackTime

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get TimeZone() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "TimeZone_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   TimeZone = mDataRec.TimeZone

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let TimeZone( _ 
   ByVal bvTimeZone As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "TimeZone_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.TimeZone = bvTimeZone

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get BestTime() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "BestTime_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   BestTime = mDataRec.BestTime

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let BestTime( _ 
   ByVal bvBestTime As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "BestTime_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.BestTime = bvBestTime

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get DistributorID() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "DistributorID_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   DistributorID = mDataRec.DistributorID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let DistributorID( _ 
   ByVal bvDistributorID As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "DistributorID_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.DistributorID = bvDistributorID

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get DistributeDate() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "DistributeDate_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   If IsDate(mDataRec.DistributeDate) Then DistributeDate = mDataRec.DistributeDate Else DistributeDate = 0
   If mDataRec.DistributeDate = "1/1/1900" Then DistributeDate = 0

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let DistributeDate( _ 
   ByVal bvDistributeDate As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "DistributeDate_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.DistributeDate = bvDistributeDate

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Get Code() As String
   '------------------------------------------------------------------------------------------------------------------------
   '   Returns the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Code_Get"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   Code = mDataRec.Code

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Public Property Let Code( _ 
   ByVal bvCode As String)
   '------------------------------------------------------------------------------------------------------------------------
   '   Sets the value of the attribute.
   '------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Code_Let"
   '------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   mDataRec.Code = bvCode

   Exit Property

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Property

Private Sub Class_Initialize()
   mCurrentLanguage = cDefaultLanguage
End Sub