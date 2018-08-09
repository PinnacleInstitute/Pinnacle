<%
g_GC_Test = True

'***********************************************************************
Function TellAllCOrder( ByVal bvMemberID, ByVal bvNameFirst, ByVal bvNameLast, ByVal bvOrderDate, ByVal bvOrder, ByVal bvEmail, ByVal bvPhone, ByVal bvStreet1, ByVal bvStreet2, ByVal bvCity, ByVal bvState, ByVal bvZip, ByVal bvCountry, ByVal bvOrderData )

    On Error Resume Next

    UpdateOrder = 0
	FilePath = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Orders\19\"
    FileName = "Post_File_" + CStr(bvMemberID) + "_" + bvNameFirst + "_" + bvNameLast + "_" + bvAffName + "_r1.csv" 
    sURL = "https://"

	a = Split(bvOrderOptions, "|")
    tmpOldNew = a(0)
    tmpSIMCard = a(1) 
    tmpSIMNumber = a(2) 
    tmpLockStatus = a(3) 
    tmpPhonBrand = a(4)
    tmpPhonModel = a(5) 
    tmpIMIEnum = a(6) 
    
    tmpNumChoice = a(7) 
    tmpareaCode = a(8)
    tmpPhoneNum = a(9) 
    tmpProvider = a(10) 
    tmpAcctNumber = a(11) 
    tmpPINnumber = a(12) 

    tmpNumTrans = "" 
    tmpAffName = ""
    tmpAffiliate = ""
    tmpActDate = "" 
     
    shipping_total = 0
    shipping_tax = 0
    total = 0
    tax_total = 0
    cart_discount = 0
    order_discount = 0
    discount_total = 0
    order_total = 0
    customer_note = ""
    
    Select Case bvOrder
    Case 1:
        total = 29.99
        tax_total = 4.89
        '34.88
    Case 2:
        total = 39.99
        tax_total = 6.52
        '46.51
    Case 3:
        total = 49.99
        tax_total = 8.15
        '58.14
    Case 4:
        total = 59.99
        tax_total = 9.78
        '69.77
    End Select
        
    FileHdr = "order_id,order_number,date,status,shipping_total,shipping_tax_total,tax_total,cart_discount,order_discount,discount_total,order_total,payment_method,shipping_method," + _
    "customer_id,billing_first_name,billing_last_name,billing_company,billing_email,billing_phone,billing_address_1,billing_address_2,billing_postcode,billing_city,billing_state,billing_country," + _
    "shipping_first_name,shipping_last_name,shipping_address_1,shipping_address_2,shipping_postcode,shipping_city,shipping_state,shipping_country,shipping_company," + _
    "customer_note,line_items,shipping_items,tax_items,coupons,order_notes,OldNew,SIMcard,LockStatus,PhonBrand,PhonModel,IMEInum,NumTrans,NumChoice,Provider,AcctNumber,PINnumber,areaCode,PhoneNUM,AffName,Affiliate,ActDate" + VBCRLF

    'SAMPLE DATA -----------------------------------------------------------------------------------------------------
    '4415,#4415,2014-09-15 04:48:06,processing,0,0.00,8.15,0.00,0.00,0.00,58.14,authorize_net_cim,Free Shipping,
    '861,Lorenzo,Cunningham,,lawrencecunningham@hotmail.com,8086926750,86-131 Kuwale Rd,Waianae,96792,Waianae,HI,,
    'Lorenzo,Cunningham,86-131 Kuwale Rd,Waianae,96792,Waianae,HI,,,
    'SIM# 8901260602763306148,name:Plan One $29.99|sku:111112|quantity:1|total:49.99|meta:,method:Free Shipping|total:0.00,code:US-TAXES & FEES-1|total:8.15,,
    '"Payment received for subscription ""Plan One $29.99""|Activated Subscription ""Plan One $29.99"".|Order status changed from pending to processing.|Authorize.net Transaction Approved: Visa ending in 5049 (expires 10/16)|Pending subscription created for ""Plan One $29.99"".","Yes, using my phone ","Using my own SIM, enter your SIM # in Order Notes","Yes, my phone is UNLOCKED",Alcatel,Tmobile One Touch,013778008810018,,,,,,808,,tmw,778,
    
    Data = CStr(bvMemberID) + ",#" + CStr(bvMemberID) + ","
    Data = Data + CStr(bvOrderDate) + ",processing,"
    Data = Data + CStr(shipping_total) + "," + CStr(shipping_tax) + "," + CStr(total) + "," + CStr(tax_total) + "," + CStr(cart_discount) + "," + CStr(order_discount) + "," + CStr(discount_total) + "," + CStr(order_total) + ","
    Data = Data + "authorize_net_cim,Free Shipping,"
    Data = Data + CStr(bvMemberID) + "," + CStr(bvNameFirst) + "," + CStr(bvNameLast) + ",," + CStr(bvEmail) + "," + CStr(bvPhone) + "," + CStr(bvStreet1) + "," + CStr(bvStreet2) + "," + CStr(bvZip) + "," + CStr(bvCity) + "," + CStr(bvState) + "," + CStr(bvCountry) + ","
    Data = Data + CStr(bvNameFirst) + "," + CStr(bvNameLast) + "," + CStr(bvStreet1) + "," + CStr(bvStreet2) + "," + CStr(bvZip) + "," + CStr(bvCity) + "," + CStr(bvState) + "," + CStr(bvCountry) + ",,"
    Data = Data + customer_note + ",1,1,1,0,,"
    Data = Data + CStr(tmpOldNew) + "," + CStr(tmpSIMCard) + "," + CStr(tmpLockStatus) + "," + CStr(tmpPhonBrand) + "," + CStr(tmpPhonModel) + "," + CStr(tmpIMEInum) + "," + CStr(tmpNumTrans) + "," + CStr(tmpNumChoice) + ","
    Data = Data + CStr(tmpProvider) + "," + CStr(tmpAcctNumber) + "," + CStr(tmpPINnumber) + "," + CStr(tmpareaCode) + "," + CStr(tmpPhoneNUM) + "," + CStr(tmpAffName) + "," + CStr(tmpAffiliate) + "," + CStr(tmpActDate) 
    Data = Data + VBCRLF
    
    sResponse = TA_SendApiRequest( sURL, Data, "POST" )

    LogGCFile "TAOrder", sResponse

    TellAllCOrder = ""

