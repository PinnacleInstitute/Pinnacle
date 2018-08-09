<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
   <xsl:include href="HTMLHeading.xsl"/>
   <xsl:include href="Bookmark.xsl"/>
   <xsl:output omit-xml-declaration="yes"/>

   <xsl:template match="/">

      <xsl:element name="HTML">

      <xsl:variable name="usergroup" select="/DATA/SYSTEM/@usergroup"/>

      <xsl:element name="link">
         <xsl:attribute name="rel">stylesheet</xsl:attribute>
         <xsl:attribute name="type">text/css</xsl:attribute>
         <xsl:attribute name="href">include/StyleSheet.css</xsl:attribute>
      </xsl:element>

      <xsl:call-template name="HTMLHeading">
         <xsl:with-param name="pagename" select="'Sales Team'"/>
         <xsl:with-param name="includecalendar" select="true()"/>
         <xsl:with-param name="htmleditor"></xsl:with-param>
         <xsl:with-param name="translate">google</xsl:with-param>
      </xsl:call-template>

      <xsl:element name="SCRIPT">
         <xsl:attribute name="language">JavaScript</xsl:attribute>
         <xsl:attribute name="src">Include/jquery-1.5.1.min.js</xsl:attribute>
         <xsl:text> </xsl:text>
      </xsl:element>

      <xsl:element name="SCRIPT">
         <xsl:attribute name="language">JavaScript</xsl:attribute>
         <xsl:attribute name="src">Include/wz_jsgraphics.js</xsl:attribute>
         <xsl:text> </xsl:text>
      </xsl:element>

      <!--BEGIN BODY-->
      <xsl:element name="BODY">
         <xsl:attribute name="topmargin">0</xsl:attribute>
         <xsl:attribute name="leftmargin">10</xsl:attribute>
         <xsl:choose>
            <xsl:when test="(/DATA/ERROR)">
               <xsl:variable name="errnum" select="/DATA/ERROR/@number"/>
               <xsl:variable name="errmsg" select="/DATA/LANGUAGE/LABEL[@name=$errnum]"/>
               <xsl:choose>
                  <xsl:when test="string-length($errmsg)&gt;0">
                     <xsl:variable name="msgval" select="/DATA/ERROR/@msgval"/>
                     <xsl:variable name="msgfld" select="/DATA/ERROR/@msgfld"/>
                     <xsl:variable name="errfld" select="/DATA/LANGUAGE[*]/LABEL[@name=$msgfld]"/>
                     <xsl:variable name="errmsgfld">
                        <xsl:choose>
                           <xsl:when test="string-length($errfld)&gt;0"><xsl:value-of select="$errfld"/></xsl:when>
                           <xsl:otherwise><xsl:value-of select="$msgfld"/></xsl:otherwise>
                        </xsl:choose>
                        <xsl:if test="string-length($msgval)&gt;0"><xsl:value-of select="concat(' (', $msgval, ')')"/></xsl:if>
                     </xsl:variable>
                     <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[
               InitBinary();
            ]]></xsl:text>;doErrorMsg('<xsl:value-of select="concat($errmsg, $errmsgfld)"/>')</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[
               InitBinary();
            ]]></xsl:text>;doErrorMsg('<xsl:value-of select="/DATA/ERROR"/>')</xsl:attribute>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
               <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[
               InitBinary();
            ]]></xsl:text></xsl:attribute>
            </xsl:otherwise>
         </xsl:choose>

         <!--BEGIN PAGE-->
      <xsl:element name="DIV">
         <xsl:attribute name="id">wrapper750</xsl:attribute>
         <xsl:element name="A">
            <xsl:attribute name="name">top</xsl:attribute>
         </xsl:element>
         <xsl:element name="TABLE">
            <xsl:attribute name="border">0</xsl:attribute>
            <xsl:attribute name="cellpadding">0</xsl:attribute>
            <xsl:attribute name="cellspacing">0</xsl:attribute>
            <xsl:attribute name="width">750</xsl:attribute>
            <xsl:attribute name="align">left</xsl:attribute>

            <!--BEGIN FORM-->
            <xsl:element name="FORM">
               <xsl:attribute name="name">Member</xsl:attribute>
               <xsl:attribute name="method">post</xsl:attribute>

               <xsl:element name="INPUT">
                  <xsl:attribute name="type">hidden</xsl:attribute>
                  <xsl:attribute name="name">ActionCode</xsl:attribute>
                  <xsl:attribute name="id">ActionCode</xsl:attribute>
                  <xsl:attribute name="value"></xsl:attribute>
               </xsl:element>
               <!--BEGIN PAGE LAYOUT ROW-->
               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="width">10</xsl:attribute>
                  </xsl:element>
                  <xsl:element name="TD">
                     <xsl:attribute name="width">740</xsl:attribute>
                  </xsl:element>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ViewDashboard(id){ 
          var url, win, db;
          db = document.getElementById('Dashboard').value
          url = db + ".asp?memberid=" + id 
          win = window.open(url,"Performance","top=100,left=100,height=650,width=450,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no");
          win.focus();
         }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ViewMember(id){ 
          var url, win;
          url = "0421.asp?memberid=" + id
          win = window.open(url,"MemberInfo","top=100,left=100,height=200,width=330,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no");
          win.focus();
         }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ShowBinaryLegend(){ 
          var url, win;
          url = "m_Page.asp?Page=BinaryLegend"
          win = window.open(url,"Legend","top=100,left=100,height=300,width=200,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no");
          win.focus();
         }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ViewDownlines(id){ 
               var url, win, company;
               company = document.getElementById('CompanyID').value
               url = "5409.asp?memberid=" + id + "&companyid=" + company
               win = window.open(url,"Downlines","top=100,left=100,height=300,width=300,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no");
               win.focus();
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ViewTeams(id){ 
               var url, win;
               url = "5404.asp?memberid=" + id
                  win = window.open(url,"Teams","top=100,left=100,height=200,width=320,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no,scrollbars=1");
               win.focus();
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ViewSponsorTeams(id){ 
               var url, win, company;
               company = document.getElementById('CompanyID').value
               url = "0471.asp?memberid=" + id + "&companyid=" + company
               if( company == 9 ) { url = url + "&s2=1" }
               win = window.open(url,"Teams","top=100,left=100,height=200,width=300,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no");
               win.focus();
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function NewGenealogy(id,lvl){ 
               var level, line, levels, only, url, title, qv;
               if(id==0) { id = document.getElementById('MemberID').value };
               level = document.getElementById('Level').value;
               level = parseInt(level) + parseInt(lvl);
               line = document.getElementById('Line').value;
               levels = document.getElementById('Levels').value;
               only = document.getElementById('Only').value;
               title = document.getElementById('Title').value;
               qv = document.getElementById('QV').value;
               tm = document.getElementById('TopMemberID').value;
               url = "0470.asp?memberid=" + id + '&level=' + level + '&line=' + line + '&levels=' + levels + '&only=' + only + '&title=' + title + '&qv=' + qv + '&topmemberid=' + tm;
               window.location = url;
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function GoTop(){ 
               var member = document.getElementById('TopMemberID').value;
               NewGenealogy(member,-1);
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function AddMember(sponsor,pos){ 
               var company = document.getElementById('CompanyID').value;
               var member = document.getElementById('TopMemberID').value;
               var url = "Enroll.asp?c=" + company + "&m=" + member + "&s3=" + sponsor + "&pos=" + pos
               if( company == 9 ) { url = url + "&option=1" }
               if( company == 12 ) { url = "13201.asp?m=" + member }
               var win = window.open(url,"Enroll");
               win.focus();
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function DrawLines(){ 
               var adjx = -1;
               var adjy = 5;
               var jg = new jsGraphics('BinaryTree');
               var coords = document.getElementById('Lines').value
               jg.setColor('#cccccc');
               var parts = coords.split('|');
               for (i = 0; i < parts.length; i++) {
               if (parts[i] != '') {
               var line = parts[i].split(',');
               var level = parseInt(line[0]);
               var pos = parseInt(line[1]);
               var x2 = pos;
               var y2 = level;
               var x1 = 0;
               var y1 = 0;
               var width, topwidth;
               if( level == 0 ) {width = 46 * 8; topwidth = 46 * 16;}
               if( level == 1 ) {width = 46 * 4; topwidth = 46 * 8;}
               if( level == 2 ) {width = 46 * 2; topwidth = 46 * 4;}
               if( level == 3 ) {width = 46 * 1; topwidth = 46 * 2;}
               //alert(level + ':' + pos);
               x2 = (x2 * width) - (width/2);
               x1 = (Math.round(pos/2) * topwidth) - (topwidth/2);
               var y2 = ((y2 + 1) * 60) - 5;
               var y1 = (level * 60) + 30;
               //alert(x1 + ':' + y1 + ' - ' + x2 + ':' + y2);

               jg.drawLine(x1 + adjx, y1 + adjy, x2 + adjx, y2 + adjy);
               }
               }
               jg.paint();
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function InitBinary(){ 
               $(document).ready(function () {
                  var binary = document.getElementById('Binary').value
                  if( binary != 0) { DrawLines(); }
               });
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
                  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
                  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
                  var tmpID = '<xsl:value-of select="/DATA/SYSTEM/@ga_acctid"/>'
                  var tmpDomain = '<xsl:value-of select="/DATA/SYSTEM/@ga_domain"/>'
                  var tmpAction = '<xsl:value-of select="/DATA/SYSTEM/@actioncode"/>'
                  <xsl:text disable-output-escaping="yes">if( tmpID.length != 0 &amp;&amp; tmpDomain.length != 0 &amp;&amp; (tmpAction = '0') ) {</xsl:text>
                     ga('create', tmpID, tmpDomain);
                     ga('send', 'pageview');
                  }
               </xsl:element>
               <xsl:element name="TR">

                  <xsl:element name="TD">
                     <xsl:attribute name="width">10</xsl:attribute>
                  </xsl:element>

                  <xsl:element name="TD">
                     <xsl:attribute name="valign">top</xsl:attribute>
                     <xsl:attribute name="width">750</xsl:attribute>

                     <xsl:element name="TABLE">
                        <xsl:attribute name="border">0</xsl:attribute>
                        <xsl:attribute name="cellpadding">0</xsl:attribute>
                        <xsl:attribute name="cellspacing">0</xsl:attribute>
                        <xsl:attribute name="width">750</xsl:attribute>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">15</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">25</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">25</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">25</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">360</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">300</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">CompanyID</xsl:attribute>
                              <xsl:attribute name="id">CompanyID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@companyid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">MemberID</xsl:attribute>
                              <xsl:attribute name="id">MemberID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@memberid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Level</xsl:attribute>
                              <xsl:attribute name="id">Level</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@level"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Only</xsl:attribute>
                              <xsl:attribute name="id">Only</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@only"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">QV</xsl:attribute>
                              <xsl:attribute name="id">QV</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@qv"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Title</xsl:attribute>
                              <xsl:attribute name="id">Title</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@title"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">TopMemberID</xsl:attribute>
                              <xsl:attribute name="id">TopMemberID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@topmemberid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Lines</xsl:attribute>
                              <xsl:attribute name="id">Lines</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@lines"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Binary</xsl:attribute>
                              <xsl:attribute name="id">Binary</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@binary"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Dashboard</xsl:attribute>
                              <xsl:attribute name="id">Dashboard</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@dashboard"/></xsl:attribute>
                           </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">40</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeader</xsl:attribute>
                              <xsl:element name="IMG">
                                 <xsl:attribute name="src">Images/Icon_o.gif</xsl:attribute>
                                 <xsl:attribute name="border">0</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">4</xsl:attribute>
                              <xsl:attribute name="width">710</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">710</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">710</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">710</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">PageHeading</xsl:attribute>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="src">Images/Company/<xsl:value-of select="/DATA/PARAM/@companyid"/>/Title<xsl:value-of select="/DATA/TXN/PTSMEMBER/@title"/>.gif</xsl:attribute>
                                                <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namefirst"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namelast"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             (#<xsl:value-of select="/DATA/TXN/PTSMEMBER/@memberid"/>)
                                          <xsl:if test="(/DATA/PARAM/@binary = 0)">
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:if test="(/DATA/TXN/PTSMEMBER/@status != 1)">
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/Status<xsl:value-of select="/DATA/TXN/PTSMEMBER/@status"/>.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSMEMBER/@status = 1)">
                                                <xsl:if test="(/DATA/TXN/PTSMEMBER/@qualify &lt;= 1)">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/Status-1.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(/DATA/TXN/PTSMEMBER/@qualify &gt; 1)">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/Status1.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                </xsl:if>
                                             </xsl:if>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSMEMBER/@ismaster != 0)">
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/FastTrack.gif</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FastTrack']"/></xsl:attribute>
                                                   <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FastTrack']"/></xsl:attribute>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@dashboard != '')">
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">#_</xsl:attribute>
                                                   <xsl:attribute name="onclick">ViewDashboard(<xsl:value-of select="/DATA/TXN/PTSMEMBER/@memberid"/>)</xsl:attribute>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/performance.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                      <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewDashboard']"/></xsl:attribute>
                                                      <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewDashboard']"/></xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@viewcodes != 0) and (/DATA/TXN/PTSMEMBER/@status &lt;= 4)">
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:if test="(/DATA/TXN/PTSMEMBER/@title &gt;= /DATA/PARAM/@viewcodes)">
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="href">#_</xsl:attribute>
                                                      <xsl:attribute name="onclick">ViewDownlines(<xsl:value-of select="/DATA/TXN/PTSMEMBER/@memberid"/>)</xsl:attribute>
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/genealogy.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewTeams']"/></xsl:attribute>
                                                         <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewTeams']"/></xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSMEMBER/@title &lt; /DATA/PARAM/@viewcodes)">
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="href">#_</xsl:attribute>
                                                      <xsl:attribute name="onclick">ViewTeams(<xsl:value-of select="/DATA/TXN/PTSMEMBER/@memberid"/>)</xsl:attribute>
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/genealogy.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewTeams']"/></xsl:attribute>
                                                         <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewTeams']"/></xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                             </xsl:if>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23) or (/DATA/SYSTEM/@usergroup = 51) or (/DATA/SYSTEM/@usergroup = 52)">
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="onclick">w=window.open(this.href,"new","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                   <xsl:attribute name="href">0403.asp?MemberID=<xsl:value-of select="/DATA/TXN/PTSMEMBER/@memberid"/>&amp;ContentPage=3&amp;Popup=1</xsl:attribute>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/Edit.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@binary = 0)">
                                             <xsl:if test="(/DATA/TXN/PTSMEMBER/@bv != 0) or (/DATA/TXN/PTSMEMBER/@qv != 0) and (/DATA/TXN/PTSMEMBER/@status != 6)">
                                                   <xsl:if test="(/DATA/PARAM/@line = 1) or (/DATA/PARAM/@line = 3)">
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">blue</xsl:attribute>
                                                      (<xsl:value-of select="concat(/DATA/TXN/PTSMEMBER/@bv, '|', /DATA/TXN/PTSMEMBER/@qv)"/>)
                                                      </xsl:element>
                                                   </xsl:if>
                                             </xsl:if>
                                                <xsl:if test="(/DATA/TXN/PTSMEMBER/@qv2 != 0) and (/DATA/PARAM/@line = 2)">
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="color">blue</xsl:attribute>
                                                   (<xsl:value-of select="concat(/DATA/TXN/PTSMEMBER/@bv2, '|', /DATA/TXN/PTSMEMBER/@qv2)"/>)
                                                   </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(/DATA/TXN/PTSMEMBER/@qv3 != 0) and (/DATA/PARAM/@line = 4)">
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="color">blue</xsl:attribute>
                                                   (<xsl:value-of select="concat(/DATA/TXN/PTSMEMBER/@bv3, '|', /DATA/TXN/PTSMEMBER/@qv3)"/>)
                                                   </xsl:element>
                                                </xsl:if>
                                          </xsl:if>
                                             -
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:if test="(/DATA/PARAM/@line = 1)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EnrollerDownline']"/>
                                             </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@line = 2)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SponsorDownline']"/>
                                          </xsl:if>
                                             <xsl:if test="(/DATA/PARAM/@line = 3)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MentorDownline']"/>
                                             </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@line = 4)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Sponsor2Downline']"/>
                                          </xsl:if>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:if test="(/DATA/PARAM/@binary = 0)">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">710</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:attribute name="class">prompt PageHeader</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GenealogyText']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:if>

                                    <xsl:if test="(/DATA/PARAM/@binary != 0)">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">710</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:attribute name="class">PageHeader</xsl:attribute>
                                             <xsl:element name="b">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='QVLeft']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/PARAM/@bvleft" disable-output-escaping="yes"/>
                                                |
                                                <xsl:value-of select="/DATA/PARAM/@qvleft" disable-output-escaping="yes"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='QVRight']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/PARAM/@bvright" disable-output-escaping="yes"/>
                                                |
                                                <xsl:value-of select="/DATA/PARAM/@qvright" disable-output-escaping="yes"/>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:if>

                                    <xsl:if test="(/DATA/PARAM/@only != 0)">
                                       <xsl:element name="INPUT">
                                          <xsl:attribute name="type">hidden</xsl:attribute>
                                          <xsl:attribute name="name">Line</xsl:attribute>
                                          <xsl:attribute name="id">Line</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@line"/></xsl:attribute>
                                       </xsl:element>
                                    </xsl:if>

                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">6</xsl:attribute>
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">6</xsl:attribute>
                              <xsl:attribute name="width">750</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='DisplayGenealogy']"/>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                              <xsl:if test="(/DATA/PARAM/@only = 0)">
                                    <xsl:element name="SELECT">
                                       <xsl:attribute name="name">Line</xsl:attribute>
                                       <xsl:attribute name="id">Line</xsl:attribute>
                                       <xsl:variable name="tmp"><xsl:value-of select="/DATA/PARAM/@line"/></xsl:variable>
                                       <xsl:if test="(/DATA/PARAM/@downline1 = 1)">
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">1</xsl:attribute>
                                             <xsl:if test="$tmp='1'"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EnrollerDownline']"/>
                                          </xsl:element>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@downline2 = 1) and (/DATA/PARAM/@companyid != 21)">
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">2</xsl:attribute>
                                             <xsl:if test="$tmp='2'"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SponsorDownline']"/>
                                          </xsl:element>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@downline2 = 1) and (/DATA/PARAM/@companyid = 21)">
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">2</xsl:attribute>
                                             <xsl:if test="$tmp='2'"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TeamDownline']"/>
                                          </xsl:element>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@downline4 = 1)">
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">4</xsl:attribute>
                                             <xsl:if test="$tmp='4'"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Sponsor2Downline']"/>
                                          </xsl:element>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@downline5 = 1)">
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">5</xsl:attribute>
                                             <xsl:if test="$tmp='5'"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Sponsor3Downline']"/>
                                          </xsl:element>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@downlineb = 1)">
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">5</xsl:attribute>
                                             <xsl:if test="$tmp='5'"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BinaryDownline']"/>
                                          </xsl:element>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@downline3 = 1)">
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">3</xsl:attribute>
                                             <xsl:if test="$tmp='3'"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MentorDownline']"/>
                                          </xsl:element>
                                       </xsl:if>
                                    </xsl:element>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='for']"/>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                              </xsl:if>
                                 <xsl:element name="SELECT">
                                    <xsl:attribute name="name">Levels</xsl:attribute>
                                    <xsl:attribute name="id">Levels</xsl:attribute>
                                    <xsl:variable name="tmp"><xsl:value-of select="/DATA/PARAM/@levels"/></xsl:variable>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">1</xsl:attribute>
                                       <xsl:if test="$tmp='1'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='1Level']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">2</xsl:attribute>
                                       <xsl:if test="$tmp='2'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='2Levels']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">3</xsl:attribute>
                                       <xsl:if test="$tmp='3'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='3Levels']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">4</xsl:attribute>
                                       <xsl:if test="$tmp='4'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='4Levels']"/>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="class">smbutton</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='View']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[NewGenealogy(0,0);]]></xsl:text></xsl:attribute>
                                 </xsl:element>
                                 <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23) or (/DATA/SYSTEM/@usergroup = 51) or (/DATA/SYSTEM/@usergroup = 52) or (/DATA/PARAM/@topmemberid != /DATA/PARAM/@memberid)">
                                 <xsl:if test="(/DATA/PARAM/@parentid &gt; 0)">
                                    <xsl:if test="(/DATA/PARAM/@binary = 0)">
                                          <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                          <xsl:element name="A">
                                             <xsl:attribute name="href">#_</xsl:attribute>
                                             <xsl:attribute name="onclick">NewGenealogy(<xsl:value-of select="/DATA/PARAM/@parentid"/>, -1)</xsl:attribute>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="src">Images/mentoringteam.gif</xsl:attribute>
                                                <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                                <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GoParent']"/></xsl:attribute>
                                                <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GoParent']"/></xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                    </xsl:if>
                                    <xsl:if test="(/DATA/PARAM/@binary != 0)">
                                          <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">button</xsl:attribute>
                                             <xsl:attribute name="class">smbutton</xsl:attribute>
                                             <xsl:attribute name="value">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='UpOne']"/>
                                             </xsl:attribute>
                                             <xsl:attribute name="onclick">NewGenealogy(<xsl:value-of select="/DATA/PARAM/@parentid"/>, -1)</xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">button</xsl:attribute>
                                             <xsl:attribute name="class">smbutton</xsl:attribute>
                                             <xsl:attribute name="value">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GoTop']"/>
                                             </xsl:attribute>
                                             <xsl:attribute name="onclick">GoTop()</xsl:attribute>
                                          </xsl:element>
                                    </xsl:if>
                                 </xsl:if>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/PARAM/@binary != 0)">
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:element name="INPUT">
                                          <xsl:attribute name="type">button</xsl:attribute>
                                          <xsl:attribute name="class">smbutton</xsl:attribute>
                                          <xsl:attribute name="value">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BottomLeft']"/>
                                          </xsl:attribute>
                                          <xsl:attribute name="onclick">NewGenealogy(-1, -1)</xsl:attribute>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:element name="INPUT">
                                          <xsl:attribute name="type">button</xsl:attribute>
                                          <xsl:attribute name="class">smbutton</xsl:attribute>
                                          <xsl:attribute name="value">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BottomRight']"/>
                                          </xsl:attribute>
                                          <xsl:attribute name="onclick">NewGenealogy(-2, -1)</xsl:attribute>
                                       </xsl:element>
                                 </xsl:if>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                              <xsl:if test="(/DATA/PARAM/@binary = 0)">
                                    <xsl:element name="SELECT">
                                       <xsl:attribute name="name">SearchType</xsl:attribute>
                                       <xsl:attribute name="id">SearchType</xsl:attribute>
                                       <xsl:variable name="tmp"><xsl:value-of select="/DATA/PARAM/@searchtype"/></xsl:variable>
                                       <xsl:element name="OPTION">
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="$tmp='1'"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SearchMemberName']"/>
                                       </xsl:element>
                                       <xsl:element name="OPTION">
                                          <xsl:attribute name="value">2</xsl:attribute>
                                          <xsl:if test="$tmp='2'"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SearchMemberID']"/>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="INPUT">
                                    <xsl:attribute name="type">text</xsl:attribute>
                                    <xsl:attribute name="name">SearchText</xsl:attribute>
                                    <xsl:attribute name="id">SearchText</xsl:attribute>
                                    <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@searchtext"/></xsl:attribute>
                                    <xsl:attribute name="size">10</xsl:attribute>
                                    </xsl:element>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:element name="INPUT">
                                       <xsl:attribute name="type">button</xsl:attribute>
                                       <xsl:attribute name="class">smbutton</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Search']"/>
                                       </xsl:attribute>
                                       <xsl:attribute name="onclick">doSubmit(5,"")</xsl:attribute>
                                    </xsl:element>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:element name="A">
                                       <xsl:attribute name="onclick">w=window.open(this.href,"Help","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                       <xsl:attribute name="href">Page.asp?Page=SalesTeam</xsl:attribute>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/LearnMore.gif</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                              </xsl:if>
                              <xsl:if test="(/DATA/PARAM/@binary = 0)">
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:element name="INPUT">
                                       <xsl:attribute name="type">button</xsl:attribute>
                                       <xsl:attribute name="class">smbutton</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Close']"/>
                                       </xsl:attribute>
                                       <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[window.close()]]></xsl:text></xsl:attribute>
                                    </xsl:element>
                              </xsl:if>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">6</xsl:attribute>
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/PARAM/@binary = 0) and (/DATA/PARAM/@count = 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">6</xsl:attribute>
                                 <xsl:attribute name="height">24</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">6</xsl:attribute>
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoGenealogy']"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">6</xsl:attribute>
                                 <xsl:attribute name="height">24</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="(/DATA/PARAM/@binary != 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">6</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">6</xsl:attribute>
                                 <xsl:attribute name="width">736</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">736</xsl:attribute>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">46</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">46</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">46</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">46</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">46</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">46</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">46</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">46</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">46</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">46</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">46</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">46</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">46</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">46</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">46</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">46</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="DIV">
                                          <xsl:attribute name="id">BinaryTree</xsl:attribute>
                                          <xsl:attribute name="style">position:relative </xsl:attribute>
                                       <xsl:element name="TR">
                                          <xsl:attribute name="height">60</xsl:attribute>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">16</xsl:attribute>
                                             <xsl:attribute name="width">736</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">top</xsl:attribute>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/Statusb<xsl:value-of select="/DATA/TXN/PTSMEMBER/@status"/>.gif</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                </xsl:element>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/Company/<xsl:value-of select="/DATA/PARAM/@companyid"/>/Titleb<xsl:value-of select="/DATA/TXN/PTSMEMBER/@title"/>.gif</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="alt"><xsl:value-of select="/DATA/PARAM/@memberdesc"/></xsl:attribute>
                                                   <xsl:attribute name="title"><xsl:value-of select="/DATA/PARAM/@memberdesc"/></xsl:attribute>
                                                </xsl:element>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/Qualify<xsl:value-of select="/DATA/TXN/PTSMEMBER/@qualify"/>.gif</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                </xsl:element>
                                                <xsl:element name="BR"/>
                                                <xsl:element name="font">
                                                   <xsl:attribute name="size">1</xsl:attribute>
                                                <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namefirst"/>
                                                </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:attribute name="height">60</xsl:attribute>
                                          <xsl:for-each select="/DATA/TXN/NODES[@level=0]/NODE">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="colspan">8</xsl:attribute>
                                                   <xsl:attribute name="width">368</xsl:attribute>
                                                   <xsl:attribute name="align">center</xsl:attribute>
                                                   <xsl:attribute name="valign">top</xsl:attribute>
                                                   <xsl:if test="(@title)">
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/Statusb<xsl:value-of select="@status"/>.gif</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                         </xsl:element>
                                                         <xsl:element name="A">
                                                            <xsl:attribute name="href">#_</xsl:attribute>
                                                            <xsl:attribute name="onclick">NewGenealogy(<xsl:value-of select="@memberid"/>,1)</xsl:attribute>
                                                            <xsl:element name="IMG">
                                                               <xsl:attribute name="src">Images/Company/<xsl:value-of select="/DATA/PARAM/@companyid"/>/Titleb<xsl:value-of select="@title"/>.gif</xsl:attribute>
                                                               <xsl:attribute name="border">0</xsl:attribute>
                                                               <xsl:attribute name="alt"><xsl:value-of select="@desc"/></xsl:attribute>
                                                               <xsl:attribute name="title"><xsl:value-of select="@desc"/></xsl:attribute>
                                                            </xsl:element>
                                                         </xsl:element>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/Qualify<xsl:value-of select="@qualify"/>.gif</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                         </xsl:element>
                                                         <xsl:element name="BR"/>
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="size">1</xsl:attribute>
                                                         <xsl:value-of select="@first"/>
                                                         </xsl:element>
                                                   </xsl:if>
                                                   <xsl:if test="(@sponsorid)">
                                                         <xsl:element name="A">
                                                            <xsl:attribute name="href">#_</xsl:attribute>
                                                            <xsl:attribute name="onclick">AddMember(<xsl:value-of select="@sponsorid"/>,<xsl:value-of select="@pos"/>)</xsl:attribute>
                                                            <xsl:element name="IMG">
                                                               <xsl:attribute name="src">Images/OpenNode.png</xsl:attribute>
                                                               <xsl:attribute name="border">0</xsl:attribute>
                                                               <xsl:attribute name="alt">Click to add new member</xsl:attribute>
                                                               <xsl:attribute name="title">Click to add new member</xsl:attribute>
                                                            </xsl:element>
                                                         </xsl:element>
                                                   </xsl:if>
                                                </xsl:element>
                                          </xsl:for-each>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:attribute name="height">60</xsl:attribute>
                                          <xsl:for-each select="/DATA/TXN/NODES[@level=1]/NODE">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="colspan">4</xsl:attribute>
                                                   <xsl:attribute name="width">184</xsl:attribute>
                                                   <xsl:attribute name="align">center</xsl:attribute>
                                                   <xsl:attribute name="valign">top</xsl:attribute>
                                                   <xsl:if test="(@title)">
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/Statusb<xsl:value-of select="@status"/>.gif</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                         </xsl:element>
                                                         <xsl:element name="A">
                                                            <xsl:attribute name="href">#_</xsl:attribute>
                                                            <xsl:attribute name="onclick">NewGenealogy(<xsl:value-of select="@memberid"/>,1)</xsl:attribute>
                                                            <xsl:element name="IMG">
                                                               <xsl:attribute name="src">Images/Company/<xsl:value-of select="/DATA/PARAM/@companyid"/>/Titleb<xsl:value-of select="@title"/>.gif</xsl:attribute>
                                                               <xsl:attribute name="border">0</xsl:attribute>
                                                               <xsl:attribute name="alt"><xsl:value-of select="@desc"/></xsl:attribute>
                                                               <xsl:attribute name="title"><xsl:value-of select="@desc"/></xsl:attribute>
                                                            </xsl:element>
                                                         </xsl:element>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/Qualify<xsl:value-of select="@qualify"/>.gif</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                         </xsl:element>
                                                         <xsl:element name="BR"/>
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="size">1</xsl:attribute>
                                                         <xsl:value-of select="@first"/>
                                                         </xsl:element>
                                                   </xsl:if>
                                                   <xsl:if test="(@sponsorid)">
                                                         <xsl:element name="A">
                                                            <xsl:attribute name="href">#_</xsl:attribute>
                                                            <xsl:attribute name="onclick">AddMember(<xsl:value-of select="@sponsorid"/>,<xsl:value-of select="@pos"/>)</xsl:attribute>
                                                            <xsl:element name="IMG">
                                                               <xsl:attribute name="src">Images/OpenNode.png</xsl:attribute>
                                                               <xsl:attribute name="border">0</xsl:attribute>
                                                               <xsl:attribute name="alt">Click to add new member</xsl:attribute>
                                                               <xsl:attribute name="title">Click to add new member</xsl:attribute>
                                                            </xsl:element>
                                                         </xsl:element>
                                                   </xsl:if>
                                                </xsl:element>
                                          </xsl:for-each>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:attribute name="height">60</xsl:attribute>
                                          <xsl:for-each select="/DATA/TXN/NODES[@level=2]/NODE">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="colspan">2</xsl:attribute>
                                                   <xsl:attribute name="width">92</xsl:attribute>
                                                   <xsl:attribute name="align">center</xsl:attribute>
                                                   <xsl:attribute name="valign">top</xsl:attribute>
                                                   <xsl:if test="(@title)">
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/Statusb<xsl:value-of select="@status"/>.gif</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                         </xsl:element>
                                                         <xsl:element name="A">
                                                            <xsl:attribute name="href">#_</xsl:attribute>
                                                            <xsl:attribute name="onclick">NewGenealogy(<xsl:value-of select="@memberid"/>,1)</xsl:attribute>
                                                            <xsl:element name="IMG">
                                                               <xsl:attribute name="src">Images/Company/<xsl:value-of select="/DATA/PARAM/@companyid"/>/Titleb<xsl:value-of select="@title"/>.gif</xsl:attribute>
                                                               <xsl:attribute name="border">0</xsl:attribute>
                                                               <xsl:attribute name="alt"><xsl:value-of select="@desc"/></xsl:attribute>
                                                               <xsl:attribute name="title"><xsl:value-of select="@desc"/></xsl:attribute>
                                                            </xsl:element>
                                                         </xsl:element>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/Qualify<xsl:value-of select="@qualify"/>.gif</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                         </xsl:element>
                                                         <xsl:element name="BR"/>
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="size">1</xsl:attribute>
                                                         <xsl:value-of select="@first"/>
                                                         </xsl:element>
                                                   </xsl:if>
                                                   <xsl:if test="(@sponsorid)">
                                                         <xsl:element name="A">
                                                            <xsl:attribute name="href">#_</xsl:attribute>
                                                            <xsl:attribute name="onclick">AddMember(<xsl:value-of select="@sponsorid"/>,<xsl:value-of select="@pos"/>)</xsl:attribute>
                                                            <xsl:element name="IMG">
                                                               <xsl:attribute name="src">Images/OpenNode.png</xsl:attribute>
                                                               <xsl:attribute name="border">0</xsl:attribute>
                                                               <xsl:attribute name="alt">Click to add new member</xsl:attribute>
                                                               <xsl:attribute name="title">Click to add new member</xsl:attribute>
                                                            </xsl:element>
                                                         </xsl:element>
                                                   </xsl:if>
                                                </xsl:element>
                                          </xsl:for-each>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:attribute name="height">60</xsl:attribute>
                                          <xsl:for-each select="/DATA/TXN/NODES[@level=3]/NODE">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">46</xsl:attribute>
                                                   <xsl:attribute name="align">center</xsl:attribute>
                                                   <xsl:attribute name="valign">top</xsl:attribute>
                                                   <xsl:if test="(@title)">
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/Statusb<xsl:value-of select="@status"/>.gif</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                         </xsl:element>
                                                         <xsl:element name="A">
                                                            <xsl:attribute name="href">#_</xsl:attribute>
                                                            <xsl:attribute name="onclick">NewGenealogy(<xsl:value-of select="@memberid"/>,1)</xsl:attribute>
                                                            <xsl:element name="IMG">
                                                               <xsl:attribute name="src">Images/Company/<xsl:value-of select="/DATA/PARAM/@companyid"/>/Titleb<xsl:value-of select="@title"/>.gif</xsl:attribute>
                                                               <xsl:attribute name="border">0</xsl:attribute>
                                                               <xsl:attribute name="alt"><xsl:value-of select="@desc"/></xsl:attribute>
                                                               <xsl:attribute name="title"><xsl:value-of select="@desc"/></xsl:attribute>
                                                            </xsl:element>
                                                         </xsl:element>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/Qualify<xsl:value-of select="@qualify"/>.gif</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                         </xsl:element>
                                                         <xsl:element name="BR"/>
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="size">1</xsl:attribute>
                                                         <xsl:value-of select="@first"/>
                                                         </xsl:element>
                                                   </xsl:if>
                                                   <xsl:if test="(@sponsorid)">
                                                         <xsl:element name="A">
                                                            <xsl:attribute name="href">#_</xsl:attribute>
                                                            <xsl:attribute name="onclick">AddMember(<xsl:value-of select="@sponsorid"/>,<xsl:value-of select="@pos"/>)</xsl:attribute>
                                                            <xsl:element name="IMG">
                                                               <xsl:attribute name="src">Images/OpenNode.png</xsl:attribute>
                                                               <xsl:attribute name="border">0</xsl:attribute>
                                                               <xsl:attribute name="alt">Click to add new member</xsl:attribute>
                                                               <xsl:attribute name="title">Click to add new member</xsl:attribute>
                                                            </xsl:element>
                                                         </xsl:element>
                                                   </xsl:if>
                                                </xsl:element>
                                          </xsl:for-each>
                                       </xsl:element>

                                       </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/PARAM/@binary = 0)">
                           <xsl:for-each select="/DATA/TXN/PTSMEMBERS/PTSMEMBER[(@sponsorid = /DATA/PARAM/@memberid)]">
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">750</xsl:attribute>
                                       <xsl:attribute name="colspan">6</xsl:attribute>
                                       <xsl:attribute name="height">1</xsl:attribute>
                                       <xsl:attribute name="bgcolor">mediumblue</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>

                                 <xsl:element name="TR">
                                    <xsl:attribute name="class">bluebar</xsl:attribute>
                                    <xsl:attribute name="height">40</xsl:attribute>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">15</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:value-of select="/DATA/PARAM/@level + 1"/>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">5</xsl:attribute>
                                       <xsl:attribute name="width">735</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/Company/<xsl:value-of select="/DATA/PARAM/@companyid"/>/Title<xsl:value-of select="@title"/>.gif</xsl:attribute>
                                             <xsl:attribute name="align">absmiddle</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                          <xsl:element name="A">
                                             <xsl:attribute name="href">#_</xsl:attribute>
                                             <xsl:attribute name="onclick">NewGenealogy(<xsl:value-of select="@memberid"/>,1)</xsl:attribute>
                                          <xsl:element name="b">
                                          <xsl:value-of select="@membername"/>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                          </xsl:element>
                                          (#<xsl:value-of select="@memberid"/>)
                                          <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:if test="(@status != 1)">
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="src">Images/Status<xsl:value-of select="@status"/>.gif</xsl:attribute>
                                                <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                             </xsl:element>
                                       </xsl:if>
                                       <xsl:if test="(@status = 1)">
                                          <xsl:if test="(@email &lt;= 1)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/Status-1.gif</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(@email &gt; 1)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/Status1.gif</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                </xsl:element>
                                          </xsl:if>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@dashboard != '')">
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:element name="A">
                                                <xsl:attribute name="href">#_</xsl:attribute>
                                                <xsl:attribute name="onclick">ViewDashboard(<xsl:value-of select="@memberid"/>)</xsl:attribute>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/performance.gif</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewDashboard']"/></xsl:attribute>
                                                   <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewDashboard']"/></xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@viewcodes != 0)">
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:element name="A">
                                                <xsl:attribute name="href">#_</xsl:attribute>
                                                <xsl:attribute name="onclick">ViewTeams(<xsl:value-of select="@memberid"/>)</xsl:attribute>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/genealogy.gif</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewTeams']"/></xsl:attribute>
                                                   <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewTeams']"/></xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23) or (/DATA/SYSTEM/@usergroup = 51) or (/DATA/SYSTEM/@usergroup = 52)">
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:element name="A">
                                                <xsl:attribute name="onclick">w=window.open(this.href,"new","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                <xsl:attribute name="href">0403.asp?MemberID=<xsl:value-of select="@memberid"/>&amp;ContentPage=3&amp;Popup=1</xsl:attribute>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/Edit.gif</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>
                                       </xsl:if>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:value-of select="@identification"/>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="font">
                                             <xsl:attribute name="color">purple</xsl:attribute>
                                             <xsl:value-of select="@enrolldate"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="@visitdate"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="font">
                                             <xsl:attribute name="color">blue</xsl:attribute>
                                          (<xsl:value-of select="concat(@bv,'|',@qv)"/>)
                                          </xsl:element>
                                       <xsl:if test="(/DATA/PARAM/@viewinfo != 0)">
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:element name="A">
                                                <xsl:attribute name="href">#_</xsl:attribute>
                                                <xsl:attribute name="onclick">ViewMember(<xsl:value-of select="@memberid"/>)</xsl:attribute>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/Preview.gif</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewInfo']"/></xsl:attribute>
                                                   <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewInfo']"/></xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>
                                       </xsl:if>
                                    </xsl:element>
                                 </xsl:element>

                                 <xsl:for-each select="/DATA/TXN/PTSMEMBERS/PTSMEMBER[(@sponsorid = current()/@memberid)]">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="width">40</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">710</xsl:attribute>
                                             <xsl:attribute name="colspan">4</xsl:attribute>
                                             <xsl:attribute name="height">1</xsl:attribute>
                                             <xsl:attribute name="bgcolor">goldenrod</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:attribute name="height">40</xsl:attribute>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">15</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/PARAM/@level + 2"/>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">25</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">4</xsl:attribute>
                                             <xsl:attribute name="width">710</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:attribute name="class">yellowbar</xsl:attribute>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/Company/<xsl:value-of select="/DATA/PARAM/@companyid"/>/Title<xsl:value-of select="@title"/>.gif</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">#_</xsl:attribute>
                                                   <xsl:attribute name="onclick">NewGenealogy(<xsl:value-of select="@memberid"/>,1)</xsl:attribute>
                                                <xsl:element name="b">
                                                <xsl:value-of select="@membername"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                </xsl:element>
                                                (#<xsl:value-of select="@memberid"/>)
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:if test="(@status != 1)">
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/Status<xsl:value-of select="@status"/>.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(@status = 1)">
                                                <xsl:if test="(@email &lt;= 1)">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/Status-1.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(@email &gt; 1)">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/Status1.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                </xsl:if>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/PARAM/@dashboard != '')">
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="href">#_</xsl:attribute>
                                                      <xsl:attribute name="onclick">ViewDashboard(<xsl:value-of select="@memberid"/>)</xsl:attribute>
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/performance.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewDashboard']"/></xsl:attribute>
                                                         <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewDashboard']"/></xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/PARAM/@viewcodes != 0)">
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="href">#_</xsl:attribute>
                                                      <xsl:attribute name="onclick">ViewTeams(<xsl:value-of select="@memberid"/>)</xsl:attribute>
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/genealogy.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewTeams']"/></xsl:attribute>
                                                         <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewTeams']"/></xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23) or (/DATA/SYSTEM/@usergroup = 51) or (/DATA/SYSTEM/@usergroup = 52)">
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="onclick">w=window.open(this.href,"new","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                      <xsl:attribute name="href">0403.asp?MemberID=<xsl:value-of select="@memberid"/>&amp;ContentPage=3&amp;Popup=1</xsl:attribute>
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/Edit.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                             </xsl:if>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:value-of select="@identification"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="font">
                                                   <xsl:attribute name="color">purple</xsl:attribute>
                                                   <xsl:value-of select="@enrolldate"/>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:value-of select="@visitdate"/>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                </xsl:element>
                                                <xsl:element name="font">
                                                   <xsl:attribute name="color">blue</xsl:attribute>
                                                (<xsl:value-of select="concat(@bv,'|',@qv)"/>)
                                                </xsl:element>
                                             <xsl:if test="(/DATA/PARAM/@viewinfo != 0)">
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="href">#_</xsl:attribute>
                                                      <xsl:attribute name="onclick">ViewMember(<xsl:value-of select="@memberid"/>)</xsl:attribute>
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/Preview.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewInfo']"/></xsl:attribute>
                                                         <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewInfo']"/></xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                             </xsl:if>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:for-each select="/DATA/TXN/PTSMEMBERS/PTSMEMBER[(@sponsorid = current()/@memberid)]">
                                             <xsl:element name="TR">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="colspan">3</xsl:attribute>
                                                   <xsl:attribute name="width">65</xsl:attribute>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">685</xsl:attribute>
                                                   <xsl:attribute name="colspan">3</xsl:attribute>
                                                   <xsl:attribute name="height">1</xsl:attribute>
                                                   <xsl:attribute name="bgcolor">firebrick</xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>

                                             <xsl:element name="TR">
                                                <xsl:attribute name="height">40</xsl:attribute>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">15</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:value-of select="/DATA/PARAM/@level + 3"/>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="colspan">2</xsl:attribute>
                                                   <xsl:attribute name="width">50</xsl:attribute>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="colspan">3</xsl:attribute>
                                                   <xsl:attribute name="width">685</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:attribute name="class">redbar</xsl:attribute>
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/Company/<xsl:value-of select="/DATA/PARAM/@companyid"/>/Title<xsl:value-of select="@title"/>.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="href">#_</xsl:attribute>
                                                         <xsl:attribute name="onclick">NewGenealogy(<xsl:value-of select="@memberid"/>,1)</xsl:attribute>
                                                      <xsl:element name="b">
                                                      <xsl:value-of select="@membername"/>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      </xsl:element>
                                                      (#<xsl:value-of select="@memberid"/>)
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:if test="(@status != 1)">
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/Status<xsl:value-of select="@status"/>.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                         </xsl:element>
                                                   </xsl:if>
                                                   <xsl:if test="(@status = 1)">
                                                      <xsl:if test="(@email &lt;= 1)">
                                                            <xsl:element name="IMG">
                                                               <xsl:attribute name="src">Images/Status-1.gif</xsl:attribute>
                                                               <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                               <xsl:attribute name="border">0</xsl:attribute>
                                                            </xsl:element>
                                                      </xsl:if>
                                                      <xsl:if test="(@email &gt; 1)">
                                                            <xsl:element name="IMG">
                                                               <xsl:attribute name="src">Images/Status1.gif</xsl:attribute>
                                                               <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                               <xsl:attribute name="border">0</xsl:attribute>
                                                            </xsl:element>
                                                      </xsl:if>
                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/PARAM/@dashboard != '')">
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                         <xsl:element name="A">
                                                            <xsl:attribute name="href">#_</xsl:attribute>
                                                            <xsl:attribute name="onclick">ViewDashboard(<xsl:value-of select="@memberid"/>)</xsl:attribute>
                                                            <xsl:element name="IMG">
                                                               <xsl:attribute name="src">Images/performance.gif</xsl:attribute>
                                                               <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                               <xsl:attribute name="border">0</xsl:attribute>
                                                               <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewDashboard']"/></xsl:attribute>
                                                               <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewDashboard']"/></xsl:attribute>
                                                            </xsl:element>
                                                         </xsl:element>
                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/PARAM/@viewcodes != 0)">
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                         <xsl:element name="A">
                                                            <xsl:attribute name="href">#_</xsl:attribute>
                                                            <xsl:attribute name="onclick">ViewTeams(<xsl:value-of select="@memberid"/>)</xsl:attribute>
                                                            <xsl:element name="IMG">
                                                               <xsl:attribute name="src">Images/genealogy.gif</xsl:attribute>
                                                               <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                               <xsl:attribute name="border">0</xsl:attribute>
                                                               <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewTeams']"/></xsl:attribute>
                                                               <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewTeams']"/></xsl:attribute>
                                                            </xsl:element>
                                                         </xsl:element>
                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23) or (/DATA/SYSTEM/@usergroup = 51) or (/DATA/SYSTEM/@usergroup = 52)">
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                         <xsl:element name="A">
                                                            <xsl:attribute name="onclick">w=window.open(this.href,"new","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                            <xsl:attribute name="href">0403.asp?MemberID=<xsl:value-of select="@memberid"/>&amp;ContentPage=3&amp;Popup=1</xsl:attribute>
                                                            <xsl:element name="IMG">
                                                               <xsl:attribute name="src">Images/Edit.gif</xsl:attribute>
                                                               <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                               <xsl:attribute name="border">0</xsl:attribute>
                                                            </xsl:element>
                                                         </xsl:element>
                                                   </xsl:if>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:value-of select="@identification"/>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">purple</xsl:attribute>
                                                         <xsl:value-of select="@enrolldate"/>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                         <xsl:value-of select="@visitdate"/>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      </xsl:element>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">blue</xsl:attribute>
                                                      (<xsl:value-of select="concat(@bv,'|',@qv)"/>)
                                                      </xsl:element>
                                                   <xsl:if test="(/DATA/PARAM/@viewinfo != 0)">
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                         <xsl:element name="A">
                                                            <xsl:attribute name="href">#_</xsl:attribute>
                                                            <xsl:attribute name="onclick">ViewMember(<xsl:value-of select="@memberid"/>)</xsl:attribute>
                                                            <xsl:element name="IMG">
                                                               <xsl:attribute name="src">Images/Preview.gif</xsl:attribute>
                                                               <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                               <xsl:attribute name="border">0</xsl:attribute>
                                                               <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewInfo']"/></xsl:attribute>
                                                               <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewInfo']"/></xsl:attribute>
                                                            </xsl:element>
                                                         </xsl:element>
                                                   </xsl:if>
                                                </xsl:element>
                                             </xsl:element>

                                             <xsl:for-each select="/DATA/TXN/PTSMEMBERS/PTSMEMBER[(@sponsorid = current()/@memberid)]">
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="colspan">4</xsl:attribute>
                                                         <xsl:attribute name="width">90</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">660</xsl:attribute>
                                                         <xsl:attribute name="colspan">2</xsl:attribute>
                                                         <xsl:attribute name="height">1</xsl:attribute>
                                                         <xsl:attribute name="bgcolor">green</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>

                                                   <xsl:element name="TR">
                                                      <xsl:attribute name="height">40</xsl:attribute>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">15</xsl:attribute>
                                                         <xsl:attribute name="align">left</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:value-of select="/DATA/PARAM/@level + 4"/>
                                                      </xsl:element>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="colspan">3</xsl:attribute>
                                                         <xsl:attribute name="width">75</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="colspan">2</xsl:attribute>
                                                         <xsl:attribute name="width">660</xsl:attribute>
                                                         <xsl:attribute name="align">left</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:attribute name="class">greenbar</xsl:attribute>
                                                            <xsl:element name="IMG">
                                                               <xsl:attribute name="src">Images/Company/<xsl:value-of select="/DATA/PARAM/@companyid"/>/Title<xsl:value-of select="@title"/>.gif</xsl:attribute>
                                                               <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                               <xsl:attribute name="border">0</xsl:attribute>
                                                            </xsl:element>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            <xsl:element name="A">
                                                               <xsl:attribute name="href">#_</xsl:attribute>
                                                               <xsl:attribute name="onclick">NewGenealogy(<xsl:value-of select="@memberid"/>,1)</xsl:attribute>
                                                            <xsl:element name="b">
                                                            <xsl:value-of select="@membername"/>
                                                            </xsl:element>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            </xsl:element>
                                                            (#<xsl:value-of select="@memberid"/>)
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                         <xsl:if test="(@status != 1)">
                                                               <xsl:element name="IMG">
                                                                  <xsl:attribute name="src">Images/Status<xsl:value-of select="@status"/>.gif</xsl:attribute>
                                                                  <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                  <xsl:attribute name="border">0</xsl:attribute>
                                                               </xsl:element>
                                                         </xsl:if>
                                                         <xsl:if test="(@status = 1)">
                                                            <xsl:if test="(@email &lt;= 1)">
                                                                  <xsl:element name="IMG">
                                                                     <xsl:attribute name="src">Images/Status-1.gif</xsl:attribute>
                                                                     <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                     <xsl:attribute name="border">0</xsl:attribute>
                                                                  </xsl:element>
                                                            </xsl:if>
                                                            <xsl:if test="(@email &gt; 1)">
                                                                  <xsl:element name="IMG">
                                                                     <xsl:attribute name="src">Images/Status1.gif</xsl:attribute>
                                                                     <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                     <xsl:attribute name="border">0</xsl:attribute>
                                                                  </xsl:element>
                                                            </xsl:if>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/PARAM/@dashboard != '')">
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                               <xsl:element name="A">
                                                                  <xsl:attribute name="href">#_</xsl:attribute>
                                                                  <xsl:attribute name="onclick">ViewDashboard(<xsl:value-of select="@memberid"/>)</xsl:attribute>
                                                                  <xsl:element name="IMG">
                                                                     <xsl:attribute name="src">Images/performance.gif</xsl:attribute>
                                                                     <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                     <xsl:attribute name="border">0</xsl:attribute>
                                                                     <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewDashboard']"/></xsl:attribute>
                                                                     <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewDashboard']"/></xsl:attribute>
                                                                  </xsl:element>
                                                               </xsl:element>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/PARAM/@viewcodes != 0)">
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                               <xsl:element name="A">
                                                                  <xsl:attribute name="href">#_</xsl:attribute>
                                                                  <xsl:attribute name="onclick">ViewTeams(<xsl:value-of select="@memberid"/>)</xsl:attribute>
                                                                  <xsl:element name="IMG">
                                                                     <xsl:attribute name="src">Images/genealogy.gif</xsl:attribute>
                                                                     <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                     <xsl:attribute name="border">0</xsl:attribute>
                                                                     <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewTeams']"/></xsl:attribute>
                                                                     <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewTeams']"/></xsl:attribute>
                                                                  </xsl:element>
                                                               </xsl:element>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23) or (/DATA/SYSTEM/@usergroup = 51) or (/DATA/SYSTEM/@usergroup = 52)">
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                               <xsl:element name="A">
                                                                  <xsl:attribute name="onclick">w=window.open(this.href,"new","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                                  <xsl:attribute name="href">0403.asp?MemberID=<xsl:value-of select="@memberid"/>&amp;ContentPage=3&amp;Popup=1</xsl:attribute>
                                                                  <xsl:element name="IMG">
                                                                     <xsl:attribute name="src">Images/Edit.gif</xsl:attribute>
                                                                     <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                     <xsl:attribute name="border">0</xsl:attribute>
                                                                  </xsl:element>
                                                               </xsl:element>
                                                         </xsl:if>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                            <xsl:value-of select="@identification"/>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                            <xsl:element name="font">
                                                               <xsl:attribute name="color">purple</xsl:attribute>
                                                               <xsl:value-of select="@enrolldate"/>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                               <xsl:value-of select="@visitdate"/>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            </xsl:element>
                                                            <xsl:element name="font">
                                                               <xsl:attribute name="color">blue</xsl:attribute>
                                                            (<xsl:value-of select="concat(@bv,'|',@qv)"/>)
                                                            </xsl:element>
                                                         <xsl:if test="(/DATA/PARAM/@viewinfo != 0)">
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                               <xsl:element name="A">
                                                                  <xsl:attribute name="href">#_</xsl:attribute>
                                                                  <xsl:attribute name="onclick">ViewMember(<xsl:value-of select="@memberid"/>)</xsl:attribute>
                                                                  <xsl:element name="IMG">
                                                                     <xsl:attribute name="src">Images/Preview.gif</xsl:attribute>
                                                                     <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                     <xsl:attribute name="border">0</xsl:attribute>
                                                                     <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewInfo']"/></xsl:attribute>
                                                                     <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewInfo']"/></xsl:attribute>
                                                                  </xsl:element>
                                                               </xsl:element>
                                                         </xsl:if>
                                                      </xsl:element>
                                                   </xsl:element>

                                             </xsl:for-each>
                                       </xsl:for-each>
                                 </xsl:for-each>
                           </xsl:for-each>
                        </xsl:if>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">6</xsl:attribute>
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">750</xsl:attribute>
                              <xsl:attribute name="colspan">6</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#004080</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">6</xsl:attribute>
                              <xsl:attribute name="height">3</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">4</xsl:attribute>
                              <xsl:attribute name="width">90</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:if test="(/DATA/PARAM/@count != 0)">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TotalMembers']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:value-of select="/DATA/PARAM/@count" disable-output-escaping="yes"/>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:if>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">660</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@binary != 0)">
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="class">smbutton</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Legend']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[ShowBinaryLegend()]]></xsl:text></xsl:attribute>
                                 </xsl:element>
                              </xsl:if>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">button</xsl:attribute>
                                 <xsl:attribute name="class">smbutton</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Close']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[window.close()]]></xsl:text></xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/PARAM/@binary = 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">6</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">6</xsl:attribute>
                                 <xsl:attribute name="width">625</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">625</xsl:attribute>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">50</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">265</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:element name="TABLE">
                                                <xsl:attribute name="border">0</xsl:attribute>
                                                <xsl:attribute name="cellpadding">0</xsl:attribute>
                                                <xsl:attribute name="cellspacing">0</xsl:attribute>
                                                <xsl:attribute name="width">265</xsl:attribute>
                                                <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>

                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">265</xsl:attribute>
                                                         <xsl:attribute name="align"></xsl:attribute>
                                                         <xsl:attribute name="valign">top</xsl:attribute>
                                                         <xsl:element name="TABLE">
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="cellpadding">0</xsl:attribute>
                                                            <xsl:attribute name="cellspacing">0</xsl:attribute>
                                                            <xsl:attribute name="width">265</xsl:attribute>

                                                               <xsl:element name="TR">
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="colspan">3</xsl:attribute>
                                                                     <xsl:attribute name="width">265</xsl:attribute>
                                                                     <xsl:attribute name="bgcolor">#C0C0FF</xsl:attribute>
                                                                     <xsl:attribute name="align">center</xsl:attribute>
                                                                     <xsl:attribute name="valign">center</xsl:attribute>
                                                                     <xsl:element name="b">
                                                                     <xsl:element name="font">
                                                                        <xsl:attribute name="size">2</xsl:attribute>
                                                                     <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Advancement']"/>
                                                                     </xsl:element>
                                                                     </xsl:element>
                                                                  </xsl:element>
                                                               </xsl:element>
                                                               <xsl:element name="TR">
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="colspan">3</xsl:attribute>
                                                                     <xsl:attribute name="height">3</xsl:attribute>
                                                                  </xsl:element>
                                                               </xsl:element>

                                                               <xsl:for-each select="/DATA/TXN/PTSMEMBERTITLES/PTSMEMBERTITLE">
                                                                     <xsl:element name="TR">
                                                                        <xsl:element name="TD">
                                                                           <xsl:attribute name="width">30</xsl:attribute>
                                                                           <xsl:attribute name="align">center</xsl:attribute>
                                                                           <xsl:attribute name="valign">top</xsl:attribute>
                                                                           <xsl:element name="IMG">
                                                                              <xsl:attribute name="src">Images/Company/<xsl:value-of select="/DATA/PARAM/@companyid"/>/Title<xsl:value-of select="@title"/>.gif</xsl:attribute>
                                                                              <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                              <xsl:attribute name="border">0</xsl:attribute>
                                                                           </xsl:element>
                                                                        </xsl:element>
                                                                        <xsl:element name="TD">
                                                                           <xsl:attribute name="width">165</xsl:attribute>
                                                                           <xsl:attribute name="align">left</xsl:attribute>
                                                                           <xsl:attribute name="valign">center</xsl:attribute>
                                                                              <xsl:element name="b">
                                                                              <xsl:value-of select="@titlename"/>
                                                                              </xsl:element>
                                                                           <xsl:if test="(@isearned = 0)">
                                                                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                                 <xsl:element name="IMG">
                                                                                    <xsl:attribute name="src">Images/yellowchecksm.gif</xsl:attribute>
                                                                                    <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                                    <xsl:attribute name="border">0</xsl:attribute>
                                                                                 </xsl:element>
                                                                           </xsl:if>
                                                                           <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23)">
                                                                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                                 <xsl:element name="A">
                                                                                    <xsl:attribute name="onclick">w=window.open(this.href,"new","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                                                    <xsl:attribute name="href">5703.asp?MemberTitleID=<xsl:value-of select="@membertitleid"/></xsl:attribute>
                                                                                    <xsl:element name="IMG">
                                                                                       <xsl:attribute name="src">Images/Edit.gif</xsl:attribute>
                                                                                       <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                                       <xsl:attribute name="border">0</xsl:attribute>
                                                                                    </xsl:element>
                                                                                 </xsl:element>
                                                                           </xsl:if>
                                                                        </xsl:element>
                                                                        <xsl:element name="TD">
                                                                           <xsl:attribute name="width">70</xsl:attribute>
                                                                           <xsl:attribute name="align">left</xsl:attribute>
                                                                           <xsl:attribute name="valign">center</xsl:attribute>
                                                                              <xsl:element name="font">
                                                                                 <xsl:attribute name="color">purple</xsl:attribute>
                                                                              <xsl:value-of select="@titledate"/>
                                                                              </xsl:element>
                                                                        </xsl:element>
                                                                     </xsl:element>
                                                                     <xsl:element name="TR">
                                                                        <xsl:element name="TD">
                                                                           <xsl:attribute name="colspan">3</xsl:attribute>
                                                                           <xsl:attribute name="height">2</xsl:attribute>
                                                                        </xsl:element>
                                                                     </xsl:element>

                                                               </xsl:for-each>
                                                         </xsl:element>
                                                      </xsl:element>
                                                   </xsl:element>

                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">10</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">180</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:element name="TABLE">
                                                <xsl:attribute name="border">0</xsl:attribute>
                                                <xsl:attribute name="cellpadding">0</xsl:attribute>
                                                <xsl:attribute name="cellspacing">0</xsl:attribute>
                                                <xsl:attribute name="width">180</xsl:attribute>
                                                <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>

                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">180</xsl:attribute>
                                                         <xsl:attribute name="align"></xsl:attribute>
                                                         <xsl:attribute name="valign">top</xsl:attribute>
                                                         <xsl:element name="TABLE">
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="cellpadding">0</xsl:attribute>
                                                            <xsl:attribute name="cellspacing">0</xsl:attribute>
                                                            <xsl:attribute name="width">180</xsl:attribute>

                                                               <xsl:element name="TR">
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="colspan">2</xsl:attribute>
                                                                     <xsl:attribute name="width">180</xsl:attribute>
                                                                     <xsl:attribute name="bgcolor">#C0C0FF</xsl:attribute>
                                                                     <xsl:attribute name="align">center</xsl:attribute>
                                                                     <xsl:attribute name="valign">center</xsl:attribute>
                                                                     <xsl:element name="b">
                                                                     <xsl:element name="font">
                                                                        <xsl:attribute name="size">2</xsl:attribute>
                                                                     <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Title']"/>
                                                                     </xsl:element>
                                                                     </xsl:element>
                                                                  </xsl:element>
                                                               </xsl:element>
                                                               <xsl:element name="TR">
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="colspan">2</xsl:attribute>
                                                                     <xsl:attribute name="height">3</xsl:attribute>
                                                                  </xsl:element>
                                                               </xsl:element>

                                                               <xsl:for-each select="/DATA/TXN/PTSTITLES/ENUM">
                                                                     <xsl:if test="(@id != 0)">
                                                                        <xsl:element name="TR">
                                                                           <xsl:element name="TD">
                                                                              <xsl:attribute name="width">30</xsl:attribute>
                                                                              <xsl:attribute name="align">center</xsl:attribute>
                                                                              <xsl:attribute name="valign">top</xsl:attribute>
                                                                              <xsl:element name="IMG">
                                                                                 <xsl:attribute name="src">Images/Company/<xsl:value-of select="/DATA/PARAM/@companyid"/>/Title<xsl:value-of select="@id"/>.gif</xsl:attribute>
                                                                                 <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                                 <xsl:attribute name="border">0</xsl:attribute>
                                                                              </xsl:element>
                                                                           </xsl:element>
                                                                           <xsl:element name="TD">
                                                                              <xsl:attribute name="width">150</xsl:attribute>
                                                                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                                              <xsl:value-of select="@name"/>
                                                                           </xsl:element>
                                                                        </xsl:element>
                                                                        <xsl:element name="TR">
                                                                           <xsl:element name="TD">
                                                                              <xsl:attribute name="colspan">2</xsl:attribute>
                                                                              <xsl:attribute name="height">2</xsl:attribute>
                                                                           </xsl:element>
                                                                        </xsl:element>
                                                                     </xsl:if>

                                                               </xsl:for-each>
                                                         </xsl:element>
                                                      </xsl:element>
                                                   </xsl:element>

                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">10</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">140</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:element name="TABLE">
                                                <xsl:attribute name="border">0</xsl:attribute>
                                                <xsl:attribute name="cellpadding">0</xsl:attribute>
                                                <xsl:attribute name="cellspacing">0</xsl:attribute>
                                                <xsl:attribute name="width">140</xsl:attribute>
                                                <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>

                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">140</xsl:attribute>
                                                         <xsl:attribute name="align"></xsl:attribute>
                                                         <xsl:attribute name="valign">top</xsl:attribute>
                                                         <xsl:element name="TABLE">
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="cellpadding">0</xsl:attribute>
                                                            <xsl:attribute name="cellspacing">0</xsl:attribute>
                                                            <xsl:attribute name="width">140</xsl:attribute>

                                                               <xsl:element name="TR">
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="colspan">2</xsl:attribute>
                                                                     <xsl:attribute name="width">140</xsl:attribute>
                                                                     <xsl:attribute name="bgcolor">#C0C0FF</xsl:attribute>
                                                                     <xsl:attribute name="align">center</xsl:attribute>
                                                                     <xsl:attribute name="valign">center</xsl:attribute>
                                                                     <xsl:element name="b">
                                                                     <xsl:element name="font">
                                                                        <xsl:attribute name="size">2</xsl:attribute>
                                                                     <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Status']"/>
                                                                     </xsl:element>
                                                                     </xsl:element>
                                                                  </xsl:element>
                                                               </xsl:element>
                                                               <xsl:element name="TR">
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="colspan">2</xsl:attribute>
                                                                     <xsl:attribute name="height">3</xsl:attribute>
                                                                  </xsl:element>
                                                               </xsl:element>

                                                               <xsl:element name="TR">
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="width">30</xsl:attribute>
                                                                     <xsl:attribute name="align">center</xsl:attribute>
                                                                     <xsl:attribute name="valign">center</xsl:attribute>
                                                                     <xsl:element name="IMG">
                                                                        <xsl:attribute name="src">Images/Status1.gif</xsl:attribute>
                                                                        <xsl:attribute name="border">0</xsl:attribute>
                                                                     </xsl:element>
                                                                  </xsl:element>
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="width">110</xsl:attribute>
                                                                     <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                                        <xsl:if test="(/DATA/TXN/PTSCOPTION/@paidname = '')">
                                                                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Active']"/>
                                                                        </xsl:if>
                                                                        <xsl:if test="(/DATA/TXN/PTSCOPTION/@paidname != '')">
                                                                           <xsl:value-of select="/DATA/TXN/PTSCOPTION/@paidname"/>
                                                                        </xsl:if>
                                                                  </xsl:element>
                                                               </xsl:element>
                                                               <xsl:element name="TR">
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="colspan">2</xsl:attribute>
                                                                     <xsl:attribute name="height">2</xsl:attribute>
                                                                  </xsl:element>
                                                               </xsl:element>

                                                               <xsl:element name="TR">
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="width">30</xsl:attribute>
                                                                     <xsl:attribute name="align">center</xsl:attribute>
                                                                     <xsl:attribute name="valign">center</xsl:attribute>
                                                                     <xsl:element name="IMG">
                                                                        <xsl:attribute name="src">Images/Status-1.gif</xsl:attribute>
                                                                        <xsl:attribute name="border">0</xsl:attribute>
                                                                     </xsl:element>
                                                                  </xsl:element>
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="width">110</xsl:attribute>
                                                                     <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                                     <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Status-1']"/>
                                                                  </xsl:element>
                                                               </xsl:element>
                                                               <xsl:element name="TR">
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="colspan">2</xsl:attribute>
                                                                     <xsl:attribute name="height">2</xsl:attribute>
                                                                  </xsl:element>
                                                               </xsl:element>

                                                               <xsl:if test="(/DATA/TXN/PTSCOPTION/@trialdays != 0)">
                                                                  <xsl:element name="TR">
                                                                     <xsl:element name="TD">
                                                                        <xsl:attribute name="width">30</xsl:attribute>
                                                                        <xsl:attribute name="align">center</xsl:attribute>
                                                                        <xsl:attribute name="valign">center</xsl:attribute>
                                                                        <xsl:element name="IMG">
                                                                           <xsl:attribute name="src">Images/Status2.gif</xsl:attribute>
                                                                           <xsl:attribute name="border">0</xsl:attribute>
                                                                        </xsl:element>
                                                                     </xsl:element>
                                                                     <xsl:element name="TD">
                                                                        <xsl:attribute name="width">110</xsl:attribute>
                                                                        <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                                        <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Status2']"/>
                                                                     </xsl:element>
                                                                  </xsl:element>
                                                                  <xsl:element name="TR">
                                                                     <xsl:element name="TD">
                                                                        <xsl:attribute name="colspan">2</xsl:attribute>
                                                                        <xsl:attribute name="height">2</xsl:attribute>
                                                                     </xsl:element>
                                                                  </xsl:element>
                                                               </xsl:if>

                                                               <xsl:if test="(/DATA/TXN/PTSCOPTION/@isfree != 0)">
                                                                  <xsl:element name="TR">
                                                                     <xsl:element name="TD">
                                                                        <xsl:attribute name="width">30</xsl:attribute>
                                                                        <xsl:attribute name="align">center</xsl:attribute>
                                                                        <xsl:attribute name="valign">center</xsl:attribute>
                                                                        <xsl:element name="IMG">
                                                                           <xsl:attribute name="src">Images/Status3.gif</xsl:attribute>
                                                                           <xsl:attribute name="border">0</xsl:attribute>
                                                                        </xsl:element>
                                                                     </xsl:element>
                                                                     <xsl:element name="TD">
                                                                        <xsl:attribute name="width">110</xsl:attribute>
                                                                        <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                                           <xsl:if test="(/DATA/TXN/PTSCOPTION/@freename = '')">
                                                                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Status3']"/>
                                                                           </xsl:if>
                                                                           <xsl:if test="(/DATA/TXN/PTSCOPTION/@freename != '')">
                                                                              <xsl:value-of select="/DATA/TXN/PTSCOPTION/@freename"/>
                                                                           </xsl:if>
                                                                     </xsl:element>
                                                                  </xsl:element>
                                                                  <xsl:element name="TR">
                                                                     <xsl:element name="TD">
                                                                        <xsl:attribute name="colspan">2</xsl:attribute>
                                                                        <xsl:attribute name="height">2</xsl:attribute>
                                                                     </xsl:element>
                                                                  </xsl:element>
                                                               </xsl:if>

                                                               <xsl:element name="TR">
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="width">30</xsl:attribute>
                                                                     <xsl:attribute name="align">center</xsl:attribute>
                                                                     <xsl:attribute name="valign">center</xsl:attribute>
                                                                     <xsl:element name="IMG">
                                                                        <xsl:attribute name="src">Images/Status4.gif</xsl:attribute>
                                                                        <xsl:attribute name="border">0</xsl:attribute>
                                                                     </xsl:element>
                                                                  </xsl:element>
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="width">110</xsl:attribute>
                                                                     <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                                     <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Status4']"/>
                                                                  </xsl:element>
                                                               </xsl:element>
                                                               <xsl:element name="TR">
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="colspan">2</xsl:attribute>
                                                                     <xsl:attribute name="height">2</xsl:attribute>
                                                                  </xsl:element>
                                                               </xsl:element>

                                                               <xsl:element name="TR">
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="width">30</xsl:attribute>
                                                                     <xsl:attribute name="align">center</xsl:attribute>
                                                                     <xsl:attribute name="valign">center</xsl:attribute>
                                                                     <xsl:element name="IMG">
                                                                        <xsl:attribute name="src">Images/Status5.gif</xsl:attribute>
                                                                        <xsl:attribute name="border">0</xsl:attribute>
                                                                     </xsl:element>
                                                                  </xsl:element>
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="width">110</xsl:attribute>
                                                                     <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                                     <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Status5']"/>
                                                                  </xsl:element>
                                                               </xsl:element>
                                                               <xsl:element name="TR">
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="colspan">2</xsl:attribute>
                                                                     <xsl:attribute name="height">2</xsl:attribute>
                                                                  </xsl:element>
                                                               </xsl:element>

                                                               <xsl:element name="TR">
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="width">30</xsl:attribute>
                                                                     <xsl:attribute name="align">center</xsl:attribute>
                                                                     <xsl:attribute name="valign">center</xsl:attribute>
                                                                     <xsl:element name="IMG">
                                                                        <xsl:attribute name="src">Images/Status6.gif</xsl:attribute>
                                                                        <xsl:attribute name="border">0</xsl:attribute>
                                                                     </xsl:element>
                                                                  </xsl:element>
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="width">110</xsl:attribute>
                                                                     <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                                     <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Status6']"/>
                                                                  </xsl:element>
                                                               </xsl:element>
                                                               <xsl:element name="TR">
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="colspan">2</xsl:attribute>
                                                                     <xsl:attribute name="height">2</xsl:attribute>
                                                                  </xsl:element>
                                                               </xsl:element>

                                                               <xsl:element name="TR">
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="width">30</xsl:attribute>
                                                                     <xsl:attribute name="align">center</xsl:attribute>
                                                                     <xsl:attribute name="valign">center</xsl:attribute>
                                                                     <xsl:element name="IMG">
                                                                        <xsl:attribute name="src">Images/Status7.gif</xsl:attribute>
                                                                        <xsl:attribute name="border">0</xsl:attribute>
                                                                     </xsl:element>
                                                                  </xsl:element>
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="width">110</xsl:attribute>
                                                                     <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                                     <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Status7']"/>
                                                                  </xsl:element>
                                                               </xsl:element>
                                                               <xsl:element name="TR">
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="colspan">2</xsl:attribute>
                                                                     <xsl:attribute name="height">2</xsl:attribute>
                                                                  </xsl:element>
                                                               </xsl:element>

                                                         </xsl:element>
                                                      </xsl:element>
                                                   </xsl:element>

                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">6</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                     </xsl:element>

                  </xsl:element>
                  <!--END CONTENT COLUMN-->

               </xsl:element>

            </xsl:element>
            <!--END FORM-->

         </xsl:element>
         <!--END PAGE-->

<xsl:element name="script">
   <xsl:attribute name="type">text/javascript</xsl:attribute>
   <xsl:text>function googleTranslateElementInit() {</xsl:text>
   <xsl:text>new google.translate.TranslateElement({pageLanguage:'en'}, 'google_translate_element');</xsl:text>
   <xsl:text>}</xsl:text>
</xsl:element>
<xsl:element name="script">
   <xsl:attribute name="type">text/javascript</xsl:attribute>
   <xsl:attribute name="src">//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit</xsl:attribute>
</xsl:element>
      </xsl:element>
      </xsl:element>
      <!--END BODY-->

      </xsl:element>

   </xsl:template>
</xsl:stylesheet>