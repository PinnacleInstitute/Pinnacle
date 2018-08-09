<html>
<body>
<h1>Database Integration Demo (2)</h1>
<p style="width:500px;">The example demonstrates creating a chart using 
data from a database. The database query is performed in the containing
HTML page. The data are then passed to the chart generation pages as 
HTTP GET parameters.</p>

<ul>
	<li><a href="viewsource.asp?file=<%=Request("SCRIPT_NAME")%>">
		View containing HTML page source code
	</a></li>
	<li><a href="viewsource.asp?file=dbdemo2a.asp">
		View chart generation page source code for upper chart
	</a></li>
	<li><a href="viewsource.asp?file=dbdemo2b.asp">
		View chart generation page source code for lower chart
	</a></li>
</ul>

<form action="<%=Request("SCRIPT_NAME")%>">
	I want to obtain the revenue data for the year 
	<select name="year">
		<option value="1990">1990
		<option value="1991">1991
		<option value="1992">1992
		<option value="1993">1993
		<option value="1994">1994
		<option value="1995">1995
		<option value="1996">1996
		<option value="1997">1997
		<option value="1998">1998
		<option value="1999">1999
		<option value="2000">2000
		<option value="2001">2001
	</select>
	<input type="submit" value="OK">
</form>

<%
Set cd = CreateObject("ChartDirector.API")

'
'Perform the database query to get the required data. The selected year
'should be passed in as a query parameter called "year"
'
SelectedYear = Request("year")
if SelectedYear = "" Then SelectedYear = 2001

'
'Create an SQL statement to get the revenues of each month for the
'selected year. The ArrayIndex will be from 0 - 11, representing Jan - Dec.
'
SQL = "Select Month(TimeStamp) - 1 As ArrayIndex, " & _
      "Software, Hardware, Services " & _
      "From Revenue Where Year(TimeStamp)=" & SelectedYear

'
'Read in the revenue data into arrays
'
Set rs = CreateObject("ADODB.RecordSet")
Call rs.Open(SQL, "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & _
	Server.MapPath("sample.mdb"))
Set dbTable = cd.DBTable(rs, "ArrayIndex", 12)
rs.Close()

'Serialize the data into a string to be used as HTTP query parameters
httpParam = "year=" & SelectedYear & "&software=" & _
	Join(dbTable.getCol(1), ",") & "&hardware=" & _
	Join(dbTable.getCol(2), ",") & "&services=" & _
	Join(dbTable.getCol(3), ",")
%>

<SCRIPT>
	//make sure the select box displays the current selected year.
	document.forms[0].year.selectedIndex = <%=SelectedYear - 1990%>;
</SCRIPT>

<img src="dbdemo2a.asp?<%=httpParam%>"><br>
<img src="dbdemo2b.asp?<%=httpParam%>">

</body>
</html>
