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
         <xsl:with-param name="pagename" select="'Member Calendar'"/>
         <xsl:with-param name="includecalendar" select="true()"/>
         <xsl:with-param name="htmleditor"></xsl:with-param>
         <xsl:with-param name="translate">google</xsl:with-param>
      </xsl:call-template>

      <!--BEGIN BODY-->
      <xsl:element name="BODY">
         <xsl:if test="/DATA/PARAM/@contentpage=1 or /DATA/PARAM/@contentpage=3">
            <xsl:attribute name="topmargin">0</xsl:attribute>
            <xsl:attribute name="leftmargin">0</xsl:attribute>
         </xsl:if>
         <xsl:if test="/DATA/PARAM/@contentpage!=1 and /DATA/PARAM/@contentpage!=3">
            <xsl:attribute name="topmargin">0</xsl:attribute>
            <xsl:attribute name="leftmargin">10</xsl:attribute>
         </xsl:if>
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
                     <xsl:attribute name="onLoad">doErrorMsg('<xsl:value-of select="concat($errmsg, $errmsgfld)"/>')</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:attribute name="onLoad">doErrorMsg('<xsl:value-of select="/DATA/ERROR"/>')</xsl:attribute>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
            </xsl:otherwise>
         </xsl:choose>

         <!--BEGIN PAGE-->
      <xsl:element name="DIV">
         <xsl:attribute name="id">wrapper</xsl:attribute>
         <xsl:element name="A">
            <xsl:attribute name="name">top</xsl:attribute>
         </xsl:element>
         <xsl:element name="TABLE">
            <xsl:attribute name="border">0</xsl:attribute>
            <xsl:attribute name="cellpadding">0</xsl:attribute>
            <xsl:attribute name="cellspacing">0</xsl:attribute>
            <xsl:if test="/DATA/PARAM/@contentpage=0">
               <xsl:attribute name="width">750</xsl:attribute>
            </xsl:if>
            <xsl:if test="/DATA/PARAM/@contentpage=1">
               <xsl:attribute name="width">600</xsl:attribute>
            </xsl:if>
            <xsl:if test="/DATA/PARAM/@contentpage=2 or /DATA/PARAM/@contentpage=3">
               <xsl:attribute name="width">610</xsl:attribute>
            </xsl:if>
            <xsl:attribute name="align">left</xsl:attribute>

            <!--BEGIN FORM-->
            <xsl:element name="FORM">
               <xsl:attribute name="name">Calendar</xsl:attribute>
               <xsl:attribute name="method">post</xsl:attribute>

               <xsl:element name="INPUT">
                  <xsl:attribute name="type">hidden</xsl:attribute>
                  <xsl:attribute name="name">ActionCode</xsl:attribute>
                  <xsl:attribute name="id">ActionCode</xsl:attribute>
                  <xsl:attribute name="value"></xsl:attribute>
               </xsl:element>
               <xsl:element name="INPUT">
                  <xsl:attribute name="type">hidden</xsl:attribute>
                  <xsl:attribute name="name">ContentPage</xsl:attribute>
                  <xsl:attribute name="id">ContentPage</xsl:attribute>
                  <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@contentpage"/></xsl:attribute>
               </xsl:element>
               <xsl:element name="INPUT">
                  <xsl:attribute name="type">hidden</xsl:attribute>
                  <xsl:attribute name="name">Bookmark</xsl:attribute>
                  <xsl:attribute name="id">Bookmark</xsl:attribute>
                  <xsl:attribute name="value"><xsl:value-of select="/DATA/BOOKMARK/@nextbookmark"/></xsl:attribute>
               </xsl:element>
               <!--BEGIN PAGE LAYOUT ROW-->
               <xsl:element name="TR">
                  <xsl:if test="/DATA/PARAM/@contentpage!=1">
                     <xsl:element name="TD">
                        <xsl:attribute name="width">10</xsl:attribute>
                     </xsl:element>
                  </xsl:if>
                  <xsl:element name="TD">
                     <xsl:attribute name="width">740</xsl:attribute>
                  </xsl:element>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ViewAppt(id){ 
               var url, win;
               url = "4804.asp?apptid=" + id
                  win = window.open(url,"vAppt","top=100,left=100,height=150,width=430,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no");
               win.focus();
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function EditAppt(id, edit){ 
               var url, win;
               if( edit == 0 )
               {
                  url = "4803.asp?apptid=" + id
                  win = window.open(url,"Appt","top=100,left=100,height=400,width=550,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no");
                  win.focus();
               }
               else
               {
                  url = "4805.asp?apptid=" + id + "&memberid=" + document.getElementById('MemberID').value;
                  win = window.open(url,"Appt","top=100,left=100,height=250,width=550,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no");
                  win.focus();
               }
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function AddAppt(){ 
               var url, win;
               url = "4802.asp?calendarid=" + document.getElementById('C').value
                  win = window.open(url,"Appt","top=100,left=100,height=400,width=550,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no");
               win.focus();
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function EditCalendar(){ 
               var url, win;
               url = "4703.asp?calendarid=" + document.getElementById('C').value
                  win = window.open(url,"EditCalendar","top=100,left=100,height=520,width=550,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no");
               win.focus();
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function AddCalendar(){ 
               var url, win;
               url = "4702.asp?memberid=" + document.getElementById('MemberID').value + "&companyid=" + document.getElementById('CompanyID').value
                  win = window.open(url,"AddCalendar","top=100,left=100,height=520,width=550,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no");
               win.focus();
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function EditOther(typ,id){ 
               var url, win, style;
               style = ""
               switch (typ)
               {
               case -70:
                  url = "7003.asp?goalid=" + id + " &contentpage=3&popup=1"
                  break
               case -22:
                  url = "2203.asp?leadid=" + id + " &contentpage=3&popup=1"
                  break
               case -81:
                  url = "8103.asp?prospectid=" + id + " &contentpage=3&popup=1"
                  break
               case -90:
                  url = "9003.asp?noteid=" + id + " &popup=1"
                  style = "top=100,left=100,height=175,width=600,resizable=yes"
                  break
               case -96:
                  url = "9603.asp?eventid=" + id + " &popup=1"
                  break
               case -13:
                  url = "1330.asp?sessionid=" + id + " &contentpage=3&popup=1"
                  break
               case -31:
                  url = "3460.asp?memberassessid=" + id + " &popup=1"
                  break
               case -75:
                  url = "7503.asp?projectid=" + id + " &contentpage=3&popup=1"
                  break
               case -74:
                  url = "7403.asp?taskid=" + id + " &contentpage=3&popup=1"
                  break
               }
                  win = window.open(url,null, style);
               win.focus();
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ViewDay(dy){ 
               var url, win, dte, strdate
               dte = new Date(document.getElementById('FromDate').value );
               dte.setDate(dy);
               strdate = (dte.getMonth()+1) + "/" + dte.getDate() + "/" + dte.getFullYear()
               url = "4711.asp?c=" + document.getElementById('C').value + "&date=" + strdate
               win = window.open(url,"DayView");
               win.focus();
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

                  <xsl:if test="/DATA/PARAM/@contentpage!=1">
                     <xsl:element name="TD">
                        <xsl:attribute name="width">10</xsl:attribute>
                     </xsl:element>
                  </xsl:if>
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
                              <xsl:attribute name="width">750</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">C</xsl:attribute>
                              <xsl:attribute name="id">C</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@c"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">FromDate</xsl:attribute>
                              <xsl:attribute name="id">FromDate</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@fromdate"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">MemberID</xsl:attribute>
                              <xsl:attribute name="id">MemberID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@memberid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">CompanyID</xsl:attribute>
                              <xsl:attribute name="id">CompanyID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@companyid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">CalendarMemberID</xsl:attribute>
                              <xsl:attribute name="id">CalendarMemberID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSCALENDAR/@memberid"/></xsl:attribute>
                           </xsl:element>

                        <xsl:if test="(/DATA/PARAM/@edit &lt;= 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">750</xsl:attribute>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">450</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">300</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">450</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:attribute name="class">PageHeading</xsl:attribute>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/calendarsm.gif</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='calendar']"/></xsl:attribute>
                                                   <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='calendar']"/></xsl:attribute>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/TXN/PTSCALENDAR/@calendarname"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="font">
                                                   <xsl:attribute name="color">gray</xsl:attribute>
                                                   (
                                                   <xsl:variable name="tmp2"><xsl:value-of select="/DATA/TXN/PTSCALENDAR/PTSTIMEZONES/ENUM[@id=/DATA/TXN/PTSCALENDAR/@timezone]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp2]"/>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Time']"/>
                                                   )
                                                </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="(/DATA/PARAM/@edit &gt; 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">750</xsl:attribute>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">450</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">300</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">450</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:attribute name="class">PageHeading</xsl:attribute>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/calendar32.gif</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='calendar']"/></xsl:attribute>
                                                   <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='calendar']"/></xsl:attribute>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/TXN/PTSCALENDAR/@calendarname"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, 'U'))">
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="onclick">w=window.open(this.href,"Tutorial","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                      <xsl:attribute name="href">Tutorial.asp?Lesson=11&amp;contentpage=3&amp;popup=1</xsl:attribute>
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/Tutorial.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PinnacleTutorials']"/></xsl:attribute>
                                                         <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PinnacleTutorials']"/></xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             </xsl:if>
                                                <xsl:element name="font">
                                                   <xsl:attribute name="color">gray</xsl:attribute>
                                                   (
                                                   <xsl:variable name="tmp2"><xsl:value-of select="/DATA/TXN/PTSCALENDAR/PTSTIMEZONES/ENUM[@id=/DATA/TXN/PTSCALENDAR/@timezone]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp2]"/>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Time']"/>
                                                   )
                                                </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">300</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:if test="(/DATA/TXN/PTSCALENDAR/@memberid != 0) or (/DATA/SYSTEM/@usergroup != 41)">
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="href">#_</xsl:attribute>
                                                      <xsl:attribute name="onclick">AddAppt()</xsl:attribute>
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/CalendarAppt.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CalendarAppt']"/></xsl:attribute>
                                                         <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CalendarAppt']"/></xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:if>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">#_</xsl:attribute>
                                                   <xsl:attribute name="onclick">doSubmit(0,"")</xsl:attribute>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/CalendarRefresh.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                      <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CalendarRefresh']"/></xsl:attribute>
                                                      <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CalendarRefresh']"/></xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:if test="(/DATA/TXN/PTSCALENDAR/@memberid != 0) or (/DATA/SYSTEM/@usergroup != 41)">
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="href">#_</xsl:attribute>
                                                      <xsl:attribute name="onclick">EditCalendar()</xsl:attribute>
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/CalendarConfig.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CalendarConfig']"/></xsl:attribute>
                                                         <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CalendarConfig']"/></xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:if>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">#_</xsl:attribute>
                                                   <xsl:attribute name="onclick">AddCalendar()</xsl:attribute>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/CalendarAdd.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                      <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CalendarAdd']"/></xsl:attribute>
                                                      <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CalendarAdd']"/></xsl:attribute>
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

                                       <xsl:if test="(/DATA/SYSTEM/@usergroup != 99)">
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">450</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:attribute name="class">prompt</xsl:attribute>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ClickHelp']"/>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">300</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:if test="(count(/DATA/TXN/PTSCALENDARS/ENUM) &gt; 1)">
                                                   <xsl:element name="SELECT">
                                                      <xsl:attribute name="name">NewC</xsl:attribute>
                                                      <xsl:attribute name="id">NewC</xsl:attribute>
                                                      <xsl:attribute name="onchange"><xsl:text disable-output-escaping="yes"><![CDATA[doSubmit(5,"");]]></xsl:text></xsl:attribute>
                                                      <xsl:for-each select="/DATA/TXN/PTSCALENDARS/ENUM">
                                                         <xsl:element name="OPTION">
                                                            <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                                            <xsl:if test="@selected"><xsl:attribute name="SELECTED"/></xsl:if>
                                                            <xsl:value-of select="@name"/>
                                                         </xsl:element>
                                                      </xsl:for-each>
                                                   </xsl:element>
                                                </xsl:if>
                                             </xsl:element>
                                          </xsl:element>

                                       </xsl:if>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="(/DATA/PARAM/@edit != -1)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                    <xsl:element name="A">
                                       <xsl:attribute name="href">#_</xsl:attribute>
                                       <xsl:attribute name="onclick">doSubmit(1,"")</xsl:attribute>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/PrevYear.gif</xsl:attribute>
                                          <xsl:attribute name="align">absmiddle</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                          <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PrevYear']"/></xsl:attribute>
                                          <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PrevYear']"/></xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="A">
                                       <xsl:attribute name="href">#_</xsl:attribute>
                                       <xsl:attribute name="onclick">doSubmit(2,"")</xsl:attribute>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/PrevMonth.gif</xsl:attribute>
                                          <xsl:attribute name="align">absmiddle</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                          <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PrevMonth']"/></xsl:attribute>
                                          <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PrevMonth']"/></xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:value-of select="/DATA/PARAM/@title" disable-output-escaping="yes"/>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:element name="A">
                                       <xsl:attribute name="href">#_</xsl:attribute>
                                       <xsl:attribute name="onclick">doSubmit(3,"")</xsl:attribute>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/NextMonth.gif</xsl:attribute>
                                          <xsl:attribute name="align">absmiddle</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                          <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NextMonth']"/></xsl:attribute>
                                          <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NextMonth']"/></xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="A">
                                       <xsl:attribute name="href">#_</xsl:attribute>
                                       <xsl:attribute name="onclick">doSubmit(4,"")</xsl:attribute>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/NextYear.gif</xsl:attribute>
                                          <xsl:attribute name="align">absmiddle</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                          <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NextYear']"/></xsl:attribute>
                                          <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NextYear']"/></xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">749</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">749</xsl:attribute>
                                    <xsl:attribute name="class">Calendar</xsl:attribute>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">107</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">107</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">107</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">107</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">107</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">107</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">107</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">107</xsl:attribute>
                                             <xsl:attribute name="bgcolor">lightblue</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Mon']"/>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">107</xsl:attribute>
                                             <xsl:attribute name="bgcolor">lightblue</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Tue']"/>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">107</xsl:attribute>
                                             <xsl:attribute name="bgcolor">lightblue</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Wed']"/>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">107</xsl:attribute>
                                             <xsl:attribute name="bgcolor">lightblue</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Thu']"/>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">107</xsl:attribute>
                                             <xsl:attribute name="bgcolor">lightblue</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Fri']"/>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">107</xsl:attribute>
                                             <xsl:attribute name="bgcolor">lightblue</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Sat']"/>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">107</xsl:attribute>
                                             <xsl:attribute name="bgcolor">lightblue</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Sun']"/>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:for-each select="/DATA/TXN/PTSCELLS/PTSCELL[position() mod 7 = 1]">
                                             <xsl:element name="TR">
                                                <xsl:for-each select=".|following-sibling::PTSCELL[position() &lt; 7]">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">107</xsl:attribute>
                                                         <xsl:attribute name="align">left</xsl:attribute>
                                                         <xsl:attribute name="valign">top</xsl:attribute>
                                                         <xsl:attribute name="class">CalendarDay</xsl:attribute>
                                                         <xsl:if test="(@today )">
                                                               <xsl:attribute name="bgcolor">honeydew</xsl:attribute>
                                                         </xsl:if>
                                                         <xsl:if test="(@day != '')">
                                                               <xsl:element name="div">
                                                                  <xsl:attribute name="id">1</xsl:attribute>
                                                                  <xsl:attribute name="align">right</xsl:attribute>
                                                                  <xsl:if test="(/DATA/PARAM/@edit != 0)">
                                                                     <xsl:element name="A">
                                                                        <xsl:attribute name="href">#_</xsl:attribute>
                                                                        <xsl:attribute name="onclick">ViewDay(<xsl:value-of select="@day"/>)</xsl:attribute>
                                                                     <xsl:element name="b">
                                                                     <xsl:element name="u">
                                                                     <xsl:value-of select="@day"/>
                                                                     </xsl:element>
                                                                     </xsl:element>
                                                                     <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                     <xsl:element name="BR"/>
                                                                     </xsl:element>
                                                                  </xsl:if>
                                                                  <xsl:if test="(/DATA/PARAM/@edit = 0)">
                                                                     <xsl:element name="b">
                                                                     <xsl:value-of select="@day"/>
                                                                     </xsl:element>
                                                                     <xsl:element name="BR"/>
                                                                  </xsl:if>
                                                               </xsl:element>
                                                            <xsl:for-each select="/DATA/TXN/PTSAPPTS/PTSAPPT[ contains(@email,concat('~',current()/@day,'~')) ]">
                                                                  <xsl:sort select="@reminder" data-type="number"/>
                                                                  <xsl:sort select="@apptname"/>
                                                                     <xsl:element name="IMG">
                                                                        <xsl:attribute name="src">Images/appt<xsl:value-of select="@appttype"/>.gif</xsl:attribute>
                                                                        <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                        <xsl:attribute name="border">0</xsl:attribute>
                                                                     </xsl:element>
                                                                     <xsl:if test="(@isplan != 0)">
                                                                        <xsl:element name="IMG">
                                                                           <xsl:attribute name="src">Images/plan.gif</xsl:attribute>
                                                                           <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                           <xsl:attribute name="border">0</xsl:attribute>
                                                                        </xsl:element>
                                                                     </xsl:if>
                                                                     <xsl:if test="(@recur != 0)">
                                                                        <xsl:element name="IMG">
                                                                           <xsl:attribute name="src">Images/recur.gif</xsl:attribute>
                                                                           <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                           <xsl:attribute name="border">0</xsl:attribute>
                                                                        </xsl:element>
                                                                     </xsl:if>
                                                                     <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                  <xsl:if test="(@importance = 1)">
                                                                        <xsl:element name="IMG">
                                                                           <xsl:attribute name="src">Images/apptlow.gif</xsl:attribute>
                                                                           <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                           <xsl:attribute name="border">0</xsl:attribute>
                                                                           <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ImportanceLow']"/></xsl:attribute>
                                                                           <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ImportanceLow']"/></xsl:attribute>
                                                                        </xsl:element>
                                                                  </xsl:if>
                                                                  <xsl:if test="(@importance = 3)">
                                                                        <xsl:element name="IMG">
                                                                           <xsl:attribute name="src">Images/appthigh.gif</xsl:attribute>
                                                                           <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                           <xsl:attribute name="border">0</xsl:attribute>
                                                                           <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ImportanceHigh']"/></xsl:attribute>
                                                                           <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ImportanceHigh']"/></xsl:attribute>
                                                                        </xsl:element>
                                                                  </xsl:if>
                                                                  <xsl:if test="(/DATA/PARAM/@edit = 1)">
                                                                     <xsl:if test="(@show = 2)">
                                                                           <xsl:element name="IMG">
                                                                              <xsl:attribute name="src">Images/apptprivate.gif</xsl:attribute>
                                                                              <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                              <xsl:attribute name="border">0</xsl:attribute>
                                                                              <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ShowPrivate']"/></xsl:attribute>
                                                                              <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ShowPrivate']"/></xsl:attribute>
                                                                           </xsl:element>
                                                                     </xsl:if>
                                                                     <xsl:if test="(@show = 3)">
                                                                           <xsl:element name="IMG">
                                                                              <xsl:attribute name="src">Images/apptbusy.gif</xsl:attribute>
                                                                              <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                              <xsl:attribute name="border">0</xsl:attribute>
                                                                              <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ShowBusy']"/></xsl:attribute>
                                                                              <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ShowBusy']"/></xsl:attribute>
                                                                           </xsl:element>
                                                                     </xsl:if>
                                                                  </xsl:if>
                                                                     <xsl:element name="font">
                                                                        <xsl:attribute name="size">1</xsl:attribute>
                                                                     <xsl:if test="(/DATA/PARAM/@edit = 0) and (@show = 3)">
                                                                           <xsl:if test="(@opt = '0')">
                                                                              <xsl:value-of select="@apptname"/>
                                                                           </xsl:if>
                                                                           <xsl:if test="(@opt = '1')">
                                                                              <xsl:element name="b">
                                                                              <xsl:element name="font">
                                                                                 <xsl:attribute name="color">purple</xsl:attribute>
                                                                              <xsl:value-of select="@apptname"/>
                                                                              </xsl:element>
                                                                              </xsl:element>
                                                                           </xsl:if>
                                                                           <xsl:if test="(@opt = '2')">
                                                                              <xsl:element name="b">
                                                                              <xsl:element name="font">
                                                                                 <xsl:attribute name="color">red</xsl:attribute>
                                                                              <xsl:value-of select="@apptname"/>
                                                                              </xsl:element>
                                                                              </xsl:element>
                                                                           </xsl:if>
                                                                     </xsl:if>
                                                                     <xsl:if test="(/DATA/PARAM/@edit = 1) or (@show != 3)">
                                                                        <xsl:if test="(/DATA/PARAM/@edit = 0) and (/DATA/PARAM/@m = 0)">
                                                                              <xsl:if test="(@opt = '0')">
                                                                                 <xsl:element name="A">
                                                                                    <xsl:attribute name="href">#_</xsl:attribute>
                                                                                    <xsl:attribute name="onclick">ViewAppt(<xsl:value-of select="@apptid"/>)</xsl:attribute>
                                                                                 <xsl:value-of select="@apptname"/>
                                                                                 </xsl:element>
                                                                              </xsl:if>
                                                                              <xsl:if test="(@opt = '1')">
                                                                                 <xsl:element name="A">
                                                                                    <xsl:attribute name="href">#_</xsl:attribute>
                                                                                    <xsl:attribute name="onclick">ViewAppt(<xsl:value-of select="@apptid"/>)</xsl:attribute>
                                                                                 <xsl:element name="b">
                                                                                 <xsl:element name="font">
                                                                                    <xsl:attribute name="color">purple</xsl:attribute>
                                                                                 <xsl:value-of select="@apptname"/>
                                                                                 </xsl:element>
                                                                                 </xsl:element>
                                                                                 </xsl:element>
                                                                              </xsl:if>
                                                                           <xsl:if test="(@opt = '2')">
                                                                                 <xsl:element name="A">
                                                                                    <xsl:attribute name="href">#_</xsl:attribute>
                                                                                    <xsl:attribute name="onclick">EditAppt(<xsl:value-of select="@apptid"/>,1)</xsl:attribute>
                                                                                 <xsl:element name="b">
                                                                                 <xsl:element name="font">
                                                                                    <xsl:attribute name="color">red</xsl:attribute>
                                                                                 <xsl:value-of select="@apptname"/>
                                                                                 </xsl:element>
                                                                                 </xsl:element>
                                                                                 </xsl:element>
                                                                           </xsl:if>
                                                                        </xsl:if>
                                                                        <xsl:if test="(/DATA/PARAM/@edit = 1) or (/DATA/PARAM/@m != 0)">
                                                                           <xsl:if test="(@appttype &gt;= 0)">
                                                                                 <xsl:if test="(@opt = '0')">
                                                                                    <xsl:element name="A">
                                                                                       <xsl:attribute name="href">#_</xsl:attribute>
                                                                                       <xsl:attribute name="onclick">EditAppt(<xsl:value-of select="@apptid"/>, 0)</xsl:attribute>
                                                                                    <xsl:value-of select="@apptname"/>
                                                                                    </xsl:element>
                                                                                 </xsl:if>
                                                                                 <xsl:if test="(@opt = '1')">
                                                                                    <xsl:element name="A">
                                                                                       <xsl:attribute name="href">#_</xsl:attribute>
                                                                                       <xsl:attribute name="onclick">EditAppt(<xsl:value-of select="@apptid"/>, 0)</xsl:attribute>
                                                                                    <xsl:element name="b">
                                                                                    <xsl:element name="font">
                                                                                       <xsl:attribute name="color">purple</xsl:attribute>
                                                                                    <xsl:value-of select="@apptname"/>
                                                                                    </xsl:element>
                                                                                    </xsl:element>
                                                                                    </xsl:element>
                                                                                 </xsl:if>
                                                                                 <xsl:if test="(@opt = '2')">
                                                                                    <xsl:element name="A">
                                                                                       <xsl:attribute name="href">#_</xsl:attribute>
                                                                                       <xsl:attribute name="onclick">EditAppt(<xsl:value-of select="@apptid"/>, 0)</xsl:attribute>
                                                                                    <xsl:element name="b">
                                                                                    <xsl:element name="font">
                                                                                       <xsl:attribute name="color">red</xsl:attribute>
                                                                                    <xsl:value-of select="@apptname"/>
                                                                                    </xsl:element>
                                                                                    </xsl:element>
                                                                                    </xsl:element>
                                                                                 </xsl:if>
                                                                           </xsl:if>
                                                                           <xsl:if test="(@appttype &lt; 0)">
                                                                              <xsl:if test="(@appttype = -70) or (@appttype = -701)">
                                                                                 <xsl:if test="(@status != 3) and (@status != 2)">
                                                                                       <xsl:element name="A">
                                                                                          <xsl:attribute name="href">#_</xsl:attribute>
                                                                                          <xsl:attribute name="onclick">EditOther(-70, <xsl:value-of select="@apptid"/>)</xsl:attribute>
                                                                                       <xsl:value-of select="@apptname"/>
                                                                                       </xsl:element>
                                                                                 </xsl:if>
                                                                                 <xsl:if test="(@status = 3)">
                                                                                       <xsl:element name="IMG">
                                                                                          <xsl:attribute name="src">Images/greenchecksm.gif</xsl:attribute>
                                                                                          <xsl:attribute name="border">0</xsl:attribute>
                                                                                       </xsl:element>
                                                                                       <xsl:element name="A">
                                                                                          <xsl:attribute name="href">#_</xsl:attribute>
                                                                                          <xsl:attribute name="onclick">EditOther(-70, <xsl:value-of select="@apptid"/>)</xsl:attribute>
                                                                                       <xsl:element name="font">
                                                                                          <xsl:attribute name="color">darkgreen</xsl:attribute>
                                                                                       <xsl:value-of select="@apptname"/>
                                                                                       </xsl:element>
                                                                                       </xsl:element>
                                                                                 </xsl:if>
                                                                                 <xsl:if test="(@status = 2)">
                                                                                       <xsl:element name="IMG">
                                                                                          <xsl:attribute name="src">Images/redchecksm.gif</xsl:attribute>
                                                                                          <xsl:attribute name="border">0</xsl:attribute>
                                                                                       </xsl:element>
                                                                                       <xsl:element name="A">
                                                                                          <xsl:attribute name="href">#_</xsl:attribute>
                                                                                          <xsl:attribute name="onclick">EditOther(-70, <xsl:value-of select="@apptid"/>)</xsl:attribute>
                                                                                       <xsl:element name="font">
                                                                                          <xsl:attribute name="color">red</xsl:attribute>
                                                                                       <xsl:value-of select="@apptname"/>
                                                                                       </xsl:element>
                                                                                       </xsl:element>
                                                                                 </xsl:if>
                                                                              </xsl:if>
                                                                              <xsl:if test="(@appttype = -22)">
                                                                                    <xsl:element name="IMG">
                                                                                       <xsl:attribute name="src">Images/Appt2.gif</xsl:attribute>
                                                                                       <xsl:attribute name="border">0</xsl:attribute>
                                                                                    </xsl:element>
                                                                                    <xsl:if test="(@calendarid != '1')">
                                                                                       <xsl:element name="A">
                                                                                          <xsl:attribute name="href">#_</xsl:attribute>
                                                                                          <xsl:attribute name="onclick">EditOther(-22, <xsl:value-of select="@apptid"/>)</xsl:attribute>
                                                                                       <xsl:value-of select="@apptname"/>
                                                                                       </xsl:element>
                                                                                    </xsl:if>
                                                                                    <xsl:if test="(@calendarid = '1')">
                                                                                       <xsl:element name="A">
                                                                                          <xsl:attribute name="href">#_</xsl:attribute>
                                                                                          <xsl:attribute name="onclick">EditOther(-22, <xsl:value-of select="@apptid"/>)</xsl:attribute>
                                                                                       <xsl:element name="font">
                                                                                          <xsl:attribute name="color">red</xsl:attribute>
                                                                                       <xsl:value-of select="@apptname"/>
                                                                                       </xsl:element>
                                                                                       </xsl:element>
                                                                                    </xsl:if>
                                                                              </xsl:if>
                                                                              <xsl:if test="(@appttype = -81)">
                                                                                 <xsl:if test="(@status = 1)">
                                                                                       <xsl:element name="IMG">
                                                                                          <xsl:attribute name="src">Images/Appt2.gif</xsl:attribute>
                                                                                          <xsl:attribute name="border">0</xsl:attribute>
                                                                                       </xsl:element>
                                                                                 </xsl:if>
                                                                                 <xsl:if test="(@status = 2)">
                                                                                       <xsl:element name="IMG">
                                                                                          <xsl:attribute name="src">Images/Appt3.gif</xsl:attribute>
                                                                                          <xsl:attribute name="border">0</xsl:attribute>
                                                                                       </xsl:element>
                                                                                 </xsl:if>
                                                                                    <xsl:if test="(@calendarid != '1')">
                                                                                       <xsl:element name="A">
                                                                                          <xsl:attribute name="href">#_</xsl:attribute>
                                                                                          <xsl:attribute name="onclick">EditOther(-81, <xsl:value-of select="@apptid"/>)</xsl:attribute>
                                                                                       <xsl:value-of select="@apptname"/>
                                                                                       </xsl:element>
                                                                                    </xsl:if>
                                                                                    <xsl:if test="(@calendarid = '1')">
                                                                                       <xsl:element name="A">
                                                                                          <xsl:attribute name="href">#_</xsl:attribute>
                                                                                          <xsl:attribute name="onclick">EditOther(-81, <xsl:value-of select="@apptid"/>)</xsl:attribute>
                                                                                       <xsl:element name="font">
                                                                                          <xsl:attribute name="color">red</xsl:attribute>
                                                                                       <xsl:value-of select="@apptname"/>
                                                                                       </xsl:element>
                                                                                       </xsl:element>
                                                                                    </xsl:if>
                                                                              </xsl:if>
                                                                              <xsl:if test="(@appttype = -90)">
                                                                                 <xsl:if test="(@status != 0)">
                                                                                       <xsl:element name="IMG">
                                                                                          <xsl:attribute name="src">Images/greenchecksm.gif</xsl:attribute>
                                                                                          <xsl:attribute name="border">0</xsl:attribute>
                                                                                       </xsl:element>
                                                                                 </xsl:if>
                                                                                    <xsl:element name="A">
                                                                                       <xsl:attribute name="href">#_</xsl:attribute>
                                                                                       <xsl:attribute name="onclick">EditOther(-90, <xsl:value-of select="@apptid"/>)</xsl:attribute>
                                                                                    <xsl:value-of select="@apptname"/>
                                                                                    </xsl:element>
                                                                              </xsl:if>
                                                                              <xsl:if test="(@appttype = -96)">
                                                                                 <xsl:if test="(@status != 0)">
                                                                                       <xsl:element name="IMG">
                                                                                          <xsl:attribute name="src">Images/event<xsl:value-of select="@status"/>.gif</xsl:attribute>
                                                                                          <xsl:attribute name="border">0</xsl:attribute>
                                                                                       </xsl:element>
                                                                                 </xsl:if>
                                                                                    <xsl:element name="A">
                                                                                       <xsl:attribute name="href">#_</xsl:attribute>
                                                                                       <xsl:attribute name="onclick">EditOther(-96, <xsl:value-of select="@apptid"/>)</xsl:attribute>
                                                                                    <xsl:value-of select="@apptname"/>
                                                                                    </xsl:element>
                                                                              </xsl:if>
                                                                              <xsl:if test="(@appttype = -13)">
                                                                                 <xsl:if test="(@status != 6) and (@status != 7)">
                                                                                       <xsl:element name="A">
                                                                                          <xsl:attribute name="href">#_</xsl:attribute>
                                                                                          <xsl:attribute name="onclick">EditOther(-13, <xsl:value-of select="@apptid"/>)</xsl:attribute>
                                                                                       <xsl:value-of select="@apptname"/>
                                                                                       </xsl:element>
                                                                                 </xsl:if>
                                                                                 <xsl:if test="(@status = 6)">
                                                                                       <xsl:element name="IMG">
                                                                                          <xsl:attribute name="src">Images/greenchecksm.gif</xsl:attribute>
                                                                                          <xsl:attribute name="border">0</xsl:attribute>
                                                                                       </xsl:element>
                                                                                       <xsl:element name="A">
                                                                                          <xsl:attribute name="href">#_</xsl:attribute>
                                                                                          <xsl:attribute name="onclick">EditOther(-13, <xsl:value-of select="@apptid"/>)</xsl:attribute>
                                                                                       <xsl:element name="font">
                                                                                          <xsl:attribute name="color">darkgreen</xsl:attribute>
                                                                                       <xsl:value-of select="@apptname"/>
                                                                                       </xsl:element>
                                                                                       </xsl:element>
                                                                                 </xsl:if>
                                                                                 <xsl:if test="(@status = 7)">
                                                                                       <xsl:element name="IMG">
                                                                                          <xsl:attribute name="src">Images/redchecksm.gif</xsl:attribute>
                                                                                          <xsl:attribute name="border">0</xsl:attribute>
                                                                                       </xsl:element>
                                                                                       <xsl:element name="A">
                                                                                          <xsl:attribute name="href">#_</xsl:attribute>
                                                                                          <xsl:attribute name="onclick">EditOther(-13, <xsl:value-of select="@apptid"/>)</xsl:attribute>
                                                                                       <xsl:element name="font">
                                                                                          <xsl:attribute name="color">red</xsl:attribute>
                                                                                       <xsl:value-of select="@apptname"/>
                                                                                       </xsl:element>
                                                                                       </xsl:element>
                                                                                 </xsl:if>
                                                                              </xsl:if>
                                                                              <xsl:if test="(@appttype = -31)">
                                                                                 <xsl:if test="(@status != 1) and (@status != 2)">
                                                                                       <xsl:element name="A">
                                                                                          <xsl:attribute name="href">#_</xsl:attribute>
                                                                                          <xsl:attribute name="onclick">EditOther(-31, <xsl:value-of select="@apptid"/>)</xsl:attribute>
                                                                                       <xsl:value-of select="@apptname"/>
                                                                                       </xsl:element>
                                                                                 </xsl:if>
                                                                                 <xsl:if test="(@status = 1)">
                                                                                       <xsl:element name="IMG">
                                                                                          <xsl:attribute name="src">Images/greenchecksm.gif</xsl:attribute>
                                                                                          <xsl:attribute name="border">0</xsl:attribute>
                                                                                       </xsl:element>
                                                                                       <xsl:element name="A">
                                                                                          <xsl:attribute name="href">#_</xsl:attribute>
                                                                                          <xsl:attribute name="onclick">EditOther(-31, <xsl:value-of select="@apptid"/>)</xsl:attribute>
                                                                                       <xsl:element name="font">
                                                                                          <xsl:attribute name="color">darkgreen</xsl:attribute>
                                                                                       <xsl:value-of select="@apptname"/>
                                                                                       </xsl:element>
                                                                                       </xsl:element>
                                                                                 </xsl:if>
                                                                                 <xsl:if test="(@status = 2)">
                                                                                       <xsl:element name="IMG">
                                                                                          <xsl:attribute name="src">Images/redchecksm.gif</xsl:attribute>
                                                                                          <xsl:attribute name="border">0</xsl:attribute>
                                                                                       </xsl:element>
                                                                                       <xsl:element name="A">
                                                                                          <xsl:attribute name="href">#_</xsl:attribute>
                                                                                          <xsl:attribute name="onclick">EditOther(-31, <xsl:value-of select="@apptid"/>)</xsl:attribute>
                                                                                       <xsl:element name="font">
                                                                                          <xsl:attribute name="color">red</xsl:attribute>
                                                                                       <xsl:value-of select="@apptname"/>
                                                                                       </xsl:element>
                                                                                       </xsl:element>
                                                                                 </xsl:if>
                                                                              </xsl:if>
                                                                              <xsl:if test="(@appttype = -75)">
                                                                                 <xsl:if test="(@status != 2) and (@status != 1)">
                                                                                       <xsl:element name="A">
                                                                                          <xsl:attribute name="href">#_</xsl:attribute>
                                                                                          <xsl:attribute name="onclick">EditOther(-75, <xsl:value-of select="@apptid"/>)</xsl:attribute>
                                                                                       <xsl:value-of select="@apptname"/>
                                                                                       </xsl:element>
                                                                                 </xsl:if>
                                                                                 <xsl:if test="(@status = 2)">
                                                                                       <xsl:element name="IMG">
                                                                                          <xsl:attribute name="src">Images/greenchecksm.gif</xsl:attribute>
                                                                                          <xsl:attribute name="border">0</xsl:attribute>
                                                                                       </xsl:element>
                                                                                       <xsl:element name="A">
                                                                                          <xsl:attribute name="href">#_</xsl:attribute>
                                                                                          <xsl:attribute name="onclick">EditOther(-75, <xsl:value-of select="@apptid"/>)</xsl:attribute>
                                                                                       <xsl:element name="font">
                                                                                          <xsl:attribute name="color">darkgreen</xsl:attribute>
                                                                                       <xsl:value-of select="@apptname"/>
                                                                                       </xsl:element>
                                                                                       </xsl:element>
                                                                                 </xsl:if>
                                                                                 <xsl:if test="(@status = 1)">
                                                                                       <xsl:element name="IMG">
                                                                                          <xsl:attribute name="src">Images/redchecksm.gif</xsl:attribute>
                                                                                          <xsl:attribute name="border">0</xsl:attribute>
                                                                                       </xsl:element>
                                                                                       <xsl:element name="A">
                                                                                          <xsl:attribute name="href">#_</xsl:attribute>
                                                                                          <xsl:attribute name="onclick">EditOther(-75, <xsl:value-of select="@apptid"/>)</xsl:attribute>
                                                                                       <xsl:element name="font">
                                                                                          <xsl:attribute name="color">red</xsl:attribute>
                                                                                       <xsl:value-of select="@apptname"/>
                                                                                       </xsl:element>
                                                                                       </xsl:element>
                                                                                 </xsl:if>
                                                                              </xsl:if>
                                                                              <xsl:if test="(@appttype = -74)">
                                                                                 <xsl:if test="(@status != 2) and (@status != 1)">
                                                                                       <xsl:element name="A">
                                                                                          <xsl:attribute name="href">#_</xsl:attribute>
                                                                                          <xsl:attribute name="onclick">EditOther(-74, <xsl:value-of select="@apptid"/>)</xsl:attribute>
                                                                                       <xsl:value-of select="@apptname"/>
                                                                                       </xsl:element>
                                                                                 </xsl:if>
                                                                                 <xsl:if test="(@status = 2)">
                                                                                       <xsl:element name="IMG">
                                                                                          <xsl:attribute name="src">Images/greenchecksm.gif</xsl:attribute>
                                                                                          <xsl:attribute name="border">0</xsl:attribute>
                                                                                       </xsl:element>
                                                                                       <xsl:element name="A">
                                                                                          <xsl:attribute name="href">#_</xsl:attribute>
                                                                                          <xsl:attribute name="onclick">EditOther(-74, <xsl:value-of select="@apptid"/>)</xsl:attribute>
                                                                                       <xsl:element name="font">
                                                                                          <xsl:attribute name="color">darkgreen</xsl:attribute>
                                                                                       <xsl:value-of select="@apptname"/>
                                                                                       </xsl:element>
                                                                                       </xsl:element>
                                                                                 </xsl:if>
                                                                                 <xsl:if test="(@status = 1)">
                                                                                       <xsl:element name="IMG">
                                                                                          <xsl:attribute name="src">Images/redchecksm.gif</xsl:attribute>
                                                                                          <xsl:attribute name="border">0</xsl:attribute>
                                                                                       </xsl:element>
                                                                                       <xsl:element name="A">
                                                                                          <xsl:attribute name="href">#_</xsl:attribute>
                                                                                          <xsl:attribute name="onclick">EditOther(-74, <xsl:value-of select="@apptid"/>)</xsl:attribute>
                                                                                       <xsl:element name="font">
                                                                                          <xsl:attribute name="color">red</xsl:attribute>
                                                                                       <xsl:value-of select="@apptname"/>
                                                                                       </xsl:element>
                                                                                       </xsl:element>
                                                                                 </xsl:if>
                                                                              </xsl:if>
                                                                           </xsl:if>
                                                                        </xsl:if>
                                                                           <xsl:if test="(@location != '') or (@note != '')">
                                                                              <xsl:element name="b">
                                                                              ...
                                                                              </xsl:element>
                                                                           </xsl:if>
                                                                     </xsl:if>
                                                                     </xsl:element>
                                                                     <xsl:element name="BR"/>
                                                            </xsl:for-each>
                                                               <xsl:element name="BR"/>
                                                         </xsl:if>
                                                      </xsl:element>
                                                </xsl:for-each>
                                             </xsl:element>

                                       </xsl:for-each>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/PARAM/@edit = 1)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:if test="(/DATA/TXN/PTSCALENDAR/@isgoal != 0)">
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/Appt-70.gif</xsl:attribute>
                                          <xsl:attribute name="align">absmiddle</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Appt-Goals']"/>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/TXN/PTSCALENDAR/@islead != 0)">
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/Appt-22.gif</xsl:attribute>
                                          <xsl:attribute name="align">absmiddle</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Appt-Lead']"/>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/TXN/PTSCALENDAR/@issales != 0)">
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/Appt-81.gif</xsl:attribute>
                                          <xsl:attribute name="align">absmiddle</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Appt-Sales']"/>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/TXN/PTSCALENDAR/@isactivities != 0)">
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/Appt-90.gif</xsl:attribute>
                                          <xsl:attribute name="align">absmiddle</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Appt-Notes']"/>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/TXN/PTSCALENDAR/@isservice != 0)">
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/Appt-701.gif</xsl:attribute>
                                          <xsl:attribute name="align">absmiddle</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Appt-Service']"/>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/TXN/PTSCALENDAR/@isevents != 0)">
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/Appt-96.gif</xsl:attribute>
                                          <xsl:attribute name="align">absmiddle</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Appt-Events']"/>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/TXN/PTSCALENDAR/@isclass != 0)">
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/Appt-13.gif</xsl:attribute>
                                          <xsl:attribute name="align">absmiddle</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Appt-Classes']"/>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/TXN/PTSCALENDAR/@isassess != 0)">
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/Appt-31.gif</xsl:attribute>
                                          <xsl:attribute name="align">absmiddle</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Appt-Assessments']"/>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/TXN/PTSCALENDAR/@isproject != 0)">
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/Appt-75.gif</xsl:attribute>
                                          <xsl:attribute name="align">absmiddle</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Apt-Projects']"/>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/TXN/PTSCALENDAR/@istask != 0)">
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/Appt-74.gif</xsl:attribute>
                                          <xsl:attribute name="align">absmiddle</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Appt-Tasks']"/>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:if>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="(/DATA/TXN/PTSCALENDAR/@isprivate = 0) and (/DATA/PARAM/@edit = 1)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                    <xsl:element name="font">
                                       <xsl:attribute name="color">red</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='public']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    </xsl:element>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:value-of select="/DATA/PARAM/@url" disable-output-escaping="yes"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="(/DATA/PARAM/@edit = -1)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:element name="font">
                                    <xsl:attribute name="color">red</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsPrivate']"/>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
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