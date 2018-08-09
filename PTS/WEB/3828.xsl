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
         <xsl:with-param name="pagename" select="'Admin Processing'"/>
         <xsl:with-param name="includecalendar" select="true()"/>
         <xsl:with-param name="htmleditor"></xsl:with-param>
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
               <xsl:attribute name="name">Company</xsl:attribute>
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

               <xsl:element name="TR">

                  <xsl:element name="TD">
                     <xsl:attribute name="width">10</xsl:attribute>
                  </xsl:element>

                  <xsl:element name="TD">
                     <xsl:attribute name="valign">top</xsl:attribute>
                     <xsl:attribute name="width">600</xsl:attribute>

                     <xsl:element name="TABLE">
                        <xsl:attribute name="border">0</xsl:attribute>
                        <xsl:attribute name="cellpadding">0</xsl:attribute>
                        <xsl:attribute name="cellspacing">0</xsl:attribute>
                        <xsl:attribute name="width">600</xsl:attribute>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">600</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/PARAM/@result != '')">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:element name="font">
                                    <xsl:attribute name="color">blue</xsl:attribute>
                                 <xsl:value-of select="/DATA/PARAM/@result" disable-output-escaping="yes"/>
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
                                 <xsl:attribute name="height">1</xsl:attribute>
                                 <xsl:attribute name="bgcolor">#004080</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">24</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:if test="(/DATA/PARAM/@mode = 0)">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NotAvailable']"/>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/PARAM/@mode = 1)">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CalcTraining']"/>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/PARAM/@mode = 2)">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CalcMonthly']"/>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/PARAM/@mode = 3)">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CreatePayouts']"/>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/PARAM/@mode = 4)">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PaidPayouts']"/>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/PARAM/@mode = 5)">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CalcReferrals']"/>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/PARAM/@mode = 6)">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CalcAdvancement']"/>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/PARAM/@mode = 7)">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PostReferrals']"/>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/PARAM/@mode = 8)">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='QualifyMembers']"/>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/PARAM/@mode = 9)">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ExportPayouts']"/>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/PARAM/@mode = 10)">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PaymentCredits']"/>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/PARAM/@mode = 14)">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='DeclinedPayments']"/>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/PARAM/@mode = 15)">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IntroUpgrades']"/>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/PARAM/@mode = 16)">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='QualifyChecks']"/>
                                 </xsl:if>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/PARAM/@mode = 1) or (/DATA/PARAM/@mode = 2)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='From']"/>
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
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='To']"/>
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
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="(/DATA/PARAM/@mode = 3) or (/DATA/PARAM/@mode = 4) or (/DATA/PARAM/@mode = 7) or (/DATA/PARAM/@mode = 8) or (/DATA/PARAM/@mode = 9)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
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
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="(/DATA/PARAM/@result != '')">
                           <xsl:if test="(/DATA/PARAM/@mode = 14)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">1</xsl:attribute>
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                              </xsl:element>

                              <xsl:for-each select="/DATA/TXN/PTSMEMBERS/PTSMEMBER">
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="src">Images/Status<xsl:value-of select="@level"/>.gif</xsl:attribute>
                                                <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="SIGNATURE/comment()" disable-output-escaping="yes"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:element name="A">
                                                <xsl:attribute name="onclick">w=window.open(this.href,"Member","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                <xsl:attribute name="href">0403.asp?MemberID=<xsl:value-of select="@status"/>&amp;ContentPage=3&amp;Popup=1</xsl:attribute>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/Edit.gif</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/></xsl:attribute>
                                                   <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/></xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:element name="A">
                                                <xsl:attribute name="onclick">w=window.open(this.href,"Finances","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                <xsl:attribute name="href">0475.asp?MemberID=<xsl:value-of select="@status"/>&amp;Code=2&amp;ContentPage=3&amp;Popup=1</xsl:attribute>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/financesm.gif</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='finances']"/></xsl:attribute>
                                                   <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='finances']"/></xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                              </xsl:for-each>
                           </xsl:if>
                        </xsl:if>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@mode != 0)">
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Process']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick">doSubmit(1,"")</xsl:attribute>
                                 </xsl:element>
                              </xsl:if>
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

      </xsl:element>
      </xsl:element>
      <!--END BODY-->

      </xsl:element>

   </xsl:template>
</xsl:stylesheet>