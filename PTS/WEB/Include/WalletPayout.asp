<%
'*** Requires BillingPayout.asp ***
'*****************************************************************************************************
Function ExportWalletWallet( byVal CompanyID, byVal Processor, byVal PayDate, byRef reqTotal, byRef reqFile, byRef reqAmount)
	On Error Resume Next
    
	Dim oFileSys, oFile, Rec
	Processor_iPayout = 11
	Processor_PayQuicker = 12
	Processor_SolidTrust = 13
	Processor_Coinbase = 14

	If Processor < Processor_iPayout or Processor > Processor_Coinbase Then
		Response.Write "Processor " & Processor & " not supported"
		Response.End
	End If
    		            
	Set oFileSys = CreateObject("Scripting.FileSystemObject")
	If oFileSys Is Nothing Then
		Response.Write "Scripting.FileSystemObject failed to load"
		Response.End
	End If

	Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
	If oBilling Is Nothing Then
		Response.Write "ptsBillingUser.CBilling failed to load"
		Response.End
	End If

	Set oPayouts = server.CreateObject("ptsPayoutUser.CPayouts")
	If oPayouts Is Nothing Then
		DoError Err.Number, Err.Source, "Unable to Create Object - ptsPayoutUser.CPayouts"
	Else
		With oPayouts
		.SysCurrentLanguage = reqSysLanguage
		.WalletExport CompanyID, 0, PayDate, Processor
		If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

		Path = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Payout\" & CompanyID & "\"
		dt = CStr(Year(Date)) + "-" + CStr(Month(Date)) + "-" + CStr(Day(Date)) + "-" + CSTR(Hour(Now)) + "-" + CSTR(Minute(Now))
        reqFile = "WAL-" + CSTR(Processor) + "-" + dt + ".csv"
	    If Processor = Processor_iPayout Then reqFile = "WAL-IP-" + dt + ".csv"
	    If Processor = Processor_PayQuicker Then reqFile = "WAL-PQ-" + dt + ".txt"
	    If Processor = Processor_SolidTrust Then reqFile = "WAL-ST-" + dt + ".txt"
	    If Processor = Processor_Coinbase Then reqFile = "WAL-CB-" + dt + ".txt"

		reqTotal = 0
		reqAmount = 0.0
		cnt = 0
		For Each oItem in oPayouts
		    With oItem
    		    If CLng(.PayType) = Processor Then
                    cnt = cnt + 1
                    If reqTotal = 0 Then
                        Set oFile = oFileSys.CreateTextFile(Path + reqFile, True)
                        If oFile Is Nothing Then
                            Response.Write "Couldn't create Wallet file: " + Path + reqFile
                            Response.End
                        Else
                            Select Case Processor
                            Case Processor_iPayout:
                                Rec = "UserName,Amount,Currency,MerchantRefID,Comments"
                                oFile.WriteLine( Rec )
                            Case Processor_PayQuicker:
                                Rec = "VERSION:2750cdf9-e06a-4fdc-8bfe-1e5eaa32778f"
                                oFile.WriteLine( Rec )
                                Rec = "EMAIL	AMOUNT	COUNTRYCODE	STATECODE	ACCOUNTINGID	COMMENT"
                                oFile.WriteLine( Rec )
                            Case Processor_SolidTrust:
                                Rec = "" 'Blank first row need for bug
                                oFile.WriteLine( Rec )
                            Case Processor_Coinbase:
                                Rec = "" 'Blank first row need for bug
                                oFile.WriteLine( Rec )
                            End Select
                        End If
                    End If

                    'PayoutID, Amount, PayType, { Pay:[], MemberID, BillingName, CountryName }
                    a = Split(.Notes, "|")
                    PayDesc = a(0)
                    MemberID = a(1)
                    MemberName = a(2)
                    CountryName = a(3)
                    PayoutBilling  PayDesc, oBilling
                    WalletID =  TRIM(oBilling.CardName)

                    Select Case CLng(.PayType)
                    Case Processor_iPayout:
			            'Wallet #, Amount, Currency, #, Comment
			            Rec = CHR(34) + WalletID + CHR(34) + "," + .Amount + "," + "USD" + "," + MemberID + "," + CHR(34) + MemberName + " - " + CountryName + CHR(34)
                    Case Processor_PayQuicker:
			            'EMAIL	AMOUNT	COUNTRYCODE	STATECODE	ACCOUNTINGID	COMMENT
			            tmpCountryCode = ""
			            tmpStateCode = ""
			            pos = InStr(CountryName, "-")
			            If pos > 0 Then
			                tmpCountryCode = Mid(CountryName, pos+2, 2)
			                tmpStateCode = Mid(CountryName, pos+5, 50)
			            End If
		                Rec = WalletID + VBTAB + .Amount  + VBTAB + tmpCountryCode + VBTAB + tmpStateCode + VBTAB + MemberID + VBTAB + MemberName + " - " + CountryName
                    Case Processor_SolidTrust:
                        '[USERNAME] [tab] [AMOUNT] [tab] [COMMENTS] [tab] [UDF1] [tab]
			            tmpNote = MemberID + " - " + MemberName + " - " + CountryName
		                Rec = WalletID + VBTAB + .Amount  + VBTAB + tmpNote + VBTAB + MemberID
                    Case Processor_Coinbase:
			            'Wallet #, Amount, #, Comment
			            tmpNote = MemberID + " - " + Replace(MemberName + " - " + CountryName, ",", "")
			            Rec = WalletID +  "," + .Amount + "," + tmpNote
                    End Select

				    reqAmount = reqAmount + CCUR(.Amount)
			        oFile.WriteLine( Rec )
    			    reqTotal = reqTotal + 1
    			End If
		    End With
		Next
		If reqTotal > 0 Then oFile.Close
		Set oFile = Nothing

		End With
	End If

	Set oPayouts = Nothing
	Set oBilling = Nothing
	Set oFileSys = Nothing

