<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
   <xsl:include href="HTMLHeading.xsl"/>
   <xsl:include href="PageHeader.xsl"/>
   <xsl:include href="PageFooter.xsl"/>
   <xsl:include href="Bookmark.xsl"/>
   <xsl:include href="Include\wtMenu.xsl"/>
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
         <xsl:with-param name="pagename" select="'View Task'"/>
         <xsl:with-param name="includecalendar" select="true()"/>
         <xsl:with-param name="htmleditor"></xsl:with-param>
         <xsl:with-param name="translate">google</xsl:with-param>
      </xsl:call-template>

      <xsl:element name="SCRIPT">
         <xsl:attribute name="language">JavaScript</xsl:attribute>
         <xsl:attribute name="src">Include/codethatsdk.js</xsl:attribute>
         <xsl:text> </xsl:text>
      </xsl:element>

      <xsl:element name="SCRIPT">
         <xsl:attribute name="language">JavaScript</xsl:attribute>
         <xsl:attribute name="src">Include/codethatmenupro.js</xsl:attribute>
         <xsl:text> </xsl:text>
      </xsl:element>

      <xsl:call-template name="DefineMenu"/>

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
               <xsl:attribute name="name">Task</xsl:attribute>
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
                              <xsl:attribute name="width">100</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">500</xsl:attribute>
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
                                       <xsl:attribute name="width">300</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="b">
                                       <xsl:value-of select="/DATA/PARAM/@projecttitle" disable-output-escaping="yes"/>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">300</xsl:attribute>
                                       <xsl:attribute name="align">right</xsl:attribute>
                                       <xsl:attribute name="valign">top</xsl:attribute>
<xsl:element name="SCRIPT">
   <xsl:attribute name="language">JavaScript</xsl:attribute>
   var TaskMenu = new CMenu(TaskMenuDef, 'TaskMenu'); TaskMenu.create();
