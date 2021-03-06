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
         <xsl:with-param name="pagename" select="'Goal Preview'"/>
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
               <xsl:attribute name="onload">document.getElementById('<xsl:value-of select="/DATA/TXN/PTSGOAL/@goalid"/>').focus()</xsl:attribute>
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
               <xsl:attribute name="name">Goal</xsl:attribute>
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
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">top</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">10</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">530</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">10</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">4</xsl:attribute>
                                          <xsl:attribute name="width">750</xsl:attribute>
                                          <xsl:attribute name="height">18</xsl:attribute>
                                          <xsl:attribute name="bgcolor">#D8EEFB</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">middle</xsl:attribute>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="src">Images/GoalPreview.gif</xsl:attribute>
                                                <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:element name="b">
                                             <xsl:element name="font">
                                                <xsl:attribute name="color">darkblue</xsl:attribute>
                                             <xsl:value-of select="/DATA/TXN/PTSGOAL/@goalname"/>
                                             </xsl:element>
                                             </xsl:element>
                                          <xsl:if test="(/DATA/SYSTEM/@usergroup != 41) or (contains(/DATA/SYSTEM/@useroptions, 's'))">
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="onclick">w=window.open(this.href,"shortcut","width=400, height=150");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                   <xsl:attribute name="href">9202.asp?EntityID=70&amp;ItemID=<xsl:value-of select="/DATA/TXN/PTSGOAL/@goalid"/>&amp;Name=<xsl:value-of select="translate(/DATA/TXN/PTSGOAL/@goalname,'&amp;',' ')"/>&amp;URL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;IsPopup=1</xsl:attribute>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/Shortcut.gif</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, 'U'))">
                                             <xsl:if test="(/DATA/TXN/PTSGOAL/@template = 0) or (/DATA/TXN/PTSGOAL/@template = 3)">
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="onclick">w=window.open(this.href,"Tutorial","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                      <xsl:attribute name="href">Tutorial.asp?Lesson=9&amp;contentpage=3&amp;popup=1</xsl:attribute>
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/Tutorial.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PinnacleTutorials']"/></xsl:attribute>
                                                         <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PinnacleTutorials']"/></xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                             </xsl:if>
                                          </xsl:if>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">10</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">530</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:if test="(/DATA/TXN/PTSGOAL/@prospectid != 0)">
                                                <xsl:element name="font">
                                                   <xsl:attribute name="color">purple</xsl:attribute>
                                                <xsl:value-of select="/DATA/TXN/PTSGOAL/@prospectname"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSGOAL/@status = 2) or (/DATA/TXN/PTSGOAL/@status = 3)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CommitDate']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/TXN/PTSGOAL/@commitdate"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSGOAL/@status = 3)">
                                             <xsl:if test="(/DATA/TXN/PTSGOAL/@variance &lt;= 0)">
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/GreenChecksm.gif</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="color">green</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSGOAL/@completedate"/>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      (<xsl:value-of select="/DATA/TXN/PTSGOAL/@variance"/>)
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSGOAL/@variance &gt; 0)">
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/RedChecksm.gif</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="color">red</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSGOAL/@completedate"/>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      (<xsl:value-of select="/DATA/TXN/PTSGOAL/@variance"/>)
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             </xsl:if>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSGOAL/@status &lt;= 1) or (/DATA/TXN/PTSGOAL/@status = 2)">
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">checkbox</xsl:attribute>
                                                <xsl:attribute name="name"><xsl:value-of select="/DATA/TXN/PTSGOAL/@goalid"/></xsl:attribute>
                                                <xsl:attribute name="id"><xsl:value-of select="/DATA/TXN/PTSGOAL/@goalid"/></xsl:attribute>
                                                </xsl:element>
                                                <xsl:if test="(/DATA/TXN/PTSGOAL/@status &lt;= 1)">
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="color">blue</xsl:attribute>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Start']"/>
                                                   </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(/DATA/TXN/PTSGOAL/@status = 2)">
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="color">green</xsl:attribute>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Complete']"/>
                                                   </xsl:element>
                                                </xsl:if>
                                          </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSGOAL/@qty != 0)">
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="class">smbutton</xsl:attribute>
                                                <xsl:attribute name="type">text</xsl:attribute>
                                                <xsl:attribute name="name">ActQty</xsl:attribute>
                                                <xsl:attribute name="id">ActQty</xsl:attribute>
                                                <xsl:attribute name="size">1</xsl:attribute>
                                                <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSGOAL/@actqty"/></xsl:attribute>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:if test="(/DATA/TXN/PTSGOAL/@actqty &lt; /DATA/TXN/PTSGOAL/@qty)">
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="color">red</xsl:attribute>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='of']"/>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/TXN/PTSGOAL/@qty"/>
                                                   </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(/DATA/TXN/PTSGOAL/@actqty &gt;= /DATA/TXN/PTSGOAL/@qty)">
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="color">green</xsl:attribute>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='of']"/>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/TXN/PTSGOAL/@qty"/>
                                                   </xsl:element>
                                                </xsl:if>
                                             </xsl:if>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="A">
                                                <xsl:attribute name="onclick">w=window.open(this.href,"Goal","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                <xsl:attribute name="href">7004.asp?GoalID=<xsl:value-of select="/DATA/TXN/PTSGOAL/@goalid"/>&amp;ContentPage=3&amp;Popup=1</xsl:attribute>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/GoalEdit.gif</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/></xsl:attribute>
                                                   <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/></xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="INPUT">
                                                <xsl:attribute name="type">button</xsl:attribute>
                                                <xsl:attribute name="class">smbutton</xsl:attribute>
                                                <xsl:attribute name="value">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Update']"/>
                                                </xsl:attribute>
                                                <xsl:attribute name="onclick">doSubmit(1,"")</xsl:attribute>
                                             </xsl:element>
                                             <xsl:element name="INPUT">
                                                <xsl:attribute name="type">button</xsl:attribute>
                                                <xsl:attribute name="class">smbutton</xsl:attribute>
                                                <xsl:attribute name="value">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Refresh']"/>
                                                </xsl:attribute>
                                                <xsl:attribute name="onclick">doSubmit(0,"")</xsl:attribute>
                                             </xsl:element>
                                             <xsl:element name="INPUT">
                                                <xsl:attribute name="type">button</xsl:attribute>
                                                <xsl:attribute name="class">smbutton</xsl:attribute>
                                                <xsl:attribute name="value">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Close']"/>
                                                </xsl:attribute>
                                                <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[window.close()]]></xsl:text></xsl:attribute>
                                             </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:if test="(/DATA/TXN/PTSGOAL/DESCRIPTION/comment() != '  ')">
                                       <xsl:if test="(/DATA/TXN/PTSGOAL/DESCRIPTION/comment() != '  ')">
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="colspan">4</xsl:attribute>
                                                <xsl:attribute name="height">3</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">10</xsl:attribute>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="colspan">2</xsl:attribute>
                                                <xsl:attribute name="width">730</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:value-of select="/DATA/TXN/PTSGOAL/DESCRIPTION/comment()" disable-output-escaping="yes"/>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="colspan">4</xsl:attribute>
                                                <xsl:attribute name="height">3</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:if>

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

                        <xsl:if test="(/DATA/PARAM/@count != 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">top</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">750</xsl:attribute>
                                    <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">50</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">50</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">50</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">50</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">550</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">5</xsl:attribute>
                                             <xsl:attribute name="width">750</xsl:attribute>
                                             <xsl:attribute name="height">18</xsl:attribute>
                                             <xsl:attribute name="bgcolor">#D8EEFB</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">middle</xsl:attribute>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/GoalChildren.gif</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="b">
                                                <xsl:element name="font">
                                                   <xsl:attribute name="color">darkblue</xsl:attribute>
                                                   <xsl:value-of select="/DATA/PARAM/@count" disable-output-escaping="yes"/>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Tasks']"/>
                                                </xsl:element>
                                                </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:for-each select="/DATA/TXN/PTSGOALS/PTSGOAL[(@parentid = /DATA/PARAM/@goalid)]">
                                             <xsl:element name="TR">
                                                <xsl:attribute name="class">graybar</xsl:attribute>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">50</xsl:attribute>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="colspan">4</xsl:attribute>
                                                   <xsl:attribute name="width">700</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="b">
                                                      <xsl:value-of select="@goalname"/>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:if test="(@status = 2) or (@status = 3)">
                                                         <xsl:value-of select="@commitdate"/>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   </xsl:if>
                                                   <xsl:if test="(@status = 3)">
                                                      <xsl:if test="(@variance &lt;= 0)">
                                                            <xsl:element name="IMG">
                                                               <xsl:attribute name="src">Images/GreenChecksm.gif</xsl:attribute>
                                                               <xsl:attribute name="border">0</xsl:attribute>
                                                            </xsl:element>
                                                            <xsl:element name="font">
                                                               <xsl:attribute name="color">green</xsl:attribute>
                                                               <xsl:value-of select="@completedate"/>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                               (<xsl:value-of select="@variance"/>)
                                                            </xsl:element>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      </xsl:if>
                                                      <xsl:if test="(@variance &gt; 0)">
                                                            <xsl:element name="IMG">
                                                               <xsl:attribute name="src">Images/RedChecksm.gif</xsl:attribute>
                                                               <xsl:attribute name="border">0</xsl:attribute>
                                                            </xsl:element>
                                                            <xsl:element name="font">
                                                               <xsl:attribute name="color">red</xsl:attribute>
                                                               <xsl:value-of select="@completedate"/>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                               (<xsl:value-of select="@variance"/>)
                                                            </xsl:element>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      </xsl:if>
                                                   </xsl:if>
                                                   <xsl:if test="(@status &lt;= 1) or (@status = 2)">
                                                         <xsl:element name="INPUT">
                                                         <xsl:attribute name="type">checkbox</xsl:attribute>
                                                         <xsl:attribute name="name"><xsl:value-of select="@goalid"/></xsl:attribute>
                                                         <xsl:attribute name="id"><xsl:value-of select="@goalid"/></xsl:attribute>
                                                         </xsl:element>
                                                         <xsl:if test="(@status &lt;= 1)">
                                                            <xsl:element name="font">
                                                               <xsl:attribute name="color">blue</xsl:attribute>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Start']"/>
                                                            </xsl:element>
                                                         </xsl:if>
                                                         <xsl:if test="(@status = 2)">
                                                            <xsl:element name="font">
                                                               <xsl:attribute name="color">green</xsl:attribute>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Complete']"/>
                                                            </xsl:element>
                                                         </xsl:if>
                                                   </xsl:if>
                                                      <xsl:if test="(@qty != 0)">
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                         <xsl:element name="INPUT">
                                                         <xsl:attribute name="class">smbutton</xsl:attribute>
                                                         <xsl:attribute name="type">text</xsl:attribute>
                                                         <xsl:attribute name="name">Q<xsl:value-of select="@goalid"/></xsl:attribute>
                                                         <xsl:attribute name="id">Q<xsl:value-of select="@goalid"/></xsl:attribute>
                                                         <xsl:attribute name="value"><xsl:value-of select="@actqty"/></xsl:attribute>
                                                         <xsl:attribute name="size">1</xsl:attribute>
                                                         </xsl:element>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                         <xsl:if test="(@actqty &lt; @qty)">
                                                            <xsl:element name="font">
                                                               <xsl:attribute name="color">red</xsl:attribute>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='of']"/>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            <xsl:value-of select="@qty"/>
                                                            </xsl:element>
                                                         </xsl:if>
                                                         <xsl:if test="(@actqty &gt;= @qty)">
                                                            <xsl:element name="font">
                                                               <xsl:attribute name="color">green</xsl:attribute>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='of']"/>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            <xsl:value-of select="@qty"/>
                                                            </xsl:element>
                                                         </xsl:if>
                                                      </xsl:if>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"Goal","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">7004.asp?GoalID=<xsl:value-of select="@goalid"/>&amp;ContentPage=3&amp;Popup=1</xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/GoalEdit.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                   <xsl:if test="(DESCRIPTION/comment() != '  ')">
                                                         <xsl:element name="BR"/>
                                                         <xsl:value-of select="DESCRIPTION/comment()" disable-output-escaping="yes"/>
                                                   </xsl:if>
                                                </xsl:element>
                                             </xsl:element>

                                             <xsl:element name="TR">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="colspan">5</xsl:attribute>
                                                   <xsl:attribute name="height">3</xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TR">
                                                <xsl:attribute name="class">graybar</xsl:attribute>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">50</xsl:attribute>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">700</xsl:attribute>
                                                   <xsl:attribute name="colspan">4</xsl:attribute>
                                                   <xsl:attribute name="height">1</xsl:attribute>
                                                   <xsl:attribute name="bgcolor">#5084A2</xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TR">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="colspan">5</xsl:attribute>
                                                   <xsl:attribute name="height">3</xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>

                                             <xsl:for-each select="/DATA/TXN/PTSGOALS/PTSGOAL[(@parentid = current()/@goalid)]">
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="colspan">2</xsl:attribute>
                                                         <xsl:attribute name="width">100</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="colspan">3</xsl:attribute>
                                                         <xsl:attribute name="width">650</xsl:attribute>
                                                         <xsl:attribute name="align">left</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                            <xsl:element name="b">
                                                            <xsl:value-of select="@goalname"/>
                                                            </xsl:element>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                         <xsl:if test="(@status = 2) or (@status = 3)">
                                                               <xsl:value-of select="@commitdate"/>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                         </xsl:if>
                                                         <xsl:if test="(@status = 3)">
                                                            <xsl:if test="(@variance &lt;= 0)">
                                                                  <xsl:element name="IMG">
                                                                     <xsl:attribute name="src">Images/GreenChecksm.gif</xsl:attribute>
                                                                     <xsl:attribute name="border">0</xsl:attribute>
                                                                  </xsl:element>
                                                                  <xsl:element name="font">
                                                                     <xsl:attribute name="color">green</xsl:attribute>
                                                                     <xsl:value-of select="@completedate"/>
                                                                     <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                     (<xsl:value-of select="@variance"/>)
                                                                  </xsl:element>
                                                                  <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            </xsl:if>
                                                            <xsl:if test="(@variance &gt; 0)">
                                                                  <xsl:element name="IMG">
                                                                     <xsl:attribute name="src">Images/RedChecksm.gif</xsl:attribute>
                                                                     <xsl:attribute name="border">0</xsl:attribute>
                                                                  </xsl:element>
                                                                  <xsl:element name="font">
                                                                     <xsl:attribute name="color">red</xsl:attribute>
                                                                     <xsl:value-of select="@completedate"/>
                                                                     <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                     (<xsl:value-of select="@variance"/>)
                                                                  </xsl:element>
                                                                  <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            </xsl:if>
                                                         </xsl:if>
                                                         <xsl:if test="(@status &lt;= 1) or (@status = 2)">
                                                               <xsl:element name="INPUT">
                                                               <xsl:attribute name="type">checkbox</xsl:attribute>
                                                               <xsl:attribute name="name"><xsl:value-of select="@goalid"/></xsl:attribute>
                                                               <xsl:attribute name="id"><xsl:value-of select="@goalid"/></xsl:attribute>
                                                               </xsl:element>
                                                               <xsl:if test="(@status &lt;= 1)">
                                                                  <xsl:element name="font">
                                                                     <xsl:attribute name="color">blue</xsl:attribute>
                                                                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Start']"/>
                                                                  </xsl:element>
                                                               </xsl:if>
                                                               <xsl:if test="(@status = 2)">
                                                                  <xsl:element name="font">
                                                                     <xsl:attribute name="color">green</xsl:attribute>
                                                                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Complete']"/>
                                                                  </xsl:element>
                                                               </xsl:if>
                                                         </xsl:if>
                                                            <xsl:if test="(@qty != 0)">
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                               <xsl:element name="INPUT">
                                                               <xsl:attribute name="type">text</xsl:attribute>
                                                               <xsl:attribute name="name">Q<xsl:value-of select="@goalid"/></xsl:attribute>
                                                               <xsl:attribute name="id">Q<xsl:value-of select="@goalid"/></xsl:attribute>
                                                               <xsl:attribute name="value"><xsl:value-of select="@actqty"/></xsl:attribute>
                                                               <xsl:attribute name="size">1</xsl:attribute>
                                                               </xsl:element>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                               <xsl:if test="(@actqty &lt; @qty)">
                                                                  <xsl:element name="font">
                                                                     <xsl:attribute name="color">red</xsl:attribute>
                                                                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='of']"/>
                                                                  <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                  <xsl:value-of select="@qty"/>
                                                                  </xsl:element>
                                                               </xsl:if>
                                                               <xsl:if test="(@actqty &gt;= @qty)">
                                                                  <xsl:element name="font">
                                                                     <xsl:attribute name="color">green</xsl:attribute>
                                                                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='of']"/>
                                                                  <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                  <xsl:value-of select="@qty"/>
                                                                  </xsl:element>
                                                               </xsl:if>
                                                            </xsl:if>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                            <xsl:element name="A">
                                                               <xsl:attribute name="onclick">w=window.open(this.href,"Goal","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                               <xsl:attribute name="href">7004.asp?GoalID=<xsl:value-of select="@goalid"/>&amp;ContentPage=3&amp;Popup=1</xsl:attribute>
                                                               <xsl:element name="IMG">
                                                                  <xsl:attribute name="src">Images/GoalEdit.gif</xsl:attribute>
                                                                  <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                  <xsl:attribute name="border">0</xsl:attribute>
                                                                  <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/></xsl:attribute>
                                                                  <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/></xsl:attribute>
                                                               </xsl:element>
                                                            </xsl:element>
                                                         <xsl:if test="(DESCRIPTION/comment() != '  ')">
                                                               <xsl:element name="BR"/>
                                                               <xsl:value-of select="DESCRIPTION/comment()" disable-output-escaping="yes"/>
                                                         </xsl:if>
                                                      </xsl:element>
                                                   </xsl:element>

                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="colspan">5</xsl:attribute>
                                                         <xsl:attribute name="height">3</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="colspan">2</xsl:attribute>
                                                         <xsl:attribute name="width">100</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">650</xsl:attribute>
                                                         <xsl:attribute name="colspan">3</xsl:attribute>
                                                         <xsl:attribute name="height">1</xsl:attribute>
                                                         <xsl:attribute name="bgcolor">#5084A2</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="colspan">5</xsl:attribute>
                                                         <xsl:attribute name="height">3</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>

                                                   <xsl:for-each select="/DATA/TXN/PTSGOALS/PTSGOAL[(@parentid = current()/@goalid)]">
                                                         <xsl:element name="TR">
                                                            <xsl:attribute name="class">graybar</xsl:attribute>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="colspan">3</xsl:attribute>
                                                               <xsl:attribute name="width">150</xsl:attribute>
                                                            </xsl:element>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="colspan">2</xsl:attribute>
                                                               <xsl:attribute name="width">600</xsl:attribute>
                                                               <xsl:attribute name="align">left</xsl:attribute>
                                                               <xsl:attribute name="valign">center</xsl:attribute>
                                                                  <xsl:element name="b">
                                                                  <xsl:value-of select="@goalname"/>
                                                                  </xsl:element>
                                                                  <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                               <xsl:if test="(@status = 2) or (@status = 3)">
                                                                     <xsl:value-of select="@commitdate"/>
                                                                     <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                               </xsl:if>
                                                               <xsl:if test="(@status = 3)">
                                                                  <xsl:if test="(@variance &lt;= 0)">
                                                                        <xsl:element name="IMG">
                                                                           <xsl:attribute name="src">Images/GreenChecksm.gif</xsl:attribute>
                                                                           <xsl:attribute name="border">0</xsl:attribute>
                                                                        </xsl:element>
                                                                        <xsl:element name="font">
                                                                           <xsl:attribute name="color">green</xsl:attribute>
                                                                           <xsl:value-of select="@completedate"/>
                                                                           <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                           (<xsl:value-of select="@variance"/>)
                                                                        </xsl:element>
                                                                        <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                  </xsl:if>
                                                                  <xsl:if test="(@variance &gt; 0)">
                                                                        <xsl:element name="IMG">
                                                                           <xsl:attribute name="src">Images/RedChecksm.gif</xsl:attribute>
                                                                           <xsl:attribute name="border">0</xsl:attribute>
                                                                        </xsl:element>
                                                                        <xsl:element name="font">
                                                                           <xsl:attribute name="color">red</xsl:attribute>
                                                                           <xsl:value-of select="@completedate"/>
                                                                           <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                           (<xsl:value-of select="@variance"/>)
                                                                        </xsl:element>
                                                                        <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                  </xsl:if>
                                                               </xsl:if>
                                                               <xsl:if test="(@status &lt;= 1) or (@status = 2)">
                                                                     <xsl:element name="INPUT">
                                                                     <xsl:attribute name="type">checkbox</xsl:attribute>
                                                                     <xsl:attribute name="name"><xsl:value-of select="@goalid"/></xsl:attribute>
                                                                     <xsl:attribute name="id"><xsl:value-of select="@goalid"/></xsl:attribute>
                                                                     </xsl:element>
                                                                     <xsl:if test="(@status &lt;= 1)">
                                                                        <xsl:element name="font">
                                                                           <xsl:attribute name="color">blue</xsl:attribute>
                                                                        <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Start']"/>
                                                                        </xsl:element>
                                                                     </xsl:if>
                                                                     <xsl:if test="(@status = 2)">
                                                                        <xsl:element name="font">
                                                                           <xsl:attribute name="color">green</xsl:attribute>
                                                                        <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Complete']"/>
                                                                        </xsl:element>
                                                                     </xsl:if>
                                                               </xsl:if>
                                                                  <xsl:if test="(@qty != 0)">
                                                                     <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                     <xsl:element name="INPUT">
                                                                     <xsl:attribute name="type">text</xsl:attribute>
                                                                     <xsl:attribute name="name">Q<xsl:value-of select="@goalid"/></xsl:attribute>
                                                                     <xsl:attribute name="id">Q<xsl:value-of select="@goalid"/></xsl:attribute>
                                                                     <xsl:attribute name="value"><xsl:value-of select="@actqty"/></xsl:attribute>
                                                                     <xsl:attribute name="size">1</xsl:attribute>
                                                                     </xsl:element>
                                                                     <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                     <xsl:if test="(@actqty &lt; @qty)">
                                                                        <xsl:element name="font">
                                                                           <xsl:attribute name="color">red</xsl:attribute>
                                                                        <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='of']"/>
                                                                        <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                        <xsl:value-of select="@qty"/>
                                                                        </xsl:element>
                                                                     </xsl:if>
                                                                     <xsl:if test="(@actqty &gt;= @qty)">
                                                                        <xsl:element name="font">
                                                                           <xsl:attribute name="color">green</xsl:attribute>
                                                                        <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='of']"/>
                                                                        <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                        <xsl:value-of select="@qty"/>
                                                                        </xsl:element>
                                                                     </xsl:if>
                                                                  </xsl:if>
                                                                  <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                                  <xsl:element name="A">
                                                                     <xsl:attribute name="onclick">w=window.open(this.href,"Goal","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                                     <xsl:attribute name="href">7004.asp?GoalID=<xsl:value-of select="@goalid"/>&amp;ContentPage=3&amp;Popup=1</xsl:attribute>
                                                                     <xsl:element name="IMG">
                                                                        <xsl:attribute name="src">Images/GoalEdit.gif</xsl:attribute>
                                                                        <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                        <xsl:attribute name="border">0</xsl:attribute>
                                                                        <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/></xsl:attribute>
                                                                        <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/></xsl:attribute>
                                                                     </xsl:element>
                                                                  </xsl:element>
                                                               <xsl:if test="(DESCRIPTION/comment() != '  ')">
                                                                     <xsl:element name="BR"/>
                                                                     <xsl:value-of select="DESCRIPTION/comment()" disable-output-escaping="yes"/>
                                                                     <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                               </xsl:if>
                                                            </xsl:element>
                                                         </xsl:element>

                                                         <xsl:element name="TR">
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="colspan">5</xsl:attribute>
                                                               <xsl:attribute name="height">3</xsl:attribute>
                                                            </xsl:element>
                                                         </xsl:element>
                                                         <xsl:element name="TR">
                                                            <xsl:attribute name="class">graybar</xsl:attribute>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="colspan">3</xsl:attribute>
                                                               <xsl:attribute name="width">150</xsl:attribute>
                                                            </xsl:element>
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="width">600</xsl:attribute>
                                                               <xsl:attribute name="colspan">2</xsl:attribute>
                                                               <xsl:attribute name="height">1</xsl:attribute>
                                                               <xsl:attribute name="bgcolor">#5084A2</xsl:attribute>
                                                            </xsl:element>
                                                         </xsl:element>
                                                         <xsl:element name="TR">
                                                            <xsl:element name="TD">
                                                               <xsl:attribute name="colspan">5</xsl:attribute>
                                                               <xsl:attribute name="height">3</xsl:attribute>
                                                            </xsl:element>
                                                         </xsl:element>

                                                         <xsl:for-each select="/DATA/TXN/PTSGOALS/PTSGOAL[(@parentid = current()/@goalid)]">
                                                               <xsl:element name="TR">
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="colspan">4</xsl:attribute>
                                                                     <xsl:attribute name="width">200</xsl:attribute>
                                                                  </xsl:element>
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="width">550</xsl:attribute>
                                                                     <xsl:attribute name="align">left</xsl:attribute>
                                                                     <xsl:attribute name="valign">center</xsl:attribute>
                                                                        <xsl:element name="b">
                                                                        <xsl:value-of select="@goalname"/>
                                                                        </xsl:element>
                                                                        <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                        <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                     <xsl:if test="(@status = 2) or (@status = 3)">
                                                                           <xsl:value-of select="@commitdate"/>
                                                                           <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                     </xsl:if>
                                                                     <xsl:if test="(@status = 3)">
                                                                        <xsl:if test="(@variance &lt;= 0)">
                                                                              <xsl:element name="IMG">
                                                                                 <xsl:attribute name="src">Images/GreenChecksm.gif</xsl:attribute>
                                                                                 <xsl:attribute name="border">0</xsl:attribute>
                                                                              </xsl:element>
                                                                              <xsl:element name="font">
                                                                                 <xsl:attribute name="color">green</xsl:attribute>
                                                                                 <xsl:value-of select="@completedate"/>
                                                                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                                 (<xsl:value-of select="@variance"/>)
                                                                              </xsl:element>
                                                                              <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                        </xsl:if>
                                                                        <xsl:if test="(@variance &gt; 0)">
                                                                              <xsl:element name="IMG">
                                                                                 <xsl:attribute name="src">Images/RedChecksm.gif</xsl:attribute>
                                                                                 <xsl:attribute name="border">0</xsl:attribute>
                                                                              </xsl:element>
                                                                              <xsl:element name="font">
                                                                                 <xsl:attribute name="color">red</xsl:attribute>
                                                                                 <xsl:value-of select="@completedate"/>
                                                                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                                 (<xsl:value-of select="@variance"/>)
                                                                              </xsl:element>
                                                                              <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                        </xsl:if>
                                                                     </xsl:if>
                                                                     <xsl:if test="(@status &lt;= 1) or (@status = 2)">
                                                                           <xsl:element name="INPUT">
                                                                           <xsl:attribute name="type">checkbox</xsl:attribute>
                                                                           <xsl:attribute name="name"><xsl:value-of select="@goalid"/></xsl:attribute>
                                                                           <xsl:attribute name="id"><xsl:value-of select="@goalid"/></xsl:attribute>
                                                                           </xsl:element>
                                                                           <xsl:if test="(@status &lt;= 1)">
                                                                              <xsl:element name="font">
                                                                                 <xsl:attribute name="color">blue</xsl:attribute>
                                                                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Start']"/>
                                                                              </xsl:element>
                                                                           </xsl:if>
                                                                           <xsl:if test="(@status = 2)">
                                                                              <xsl:element name="font">
                                                                                 <xsl:attribute name="color">green</xsl:attribute>
                                                                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Complete']"/>
                                                                              </xsl:element>
                                                                           </xsl:if>
                                                                     </xsl:if>
                                                                        <xsl:if test="(@qty != 0)">
                                                                           <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                           <xsl:element name="INPUT">
                                                                           <xsl:attribute name="type">text</xsl:attribute>
                                                                           <xsl:attribute name="name">Q<xsl:value-of select="@goalid"/></xsl:attribute>
                                                                           <xsl:attribute name="id">Q<xsl:value-of select="@goalid"/></xsl:attribute>
                                                                           <xsl:attribute name="value"><xsl:value-of select="@actqty"/></xsl:attribute>
                                                                           <xsl:attribute name="size">1</xsl:attribute>
                                                                           </xsl:element>
                                                                           <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                           <xsl:if test="(@actqty &lt; @qty)">
                                                                              <xsl:element name="font">
                                                                                 <xsl:attribute name="color">red</xsl:attribute>
                                                                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='of']"/>
                                                                              <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                              <xsl:value-of select="@qty"/>
                                                                              </xsl:element>
                                                                           </xsl:if>
                                                                           <xsl:if test="(@actqty &gt;= @qty)">
                                                                              <xsl:element name="font">
                                                                                 <xsl:attribute name="color">green</xsl:attribute>
                                                                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='of']"/>
                                                                              <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                              <xsl:value-of select="@qty"/>
                                                                              </xsl:element>
                                                                           </xsl:if>
                                                                        </xsl:if>
                                                                        <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                                        <xsl:element name="A">
                                                                           <xsl:attribute name="onclick">w=window.open(this.href,"Goal","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                                           <xsl:attribute name="href">7004.asp?GoalID=<xsl:value-of select="@goalid"/>&amp;ContentPage=3&amp;Popup=1</xsl:attribute>
                                                                           <xsl:element name="IMG">
                                                                              <xsl:attribute name="src">Images/GoalEdit.gif</xsl:attribute>
                                                                              <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                              <xsl:attribute name="border">0</xsl:attribute>
                                                                              <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/></xsl:attribute>
                                                                              <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/></xsl:attribute>
                                                                           </xsl:element>
                                                                        </xsl:element>
                                                                     <xsl:if test="(DESCRIPTION/comment() != '  ')">
                                                                           <xsl:element name="BR"/>
                                                                           <xsl:value-of select="DESCRIPTION/comment()" disable-output-escaping="yes"/>
                                                                     </xsl:if>
                                                                  </xsl:element>
                                                               </xsl:element>

                                                               <xsl:element name="TR">
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="colspan">5</xsl:attribute>
                                                                     <xsl:attribute name="height">3</xsl:attribute>
                                                                  </xsl:element>
                                                               </xsl:element>
                                                               <xsl:element name="TR">
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="colspan">4</xsl:attribute>
                                                                     <xsl:attribute name="width">200</xsl:attribute>
                                                                  </xsl:element>
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="width">550</xsl:attribute>
                                                                     <xsl:attribute name="height">1</xsl:attribute>
                                                                     <xsl:attribute name="bgcolor">#5084A2</xsl:attribute>
                                                                  </xsl:element>
                                                               </xsl:element>
                                                               <xsl:element name="TR">
                                                                  <xsl:element name="TD">
                                                                     <xsl:attribute name="colspan">5</xsl:attribute>
                                                                     <xsl:attribute name="height">3</xsl:attribute>
                                                                  </xsl:element>
                                                               </xsl:element>

                                                         </xsl:for-each>
                                                   </xsl:for-each>
                                             </xsl:for-each>
                                       </xsl:for-each>
                                 </xsl:element>
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
                              <xsl:attribute name="width">750</xsl:attribute>
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