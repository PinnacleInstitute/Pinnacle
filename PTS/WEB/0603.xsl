<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
   <xsl:include href="HTMLHeading.xsl"/>
   <xsl:include href="PageHeader.xsl"/>
   <xsl:include href="PageFooter.xsl"/>
   <xsl:include href="Bookmark.xsl"/>
   <xsl:include href="Include\wtSystem.xsl"/>
   <xsl:include href="Include\wtTab.xsl"/>
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
         <xsl:with-param name="pagename" select="'Affiliate'"/>
         <xsl:with-param name="includecalendar" select="true()"/>
         <xsl:with-param name="htmleditor">editor_simple</xsl:with-param>
         <xsl:with-param name="translate">google</xsl:with-param>
      </xsl:call-template>

      <xsl:element name="SCRIPT">
         <xsl:attribute name="language">JavaScript</xsl:attribute>
         <xsl:attribute name="src">Include/codethatsdk.js</xsl:attribute>
         <xsl:text> </xsl:text>
      </xsl:element>

      <xsl:element name="SCRIPT">
         <xsl:attribute name="language">JavaScript</xsl:attribute>
         <xsl:attribute name="src">Include/codethattabpro.js</xsl:attribute>
         <xsl:text> </xsl:text>
      </xsl:element>

      <xsl:call-template name="DefineTab"/>

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
                     <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[
               ShowTab('TabStatus',0);
            ]]></xsl:text>;doErrorMsg('<xsl:value-of select="concat($errmsg, $errmsgfld)"/>')</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[
               ShowTab('TabStatus',0);
            ]]></xsl:text>;doErrorMsg('<xsl:value-of select="/DATA/ERROR"/>')</xsl:attribute>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
               <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[
               ShowTab('TabStatus',0);
            ]]></xsl:text></xsl:attribute>
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
               <xsl:attribute name="name">Affiliate</xsl:attribute>
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

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ShowTab(tab, shw){ 
               document.getElementById('TabStatus').style.display = 'none';
               document.getElementById('TabContact').style.display = 'none';
               document.getElementById('TabTerms').style.display = 'none';
               document.getElementById('TabNotes').style.display = 'none';
               document.getElementById(tab).style.display = '';
               if (shw > 0) {
                  content = window.document.getElementById('AffiliateName');
                  if(content)
                     content.scrollIntoView();
               }   
              }]]></xsl:text>
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
                              <xsl:attribute name="width">160</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/SYSTEM/@usergroup != 61)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:element name="b">
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Affiliate']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@affiliatename"/>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:if test="(/DATA/SYSTEM/@usergroup != 41) or (contains(/DATA/SYSTEM/@useroptions, 's'))">
                                    <xsl:element name="A">
                                       <xsl:attribute name="onclick">w=window.open(this.href,"shortcut","width=400, height=150");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                       <xsl:attribute name="href">9202.asp?EntityID=06&amp;ItemID=<xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@affiliateid"/>&amp;Name=<xsl:value-of select="translate(/DATA/TXN/PTSAFFILIATE/@affiliatename,'&amp;',' ')"/>&amp;URL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/Shortcut.gif</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:if>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">bottom</xsl:attribute>
                                 <xsl:attribute name="class">PrevNext</xsl:attribute>
                                 <xsl:element name="A">
                                    <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                    <xsl:attribute name="href">0604.asp?AffiliateID=<xsl:value-of select="/DATA/PARAM/@affiliateid"/>&amp;ContentPage=<xsl:value-of select="/DATA/PARAM/@contentpage"/>&amp;Popup=<xsl:value-of select="/DATA/PARAM/@popup"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LeadCampaigns']"/>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;|&amp;#160;</xsl:text>
                                 <xsl:if test="(/DATA/TXN/PTSAFFILIATE/@usergroup != 0)">
                                    <xsl:element name="A">
                                       <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                       <xsl:attribute name="href">0104.asp?AuthUserID=<xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@authuserid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ResetLogon']"/>
                                    </xsl:element>
                                 </xsl:if>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">1</xsl:attribute>
                                 <xsl:attribute name="bgcolor">#000000</xsl:attribute>
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
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">2</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:if test="(/DATA/SYSTEM/@userstatus = 1)">
                                    <xsl:element name="INPUT">
                                       <xsl:attribute name="type">button</xsl:attribute>
                                       <xsl:attribute name="class">smbutton</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Update']"/>
                                       </xsl:attribute>
                                       <xsl:attribute name="onclick">doSubmit(1,"")</xsl:attribute>
                                    </xsl:element>
                                 </xsl:if>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:if test="(/DATA/PARAM/@popup = 0)">
                                    <xsl:element name="INPUT">
                                       <xsl:attribute name="type">button</xsl:attribute>
                                       <xsl:attribute name="class">smbutton</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Cancel']"/>
                                       </xsl:attribute>
                                       <xsl:attribute name="onclick">doSubmit(3,"")</xsl:attribute>
                                    </xsl:element>
                                 </xsl:if>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:if test="(/DATA/PARAM/@popup != 0)">
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

                        </xsl:if>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">160</xsl:attribute>
                              <xsl:attribute name="height">18</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AffiliateID']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="b">
                              <xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@affiliateid"/>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">160</xsl:attribute>
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
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">CompanyID</xsl:attribute>
                                 <xsl:attribute name="id">CompanyID</xsl:attribute>
                                 <xsl:attribute name="size">6</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@companyid"/></xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/SYSTEM/@usergroup &gt; 23)">
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CompanyID</xsl:attribute>
                                 <xsl:attribute name="id">CompanyID</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@companyid"/></xsl:attribute>
                              </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/SYSTEM/@usergroup != 61)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">160</xsl:attribute>
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
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@memberid"/></xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:if test="(/DATA/SYSTEM/@usergroup != 41) and (/DATA/TXN/PTSAFFILIATE/@memberid != 0)">
                                    <xsl:element name="A">
                                       <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                       <xsl:attribute name="onclick">w=window.open(this.href,"Member","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                       <xsl:attribute name="href">0403.asp?MemberID=<xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@memberid"/>&amp;Popup=1</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MemberID']"/>
                                    </xsl:element>
                                 </xsl:if>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SponsorID']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">SponsorID</xsl:attribute>
                                 <xsl:attribute name="id">SponsorID</xsl:attribute>
                                 <xsl:attribute name="size">6</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@sponsorid"/></xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:if test="(/DATA/TXN/PTSAFFILIATE/@sponsorid != 0)">
                                    <xsl:element name="A">
                                       <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                       <xsl:attribute name="onclick">w=window.open(this.href,"Affiliate","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                       <xsl:attribute name="href">0603.asp?AffiliateID=<xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@sponsorid"/>&amp;Popup=1</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SponsorID']"/>
                                    </xsl:element>
                                 </xsl:if>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/SYSTEM/@usergroup = 61)">
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">MemberID</xsl:attribute>
                                 <xsl:attribute name="id">MemberID</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@memberid"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">SponsorID</xsl:attribute>
                                 <xsl:attribute name="id">SponsorID</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@sponsorid"/></xsl:attribute>
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
                              <xsl:attribute name="width">160</xsl:attribute>
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

                        <xsl:if test="(/DATA/SYSTEM/@usergroup != 61)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">160</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AffiliateName']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">AffiliateName</xsl:attribute>
                                 <xsl:attribute name="id">AffiliateName</xsl:attribute>
                                 <xsl:attribute name="size">60</xsl:attribute>
                                 <xsl:attribute name="maxlength">60</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@affiliatename"/></xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:element name="IMG">
                                    <xsl:attribute name="src">Images/Required.gif</xsl:attribute>
                                    <xsl:attribute name="alt">Required Field</xsl:attribute>
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
                                    <xsl:attribute name="width">600</xsl:attribute>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
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
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ContactName']"/>
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
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@namefirst"/></xsl:attribute>
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
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@namelast"/></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/SYSTEM/@usergroup = 61)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">160</xsl:attribute>
                                 <xsl:attribute name="height">18</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AffiliateName']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@affiliatename"/>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">160</xsl:attribute>
                                 <xsl:attribute name="height">18</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ContactName']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@contactname"/>
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
                                 <xsl:attribute name="width">160</xsl:attribute>
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

                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">AffiliateName</xsl:attribute>
                                 <xsl:attribute name="id">AffiliateName</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@affiliatename"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">NameFirst</xsl:attribute>
                                 <xsl:attribute name="id">NameFirst</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@namefirst"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">NameLast</xsl:attribute>
                                 <xsl:attribute name="id">NameLast</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@namelast"/></xsl:attribute>
                              </xsl:element>

                        </xsl:if>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">160</xsl:attribute>
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
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@email"/></xsl:attribute>
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
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
<xsl:element name="SCRIPT">
   <xsl:attribute name="language">JavaScript</xsl:attribute>
   var AffiliateTab = new CTabSet("AffiliateTab"); AffiliateTab.create(AffiliateTabDef);
</xsl:element>

                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:attribute name="id">TabStatus</xsl:attribute>
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
                                          <xsl:attribute name="align">right</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:if test="(/DATA/SYSTEM/@usergroup != 61)">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="height">6</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">160</xsl:attribute>
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

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">160</xsl:attribute>
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
                                                <xsl:for-each select="/DATA/TXN/PTSAFFILIATE/PTSSTATUSS/ENUM">
                                                   <xsl:element name="OPTION">
                                                      <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                                      <xsl:if test="@selected"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:variable name="tmp1"><xsl:value-of select="current()/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp1]"/>
                                                   </xsl:element>
                                                </xsl:for-each>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EnrollDate']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">text</xsl:attribute>
                                             <xsl:attribute name="name">EnrollDate</xsl:attribute>
                                             <xsl:attribute name="id">EnrollDate</xsl:attribute>
                                             <xsl:attribute name="size">10</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@enrolldate"/></xsl:attribute>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="name">Calendar</xsl:attribute>
                                                <xsl:attribute name="src">Images/Calendar.gif</xsl:attribute>
                                                <xsl:attribute name="width">16</xsl:attribute>
                                                <xsl:attribute name="height">16</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                                <xsl:attribute name="onclick">CalendarPopup(document.forms[0], document.getElementById('EnrollDate'))</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">160</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SSN']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">440</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">text</xsl:attribute>
                                             <xsl:attribute name="name">SSN</xsl:attribute>
                                             <xsl:attribute name="id">SSN</xsl:attribute>
                                             <xsl:attribute name="size">18</xsl:attribute>
                                             <xsl:attribute name="maxlength">18</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@ssn"/></xsl:attribute>
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
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:attribute name="class">prompt</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LeadCampaignsText']"/>
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
                                             <xsl:attribute name="width">160</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LeadCampaigns']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">440</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">text</xsl:attribute>
                                             <xsl:attribute name="name">LeadCampaigns</xsl:attribute>
                                             <xsl:attribute name="id">LeadCampaigns</xsl:attribute>
                                             <xsl:attribute name="size">40</xsl:attribute>
                                             <xsl:attribute name="maxlength">50</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@leadcampaigns"/></xsl:attribute>
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
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:attribute name="class">prompt</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='UserAccessText']"/>
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
                                             <xsl:attribute name="width">160</xsl:attribute>
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
                                                <xsl:for-each select="/DATA/TXN/PTSAFFILIATE/PTSUSERGROUPS/ENUM">
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
                                                <xsl:for-each select="/DATA/TXN/PTSAFFILIATE/PTSUSERSTATUSS/ENUM">
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
                                    <xsl:if test="(/DATA/SYSTEM/@usergroup = 61)">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">160</xsl:attribute>
                                             <xsl:attribute name="height">18</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EnrollDate']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">440</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@enrolldate"/>
                                          </xsl:element>
                                       </xsl:element>

                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">hidden</xsl:attribute>
                                             <xsl:attribute name="name">Status</xsl:attribute>
                                             <xsl:attribute name="id">Status</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@status"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">hidden</xsl:attribute>
                                             <xsl:attribute name="name">EnrollDate</xsl:attribute>
                                             <xsl:attribute name="id">EnrollDate</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@enrolldate"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">hidden</xsl:attribute>
                                             <xsl:attribute name="name">SSN</xsl:attribute>
                                             <xsl:attribute name="id">SSN</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@ssn"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">hidden</xsl:attribute>
                                             <xsl:attribute name="name">LeadCampaigns</xsl:attribute>
                                             <xsl:attribute name="id">LeadCampaigns</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@leadcampaigns"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">hidden</xsl:attribute>
                                             <xsl:attribute name="name">UserGroup</xsl:attribute>
                                             <xsl:attribute name="id">UserGroup</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@usergroup"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">hidden</xsl:attribute>
                                             <xsl:attribute name="name">UserStatus</xsl:attribute>
                                             <xsl:attribute name="id">UserStatus</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@userstatus"/></xsl:attribute>
                                          </xsl:element>

                                    </xsl:if>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:attribute name="id">TabContact</xsl:attribute>
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
                                          <xsl:attribute name="align">right</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">2</xsl:attribute>
                                          <xsl:element name="TABLE">
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="cellpadding">0</xsl:attribute>
                                             <xsl:attribute name="cellspacing">0</xsl:attribute>
                                             <xsl:attribute name="width">600</xsl:attribute>
                                             <xsl:element name="TR">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">160</xsl:attribute>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">294</xsl:attribute>
                                                   <xsl:attribute name="class">InputHeading</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">bottom</xsl:attribute>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Street']"/>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">146</xsl:attribute>
                                                   <xsl:attribute name="class">InputHeading</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">bottom</xsl:attribute>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Unit']"/>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TR">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">160</xsl:attribute>
                                                   <xsl:attribute name="align">right</xsl:attribute>
                                                   <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Address']"/>
                                                   <xsl:text>:</xsl:text>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">294</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">text</xsl:attribute>
                                                   <xsl:attribute name="name">Street</xsl:attribute>
                                                   <xsl:attribute name="id">Street</xsl:attribute>
                                                   <xsl:attribute name="size">40</xsl:attribute>
                                                   <xsl:attribute name="maxlength">60</xsl:attribute>
                                                   <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@street"/></xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">146</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">text</xsl:attribute>
                                                   <xsl:attribute name="name">Unit</xsl:attribute>
                                                   <xsl:attribute name="id">Unit</xsl:attribute>
                                                   <xsl:attribute name="size">10</xsl:attribute>
                                                   <xsl:attribute name="maxlength">40</xsl:attribute>
                                                   <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@unit"/></xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                             </xsl:element>
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
                                             <xsl:attribute name="width">600</xsl:attribute>
                                             <xsl:element name="TR">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">160</xsl:attribute>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">200</xsl:attribute>
                                                   <xsl:attribute name="class">InputHeading</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">bottom</xsl:attribute>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='City']"/>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">240</xsl:attribute>
                                                   <xsl:attribute name="class">InputHeading</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">bottom</xsl:attribute>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='State']"/>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TR">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">160</xsl:attribute>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">200</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">text</xsl:attribute>
                                                   <xsl:attribute name="name">City</xsl:attribute>
                                                   <xsl:attribute name="id">City</xsl:attribute>
                                                   <xsl:attribute name="size">25</xsl:attribute>
                                                   <xsl:attribute name="maxlength">30</xsl:attribute>
                                                   <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@city"/></xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">240</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">text</xsl:attribute>
                                                   <xsl:attribute name="name">State</xsl:attribute>
                                                   <xsl:attribute name="id">State</xsl:attribute>
                                                   <xsl:attribute name="size">25</xsl:attribute>
                                                   <xsl:attribute name="maxlength">30</xsl:attribute>
                                                   <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@state"/></xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                             </xsl:element>
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
                                             <xsl:attribute name="width">600</xsl:attribute>
                                             <xsl:element name="TR">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">160</xsl:attribute>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">200</xsl:attribute>
                                                   <xsl:attribute name="class">InputHeading</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">bottom</xsl:attribute>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Zip']"/>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">240</xsl:attribute>
                                                   <xsl:attribute name="class">InputHeading</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">bottom</xsl:attribute>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Country']"/>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TR">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">160</xsl:attribute>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">200</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">text</xsl:attribute>
                                                   <xsl:attribute name="name">Zip</xsl:attribute>
                                                   <xsl:attribute name="id">Zip</xsl:attribute>
                                                   <xsl:attribute name="size">25</xsl:attribute>
                                                   <xsl:attribute name="maxlength">20</xsl:attribute>
                                                   <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@zip"/></xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">240</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">text</xsl:attribute>
                                                   <xsl:attribute name="name">Country</xsl:attribute>
                                                   <xsl:attribute name="id">Country</xsl:attribute>
                                                   <xsl:attribute name="size">25</xsl:attribute>
                                                   <xsl:attribute name="maxlength">30</xsl:attribute>
                                                   <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@country"/></xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                             </xsl:element>
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
                                          <xsl:attribute name="width">160</xsl:attribute>
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

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Phone1']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Phone1</xsl:attribute>
                                          <xsl:attribute name="id">Phone1</xsl:attribute>
                                          <xsl:attribute name="size">30</xsl:attribute>
                                          <xsl:attribute name="maxlength">30</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@phone1"/></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Phone2']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Phone2</xsl:attribute>
                                          <xsl:attribute name="id">Phone2</xsl:attribute>
                                          <xsl:attribute name="size">30</xsl:attribute>
                                          <xsl:attribute name="maxlength">30</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@phone2"/></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Fax']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Fax</xsl:attribute>
                                          <xsl:attribute name="id">Fax</xsl:attribute>
                                          <xsl:attribute name="size">30</xsl:attribute>
                                          <xsl:attribute name="maxlength">30</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@fax"/></xsl:attribute>
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
                                          <xsl:attribute name="width">160</xsl:attribute>
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

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Website']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Website</xsl:attribute>
                                          <xsl:attribute name="id">Website</xsl:attribute>
                                          <xsl:attribute name="size">60</xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@website"/></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:attribute name="id">TabTerms</xsl:attribute>
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
                                          <xsl:attribute name="align">right</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:if test="(/DATA/SYSTEM/@usergroup != 61)">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="width">600</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="TEXTAREA">
                                                <xsl:attribute name="name">Terms</xsl:attribute>
                                                <xsl:attribute name="id">Terms</xsl:attribute>
                                                <xsl:attribute name="rows">8</xsl:attribute>
                                                <xsl:attribute name="cols">72</xsl:attribute>
                                                <xsl:attribute name="onkeyup"><xsl:text disable-output-escaping="yes"><![CDATA[if (value.length>1000) {doMaxLenMsg(1000); value=value.substring(0,1000);}]]></xsl:text></xsl:attribute>
                                                <xsl:value-of select="/DATA/TXN/PTSAFFILIATE/TERMS/comment()" disable-output-escaping="yes"/>
                                             </xsl:element>
                                             <xsl:element name="SCRIPT">
                                                <xsl:attribute name="language">JavaScript1.2</xsl:attribute>
                                                <![CDATA[   CKEDITOR.replace('Terms', { toolbar:'simple', height:160 } );  ]]>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:if>

                                    <xsl:if test="(/DATA/SYSTEM/@usergroup = 61)">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="width">600</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/TXN/PTSAFFILIATE/TERMS/comment()" disable-output-escaping="yes"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:if>

                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:attribute name="id">TabNotes</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:if test="(/DATA/SYSTEM/@usergroup != 61)">
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">600</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">2</xsl:attribute>
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="IFRAME">
                                             <xsl:attribute name="src">9011.asp?OwnerType=6&amp;OwnerID=<xsl:value-of select="/DATA/PARAM/@affiliateid"/>&amp;Title=<xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@AffiliateName"/></xsl:attribute>
                                             <xsl:attribute name="width">600</xsl:attribute>
                                             <xsl:attribute name="height">250</xsl:attribute>
                                             <xsl:attribute name="frmheight">250</xsl:attribute>
                                             <xsl:attribute name="id">NotesFrame</xsl:attribute>
                                             <xsl:attribute name="name">NotesFrame</xsl:attribute>
                                             <xsl:attribute name="frameborder">0</xsl:attribute>
                                             <xsl:element name="A">
                                                <xsl:attribute name="href">9011.asp?OwnerType=6&amp;OwnerID=<xsl:value-of select="/DATA/PARAM/@affiliateid"/>&amp;Title=<xsl:value-of select="/DATA/TXN/PTSAFFILIATE/@AffiliateName"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoFrameSupport']"/>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">2</xsl:attribute>
                                          <xsl:attribute name="height">6</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>

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
                              <xsl:if test="(/DATA/SYSTEM/@userstatus = 1)">
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Update']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick">doSubmit(1,"")</xsl:attribute>
                                 </xsl:element>
                              </xsl:if>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:if test="(/DATA/PARAM/@popup = 0)">
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Cancel']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick">doSubmit(3,"")</xsl:attribute>
                                 </xsl:element>
                              </xsl:if>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:if test="(/DATA/PARAM/@popup != 0)">
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Close']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[window.close()]]></xsl:text></xsl:attribute>
                                 </xsl:element>
                              </xsl:if>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:if test="(/DATA/SYSTEM/@userstatus = 1) and (/DATA/SYSTEM/@usergroup != 61)">
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