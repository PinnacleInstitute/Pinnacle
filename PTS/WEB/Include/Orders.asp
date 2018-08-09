<%
'*****************************************************************************************************
Function ExportOrder( byVal bvCompanyID, byVal bvStatus, byVal bvDate, byVal bvType, byRef brFile, byRef brTotal, byRef brAmount)
	On Error Resume Next
    
	Dim oFileSys, oFile, Rec
		            
	Set oFileSys = CreateObject("Scripting.FileSystemObject")
	If oFileSys Is Nothing Then
		Response.Write "Scripting.FileSystemObject failed to load"
		Response.End
	End If

	Set oSalesOrders = server.CreateObject("ptsSalesOrderUser.CSalesOrders")
	If oSalesOrders Is Nothing Then
		DoError Err.Number, Err.Source, "Unable to Create Object - ptsSalesOrderUser.CSalesOrders"
	Else
		With oSalesOrders
		.SysCurrentLanguage = reqSysLanguage
		.CustomList bvCompanyID, bvStatus, bvDate, bvType, 0
		If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

		Path = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Orders\" & bvCompanyID & "\"
		dt = CStr(Year(Date)) + "-" + CStr(Month(Date)) + "-" + CStr(Day(Date)) + "-" + CSTR(Hour(Now)) + "-" + CSTR(Minute(Now))
        If bvStatus = 101 Then
		    brFile = "SUBMITTED" + CStr(bvType) + "-" + dt + ".csv"
		Else
		    brFile = "INPROCESS" + CStr(bvType) + "-" + dt + ".csv"
		End If    

        brTotal = 0
        brAmount = 0.0
		For Each oItem in oSalesOrders

			If brTotal = 0 Then
				Set oFile = oFileSys.CreateTextFile(Path + brFile, True)
				If oFile Is Nothing Then
					Response.Write "Couldn't create Order file: " + Path + brFile
					Response.End
				Else
				    Select Case bvCompanyID
    				    Case 14
    				        If bvType = 2 Then 'Access Report
                                rec = "organizationCustomerIdentifier,programCustomerIdentifier,memberCustomerIdentifier,previousMemberCustomerIdentifier,memberStatus,fullName,firstName,middleName,lastName,streetLine1,streetLine2,city,state,postalCode,country,phoneNumber,emailAddress,membershipRenewalDate,productIdentifier,productTemplateField1,productTemplateField2,productTemplateField3,productTemplateField4,productTemplateField5"
    				        Else
        				        rec = "SHPR,ORD_DT,SHP_DT,TRK#,STATUS,DEL_DT,ORD#,$_AMT,$_SHIP,QTY,PACKAGE,PRODUCTS,REP#,FIRSTNAME,LASTNAME,STREET1,STREET2,CITY,STATE,ZIP,COUNTRY,EMAIL,PHONE"
    				        End If
	    	    		Case Else
	    	    		    Rec = "OrderDate,Order#,Quantity,Product,ShipInfo,Member#,FirstName,LastName,Email,Phone,Street1,Street2,City,State,Zip,Country"
		    		End Select
        			oFile.WriteLine( Rec )
				End If
			End If

			With oItem
				Rec = CHR(34) + Replace(.Result, "|", CHR(34) + "," + CHR(34)) + CHR(34)
				brAmount = brAmount + .Total
			End With

			oFile.WriteLine( Rec )
					
			brTotal = brTotal + 1

		Next
		If brTotal > 0 Then oFile.Close
		Set oFile = Nothing

		End With
	End If

	Set oSalesOrders = Nothing
	Set oFileSys = Nothing

End Function

%>

