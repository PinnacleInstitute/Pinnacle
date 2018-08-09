<%
' Bob Wood 2/19/04
' Test for access limitations on:
' IP:1.2.3.4
' DAY:17
' TIME:900-1700
 
Public Function LimitedAccess(ByVal bvLimit)
Dim x, z, y
Dim str, token, data
Dim time1, time2, timedata

'Initialize return as success
LimitedAccess = 1

aAccess = Split( bvLimit, " " )
total = UBOUND(aAccess)
tmpIP = ""
tmpDay = ""
tmpTime = ""
tmpTZ = ""
For x = 0 to total
    a = Split( aAccess(x), ":" )
    Select Case a(0)
        Case "IP": tmpIP = a(1)
        Case "DAY": tmpDay = a(1)
        Case "TIME": tmpTime = a(1)
        Case "TZ": tmpTZ = a(1)
    End Select
Next

-- Test IP Limits
If tmpIP <> "" Then
    data = reqSysServerName = Request.ServerVariables("REMOTE_ADDR")
    length = Len( tmpIP)
    data = Left( data, length)
    If data <> tmpIP Then LimitedAccess = -1
End If

-- Test Day Limits
If tmpDay <> "" Then
    data = CStr(DatePart("w", Date))
    If InStr( tmpDay, data ) = 0 Then  LimitedAccess = -2
End If

-- Test Time Limits
If tmpTime <> "" Then
    a = Split( tmpTime, "-" )
    If UBOUND(a) = 1 Then
        StartTime = a(0)
        EndTime = a(1)
        data = (Hour(Now) * 100) + Minute(Now)
        If tmpTZ <> "" Then
            CST = -6
            data = data + (100*(tmpTZ - CST)) 
       End If
End If



'TEST FOR IP LIMITS
str = bvLimit
'Search for IP limit
x = InStr(str, "IP:")
'If we have a IP limit
If x > 0 Then
   'set return to false
   LimitedAccess = 0
   str = Mid(str, x)
   x = 1
   'Get User's IP Address
   data = reqSysServerName = Request.ServerVariables("REMOTE_ADDR")
   Do While x > 0
      str = Mid(str, 4)
      z = InStr(str, ";")
      If z > 0 Then
         token = Left(str, z - 1)
      Else
         token = str
      End If
      If token = Left(data, Len(token)) Then
         LimitedAccess = 1
         Exit Do
      End If
      If z > 0 Then
         x = InStr(str, "IP:")
         If x > 0 Then str = Mid(str, x)
      Else
         x = 0
      End If
   Loop
End If

'TEST FOR DAY LIMITS
'If we passed all the previous limits
If LimitedAccess = 1 Then
   str = bvLimit
   'Search for DAY limit
   x = InStr(str, "DAY:")
   'If we have a DAY limit
   If x > 0 Then
      'set return to false
      LimitedAccess = 0
      str = Mid(str, x)
      x = 1
      'Get day of week
      data = CStr(DatePart("w", Date))
      Do While x > 0
         str = Mid(str, 5)
         z = InStr(str, ";")
         If z > 0 Then
            token = Left(str, z - 1)
         Else
            token = str
         End If
         If InStr(token, data) > 0 Then
            LimitedAccess = 1
            Exit Do
         End If
         If z > 0 Then
            x = InStr(str, "DAY:")
            If x > 0 Then str = Mid(str, x)
         Else
            x = 0
         End If
      Loop
   End If
End If

'TEST FOR TIME LIMITS
'If we passed all the previous limits
If LimitedAccess = 1 Then
   str = bvLimit
   'Search for TIME limit
   x = InStr(str, "TIME:")
   'If we have a DAY limit
   If x > 0 Then
      'set return to false
      LimitedAccess = 0
      str = Mid(str, x)
      x = 1
      'Get day of week
      data = (Hour(Now) * 100) + Minute(Now)
      Do While x > 0
         str = Mid(str, 6)
         z = InStr(str, ";")
         If z > 0 Then
            token = Left(str, z - 1)
         Else
            token = str
         End If
         z = InStr(token, "-")
         If z > 0 Then
            time1 = Left(token, z - 1)
            time2 = Mid(token, z + 1)
            timedata = data
            If timedata >= time1 And timedata <= time2 Then
               LimitedAccess = 1
               Exit Do
            End If
         End If
         If z > 0 Then
            x = InStr(str, "TIME:")
            If x > 0 Then str = Mid(str, x)
         Else
            x = 0
         End If
      Loop
   End If
End If

End Function
%>

