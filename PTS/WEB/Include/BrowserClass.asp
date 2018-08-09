<%
  '##############################################
  'Please do not delete this text
  '
  'Created by: Capo
	'Creation date: 05/04/2004
	'Version: 1.3
  'Contact mail: capo@soulcreation.com
  'Website: http://www.soulcreation.com
	
	'update: 09/04/2004
	'additions:
	'  - Mozilla<br>
	'  - Mozilla Firebird
	'  - Mozilla Firefox
	'  - Mozilla K-Meleon
	'  - Mozilla Phoenix
	'  - Crazy Browser
	'  - Galeon
	'  - Konqueror
	'  - Opera
	'  - Safari
	'  - Lotus-Notes
	'  - Lynx

'Browser Short Name: browser.getName
'Browser Full Name:  browser.getFullName
'Browser Version:    browser.getVersion
'OS Short Name:      browser.getOS
'OS Full Name:       browser.getFullOS

  '##############################################
%>

<%
	Class browserInfo

		Public userAgent

		Public Property Get getName
			getName = "unknown"
			'Leave Mozilla on this position because others are based on Mozilla technology
			if inStr(userAgent,"Mozilla") > 0 then getName = "mz" end if      'Mozilla
			if inStr(userAgent,"Firebird") > 0 then getName = "fb" end if     'Mozilla Firebird
			if inStr(userAgent,"Firefox") > 0 then getName = "ff" end if      'Mozilla Firefox
			if inStr(userAgent,"K-Meleon") > 0 then getName = "km" end if     'Mozilla K-Meleon
			if inStr(userAgent,"Phoenix") > 0 then getName = "px" end if      'Mozilla Phoenix
			'Leave MSIE on this position because others are based on MSIE technology
			if inStr(userAgent,"MSIE") > 0 then getName = "ie" end if         'Internet Explorer
			if inStr(userAgent,"Crazy") > 0 then getName = "cb" end if        'Crazy Browser
			if inStr(userAgent,"Galeon") > 0 then getName = "gl" end if       'Galeon
			if inStr(userAgent,"Konqueror") > 0 then getName = "kq" end if    'Konqueror
			if inStr(userAgent,"Opera") > 0 then getName = "op" end if        'Opera
			if inStr(userAgent,"Safari") > 0 then getName = "sf" end if       'Safari
			if inStr(userAgent,"Lotus-Notes") > 0 then getName = "ln" end if  'Lotus-Notes
			if inStr(userAgent,"Lynx") > 0 then getName = "lx" end if         'Lynx
			if ((inStr(userAgent,"Netscape") > 0) or (inStr(userAgent,"Nav") > 0)) then getName = "ns" end if     'Netscape
		End Property
		
		Public Property Get getFullName
			getFullName = "unknown"
			'Leave Mozilla on this position because others are based on Mozilla technology
			if inStr(userAgent,"Mozilla") > 0 then getFullName = "Mozilla" end if      'Mozilla
			if inStr(userAgent,"Firebird") > 0 then getFullName = "Mozilla Firebird" end if     'Mozilla Firebird
			if inStr(userAgent,"Firefox") > 0 then getFullName = "Mozilla Firefox" end if      'Mozilla Firefox
			if inStr(userAgent,"K-Meleon") > 0 then getFullName = "Mozilla K-Meleon" end if     'Mozilla K-Meleon
			if inStr(userAgent,"Phoenix") > 0 then getFullName = "Mozilla Phoenix" end if      'Mozilla Phoenix
			'Leave MSIE on this position because others are based on MSIE technology
			if inStr(userAgent,"MSIE") > 0 then getFullName = "Internet Explorer" end if         'Internet Explorer
			if inStr(userAgent,"Crazy") > 0 then getFullName = "Crazy Browser" end if        'Crazy Browser
			if inStr(userAgent,"Galeon") > 0 then getFullName = "Galeon" end if       'Galeon
			if inStr(userAgent,"Konqueror") > 0 then getFullName = "Konqueror" end if    'Konqueror
			if inStr(userAgent,"Opera") > 0 then getFullName = "Opera" end if        'Opera
			if inStr(userAgent,"Safari") > 0 then getFullName = "Safari" end if       'Safari
			if inStr(userAgent,"Lotus-Notes") > 0 then getFullName = "Lotus Notes" end if  'Lotus-Notes
			if inStr(userAgent,"Lynx") > 0 then getFullName = "Lynx" end if         'Lynx
			if ((inStr(userAgent,"Netscape") > 0) or (inStr(userAgent,"Nav") > 0)) then 'Netscape
				getFullName = "Netscape"
			end if     
		End Property

		Public Property Get getVersion
			getVersion = "???"
		
			if inStr(userAgent,"Mozilla") > 0 then 
				getVersion = mid(userAgent,inStr(userAgent,"rv")+3,3)
			end if
		
			if inStr(userAgent,"MSIE") > 0 then 
				getVersion = mid(userAgent,inStr(userAgent,"MSIE")+5,4)
				
				if mid(getVersion,4,1) = ";" then
					getVersion = mid(userAgent,inStr(userAgent,"MSIE")+5,3)
				end if
				
			end if
			
			if inStr(userAgent,"Firebird") > 0 then 
				getVersion = mid(userAgent,inStr(userAgent,"Firebird")+9,4)
			end if 
			
			if inStr(userAgent,"Firefox") > 0 then 
				getVersion = mid(userAgent,inStr(userAgent,"Firefox")+8,3)
			end if
			
			if inStr(userAgent,"K-Meleon") > 0 then 
				getVersion = mid(userAgent,inStr(userAgent,"K-Meleon")+9,5)
				
				if mid(getVersion,4,1) = "" then
					getVersion = mid(userAgent,inStr(userAgent,"K-Meleon")+9,3)
				end if
				
			end if
			
			if inStr(userAgent,"Phoenix") > 0 then 
				getVersion = mid(userAgent,inStr(userAgent,"Phoenix")+8,3)
			end if
			
			if inStr(userAgent,"Crazy") > 0 then  
				getVersion = mid(userAgent,inStr(userAgent,"Crazy Browser")+14,5)
			end if
			
			if inStr(userAgent,"Galeon") > 0 then 
				getVersion = mid(userAgent,inStr(userAgent,"Galeon")+7,6)
			end if
			
			if inStr(userAgent,"Konqueror") > 0 then 
				getVersion = mid(userAgent,inStr(userAgent,"Konqueror")+10,5)
				
				if ( mid(getVersion,2,1) = ";" or mid(getVersion,2,1) = ")" )then
					getVersion = mid(userAgent,inStr(userAgent,"Konqueror")+10,1)
				end if
				if ( mid(getVersion,4,1) = ";" or mid(getVersion,4,1) = ")" )then
					getVersion = mid(userAgent,inStr(userAgent,"Konqueror")+10,3)
				end if
				
			end if
			
			if inStr(userAgent,"Opera") > 0 then 
				getVersion = mid(userAgent,inStr(userAgent,"Opera")+6,4)
			end if
			
			if inStr(userAgent,"Safari") > 0 then 
				getVersion = mid(userAgent,inStr(userAgent,"Safari")+7,5)
			end if
			
			if inStr(userAgent,"Lotus-Notes") > 0 then 
				getVersion = mid(userAgent,inStr(userAgent,"Lotus-Notes")+12,3)
			end if
			
			if inStr(userAgent,"Lynx") > 0 then 
				getVersion = mid(userAgent,inStr(userAgent,"Lynx")+5,5)
			end if
			
			if ((inStr(userAgent,"Netscape") > 0) or (inStr(userAgent,"Nav") > 0)) then 
				getVersion = mid(userAgent,inStr(userAgent,"Netscape")+5,5)
			end if    
			
		End Property
		
		
		Public Property Get getOS
			getOS = "???"
		
			if inStr(userAgent,"Win") > 0 then
				getOS = "win"
			elseif inStr(userAgent,"Mac") > 0 then
				getOS = "mac"
			elseif inStr(userAgent,"Linux") > 0 then
				getOS = "lnx"
			elseif inStr(userAgent,"Unix") > 0 then
				getOS = "unx"
			elseif inStr(userAgent,"SunOS") > 0 then
				getOS = "sol"
			elseif inStr(userAgent,"FreeBSD") > 0 then
				getOS = "bsd"
			end if
		End Property
		
		
		Public Property Get getFullOS
			getFullOS = "unknown"
			
			if inStr(userAgent,"Win") > 0 then
				getFullOS = "Windows"
			elseif inStr(userAgent,"Mac") > 0 then
				getFullOS = "Macintosh"
			elseif inStr(userAgent,"Linux") > 0 then
				getFullOS = "Linux"
			elseif inStr(userAgent,"Unix") > 0 then
				getFullOS = "Unix"
			elseif inStr(userAgent,"SunOS") > 0 then
				getFullOS = "Sun Solaris"
			elseif inStr(userAgent,"FreeBSD") > 0 then
				getFullOS = "FreeBSD"
			end if
		End Property
		
	End Class

	Dim browser, userAgent
	Set browser = New browserInfo
	
	browser.userAgent = request.serverVariables("HTTP_USER_AGENT")
%>

