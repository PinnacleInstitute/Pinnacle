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
         <xsl:with-param name="pagename" select="'Downline Sponsors'"/>
         <xsl:with-param name="includecalendar" select="true()"/>
         <xsl:with-param name="htmleditor"></xsl:with-param>
         <xsl:with-param name="viewport">width=device-width</xsl:with-param>
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
         <xsl:element name="A">
            <xsl:attribute name="name">top</xsl:attribute>
         </xsl:element>
         <xsl:element name="TABLE">
            <xsl:attribute name="border">0</xsl:attribute>
            <xsl:attribute name="cellpadding">0</xsl:attribute>
            <xsl:attribute name="cellspacing">0</xsl:attribute>
            <xsl:attribute name="width">100%</xsl:attribute>
            <xsl:attribute name="align">left</xsl:attribute>

            <!--BEGIN FORM-->
            <xsl:element name="FORM">
               <xsl:attribute name="name">Downline</xsl:attribute>
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
                     <xsl:attribute name="width">NaN</xsl:attribute>
                  </xsl:element>
               </xsl:element>

               <xsl:element name="TR">

                  <xsl:element name="TD">
                     <xsl:attribute name="width">10</xsl:attribute>
                  </xsl:element>

                  <xsl:element name="TD">
                     <xsl:attribute name="valign">top</xsl:attribute>
                     <xsl:attribute name="width">100%</xsl:attribute>

                     <xsl:element name="TABLE">
                        <xsl:attribute name="border">0</xsl:attribute>
                        <xsl:attribute name="cellpadding">0</xsl:attribute>
                        <xsl:attribute name="cellspacing">0</xsl:attribute>
                        <xsl:attribute name="width">100%</xsl:attribute>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100%</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namefirst"/>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namelast"/>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="width">50%</xsl:attribute>
                                       <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                       <xsl:attribute name="valign">Bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Team']"/>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="width">50%</xsl:attribute>
                                       <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                       <xsl:attribute name="valign">Bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Leader']"/>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">2</xsl:attribute>
                                       <xsl:attribute name="height">2</xsl:attribute>
                                       <xsl:attribute name="bgcolor">#CCCCCC</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>

                                 <xsl:for-each select="/DATA/TXN/PTSDOWNLINES/PTSDOWNLINE">
                                    <xsl:element name="TR">
                                       <xsl:if test="(position() mod 2)=1">
                                          <xsl:attribute name="class">GrayBar</xsl:attribute>
                                       </xsl:if>
                                       <xsl:if test="(position() mod 2)=0">
                                          <xsl:attribute name="class">WhiteBar</xsl:attribute>
                                       </xsl:if>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">%</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:if test="(/DATA/PARAM/@companyid != 5) and (/DATA/PARAM/@companyid != 9) and (/DATA/PARAM/@companyid != 13) and (/DATA/PARAM/@companyid != 14) and (/DATA/PARAM/@companyid != 17)">
                                                <xsl:value-of select="@line"/>
                                             </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@companyid = 5)">
                                                <xsl:if test="(@line = 2)">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ManagerTeam']"/>
                                                </xsl:if>
                                                <xsl:if test="(@line = 3)">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='DirectorTeam']"/>
                                                </xsl:if>
                                                <xsl:if test="(@line = 4)">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ExecutiveTeam']"/>
                                                </xsl:if>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@companyid = 9)">
                                                <xsl:if test="(@line = 7)">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Team9_7']"/>
                                                </xsl:if>
                                                <xsl:if test="(@line = 8)">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Team9_8']"/>
                                                </xsl:if>
                                                <xsl:if test="(@line = 9)">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Team9_9']"/>
                                                </xsl:if>
                                                <xsl:if test="(@line = 10)">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Team9_10']"/>
                                                </xsl:if>
                                                <xsl:if test="(@line = 11)">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Team9_11']"/>
                                                </xsl:if>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@companyid = 13)">
                                                <xsl:if test="(@line = 5)">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Team13_5']"/>
                                                </xsl:if>
                                                <xsl:if test="(@line = 6)">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Team13_6']"/>
                                                </xsl:if>
                                                <xsl:if test="(@line = 7)">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Team13_7']"/>
                                                </xsl:if>
                                                <xsl:if test="(@line = 9)">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Team13_9']"/>
                                                </xsl:if>
                                                <xsl:if test="(@line = 10)">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Team13_10']"/>
                                                </xsl:if>
                                                <xsl:if test="(@line = 11)">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Team13_11']"/>
                                                </xsl:if>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@companyid = 14)">
                                                <xsl:if test="(@line = 6)">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Team14_6']"/>
                                                </xsl:if>
                                                <xsl:if test="(@line = 7)">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Team14_7']"/>
                                                </xsl:if>
                                                <xsl:if test="(@line = 8)">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Team14_8']"/>
                                                </xsl:if>
                                                <xsl:if test="(@line = 9)">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Team14_9']"/>
                                                </xsl:if>
                                                <xsl:if test="(@line = 10)">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Team14_10']"/>
                                                </xsl:if>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@companyid = 17)">
                                                <xsl:if test="(@line = 6)">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Team17_6']"/>
                                                </xsl:if>
                                                <xsl:if test="(@line = 7)">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Team17_7']"/>
                                                </xsl:if>
                                                <xsl:if test="(@line = 8)">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Team17_8']"/>
                                                </xsl:if>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@companyid = 20)">
                                                <xsl:if test="(@line = 2)">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Team20_2']"/>
                                                </xsl:if>
                                                <xsl:if test="(@line = 3)">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Team20_3']"/>
                                                </xsl:if>
                                                <xsl:if test="(@line = 4)">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Team20_4']"/>
                                                </xsl:if>
                                          </xsl:if>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">%</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="@childname"/>
                                          <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23) or (/DATA/SYSTEM/@usergroup = 51)">
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">5405.asp?DownlineID=<xsl:value-of select="@downlineid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/Edit.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                          </xsl:if>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:for-each>
                                 <xsl:choose>
                                    <xsl:when test="(count(/DATA/TXN/PTSDOWNLINES/PTSDOWNLINE) = 0)">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="class">NoItems</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoItems']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:when>
                                 </xsl:choose>

                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">2</xsl:attribute>
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
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">button</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Close']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[window.close()]]></xsl:text></xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23) or (/DATA/SYSTEM/@usergroup = 51)">
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Rebuild']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick">doSubmit(5,'<xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ConfirmRebuild']"/>')</xsl:attribute>
                                 </xsl:element>
                              </xsl:if>
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
      <!--END BODY-->

      </xsl:element>

   </xsl:template>
</xsl:stylesheet>