<%
'*****************************************************************************************************
Function ExportData( byVal bvCompanyID, byVal bvType, byVal bvFromDate, byVal bvToDate, byRef brFile, byRef brTotal)
	On Error Resume Next
    
	Dim oFileSys, oFile, Rec, oItems
		            
	Set oFileSys = CreateObject("Scripting.FileSystemObject")
	If oFileSys Is Nothing Then
		Response.Write "Scripting.FileSystemObject failed to load"
		Response.End
	End If

    If bvCompanyID = 14 Then Set oItems = server.CreateObject("ptsLegacyUser.CLegacys")

    If oItems Is Nothing Then
	    Response.Write "Unable to Create Object - Items"
	    Response.End
    End If

	Path = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Data/" & bvCompanyID & "/"
    Select Case bvType
        Case 10:
            brFile = "Orders.csv"
            Hdr = "Order#,Date,Status,Total,Amount,Shipping,Member#,Group,Country"
        Case 11: 
            brFile = "Items.csv"
            Hdr = "Item#,Order#,Date,Status,Quantity,Price,Product,Category,Member#,Group,Country"
        Case 12: 
            brFile = "Payments.csv"
            Hdr = "Payment#,Order#,Date,Total,Status,Purpose,Type,Commission,Member#,Group,Country"
        Case 13: 
            brFile = "Bonuses.csv"
            Hdr = "Bonus#,Date,Total,Status,Type,Payment#,Member#,Group,Country"
        Case Else
    	    Response.Write "Invalid Export Type"
	        Response.End
    End Select
    
    Set oFile = oFileSys.CreateTextFile(Path + brFile, True)
    If oFile Is Nothing Then
        Response.Write "Couldn't create Export file: " + Path + brFile
        Response.End
    End If
	oFile.WriteLine( Hdr )
    
    days = DateDiff("d", bvFromDate, bvToDate )
    oItems.CustomList bvType, bvFromDate, days, 0

    brTotal = 0
	For Each oItem in oItems
		oFile.WriteLine( oItem.Result )
		brTotal = brTotal + 1
	Next
	
    oFile.Close
    Set oFile = Nothing
    Set oItems = Nothing
    Set oFileSys = Nothing

End Function
%>

