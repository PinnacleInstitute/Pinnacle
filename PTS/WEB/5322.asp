<!--#include file="Include\System.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
'-----system variables
Dim reqActionCode
Dim reqSysUserID, reqSysUserGroup, reqSysUserStatus, reqSysUserName, reqSysEmployeeID, reqSysCustomerID, reqSysAffiliateID, reqSysAffiliateType
Dim reqSysDate, reqSysTime, reqSysTimeno, reqSysServerName, reqSysServerPath, reqSysWebDirectory
Dim reqPageURL, reqPageData, reqReturnURL, reqReturnData
Dim reqSysCompanyID, reqSysTrainerID, reqSysMemberID, reqSysOrgID, reqSysUserMode, reqSysUserOptions, reqSysGA_ACCTID, reqSysGA_DOMAIN
'-----object variables
Dim oProduct, xmlProduct
Dim oSalesItem, xmlSalesItem
'-----declare page parameters
Dim reqCO
Dim reqSO
Dim reqPC
Dim reqQT
Dim reqDS
Dim reqPR
Dim reqBV
On Error Resume Next

'-----Call Common System Function
CommonSystem()

Sub DoError(ByVal bvNumber, ByVal bvSource, ByVal bvErrorMsg)
   xmlError = bvErrorMsg
   Err.Clear
End Sub

'-----initialize the error data
xmlError = ""

'-----save the return URL and form data if supplied
If (Len(Request.Item("ReturnURL")) > 0) Then
   reqReturnURL = Replace(Request.Item("ReturnURL"), "&", "%26")
   reqReturnData = Replace(Request.Item("ReturnData"), "&", "%26")
   SetCache "5322URL", reqReturnURL
   SetCache "5322DATA", reqReturnData
End If

'-----restore my form if it was cached
reqPageData = GetCache("RETURNDATA")
SetCache "RETURNDATA", ""

reqActionCode = Numeric(GetInput("ActionCode", reqPageData))
reqSysEmployeeID = Numeric(GetCache("EMPLOYEEID"))
reqSysCustomerID = Numeric(GetCache("CUSTOMERID"))
reqSysAffiliateID = Numeric(GetCache("AFFILIATEID"))
reqSysAffiliateType = Numeric(GetCache("AFFILIATETYPE"))
reqSysDate = CStr(Date())
reqSysTime = CStr(Time())
reqSysTimeno = CStr((Hour(Time())*100 ) + Minute(Time()))
reqSysServerName = Request.ServerVariables("SERVER_NAME")
reqSysWebDirectory = Request.ServerVariables("APPL_PHYSICAL_PATH")
reqSysServerPath = Request.ServerVariables("PATH_INFO")
pos = InStr(LCASE(reqSysServerPath), "5322")
If pos > 0 Then reqSysServerPath = left(reqSysServerPath, pos-1)

reqSysCompanyID = Numeric(GetCache("COMPANYID"))
reqSysTrainerID = Numeric(GetCache("TRAINERID"))
reqSysMemberID = Numeric(GetCache("MEMBERID"))
reqSysOrgID = Numeric(GetCache("ORGID"))
reqSysUserMode = Numeric(GetCache("USERMODE"))
reqSysUserOptions = GetCache("USEROPTIONS")
reqSysGA_ACCTID = GetCache("GA_ACCTID")
reqSysGA_DOMAIN = GetCache("GA_DOMAIN")

'-----fetch page parameters
reqCO =  Numeric(GetInput("CO", reqPageData))
reqSO =  Numeric(GetInput("SO", reqPageData))
reqPC =  GetInput("PC", reqPageData)
reqQT =  Numeric(GetInput("QT", reqPageData))
reqDS =  GetInput("DS", reqPageData)
reqPR =  GetInput("PR", reqPageData)
reqBV =  GetInput("BV", reqPageData)
'-----get the userID and security group
CheckSecurity reqSysUserID, reqSysUserGroup, 0, 0


Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      
      If reqCO = 0 Then
         response.write "0 - Missing Company Number"
         response.end
      End If
      If reqSO = 0 Then
         response.write "0 - Missing Sales Order"
         response.end
      End If
      If reqPC = "" Then
         If reqDS = "" Then
            response.write "0 - Missing Product Code or Product Description"
            response.end
         End If
         If reqPR = "" Then
            response.write "0 - Missing Product Price"
            response.end
         End If
         If reqBV = "" Then
            response.write "0 - Missing Product Bonus Volume"
            response.end
         End If
      End If
      If reqQT = "" Then reqQT = 1


      If (reqPC <> 0) Then
         Set oProduct = server.CreateObject("ptsProductUser.CProduct")
         If oProduct Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsProductUser.CProduct"
         Else
            With oProduct
               .FetchCode reqCO, reqPC
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               If (.ProductID <> 0) Then
                  tmpProductID = .ProductID
                  tmpPrice = .Price
                  tmpBV = .BV
               End If
               If (.ProductID = 0) Then
                  reqPC = ""
                  
                  If reqDS = "" Then
                     response.write "0 - Invalid Product Code with Missing Product Description"
                     response.end
                  End If   
                  If reqPR = "" Then
                     response.write "0 - Invalid Product Code with Missing Product Price"
                     response.end
                  End If
                  If reqBV = "" Then
                     response.write "0 - Invalid Product Code with Missing Product Bonus Volume"
                     response.end
                  End If

               End If
            End With
         End If
         Set oProduct = Nothing
      End If

      Set oSalesItem = server.CreateObject("ptsSalesItemUser.CSalesItem")
      If oSalesItem Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsSalesItemUser.CSalesItem"
      Else
         With oSalesItem
            .Load 0, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .SalesOrderID = reqSO
            .Quantity = reqQT
            .Status = 3
            If (reqPC <> "") Then
               .ProductID = tmpProductID
               .Price = tmpPrice
               .BV = tmpBV
            End If
            If (reqPC = "") Then
               .Reference = Left(reqDS, 50)
               .Price = reqPR
               .BV = reqBV
            End If
            SalesItemID = CLng(.Add(CLng(reqSysUserID)))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oSalesItem = Nothing
      
               If Len(xmlError) = 0 Then
                  response.write SalesItemID
               Else
                  response.write "0 - " + xmlError
               End If   
               response.end

End Select

%>