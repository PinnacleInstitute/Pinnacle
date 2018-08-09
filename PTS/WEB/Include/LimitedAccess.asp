<% 

' Bob Wood 9/1/16
' Test for access limitations on:
' IP:1.2.3.4
' DAY:17
' TIME:900-1700
' TZ:-8
 
Public Function LimitedAccess(ByVal bvAccess)

' Initialize return as success
LimitedAccess = 1

aAccess = Split( bvAccess, " " )
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

' Test IP Limits
If tmpIP <> "" Then
    data = Request.ServerVariables("REMOTE_ADDR")
    aIP = Split( tmpIP, ";" )
    total = UBOUND(aIP)
    LimitedAccess = -1
    For x = 0 to total
        IP = aIP(x)
        length = Len(IP)
        tmp = Left( data, length)
        If tmp = IP Then
            LimitedAccess = 1
            Exit For
        End If
    Next
End If

' Test Day Limits
If tmpDay <> "" Then
    data = CStr(DatePart("w", Date))
    If InStr( tmpDay, data ) = 0 Then LimitedAccess = -2
End If

' Test Time Limits
If tmpTime <> "" Then
    a = Split( tmpTime, "-" )
    If UBOUND(a) = 1 Then
        StartTime = CInt( a(0) )
        EndTime = CInt( a(1) )
        data = (Hour(Now) * 100) + Minute(Now)
        'Adjust time for Timezone if specified
        If tmpTZ <> "" Then
            CST = -6
            data = data + (100*(tmpTZ - CST))
        End If
        If data < StartTime Or data > EndTime Then LimitedAccess = -3
    End If
End If

End Function
%>
