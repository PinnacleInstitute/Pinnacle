<%
Function CreateCCCKFiles( byVal CompanyID, byRef reqCCTotal, byRef reqCKTotal, byRef reqCCFile, byRef reqCKFile, byRef reqError)
	On Error Resume Next
    
	Dim oFileSys, oCCFile, oCKFile, Rec
	Dim CardType, CardNumber, CardDate, CardCode, CardName
	Dim CheckBank, CheckRoute, CheckAccount, CheckNumber, CheckName, CheckAcctType
	Dim FinanceEmail, CardProcessor, CheckProcessor, CardAcct, CheckAcct
	
MaxChkAmt = 10000
	            
   Set oBusiness = server.CreateObject("ptsBusinessUser.CBusiness")
   If oBusiness Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsBusinessUser.CBusiness"
   Else
      With oBusiness
         .SysCurrentLanguage = reqSysLanguage
         .Load 1, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
			FinanceEmail = .FinanceEmail
			CardProcessor = CLng(.CardProcessor)
			CheckProcessor = CLng(.CheckProcessor)
			CardAcct = .CardAcct
			CheckAcct = .CheckAcct
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oBusiness = Nothing

	IF FinanceEmail = "" Then reqError = "ERROR: Missing Finance Email Address!"
	IF CardProcessor = 0 Then reqError = "ERROR: Missing Credit Card Processor!"
	IF CheckProcessor = 0 Then reqError = "ERROR: Missing Bank Account Processor!"
	IF CardAcct = "" Then reqError = "ERROR: Missing Credit Card - Account #!"
	IF CheckAcct = "" Then reqError = "ERROR: Missing Bank Account - Account #!"
	SELECT CASE CardProcessor
		CASE 6   ' Merchant Partner
		CASE 10  ' Pay Junction
		CASE ELSE
			reqError = "ERROR: Unsupported Credit Card Processor!"
	END SELECT
	SELECT CASE CheckProcessor
		CASE 7  ' Merchant Partners
		CASE 100  ' Legacy Texas Bank
		CASE ELSE
			reqError = "ERROR: Unsupported Bank Account Processor!"
	END SELECT

	IF reqError = "" Then	
	
		Set oFileSys = CreateObject("Scripting.FileSystemObject")
		If oFileSys Is Nothing Then
		   Response.Write "Scripting.FileSystemObject failed to load"
		   Response.End
		End If

		Set oPayments = server.CreateObject("ptsPaymentUser.CPayments")
		If oPayments Is Nothing Then
		   DoError Err.Number, Err.Source, "Unable to Create Object - ptsPaymentUser.CPayments"
		Else
			With oPayments
			.SysCurrentLanguage = reqSysLanguage
			.ListSubmittedCCCK CompanyID
			If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

			Path = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Billing\"
			dt = CStr(Year(Date)) + "-" + CStr(Month(Date)) + "-" + CStr(Day(Date)) + "-" + CSTR(Hour(Now)) + "-" + CSTR(Minute(Now))
			reqCCFile = "CC" + CSTR(CardProcessor) + "-" + dt + ".txt"
			reqCKFile = "ACH" + CSTR(CheckProcessor) + "-" + dt + ".txt"

			reqCCTotal = 0
			reqCKTotal = 0
			CKAmt = 0
			CKHsh = 0
			For Each oPay in oPayments
				With oPay

					'Get Billing Information
					tmpData = .Description
					pos = InStr(tmpData, "Charged:[")
					If pos > 0 Then
						tmpData = Mid(tmpData, pos + 9)
						pos = InStr(tmpData, "]")
						If pos > 0 Then tmpData = Left(tmpData, pos - 1)
					End If

					'Process Credit Cards
					If .PayType >= 1 AND .PayType <= 4 Then
						If reqCCTotal = 0 Then
							Set oCCFile = oFileSys.CreateTextFile(Path + reqCCFile, True)
							If oCCFile Is Nothing Then
								Response.Write "Couldn't create CC file: " + Path + reqCCFile
								Response.End
							End If
							'Write File Header
							Select Case CardProcessor
							Case 6 'Merchant Partner: RecordType, Email Addresses
								Rec = "EmailReceiptTo" & VBTAB & FinanceEmail 
								oCCFile.WriteLine(Rec)
							Case 10 'Pay Junction
							End Select
						End If
						cnt = 1
						CardType = ""
						CardNumber = ""
						CardDate = ""
						CardCode = ""
						CardName = ""
						CardZip = ""
						While Len(tmpData) > 0
							pos = InStr(tmpData, ";")
							If pos > 0 Then
								token = Left(tmpData, pos-1) 
								tmpData = Mid(tmpData, pos+1)
							Else
								token = tmpData 
								tmpData = ""
							End If   
							Select Case cnt
							Case 1: CardType = Trim(token)
							Case 2: CardNumber = Trim(token)
							Case 3: CardDate = Trim(token)
							Case 4: CardCode = Trim(token)
							Case 5: CardName = Trim(token)
							Case 6: CardZip = Trim(token)
							End Select
							cnt = cnt + 1
						Wend
						'Write Transaction Record
						Select Case CardProcessor
						Case 6 'Merchant Partner: TransactionID, RecordType, AcctID, Amount, CCName, CCNum, CCExpMonth, CCExpYear
							CCExpMonth = ""
							CCExpYear = ""
							pos = InStr(CardDate, "/")
							If pos > 0 Then
								CCExpMonth = Left(CardDate, pos-1) 
								CCExpYear = Mid(CardDate, pos+1)
							End If
							If Len(CCExpMonth) = 1 Then CCExpMonth = "0" + CCExpMonth
							If Len(CCExpYear) = 1 Then CCExpYear = "0" + CCExpYear
							If CCExpYear <> "" Then CCExpYear = "20" + CCExpYear
							Rec = .PaymentID & VBTAB & "ns_quicksale_cc" & VBTAB & CardAcct & VBTAB & .Amount & VBTAB & CardName & VBTAB & CardNumber & VBTAB & CCExpMonth & VBTAB & CCExpYear 
							'Add CVV2 field, locatred in cloumn #37
							If CardCode <> "" Then
								tmpCVV2 = VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+VBTAB+CardCode
							Else
								tmpCVV2 = ""
							End If
							oCCFile.WriteLine( Rec + tmpCVV2 )
						Case 10 'Pay Junction: "action", "credit_card_number", "expiration", "name", "invoice", "amount", "address", "zip", "verification" 
											  '"charge", "4444333322221111", "0104", "PayJunction", "", "1.00", "12 main st.", "90210", "123" 
							pos = InStr(CardDate, "/")
							If pos > 0 Then
								CCExpMonth = Left(CardDate, pos-1) 
								CCExpYear = Mid(CardDate, pos+1)
							End If
							If Len(CCExpMonth) = 1 Then CCExpMonth = "0" + CCExpMonth
							If Len(CCExpYear) = 1 Then CCExpYear = "0" + CCExpYear
							Rec = """" + "charge" + """,""" + CardNumber + """,""" + CCExpMonth + CCExpYear + """,""" + CardName + """,""" + .PaymentID + """,""" + .Amount + """,""" + "" + """,""" + CardZip  + """,""" + CardCode  + """"  
							oCCFile.WriteLine( Rec )
						End Select
						reqCCTotal = reqCCTotal + 1
					End If

					'Process Bank Accounts
					If .PayType = 5 Then
						If reqCKTotal = 0 Then
							Set oCKFile = oFileSys.CreateTextFile(Path + reqCKFile, True)
							If oCKFile Is Nothing Then
								Response.Write "Couldn't create CK file: " + Path + reqCKFile
								Response.End
							End If
							'Write File Header
							Select Case CheckProcessor
							Case 7 'Merchant Partner: RecordType, Email Addresses
								Rec = "EmailReceiptTo" & VBTAB & FinanceEmail 
								oCKFile.WriteLine(Rec)
							Case 100 'Legacy Texas Bank
								oCKFile.WriteLine( ACHHeader() )
							End Select
						End If
						cnt = 1
						CheckBank = ""
						CheckRoute = ""
						CheckAccount = ""
						CheckNumber = ""
						CheckName = ""
						CheckAcctType = ""
						While Len(tmpData) > 0
							pos = InStr(tmpData, ";")
							If pos > 0 Then
								token = Left(tmpData, pos-1) 
								tmpData = Mid(tmpData, pos+1)
							Else
								token = tmpData 
								tmpData = ""
							End If
							Select Case cnt
							Case 1: CheckBank = Trim(token)
							Case 2: CheckRoute = Trim(token)
							Case 3: CheckAccount = Trim(token)
							Case 4: CheckNumber = Trim(token)
							Case 5: CheckName = Trim(token)
							Case 6: CheckAcctType = Trim(token)
							End Select
							cnt = cnt + 1
						Wend
						'Write Transaction Record
						Select Case CheckProcessor
						Case 7 'Merchant Partner: TransactionID, RecordType, AcctID, Amount, CKName, CKABA, CKAccount
							Rec = .PaymentID & VBTAB & "ns_quicksale_check" & VBTAB & CheckAcct & VBTAB & .Amount & VBTAB & CheckName & VBTAB & CheckRoute & VBTAB & CheckAccount 
							oCKFile.WriteLine(Rec)
							reqCKTotal = reqCKTotal + 1
						Case 8 'Legacy Texas Bank
							'	-------- PPD Entry Detail Record -----------------
							'	Record Type Code		"6"
							'	Transaction Code		"27" or "37"
							'	Receiving DFI ID		8 digits 
							'	DFI Check Digit			1 digit
							'	DFI Acccount Number		17 alpha-digits
							'	Amount					"$$$$$$$$cc"
							'	Receiver ID				15 alpha-digits
							'	Receiver Name			22 characters
							'	Discretionary Data		2 spaces
							'	Addenda Record Flag		"0"
							'	Trace Number			"111901230000000"

							acct = LEFT(CheckAccount + Space(17), 17)
							If CheckAcctType = "2" Then accttype = "37" Else accttype = "27"
							fmtAmt = Right(String(10,"0") + Digits(.Amount),10)
							id = LEFT(.PaymentID + Space(15), 15)
