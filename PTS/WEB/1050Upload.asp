<!--#include file="Include\Cookies.asp"-->
<%
On Error Resume Next

Path = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Sections\Billing\"

CardProcessor = GetCache( "CARDPROCESSOR")

SELECT CASE CardProcessor
	CASE 6   ' Merchant Partner
	CASE 10  ' Pay Junction
	CASE ELSE
		Response.Redirect "1050.asp?UploadError=-1&UploadErrorDesc=Invalid Processor (" + CStr(CardProcessor) + ")"
END SELECT

Set Obj = Server.CreateObject("wtFileUpload.CFileUpload")
with Obj
	.InputName = "upload"
	.UpLoadPath = Path
	.Upload
	NewFileName = .UploadedFileName
	pos = InStrRev( NewFileName, "\" )
	If pos > 0 Then NewFileName = Right(NewFileName, Len(NewFileName) - pos)
End With
Set Obj = Nothing

If Err.number <> 0 Then
	Response.Redirect "1050.asp?UploadError=" & Err.Number & "&UploadErrorDesc=" & Err.Description
Else
   Dim oFileSys, oFile
   Dim PaymentID, Status, Data1, Data2, Data3
   Dim data, x, rec, pos
   Dim Total, TotalAppproved, TotalDeclined
   
   Set oFileSys = CreateObject("Scripting.FileSystemObject")
   If oFileSys Is Nothing Then
		Response.Write "Scripting.FileSystemObject failed to load"
		Response.End
   End If
   Set oFile = oFileSys.OpenTextFile(Path + NewFileName)
   If oFile Is Nothing Then
		Response.Write "Couldn't open file: " + Path + NewFileName
		Response.End
   End If
   Set oPayment = server.CreateObject("ptsPaymentUser.CPayment")
   If oPayment Is Nothing Then
		Response.Write "Unable to Create Object - ptsPaymentUser.CPayment"
		Response.End
   End If

   Total = 0
   TotalAppproved = 0
   TotalDeclined = 0

	'Process header
	SELECT CASE CardProcessor
		CASE 6   ' Merchant Partner
		CASE 10  ' Pay Junction
			rec = oFile.ReadLine
	END SELECT

   Do While oFile.AtEndOfStream <> True

	SELECT CASE CardProcessor
	CASE 6   ' Merchant Partner
		'6       ACCEPTED:SALE:018597:507021500248:2:43634563:U::        34802797
		'24      DECLINED:1101440001:Invalid Credit Card Number  34802838
		'296     ACCEPTED:CHECKAUTH:43636281:::43636281:::       34804229
		'303     DECLINED:1101720001:Invalid Bank        34804230
	   Total = Total + 1
      rec = oFile.ReadLine
      If Len(Trim(rec)) > 0 Then
		a=Split(rec, ":" )  'subscript zero based
		pos = InStr( a(0), " " )
        PaymentID = CLng(TRIM(LEFT(a(0),pos-1)))
        Status = TRIM(MID(a(0), pos+1))
        Data1 = a(1)
        Data2 = a(2)

		With oPayment
			If PaymentID > 0 Then
		        .Load PaymentID, 1
				If .OwnerID > 0 Then
					If Status = "ACCEPTED" Then
						.Status = 3
						.Reference = Data1 + ":" + Data2
					    .Save 1
						TotalAppproved = TotalAppproved + 1
					End If
					If Status = "DECLINED" Then
						.Status = 4
						.Reference = Data1
						Data2 = TRIM(LEFT(Data2,LEN(Data2)-8))
						.Notes = .Notes + " Declined:[" + Data2 + "]"
					    .Save 1
						TotalDeclined = TotalDeclined + 1
					End If
				End If
		    End If
		End With
      End If
         
	CASE 10  ' Pay Junction
		'Transaction Id,User Id,Name,Login,Service,Action,Name,Type,Acct,Date,Approved Amount,Posture,Invoice,Purchase Order,IP Address,Amount,Subtotal,Tip,Tax,Shipping,Response Code,Explanation,Approval Code,...
		'        0         1     2     3     4        5    6    7    8    9         10          11      12          13           14       15      16    17  18     19         20           21           22     
	   Total = Total + 1
      rec = oFile.ReadLine
      If Len(Trim(rec)) > 0 Then
		a=Split(rec, "," )  'subscript zero based
        PaymentID = a(12)
        Status = a(21)
        Data1 = a(22)
        Data2 = a(20)

		With oPayment
			If PaymentID > 0 Then
		        .Load PaymentID, 1
				If .OwnerID > 0 Then
					If UCASE(Status) = "APPROVED" Then
						.Status = 3
						.Reference = TRIM(Data1)
						.PaidDate = DATE
					    .Save 1
						TotalAppproved = TotalAppproved + 1
					End If
					If UCASE(Status) = "DECLINED" Then
						.Status = 4
						.Reference = TRIM(Data2)
					    .Save 1
						TotalDeclined = TotalDeclined + 1
					End If
				End If
		    End If
		End With
      End If

	END SELECT

   Loop

   oFile.Close
   Set oPayment = Nothing
   Set oFile = Nothing
   Set oFileSys = Nothing

	If Total > (TotalAppproved + TotalDeclined) Then Result = "ERROR!~" &  Total - (TotalAppproved + TotalDeclined) & " Payments Unprocessed!~"
	Result = Result & TotalAppproved + TotalDeclined  & " Payments Processed!~" & TotalAppproved & " Payments Approved!~" & TotalDeclined & " Payments Declined!"  
	Response.Redirect "1050.asp?Result=" + Result
End If

%>