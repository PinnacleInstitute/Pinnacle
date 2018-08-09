<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
   <xsl:include href="HTMLHeading.xsl"/>
   <xsl:include href="PageHeader.xsl"/>
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
         <xsl:with-param name="pagename" select="'Day View'"/>
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
            <xsl:attribute name="width">750</xsl:attribute>
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

               <!--HEADER ROW-->
               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="colspan">2</xsl:attribute>
                     <xsl:call-template name="PageHeader"/>
                  </xsl:element>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function EditAppt(id){ 
               var url, win;
               url = "4803.asp?apptid=" + id
               win = window.open(url,"Appt","top=100,left=100,height=400,width=550,status=no,toolbar=no,menubar=no,location=no,titlebar=no");
               win.focus();
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function EditOther(typ,id){ 
               var url, win;
               switch (typ)
               {
               case -70:
                  url = "7003.asp?goalid=" + id + " &popup=1"
                  break
               case -22:
                  url = "2203.asp?leadid=" + id + " &popup=1"
                  break
               case -81:
                  url = "8103.asp?prospectid=" + id + " &popup=1"
                  break
               case -90:
                  url = "9003.asp?noteid=" + id + " &popup=1"
                  break
               case -96:
                  url = "9603.asp?eventid=" + id + " &popup=1"
                  break
               case -13:
                  url = "1330.asp?sessionid=" + id + " &popup=1"
                  break
               case -31:
                  url = "3460.asp?memberassessid=" + id + " &popup=1"
                  break
               case -75:
                  url = "7503.asp?projectid=" + id + " &popup=1"
                  break
               case -74:
                  url = "7403.asp?taskid=" + id + " &popup=1"
                  break
               }
                  win = window.open(url,null);
               win.focus();
             }]]></xsl:text>
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
                              <xsl:attribute name="name">Date</xsl:attribute>
                              <xsl:attribute name="id">Date</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@date"/></xsl:attribute>
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

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">750</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeading</xsl:attribute>
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

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">750</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#004080</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">750</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeading</xsl:attribute>
                              <xsl:value-of select="/DATA/PARAM/@title" disable-output-escaping="yes"/>
                           </xsl:element>
                        </xsl:element>

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
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="width">100%</xsl:attribute>
                                       <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                       <xsl:attribute name="valign">Bottom</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="height">2</xsl:attribute>
                                       <xsl:attribute name="bgcolor">#CCCCCC</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>

                                 <xsl:for-each select="/DATA/TXN/PTSAPPTS/PTSAPPT">
                                    <xsl:sort select="@reminder" data-type="number"/>
                                    <xsl:sort select="@apptname"/>
                                    <xsl:element name="TR">
                                       <xsl:if test="(position() mod 2)=1">
                                          <xsl:attribute name="class">GrayBar</xsl:attribute>
                                       </xsl:if>
                                       <xsl:if test="(position() mod 2)=0">
                                          <xsl:attribute name="class">WhiteBar</xsl:attribute>
                                       </xsl:if>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="src">Images/appt<xsl:value-of select="@appttype"/>.gif</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                             </xsl:element>
                                          <xsl:if test="(@isplan != 0)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/plan.gif</xsl:attribute>
                                                   <xsl:attribute name="align">top</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(@recur != 0)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/recur.gif</xsl:attribute>
                                                   <xsl:attribute name="align">top</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                </xsl:element>
                                          </xsl:if>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                          <xsl:if test="(@importance = 1)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/apptlow.gif</xsl:attribute>
                                                   <xsl:attribute name="align">top</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ImportanceLow']"/></xsl:attribute>
                                                   <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ImportanceLow']"/></xsl:attribute>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(@importance = 3)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/appthigh.gif</xsl:attribute>
                                                   <xsl:attribute name="align">top</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ImportanceHigh']"/></xsl:attribute>
                                                   <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ImportanceHigh']"/></xsl:attribute>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(@show = 2)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/apptprivate.gif</xsl:attribute>
                                                   <xsl:attribute name="align">top</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ShowPrivate']"/></xsl:attribute>
                                                   <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ShowPrivate']"/></xsl:attribute>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(@show = 3)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/apptbusy.gif</xsl:attribute>
                                                   <xsl:attribute name="align">top</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ShowBusy']"/></xsl:attribute>
                                                   <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ShowBusy']"/></xsl:attribute>
                                                </xsl:element>
                                          </xsl:if>
                                             <xsl:element name="b">
                                             <xsl:if test="(@appttype &gt;= 0)">
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:if test="(/DATA/PARAM/@edit = 0)">
                                                      <xsl:if test="(@opt = '0')">
                                                         <xsl:value-of select="@apptname"/>
                                                      </xsl:if>
                                                      <xsl:if test="(@opt = '1')">
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="color">purple</xsl:attribute>
                                                         <xsl:value-of select="@apptname"/>
                                                         </xsl:element>
                                                      </xsl:if>
                                                      <xsl:if test="(@opt = '2')">
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="color">red</xsl:attribute>
                                                         <xsl:value-of select="@apptname"/>
                                                         </xsl:element>
                                                      </xsl:if>
                                                </xsl:if>
                                                <xsl:if test="(/DATA/PARAM/@edit = 1)">
                                                      <xsl:if test="(@opt = '0')">
                                                         <xsl:element name="A">
                                                            <xsl:attribute name="href">#_</xsl:attribute>
                                                            <xsl:attribute name="onclick">EditAppt(<xsl:value-of select="@apptid"/>)</xsl:attribute>
                                                         <xsl:value-of select="@apptname"/>
                                                         </xsl:element>
                                                      </xsl:if>
                                                      <xsl:if test="(@opt = '1')">
                                                         <xsl:element name="A">
                                                            <xsl:attribute name="href">#_</xsl:attribute>
                                                            <xsl:attribute name="onclick">EditAppt(<xsl:value-of select="@apptid"/>)</xsl:attribute>
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="color">purple</xsl:attribute>
                                                         <xsl:value-of select="@apptname"/>
                                                         </xsl:element>
                                                         </xsl:element>
                                                      </xsl:if>
                                                      <xsl:if test="(@opt = '2')">
                                                         <xsl:element name="A">
                                                            <xsl:attribute name="href">#_</xsl:attribute>
                                                            <xsl:attribute name="onclick">EditAppt(<xsl:value-of select="@apptid"/>)</xsl:attribute>
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="color">red</xsl:attribute>
                                                         <xsl:value-of select="@apptname"/>
                                                         </xsl:element>
                                                         </xsl:element>
                                                      </xsl:if>
                                                </xsl:if>
                                             </xsl:if>
                                             <xsl:if test="(@appttype = -70) or (@appttype = -701)">
                                                <xsl:if test="(@status != 2) and (@status != 3)">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="href">#_</xsl:attribute>
                                                         <xsl:attribute name="onclick">EditOther(-70, <xsl:value-of select="@apptid"/>)</xsl:attribute>
                                                      <xsl:value-of select="@apptname"/>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(@status = 3)">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/greenchecksm.gif</xsl:attribute>
                                                         <xsl:attribute name="align">top</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="href">#_</xsl:attribute>
                                                         <xsl:attribute name="onclick">EditOther(-70, <xsl:value-of select="@apptid"/>)</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">green</xsl:attribute>
                                                      <xsl:value-of select="@apptname"/>
                                                      </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(@status = 2)">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/redchecksm.gif</xsl:attribute>
                                                         <xsl:attribute name="align">top</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
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
                                                      <xsl:attribute name="align">top</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
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
                                                         <xsl:attribute name="align">top</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(@status = 2)">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/Appt3.gif</xsl:attribute>
                                                         <xsl:attribute name="align">top</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                </xsl:if>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
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
                                                         <xsl:attribute name="align">top</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                </xsl:if>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
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
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="href">#_</xsl:attribute>
                                                      <xsl:attribute name="onclick">EditOther(-96, <xsl:value-of select="@apptid"/>)</xsl:attribute>
                                                   <xsl:value-of select="@apptname"/>
                                                   </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(@appttype = -13)">
                                                <xsl:if test="(@status != 6) and (@status != 7)">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="href">#_</xsl:attribute>
                                                         <xsl:attribute name="onclick">EditOther(-13, <xsl:value-of select="@apptid"/>)</xsl:attribute>
                                                      <xsl:value-of select="@apptname"/>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(@status = 6)">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/greenchecksm.gif</xsl:attribute>
                                                         <xsl:attribute name="align">top</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="href">#_</xsl:attribute>
                                                         <xsl:attribute name="onclick">EditOther(-13, <xsl:value-of select="@apptid"/>)</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">green</xsl:attribute>
                                                      <xsl:value-of select="@apptname"/>
                                                      </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(@status = 7)">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/redchecksm.gif</xsl:attribute>
                                                         <xsl:attribute name="align">top</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
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
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="href">#_</xsl:attribute>
                                                         <xsl:attribute name="onclick">EditOther(-31, <xsl:value-of select="@apptid"/>)</xsl:attribute>
                                                      <xsl:value-of select="@apptname"/>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(@status = 1)">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/greenchecksm.gif</xsl:attribute>
                                                         <xsl:attribute name="align">top</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="href">#_</xsl:attribute>
                                                         <xsl:attribute name="onclick">EditOther(-31, <xsl:value-of select="@apptid"/>)</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">green</xsl:attribute>
                                                      <xsl:value-of select="@apptname"/>
                                                      </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(@status = 2)">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/redchecksm.gif</xsl:attribute>
                                                         <xsl:attribute name="align">top</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
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
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="href">#_</xsl:attribute>
                                                         <xsl:attribute name="onclick">EditOther(-75, <xsl:value-of select="@apptid"/>)</xsl:attribute>
                                                      <xsl:value-of select="@apptname"/>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(@status = 2)">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/greenchecksm.gif</xsl:attribute>
                                                         <xsl:attribute name="align">top</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="href">#_</xsl:attribute>
                                                         <xsl:attribute name="onclick">EditOther(-75, <xsl:value-of select="@apptid"/>)</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">green</xsl:attribute>
                                                      <xsl:value-of select="@apptname"/>
                                                      </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(@status = 1)">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/redchecksm.gif</xsl:attribute>
                                                         <xsl:attribute name="align">top</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
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
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="href">#_</xsl:attribute>
                                                         <xsl:attribute name="onclick">EditOther(-74, <xsl:value-of select="@apptid"/>)</xsl:attribute>
                                                      <xsl:value-of select="@apptname"/>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(@status = 2)">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/greenchecksm.gif</xsl:attribute>
                                                         <xsl:attribute name="align">top</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="href">#_</xsl:attribute>
                                                         <xsl:attribute name="onclick">EditOther(-74, <xsl:value-of select="@apptid"/>)</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">green</xsl:attribute>
                                                      <xsl:value-of select="@apptname"/>
                                                      </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(@status = 1)">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/redchecksm.gif</xsl:attribute>
                                                         <xsl:attribute name="align">top</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
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
                                             </xsl:element>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:if test="(@location != '') or (@note != '')">
                                       <xsl:element name="TR">
                                          <xsl:if test="(position() mod 2)=1">
                                             <xsl:attribute name="class">GrayBar</xsl:attribute>
                                          </xsl:if>
                                          <xsl:if test="(position() mod 2)=0">
                                             <xsl:attribute name="class">WhiteBar</xsl:attribute>
                                          </xsl:if>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="@location"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="@note" disable-output-escaping="yes"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:if>
                                 </xsl:for-each>
                                 <xsl:choose>
                                    <xsl:when test="(count(/DATA/TXN/PTSAPPTS/PTSAPPT) = 0)">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">1</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="class">NoItems</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoItems']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:when>
                                 </xsl:choose>

                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
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
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">button</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Refresh']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[doSubmit(0,"")]]></xsl:text></xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">button</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Close']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[window.close()]]></xsl:text></xsl:attribute>
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