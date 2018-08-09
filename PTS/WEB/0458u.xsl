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
         <xsl:with-param name="pagename" select="'Upgrade Member'"/>
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

               <!--HEADER ROW-->
               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="colspan">2</xsl:attribute>
                     <xsl:call-template name="PageHeader"/>
                  </xsl:element>
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
                              <xsl:attribute name="width">100</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">650</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/PARAM/@upgrade = 0)">
                           <xsl:if test="(/DATA/PARAM/@oldtitle != 11) and (/DATA/PARAM/@oldtitle != 12) and (/DATA/PARAM/@oldtitle != 13) and (/DATA/PARAM/@oldtitle != 14)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="height">24</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="width">750</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:attribute name="class">PageHeading</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoUpgrade']"/>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="height">24</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="width">750</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
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
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="height">24</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>

                           </xsl:if>
                           <xsl:if test="(/DATA/PARAM/@oldtitle = 11) or (/DATA/PARAM/@oldtitle = 12) or (/DATA/PARAM/@oldtitle = 13) or (/DATA/PARAM/@oldtitle = 14)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="height">18</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">750</xsl:attribute>
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
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="width">750</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:value-of select="/DATA/TXN/PTSHTMLFILE/DATA/comment()" disable-output-escaping="yes"/>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:if test="(/DATA/PARAM/@oldtitle = 11)">
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">100</xsl:attribute>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">650</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="INPUT">
                                       <xsl:attribute name="type">radio</xsl:attribute>
                                       <xsl:attribute name="name">Title</xsl:attribute>
                                       <xsl:attribute name="id">Title</xsl:attribute>
                                       <xsl:attribute name="value">1</xsl:attribute>
                                       <xsl:if test="1">
                                          <xsl:attribute name="CHECKED"/>
                                       </xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='RegularMembership']"/>
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
                                       <xsl:attribute name="width">100</xsl:attribute>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">650</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="INPUT">
                                       <xsl:attribute name="type">radio</xsl:attribute>
                                       <xsl:attribute name="name">Title</xsl:attribute>
                                       <xsl:attribute name="id">Title</xsl:attribute>
                                       <xsl:attribute name="value">12</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Intro1-2']"/>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>

                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">100</xsl:attribute>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">650</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="INPUT">
                                       <xsl:attribute name="type">radio</xsl:attribute>
                                       <xsl:attribute name="name">Title</xsl:attribute>
                                       <xsl:attribute name="id">Title</xsl:attribute>
                                       <xsl:attribute name="value">13</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Intro1-3']"/>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>

                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">100</xsl:attribute>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">650</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="INPUT">
                                       <xsl:attribute name="type">radio</xsl:attribute>
                                       <xsl:attribute name="name">Title</xsl:attribute>
                                       <xsl:attribute name="id">Title</xsl:attribute>
                                       <xsl:attribute name="value">14</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Intro1-4']"/>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>

                              </xsl:if>
                              <xsl:if test="(/DATA/PARAM/@oldtitle = 12)">
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">100</xsl:attribute>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">650</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="INPUT">
                                       <xsl:attribute name="type">radio</xsl:attribute>
                                       <xsl:attribute name="name">Title</xsl:attribute>
                                       <xsl:attribute name="id">Title</xsl:attribute>
                                       <xsl:attribute name="value">1</xsl:attribute>
                                       <xsl:if test="1">
                                          <xsl:attribute name="CHECKED"/>
                                       </xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='RegularMembership']"/>
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
                                       <xsl:attribute name="width">100</xsl:attribute>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">650</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="INPUT">
                                       <xsl:attribute name="type">radio</xsl:attribute>
                                       <xsl:attribute name="name">Title</xsl:attribute>
                                       <xsl:attribute name="id">Title</xsl:attribute>
                                       <xsl:attribute name="value">13</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Intro2-3']"/>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>

                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">100</xsl:attribute>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">650</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="INPUT">
                                       <xsl:attribute name="type">radio</xsl:attribute>
                                       <xsl:attribute name="name">Title</xsl:attribute>
                                       <xsl:attribute name="id">Title</xsl:attribute>
                                       <xsl:attribute name="value">14</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Intro2-4']"/>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>

                              </xsl:if>
                              <xsl:if test="(/DATA/PARAM/@oldtitle = 13)">
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">100</xsl:attribute>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">650</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="INPUT">
                                       <xsl:attribute name="type">radio</xsl:attribute>
                                       <xsl:attribute name="name">Title</xsl:attribute>
                                       <xsl:attribute name="id">Title</xsl:attribute>
                                       <xsl:attribute name="value">1</xsl:attribute>
                                       <xsl:if test="1">
                                          <xsl:attribute name="CHECKED"/>
                                       </xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='RegularMembership']"/>
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
                                       <xsl:attribute name="width">100</xsl:attribute>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">650</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="INPUT">
                                       <xsl:attribute name="type">radio</xsl:attribute>
                                       <xsl:attribute name="name">Title</xsl:attribute>
                                       <xsl:attribute name="id">Title</xsl:attribute>
                                       <xsl:attribute name="value">14</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Intro3-4']"/>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>

                              </xsl:if>
                              <xsl:if test="(/DATA/PARAM/@oldtitle = 14)">
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">2</xsl:attribute>
                                       <xsl:attribute name="height">12</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">100</xsl:attribute>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">650</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="INPUT">
                                       <xsl:attribute name="type">radio</xsl:attribute>
                                       <xsl:attribute name="name">Title</xsl:attribute>
                                       <xsl:attribute name="id">Title</xsl:attribute>
                                       <xsl:attribute name="value">1</xsl:attribute>
                                       <xsl:if test="1">
                                          <xsl:attribute name="CHECKED"/>
                                       </xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='RegularMembership']"/>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>

                              </xsl:if>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">750</xsl:attribute>
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="height">1</xsl:attribute>
                                    <xsl:attribute name="bgcolor">#004080</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="height">18</xsl:attribute>
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
                                    <xsl:attribute name="width">750</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="INPUT">
                                       <xsl:attribute name="type">button</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Upgrade']"/>
                                       </xsl:attribute>
                                       <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[doSubmit(2,""); this.disabled = true]]></xsl:text></xsl:attribute>
                                    </xsl:element>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:element name="INPUT">
                                       <xsl:attribute name="type">button</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Cancel']"/>
                                       </xsl:attribute>
                                       <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[window.close()]]></xsl:text></xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>

                           </xsl:if>
                        </xsl:if>
                        <xsl:if test="(/DATA/PARAM/@upgrade != 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">24</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MemberUpgraded']"/>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">24</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
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
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">24</xsl:attribute>
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