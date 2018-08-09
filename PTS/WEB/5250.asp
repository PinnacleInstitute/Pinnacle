<!--#include file="Include\System.asp"-->
<!--#include file="Include\Company.asp"-->
<!--#include file="Include\Recur.asp"-->
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
Dim oSalesOrder, xmlSalesOrder
'-----declare page parameters
Dim reqProductID
Dim reqCompanyID
Dim reqMemberID
Dim reqPromotionID
Dim reqNoAdd
Dim reqP
Dim reqPT
Dim reqC
Dim reqME
Dim reqSP
Dim reqPR
Dim reqNA
Dim reqR
Dim reqN
Dim reqM
Dim reqS
Dim reqL
Dim reqT
Dim reqG
Dim reqA
Dim reqPA
Dim reqBadProduct
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
   SetCache "5250URL", reqReturnURL
   SetCache "5250DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "5250")
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
reqProductID =  GetInput("ProductID", reqPageData)
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqMemberID =  Numeric(GetInput("MemberID", reqPageData))
reqPromotionID =  Numeric(GetInput("PromotionID", reqPageData))
reqNoAdd =  Numeric(GetInput("NoAdd", reqPageData))
reqP =  GetInput("P", reqPageData)
reqPT =  Numeric(GetInput("PT", reqPageData))
reqC =  Numeric(GetInput("C", reqPageData))
reqME =  Numeric(GetInput("ME", reqPageData))
reqSP =  Numeric(GetInput("SP", reqPageData))
reqPR =  Numeric(GetInput("PR", reqPageData))
reqNA =  Numeric(GetInput("NA", reqPageData))
reqR =  GetInput("R", reqPageData)
reqN =  Numeric(GetInput("N", reqPageData))
reqM =  Numeric(GetInput("M", reqPageData))
reqS =  Numeric(GetInput("S", reqPageData))
reqL =  Numeric(GetInput("L", reqPageData))
reqT =  Numeric(GetInput("T", reqPageData))
reqG =  GetInput("G", reqPageData)
reqA =  Numeric(GetInput("A", reqPageData))
reqPA =  Numeric(GetInput("PA", reqPageData))
reqBadProduct =  GetInput("BadProduct", reqPageData)
'-----get the userID and security group
CheckSecurity reqSysUserID, reqSysUserGroup, 0, 0


