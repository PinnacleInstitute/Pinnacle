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
         <xsl:with-param name="pagename" select="'Activity Statistics'"/>
         <xsl:with-param name="includecalendar" select="true()"/>
         <xsl:with-param name="htmleditor"></xsl:with-param>
         <xsl:with-param name="translate">google</xsl:with-param>
      </xsl:call-template>

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
                     <xsl:attribute name="onLoad">doErrorMsg('<xsl:value-of select="concat($errmsg, $errmsgfld)"/>')</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:attribute name="onLoad">doErrorMsg('<xsl:value-of select="/DATA/ERROR"/>')</xsl:attribute>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
               <xsl:attribute name="onload">document.getElementById('FromDate').focus()</xsl:attribute>
            </xsl:otherwise>
         </xsl:choose>

         <!--BEGIN PAGE-->
      <xsl:element name="DIV">
         <xsl:attribute name="id">wrapper800</xsl:attribute>
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
               <xsl:attribute name="name">Metric</xsl:attribute>
               <xsl:attribute name="method">post</xsl:attribute>

               <xsl:element name="INPUT">
                  <xsl:attribute name="type">hidden</xsl:attribute>
                  <xsl:attribute name="name">ActionCode</xsl:attribute>
                  <xsl:attribute name="id">ActionCode</xsl:attribute>
                  <xsl:attribute name="value"></xsl:attribute>
               </xsl:element>
               <xsl:element name="INPUT">
                  <xsl:attribute name="type">hidden</xsl:attribute>
                  <xsl:attribute name="name">Bookmark</xsl:attribute>
                  <xsl:attribute name="id">Bookmark</xsl:attribute>
                  <xsl:attribute name="value"><xsl:value-of select="/DATA/BOOKMARK/@nextbookmark"/></xsl:attribute>
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
                     <xsl:attribute name="width">800</xsl:attribute>

                     <xsl:element name="TABLE">
                        <xsl:attribute name="border">0</xsl:attribute>
                        <xsl:attribute name="cellpadding">0</xsl:attribute>
                        <xsl:attribute name="cellspacing">0</xsl:attribute>
                        <xsl:attribute name="width">800</xsl:attribute>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">800</xsl:attribute>
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
                              <xsl:attribute name="name">EnrollDate</xsl:attribute>
                              <xsl:attribute name="id">EnrollDate</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@enrolldate"/></xsl:attribute>
                           </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">800</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeading</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MemberSummary']"/>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">800</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">ColumnHeader</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MetricsFor']"/>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="SELECT">
                                 <xsl:attribute name="name">Term</xsl:attribute>
                                 <xsl:attribute name="id">Term</xsl:attribute>
                                 <xsl:attribute name="onchange"><xsl:text disable-output-escaping="yes"><![CDATA[
                     var ONE_DAY = 1000 * 60 * 60 * 24;
                     var fromdate = new Date();
                     var todate = new Date();
                     term = document.getElementById('Term').value;
                     switch(term) {
                     case "1":
                     document.getElementById('FromDate').value = document.getElementById('EnrollDate').value
                     break;
                     case "2":
                     break;
                     case "3":
                     fromdate.setTime(fromdate.getTime() - ONE_DAY );
                     todate = fromdate;
                     break;
                     case "4":
                     var d = fromdate.getDay()
                     if( d == 0 ) { d = 7 }
                     fromdate.setTime(fromdate.getTime() - ( (d-1) * ONE_DAY ) );
                     break;
                     case "5":
                     fromdate.setDate(1);
                     break;
                     case "6":
                     fromdate.setMonth(0);
                     fromdate.setDate(1);
                     break;
                     case "7":
                     var d = todate.getDay()
                     if( d == 0 ) { d = 7 }
                     todate.setTime(todate.getTime() - ( d * ONE_DAY ) );
                     fromdate.setTime(todate.getTime() - ( 6 * ONE_DAY ) );
                     break;
                     case "8":
                     todate.setDate(1);
                     todate.setTime(todate.getTime() - ONE_DAY );
                     fromdate.setTime(todate.getTime());
                     fromdate.setDate(1);
                     break;
                     case "9":
                     fromdate.setTime(fromdate.getTime() - ( 6 * ONE_DAY) );
                     break;
                     case "10":
                     fromdate.setTime(fromdate.getTime() - ( 30 * ONE_DAY) );
                     break;
                     case "11":
                     fromdate.setTime(fromdate.getTime() - ( 60 * ONE_DAY) );
                     break;
                     case "12":
                     fromdate.setTime(fromdate.getTime() - ( 90 * ONE_DAY) );
                     break;
                     }
                     if(term!=1){document.getElementById('FromDate').value = fromdate.getMonth()+1 + "/" + fromdate.getDate() + "/" + fromdate.getFullYear();}
                     document.getElementById('ToDate').value = todate.getMonth()+1 + "/" + todate.getDate() + "/" + todate.getFullYear();
                  ]]></xsl:text></xsl:attribute>
                                 <xsl:variable name="tmp"><xsl:value-of select="/DATA/PARAM/@term"/></xsl:variable>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">1</xsl:attribute>
                                    <xsl:if test="$tmp='1'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">2</xsl:attribute>
                                    <xsl:if test="$tmp='2'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Today']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">3</xsl:attribute>
                                    <xsl:if test="$tmp='3'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Yesterday']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">9</xsl:attribute>
                                    <xsl:if test="$tmp='9'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Prev7']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">10</xsl:attribute>
                                    <xsl:if test="$tmp='10'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Prev30']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">4</xsl:attribute>
                                    <xsl:if test="$tmp='4'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ThisWeek']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">5</xsl:attribute>
                                    <xsl:if test="$tmp='5'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ThisMonth']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">6</xsl:attribute>
                                    <xsl:if test="$tmp='6'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ThisYear']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">7</xsl:attribute>
                                    <xsl:if test="$tmp='7'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LastWeek']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">8</xsl:attribute>
                                    <xsl:if test="$tmp='8'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LastMonth']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">11</xsl:attribute>
                                    <xsl:if test="$tmp='11'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Prev60']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">12</xsl:attribute>
                                    <xsl:if test="$tmp='12'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Prev90']"/>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='from']"/>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">FromDate</xsl:attribute>
                              <xsl:attribute name="id">FromDate</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@fromdate"/></xsl:attribute>
                              <xsl:attribute name="size">8</xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="IMG">
                                 <xsl:attribute name="name">Calendar</xsl:attribute>
                                 <xsl:attribute name="src">Images/Calendar.gif</xsl:attribute>
                                 <xsl:attribute name="width">16</xsl:attribute>
                                 <xsl:attribute name="height">16</xsl:attribute>
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="onclick">CalendarPopup(document.forms[0], document.getElementById('FromDate'))</xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='to']"/>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">ToDate</xsl:attribute>
                              <xsl:attribute name="id">ToDate</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@todate"/></xsl:attribute>
                              <xsl:attribute name="size">8</xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="IMG">
                                 <xsl:attribute name="name">Calendar</xsl:attribute>
                                 <xsl:attribute name="src">Images/Calendar.gif</xsl:attribute>
                                 <xsl:attribute name="width">16</xsl:attribute>
                                 <xsl:attribute name="height">16</xsl:attribute>
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="onclick">CalendarPopup(document.forms[0], document.getElementById('ToDate'))</xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">submit</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='View']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick">doSubmit(1,"")</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">800</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">800</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">250</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">250</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">250</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                          <xsl:element name="TABLE">
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="cellpadding">0</xsl:attribute>
                                             <xsl:attribute name="cellspacing">0</xsl:attribute>
                                             <xsl:attribute name="width">300</xsl:attribute>
                                             <xsl:attribute name="style">border: 1px #7589a6 solid</xsl:attribute>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">300</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">2</xsl:attribute>
                                                      <xsl:attribute name="width">300</xsl:attribute>
                                                      <xsl:attribute name="height">18</xsl:attribute>
                                                      <xsl:attribute name="bgcolor">#7589a6</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">middle</xsl:attribute>
                                                         <xsl:element name="b">
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="color">white</xsl:attribute>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CurrentTrack']"/>
                                                         </xsl:element>
                                                         </xsl:element>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">300</xsl:attribute>
                                                      <xsl:attribute name="bgcolor">white</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="size">3</xsl:attribute>
                                                         <xsl:attribute name="color">purple</xsl:attribute>
                                                      <xsl:if test="(/DATA/PARAM/@theme = 0)">
                                                            <xsl:if test="(/DATA/PARAM/@track = 1)">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Track1']"/>
                                                            </xsl:if>
                                                            <xsl:if test="(/DATA/PARAM/@track = 2)">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Track2']"/>
                                                            </xsl:if>
                                                            <xsl:if test="(/DATA/PARAM/@track = 3)">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Track3']"/>
                                                            </xsl:if>
                                                            <xsl:if test="(/DATA/PARAM/@track = 4)">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Track4']"/>
                                                            </xsl:if>
                                                            <xsl:if test="(/DATA/PARAM/@track = 5)">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Track5']"/>
                                                            </xsl:if>
                                                      </xsl:if>
                                                      <xsl:if test="(/DATA/PARAM/@theme = 1)">
                                                            <xsl:if test="(/DATA/PARAM/@track = 1)">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Track1a']"/>
                                                            </xsl:if>
                                                            <xsl:if test="(/DATA/PARAM/@track = 2)">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Track2a']"/>
                                                            </xsl:if>
                                                            <xsl:if test="(/DATA/PARAM/@track = 3)">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Track3a']"/>
                                                            </xsl:if>
                                                            <xsl:if test="(/DATA/PARAM/@track = 4)">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Track4a']"/>
                                                            </xsl:if>
                                                            <xsl:if test="(/DATA/PARAM/@track = 5)">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Track5a']"/>
                                                            </xsl:if>
                                                      </xsl:if>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Ranking']"/>
                                                         <xsl:value-of select="/DATA/PARAM/@rank" disable-output-escaping="yes"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                </xsl:element>

                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">250</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>

                              </xsl:element>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">800</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">800</xsl:attribute>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="align">center</xsl:attribute>
                                       <xsl:attribute name="width">15%</xsl:attribute>
                                       <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                       <xsl:attribute name="valign">Bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Qty']"/>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="align">center</xsl:attribute>
                                       <xsl:attribute name="width">15%</xsl:attribute>
                                       <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                       <xsl:attribute name="valign">Bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Points']"/>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="width">70%</xsl:attribute>
                                       <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                       <xsl:attribute name="valign">Bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MetricTypeName']"/>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">3</xsl:attribute>
                                       <xsl:attribute name="height">2</xsl:attribute>
                                       <xsl:attribute name="bgcolor">#CCCCCC</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>

                                 <xsl:for-each select="/DATA/TXN/PTSMETRICS/PTSMETRIC">
                                    <xsl:element name="TR">
                                       <xsl:attribute name="height">30</xsl:attribute>
                                       <xsl:if test="(position() mod 2)=1">
                                          <xsl:attribute name="class">GrayBar</xsl:attribute>
                                       </xsl:if>
                                       <xsl:if test="(position() mod 2)=0">
                                          <xsl:attribute name="class">WhiteBar</xsl:attribute>
                                       </xsl:if>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="@qty"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="@points"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="@metrictypename"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:element name="A">
                                                <xsl:attribute name="href">11713.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;MetricTypeID=<xsl:value-of select="@metrictypeid"/>&amp;FromDate=<xsl:value-of select="/DATA/PARAM/@fromdate"/>&amp;ToDate=<xsl:value-of select="/DATA/PARAM/@todate"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/Preview24.gif</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/></xsl:attribute>
                                                   <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/></xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:for-each>
                                 <xsl:choose>
                                    <xsl:when test="(count(/DATA/TXN/PTSMETRICS/PTSMETRIC) = 0)">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">3</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="class">NoItems</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoItems']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:when>
                                 </xsl:choose>

                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">3</xsl:attribute>
                                       <xsl:attribute name="height">2</xsl:attribute>
                                       <xsl:attribute name="bgcolor">#CCCCCC</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>

                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">90</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">90</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">420</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">90</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TotalPoints']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">90</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          <xsl:value-of select="/DATA/PARAM/@total" disable-output-escaping="yes"/>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">420</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='in']"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/PARAM/@days" disable-output-escaping="yes"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='days']"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ontrack']"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/PARAM/@days30" disable-output-escaping="yes"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='in30Days']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">800</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">button</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LoggedActivities']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick">doSubmit(3,"")</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">800</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">800</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">295</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">210</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">295</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">295</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">210</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                          <xsl:element name="TABLE">
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="cellpadding">0</xsl:attribute>
                                             <xsl:attribute name="cellspacing">0</xsl:attribute>
                                             <xsl:attribute name="width">210</xsl:attribute>
                                             <xsl:attribute name="style">border: 1px #7589a6 solid</xsl:attribute>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">90</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">120</xsl:attribute>
                                                      <xsl:attribute name="align">left</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">2</xsl:attribute>
                                                      <xsl:attribute name="width">210</xsl:attribute>
                                                      <xsl:attribute name="height">18</xsl:attribute>
                                                      <xsl:attribute name="bgcolor">#7589a6</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">middle</xsl:attribute>
                                                         <xsl:element name="b">
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="color">white</xsl:attribute>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MonthlyTracks']"/>
                                                         </xsl:element>
                                                         </xsl:element>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">90</xsl:attribute>
                                                      <xsl:attribute name="bgcolor">#ffffff</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">004080</xsl:attribute>
                                                         <xsl:value-of select="concat(/DATA/PARAM/@frompts1,'-',/DATA/PARAM/@topts1,' pts.')"/>
                                                         <xsl:element name="BR"/>
                                                         <xsl:value-of select="concat(/DATA/PARAM/@frompts2,'-',/DATA/PARAM/@topts2,' pts.')"/>
                                                         <xsl:element name="BR"/>
                                                         <xsl:value-of select="concat(/DATA/PARAM/@frompts3,'-',/DATA/PARAM/@topts3,' pts.')"/>
                                                         <xsl:element name="BR"/>
                                                         <xsl:value-of select="concat(/DATA/PARAM/@frompts4,'-',/DATA/PARAM/@topts4,' pts.')"/>
                                                         <xsl:element name="BR"/>
                                                         <xsl:value-of select="concat(/DATA/PARAM/@frompts5,'+ pts.')"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">120</xsl:attribute>
                                                      <xsl:attribute name="bgcolor">#ffffff</xsl:attribute>
                                                      <xsl:attribute name="align">left</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">004080</xsl:attribute>
                                                      <xsl:if test="(/DATA/PARAM/@theme = 0)">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Track1']"/>
                                                            <xsl:element name="BR"/>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Track2']"/>
                                                            <xsl:element name="BR"/>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Track3']"/>
                                                            <xsl:element name="BR"/>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Track4']"/>
                                                            <xsl:element name="BR"/>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Track5']"/>
                                                      </xsl:if>
                                                      <xsl:if test="(/DATA/PARAM/@theme = 1)">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Track1a']"/>
                                                            <xsl:element name="BR"/>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Track2a']"/>
                                                            <xsl:element name="BR"/>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Track3a']"/>
                                                            <xsl:element name="BR"/>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Track4a']"/>
                                                            <xsl:element name="BR"/>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Track5a']"/>
                                                      </xsl:if>
                                                      </xsl:element>
                                                   </xsl:element>
                                                </xsl:element>

                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">295</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>

                              </xsl:element>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

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