End Function

'*****************************************************************************************************
Function ExportWalletCheck( byVal CompanyID, byVal CommDate, byVal Amount, byRef reqTotal, byRef reqFile, byRef reqAmount)
	On Error Resume Next
    
	Dim oFileSys, oFile, Rec
		            
	Set oFileSys = CreateObject("Scripting.FileSystemObject")
	If oFileSys Is Nothing Then
		Response.Write "Scripting.FileSystemObject failed to load"
		Response.End
	End If

	Set oBillings = server.CreateObject("ptsBillingUser.CBillings")
	If oBillings Is Nothing Then
		DoError Err.Number, Err.Source, "Unable to Create Object - ptsBillingUser.CBillings"
	Else
		With oBillings
		.SysCurrentLanguage = reqSysLanguage
		.CommpCheck CompanyID, CommDate, Amount
		If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

		Path = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Payout\" & CompanyID & "\"
		dt = CStr(Year(Date)) + "-" + CStr(Month(Date)) + "-" + CStr(Day(Date)) + "-" + CSTR(Hour(Now)) + "-" + CSTR(Minute(Now))
		reqFile = "CHK" + "-" + dt + ".csv"

		reqTotal = 0
		reqAmount = 0.0
		For Each oBill in oBillings

			If reqTotal = 0 Then
				Set oFile = oFileSys.CreateTextFile(Path + reqFile, True)
				If oFile Is Nothing Then
					Response.Write "Couldn't create Check file: " + Path + reqFile
					Response.End
				End If
			End If

			With oBill
				Rec = .BillingID + "," + CHR(34) + .BillingName + CHR(34) + "," + CHR(34) + .Street1 + CHR(34) + "," + CHR(34) + .Street2 + CHR(34) + "," + CHR(34) + .City + CHR(34) + "," + CHR(34) + .State + CHR(34) + "," +  CHR(34) + .Zip + CHR(34) + "," + CHR(34) + .CountryName + CHR(34) + "," + .CommDate + "," + .Amount + "," + .Memo 
				reqAmount = reqAmount + CCUR(.Amount)
			End With

			oFile.WriteLine( Rec )
					
			reqTotal = reqTotal + 1

		Next
		If reqTotal > 0 Then oFile.Close
		Set oFile = Nothing

		End With
	End If

	Set oBillings = Nothing
	Set oFileSys = Nothing