If (reqSP = 0) Then
   reqSP = Numeric(GetCache("A"))
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      If (reqProductID <> "") Then
         reqP = reqProductID
      End If
      If (reqCompanyID <> 0) Then
         reqC = reqCompanyID
      End If
      If (reqMemberID <> 0) Then
         reqME = reqMemberID
      End If
      If (reqPromotionID <> 0) Then
         reqPR = reqPromotionID
      End If
      If (reqNoAdd <> 0) Then
         reqNA = reqNoAdd
      End If
      If (reqC <> 0) And (reqME = 0) And (reqR <> "") Then

         Set oMember = server.CreateObject("ptsMemberUser.CMember")
         If oMember Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
         Else
            With oMember
               .FetchRef reqC, reqR
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               reqME = .MemberID
               
            If reqME = 0 Then
               response.write "0 - Member Not Found - Order Not Processed"
               response.end
            End If

            End With
         End If
         Set oMember = Nothing
      End If
      If (reqC <> 0) And (reqSysCompanyID = 0) Then
         GetCompany(reqC)
      End If
      If (reqC = 0) Then
         reqC = reqSysCompanyID
      End If
      If (reqME = 0) Then
         reqME = reqSysMemberID
      End If
      If (reqN <> 0) Then
         SetCache "SHOPPINGCART", 0
      End If
      tmpShoppingCartID = Numeric(GetCache("SHOPPINGCART"))

      If (tmpShoppingCartID <> 0) And (reqME <> 0) Then
         Set oSalesOrder = server.CreateObject("ptsSalesOrderUser.CSalesOrder")
         If oSalesOrder Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsSalesOrderUser.CSalesOrder"
         Else
            With oSalesOrder
               .Load tmpShoppingCartID, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               .MemberID = reqME
               .Save CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oSalesOrder = Nothing
      End If

      If (tmpShoppingCartID = 0) Then
         Set oSalesOrder = server.CreateObject("ptsSalesOrderUser.CSalesOrder")
         If oSalesOrder Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsSalesOrderUser.CSalesOrder"
         Else
            With oSalesOrder
               .Load 0, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               .CompanyID = reqC
               .MemberID = reqME
               .PromotionID = reqPR
               .PartyID = reqPA
               .OrderDate = Now
               .AffiliateID = reqSysAffiliateID
               If (reqM = 0) And (reqA <> 0) Then
                  .AutoShip = 2
               End If
               tmpShoppingCartID = CLng(.Add(CLng(reqSysUserID)))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               If (reqM = 0) And (reqA <> 0) Then
                  .SetAutoShip reqME, tmpShoppingCartID
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
               SetCache "SHOPPINGCART", tmpShoppingCartID
            End With
         End If
         Set oSalesOrder = Nothing
      End If
      If (reqM = 0) And (reqA <> 0) And (reqME <> 0) Then

         Set oMember = server.CreateObject("ptsMemberUser.CMember")
         If oMember Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
         Else
            With oMember
               .Load reqME, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               If (.AutoShipDate = "") Then
                  .AutoShipDate = reqSysDate
                  .Save CLng(reqSysUserID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
            End With
         End If
         Set oMember = Nothing
      End If
      
If (reqP <> "") Then
    Set oProduct = server.CreateObject("ptsProductUser.CProduct")
    Set oSalesItem = server.CreateObject("ptsSalesItemUser.CSalesItem")

    With oSalesItem
        .SalesOrderID = tmpShoppingCartID
        .Status = 1
    End With

   aProducts = Split(reqP, ",")
   reqTotal = UBOUND(aProducts)
   For x = 0 to reqTotal
      tmpLocks = 0
      tmpQty = 1
      tmpInputValues = ""
      product = aProducts(x)
      If Left(product, 1) = "(" Then
         pos = InStr(product, ")")
         If pos > 0 Then
            tmpQty = Mid( product, 2, pos-2)
            product = Mid( product, pos+1)
         End If   
      End If
      If Left(product, 1) = "*" Then
         tmpLocks = 1
         product = Mid( product, 2)      
      End If
      If Left(product, 1) = "-" Then
         tmpLocks = 2
         product = Mid( product, 2)      
      End If
      pos = InStr(product, ";")
      If pos > 0 Then
         tmpInputValues = Replace(product, ";", vbCrLf, pos+1)
         product = Left(product, pos-1)
      End If
      productid = product
      With oProduct
         .Load productid, 1
         tmpInventory = .Inventory
         tmpInStock = .InStock
         tmpPrice = .Price
         tmpBV = .BV
         tmpRecur = .Recur
         tmpTerm = .RecurTerm
         tmpInputOptions = .InputOptions
      End With

      'Check for Inventory Stock
      result = oProduct.CheckInventory( productid, 0 )
      If result <> -999999 AND result < 0 Then
         If reqBadProduct <> "" Then reqBadProduct = reqBadProduct + ","
         reqBadProduct = reqBadProduct + productid
      Else
         tmpStartBill = 0
         tmpEndBill = 0
         If tmpRecur > 0 Then GetRecur tmpStartBill, tmpEndBill, tmpRecur, tmpTerm

         tmpOptionPrice = 0
         If tmpInputOptions <> "" Then
             Set oInputOptions = server.CreateObject("wtSystem.CInputOptions")
            With oInputOptions
               .Load tmpInputOptions, tmpInputValues
               tmpInputValues = .Values
               tmpOptionPrice = .TotalPrice
            End With   
            Set oInputOptions = Nothing
         End If

         With oSalesItem
            SalesItemID = CLng(.DuplicateProduct(tmpShoppingCartID, productid))
            If (SalesItemID = 0) Then
               .ProductID = productid
               .Quantity = tmpQty
               .Price = tmpPrice
               .BV = tmpBV
               .BillDate = tmpStartBill
               .EndDate = tmpEndBill
               .InputValues = tmpInputValues
               .OptionPrice = tmpOptionPrice
               .Locks = tmpLocks
               SalesItemID = .Add(1)
            End If
         End With
      End If
    Next
    Set oSalesItem = Nothing
    Set oProduct = Nothing
End If


      If (reqM <> 0) Then
         Response.Redirect "0432.asp" & "?CompanyID=" & reqC & "&MemberID=" & reqSP & "&S=" & reqS & "&L=" & reqL & "&T=" & reqT & "&G=" & reqG & "&A=" & reqA
      End If

      If (reqM = 0) Then
         Response.Redirect "5251.asp" & "?ShoppingCartID=" & tmpShoppingCartID & "&CompanyID=" & reqC & "&MemberID=" & reqME & "&SponsorID=" & reqSP & "&NoAdd=" & reqNA & "&BadProduct=" & reqBadProduct & "&ProductTypeID=" & reqPT
      End If
End Select

%>