<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
   <xsl:include href="HTMLHeading.xsl"/>
   <xsl:include href="PageHeader.xsl"/>
   <xsl:include href="PageFooter.xsl"/>
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
         <xsl:with-param name="pagename" select="'Training Buddy'"/>
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
               <xsl:attribute name="name">Member</xsl:attribute>
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

               <!--HEADER ROW-->
               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="colspan">2</xsl:attribute>
                     <xsl:if test="/DATA/PARAM/@contentpage!=1 and /DATA/PARAM/@contentpage!=3">
                        <xsl:call-template name="PageHeader"/>
                     </xsl:if>
                  </xsl:element>
               </xsl:element>

               <xsl:element name="TR">

                  <xsl:if test="/DATA/PARAM/@contentpage!=1">
                     <xsl:element name="TD">
                        <xsl:attribute name="width">10</xsl:attribute>
                     </xsl:element>
                  </xsl:if>
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
                              <xsl:attribute name="width">200</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">400</xsl:attribute>
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
                              <xsl:attribute name="width">200</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">middle</xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@tbpage != '')">
                                    <xsl:element name="b">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ClickMe']"/>
                                    </xsl:element>
                                    <xsl:element name="A">
                                       <xsl:attribute name="onclick">w=window.open(this.href,"TB","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                       <xsl:attribute name="href">3815.asp?CompanyID=<xsl:value-of select="/DATA/TXN/PTSCOMPANY/@companyid"/>&amp;Page=<xsl:value-of select="/DATA/PARAM/@tbpage"/></xsl:attribute>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/IconG.gif</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                          <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TBInfo']"/></xsl:attribute>
                                          <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TBInfo']"/></xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                              </xsl:if>
                              <xsl:if test="(/DATA/PARAM/@tbpage = '')">
                                    <xsl:element name="IMG">
                                       <xsl:attribute name="src">Images/IconG.gif</xsl:attribute>
                                       <xsl:attribute name="border">0</xsl:attribute>
                                    </xsl:element>
                              </xsl:if>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">400</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="b">
                                 <xsl:element name="font">
                                    <xsl:attribute name="size">3</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Good']"/>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:if test="(/DATA/PARAM/@time = 1)">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EarlyMorning']"/>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    </xsl:if>
                                    <xsl:if test="(/DATA/PARAM/@time = 2)">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Morning']"/>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    </xsl:if>
                                    <xsl:if test="(/DATA/PARAM/@time = 3)">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Afternoon']"/>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    </xsl:if>
                                    <xsl:if test="(/DATA/PARAM/@time = 4)">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Evening']"/>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    </xsl:if>
                                    <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namefirst"/>
                                    <xsl:element name="BR"/>
                                 </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="b">
                                 <xsl:if test="(/DATA/PARAM/@visit = 0)">
                                       <xsl:element name="font">
                                          <xsl:attribute name="color">darkgreen</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='VisitFirst']"/>
                                       </xsl:element>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/PARAM/@visit = 1)">
                                       <xsl:element name="font">
                                          <xsl:attribute name="color">darkgreen</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Visit1Day']"/>
                                       </xsl:element>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/PARAM/@visit = 2)">
                                       <xsl:element name="font">
                                          <xsl:attribute name="color">darkblue</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Visit4Day']"/>
                                       </xsl:element>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/PARAM/@visit = 3)">
                                       <xsl:element name="font">
                                          <xsl:attribute name="color">darkcyan</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Visit7Day']"/>
                                       </xsl:element>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/PARAM/@visit = 4)">
                                       <xsl:element name="font">
                                          <xsl:attribute name="color">saddlebrown</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Visit14Day']"/>
                                       </xsl:element>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/PARAM/@visit = 5)">
                                       <xsl:element name="font">
                                          <xsl:attribute name="color">orangered</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Visit30Day']"/>
                                       </xsl:element>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/PARAM/@visit = 6)">
                                       <xsl:element name="font">
                                          <xsl:attribute name="color">red</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Visit31Day']"/>
                                       </xsl:element>
                                 </xsl:if>
                                 </xsl:element>
                                 <xsl:element name="BR"/>
                              <xsl:if test="(/DATA/PARAM/@visit != 0)">
                                    <xsl:element name="font">
                                       <xsl:attribute name="size">1</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LastVisit']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    </xsl:element>
                                    <xsl:element name="font">
                                       <xsl:attribute name="size">1</xsl:attribute>
                                    <xsl:value-of select="/DATA/PARAM/@visitdate" disable-output-escaping="yes"/>
                                    </xsl:element>
                                    <xsl:element name="BR"/><xsl:element name="BR"/>
                              </xsl:if>
                                 <xsl:element name="b">
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CustomerSupport']"/>
                                 </xsl:element>
                                 <xsl:element name="BR"/>
                                 <xsl:if test="(/DATA/TXN/PTSBUSINESS/@customeremail != '')">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Email']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:value-of select="/DATA/TXN/PTSBUSINESS/@customeremail"/>
                                    <xsl:element name="BR"/>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/TXN/PTSBUSINESS/@phone != '')">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Phone']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:value-of select="/DATA/TXN/PTSBUSINESS/@phone"/>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/TXN/PTSBUSINESS/@fax != '')">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Fax']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:value-of select="/DATA/TXN/PTSBUSINESS/@fax"/>
                                    <xsl:element name="BR"/>
                                 </xsl:if>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#004080</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">prompt</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TraingBuddyText']"/>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#004080</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">3</xsl:attribute>
                                          <xsl:attribute name="height">12</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="bgcolor">Green</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          <xsl:element name="font">
                                             <xsl:attribute name="color">white</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='YourExpectations']"/>
                                          </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="bgcolor">palegreen</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSTB/@goaltotal"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:element name="A">
                                                <xsl:attribute name="href">7001.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GoalTotal']"/>
                                             <xsl:element name="BR"/>
                                             </xsl:element>
                                          <xsl:if test="(/DATA/TXN/PTSTB/@goaldeclare != 0)">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSTB/@goaldeclare"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">7001.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GoalDeclare']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSTB/@goalcommit != 0)">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSTB/@goalcommit"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">7001.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GoalCommit']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSTB/@goalcomplete != 0)">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSTB/@goalcomplete"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">7001.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GoalComplete']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSTB/@goalearly != 0)">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSTB/@goalearly"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">7001.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GoalEarly']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSTB/@goalontime != 0)">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSTB/@goalontime"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">7001.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GoalOntime']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSTB/@goallate != 0)">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSTB/@goallate"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">7001.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GoalLate']"/>
                                                </xsl:element>
                                          </xsl:if>
                                       </xsl:element>
                                    </xsl:element>

                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">30</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">260</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">20</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">260</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">30</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">5</xsl:attribute>
                                          <xsl:attribute name="height">12</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">30</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">260</xsl:attribute>
                                          <xsl:attribute name="bgcolor">Green</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          <xsl:element name="font">
                                             <xsl:attribute name="color">white</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SinceVisit']"/>
                                          </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">20</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">260</xsl:attribute>
                                          <xsl:attribute name="bgcolor">Green</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          <xsl:element name="font">
                                             <xsl:attribute name="color">white</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Since30']"/>
                                          </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">30</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">260</xsl:attribute>
                                          <xsl:attribute name="bgcolor">palegreen</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                          <xsl:if test="(/DATA/TXN/PTSTB/@companycoursevisit = 0) and (/DATA/TXN/PTSTB/@publiccoursevisit = 0) and (/DATA/TXN/PTSTB/@companyassessmentvisit = 0) and (/DATA/TXN/PTSTB/@publicassessmentvisit = 0) and (/DATA/TXN/PTSTB/@surveyvisit = 0) and (/DATA/TXN/PTSTB/@suggestionvisit = 0) and (/DATA/TXN/PTSTB/@messagevisit = 0) and (/DATA/TXN/PTSTB/@favoriteccvisit = 0) and (/DATA/TXN/PTSTB/@favoritepcvisit = 0) and (/DATA/TXN/PTSTB/@favoritempvisit = 0) and (/DATA/TXN/PTSTB/@favoritemrvisit = 0)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoVisit']"/>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSTB/@companycoursevisit &gt; 0)">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSTB/@companycoursevisit"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">1118.asp?CompanyID=<xsl:value-of select="/DATA/TXN/PTSMEMBER/@companyid"/>&amp;MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;CourseDate=<xsl:value-of select="/DATA/PARAM/@visitdate"/>&amp;Mode=1&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CompanyCourseVisit']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSTB/@publiccoursevisit &gt; 0)">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSTB/@publiccoursevisit"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">1118.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;CourseDate=<xsl:value-of select="/DATA/PARAM/@visitdate"/>&amp;Mode=3&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PublicCoursevisit']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSTB/@companyassessmentvisit &gt; 0)">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSTB/@companyassessmentvisit"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">3112.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;VisitDate=<xsl:value-of select="/DATA/PARAM/@visitdate"/>&amp;Mode=9&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CompanyAssessmentVisit']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSTB/@publicassessmentvisit &gt; 0)">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSTB/@publicassessmentvisit"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">3112.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;VisitDate=<xsl:value-of select="/DATA/PARAM/@visitdate"/>&amp;Mode=13&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PublicAssessmentVisit']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSTB/@surveyvisit &gt; 0)">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSTB/@surveyvisit"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">4012.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;VisitDate=<xsl:value-of select="/DATA/PARAM/@visitdate"/>&amp;Mode=3&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SurveyVisit']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSTB/@suggestionvisit &gt; 0)">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSTB/@suggestionvisit"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">4512.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;SuggestionDate=<xsl:value-of select="/DATA/PARAM/@visitdate"/>&amp;Mode=3&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SuggestionVisit']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSTB/@messagevisit &gt; 0)">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSTB/@messagevisit"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">8412.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;VisitDate=<xsl:value-of select="/DATA/PARAM/@visitdate"/>&amp;Mode=26&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MessageVisit']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSTB/@favoriteccvisit &gt; 0)">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSTB/@favoriteccvisit"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">4612.asp?CompanyID=<xsl:value-of select="/DATA/TXN/PTSMEMBER/@companyid"/>&amp;MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;RefType=2&amp;Mode=32&amp;VisitDate=<xsl:value-of select="/DATA/PARAM/@visitdate"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FavoriteCCVisit']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSTB/@favoritepcvisit &gt; 0)">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSTB/@favoritepcvisit"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">4612.asp?CompanyID=<xsl:value-of select="/DATA/TXN/PTSMEMBER/@companyid"/>&amp;MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;RefType=1&amp;Mode=34&amp;VisitDate=<xsl:value-of select="/DATA/PARAM/@visitdate"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FavoritePCVisit']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSTB/@favoritempvisit &gt; 0)">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSTB/@favoritempvisit"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">4612.asp?CompanyID=<xsl:value-of select="/DATA/TXN/PTSMEMBER/@companyid"/>&amp;MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;RefType=4&amp;Mode=36&amp;VisitDate=<xsl:value-of select="/DATA/PARAM/@visitdate"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FavoriteMPVisit']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSTB/@favoritemrvisit &gt; 0)">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSTB/@favoritemrvisit"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">4612.asp?CompanyID=<xsl:value-of select="/DATA/TXN/PTSMEMBER/@companyid"/>&amp;MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;RefType=4&amp;Mode=38&amp;VisitDate=<xsl:value-of select="/DATA/PARAM/@visitdate"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FavoriteMRVisit']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                          </xsl:if>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">20</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">260</xsl:attribute>
                                          <xsl:attribute name="bgcolor">palegreen</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                          <xsl:if test="(/DATA/TXN/PTSTB/@companycourse30 = 0) and (/DATA/TXN/PTSTB/@publiccourse30 = 0) and (/DATA/TXN/PTSTB/@companyassessment30 = 0) and (/DATA/TXN/PTSTB/@publicassessment30 = 0) and (/DATA/TXN/PTSTB/@survey30 = 0) and (/DATA/TXN/PTSTB/@suggestion30 = 0) and (/DATA/TXN/PTSTB/@message30 = 0) and (/DATA/TXN/PTSTB/@favoritecc30 = 0) and (/DATA/TXN/PTSTB/@favoritepc30 = 0) and (/DATA/TXN/PTSTB/@favoritemp30 = 0) and (/DATA/TXN/PTSTB/@favoritemr30 = 0)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='No30']"/>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSTB/@companycourse30 &gt; 0)">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSTB/@companycourse30"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">1118.asp?CompanyID=<xsl:value-of select="/DATA/TXN/PTSMEMBER/@companyid"/>&amp;MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;CourseDate=<xsl:value-of select="/DATA/PARAM/@date30"/>&amp;Mode=1&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CompanyCourse30']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSTB/@publiccourse30 &gt; 0)">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSTB/@publiccourse30"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">1118.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;CourseDate=<xsl:value-of select="/DATA/PARAM/@date30"/>&amp;Mode=3&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PublicCourse30']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSTB/@companyassessment30 &gt; 0)">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSTB/@companyassessment30"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">3112.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;VisitDate=<xsl:value-of select="/DATA/PARAM/@date30"/>&amp;Mode=10&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CompanyAssessment30']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSTB/@publicassessment30 &gt; 0)">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSTB/@publicassessment30"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">3112.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;VisitDate=<xsl:value-of select="/DATA/PARAM/@date30"/>&amp;Mode=14&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PublicAssessment30']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSTB/@survey30 &gt; 0)">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSTB/@survey30"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">4012.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;VisitDate=<xsl:value-of select="/DATA/PARAM/@date30"/>&amp;Mode=4&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Survey30']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSTB/@suggestion30 &gt; 0)">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSTB/@suggestion30"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">4512.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;SuggestionDate=<xsl:value-of select="/DATA/PARAM/@date30"/>&amp;Mode=4&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Suggestion30']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSTB/@message30 &gt; 0)">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSTB/@message30"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">8412.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;VisitDate=<xsl:value-of select="/DATA/PARAM/@date30"/>&amp;Mode=27&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Message30']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSTB/@favoritecc30 &gt; 0)">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSTB/@favoritecc30"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">4612.asp?CompanyID=<xsl:value-of select="/DATA/TXN/PTSMEMBER/@companyid"/>&amp;MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;RefType=2&amp;Mode=33&amp;VisitDate=<xsl:value-of select="/DATA/PARAM/@date30"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FavoriteCC30']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSTB/@favoritepc30 &gt; 0)">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSTB/@favoritepc30"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">4612.asp?CompanyID=<xsl:value-of select="/DATA/TXN/PTSMEMBER/@companyid"/>&amp;MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;RefType=1&amp;Mode=35&amp;VisitDate=<xsl:value-of select="/DATA/PARAM/@date30"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FavoritePC30']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSTB/@favoritemp30 &gt; 0)">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSTB/@favoritemp30"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">4612.asp?CompanyID=<xsl:value-of select="/DATA/TXN/PTSMEMBER/@companyid"/>&amp;MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;RefType=4&amp;Mode=37&amp;VisitDate=<xsl:value-of select="/DATA/PARAM/@date30"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FavoriteMP30']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSTB/@favoritemr30 &gt; 0)">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSTB/@favoritemr30"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">4612.asp?CompanyID=<xsl:value-of select="/DATA/TXN/PTSMEMBER/@companyid"/>&amp;MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;RefType=4&amp;Mode=39&amp;VisitDate=<xsl:value-of select="/DATA/PARAM/@date30"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FavoriteMR30']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                          </xsl:if>
                                       </xsl:element>
                                    </xsl:element>

                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">15</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">215</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">15</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">195</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">5</xsl:attribute>
                                          <xsl:attribute name="height">18</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="bgcolor">Navy</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="font">
                                             <xsl:attribute name="color">white</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='YourFavorites']"/>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">15</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">215</xsl:attribute>
                                          <xsl:attribute name="bgcolor">Navy</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="font">
                                             <xsl:attribute name="color">white</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='YourCourses']"/>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">15</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">195</xsl:attribute>
                                          <xsl:attribute name="bgcolor">Navy</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="font">
                                             <xsl:attribute name="color">white</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='YourAssessments']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="bgcolor">PaleTurquoise</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSTB/@favoritecompany"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:if test="(/DATA/TXN/PTSTB/@favoritecompany = 0)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FavoriteCompany']"/>
                                                <xsl:element name="BR"/>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSTB/@favoritecompany != 0)">
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">4612.asp?CompanyID=<xsl:value-of select="/DATA/TXN/PTSMEMBER/@companyid"/>&amp;MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;RefType=2&amp;Mode=28&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FavoriteCompany']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSTB/@favoritepublic"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:if test="(/DATA/TXN/PTSTB/@favoritepublic = 0)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FavoritePublic']"/>
                                                <xsl:element name="BR"/>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSTB/@favoritepublic != 0)">
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">4612.asp?CompanyID=<xsl:value-of select="/DATA/TXN/PTSMEMBER/@companyid"/>&amp;MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;RefType=1&amp;Mode=29&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FavoritePublic']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSTB/@favoritechat"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:if test="(/DATA/TXN/PTSTB/@favoritechat = 0)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FavoriteChat']"/>
                                                <xsl:element name="BR"/>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSTB/@favoritechat != 0)">
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">4612.asp?CompanyID=<xsl:value-of select="/DATA/TXN/PTSMEMBER/@companyid"/>&amp;MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;RefType=3&amp;Mode=30&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FavoriteChat']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSTB/@favoriteforum"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:if test="(/DATA/TXN/PTSTB/@favoriteforum = 0)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FavoriteForum']"/>
                                                <xsl:element name="BR"/>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSTB/@favoriteforum != 0)">
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">4612.asp?CompanyID=<xsl:value-of select="/DATA/TXN/PTSMEMBER/@companyid"/>&amp;MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;RefType=4&amp;Mode=31&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FavoriteForum']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                             </xsl:if>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">15</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">215</xsl:attribute>
                                          <xsl:attribute name="bgcolor">PaleTurquoise</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSTB/@companycoursetotal"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:if test="(/DATA/TXN/PTSTB/@companycoursetotal = 0)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CompanyCourseTotal']"/>
                                                <xsl:element name="BR"/>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSTB/@companycoursetotal != 0)">
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">1212.asp?CompanyID=<xsl:value-of select="/DATA/TXN/PTSMEMBER/@companyid"/>&amp;MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;Mode=2&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CompanyCourseTotal']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSTB/@companycourseunregister"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:if test="(/DATA/TXN/PTSTB/@companycourseunregister = 0)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CompanyCourseUnregister']"/>
                                                <xsl:element name="BR"/>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSTB/@companycourseunregister != 0)">
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">1118.asp?CompanyID=<xsl:value-of select="/DATA/TXN/PTSMEMBER/@companyid"/>&amp;MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;Mode=2&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CompanyCourseUnregister']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSTB/@companycourseregister"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:if test="(/DATA/TXN/PTSTB/@companycourseregister = 0)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CompanyCourseRegister']"/>
                                                <xsl:element name="BR"/>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSTB/@companycourseregister != 0)">
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">1311.asp?CompanyID=<xsl:value-of select="/DATA/TXN/PTSMEMBER/@companyid"/>&amp;MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CompanyCourseRegister']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSTB/@publiccourseregister"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:if test="(/DATA/TXN/PTSTB/@publiccourseregister = 0)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PublicCourseRegister']"/>
                                                <xsl:element name="BR"/>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSTB/@publiccourseregister != 0)">
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">1311.asp?CompanyID=<xsl:value-of select="/DATA/TXN/PTSMEMBER/@companyid"/>&amp;MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PublicCourseRegister']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                             </xsl:if>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">15</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">195</xsl:attribute>
                                          <xsl:attribute name="bgcolor">PaleTurquoise</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSTB/@companyassessmenttotal"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:if test="(/DATA/TXN/PTSTB/@companyassessmenttotal = 0)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CompanyAssessmentTotal']"/>
                                                <xsl:element name="BR"/>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSTB/@companyassessmenttotal != 0)">
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">3112.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;CompanyID=<xsl:value-of select="/DATA/TXN/PTSMEMBER/@companyid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CompanyAssessmentTotal']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSTB/@companyassessmenttaken"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:if test="(/DATA/TXN/PTSTB/@companyassessmenttaken = 0)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CompanyAssessmentTaken']"/>
                                                <xsl:element name="BR"/>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSTB/@companyassessmenttaken != 0)">
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">3411.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;CompanyID=<xsl:value-of select="/DATA/TXN/PTSMEMBER/@companyid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CompanyAssessmentTaken']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSTB/@publicassessmenttaken"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:if test="(/DATA/TXN/PTSTB/@publicassessmenttaken = 0)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PublicAssessmentTaken']"/>
                                                <xsl:element name="BR"/>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSTB/@publicassessmenttaken != 0)">
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">3411.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;CompanyID=<xsl:value-of select="/DATA/TXN/PTSMEMBER/@companyid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PublicAssessmentTaken']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                             </xsl:if>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">5</xsl:attribute>
                                          <xsl:attribute name="height">18</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="bgcolor">Purple</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="font">
                                             <xsl:attribute name="color">white</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='YourSurveys']"/>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">15</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">215</xsl:attribute>
                                          <xsl:attribute name="bgcolor">Purple</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="font">
                                             <xsl:attribute name="color">white</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='YourSuggestions']"/>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">15</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">195</xsl:attribute>
                                          <xsl:attribute name="bgcolor">Purple</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="font">
                                             <xsl:attribute name="color">white</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='YourMessages']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="bgcolor">plum</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSTB/@surveytaken"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:if test="(/DATA/TXN/PTSTB/@surveytaken = 0)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SurveyTaken']"/>
                                                <xsl:element name="BR"/>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSTB/@surveytaken != 0)">
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">4012.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;Mode=1&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SurveyTaken']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSTB/@surveyuntaken"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:if test="(/DATA/TXN/PTSTB/@surveyuntaken = 0)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SurveyUntaken']"/>
                                                <xsl:element name="BR"/>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSTB/@surveyuntaken != 0)">
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">4012.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;Mode=2&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SurveyUntaken']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                             </xsl:if>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">15</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">215</xsl:attribute>
                                          <xsl:attribute name="bgcolor">plum</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSTB/@suggestionsubmitted"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:if test="(/DATA/TXN/PTSTB/@suggestionsubmitted = 0)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SuggestionSubmitted']"/>
                                                <xsl:element name="BR"/>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSTB/@suggestionsubmitted != 0)">
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">4512.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;Mode=1&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SuggestionSubmitted']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSTB/@suggestionreplied"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:if test="(/DATA/TXN/PTSTB/@suggestionreplied = 0)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SuggestionReplied']"/>
                                                <xsl:element name="BR"/>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSTB/@suggestionreplied != 0)">
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">4512.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;Mode=2&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SuggestionReplied']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                             </xsl:if>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">15</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">195</xsl:attribute>
                                          <xsl:attribute name="bgcolor">plum</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSTB/@messageposted"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:if test="(/DATA/TXN/PTSTB/@messageposted = 0)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MessagePosted']"/>
                                                <xsl:element name="BR"/>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSTB/@messageposted != 0)">
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">8412.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;Mode=24&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MessagePosted']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSTB/@messagereplied"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:if test="(/DATA/TXN/PTSTB/@messagereplied = 0)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MessageReplied']"/>
                                                <xsl:element name="BR"/>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSTB/@messagereplied != 0)">
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">8412.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;Mode=25&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MessageReplied']"/>
                                                <xsl:element name="BR"/>
                                                </xsl:element>
                                             </xsl:if>
                                       </xsl:element>
                                    </xsl:element>

                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#004080</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@refresh = 0)">
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Refresh']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick">doSubmit(1,"")</xsl:attribute>
                                 </xsl:element>
                              </xsl:if>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:if test="(/DATA/PARAM/@contentpage = 0)">
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Return']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick">doSubmit(3,"")</xsl:attribute>
                                 </xsl:element>
                              </xsl:if>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:if test="(/DATA/PARAM/@contentpage != 0)">
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
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
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                     </xsl:element>

                  </xsl:element>
                  <!--END CONTENT COLUMN-->

               </xsl:element>

               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="colspan">2</xsl:attribute>
                     <xsl:if test="/DATA/PARAM/@contentpage!=1 and /DATA/PARAM/@contentpage!=3">
                        <xsl:call-template name="PageFooter"/>
                     </xsl:if>
                  </xsl:element>
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