End Function

'*****************************************************************************************************
Function ExportWalletACH( byVal CompanyID, byVal CommDate, byVal Amount, byRef reqTotal, byRef reqFile, byRef reqAmount)
	On Error Resume Next
    
	Dim oFileSys, oFile, Rec, Amt, Hsh
		            
	Set oFileSys = CreateObject("Scripting.FileSystemObject")
	If oFileSys Is Nothing Then
		Response.Write "Scripting.FileSystemObject failed to load"
		Response.End
	End If

	Set oBillings = server.CreateObject("ptsBillingUser.CBillings")
	If oBillings Is Nothing Then
		DoError Err.Number, Err.Source, "Unable to Create Object - ptsBillingUser.CBillings"
	Else
		With oBillings
		.SysCurrentLanguage = reqSysLanguage
		.CommeCheck CompanyID, CommDate, Amount
		If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

		Path = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Payout\" & CompanyID & "\"
		dt = CStr(Year(Date)) + "-" + CStr(Month(Date)) + "-" + CStr(Day(Date)) + "-" + CSTR(Hour(Now)) + "-" + CSTR(Minute(Now))
		reqFile = "ACH" + "-" + dt + ".txt"

		reqTotal = 0
		reqAmount = 0.0
		Amt = 0
		Hsh = 0
		For Each oBill in oBillings

			If reqTotal = 0 Then
				Set oFile = oFileSys.CreateTextFile(Path + reqFile, True)
				If oFile Is Nothing Then
					Response.Write "Couldn't create ACH file: " + Path + reqFile
					Response.End
				Else
					oFile.WriteLine( ACHHeader(CompanyID) )
				End If
			End If
				
			'	-------- PPD Entry Detail Record -----------------
			'	Record Type Code		"6"
			'	Transaction Code		"22" or "32"
			'	Receiving DFI ID		8 digits 
			'	DFI Check Digit			1 digit
			'	DFI Acccount Number		17 alpha-digits
			'	Amount					"$$$$$$$$cc"
			'	Receiver ID				15 alpha-digits
			'	Receiver Name			22 characters
			'	Discretionary Data		2 spaces
			'	Addenda Record Flag		"0"
			'	Trace Number			"111901230000000"

			With oBill
				acct = LEFT(.CheckAccount + Space(17), 17)
				If .CheckAcctType = "2" Then accttype = "32" Else accttype = "22"
				fmtAmt = Right(String(10,"0") + Digits( FormatNumber(.Amount,2) ),10)
				id = LEFT(.BillingID + Space(15), 15)
				nam = LEFT(.BillingName + Space(22), 22)  
				tmpDFI = "11190123"
				If CompanyID = 5 Then tmpDFI = "11100002"
				If CompanyID = 7 Then tmpDFI = "11300846"
				Rec = "6" + accttype + .CheckRoute + acct + fmtAmt + id + nam + Space(2) + "0" + tmpDFI + "0000000"

				oFile.WriteLine( Rec )
						
				reqTotal = reqTotal + 1
				reqAmount = reqAmount + CCUR(.Amount)
				Amt = Amt + CCUR(.Amount)
				Hsh = Hsh + CLNG(LEFT(.CheckRoute,8))
			End With
		Next
		If reqTotal > 0 Then
			oFile.WriteLine( ACHFooter( CompanyID, reqTotal, Amt, Hsh ) )
			oFile.Close
		End If	
		Set oFile = Nothing

		End With
	End If

	Set oBillings = Nothing
	Set oFileSys = Nothing

