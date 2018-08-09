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
         <xsl:with-param name="pagename" select="'Org'"/>
         <xsl:with-param name="includecalendar" select="true()"/>
         <xsl:with-param name="htmleditor">editor_simple</xsl:with-param>
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
               <xsl:attribute name="name">Org</xsl:attribute>
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
                     <xsl:attribute name="width">590</xsl:attribute>

                     <xsl:element name="TABLE">
                        <xsl:attribute name="border">0</xsl:attribute>
                        <xsl:attribute name="cellpadding">0</xsl:attribute>
                        <xsl:attribute name="cellspacing">0</xsl:attribute>
                        <xsl:attribute name="width">590</xsl:attribute>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">150</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">590</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Properties']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/TXN/PTSORG/@orgname"/>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Folder']"/>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">590</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">bottom</xsl:attribute>
                              <xsl:attribute name="class">PrevNext</xsl:attribute>
                              <xsl:element name="A">
                                 <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                 <xsl:attribute name="onclick">w=window.open(this.href,"_blank","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                 <xsl:attribute name="href">8010.asp?ParentType=28&amp;ParentID=<xsl:value-of select="/DATA/TXN/PTSORG/@orgid"/>&amp;CompanyID=<xsl:value-of select="/DATA/TXN/PTSORG/@companyid"/>&amp;Title=<xsl:value-of select="/DATA/TXN/PTSORG/@orgname"/></xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Attachments']"/>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;|&amp;#160;</xsl:text>
                              <xsl:element name="A">
                                 <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                 <xsl:attribute name="href">4501.asp?contentpage=<xsl:value-of select="/DATA/PARAM/@contentpage"/>&amp;OrgID=<xsl:value-of select="/DATA/PARAM/@orgid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Suggestions']"/>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;|&amp;#160;</xsl:text>
                              <xsl:element name="A">
                                 <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                 <xsl:attribute name="href">4001.asp?contentpage=<xsl:value-of select="/DATA/PARAM/@contentpage"/>&amp;OrgID=<xsl:value-of select="/DATA/PARAM/@orgid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Surveys']"/>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;|&amp;#160;</xsl:text>
                              <xsl:element name="A">
                                 <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                 <xsl:attribute name="onclick">w=window.open(this.href,"Report","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                 <xsl:attribute name="href">1360.asp?OrgID=<xsl:value-of select="/DATA/PARAM/@orgid"/></xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Report']"/>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;|&amp;#160;</xsl:text>
                              <xsl:element name="A">
                                 <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                 <xsl:attribute name="href">2802.asp?contentpage=<xsl:value-of select="/DATA/PARAM/@contentpage"/>&amp;ParentID=<xsl:value-of select="/DATA/PARAM/@orgid"/>&amp;CompanyID=<xsl:value-of select="/DATA/TXN/PTSORG/@companyid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewFolder']"/>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;|&amp;#160;</xsl:text>
                              <xsl:if test="(/DATA/TXN/PTSORG/@usergroup != 0)">
                                 <xsl:element name="A">
                                    <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                    <xsl:attribute name="href">0104.asp?AuthUserID=<xsl:value-of select="/DATA/TXN/PTSORG/@authuserid"/>&amp;contentpage=<xsl:value-of select="/DATA/PARAM/@contentpage"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ResetLogon']"/>
                                 </xsl:element>
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
                              <xsl:attribute name="width">590</xsl:attribute>
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
                              <xsl:attribute name="width">150</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">IsPublic</xsl:attribute>
                              <xsl:attribute name="id">IsPublic</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:if test="(/DATA/TXN/PTSORG/@ispublic = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsPublic']"/>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">150</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">IsSuggestion</xsl:attribute>
                              <xsl:attribute name="id">IsSuggestion</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:if test="(/DATA/TXN/PTSORG/@issuggestion = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsSuggestion']"/>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">150</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">IsFavorite</xsl:attribute>
                              <xsl:attribute name="id">IsFavorite</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:if test="(/DATA/TXN/PTSORG/@isfavorite = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsFavorite']"/>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">150</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">checkbox</xsl:attribute>
                                 <xsl:attribute name="name">IsCatalog</xsl:attribute>
                                 <xsl:attribute name="id">IsCatalog</xsl:attribute>
                                 <xsl:attribute name="value">1</xsl:attribute>
                                 <xsl:if test="(/DATA/TXN/PTSORG/@iscatalog = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsCatalog']"/>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">150</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">checkbox</xsl:attribute>
                                 <xsl:attribute name="name">IsProgram</xsl:attribute>
                                 <xsl:attribute name="id">IsProgram</xsl:attribute>
                                 <xsl:attribute name="value">1</xsl:attribute>
                                 <xsl:if test="(/DATA/TXN/PTSORG/@isprogram = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsProgram']"/>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">150</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Credits']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">Credits</xsl:attribute>
                                 <xsl:attribute name="id">Credits</xsl:attribute>
                                 <xsl:attribute name="size">2</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSORG/@credits"/></xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">150</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">checkbox</xsl:attribute>
                                 <xsl:attribute name="name">NoCertificate</xsl:attribute>
                                 <xsl:attribute name="id">NoCertificate</xsl:attribute>
                                 <xsl:attribute name="value">1</xsl:attribute>
                                 <xsl:if test="(/DATA/TXN/PTSORG/@nocertificate = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoCertificate']"/>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">150</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">checkbox</xsl:attribute>
                                 <xsl:attribute name="name">IsCustomCertificate</xsl:attribute>
                                 <xsl:attribute name="id">IsCustomCertificate</xsl:attribute>
                                 <xsl:attribute name="value">1</xsl:attribute>
                                 <xsl:if test="(/DATA/TXN/PTSORG/@iscustomcertificate = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsCustomCertificate']"/>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/SYSTEM/@usergroup &gt; 23)">
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">IsCatalog</xsl:attribute>
                              <xsl:attribute name="id">IsCatalog</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSORG/@iscatalog"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">IsProgram</xsl:attribute>
                              <xsl:attribute name="id">IsProgram</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSORG/@isprogram"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Credits</xsl:attribute>
                              <xsl:attribute name="id">Credits</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSORG/@credits"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">NoCertificate</xsl:attribute>
                              <xsl:attribute name="id">NoCertificate</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSORG/@nocertificate"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">IsCustomCertificate</xsl:attribute>
                              <xsl:attribute name="id">IsCustomCertificate</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSORG/@iscustomcertificate"/></xsl:attribute>
                           </xsl:element>
                        </xsl:if>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">590</xsl:attribute>
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#004080</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/PARAM/@updated = 1)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">150</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="font">
                                    <xsl:attribute name="color">blue</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='UpdateSuccessMessage']"/>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="((/DATA/SYSTEM/@usergroup &lt;= 51) or (/DATA/SYSTEM/@usergroup &lt;= 52)) and (/DATA/SYSTEM/@userstatus = 1)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">590</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Update']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick">doSubmit(1,"")</xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:if test="(/DATA/TXN/PTSORG/@parentid != 0) and ((/DATA/SYSTEM/@usergroup &lt;= 21) or (/DATA/SYSTEM/@usergroup &lt;= 51))">
                                    <xsl:element name="INPUT">
                                       <xsl:attribute name="type">button</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Delete']"/>
                                       </xsl:attribute>
                                       <xsl:attribute name="onclick">doSubmit(4,'<xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ConfirmDelete']"/>')</xsl:attribute>
                                    </xsl:element>
                                 </xsl:if>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">150</xsl:attribute>
                              <xsl:attribute name="height">18</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FolderID']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="b">
                              <xsl:value-of select="/DATA/TXN/PTSORG/@orgid"/>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">150</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CompanyID']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="b">
                              <xsl:value-of select="/DATA/TXN/PTSORG/@companyid"/>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">150</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ParentID']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">ParentID</xsl:attribute>
                                 <xsl:attribute name="id">ParentID</xsl:attribute>
                                 <xsl:attribute name="size">6</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSORG/@parentid"/></xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">150</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PrivateID']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">PrivateID</xsl:attribute>
                                 <xsl:attribute name="id">PrivateID</xsl:attribute>
                                 <xsl:attribute name="size">6</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSORG/@privateid"/></xsl:attribute>
                                 </xsl:element>
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
                                 <xsl:attribute name="width">150</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
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

                        </xsl:if>
                        <xsl:if test="(/DATA/SYSTEM/@usergroup &gt; 23)">
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">ParentID</xsl:attribute>
                                 <xsl:attribute name="id">ParentID</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSORG/@parentid"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">PrivateID</xsl:attribute>
                                 <xsl:attribute name="id">PrivateID</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSORG/@privateid"/></xsl:attribute>
                              </xsl:element>

                        </xsl:if>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">150</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FolderName']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">OrgName</xsl:attribute>
                              <xsl:attribute name="id">OrgName</xsl:attribute>
                              <xsl:attribute name="size">60</xsl:attribute>
                              <xsl:attribute name="maxlength">60</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSORG/@orgname"/></xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">150</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Status']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="SELECT">
                                 <xsl:attribute name="name">Status</xsl:attribute>
                                 <xsl:attribute name="id">Status</xsl:attribute>
                                 <xsl:for-each select="/DATA/TXN/PTSORG/PTSSTATUSS/ENUM">
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                       <xsl:if test="@selected"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:variable name="tmp1"><xsl:value-of select="current()/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp1]"/>
                                    </xsl:element>
                                 </xsl:for-each>
                              </xsl:element>
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
                              <xsl:attribute name="width">590</xsl:attribute>
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
                              <xsl:attribute name="width">590</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Description']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">590</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TEXTAREA">
                                 <xsl:attribute name="name">Description</xsl:attribute>
                                 <xsl:attribute name="id">Description</xsl:attribute>
                                 <xsl:attribute name="rows">6</xsl:attribute>
                                 <xsl:attribute name="cols">72</xsl:attribute>
                                 <xsl:attribute name="onkeyup"><xsl:text disable-output-escaping="yes"><![CDATA[if (value.length>1000) {doMaxLenMsg(1000); value=value.substring(0,1000);}]]></xsl:text></xsl:attribute>
                                 <xsl:value-of select="/DATA/TXN/PTSORG/DESCRIPTION/comment()" disable-output-escaping="yes"/>
                              </xsl:element>
                              <xsl:element name="SCRIPT">
                                 <xsl:attribute name="language">JavaScript1.2</xsl:attribute>
                                 <![CDATA[   CKEDITOR.replace('Description', { toolbar:'simple', height:120 } );  ]]>
                              </xsl:element>
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
                              <xsl:attribute name="width">590</xsl:attribute>
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

                        <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 51) or (/DATA/SYSTEM/@usergroup &lt;= 23)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">590</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">prompt</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MemberIDText']"/>
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
                                 <xsl:attribute name="width">150</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MemberID']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">MemberID</xsl:attribute>
                                 <xsl:attribute name="id">MemberID</xsl:attribute>
                                 <xsl:attribute name="size">6</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSORG/@memberid"/></xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">590</xsl:attribute>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="class">InputHeading</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NameFirst']"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">240</xsl:attribute>
                                          <xsl:attribute name="class">InputHeading</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NameLast']"/>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Manager']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">NameFirst</xsl:attribute>
                                          <xsl:attribute name="id">NameFirst</xsl:attribute>
                                          <xsl:attribute name="size">25</xsl:attribute>
                                          <xsl:attribute name="maxlength">30</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSORG/@namefirst"/></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">240</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">NameLast</xsl:attribute>
                                          <xsl:attribute name="id">NameLast</xsl:attribute>
                                          <xsl:attribute name="size">25</xsl:attribute>
                                          <xsl:attribute name="maxlength">30</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSORG/@namelast"/></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">150</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Email']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">Email</xsl:attribute>
                                 <xsl:attribute name="id">Email</xsl:attribute>
                                 <xsl:attribute name="size">60</xsl:attribute>
                                 <xsl:attribute name="maxlength">80</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSORG/@email"/></xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">150</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Secure']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">Secure</xsl:attribute>
                                 <xsl:attribute name="id">Secure</xsl:attribute>
                                 <xsl:attribute name="size">2</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSORG/@secure"/></xsl:attribute>
                                 </xsl:element>
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
                                 <xsl:attribute name="width">590</xsl:attribute>
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
                                 <xsl:attribute name="width">150</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='UserAccess']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="SELECT">
                                    <xsl:attribute name="name">UserGroup</xsl:attribute>
                                    <xsl:attribute name="id">UserGroup</xsl:attribute>
                                    <xsl:for-each select="/DATA/TXN/PTSORG/PTSUSERGROUPS/ENUM">
                                       <xsl:element name="OPTION">
                                          <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                          <xsl:if test="@selected"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:variable name="tmp1"><xsl:value-of select="current()/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp1]"/>
                                       </xsl:element>
                                    </xsl:for-each>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="SELECT">
                                    <xsl:attribute name="name">UserStatus</xsl:attribute>
                                    <xsl:attribute name="id">UserStatus</xsl:attribute>
                                    <xsl:for-each select="/DATA/TXN/PTSORG/PTSUSERSTATUSS/ENUM">
                                       <xsl:element name="OPTION">
                                          <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                          <xsl:if test="@selected"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:variable name="tmp2"><xsl:value-of select="current()/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp2]"/>
                                       </xsl:element>
                                    </xsl:for-each>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/SYSTEM/@usergroup &gt; 23) and (/DATA/SYSTEM/@usergroup &gt; 51)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">150</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Manager']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:value-of select="/DATA/TXN/PTSORG/@namefirst"/>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:value-of select="/DATA/TXN/PTSORG/@namelast"/>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">150</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Email']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/TXN/PTSORG/@email"/>
                              </xsl:element>
                           </xsl:element>

                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">UserGroup</xsl:attribute>
                                 <xsl:attribute name="id">UserGroup</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSORG/@usergroup"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">UserStatus</xsl:attribute>
                                 <xsl:attribute name="id">UserStatus</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSORG/@userstatus"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">MemberID</xsl:attribute>
                                 <xsl:attribute name="id">MemberID</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSORG/@memberid"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">NameFirst</xsl:attribute>
                                 <xsl:attribute name="id">NameFirst</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSORG/@namefirst"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">NameLast</xsl:attribute>
                                 <xsl:attribute name="id">NameLast</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSORG/@namelast"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Email</xsl:attribute>
                                 <xsl:attribute name="id">Email</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSORG/@email"/></xsl:attribute>
                              </xsl:element>

                        </xsl:if>
                        <xsl:if test="((/DATA/SYSTEM/@usergroup &lt;= 51) or (/DATA/SYSTEM/@usergroup &lt;= 52)) and (/DATA/SYSTEM/@userstatus = 1)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">590</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Update']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick">doSubmit(1,"")</xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:if test="(/DATA/TXN/PTSORG/@parentid != 0) and ((/DATA/SYSTEM/@usergroup &lt;= 21) or (/DATA/SYSTEM/@usergroup &lt;= 51))">
                                    <xsl:element name="INPUT">
                                       <xsl:attribute name="type">button</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Delete']"/>
                                       </xsl:attribute>
                                       <xsl:attribute name="onclick">doSubmit(4,'<xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ConfirmDelete']"/>')</xsl:attribute>
                                    </xsl:element>
                                 </xsl:if>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

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

      </xsl:element>
      <!--END BODY-->

      </xsl:element>

   </xsl:template>
</xsl:stylesheet>