'							nam = GetMemberName(id)  
							nam = CheckName  
							nam = LEFT(nam + Space(22), 22)  
							Rec = "6" + accttype + CheckRoute + acct + fmtAmt + id + nam + Space(2) + "0" + "111901230000000"

							If ( CKAmt + CCUR(.Amount) ) < MaxChkAmt Then
								oCKFile.WriteLine(Rec)
								CKAmt = CKAmt + CCUR(.Amount)
								CKHsh = CKHsh + CLNG(LEFT(CheckRoute,8))
								reqCKTotal = reqCKTotal + 1
							Else
								Exit For
							End If

						End Select
					End If

				End With
			Next

			If reqCCTotal > 0 Then
				'Write File Footer
				Select Case CardProcessor
				Case 6  'Merchant Partner:
				Case 10 'Pay Junction:
				End Select
				oCCFile.Close
			End If	
			
			If reqCKTotal > 0 Then
				'Write File Footer
				Select Case CheckProcessor
				Case 7 'Merchant Partner:
				Case 8 'Legacy Texas Bank
					oCKFile.WriteLine( ACHFooter( reqCKTotal, CKAmt, CKHsh ) )
				End Select
				oCKFile.Close
			End If	

			Set oCCFile = Nothing
			Set oCKFile = Nothing

			End With
		End If

		Set oPayments = Nothing
		Set oFileSys = Nothing

	End If
	
