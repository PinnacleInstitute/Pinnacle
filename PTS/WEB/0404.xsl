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
         <xsl:with-param name="pagename" select="'Member Back-Office'"/>
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

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function CheckIdentity(){  
               var url, win
               url = "0426.asp?memberid=" + document.getElementById('MemberID').value;
                 win = window.open(url);
               win.focus();
             }]]></xsl:text>
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
               case -96:
                  url = "9603.asp?eventid=" + id + " &popup=1"
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

                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">MemberID</xsl:attribute>
                              <xsl:attribute name="id">MemberID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@memberid"/></xsl:attribute>
                           </xsl:element>

                        <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 41)">
                           <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">600</xsl:attribute>
                                    <xsl:attribute name="align">right</xsl:attribute>
                                    <xsl:attribute name="valign">bottom</xsl:attribute>
                                    <xsl:attribute name="class">PrevNext</xsl:attribute>
                                    <xsl:element name="A">
                                       <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                       <xsl:attribute name="href">0403.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Member']"/>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:if>

                           <xsl:if test="(count(/DATA/TXN/ICONS/ICON) &gt; 0)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="width">600</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="TABLE">
                                       <xsl:attribute name="border">0</xsl:attribute>
                                       <xsl:attribute name="cellpadding">0</xsl:attribute>
                                       <xsl:attribute name="cellspacing">0</xsl:attribute>
                                       <xsl:attribute name="width">600</xsl:attribute>

                                          <xsl:for-each select="/DATA/TXN/ICONS/ICON[position() mod 6 = 1]">
                                                <xsl:element name="TR">
                                                   <xsl:for-each select=".|following-sibling::ICON[position() &lt; 6]">
                                                         <xsl:if test="(@name != '')">
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">100</xsl:attribute>
                                                               <xsl:attribute name="align">center</xsl:attribute>
                                                               <xsl:attribute name="valign">center</xsl:attribute>
                                                               <xsl:if test="(@target )">
                                                                     <xsl:element name="A">
                                                                        <xsl:attribute name="onclick">w=window.open(this.href,"<xsl:value-of select="@target"/>","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                                        <xsl:attribute name="href"><xsl:value-of select="@url"/></xsl:attribute>
                                                                        <xsl:element name="IMG">
                                                                           <xsl:attribute name="src">Images/<xsl:value-of select="@file"/></xsl:attribute>
                                                                           <xsl:attribute name="border">0</xsl:attribute>
                                                                        </xsl:element>
                                                                     </xsl:element>
                                                               </xsl:if>
                                                               <xsl:if test="(not(@target) )">
                                                                     <xsl:element name="A">
                                                                        <xsl:attribute name="href"><xsl:value-of select="@url"/></xsl:attribute>
                                                                        <xsl:element name="IMG">
                                                                           <xsl:attribute name="src">Images/<xsl:value-of select="@file"/></xsl:attribute>
                                                                           <xsl:attribute name="border">0</xsl:attribute>
                                                                        </xsl:element>
                                                                     </xsl:element>
                                                               </xsl:if>
                                                                  <xsl:element name="BR"/>
                                                                  <xsl:element name="b">
                                                                  <xsl:variable name="tmp4"><xsl:value-of select="@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp4]"/>
                                                                  </xsl:element>
                                                            </xsl:element>
                                                         </xsl:if>
                                                   </xsl:for-each>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">6</xsl:attribute>
                                                      <xsl:attribute name="height">12</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                          </xsl:for-each>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>

                           </xsl:if>
                           <xsl:if test="(count(/DATA/TXN/PTSSHORTCUTS/PTSSHORTCUT) &gt; 0)">
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
                                                <xsl:attribute name="width">100</xsl:attribute>
                                                <xsl:attribute name="align">center</xsl:attribute>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">100</xsl:attribute>
                                                <xsl:attribute name="align">center</xsl:attribute>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">100</xsl:attribute>
                                                <xsl:attribute name="align">center</xsl:attribute>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">100</xsl:attribute>
                                                <xsl:attribute name="align">center</xsl:attribute>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">100</xsl:attribute>
                                                <xsl:attribute name="align">center</xsl:attribute>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">100</xsl:attribute>
                                                <xsl:attribute name="align">center</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:for-each select="/DATA/TXN/PTSSHORTCUTS/PTSSHORTCUT[position() mod 6 = 1]">
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">6</xsl:attribute>
                                                      <xsl:attribute name="height">3</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:for-each select=".|following-sibling::PTSSHORTCUT[position() &lt; 6]">
                                                         <xsl:element name="TD">
                                                            <xsl:attribute name="width">100</xsl:attribute>
                                                            <xsl:attribute name="align">center</xsl:attribute>
                                                            <xsl:attribute name="valign">top</xsl:attribute>
                                                            <xsl:if test="(@ispopup = 0)">
                                                                  <xsl:element name="A">
                                                                     <xsl:attribute name="href"><xsl:value-of select="@url"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                                     <xsl:element name="IMG">
                                                                        <xsl:attribute name="src">Images/entity<xsl:value-of select="@entityid"/>a.gif</xsl:attribute>
                                                                        <xsl:attribute name="border">0</xsl:attribute>
                                                                     </xsl:element>
                                                                  </xsl:element>
                                                            </xsl:if>
                                                            <xsl:if test="(@ispopup != 0)">
                                                                  <xsl:element name="A">
                                                                     <xsl:attribute name="onclick">w=window.open(this.href,"new","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                                     <xsl:attribute name="href"><xsl:value-of select="@url"/></xsl:attribute>
                                                                     <xsl:element name="IMG">
                                                                        <xsl:attribute name="src">Images/entity<xsl:value-of select="@entityid"/>a.gif</xsl:attribute>
                                                                        <xsl:attribute name="border">0</xsl:attribute>
                                                                     </xsl:element>
                                                                  </xsl:element>
                                                            </xsl:if>
                                                         </xsl:element>
                                                   </xsl:for-each>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:for-each select=".|following-sibling::PTSSHORTCUT[position() &lt; 6]">
                                                         <xsl:element name="TD">
                                                            <xsl:attribute name="width">100</xsl:attribute>
                                                            <xsl:attribute name="align">center</xsl:attribute>
                                                            <xsl:attribute name="valign">top</xsl:attribute>
                                                               <xsl:if test="(@ispopup = 0)">
                                                                  <xsl:element name="A">
                                                                     <xsl:attribute name="href"><xsl:value-of select="@url"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                                  <xsl:value-of select="@shortcutname"/>
                                                                  </xsl:element>
                                                               </xsl:if>
                                                               <xsl:if test="(@ispopup != 0)">
                                                                  <xsl:element name="A">
                                                                     <xsl:attribute name="onclick">w=window.open(this.href,"new","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                                     <xsl:attribute name="href"><xsl:value-of select="@url"/></xsl:attribute>
                                                                  <xsl:value-of select="@shortcutname"/>
                                                                  </xsl:element>
                                                               </xsl:if>
                                                         </xsl:element>
                                                   </xsl:for-each>
                                                </xsl:element>

                                          </xsl:for-each>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">1</xsl:attribute>
                                    <xsl:attribute name="height">3</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>

                           </xsl:if>
                           <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, 'i'))">
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
                                                <xsl:attribute name="width">365</xsl:attribute>
                                                <xsl:attribute name="align">center</xsl:attribute>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">5</xsl:attribute>
                                                <xsl:attribute name="align">center</xsl:attribute>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">230</xsl:attribute>
                                                <xsl:attribute name="align">center</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, '2'))">
                                             <xsl:element name="TR">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">355</xsl:attribute>
                                                   <xsl:attribute name="align">center</xsl:attribute>
                                                   <xsl:attribute name="valign">top</xsl:attribute>
                                                   <xsl:element name="TABLE">
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                      <xsl:attribute name="cellpadding">0</xsl:attribute>
                                                      <xsl:attribute name="cellspacing">0</xsl:attribute>
                                                      <xsl:attribute name="width">355</xsl:attribute>
                                                      <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>

                                                         <xsl:element name="TR">
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">355</xsl:attribute>
                                                               <xsl:attribute name="align">center</xsl:attribute>
                                                            </xsl:element>
                                                         </xsl:element>
                                                         <xsl:element name="TR">
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">355</xsl:attribute>
                                                               <xsl:attribute name="align">center</xsl:attribute>
                                                               <xsl:attribute name="valign">center</xsl:attribute>
                                                               <xsl:element name="TABLE">
                                                                  <xsl:attribute name="border">0</xsl:attribute>
                                                                  <xsl:attribute name="cellpadding">0</xsl:attribute>
                                                                  <xsl:attribute name="cellspacing">0</xsl:attribute>
                                                                  <xsl:attribute name="width">355</xsl:attribute>

                                                                     <xsl:element name="TR">
                                                                        <xsl:element name="TD">
                                                                           <xsl:attribute name="width">355</xsl:attribute>
                                                                           <xsl:attribute name="align">center</xsl:attribute>
                                                                        </xsl:element>
                                                                     </xsl:element>
                                                                     <xsl:element name="TR">
                                                                        <xsl:element name="TD">
                                                                           <xsl:attribute name="width">355</xsl:attribute>
                                                                           <xsl:attribute name="height">18</xsl:attribute>
                                                                           <xsl:attribute name="bgcolor">#D8EEFB</xsl:attribute>
                                                                           <xsl:attribute name="align">center</xsl:attribute>
                                                                           <xsl:attribute name="valign">middle</xsl:attribute>
                                                                              <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                              <xsl:element name="IMG">
                                                                                 <xsl:attribute name="src">Images/db-appts.gif</xsl:attribute>
                                                                                 <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                                 <xsl:attribute name="border">0</xsl:attribute>
                                                                              </xsl:element>
                                                                              <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                              <xsl:element name="b">
                                                                              <xsl:element name="font">
                                                                                 <xsl:attribute name="color">darkblue</xsl:attribute>
                                                                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Today']"/>
                                                                                 <xsl:text>:</xsl:text>
                                                                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                                                 <xsl:value-of select="/DATA/SYSTEM/@currdate"/>
                                                                              </xsl:element>
                                                                              </xsl:element>
                                                                        </xsl:element>
                                                                     </xsl:element>

                                                               </xsl:element>
                                                            </xsl:element>
                                                         </xsl:element>

                                                         <xsl:if test="(count(/DATA/TXN/PTSAPPTS/PTSAPPT) = 0)">
                                                            <xsl:element name="TR">
                                                               <xsl:element name="TD">
                                                                  <xsl:attribute name="colspan">1</xsl:attribute>
                                                                  <xsl:attribute name="height">12</xsl:attribute>
                                                               </xsl:element>
                                                            </xsl:element>
                                                            <xsl:element name="TR">
                                                               <xsl:element name="TD">
                                                                  <xsl:attribute name="width">355</xsl:attribute>
                                                                  <xsl:attribute name="align">center</xsl:attribute>
                                                                  <xsl:attribute name="valign">center</xsl:attribute>
                                                                  <xsl:element name="TABLE">
                                                                     <xsl:attribute name="border">0</xsl:attribute>
                                                                     <xsl:attribute name="cellpadding">0</xsl:attribute>
                                                                     <xsl:attribute name="cellspacing">0</xsl:attribute>
                                                                     <xsl:attribute name="width">355</xsl:attribute>

                                                                        <xsl:element name="TR">
                                                                           <xsl:element name="TD">
                                                                              <xsl:attribute name="width">355</xsl:attribute>
                                                                              <xsl:attribute name="align">center</xsl:attribute>
                                                                           </xsl:element>
                                                                        </xsl:element>
                                                                        <xsl:element name="TR">
                                                                           <xsl:element name="TD">
                                                                              <xsl:attribute name="width">355</xsl:attribute>
                                                                              <xsl:attribute name="align">center</xsl:attribute>
                                                                              <xsl:attribute name="valign">center</xsl:attribute>
                                                                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoAppts']"/>
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
                                                         </xsl:if>

                                                         <xsl:if test="(count(/DATA/TXN/PTSAPPTS/PTSAPPT) &gt; 0)">
                                                            <xsl:element name="TR">
                                                               <xsl:element name="TD">
                                                                  <xsl:attribute name="colspan">1</xsl:attribute>
                                                                  <xsl:element name="TABLE">
                                                                     <xsl:attribute name="border">0</xsl:attribute>
                                                                     <xsl:attribute name="cellpadding">0</xsl:attribute>
                                                                     <xsl:attribute name="cellspacing">0</xsl:attribute>
                                                                     <xsl:attribute name="width">355</xsl:attribute>
                                                                     <xsl:element name="TR">
                                                                        <xsl:element name="TD">
                                                                           <xsl:attribute name="width">355</xsl:attribute>
                                                                           <xsl:attribute name="align">center</xsl:attribute>
                                                                           <xsl:attribute name="valign">center</xsl:attribute>
                                                                           <xsl:element name="TABLE">
                                                                              <xsl:attribute name="border">0</xsl:attribute>
                                                                              <xsl:attribute name="cellpadding">0</xsl:attribute>
                                                                              <xsl:attribute name="cellspacing">0</xsl:attribute>
                                                                              <xsl:attribute name="width">355</xsl:attribute>
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
                                                                                          <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                                          <xsl:element name="IMG">
                                                                                             <xsl:attribute name="src">Images/appt<xsl:value-of select="@appttype"/>.gif</xsl:attribute>
                                                                                             <xsl:attribute name="border">0</xsl:attribute>
                                                                                          </xsl:element>
                                                                                       <xsl:if test="(@isplan != 0)">
