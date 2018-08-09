<%
Function GetMerchantACH( byVal bvPayment, byRef brCheckBank, byRef brCheckName, byRef brCheckRoute, byRef brCheckAccount, byRef brCheckAcctType, byRef brCheckNumber)
    aPay = Split(bvPayment, "|")
    Pays = UBOUND(aPay)
    If Pays &gt;= 0 Then brCheckBank = aPay(0) Else brCheckBank = ""
    If Pays &gt;= 1 Then brCheckName = aPay(1) Else brCheckName = ""
    If Pays &gt;= 2 Then brCheckRoute = aPay(2) Else brCheckRoute = ""
    If Pays &gt;= 3 Then brCheckAccount = aPay(3) Else brCheckAccount = ""
    If Pays &gt;= 4 Then brCheckAcctType = aPay(4) Else brCheckAcctType = 0
    If Pays &gt;= 5 Then brCheckNumber = aPay(5) Else brCheckNumber = ""
End Function

Function SetMerchantACH( byVal bvCheckBank, byVal bvCheckName, byVal bvCheckRoute, byVal bvCheckAccount, byVal bvCheckAcctType, byVal bvCheckNumber )
    SetMerchantACH = bvCheckBank +"|" + bvCheckName + "|" + bvCheckRoute + "|" + bvCheckAccount + "|" + CStr(bvCheckAcctType) + "|" + bvCheckNumber
End Function

%>

