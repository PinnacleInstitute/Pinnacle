<!--#include file="Include\Cookies.asp"-->
<%
On Error Resume Next

Path = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Sections\Billing\"

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

'6       ACCEPTED:SALE:018597:507021500248:2:43634563:U::        34802797
'24      DECLINED:1101440001:Invalid Credit Card Number  34802838
'296     ACCEPTED:CHECKAUTH:43636281:::43636281:::       34804229
'303     DECLINED:1101720001:Invalid Bank        34804230

   Total = 0
   TotalAppproved = 0
   TotalDeclined = 0
   Do While oFile.AtEndOfStream <> True
	   Total = Total + 1
      rec = oFile.ReadLine
      If Len(Trim(rec)) > 0 Then
         PaymentID = CLng(TRIM(LEFT(rec,8)))
         rec = mid(rec, 9)
         Status = ""
         Data1 = ""
         Data2 = ""
         Data3 = ""
         x = 1
         Do While rec <> ""
            pos = InStr(rec, ":")
            If pos = 0 Then
               data = rec
               rec = ""
            Else
               data = Left(rec, pos - 1)
               rec = mID(rec, pos + 1)
            End If
            Select Case x
               Case 1: Status = data
               Case 2: Data1 = data
               Case 3: Data2 = data
               Case 4: Data3 = data
            End Select
            x = x + 1
         Loop

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