<xsl:element name="IMG">
   <xsl:attribute name="src">Images/plan.gif</xsl:attribute>
   <xsl:attribute name="border">0</xsl:attribute>
</xsl:element>
                                                                                       </xsl:if>
                                                                                       <xsl:if test="(@recur != 0)">
<xsl:element name="IMG">
   <xsl:attribute name="src">Images/recur.gif</xsl:attribute>
   <xsl:attribute name="border">0</xsl:attribute>
</xsl:element>
                                                                                       </xsl:if>
                                                                                          <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                                       <xsl:if test="(@importance = 1)">
<xsl:element name="IMG">
   <xsl:attribute name="src">Images/apptlow.gif</xsl:attribute>
   <xsl:attribute name="border">0</xsl:attribute>
   <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ImportanceLow']"/></xsl:attribute>
   <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ImportanceLow']"/></xsl:attribute>
</xsl:element>
                                                                                       </xsl:if>
                                                                                       <xsl:if test="(@importance = 3)">
<xsl:element name="IMG">
   <xsl:attribute name="src">Images/appthigh.gif</xsl:attribute>
   <xsl:attribute name="border">0</xsl:attribute>
   <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ImportanceHigh']"/></xsl:attribute>
   <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ImportanceHigh']"/></xsl:attribute>
