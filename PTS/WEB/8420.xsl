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
         <xsl:with-param name="pagename" select="'Conference Room'"/>
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
               <xsl:attribute name="name">Forum</xsl:attribute>
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
                              <xsl:attribute name="width">750</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">750</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">750</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">450</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="rowspan">2</xsl:attribute>
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/MessageBoard.gif</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">450</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">PageHeading</xsl:attribute>
                                             <xsl:value-of select="/DATA/TXN/PTSFORUM/@forumname"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ConferenceRoom']"/>
                                             <xsl:element name="BR"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">PageHeading</xsl:attribute>
                                          <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23) or (/DATA/SYSTEM/@usergroup = 51) or (/DATA/SYSTEM/@usergroup = 52)">
                                             <xsl:element name="A">
                                                <xsl:attribute name="href">8311.asp?ForumID=<xsl:value-of select="/DATA/TXN/PTSFORUM/@forumid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Moderators']"/>
                                             </xsl:element>
                                          </xsl:if>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">450</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">prompt</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ConferenceRoomText']"/>
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
                              <xsl:attribute name="width">750</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#000000</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">750</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">bottom</xsl:attribute>
                              <xsl:attribute name="class">PrevNext</xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@isforum != 0)">
                                 <xsl:element name="A">
                                    <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                    <xsl:attribute name="href">8411.asp?ForumID=<xsl:value-of select="/DATA/PARAM/@forumid"/>&amp;IsChat=1&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Forum']"/>
                                 </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;|&amp;#160;</xsl:text>
                              </xsl:if>
                              <xsl:if test="(/DATA/SYSTEM/@brduserid != 0)">
                                 <xsl:element name="A">
                                    <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                    <xsl:attribute name="href">8303.asp?BoardUserID=<xsl:value-of select="/DATA/TXN/PTSBOARDUSER/@boarduserid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EditUser']"/>
                                 </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;|&amp;#160;</xsl:text>
                              </xsl:if>
                              <xsl:element name="A">
                                 <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                 <xsl:attribute name="onclick">w=window.open(this.href,"Favorite","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                 <xsl:attribute name="href">4620.asp?MemberID=<xsl:value-of select="/DATA/SYSTEM/@memberid"/>&amp;RefType=3&amp;RefID=<xsl:value-of select="/DATA/PARAM/@forumid"/>&amp;Name=<xsl:value-of select="/DATA/TXN/PTSFORUM/@forumname"/></xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Favorite']"/>
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
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">750</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="APPLET">
                                 <xsl:attribute name="code">CoffeeTalk.class</xsl:attribute>
                                 <xsl:attribute name="codebase">include/chat</xsl:attribute>
                                 <xsl:attribute name="archive">smack.jar,smackx.jar,CoffeeTalk.jar</xsl:attribute>
                                 <xsl:attribute name="id">CoffeeTalk</xsl:attribute>
                                 <xsl:attribute name="name">CoffeeTalk</xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="height">400</xsl:attribute>
                                 <xsl:element name="PARAM">
                                    <xsl:attribute name="name">cabbase</xsl:attribute>
                                    <xsl:attribute name="value">CoffeeTalk.cab</xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="PARAM">
                                    <xsl:attribute name="name">server</xsl:attribute>
                                    <xsl:attribute name="value">web1.pinnaclep.com</xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="PARAM">
                                    <xsl:attribute name="name">classroom</xsl:attribute>
                                    <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@class"/></xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="PARAM">
                                    <xsl:attribute name="name">userid</xsl:attribute>
                                    <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSAUTHUSER/@logon"/></xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="PARAM">
                                    <xsl:attribute name="name">userpass</xsl:attribute>
                                    <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSAUTHUSER/@password"/></xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="PARAM">
                                    <xsl:attribute name="name">nickname</xsl:attribute>
                                    <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBOARDUSER/@boardusername"/></xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="PARAM">
                                    <xsl:attribute name="name">bgcolor</xsl:attribute>
                                    <xsl:attribute name="value">0xFFFFFF</xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="PARAM">
                                    <xsl:attribute name="name">chat_color</xsl:attribute>
                                    <xsl:attribute name="value">0x0AF00A</xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="PARAM">
                                    <xsl:attribute name="name">debug</xsl:attribute>
                                    <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@debug"/></xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="PARAM">
                                    <xsl:attribute name="name">moderator</xsl:attribute>
                                    <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@ismoderator"/></xsl:attribute>
                                 </xsl:element>
                              Error: could not load applet or object.
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
                              <xsl:element name="A">
                                 <xsl:attribute name="onclick">w=window.open(this.href,"Java","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                 <xsl:attribute name="href">http://java.com/en/index.jsp</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GetJava']"/>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="A">
                                 <xsl:attribute name="onclick">w=window.open(this.href,"Java","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                 <xsl:attribute name="href">http://java.com/en/index.jsp</xsl:attribute>
                                 <xsl:element name="IMG">
                                    <xsl:attribute name="src">http://java.sun.com/j2se/1.5.0/docs/guide/deployment/deployment-guide/upgrade-guide/images/get_java_red_button.gif</xsl:attribute>
                                    <xsl:attribute name="border">0</xsl:attribute>
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

               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="colspan">2</xsl:attribute>
                     <xsl:call-template name="PageFooter"/>
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