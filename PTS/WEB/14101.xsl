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
         <xsl:with-param name="pagename" select="/DATA/LANGUAGE/LABEL[@name='Friend']"/>
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
               <xsl:attribute name="onload">document.getElementById('SearchText').focus()</xsl:attribute>
            </xsl:otherwise>
         </xsl:choose>

         <!--BEGIN PAGE-->
      <xsl:element name="DIV">
         <xsl:attribute name="id">wrapper600</xsl:attribute>
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
               <xsl:attribute name="name">Friend</xsl:attribute>
               <xsl:attribute name="method">post</xsl:attribute>

               <xsl:element name="INPUT">
                  <xsl:attribute name="type">hidden</xsl:attribute>
                  <xsl:attribute name="name">ActionCode</xsl:attribute>
                  <xsl:attribute name="id">ActionCode</xsl:attribute>
                  <xsl:attribute name="value"><xsl:value-of select="5"/></xsl:attribute>
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
                                          <xsl:attribute name="width">75</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">250</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">275</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">75</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/Friend48.gif</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">250</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">PageHeading</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FindFriend']"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">275</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="src">Images/addnew.gif</xsl:attribute>
                                                <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:element name="A">
                                                <xsl:attribute name="href">14102.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewFriend']"/>
                                             </xsl:element>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="src">Images/friend.gif</xsl:attribute>
                                                <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:element name="A">
                                                <xsl:attribute name="href">14211.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FriendGroups']"/>
                                             </xsl:element>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="src">Images/import.gif</xsl:attribute>
                                                <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:element name="A">
                                                <xsl:attribute name="onclick">w=window.open(this.href,"import","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                <xsl:attribute name="href">14106.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/></xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ImportFriends']"/>
                                             </xsl:element>
                                             </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">2</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#000000</xsl:attribute>
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
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="b">
                                 <xsl:if test="(/DATA/PARAM/@friendcount = 0)">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoFriendGroups']"/>
                                 </xsl:if>
                              <xsl:if test="(/DATA/PARAM/@friendcount != 0)">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='YouHave']"/>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:value-of select="/DATA/PARAM/@friendcount" disable-output-escaping="yes"/>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FriendGroupsDefined']"/>
                              </xsl:if>
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
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">prompt</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FriendsText']"/>
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
                              <xsl:attribute name="colspan">2</xsl:attribute>
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

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">ColumnHeader</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SearchBy']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="SELECT">
                                 <xsl:attribute name="name">FindTypeID</xsl:attribute>
                                 <xsl:attribute name="id">FindTypeID</xsl:attribute>
                                 <xsl:for-each select="/DATA/TXN/PTSFRIENDS/PTSFINDTYPEIDS/ENUM">
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                       <xsl:if test="@selected"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:variable name="tmp2"><xsl:value-of select="current()/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp2]"/>
                                    </xsl:element>
                                 </xsl:for-each>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SearchFor']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">SearchText</xsl:attribute>
                              <xsl:attribute name="id">SearchText</xsl:attribute>
                              <xsl:attribute name="size">20</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/BOOKMARK/@searchtext"/></xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">submit</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Go']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick">doSubmit(5,"")</xsl:attribute>
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
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:call-template name="PreviousNext"/>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="width">33%</xsl:attribute>
                                       <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                       <xsl:attribute name="valign">Bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FriendName']"/>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="width">43%</xsl:attribute>
                                       <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                       <xsl:attribute name="valign">Bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Email']"/>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="width">12%</xsl:attribute>
                                       <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                       <xsl:attribute name="valign">Bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FriendDate']"/>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="width">12%</xsl:attribute>
                                       <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                       <xsl:attribute name="valign">Bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Status']"/>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">4</xsl:attribute>
                                       <xsl:attribute name="height">2</xsl:attribute>
                                       <xsl:attribute name="bgcolor">#CCCCCC</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>

                                 <xsl:for-each select="/DATA/TXN/PTSFRIENDS/PTSFRIEND">
                                    <xsl:if test="(@status = 1)">
                                       <xsl:element name="TR">
                                          <xsl:attribute name="height">24</xsl:attribute>
                                          <xsl:if test="(position() mod 2)=1">
                                             <xsl:attribute name="class">GrayBar</xsl:attribute>
                                          </xsl:if>
                                          <xsl:if test="(position() mod 2)=0">
                                             <xsl:attribute name="class">WhiteBar</xsl:attribute>
                                          </xsl:if>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="font">
                                                   <xsl:attribute name="color">orange</xsl:attribute>
                                                <xsl:value-of select="@friendname"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">14103.asp?FriendID=<xsl:value-of select="@friendid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/Edit.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                      <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/></xsl:attribute>
                                                      <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/></xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="font">
                                                <xsl:attribute name="color">orange</xsl:attribute>
                                             <xsl:value-of select="@email"/>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="font">
                                                <xsl:attribute name="color">orange</xsl:attribute>
                                             <xsl:value-of select="@frienddate"/>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="font">
                                                <xsl:attribute name="color">orange</xsl:attribute>
                                             <xsl:variable name="tmp5"><xsl:value-of select="../PTSSTATUSS/ENUM[@id=current()/@status]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp5]"/>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:if>
                                    <xsl:if test="(@status = 2)">
                                       <xsl:element name="TR">
                                          <xsl:attribute name="height">24</xsl:attribute>
                                          <xsl:if test="(position() mod 2)=1">
                                             <xsl:attribute name="class">GrayBar</xsl:attribute>
                                          </xsl:if>
                                          <xsl:if test="(position() mod 2)=0">
                                             <xsl:attribute name="class">WhiteBar</xsl:attribute>
                                          </xsl:if>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="@friendname"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">14103.asp?FriendID=<xsl:value-of select="@friendid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/Edit.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                      <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/></xsl:attribute>
                                                      <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/></xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="@email"/>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="@frienddate"/>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:variable name="tmp5"><xsl:value-of select="../PTSSTATUSS/ENUM[@id=current()/@status]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp5]"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:if>
                                    <xsl:if test="(@status &gt; 2)">
                                       <xsl:element name="TR">
                                          <xsl:attribute name="height">24</xsl:attribute>
                                          <xsl:if test="(position() mod 2)=1">
                                             <xsl:attribute name="class">GrayBar</xsl:attribute>
                                          </xsl:if>
                                          <xsl:if test="(position() mod 2)=0">
                                             <xsl:attribute name="class">WhiteBar</xsl:attribute>
                                          </xsl:if>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="font">
                                                   <xsl:attribute name="color">red</xsl:attribute>
                                                <xsl:value-of select="@friendname"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">14103.asp?FriendID=<xsl:value-of select="@friendid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/Edit.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                      <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/></xsl:attribute>
                                                      <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/></xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="font">
                                                <xsl:attribute name="color">red</xsl:attribute>
                                             <xsl:value-of select="@email"/>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="font">
                                                <xsl:attribute name="color">red</xsl:attribute>
                                             <xsl:value-of select="@frienddate"/>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="font">
                                                <xsl:attribute name="color">red</xsl:attribute>
                                             <xsl:variable name="tmp5"><xsl:value-of select="../PTSSTATUSS/ENUM[@id=current()/@status]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp5]"/>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:if>
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
                                          <xsl:element name="font">
                                             <xsl:attribute name="color">gray</xsl:attribute>
                                             <xsl:value-of select="@friendgroupname"/>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">3</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="font">
                                             <xsl:attribute name="color">gray</xsl:attribute>
                                             <xsl:value-of select="@dob"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:value-of select="@zip"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:value-of select="@countryname"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:for-each>
                                 <xsl:choose>
                                    <xsl:when test="(count(/DATA/TXN/PTSFRIENDS/PTSFRIEND) = 0)">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">4</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="class">NoItems</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoItems']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:when>
                                 </xsl:choose>

                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">4</xsl:attribute>
                                       <xsl:attribute name="height">2</xsl:attribute>
                                       <xsl:attribute name="bgcolor">#CCCCCC</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>

                              </xsl:element>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="height">2</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">25%</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="class">PrevNext</xsl:attribute>
                                       <xsl:if test="/DATA/BOOKMARK/@next='False'">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EndOfList']"/>
                                       </xsl:if>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">75%</xsl:attribute>
                                       <xsl:attribute name="align">right</xsl:attribute>
                                       <xsl:call-template name="PreviousNext"/>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="height">4</xsl:attribute>
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