</xsl:element>

                                    </xsl:element>
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
                              <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TaskID']"/>
                                 <xsl:element name="b">
                                 <xsl:value-of select="/DATA/TXN/PTSTASK/@taskid"/>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/TXN/PTSTASK/@taskname"/>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:if test="(/DATA/SYSTEM/@usergroup != 41) or (contains(/DATA/SYSTEM/@useroptions, 's'))">
                                 <xsl:element name="A">
                                    <xsl:attribute name="onclick">w=window.open(this.href,"shortcut","width=400, height=150");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                    <xsl:attribute name="href">9202.asp?EntityID=74&amp;ItemID=<xsl:value-of select="/DATA/TXN/PTSTASK/@taskid"/>&amp;Name=<xsl:value-of select="translate(/DATA/TXN/PTSTASK/@taskname,'&amp;',' ')"/>&amp;URL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                    <xsl:element name="IMG">
                                       <xsl:attribute name="src">Images/Shortcut.gif</xsl:attribute>
                                       <xsl:attribute name="border">0</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:if>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:if test="(/DATA/TXN/PTSTASK/@status = 0)">
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:element name="A">
                                       <xsl:attribute name="href">7403.asp?TaskID=<xsl:value-of select="/DATA/TXN/PTSTASK/@taskid"/>&amp;UpdateTaskID=<xsl:value-of select="/DATA/TXN/PTSTASK/@taskid"/>&amp;ContentPage=<xsl:value-of select="/DATA/PARAM/@contentpage"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@returnurl"/></xsl:attribute>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/GoalStart.gif</xsl:attribute>
                                          <xsl:attribute name="align">absmiddle</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                          <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Start']"/></xsl:attribute>
                                          <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Start']"/></xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                              </xsl:if>
                              <xsl:if test="(/DATA/TXN/PTSTASK/@status = 1)">
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:element name="A">
                                       <xsl:attribute name="href">7403.asp?TaskID=<xsl:value-of select="/DATA/TXN/PTSTASK/@taskid"/>&amp;UpdateTaskID=<xsl:value-of select="/DATA/TXN/PTSTASK/@taskid"/>&amp;ContentPage=<xsl:value-of select="/DATA/PARAM/@contentpage"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@returnurl"/></xsl:attribute>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/GoalComplete.gif</xsl:attribute>
                                          <xsl:attribute name="align">absmiddle</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                          <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Complete']"/></xsl:attribute>
                                          <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Complete']"/></xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                              </xsl:if>
                              <xsl:if test="(/DATA/TXN/PTSTASK/@status != 0)">
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:element name="A">
                                       <xsl:attribute name="href">7403.asp?TaskID=<xsl:value-of select="/DATA/TXN/PTSTASK/@taskid"/>&amp;UpdateTaskID=<xsl:value-of select="/DATA/TXN/PTSTASK/@taskid"/>&amp;ClearTask=1&amp;ContentPage=<xsl:value-of select="/DATA/PARAM/@contentpage"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@returnurl"/></xsl:attribute>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/GoalClear.gif</xsl:attribute>
                                          <xsl:attribute name="align">absmiddle</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                          <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Clear']"/></xsl:attribute>
                                          <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Clear']"/></xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                              </xsl:if>
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
                              <xsl:attribute name="height">2</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IMG">
                                 <xsl:attribute name="src">Images/Task.gif</xsl:attribute>
                                 <xsl:attribute name="border">0</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">500</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:if test="(/DATA/TXN/PTSTASK/@ismilestone != 0)">
                                    <xsl:element name="IMG">
                                       <xsl:attribute name="src">Images/milestone.gif</xsl:attribute>
                                       <xsl:attribute name="border">0</xsl:attribute>
                                    </xsl:element>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:element name="b">
                                    <xsl:element name="font">
                                       <xsl:attribute name="color">royalblue</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Milestone']"/>
                                    </xsl:element>
                                    </xsl:element>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:if>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MemberName']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="b">
                                 <xsl:element name="font">
                                    <xsl:attribute name="color">purple</xsl:attribute>
                                 <xsl:value-of select="/DATA/TXN/PTSTASK/@membername"/>
                                 </xsl:element>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Status']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:if test="(/DATA/TXN/PTSTASK/@status = 0)">
                                    <xsl:element name="b">
                                    <xsl:element name="font">
                                       <xsl:attribute name="color">gray</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Pending']"/>
                                    </xsl:element>
                                    </xsl:element>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/TXN/PTSTASK/@status = 1)">
                                    <xsl:element name="b">
                                    <xsl:element name="font">
                                       <xsl:attribute name="color">green</xsl:attribute>
                                    <xsl:variable name="tmp6"><xsl:value-of select="/DATA/TXN/PTSTASK/PTSSTATUSS/ENUM[@id=/DATA/TXN/PTSTASK/@status]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp6]"/>
                                    </xsl:element>
                                    </xsl:element>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/TXN/PTSTASK/@status = 2)">
                                    <xsl:element name="b">
                                    <xsl:element name="font">
                                       <xsl:attribute name="color">blue</xsl:attribute>
                                    <xsl:variable name="tmp7"><xsl:value-of select="/DATA/TXN/PTSTASK/PTSSTATUSS/ENUM[@id=/DATA/TXN/PTSTASK/@status]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp7]"/>
                                    </xsl:element>
                                    </xsl:element>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/TXN/PTSTASK/@status = 3)">
                                    <xsl:element name="b">
                                    <xsl:element name="font">
                                       <xsl:attribute name="color">red</xsl:attribute>
                                    <xsl:variable name="tmp8"><xsl:value-of select="/DATA/TXN/PTSTASK/PTSSTATUSS/ENUM[@id=/DATA/TXN/PTSTASK/@status]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp8]"/>
                                    </xsl:element>
                                    </xsl:element>
                                 </xsl:if>
                              <xsl:if test="(/DATA/TXN/PTSTASK/@tothrs != 0)">
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Hrs']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:element name="b">
                                    <xsl:value-of select="/DATA/TXN/PTSTASK/@tothrs"/>
                                    </xsl:element>
                              </xsl:if>
                                 <xsl:element name="BR"/>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EstDates']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:if test="(/DATA/TXN/PTSTASK/@eststartdate != '')">
                                    <xsl:element name="b">
                                    <xsl:value-of select="/DATA/TXN/PTSTASK/@eststartdate"/>
                                    </xsl:element>
                                 </xsl:if>
                                 <xsl:if test="(not(/DATA/TXN/PTSTASK/@eststartdate))">
                                    <xsl:element name="b">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='???']"/>
                                    </xsl:element>
                                 </xsl:if>
                                  - 
                                 <xsl:if test="(/DATA/TXN/PTSTASK/@estenddate != '')">
                                    <xsl:element name="b">
                                    <xsl:value-of select="/DATA/TXN/PTSTASK/@estenddate"/>
                                    </xsl:element>
                                 </xsl:if>
                                 <xsl:if test="(not(/DATA/TXN/PTSTASK/@estenddate))">
                                    <xsl:element name="b">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='???']"/>
                                    </xsl:element>
                                 </xsl:if>
                              <xsl:if test="(/DATA/TXN/PTSTASK/@estcost != '$0.00')">
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:element name="b">
                                    <xsl:element name="font">
                                       <xsl:attribute name="color">green</xsl:attribute>
                                    <xsl:value-of select="/DATA/TXN/PTSTASK/@estcost"/>
                                    </xsl:element>
                                    </xsl:element>
                              </xsl:if>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ActDates']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:if test="(/DATA/TXN/PTSTASK/@actstartdate != '')">
                                    <xsl:element name="b">
                                    <xsl:value-of select="/DATA/TXN/PTSTASK/@actstartdate"/>
                                    </xsl:element>
                                 </xsl:if>
                                 <xsl:if test="(not(/DATA/TXN/PTSTASK/@actstartdate))">
                                    <xsl:element name="b">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='???']"/>
                                    </xsl:element>
                                 </xsl:if>
                                  - 
                                 <xsl:if test="(/DATA/TXN/PTSTASK/@actenddate != '')">
                                    <xsl:element name="b">
                                    <xsl:value-of select="/DATA/TXN/PTSTASK/@actenddate"/>
                                    </xsl:element>
                                 </xsl:if>
                                 <xsl:if test="(not(/DATA/TXN/PTSTASK/@actenddate))">
                                    <xsl:element name="b">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='???']"/>
                                    </xsl:element>
                                 </xsl:if>
                              <xsl:if test="(/DATA/TXN/PTSTASK/@totcost != '$0.00')">
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:element name="b">
                                    <xsl:element name="font">
                                       <xsl:attribute name="color">green</xsl:attribute>
                                    <xsl:value-of select="/DATA/TXN/PTSTASK/@totcost"/>
                                    </xsl:element>
                                    </xsl:element>
                              </xsl:if>
                              <xsl:if test="(/DATA/TXN/PTSTASK/@varstartdate != 0) or (/DATA/TXN/PTSTASK/@varenddate != 0) or (/DATA/PARAM/@varcost != 0)">
                                    <xsl:element name="BR"/>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Variance']"/>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:if test="(/DATA/TXN/PTSTASK/@varstartdate != 0)">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StartDate']"/>
                                       <xsl:text>:</xsl:text>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:if test="(/DATA/TXN/PTSTASK/@varstartdate &lt; 0)">
                                          <xsl:element name="b">
                                          <xsl:element name="font">
                                             <xsl:attribute name="color">blue</xsl:attribute>
                                          <xsl:value-of select="/DATA/TXN/PTSTASK/@varstartdate"/>
                                          </xsl:element>
                                          </xsl:element>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/TXN/PTSTASK/@varstartdate &gt; 0)">
                                          <xsl:element name="b">
                                          <xsl:element name="font">
                                             <xsl:attribute name="color">red</xsl:attribute>
                                          <xsl:value-of select="/DATA/TXN/PTSTASK/@varstartdate"/>
                                          </xsl:element>
                                          </xsl:element>
                                       </xsl:if>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='days']"/>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/TXN/PTSTASK/@varenddate != 0)">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EndDate']"/>
                                       <xsl:text>:</xsl:text>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:if test="(/DATA/TXN/PTSTASK/@varenddate &lt; 0)">
                                          <xsl:element name="b">
                                          <xsl:element name="font">
                                             <xsl:attribute name="color">blue</xsl:attribute>
                                          <xsl:value-of select="/DATA/TXN/PTSTASK/@varenddate"/>
                                          </xsl:element>
                                          </xsl:element>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/TXN/PTSTASK/@varenddate &gt; 0)">
                                          <xsl:element name="b">
                                          <xsl:element name="font">
                                             <xsl:attribute name="color">red</xsl:attribute>
                                          <xsl:value-of select="/DATA/TXN/PTSTASK/@varenddate"/>
                                          </xsl:element>
                                          </xsl:element>
                                       </xsl:if>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='days']"/>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/PARAM/@varcost != 0)">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Cost']"/>
                                       <xsl:text>:</xsl:text>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:if test="(/DATA/PARAM/@varcost &lt; 0)">
                                          <xsl:element name="b">
                                          <xsl:element name="font">
                                             <xsl:attribute name="color">blue</xsl:attribute>
                                          <xsl:value-of select="/DATA/TXN/PTSTASK/@varcost"/>
                                          </xsl:element>
                                          </xsl:element>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@varcost &gt; 0)">
                                          <xsl:element name="b">
                                          <xsl:element name="font">
                                             <xsl:attribute name="color">red</xsl:attribute>
                                          <xsl:value-of select="/DATA/TXN/PTSTASK/@varcost"/>
                                          </xsl:element>
                                          </xsl:element>
                                       </xsl:if>
                                 </xsl:if>
                              </xsl:if>
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
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#004080</xsl:attribute>
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
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="font">
                                    <xsl:attribute name="color">darkblue</xsl:attribute>
                                 <xsl:value-of select="/DATA/TXN/PTSTASK/@description"/>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
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
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23) or (/DATA/PARAM/@projectmemberid = /DATA/SYSTEM/@memberid) or (/DATA/TXN/PTSTASK/@memberid = /DATA/SYSTEM/@memberid)">
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick">doSubmit(1,"")</xsl:attribute>
                                 </xsl:element>
                              </xsl:if>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">button</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Return']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick">doSubmit(3,"")</xsl:attribute>
                              </xsl:element>
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
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/PARAM/@count != 0)">
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
                                 <xsl:attribute name="height">3</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
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
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="width">40%</xsl:attribute>
                                          <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                          <xsl:attribute name="valign">Bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Tasks']"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="width">24%</xsl:attribute>
                                          <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                          <xsl:attribute name="valign">Bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MemberName']"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="width">12%</xsl:attribute>
                                          <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                          <xsl:attribute name="valign">Bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Status']"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="width">12%</xsl:attribute>
                                          <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                          <xsl:attribute name="valign">Bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StartDate']"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="width">12%</xsl:attribute>
                                          <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                          <xsl:attribute name="valign">Bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EndDate']"/>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">5</xsl:attribute>
                                          <xsl:attribute name="height">2</xsl:attribute>
                                          <xsl:attribute name="bgcolor">#CCCCCC</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:for-each select="/DATA/TXN/PTSTASKS/PTSTASK">
                                       <xsl:element name="TR">
                                          <xsl:if test="(position() mod 2)=1">
                                             <xsl:attribute name="class">GrayBar</xsl:attribute>
                                          </xsl:if>
                                          <xsl:if test="(position() mod 2)=0">
                                             <xsl:attribute name="class">WhiteBar</xsl:attribute>
                                          </xsl:if>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:if test="(@ismilestone != 0)">
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/milestone.gif</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             </xsl:if>
                                             <xsl:if test="(@status = 2)">
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
                                                <xsl:if test="(@status = 3)">
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/RedX.gif</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:if>
                                                <xsl:value-of select="@taskname"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">7403.asp?TaskID=<xsl:value-of select="@taskid"/>&amp;ContentPage=<xsl:value-of select="/DATA/PARAM/@contentpage"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/TaskPreview.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                      <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PreviewTask']"/></xsl:attribute>
                                                      <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PreviewTask']"/></xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                             <xsl:if test="(@status = 0)">
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="href">7503.asp?ProjectID=<xsl:value-of select="/DATA/TXN/PTSTASK/@projectid"/>&amp;UpdateTaskID=<xsl:value-of select="@taskid"/>&amp;ContentPage=<xsl:value-of select="/DATA/PARAM/@contentpage"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@returnurl"/></xsl:attribute>
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/GoalStart.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StartTask']"/></xsl:attribute>
                                                         <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StartTask']"/></xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(@status = 1)">
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="href">7503.asp?ProjectID=<xsl:value-of select="/DATA/TXN/PTSTASK/@projectid"/>&amp;UpdateTaskID=<xsl:value-of select="@taskid"/>&amp;ContentPage=<xsl:value-of select="/DATA/PARAM/@contentpage"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@returnurl"/></xsl:attribute>
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/GoalComplete.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CompleteTask']"/></xsl:attribute>
                                                         <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CompleteTask']"/></xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(@status != 0)">
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="href">7503.asp?ProjectID=<xsl:value-of select="/DATA/TXN/PTSTASK/@projectid"/>&amp;UpdateTaskID=<xsl:value-of select="@taskid"/>&amp;ClearTask=1&amp;ContentPage=<xsl:value-of select="/DATA/PARAM/@contentpage"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@returnurl"/></xsl:attribute>
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/GoalClear.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ClearTask']"/></xsl:attribute>
                                                         <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ClearTask']"/></xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                             </xsl:if>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:element name="font">
                                                <xsl:attribute name="color">purple</xsl:attribute>
                                             <xsl:value-of select="@membername"/>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">top</xsl:attribute>
                                                <xsl:if test="(@status = 0)">
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="color">gray</xsl:attribute>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Pending']"/>
                                                   </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(@status = 1)">
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="color">green</xsl:attribute>
                                                   <xsl:variable name="tmp2"><xsl:value-of select="../PTSSTATUSS/ENUM[@id=current()/@status]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp2]"/>
                                                   </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(@status = 2)">
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="color">blue</xsl:attribute>
                                                   <xsl:variable name="tmp3"><xsl:value-of select="../PTSSTATUSS/ENUM[@id=current()/@status]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp3]"/>
                                                   </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(@status = 3)">
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="color">red</xsl:attribute>
                                                   <xsl:variable name="tmp4"><xsl:value-of select="../PTSSTATUSS/ENUM[@id=current()/@status]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp4]"/>
                                                   </xsl:element>
                                                </xsl:if>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">top</xsl:attribute>
                                                <xsl:if test="(@varstartdate = 0)">
                                                   <xsl:value-of select="@actstartdate"/>
                                                </xsl:if>
                                                <xsl:if test="(@varstartdate &lt; 0)">
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="color">blue</xsl:attribute>
                                                   <xsl:value-of select="@actstartdate"/>
                                                   </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(@varstartdate &gt; 0)">
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="color">red</xsl:attribute>
                                                   <xsl:value-of select="@actstartdate"/>
                                                   </xsl:element>
                                                </xsl:if>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">top</xsl:attribute>
                                                <xsl:if test="(@varenddate = 0)">
                                                   <xsl:value-of select="@actenddate"/>
                                                </xsl:if>
                                                <xsl:if test="(@varenddate &lt; 0)">
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="color">blue</xsl:attribute>
                                                   <xsl:value-of select="@actenddate"/>
                                                   </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(@varenddate &gt; 0)">
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="color">red</xsl:attribute>
                                                   <xsl:value-of select="@actenddate"/>
                                                   </xsl:element>
                                                </xsl:if>
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
                                             <xsl:attribute name="colspan">5</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="font">
                                                   <xsl:attribute name="color">gray</xsl:attribute>
                                                <xsl:value-of select="@description"/>
                                                </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:for-each>
                                    <xsl:choose>
                                       <xsl:when test="(count(/DATA/TXN/PTSTASKS/PTSTASK) = 0)">
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="colspan">5</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="class">NoItems</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoItems']"/>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:when>
                                    </xsl:choose>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">5</xsl:attribute>
                                          <xsl:attribute name="height">2</xsl:attribute>
                                          <xsl:attribute name="bgcolor">#CCCCCC</xsl:attribute>
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
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="b">
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TotalSubTasks']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/PARAM/@count" disable-output-escaping="yes"/>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/PARAM/@attachmentcount != 0)">
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
                                 <xsl:attribute name="height">3</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
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
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="width">44%</xsl:attribute>
                                          <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                          <xsl:attribute name="valign">Bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AttachName']"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="width">22%</xsl:attribute>
                                          <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                          <xsl:attribute name="valign">Bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='File']"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="width">12%</xsl:attribute>
                                          <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                          <xsl:attribute name="valign">Bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Status']"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="width">10%</xsl:attribute>
                                          <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                          <xsl:attribute name="valign">Bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AttachSize']"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="width">12%</xsl:attribute>
                                          <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                          <xsl:attribute name="valign">Bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AttachDate']"/>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">5</xsl:attribute>
                                          <xsl:attribute name="height">2</xsl:attribute>
                                          <xsl:attribute name="bgcolor">#CCCCCC</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:for-each select="/DATA/TXN/PTSATTACHMENTS/PTSATTACHMENT">
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
                                             <xsl:element name="A">
                                                <xsl:attribute name="href">8003.asp?AttachmentID=<xsl:value-of select="@attachmentid"/>&amp;Mini=1&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:value-of select="@attachname"/>
                                             </xsl:element>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:if test="(@islink != 0)">
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="onclick">w=window.open(this.href,"blank","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                      <xsl:attribute name="href"><xsl:value-of select="@filename"/></xsl:attribute>
                                                   <xsl:value-of select="@filename"/>
                                                   </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(@islink = 0)">
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="onclick">w=window.open(this.href,"blank","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                      <xsl:attribute name="href">Attachments/74/<xsl:value-of select="concat(/DATA/PARAM/@taskid,'/',@filename)"/></xsl:attribute>
                                                   <xsl:value-of select="@filename"/>
                                                   </xsl:element>
                                                </xsl:if>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:if test="(@status &lt;= 1)">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Active']"/>
                                                </xsl:if>
                                                <xsl:if test="(@status = 2)">
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="color">red</xsl:attribute>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Inactive']"/>
                                                   </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(@status = 3)">
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="color">purple</xsl:attribute>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Private']"/>
                                                   </xsl:element>
                                                </xsl:if>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="font">
                                                   <xsl:attribute name="color">blue</xsl:attribute>
                                                <xsl:value-of select="@secure"/>
                                                </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:if test="(@islink = 0)">
                                                   <xsl:value-of select="@attachsize"/>
                                                </xsl:if>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="@attachdate"/>
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
                                             <xsl:attribute name="colspan">5</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="font">
                                                <xsl:attribute name="color">gray</xsl:attribute>
                                             <xsl:value-of select="@description"/>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:for-each>
                                    <xsl:choose>
                                       <xsl:when test="(count(/DATA/TXN/PTSATTACHMENTS/PTSATTACHMENT) = 0)">
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="colspan">5</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="class">NoItems</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoItems']"/>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:when>
                                    </xsl:choose>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">5</xsl:attribute>
                                          <xsl:attribute name="height">2</xsl:attribute>
                                          <xsl:attribute name="bgcolor">#CCCCCC</xsl:attribute>
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
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">prompt</xsl:attribute>
                                    <xsl:value-of select="/DATA/PARAM/@attachmentcount" disable-output-escaping="yes"/>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Attachments']"/>
                              </xsl:element>
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
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#004080</xsl:attribute>
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
                              <xsl:element name="IFRAME">
                                 <xsl:attribute name="src">9011.asp?Height=150&amp;OwnerType=74&amp;OwnerID=<xsl:value-of select="/DATA/PARAM/@taskid"/>&amp;Title=<xsl:value-of select="/DATA/PARAM/@title"/></xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="height">500</xsl:attribute>
                                 <xsl:attribute name="frmheight">500</xsl:attribute>
                                 <xsl:attribute name="id">NotesFrame</xsl:attribute>
                                 <xsl:attribute name="name">NotesFrame</xsl:attribute>
                                 <xsl:attribute name="class">FrameNoScroll</xsl:attribute>
                                 <xsl:attribute name="frameborder">0</xsl:attribute>
                                 <xsl:element name="A">
                                    <xsl:attribute name="href">9011.asp?Height=150&amp;OwnerType=74&amp;OwnerID=<xsl:value-of select="/DATA/PARAM/@taskid"/>&amp;Title=<xsl:value-of select="/DATA/PARAM/@title"/></xsl:attribute>
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

<xsl:element name="SCRIPT">
   <xsl:attribute name="language">JavaScript</xsl:attribute>
   <xsl:text disable-output-escaping="yes"><![CDATA[
   TaskMenu.run();
   ]]></xsl:text>
</xsl:element>

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