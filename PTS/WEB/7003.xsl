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
         <xsl:with-param name="pagename" select="'Goal Details'"/>
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
               <xsl:attribute name="name">Goal</xsl:attribute>
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
                              <xsl:attribute name="width">140</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">460</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">ContentPage</xsl:attribute>
                              <xsl:attribute name="id">ContentPage</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@contentpage"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Popup</xsl:attribute>
                              <xsl:attribute name="id">Popup</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@popup"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">MemberID</xsl:attribute>
                              <xsl:attribute name="id">MemberID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@memberid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">ProspectID</xsl:attribute>
                              <xsl:attribute name="id">ProspectID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@prospectid"/></xsl:attribute>
                           </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">top</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="style">border: 1px #62B462 solid</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">10</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">430</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">150</xsl:attribute>
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
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="height">18</xsl:attribute>
                                          <xsl:attribute name="bgcolor">#D8EEFB</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">middle</xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:element name="font">
                                                <xsl:attribute name="color">darkblue</xsl:attribute>
                                             <xsl:if test="(/DATA/TXN/PTSGOAL/@template = 0)">
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/Goalsm.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Goal']"/>
                                                   <xsl:text>:</xsl:text>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/TXN/PTSGOAL/@goalname"/>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSGOAL/@template = 1) or (/DATA/TXN/PTSGOAL/@template = 2)">
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/Template.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Track']"/>
                                                   <xsl:text>:</xsl:text>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/TXN/PTSGOAL/@goalname"/>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSGOAL/@template = 3)">
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/Goalsm.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Task']"/>
                                                   <xsl:text>:</xsl:text>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/TXN/PTSGOAL/@goalname"/>
                                             </xsl:if>
                                                <xsl:if test="(/DATA/TXN/PTSGOAL/@qty != 0) and (/DATA/TXN/PTSGOAL/@template != 1) and (/DATA/TXN/PTSGOAL/@template != 2)">
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:if test="(/DATA/TXN/PTSGOAL/@actqty &lt; /DATA/TXN/PTSGOAL/@qty)">
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">red</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSGOAL/@actqty"/>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='of']"/>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:value-of select="/DATA/TXN/PTSGOAL/@qty"/>
                                                      </xsl:element>
                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/TXN/PTSGOAL/@actqty &gt;= /DATA/TXN/PTSGOAL/@qty)">
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">green</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSGOAL/@actqty"/>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='of']"/>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:value-of select="/DATA/TXN/PTSGOAL/@qty"/>
                                                      </xsl:element>
                                                   </xsl:if>
                                                </xsl:if>
                                             <xsl:if test="(/DATA/SYSTEM/@usergroup != 41) or (contains(/DATA/SYSTEM/@useroptions, 's'))">
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="onclick">w=window.open(this.href,"shortcut","width=400, height=150");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                      <xsl:attribute name="href">9202.asp?EntityID=70&amp;ItemID=<xsl:value-of select="/DATA/TXN/PTSGOAL/@goalid"/>&amp;Name=<xsl:value-of select="translate(/DATA/TXN/PTSGOAL/@goalname,'&amp;',' ')"/>&amp;URL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/Shortcut.gif</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                             </xsl:if>
                                             </xsl:element>
                                             </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:if test="(/DATA/TXN/PTSGOAL/DESCRIPTION/comment() != '  ')">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">10</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">3</xsl:attribute>
                                             <xsl:attribute name="width">590</xsl:attribute>
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
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">600</xsl:attribute>
                                             <xsl:attribute name="colspan">4</xsl:attribute>
                                             <xsl:attribute name="height">1</xsl:attribute>
                                             <xsl:attribute name="bgcolor">#62B462</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">4</xsl:attribute>
                                             <xsl:attribute name="height">3</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>

                                    </xsl:if>
                                    <xsl:if test="(/DATA/TXN/PTSGOAL/@template = 1) or (/DATA/TXN/PTSGOAL/@template = 2)">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">10</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="width">580</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CreateDate']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSGOAL/@createdate"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='RemindDate']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSGOAL/@reminddate"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="width">160</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">top</xsl:attribute>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="onclick">w=window.open(this.href,"Preview","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                   <xsl:attribute name="href">7012.asp?GoalID=<xsl:value-of select="/DATA/TXN/PTSGOAL/@goalid"/></xsl:attribute>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/GoalPreviewmd.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                      <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Preview']"/></xsl:attribute>
                                                      <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Preview']"/></xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">7004.asp?GoalID=<xsl:value-of select="/DATA/TXN/PTSGOAL/@goalid"/>&amp;ContentPage=<xsl:value-of select="/DATA/PARAM/@contentpage"/>&amp;Popup=<xsl:value-of select="/DATA/PARAM/@popup"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/GoalEdit1.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                      <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/></xsl:attribute>
                                                      <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/></xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:if>

                                    <xsl:if test="(/DATA/TXN/PTSGOAL/@template != 1) and (/DATA/TXN/PTSGOAL/@template != 2)">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">10</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="width">580</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CommitDate']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSGOAL/@commitdate"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CompleteDate']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSGOAL/@completedate"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="BR"/>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='RemindDate']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSGOAL/@reminddate"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GoalType']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="b">
                                                <xsl:variable name="tmp8"><xsl:value-of select="/DATA/TXN/PTSGOAL/PTSGOALTYPES/ENUM[@id=/DATA/TXN/PTSGOAL/@goaltype]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp8]"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Priority']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="b">
                                                <xsl:variable name="tmp10"><xsl:value-of select="/DATA/TXN/PTSGOAL/PTSPRIORITYS/ENUM[@id=/DATA/TXN/PTSGOAL/@priority]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp10]"/>
                                                </xsl:element>
                                                <xsl:element name="BR"/>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='#']"/>
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSGOAL/@goalid"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AssignName']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="font">
                                                   <xsl:attribute name="color">blue</xsl:attribute>
                                                <xsl:value-of select="/DATA/TXN/PTSGOAL/@assignname"/>
                                                </xsl:element>
                                             <xsl:if test="(/DATA/TXN/PTSGOAL/@prospectid != 0)">
                                                   <xsl:element name="b">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Service']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"Prospect","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">8153.asp?ProspectID=<xsl:value-of select="/DATA/TXN/PTSGOAL/@prospectid"/>&amp;ContentPage=3&amp;Popup=1</xsl:attribute>
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">purple</xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSGOAL/@prospectname"/>
                                                      </xsl:element>
                                                      </xsl:element>
                                                   </xsl:element>
                                             </xsl:if>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="width">160</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">top</xsl:attribute>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="onclick">w=window.open(this.href,"Preview","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                   <xsl:attribute name="href">7050.asp?GoalID=<xsl:value-of select="/DATA/TXN/PTSGOAL/@goalid"/></xsl:attribute>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/GoalPreviewmd.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                      <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Preview']"/></xsl:attribute>
                                                      <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Preview']"/></xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:if test="(/DATA/TXN/PTSGOAL/@status = 0) or (/DATA/TXN/PTSGOAL/@status = 1)">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="href">7003.asp?GoalID=<xsl:value-of select="/DATA/TXN/PTSGOAL/@goalid"/>&amp;UpdateGoalID=<xsl:value-of select="/DATA/TXN/PTSGOAL/@goalid"/>&amp;ContentPage=<xsl:value-of select="/DATA/PARAM/@contentpage"/>&amp;Popup=<xsl:value-of select="/DATA/PARAM/@popup"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@returnurl"/></xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/GoalStart1.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Start']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Start']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(/DATA/TXN/PTSGOAL/@status = 2)">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="href">7003.asp?GoalID=<xsl:value-of select="/DATA/TXN/PTSGOAL/@goalid"/>&amp;UpdateGoalID=<xsl:value-of select="/DATA/TXN/PTSGOAL/@goalid"/>&amp;ContentPage=<xsl:value-of select="/DATA/PARAM/@contentpage"/>&amp;Popup=<xsl:value-of select="/DATA/PARAM/@popup"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@returnurl"/></xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/GoalComplete1.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Complete']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Complete']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(/DATA/TXN/PTSGOAL/@status != 0)">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="href">7003.asp?GoalID=<xsl:value-of select="/DATA/TXN/PTSGOAL/@goalid"/>&amp;UpdateGoalID=<xsl:value-of select="/DATA/TXN/PTSGOAL/@goalid"/>&amp;ClearGoal=1&amp;ContentPage=<xsl:value-of select="/DATA/PARAM/@contentpage"/>&amp;Popup=<xsl:value-of select="/DATA/PARAM/@popup"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@returnurl"/></xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/GoalClear1.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Clear']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Clear']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="href">7004.asp?GoalID=<xsl:value-of select="/DATA/TXN/PTSGOAL/@goalid"/>&amp;ContentPage=<xsl:value-of select="/DATA/PARAM/@contentpage"/>&amp;Popup=<xsl:value-of select="/DATA/PARAM/@popup"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/GoalEdit1.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/></xsl:attribute>
                                                         <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/></xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:if>

                              </xsl:element>
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
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">button</xsl:attribute>
                                 <xsl:attribute name="class">smbutton</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewSubGoal']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick">doSubmit(4,"")</xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:if test="(/DATA/PARAM/@popup = 0)">
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="class">smbutton</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Return']"/>
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
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">3</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/PARAM/@count != 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">top</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">600</xsl:attribute>
                                    <xsl:attribute name="style">border: 1px #62B462 solid</xsl:attribute>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">600</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">600</xsl:attribute>
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
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="align">left</xsl:attribute>
                                                      <xsl:attribute name="width">48%</xsl:attribute>
                                                      <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                                      <xsl:attribute name="valign">Bottom</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GoalNames']"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="width">12%</xsl:attribute>
                                                      <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                                      <xsl:attribute name="valign">Bottom</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Projected']"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="width">12%</xsl:attribute>
                                                      <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                                      <xsl:attribute name="valign">Bottom</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Actual']"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="width">8%</xsl:attribute>
                                                      <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                                      <xsl:attribute name="valign">Bottom</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Variance']"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="width">12%</xsl:attribute>
                                                      <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                                      <xsl:attribute name="valign">Bottom</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Reminder']"/>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="width">8%</xsl:attribute>
                                                      <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                                      <xsl:attribute name="valign">Bottom</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Priority']"/>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">6</xsl:attribute>
                                                      <xsl:attribute name="height">2</xsl:attribute>
                                                      <xsl:attribute name="bgcolor">#CCCCCC</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:for-each select="/DATA/TXN/PTSGOALS/PTSGOAL">
                                                   <xsl:element name="TR">
                                                      <xsl:attribute name="height">15</xsl:attribute>
                                                      <xsl:if test="(position() mod 2)=1">
                                                         <xsl:attribute name="class">GrayBar</xsl:attribute>
                                                      </xsl:if>
                                                      <xsl:if test="(position() mod 2)=0">
                                                         <xsl:attribute name="class">WhiteBar</xsl:attribute>
                                                      </xsl:if>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="align">left</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:if test="(@completedate != '') and (@status != 4)">
                                                               <xsl:if test="(@variance &lt;= 0)">
                                                                  <xsl:element name="IMG">
                                                                     <xsl:attribute name="src">Images/GreenChecksm.gif</xsl:attribute>
                                                                     <xsl:attribute name="border">0</xsl:attribute>
                                                                  </xsl:element>
                                                               </xsl:if>
                                                               <xsl:if test="(@variance &gt; 0)">
                                                                  <xsl:element name="IMG">
                                                                     <xsl:attribute name="src">Images/RedChecksm.gif</xsl:attribute>
                                                                     <xsl:attribute name="border">0</xsl:attribute>
                                                                  </xsl:element>
                                                               </xsl:if>
                                                         </xsl:if>
                                                            <xsl:if test="(@status = 4)">
                                                               <xsl:element name="IMG">
                                                                  <xsl:attribute name="src">Images/RedX.gif</xsl:attribute>
                                                                  <xsl:attribute name="border">0</xsl:attribute>
                                                               </xsl:element>
                                                            </xsl:if>
                                                            <xsl:if test="(@parentid = 0)">
                                                               <xsl:element name="IMG">
                                                                  <xsl:attribute name="src">Images/Primary.gif</xsl:attribute>
                                                                  <xsl:attribute name="border">0</xsl:attribute>
                                                               </xsl:element>
                                                            </xsl:if>
                                                            <xsl:element name="A">
                                                               <xsl:attribute name="href">7003.asp?GoalID=<xsl:value-of select="@goalid"/>&amp;ContentPage=<xsl:value-of select="/DATA/PARAM/@contentpage"/>&amp;Popup=<xsl:value-of select="/DATA/PARAM/@popup"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                                            <xsl:element name="b">
                                                            <xsl:element name="font">
                                                               <xsl:attribute name="color">purple</xsl:attribute>
                                                            <xsl:value-of select="@goalname"/>
                                                            </xsl:element>
                                                            </xsl:element>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            </xsl:element>
                                                         <xsl:if test="(@children != 0)">
                                                               <xsl:element name="IMG">
                                                                  <xsl:attribute name="src">Images/GoalChildren.gif</xsl:attribute>
                                                                  <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                  <xsl:attribute name="border">0</xsl:attribute>
                                                               </xsl:element>
                                                         </xsl:if>
                                                            <xsl:element name="b">
                                                            <xsl:if test="(/DATA/TXN/PTSGOAL/@template != 1) and (/DATA/TXN/PTSGOAL/@template != 2)">
                                                                  <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                  <xsl:element name="A">
                                                                     <xsl:attribute name="onclick">w=window.open(this.href,"Preview","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                                     <xsl:attribute name="href">7050.asp?GoalID=<xsl:value-of select="@goalid"/></xsl:attribute>
                                                                     <xsl:element name="IMG">
                                                                        <xsl:attribute name="src">Images/GoalPreview.gif</xsl:attribute>
                                                                        <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                        <xsl:attribute name="border">0</xsl:attribute>
                                                                        <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Preview']"/></xsl:attribute>
                                                                        <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Preview']"/></xsl:attribute>
                                                                     </xsl:element>
                                                                  </xsl:element>
                                                               <xsl:if test="(@status = 0) or (/DATA/TXN/PTSGOAL/@status = 1)">
                                                                     <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                     <xsl:element name="A">
                                                                        <xsl:attribute name="href">7003.asp?GoalID=<xsl:value-of select="/DATA/TXN/PTSGOAL/@goalid"/>&amp;UpdateGoalID=<xsl:value-of select="@goalid"/>&amp;ContentPage=<xsl:value-of select="/DATA/PARAM/@contentpage"/>&amp;Popup=<xsl:value-of select="/DATA/PARAM/@popup"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@returnurl"/></xsl:attribute>
                                                                        <xsl:element name="IMG">
                                                                           <xsl:attribute name="src">Images/GoalStart.gif</xsl:attribute>
                                                                           <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                           <xsl:attribute name="border">0</xsl:attribute>
                                                                           <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Start']"/></xsl:attribute>
                                                                           <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Start']"/></xsl:attribute>
                                                                        </xsl:element>
                                                                     </xsl:element>
                                                               </xsl:if>
                                                               <xsl:if test="(@status = 2)">
                                                                     <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                     <xsl:element name="A">
                                                                        <xsl:attribute name="href">7003.asp?GoalID=<xsl:value-of select="/DATA/TXN/PTSGOAL/@goalid"/>&amp;UpdateGoalID=<xsl:value-of select="@goalid"/>&amp;ContentPage=<xsl:value-of select="/DATA/PARAM/@contentpage"/>&amp;Popup=<xsl:value-of select="/DATA/PARAM/@popup"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@returnurl"/></xsl:attribute>
                                                                        <xsl:element name="IMG">
                                                                           <xsl:attribute name="src">Images/GoalComplete.gif</xsl:attribute>
                                                                           <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                           <xsl:attribute name="border">0</xsl:attribute>
                                                                           <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Complete']"/></xsl:attribute>
                                                                           <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Complete']"/></xsl:attribute>
                                                                        </xsl:element>
                                                                     </xsl:element>
                                                               </xsl:if>
                                                               <xsl:if test="(@status != 0)">
                                                                     <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                     <xsl:element name="A">
                                                                        <xsl:attribute name="href">7003.asp?GoalID=<xsl:value-of select="/DATA/TXN/PTSGOAL/@goalid"/>&amp;UpdateGoalID=<xsl:value-of select="@goalid"/>&amp;ClearGoal=1&amp;ContentPage=<xsl:value-of select="/DATA/PARAM/@contentpage"/>&amp;Popup=<xsl:value-of select="/DATA/PARAM/@popup"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@returnurl"/></xsl:attribute>
                                                                        <xsl:element name="IMG">
                                                                           <xsl:attribute name="src">Images/GoalClear.gif</xsl:attribute>
                                                                           <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                           <xsl:attribute name="border">0</xsl:attribute>
                                                                           <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Clear']"/></xsl:attribute>
                                                                           <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Clear']"/></xsl:attribute>
                                                                        </xsl:element>
                                                                     </xsl:element>
                                                               </xsl:if>
                                                            </xsl:if>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                               <xsl:element name="A">
                                                                  <xsl:attribute name="href">7004.asp?GoalID=<xsl:value-of select="@goalid"/>&amp;ContentPage=<xsl:value-of select="/DATA/PARAM/@contentpage"/>&amp;Popup=<xsl:value-of select="/DATA/PARAM/@popup"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                                                  <xsl:element name="IMG">
                                                                     <xsl:attribute name="src">Images/GoalEdit.gif</xsl:attribute>
                                                                     <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                     <xsl:attribute name="border">0</xsl:attribute>
                                                                     <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/></xsl:attribute>
                                                                     <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/></xsl:attribute>
                                                                  </xsl:element>
                                                               </xsl:element>
                                                            </xsl:element>
                                                            <xsl:if test="(@qty != 0)">
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                               <xsl:if test="(@actqty &lt; @qty)">
                                                                  <xsl:element name="font">
                                                                     <xsl:attribute name="color">red</xsl:attribute>
                                                                  <xsl:value-of select="@actqty"/>
                                                                  <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='of']"/>
                                                                  <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                  <xsl:value-of select="@qty"/>
                                                                  </xsl:element>
                                                               </xsl:if>
                                                               <xsl:if test="(@actqty &gt;= @qty)">
                                                                  <xsl:element name="font">
                                                                     <xsl:attribute name="color">green</xsl:attribute>
                                                                  <xsl:value-of select="@actqty"/>
                                                                  <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='of']"/>
                                                                  <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                  <xsl:value-of select="@qty"/>
                                                                  </xsl:element>
                                                               </xsl:if>
                                                            </xsl:if>
                                                      </xsl:element>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="align">center</xsl:attribute>
                                                         <xsl:attribute name="valign">top</xsl:attribute>
                                                         <xsl:value-of select="@commitdate"/>
                                                      </xsl:element>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="align">center</xsl:attribute>
                                                         <xsl:attribute name="valign">top</xsl:attribute>
                                                         <xsl:value-of select="@completedate"/>
                                                      </xsl:element>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="align">center</xsl:attribute>
                                                         <xsl:attribute name="valign">top</xsl:attribute>
                                                         <xsl:if test="(@completedate != '')">
                                                               <xsl:if test="(@variance &lt; 0)">
                                                                  <xsl:element name="font">
                                                                     <xsl:attribute name="color">green</xsl:attribute>
                                                                  <xsl:value-of select="@variance"/>
                                                                  </xsl:element>
                                                               </xsl:if>
                                                               <xsl:if test="(@variance = 0)">
                                                                  <xsl:value-of select="@variance"/>
                                                               </xsl:if>
                                                               <xsl:if test="(@variance &gt; 0)">
                                                                  <xsl:element name="font">
                                                                     <xsl:attribute name="color">red</xsl:attribute>
                                                                  <xsl:value-of select="@variance"/>
                                                                  </xsl:element>
                                                               </xsl:if>
                                                         </xsl:if>
                                                      </xsl:element>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="align">center</xsl:attribute>
                                                         <xsl:attribute name="valign">top</xsl:attribute>
                                                         <xsl:value-of select="@reminddate"/>
                                                      </xsl:element>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="align">center</xsl:attribute>
                                                         <xsl:attribute name="valign">top</xsl:attribute>
                                                         <xsl:variable name="tmp6"><xsl:value-of select="../PTSPRIORITYS/ENUM[@id=current()/@priority]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp6]"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:if test="(DESCRIPTION/comment() != '  ')">
                                                      <xsl:element name="TR">
                                                         <xsl:if test="(position() mod 2)=1">
                                                            <xsl:attribute name="class">GrayBar</xsl:attribute>
                                                         </xsl:if>
                                                         <xsl:if test="(position() mod 2)=0">
                                                            <xsl:attribute name="class">WhiteBar</xsl:attribute>
                                                         </xsl:if>
                                                         <xsl:element name="TD">
                                                            <xsl:attribute name="colspan">6</xsl:attribute>
                                                            <xsl:attribute name="align">left</xsl:attribute>
                                                            <xsl:attribute name="valign">center</xsl:attribute>
                                                            <xsl:value-of select="DESCRIPTION/comment()" disable-output-escaping="yes"/>
                                                         </xsl:element>
                                                      </xsl:element>
                                                   </xsl:if>
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                      <xsl:if test="(position() mod 2)=1">
                                                         <xsl:attribute name="class">GrayBar</xsl:attribute>
                                                      </xsl:if>
                                                      <xsl:if test="(position() mod 2)=0">
                                                         <xsl:attribute name="class">WhiteBar</xsl:attribute>
                                                      </xsl:if>
                                                         <xsl:attribute name="colspan">2</xsl:attribute>
                                                         <xsl:attribute name="height">3</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TR">
                                                      <xsl:if test="(position() mod 2)=1">
                                                         <xsl:attribute name="class">GrayBar</xsl:attribute>
                                                      </xsl:if>
                                                      <xsl:if test="(position() mod 2)=0">
                                                         <xsl:attribute name="class">WhiteBar</xsl:attribute>
                                                      </xsl:if>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width"></xsl:attribute>
                                                         <xsl:attribute name="colspan">6</xsl:attribute>
                                                         <xsl:attribute name="height">1</xsl:attribute>
                                                         <xsl:attribute name="bgcolor">#62B462</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                      <xsl:if test="(position() mod 2)=1">
                                                         <xsl:attribute name="class">GrayBar</xsl:attribute>
                                                      </xsl:if>
                                                      <xsl:if test="(position() mod 2)=0">
                                                         <xsl:attribute name="class">WhiteBar</xsl:attribute>
                                                      </xsl:if>
                                                         <xsl:attribute name="colspan">2</xsl:attribute>
                                                         <xsl:attribute name="height">3</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                   <xsl:when test="(count(/DATA/TXN/PTSGOALS/PTSGOAL) = 0)">
                                                      <xsl:element name="TR">
                                                         <xsl:element name="TD">
                                                            <xsl:attribute name="colspan">6</xsl:attribute>
                                                            <xsl:attribute name="align">left</xsl:attribute>
                                                            <xsl:attribute name="class">NoItems</xsl:attribute>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoItems']"/>
                                                         </xsl:element>
                                                      </xsl:element>
                                                   </xsl:when>
                                                </xsl:choose>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">6</xsl:attribute>
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
                        <xsl:if test="(/DATA/TXN/PTSGOAL/@template != 1) and (/DATA/TXN/PTSGOAL/@template != 2)">
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
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="IFRAME">
                                    <xsl:attribute name="src">9011.asp?Height=150&amp;OwnerType=70&amp;OwnerID=<xsl:value-of select="/DATA/PARAM/@goalid"/>&amp;Title=<xsl:value-of select="/DATA/PARAM/@title"/></xsl:attribute>
                                    <xsl:attribute name="width">600</xsl:attribute>
                                    <xsl:attribute name="height">300</xsl:attribute>
                                    <xsl:attribute name="frmheight">300</xsl:attribute>
                                    <xsl:attribute name="id">NotesFrame</xsl:attribute>
                                    <xsl:attribute name="name">NotesFrame</xsl:attribute>
                                    <xsl:attribute name="class">FrameNoScroll</xsl:attribute>
                                    <xsl:attribute name="frameborder">0</xsl:attribute>
                                    <xsl:element name="A">
                                       <xsl:attribute name="href">9011.asp?Height=150&amp;OwnerType=70&amp;OwnerID=<xsl:value-of select="/DATA/PARAM/@goalid"/>&amp;Title=<xsl:value-of select="/DATA/PARAM/@title"/></xsl:attribute>
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
                        </xsl:if>

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