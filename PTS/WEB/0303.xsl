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
         <xsl:with-param name="pagename" select="'Trainer'"/>
         <xsl:with-param name="includecalendar" select="true()"/>
         <xsl:with-param name="htmleditor">editor</xsl:with-param>
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
               <xsl:attribute name="onload">document.getElementById('CompanyName').focus()</xsl:attribute>
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
               <xsl:attribute name="name">Trainer</xsl:attribute>
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
                              <xsl:attribute name="width">160</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeading</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Trainer']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:value-of select="/DATA/TXN/PTSTRAINER/@companyname"/>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:if test="(/DATA/SYSTEM/@usergroup != 41) or (contains(/DATA/SYSTEM/@useroptions, 's'))">
                                 <xsl:element name="A">
                                    <xsl:attribute name="onclick">w=window.open(this.href,"shortcut","width=400, height=150");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                    <xsl:attribute name="href">9202.asp?EntityID=03&amp;ItemID=<xsl:value-of select="/DATA/TXN/PTSTRAINER/@trainerid"/>&amp;Name=<xsl:value-of select="translate(/DATA/TXN/PTSTRAINER/@companyname,'&amp;',' ')"/>&amp;URL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                    <xsl:element name="IMG">
                                       <xsl:attribute name="src">Images/Shortcut.gif</xsl:attribute>
                                       <xsl:attribute name="border">0</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:if>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23) and (/DATA/SYSTEM/@userstatus = 1)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">160</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">bottom</xsl:attribute>
                                 <xsl:attribute name="class">PrevNext</xsl:attribute>
                                 <xsl:element name="A">
                                    <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                    <xsl:attribute name="href">1112.asp?TrainerID=<xsl:value-of select="/DATA/TXN/PTSTRAINER/@trainerid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Courses']"/>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;|&amp;#160;</xsl:text>
                                 <xsl:element name="A">
                                    <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                    <xsl:attribute name="href">3111.asp?TrainerID=<xsl:value-of select="/DATA/TXN/PTSTRAINER/@trainerid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Assessments']"/>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;|&amp;#160;</xsl:text>
                                 <xsl:element name="A">
                                    <xsl:attribute name="onclick">w=window.open(this.href,"Attachments","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                    <xsl:attribute name="href">8001.asp?TrainerID=<xsl:value-of select="/DATA/TXN/PTSTRAINER/@trainerid"/></xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Attachments']"/>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;|&amp;#160;</xsl:text>
                                 <xsl:element name="A">
                                    <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                    <xsl:attribute name="href">0911.asp?OwnerType=3&amp;OwnerID=<xsl:value-of select="/DATA/TXN/PTSTRAINER/@trainerid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Commissions']"/>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;|&amp;#160;</xsl:text>
                                 <xsl:element name="A">
                                    <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                    <xsl:attribute name="href">0811.asp?OwnerType=3&amp;OwnerID=<xsl:value-of select="/DATA/TXN/PTSTRAINER/@trainerid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Payouts']"/>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;|&amp;#160;</xsl:text>
                                 <xsl:if test="(/DATA/TXN/PTSTRAINER/@usergroup != 0)">
                                    <xsl:element name="A">
                                       <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                       <xsl:attribute name="href">0104.asp?AuthUserID=<xsl:value-of select="/DATA/TXN/PTSTRAINER/@authuserid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ResetLogon']"/>
                                    </xsl:element>
                                 </xsl:if>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

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
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">160</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IMG">
                                 <xsl:attribute name="src">Images/record.gif</xsl:attribute>
                                 <xsl:attribute name="border">0</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">Prompt</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EditTrainerText']"/>
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

                        <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 21)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">160</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SponsorID']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">SponsorID</xsl:attribute>
                                 <xsl:attribute name="id">SponsorID</xsl:attribute>
                                 <xsl:attribute name="size">6</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSTRAINER/@sponsorid"/></xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="A">
                                    <xsl:attribute name="href">0403.asp?MemberID=<xsl:value-of select="/DATA/TXN/PTSTRAINER/@sponsorid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                    <xsl:value-of select="/DATA/TXN/PTSTRAINER/@sponsorname"/>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/SYSTEM/@usergroup &gt; 21)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">160</xsl:attribute>
                                 <xsl:attribute name="height">18</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SponsorName']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="b">
                                 <xsl:value-of select="/DATA/TXN/PTSTRAINER/@sponsorname"/>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">SponsorID</xsl:attribute>
                                 <xsl:attribute name="id">SponsorID</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSTRAINER/@sponsorid"/></xsl:attribute>
                              </xsl:element>

                        </xsl:if>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">160</xsl:attribute>
                              <xsl:attribute name="height">18</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TrainerID']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="b">
                              <xsl:value-of select="/DATA/TXN/PTSTRAINER/@trainerid"/>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">160</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CompanyName']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">CompanyName</xsl:attribute>
                              <xsl:attribute name="id">CompanyName</xsl:attribute>
                              <xsl:attribute name="size">60</xsl:attribute>
                              <xsl:attribute name="maxlength">60</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSTRAINER/@companyname"/></xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23)">
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
                                    <xsl:for-each select="/DATA/TXN/PTSTRAINER/PTSSTATUSS/ENUM">
                                       <xsl:element name="OPTION">
                                          <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                          <xsl:if test="@selected"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:variable name="tmp1"><xsl:value-of select="current()/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp1]"/>
                                       </xsl:element>
                                    </xsl:for-each>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="SELECT">
                                    <xsl:attribute name="name">Tier</xsl:attribute>
                                    <xsl:attribute name="id">Tier</xsl:attribute>
                                    <xsl:for-each select="/DATA/TXN/PTSTRAINER/PTSTIERS/ENUM">
                                       <xsl:element name="OPTION">
                                          <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                          <xsl:if test="@selected"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:variable name="tmp2"><xsl:value-of select="current()/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp2]"/>
                                       </xsl:element>
                                    </xsl:for-each>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">EnrollDate</xsl:attribute>
                                 <xsl:attribute name="id">EnrollDate</xsl:attribute>
                                 <xsl:attribute name="size">10</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSTRAINER/@enrolldate"/></xsl:attribute>
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
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:element name="IMG">
                                    <xsl:attribute name="src">Images/Required.gif</xsl:attribute>
                                    <xsl:attribute name="alt">Required Field</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="(/DATA/SYSTEM/@usergroup &gt; 23)">
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Status</xsl:attribute>
                              <xsl:attribute name="id">Status</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSTRAINER/@status"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Tier</xsl:attribute>
                              <xsl:attribute name="id">Tier</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSTRAINER/@tier"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">EnrollDate</xsl:attribute>
                              <xsl:attribute name="id">EnrollDate</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSTRAINER/@enrolldate"/></xsl:attribute>
                           </xsl:element>
                        </xsl:if>

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
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TrainerName']"/>
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
                                       <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSTRAINER/@namefirst"/></xsl:attribute>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/Required.gif</xsl:attribute>
                                          <xsl:attribute name="alt">Required Field</xsl:attribute>
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
                                       <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSTRAINER/@namelast"/></xsl:attribute>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/Required.gif</xsl:attribute>
                                          <xsl:attribute name="alt">Required Field</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

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
                              <xsl:attribute name="size">40</xsl:attribute>
                              <xsl:attribute name="maxlength">80</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSTRAINER/@email"/></xsl:attribute>
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
                                       <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSTRAINER/@street"/></xsl:attribute>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/Required.gif</xsl:attribute>
                                          <xsl:attribute name="alt">Required Field</xsl:attribute>
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
                                       <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSTRAINER/@unit"/></xsl:attribute>
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
                                       <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSTRAINER/@city"/></xsl:attribute>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/Required.gif</xsl:attribute>
                                          <xsl:attribute name="alt">Required Field</xsl:attribute>
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
                                       <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSTRAINER/@state"/></xsl:attribute>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/Required.gif</xsl:attribute>
                                          <xsl:attribute name="alt">Required Field</xsl:attribute>
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
                                       <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSTRAINER/@zip"/></xsl:attribute>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/Required.gif</xsl:attribute>
                                          <xsl:attribute name="alt">Required Field</xsl:attribute>
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
                                       <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSTRAINER/@country"/></xsl:attribute>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/Required.gif</xsl:attribute>
                                          <xsl:attribute name="alt">Required Field</xsl:attribute>
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
                              <xsl:attribute name="size">15</xsl:attribute>
                              <xsl:attribute name="maxlength">30</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSTRAINER/@phone1"/></xsl:attribute>
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
                              <xsl:attribute name="size">15</xsl:attribute>
                              <xsl:attribute name="maxlength">30</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSTRAINER/@phone2"/></xsl:attribute>
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
                              <xsl:attribute name="size">15</xsl:attribute>
                              <xsl:attribute name="maxlength">30</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSTRAINER/@fax"/></xsl:attribute>
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
                              <xsl:attribute name="size">40</xsl:attribute>
                              <xsl:attribute name="maxlength">80</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSTRAINER/@website"/></xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">160</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='URL']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">URL</xsl:attribute>
                                 <xsl:attribute name="id">URL</xsl:attribute>
                                 <xsl:attribute name="size">60</xsl:attribute>
                                 <xsl:attribute name="maxlength">80</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSTRAINER/@url"/></xsl:attribute>
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
                              <xsl:attribute name="width">160</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
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
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">button</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Cancel']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick">doSubmit(3,"")</xsl:attribute>
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
                              <xsl:attribute name="class">Prompt</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ImageHelp']"/>
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
                              <xsl:attribute name="width">160</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">bottom</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Image']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">button</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Upload']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick">doSubmit(6,"")</xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:if test="(/DATA/TXN/PTSTRAINER/@image != '')">
                                 <xsl:element name="IMG">
                                    <xsl:attribute name="src">Images/Trainer/<xsl:value-of select="/DATA/TXN/PTSTRAINER/@image"/></xsl:attribute>
                                    <xsl:attribute name="width">100</xsl:attribute>
                                    <xsl:attribute name="border">0</xsl:attribute>
                                 </xsl:element>
                              </xsl:if>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
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
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TEXTAREA">
                                 <xsl:attribute name="name">Data</xsl:attribute>
                                 <xsl:attribute name="id">Data</xsl:attribute>
                                 <xsl:attribute name="rows">25</xsl:attribute>
                                 <xsl:attribute name="cols">72</xsl:attribute>
                                 <xsl:value-of select="/DATA/TXN/PTSHTMLFILE/DATA/comment()" disable-output-escaping="yes"/>
                              </xsl:element>
                              <xsl:element name="SCRIPT">
                                 <xsl:attribute name="language">JavaScript1.2</xsl:attribute>
                                 <![CDATA[   CKEDITOR.replace('Data', { height:500 } );  ]]>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23)">
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
                                 <xsl:element name="IFRAME">
                                    <xsl:attribute name="src">9011.asp?Height=150&amp;OwnerType=3&amp;OwnerID=<xsl:value-of select="/DATA/PARAM/@trainerid"/>&amp;Title=<xsl:value-of select="/DATA/TXN/PTSTRAINER/@trainername"/></xsl:attribute>
                                    <xsl:attribute name="width">600</xsl:attribute>
                                    <xsl:attribute name="height">150</xsl:attribute>
                                    <xsl:attribute name="frmheight">150</xsl:attribute>
                                    <xsl:attribute name="id">NotesFrame</xsl:attribute>
                                    <xsl:attribute name="name">NotesFrame</xsl:attribute>
                                    <xsl:attribute name="class">FrameNoScroll</xsl:attribute>
                                    <xsl:attribute name="frameborder">0</xsl:attribute>
                                    <xsl:element name="A">
                                       <xsl:attribute name="href">9011.asp?Height=150&amp;OwnerType=3&amp;OwnerID=<xsl:value-of select="/DATA/PARAM/@trainerid"/>&amp;Title=<xsl:value-of select="/DATA/TXN/PTSTRAINER/@trainername"/></xsl:attribute>
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
                                    <xsl:for-each select="/DATA/TXN/PTSTRAINER/PTSUSERGROUPS/ENUM">
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
                                    <xsl:for-each select="/DATA/TXN/PTSTRAINER/PTSUSERSTATUSS/ENUM">
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
                        <xsl:if test="(/DATA/SYSTEM/@usergroup &gt; 23)">
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">URL</xsl:attribute>
                                 <xsl:attribute name="id">URL</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSTRAINER/@url"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">UserGroup</xsl:attribute>
                                 <xsl:attribute name="id">UserGroup</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSTRAINER/@usergroup"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">UserStatus</xsl:attribute>
                                 <xsl:attribute name="id">UserStatus</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSTRAINER/@userstatus"/></xsl:attribute>
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
                              <xsl:attribute name="width">160</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
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
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">button</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Cancel']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick">doSubmit(3,"")</xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 21) and (/DATA/SYSTEM/@userstatus = 1)">
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