</xsl:element>
                                                                                       </xsl:if>
                                                                                       <xsl:if test="(@show = 2)">
<xsl:element name="IMG">
   <xsl:attribute name="src">Images/apptprivate.gif</xsl:attribute>
   <xsl:attribute name="border">0</xsl:attribute>
   <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ShowPrivate']"/></xsl:attribute>
   <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ShowPrivate']"/></xsl:attribute>
</xsl:element>
                                                                                       </xsl:if>
                                                                                       <xsl:if test="(@show = 3)">
<xsl:element name="IMG">
   <xsl:attribute name="src">Images/apptbusy.gif</xsl:attribute>
   <xsl:attribute name="border">0</xsl:attribute>
   <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ShowBusy']"/></xsl:attribute>
   <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ShowBusy']"/></xsl:attribute>
</xsl:element>
                                                                                       </xsl:if>
                                                                                          <xsl:element name="b">
                                                                                          <xsl:if test="(@appttype &gt;= 0)">
<xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
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
   <xsl:attribute name="border">0</xsl:attribute>
</xsl:element>
</xsl:if>
<xsl:if test="(@status = 2)">
<xsl:element name="IMG">
   <xsl:attribute name="src">Images/Appt3.gif</xsl:attribute>
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
                                                                  </xsl:element>
                                                               </xsl:element>
                                                            </xsl:element>

                                                         </xsl:if>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">5</xsl:attribute>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">230</xsl:attribute>
                                                   <xsl:attribute name="align">center</xsl:attribute>
                                                   <xsl:attribute name="valign">top</xsl:attribute>
                                                   <xsl:element name="TABLE">
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                      <xsl:attribute name="cellpadding">0</xsl:attribute>
                                                      <xsl:attribute name="cellspacing">0</xsl:attribute>
                                                      <xsl:attribute name="width">230</xsl:attribute>

                                                         <xsl:element name="TR">
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">230</xsl:attribute>
                                                               <xsl:attribute name="align">center</xsl:attribute>
                                                            </xsl:element>
                                                         </xsl:element>
                                                         <xsl:element name="TR">
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">230</xsl:attribute>
                                                               <xsl:attribute name="align">center</xsl:attribute>
                                                               <xsl:attribute name="valign">top</xsl:attribute>
                                                               <xsl:element name="TABLE">
                                                                  <xsl:attribute name="border">0</xsl:attribute>
                                                                  <xsl:attribute name="cellpadding">0</xsl:attribute>
                                                                  <xsl:attribute name="cellspacing">0</xsl:attribute>
                                                                  <xsl:attribute name="width">230</xsl:attribute>
                                                                  <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>

                                                                     <xsl:element name="TR">
                                                                        <xsl:element name="TD">
                                                                           <xsl:attribute name="width">230</xsl:attribute>
                                                                           <xsl:attribute name="align">center</xsl:attribute>
                                                                        </xsl:element>
                                                                     </xsl:element>
                                                                     <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, 'H'))">
                                                                        <xsl:element name="TR">
                                                                           <xsl:element name="TD">
                                                                              <xsl:attribute name="width">230</xsl:attribute>
                                                                              <xsl:attribute name="align">center</xsl:attribute>
                                                                              <xsl:attribute name="valign">center</xsl:attribute>
                                                                              <xsl:element name="TABLE">
                                                                                 <xsl:attribute name="border">0</xsl:attribute>
                                                                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                                                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                                                                 <xsl:attribute name="width">230</xsl:attribute>

                                                                                    <xsl:element name="TR">
                                                                                       <xsl:element name="TD">
                                                                                          <xsl:attribute name="width">230</xsl:attribute>
                                                                                          <xsl:attribute name="align">center</xsl:attribute>
                                                                                       </xsl:element>
                                                                                    </xsl:element>
                                                                                    <xsl:element name="TR">
                                                                                       <xsl:element name="TD">
                                                                                          <xsl:attribute name="width">230</xsl:attribute>
                                                                                          <xsl:attribute name="height">18</xsl:attribute>
                                                                                          <xsl:attribute name="bgcolor">#D8EEFB</xsl:attribute>
                                                                                          <xsl:attribute name="align">center</xsl:attribute>
                                                                                          <xsl:attribute name="valign">middle</xsl:attribute>
<xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
<xsl:element name="IMG">
   <xsl:attribute name="src">Images/db-goals.gif</xsl:attribute>
   <xsl:attribute name="align">absmiddle</xsl:attribute>
   <xsl:attribute name="border">0</xsl:attribute>
</xsl:element>
<xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                                             <xsl:element name="b">
                                                                                             <xsl:element name="font">
                                                                                                <xsl:attribute name="color">darkblue</xsl:attribute>
<xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SuccessTracks']"/>
                                                                                             </xsl:element>
                                                                                             </xsl:element>
                                                                                       </xsl:element>
                                                                                    </xsl:element>

                                                                              </xsl:element>
                                                                           </xsl:element>
                                                                        </xsl:element>

                                                                        <xsl:element name="TR">
                                                                           <xsl:element name="TD">
                                                                              <xsl:attribute name="width">230</xsl:attribute>
                                                                              <xsl:attribute name="align">center</xsl:attribute>
                                                                              <xsl:attribute name="valign">center</xsl:attribute>
                                                                              <xsl:element name="TABLE">
                                                                                 <xsl:attribute name="border">0</xsl:attribute>
                                                                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                                                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                                                                 <xsl:attribute name="width">230</xsl:attribute>

                                                                                    <xsl:element name="TR">
                                                                                       <xsl:element name="TD">
                                                                                          <xsl:attribute name="width">230</xsl:attribute>
                                                                                          <xsl:attribute name="align">left</xsl:attribute>
                                                                                       </xsl:element>
                                                                                    </xsl:element>
                                                                                    <xsl:if test="(count(/DATA/TXN/PTSGOALS/PTSGOAL) &gt; 0)">
                                                                                       <xsl:for-each select="/DATA/TXN/PTSGOALS/PTSGOAL">
