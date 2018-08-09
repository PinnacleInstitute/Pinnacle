<%@LANGUAGE="JAVASCRIPT" CODEPAGE="1252"%>

<script language=vbscript runat=server>
'*** File Upload to: Store/Images/Here, Extensions: "jpg,gif,png", Form: form1, Redirect: "www.whenuploadingdone.com"
'*** Pure ASP File Upload -----------------------------------------------------
' Copyright 2000 (c) George Petrov
'
' Script partially based on code from Philippe Collignon 
'              (http://www.asptoday.com/articles/20000316.htm)
'
' New features from GP:
'  * Fast file save with ADO 2.5 stream object
'  * new wrapper functions, extra error checking
'  * UltraDev Server Behavior extension
'
' Version: 1.5.0
'------------------------------------------------------------------------------
Sub BuildUploadRequest(RequestBin)
  'Get the boundary
  PosBeg = 1
  PosEnd = InstrB(PosBeg,RequestBin,getByteString(chr(13)))
  if PosEnd = 0 then
    Response.Write "<b>Form was submitted with no ENCTYPE=""multipart/form-data""</b><br>"
    Response.Write "Please correct the form attributes and try again."
    Response.End
  end if
  boundary = MidB(RequestBin,PosBeg,PosEnd-PosBeg)
  boundaryPos = InstrB(1,RequestBin,boundary)
  'Get all data inside the boundaries
  Do until (boundaryPos=InstrB(RequestBin,boundary & getByteString("--")))
    'Members variable of objects are put in a dictionary object
    Dim UploadControl
    Set UploadControl = CreateObject("Scripting.Dictionary")
    'Get an object name
    Pos = InstrB(BoundaryPos,RequestBin,getByteString("Content-Disposition"))
    Pos = InstrB(Pos,RequestBin,getByteString("name="))
    PosBeg = Pos+6
    PosEnd = InstrB(PosBeg,RequestBin,getByteString(chr(34)))
    Name = getString(MidB(RequestBin,PosBeg,PosEnd-PosBeg))
    PosFile = InstrB(BoundaryPos,RequestBin,getByteString("filename="))
    PosBound = InstrB(PosEnd,RequestBin,boundary)
    'Test if object is of file type
    If  PosFile<>0 AND (PosFile<PosBound) Then
      'Get Filename, content-type and content of file
      PosBeg = PosFile + 10
      PosEnd =  InstrB(PosBeg,RequestBin,getByteString(chr(34)))
      FileName = getString(MidB(RequestBin,PosBeg,PosEnd-PosBeg))
      FileName = Mid(FileName,InStrRev(FileName,"\")+1)
      'Add filename to dictionary object
      UploadControl.Add "FileName", FileName
      Pos = InstrB(PosEnd,RequestBin,getByteString("Content-Type:"))
      PosBeg = Pos+14
      PosEnd = InstrB(PosBeg,RequestBin,getByteString(chr(13)))
      'Add content-type to dictionary object
      ContentType = getString(MidB(RequestBin,PosBeg,PosEnd-PosBeg))
      UploadControl.Add "ContentType",ContentType
      'Get content of object
      PosBeg = PosEnd+4
      PosEnd = InstrB(PosBeg,RequestBin,boundary)-2
      Value = FileName
      ValueBeg = PosBeg-1
      ValueLen = PosEnd-Posbeg
    Else
      'Get content of object
      Pos = InstrB(Pos,RequestBin,getByteString(chr(13)))
      PosBeg = Pos+4
      PosEnd = InstrB(PosBeg,RequestBin,boundary)-2
      Value = getString(MidB(RequestBin,PosBeg,PosEnd-PosBeg))
      ValueBeg = 0
      ValueEnd = 0
    End If
    'Add content to dictionary object
    UploadControl.Add "Value" , Value	
    UploadControl.Add "ValueBeg" , ValueBeg
    UploadControl.Add "ValueLen" , ValueLen	
    'Add dictionary object to main dictionary
    UploadRequest.Add name, UploadControl	
    'Loop to next object
    BoundaryPos=InstrB(BoundaryPos+LenB(boundary),RequestBin,boundary)
  Loop
End Sub

'String to byte string conversion
Function getByteString(StringStr)
  For i = 1 to Len(StringStr)
 	  char = Mid(StringStr,i,1)
	  getByteString = getByteString & chrB(AscB(char))
  Next
End Function

'Byte string to string conversion
Function getString(StringBin)
  getString =""
  For intCount = 1 to LenB(StringBin)
	  getString = getString & chr(AscB(MidB(StringBin,intCount,1))) 
  Next
End Function

Function UploadFormRequest(name)
  on error resume next
  if UploadRequest.Item(name) then
    UploadFormRequest = UploadRequest.Item(name).Item("Value")
  end if  
End Function

'Process the upload
UploadQueryString = Replace(Request.QueryString,"GP_upload=true","")
if mid(UploadQueryString,1,1) = "&" then
	UploadQueryString = Mid(UploadQueryString,2)
end if

GP_uploadAction = CStr(Request.ServerVariables("URL")) & "?GP_upload=true"
If (Request.QueryString <> "") Then  
  if UploadQueryString <> "" then
	  GP_uploadAction = GP_uploadAction & "&" & UploadQueryString
  end if 
End If

If (CStr(Request.QueryString("GP_upload")) <> "") Then
'  GP_redirectPage = "www.whenuploadingdone.com"

 
 If (GP_redirectPage = "") Then
    GP_redirectPage = CStr(Request.ServerVariables("URL"))
  end if
    
  RequestBin = Request.BinaryRead(Request.TotalBytes)
  Dim UploadRequest
  Set UploadRequest = CreateObject("Scripting.Dictionary")  
  BuildUploadRequest RequestBin
  
  GP_keys = UploadRequest.Keys
  for GP_i = 0 to UploadRequest.Count - 1
    GP_curKey = GP_keys(GP_i)
    'Save all uploaded files
    if UploadRequest.Item(GP_curKey).Item("FileName") <> "" then
      GP_value = UploadRequest.Item(GP_curKey).Item("Value")
      GP_valueBeg = UploadRequest.Item(GP_curKey).Item("ValueBeg")
      GP_valueLen = UploadRequest.Item(GP_curKey).Item("ValueLen")

      if GP_valueLen = 0 then
        Response.Write "<B>An error has occured saving uploaded file!</B><br><br>"
        Response.Write "Filename: " & Trim(GP_curPath) & UploadRequest.Item(GP_curKey).Item("FileName") & "<br>"
        Response.Write "File does not exists or is empty.<br>"
        Response.Write "Please correct and <A HREF=""javascript:history.back(1)"">try again</a>"
	  	  response.End
	    end if
      
      'Create a Stream instance
      Dim GP_strm1, GP_strm2
      Set GP_strm1 = Server.CreateObject("ADODB.Stream")
      Set GP_strm2 = Server.CreateObject("ADODB.Stream")
      
      'Open the stream
      GP_strm1.Open
      GP_strm1.Type = 1 'Binary
      GP_strm2.Open
      GP_strm2.Type = 1 'Binary
        
      GP_strm1.Write RequestBin
      GP_strm1.Position = GP_ValueBeg
      GP_strm1.CopyTo GP_strm2,GP_ValueLen
    
      'Create and Write to a File
      GP_curPath = Request.ServerVariables("PATH_INFO")
      GP_curPath = Trim(Mid(GP_curPath,1,InStrRev(GP_curPath,"/")) & "uploaded/")
      if Mid(GP_curPath,Len(GP_curPath),1) <> "/" then
        GP_curPath = GP_curPath & "/"
      end if  
      on error resume next
      GP_strm2.SaveToFile Trim(Server.mappath(GP_curPath))& "\" & UploadRequest.Item(GP_curKey).Item("FileName"),2
      if err then
        Response.Write "<B>An error has occured saving uploaded file!</B><br><br>"
        Response.Write "Filename: " & Trim(GP_curPath) & UploadRequest.Item(GP_curKey).Item("FileName") & "<br>"
        Response.Write "Maybe the destination directory does not exist, or you don't have write permission.<br>"
        Response.Write "Please correct and <A HREF=""javascript:history.back(1)"">try again</a>"
  		  err.clear
	  	  response.End
	    end if
    end if
  next
  
  '***GP BEGIN REDIRECT:  with URL parameters (only if no Insert/Update)
  If (GP_redirectPage <> "") Then
    If (InStr(1, GP_redirectPage, "?", vbTextCompare) = 0 And UploadQueryString <> "") Then
      GP_redirectPage = GP_redirectPage & "?" & UploadQueryString
    End If
    Call Response.Redirect(GP_redirectPage)  
  end if  
  '***GP END REDIRECT
end if  
if UploadQueryString <> "" then
  UploadQueryString = UploadQueryString & "&GP_upload=true"
else  
  UploadQueryString = "GP_upload=true"
end if  

</script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript">
<!--

function getFileExtension(filePath) { //v1.0
  fileName = ((filePath.indexOf('/') > -1) ? filePath.substring(filePath.lastIndexOf('/')+1,filePath.length) : filePath.substring(filePath.lastIndexOf('\\')+1,filePath.length));
  return fileName.substring(fileName.lastIndexOf('.')+1,fileName.length);
}

function checkFileUpload(form,extensions) { //v1.0
  document.MM_returnValue = true;
  if (extensions && extensions != '') {
    for (var i = 0; i<form.elements.length; i++) {
      field = form.elements[i];
      if (field.type.toUpperCase() != 'FILE') continue;
      if (field.value == '') {
        alert('File is required!');
        document.MM_returnValue = false;field.focus();break;
      }
      if (extensions.toUpperCase().indexOf(getFileExtension(field.value).toUpperCase()) == -1) {
        alert('This file is not allowed for uploading!');
        document.MM_returnValue = false;field.focus();break;
  } } }
}
//-->
</script>
</head>

<body style="background: threedface; color: windowtext;" scroll=no>
<form action="<%=GP_uploadAction%>" method="post" enctype="multipart/form-data" name="form1"  onSubmit="checkFileUpload(this,'jpg,gif,png');return document.MM_returnValue">
  <input style="width : 280px; height: 2.2em;" type="file" name="file">

<BUTTON type=submit style="width: 7em; height: 2.2em; ">Ladda upp >></BUTTON>
<p style="font-family: MS Shell Dlg; font-size: 8pt;" >
För att kunna använda dina egna bilder i ditt dokument måste du ladda upp<br>
dom först. Bläddra fram till bilden du vill ladda upp och klicka sedan på ladda<br>
upp. När du laddat upp bilden/bilderna du vill använda stänger du fönstret. <br>
På föregående dialogruta kan du nu välja bilden du laddade upp. Alla bilder<br>
sparas i mappen Upload.<br>
<br>
Obs! Du kan endast använda dig av .JPG eller .GIF bilder. Filstorleken per bild<br>
får inte överstiga 30kB<br>
</p>
</form>


</body>
</html>