End Function

'*****************************************************************************************************
Function ACHHeader( byVal CompanyID )
	On Error Resume Next
	Dim Hdr

'	-------- File Header Record -------------------------
'	Record Type Code		"1"
'	Priority Code			"01"
'	Immediate Destination	" 111901234"
'	Immediate Origin		"20-2341812"
'	File Create Date		"YYMMDD"
'	File Create Time		"HHMM"
'	File ID Modifier		"A"
'	Record Size				"094"
'	Blocking Factor			"10"
'	Format Code				"1"
'	Destination Name		"Legacy Texas Bank      "
'	Company Name			"Pinnacle Institute     "
'	Reference Code			8 spaces

	tmpRouting = "111901234"
	tmpCompanyID = "20-2341812"
	tmpBank    = "Legacy Texas Bank      "
	tmpCompany = "Pinnacle Institute     "
	
	If CompanyID = 5 Then
		tmpRouting   = "111000025"
		tmpCompanyID = "1454623022"
		tmpBank      = "Bank Of America        "
		tmpCompany   = "CloudZow, Inc          "
	End If
	
	If CompanyID = 7 Then
		tmpRouting = "113008465"
		tmpCompanyID   = "20-2341812"
		tmpBank    = "WoodForest Bank        "
		tmpCompany = "Wealth Resource Network"
	End If

	yy = Right(CStr(Year(Date)),2)
	mm = Right("0" + CStr(Month(Date)),2)
	dd = Right("0" + CStr(Day(Date)),2)
	hh = Right("0" + CStr(Hour(Now)),2)
	mn = Right("0" + CStr(Minute(Now)),2)

	YYMMDD = yy + mm + dd
	HHMM = hh + mn

	Hdr = "1" + "01" + " " + tmpRouting + tmpCompanyID + YYMMDD + HHMM + "A" + "094" + "10" + "1" + tmpBank + tmpCompany + Space(8)
	Hdr = Hdr + CHR(13) + CHR(10)
	
'	-------- Batch Header Record -------------------------
'	Record Type Code		"5"
'	Service Class Code		"200"
'	Company Name			"Pinnacle Univers"
'	Discretionary Data		20 spaces
'	Company Identification	"20-2341812"
'	Standard Entry Code		"PPD"
'	Entry Description		"COMMISSION"
'	Descriptive Date		"YYMMDD"
'	Effective Date			"YYMMDD"
'	Settlement Date			3 spaces
'	Originator Status Code	"1"
'	Originator DFI ID		"11190123"
'	Batch Number			"0000001"
	
	tmpCompany = "Pinnacle Systems"
	tmpCompanyID   = "20-2341812"
	tmpDFI_ID  = "11190123"
	
	If CompanyID = 5 Then
		tmpCompany = "CloudZow, Inc   "
		tmpCompanyID   = "1454623022"
		tmpDFI_ID  = "11100002"
	End If
	If CompanyID = 7 Then
		tmpCompany = "Wealth Resource "
		tmpCompanyID   = "20-2341812"
		tmpDFI_ID  = "11300846"
	End If

	Hdr = Hdr + "5" + "200" + tmpCompany + Space(20) + tmpCompanyID + "PPD" + "COMMISSION" + YYMMDD + YYMMDD + Space(3) + "1" + tmpDFI_ID + "0000001"

	ACHHeader = Hdr
		
End Function

'*****************************************************************************************************
Function ACHFooter( byVal CompanyID, byVal Cnt, byVal Amt, byVal Hsh )
	On Error Resume Next
	Dim Ftr

