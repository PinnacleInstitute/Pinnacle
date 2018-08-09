<%
Function StripHTML( ByVal bvHTML )
    bvHTML = join(filter(split(replace(bvHTML, "<", "><"),">"),"<", false))
    bvHTML = replace(bvHTML,"&nbsp;"," ")
    StripHTML = bvHTML
End Function

%>