<xsl:element name="TR">
<xsl:element name="TD">
   <xsl:attribute name="width">230</xsl:attribute>
   <xsl:attribute name="align">center</xsl:attribute>
   <xsl:attribute name="valign">center</xsl:attribute>
<xsl:element name="A">
   <xsl:attribute name="onclick">w=window.open(this.href,"Preview","");if (window.focus) {w.focus();};return false;</xsl:attribute>
   <xsl:attribute name="href">7050.asp?GoalID=<xsl:value-of select="@goalid"/></xsl:attribute>
   <xsl:value-of select="@goalname"/>
</xsl:element>
</xsl:element>
</xsl:element>

                                                                                       </xsl:for-each>
                                                                                    </xsl:if>
                                                                                    <xsl:element name="TR">
                                                                                       <xsl:element name="TD">
                                                                                          <xsl:attribute name="width">230</xsl:attribute>
                                                                                          <xsl:attribute name="align">center</xsl:attribute>
                                                                                          <xsl:attribute name="valign">center</xsl:attribute>
<xsl:element name="IMG">
   <xsl:attribute name="src">Images/db-newgoal.gif</xsl:attribute>
   <xsl:attribute name="align">absmiddle</xsl:attribute>
   <xsl:attribute name="border">0</xsl:attribute>
</xsl:element>
<xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
<xsl:element name="A">
   <xsl:attribute name="onclick">w=window.open(this.href,"Tracks","");if (window.focus) {w.focus();};return false;</xsl:attribute>
   <xsl:attribute name="href">7005.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;ContentPage=1&amp;Popup=1</xsl:attribute>
                                                                                             <xsl:element name="b">
<xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='JoinSuccessTrack']"/>
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

                                                                              </xsl:element>
                                                                           </xsl:element>
                                                                        </xsl:element>

                                                                     </xsl:if>
                                                               </xsl:element>
                                                            </xsl:element>
                                                         </xsl:element>

                                                         <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, 'g')) or (contains(/DATA/SYSTEM/@useroptions, 'G'))">
                                                            <xsl:element name="TR">
                                                               <xsl:element name="TD">
                                                                  <xsl:attribute name="colspan">1</xsl:attribute>
                                                                  <xsl:attribute name="height">6</xsl:attribute>
                                                               </xsl:element>
                                                            </xsl:element>
                                                            <xsl:element name="TR">
                                                               <xsl:element name="TD">
                                                                  <xsl:attribute name="width">230</xsl:attribute>
                                                                  <xsl:attribute name="align">center</xsl:attribute>
                                                                  <xsl:attribute name="valign">top</xsl:attribute>
                                                                  <xsl:element name="TABLE">
                                                                     <xsl:attribute name="border">0</xsl:attribute>
                                                                     <xsl:attribute name="cellpadding">0</xsl:attribute>
                                                                     <xsl:attribute name="cellspacing">0</xsl:attribute>
                                                                     <xsl:attribute name="width">230</xsl:attribute>
                                                                     <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>

                                                                        <xsl:element name="TR">
                                                                           <xsl:element name="TD">
                                                                              <xsl:attribute name="width">230</xsl:attribute>
                                                                              <xsl:attribute name="align">center</xsl:attribute>
                                                                           </xsl:element>
                                                                        </xsl:element>
                                                                        <xsl:element name="TR">
                                                                           <xsl:element name="TD">
                                                                              <xsl:attribute name="width">230</xsl:attribute>
                                                                              <xsl:attribute name="align">center</xsl:attribute>
                                                                              <xsl:attribute name="valign">center</xsl:attribute>
                                                                              <xsl:element name="TABLE">
                                                                                 <xsl:attribute name="border">0</xsl:attribute>
                                                                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                                                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                                                                 <xsl:attribute name="width">230</xsl:attribute>

                                                                                    <xsl:element name="TR">
                                                                                       <xsl:element name="TD">
                                                                                          <xsl:attribute name="width">230</xsl:attribute>
                                                                                          <xsl:attribute name="align">center</xsl:attribute>
                                                                                       </xsl:element>
                                                                                    </xsl:element>
                                                                                    <xsl:element name="TR">
                                                                                       <xsl:element name="TD">
                                                                                          <xsl:attribute name="width">230</xsl:attribute>
                                                                                          <xsl:attribute name="height">18</xsl:attribute>
                                                                                          <xsl:attribute name="bgcolor">#D8EEFB</xsl:attribute>
                                                                                          <xsl:attribute name="align">center</xsl:attribute>
                                                                                          <xsl:attribute name="valign">middle</xsl:attribute>
<xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
<xsl:element name="IMG">
   <xsl:attribute name="src">Images/db-mentor.gif</xsl:attribute>
   <xsl:attribute name="align">absmiddle</xsl:attribute>
   <xsl:attribute name="border">0</xsl:attribute>
</xsl:element>
<xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                                             <xsl:element name="b">
                                                                                             <xsl:element name="font">
                                                                                                <xsl:attribute name="color">darkblue</xsl:attribute>
<xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Mentoring']"/>
                                                                                             </xsl:element>
                                                                                             </xsl:element>
                                                                                       </xsl:element>
                                                                                    </xsl:element>

                                                                              </xsl:element>
                                                                           </xsl:element>
                                                                        </xsl:element>

                                                                        <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, 'g'))">
                                                                           <xsl:element name="TR">
                                                                              <xsl:element name="TD">
                                                                                 <xsl:attribute name="width">230</xsl:attribute>
                                                                                 <xsl:attribute name="align">center</xsl:attribute>
                                                                                 <xsl:attribute name="valign">center</xsl:attribute>
                                                                                    <xsl:element name="b">
                                                                                    <xsl:value-of select="/DATA/TXN/PTSDB/@mentorees"/>
                                                                                    </xsl:element>
                                                                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                                    <xsl:element name="A">
                                                                                       <xsl:attribute name="onclick">w=window.open(this.href,"Mentor","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                                                       <xsl:attribute name="href">0410.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;ContentPage=3&amp;Popup=1</xsl:attribute>
                                                                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Mentorees']"/>
                                                                                    </xsl:element>
                                                                              </xsl:element>
                                                                           </xsl:element>
                                                                        </xsl:if>

                                                                        <xsl:element name="TR">
                                                                           <xsl:element name="TD">
                                                                              <xsl:attribute name="width">230</xsl:attribute>
                                                                              <xsl:attribute name="align">center</xsl:attribute>
                                                                              <xsl:attribute name="valign">center</xsl:attribute>
                                                                                 <xsl:element name="b">
                                                                                 <xsl:value-of select="/DATA/TXN/PTSDB/@mentornotes"/>
                                                                                 </xsl:element>
                                                                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                              <xsl:if test="(/DATA/TXN/PTSDB/@mentornotes &gt; 0)">
                                                                                    <xsl:element name="IMG">
                                                                                       <xsl:attribute name="src">Images/NewNote.gif</xsl:attribute>
                                                                                       <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                                       <xsl:attribute name="border">0</xsl:attribute>
                                                                                    </xsl:element>
                                                                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                              </xsl:if>
                                                                                 <xsl:element name="A">
                                                                                    <xsl:attribute name="onclick">w=window.open(this.href,"Mentor","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                                                    <xsl:attribute name="href">0410.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;ContentPage=3&amp;Popup=1</xsl:attribute>
                                                                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MentoringNotes']"/>
                                                                                 </xsl:element>
                                                                           </xsl:element>
                                                                        </xsl:element>

                                                                  </xsl:element>
                                                               </xsl:element>
                                                            </xsl:element>

                                                         </xsl:if>
                                                         <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, 'E')) or (contains(/DATA/SYSTEM/@useroptions, '6'))">
                                                            <xsl:element name="TR">
                                                               <xsl:element name="TD">
                                                                  <xsl:attribute name="colspan">1</xsl:attribute>
                                                                  <xsl:attribute name="height">6</xsl:attribute>
                                                               </xsl:element>
                                                            </xsl:element>
                                                            <xsl:element name="TR">
                                                               <xsl:element name="TD">
                                                                  <xsl:attribute name="width">230</xsl:attribute>
                                                                  <xsl:attribute name="align">center</xsl:attribute>
                                                                  <xsl:attribute name="valign">top</xsl:attribute>
                                                                  <xsl:element name="TABLE">
                                                                     <xsl:attribute name="border">0</xsl:attribute>
                                                                     <xsl:attribute name="cellpadding">0</xsl:attribute>
                                                                     <xsl:attribute name="cellspacing">0</xsl:attribute>
                                                                     <xsl:attribute name="width">230</xsl:attribute>
                                                                     <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>

                                                                        <xsl:element name="TR">
                                                                           <xsl:element name="TD">
                                                                              <xsl:attribute name="width">230</xsl:attribute>
                                                                              <xsl:attribute name="align">center</xsl:attribute>
                                                                           </xsl:element>
                                                                        </xsl:element>
                                                                        <xsl:element name="TR">
                                                                           <xsl:element name="TD">
                                                                              <xsl:attribute name="width">230</xsl:attribute>
                                                                              <xsl:attribute name="align">center</xsl:attribute>
                                                                              <xsl:attribute name="valign">center</xsl:attribute>
                                                                              <xsl:element name="TABLE">
                                                                                 <xsl:attribute name="border">0</xsl:attribute>
                                                                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                                                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                                                                 <xsl:attribute name="width">230</xsl:attribute>

                                                                                    <xsl:element name="TR">
                                                                                       <xsl:element name="TD">
                                                                                          <xsl:attribute name="width">230</xsl:attribute>
                                                                                          <xsl:attribute name="align">center</xsl:attribute>
                                                                                       </xsl:element>
                                                                                    </xsl:element>
                                                                                    <xsl:element name="TR">
                                                                                       <xsl:element name="TD">
                                                                                          <xsl:attribute name="width">230</xsl:attribute>
                                                                                          <xsl:attribute name="height">18</xsl:attribute>
                                                                                          <xsl:attribute name="bgcolor">#D8EEFB</xsl:attribute>
                                                                                          <xsl:attribute name="align">center</xsl:attribute>
                                                                                          <xsl:attribute name="valign">middle</xsl:attribute>
<xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
<xsl:element name="IMG">
   <xsl:attribute name="src">Images/db-sales.gif</xsl:attribute>
   <xsl:attribute name="align">absmiddle</xsl:attribute>
   <xsl:attribute name="border">0</xsl:attribute>
</xsl:element>
<xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                                             <xsl:element name="b">
                                                                                             <xsl:element name="font">
                                                                                                <xsl:attribute name="color">darkblue</xsl:attribute>
<xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Sales']"/>
                                                                                             </xsl:element>
                                                                                             </xsl:element>
                                                                                       </xsl:element>
                                                                                    </xsl:element>

                                                                              </xsl:element>
                                                                           </xsl:element>
                                                                        </xsl:element>

                                                                        <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, 'E'))">
                                                                           <xsl:element name="TR">
                                                                              <xsl:element name="TD">
                                                                                 <xsl:attribute name="width">230</xsl:attribute>
                                                                                 <xsl:attribute name="align">center</xsl:attribute>
                                                                                 <xsl:attribute name="valign">center</xsl:attribute>
                                                                                    <xsl:element name="b">
                                                                                    <xsl:value-of select="/DATA/TXN/PTSDB/@prospects"/>
                                                                                    </xsl:element>
                                                                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                                    <xsl:element name="A">
                                                                                       <xsl:attribute name="onclick">w=window.open(this.href,"Sales","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                                                       <xsl:attribute name="href">8129.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;Rpt=1</xsl:attribute>
                                                                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewProspects']"/>
                                                                                    </xsl:element>
                                                                              </xsl:element>
                                                                           </xsl:element>

                                                                           <xsl:element name="TR">
                                                                              <xsl:element name="TD">
                                                                                 <xsl:attribute name="width">230</xsl:attribute>
                                                                                 <xsl:attribute name="align">center</xsl:attribute>
                                                                                 <xsl:attribute name="valign">center</xsl:attribute>
                                                                                    <xsl:element name="b">
                                                                                    <xsl:value-of select="/DATA/TXN/PTSDB/@prospects30"/>
                                                                                    </xsl:element>
                                                                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                                    <xsl:element name="A">
                                                                                       <xsl:attribute name="onclick">w=window.open(this.href,"Sales","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                                                       <xsl:attribute name="href">8129.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;Rpt=2</xsl:attribute>
                                                                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Prospects30']"/>
                                                                                    </xsl:element>
                                                                              </xsl:element>
                                                                           </xsl:element>

                                                                           <xsl:element name="TR">
                                                                              <xsl:element name="TD">
                                                                                 <xsl:attribute name="width">230</xsl:attribute>
                                                                                 <xsl:attribute name="align">center</xsl:attribute>
                                                                                 <xsl:attribute name="valign">center</xsl:attribute>
                                                                                    <xsl:element name="b">
                                                                                    <xsl:value-of select="/DATA/TXN/PTSDB/@prospectsactive"/>
                                                                                    </xsl:element>
                                                                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                                    <xsl:element name="A">
                                                                                       <xsl:attribute name="onclick">w=window.open(this.href,"Sales","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                                                       <xsl:attribute name="href">8129.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;Rpt=3</xsl:attribute>
                                                                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ActiveProspects']"/>
                                                                                    </xsl:element>
                                                                              </xsl:element>
                                                                           </xsl:element>

                                                                        </xsl:if>
                                                                        <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, '6'))">
                                                                           <xsl:element name="TR">
                                                                              <xsl:element name="TD">
                                                                                 <xsl:attribute name="width">230</xsl:attribute>
                                                                                 <xsl:attribute name="align">center</xsl:attribute>
                                                                                 <xsl:attribute name="valign">center</xsl:attribute>
                                                                                    <xsl:element name="b">
                                                                                    <xsl:value-of select="/DATA/TXN/PTSDB/@customers"/>
                                                                                    </xsl:element>
                                                                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                                    <xsl:element name="A">
                                                                                       <xsl:attribute name="onclick">w=window.open(this.href,"Service","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                                                       <xsl:attribute name="href">8151.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;CompanyID=<xsl:value-of select="/DATA/TXN/PTSMEMBER/@companyid"/>&amp;ContentPage=1&amp;Popup=1</xsl:attribute>
                                                                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TotalCustomers']"/>
                                                                                    </xsl:element>
                                                                              </xsl:element>
                                                                           </xsl:element>
                                                                        </xsl:if>

                                                                  </xsl:element>
                                                               </xsl:element>
                                                            </xsl:element>

                                                         </xsl:if>
                                                         <xsl:element name="TR">
                                                            <xsl:attribute name="height">10</xsl:attribute>
                                                         </xsl:element>

                                                   </xsl:element>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:if>

                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>

                           </xsl:if>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CompanyID</xsl:attribute>
                                 <xsl:attribute name="id">CompanyID</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@companyid"/></xsl:attribute>
                              </xsl:element>

                           <xsl:if test="(/DATA/PARAM/@identify != 0)">
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
                                       <xsl:attribute name="type">button</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IdentificationInfo']"/>
                                       </xsl:attribute>
                                       <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[CheckIdentity();]]></xsl:text></xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">1</xsl:attribute>
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:if>

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
                                 <xsl:value-of select="/DATA/TXN/PTSHTMLMEMBER/DATA/comment()" disable-output-escaping="yes"/>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/TXN/PTSHTMLFILE/DATA/comment()" disable-output-escaping="yes"/>
                              </xsl:element>
                           </xsl:element>

                           <xsl:if test="(/DATA/PARAM/@warn != 0)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">1</xsl:attribute>
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">600</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:value-of select="/DATA/TXN/PTSHTMLWARN/DATA/comment()" disable-output-escaping="yes"/>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">1</xsl:attribute>
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>

                           </xsl:if>
                        </xsl:if>
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