'	-- Create Debit Record for total amount from Pinnacle Account --
'	-------- PPD Entry Detail Record -----------------
'	Record Type Code		"6"
'	Transaction Code		"27"
'	Receiving DFI ID		8 digits 
'	DFI Check Digit			1 digit
'	DFI Acccount Number		17 alpha-digits
'	Amount					"$$$$$$$$cc"
'	Receiver ID				15 alpha-digits
'	Receiver Name			22 characters
'	Discretionary Data		2 spaces
'	Addenda Record Flag		"0"
'	Trace Number			"111901230000000"

	tmpDFI_ID    = "11190123"
	tmpDFI_CHK   = "4"
	tmpAccount   = "70006655         "
	tmpCompany   = "Pinnacle Institute    "
	tmpCompanyID = "20-2341812"
	
	If CompanyID = 5 Then
		tmpDFI_ID    = "11100002"
		tmpDFI_CHK   = "5"
		tmpAccount   = "1454623022       "
		tmpCompany   = "CloudZow, Inc         "
		tmpCompanyID = "1454623022     "
	End If
	If CompanyID = 7 Then
		tmpDFI_ID    = "11300846"
		tmpDFI_CHK   = "5"
		tmpAccount   = "1806000145       "
		tmpCompany   = "Wealth Resource Netwrk"
		tmpCompanyID = "20-2341812     "
	End If

	Ftr = ""
	Amt = FormatNumber( Amt, 2 )
	
	If CompanyID <> 5 Then
		fmtAmt = Right( String(10,"0") + Digits(Amt),10)
		Ftr = "6" + "27" + tmpDFI_ID + tmpDFI_CHK + tmpAccount + fmtamt + tmpCompanyID + tmpCompany + "  " + "0" + "111901230000000"
		Ftr = Ftr + CHR(13) + CHR(10)

		'increment counter and add Route Number to Hash for last detail record
		Cnt = Cnt + 1
		Hsh = Hsh + CLng(tmpDFI_ID)
	End If
	
	count = Right( String(6,"0") + CStr(Cnt),6)
	hash = Right( String(10,"0") + Right(CStr(Hsh),10) ,10)
	amount = Right( String(12,"0") + CStr(Digits(Amt)),12)

'	-------- Batch Control Record -------------------------
'	Record Type Code		"8"
'	Service Class Code		"200"
'	Entry Count				"NNNNNN"
'	Entry Hash				"NNNNNNNNNN"
'	Total Debit				"$$$$$$$$$$cc"
'	Total Credit			"$$$$$$$$$$cc"
'	Company Identification	"20-2341812"
'	Msg Authentication Code	19 spaces
'	Reserved				6 spaces
'	Originator DFI ID		"11190123"
'	Batch Number			"0000001"

	tmpDebit = amount
	tmpCredit = amount
	If CompanyID = 5 Then tmpDebit = "000000000000"
	tmpCompanyID = Left(tmpCompanyID, 10)

	Ftr = Ftr + "8" + "200" + count + hash + tmpDebit + tmpCredit + tmpCompanyID + Space(19) + Space(6) + tmpDFI_ID + "0000001"
	Ftr = Ftr + CHR(13) + CHR(10)
	
'	-------- File Control Record -------------------------
'	Record Type Code		"9"
'	Batch Count				"000001"
'	Block Count				"00000001"
'	Entry Count				"NNNNNNNN"
'	Entry Hash				"NNNNNNNNNN"
'	Total Debit				"$$$$$$$$$$cc"
'	Total Credit			"$$$$$$$$$$cc"
'	Reserved				39 spaces

	amount = Right(String(12,"0") + CStr(Digits(Amt)),12)
	Ftr = Ftr + "9" + "000001" + "00000001" + count + hash + tmpDebit + tmpCredit + Space(39)

	ACHFooter = Ftr
		
End Function

'*****************************************************************************************************
Function Digits( byVal Amt )
	On Error Resume Next

	length = len(Amt)
	pos = 1
	tmp = ""
	While pos <= length
		x = Mid(Amt,pos,1)
		If IsNumeric(x) Then tmp = tmp + x	
		pos = pos + 1
	Wend
	
	If InStr(Amt,"." ) = 0 Then tmp = tmp + "00"
	Digits = tmp
		
End Function
%>