End Function

'*****************************************************************************************************
Function ACHHeader()
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

	yy = Right(CStr(Year(Date)),2)
	mm = Right("0" + CStr(Month(Date)),2)
	dd = Right("0" + CStr(Day(Date)),2)
	hh = Right("0" + CStr(Hour(Now)),2)
	mn = Right("0" + CStr(Minute(Now)),2)

	YYMMDD = yy + mm + dd
	HHMM = hh + mn

	Hdr = "1" + "01" + " 111901234" + "20-2341812" + YYMMDD + HHMM + "A" + "094" + "10" + "1" + "Legacy Texas Bank      " + "Pinnacle Institute     " + Space(8)
	Hdr = Hdr + CHR(13) + CHR(10)
	
'	-------- Batch Header Record -------------------------
'	Record Type Code		"5"
'	Service Class Code		"200"
'	Company Name			"Pinnacle Systems"
'	Discretionary Data		20 spaces
'	Company Identification	"20-2341812"
'	Standard Entry Code		"PPD"
'	Entry Description		"MO BILLING"
'	Descriptive Date		"YYMMDD"
'	Effective Date			"YYMMDD"
'	Settlement Date			3 spaces
'	Originator Status Code	"1"
'	Originator DFI ID		"11190123"
'	Batch Number			"0000001"

	Hdr = Hdr + "5" + "200" + "Pinnacle Systems" + Space(20) + "20-2341812" + "PPD" + "MO BILLING" + YYMMDD + YYMMDD + Space(3) + "1" + "11190123" + "0000001"

	ACHHeader = Hdr
		