End Function

'****************************************************************************************
Function TA_SendApiRequest(byVal bvURL, byVal bvRequest, byVal bvMethod)
    On Error Resume Next
    Dim signature, oHTTP, sResponse 

'    If g_GC_Test Then Response.Write "<BR><BR>URL: " & bvURL
    If g_GC_Test Then Response.Write "<BR><BR>Request: " & bvRequest

    Set oHTTP = Server.CreateObject("MSXML2.ServerXMLHTTP")
    With oHTTP
        .open bvMethod, bvURL
        .setRequestHeader "Content-Type", "application/Json"
        .send bvRequest
        sResponse = .responseText
    End With
    Set oHTTP = Nothing

    If g_GC_Test Then Response.Write "<BR><BR>Response: " & sResponse
    TA_SendApiRequest = sResponse
End Function

'**************************************************************************************
Function LogTAFile(ByVal bvFilename, ByVal bvLine)
   On Error Resume Next
	Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
	'Open the text file for appending
	FilePath = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Log\"
	Set objTextStream = objFSO.OpenTextFile(FilePath + bvFilename + ".txt", 8, 1)
	'write the line to the file 
	objTextStream.WriteLine CSTR(Date()) + " " + CSTR(Time()) + " " + bvLine
	'Close the file and clean up
	objTextStream.Close
	Set objTextStream = Nothing
	Set objFSO = Nothing
End Function

%>