End Function

'*****************************************************************************************************
Function ACHFooter( byVal Cnt, byVal Amt, byVal Hsh )
	On Error Resume Next
	Dim Ftr

'	-- Create Credit Record for total amount to Pinnacle Account --
'	-------- PPD Entry Detail Record -----------------
'	Record Type Code		"6"
'	Transaction Code		"22"
'	Receiving DFI ID		8 digits 
'	DFI Check Digit			1 digit
'	DFI Acccount Number		17 alpha-digits
'	Amount					"$$$$$$$$cc"
'	Receiver ID				15 alpha-digits
'	Receiver Name			22 characters
'	Discretionary Data		2 spaces
'	Addenda Record Flag		"0"
'	Trace Number			"111901230000000"

	fmtAmt = Right( String(10,"0") + Digits(Amt),10)
	Ftr = "6" + "22" + "11190123" + "4" + "70006655         " + fmtamt + "2              " + "Pinnacle Institute    " + "  " + "0" + "111901230000000"
	Ftr = Ftr + CHR(13) + CHR(10)

	'increment counter and add Route Number to Hash for last detail record
	Cnt = Cnt + 1
	Hsh = Hsh + 11190123
	
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

	Ftr = Ftr + "8" + "200" + count + hash + amount + amount + "20-2341812" + Space(19) + Space(6) + "11190123" + "0000001"
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
	Ftr = Ftr + "9" + "000001" + "00000001" + count + hash + amount + amount + Space(39)

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

'*****************************************************************************************************
Function GetMemberName( byVal bvPaymentID )
	On Error Resume Next

	Set oPayment = server.CreateObject("ptsPaymentUser.CPayment")
	If oPayment Is Nothing Then
		DoError Err.Number, Err.Source, "Unable to Create Object - ptsPaymentUser.CPayment"
	Else
		With oPayment
			.SysCurrentLanguage = reqSysLanguage
			.Load CLng(bvPaymentID), 1
			If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
			tmpMemberID = .OwnerID
		End With
	End If
	Set oPayment = Nothing

	Set oMember = server.CreateObject("ptsMemberUser.CMember")
	If oMember Is Nothing Then
		DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
	Else
		With oMember
			.SysCurrentLanguage = reqSysLanguage
			.Load CLng(tmpMemberID), 1
			If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
			tmpName = .NameFirst + " " + .NameLast
		End With
	End If
	Set oMember = Nothing

	GetMemberName = tmpName

End Function

%>

