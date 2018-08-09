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
         <xsl:with-param name="pagename" select="/DATA/LANGUAGE/LABEL[@name='Find']"/>
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
               <xsl:attribute name="name">Course</xsl:attribute>
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

                        <xsl:if test="(/DATA/PARAM/@mode = 1)">
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
                                             <xsl:attribute name="width">300</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">300</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">300</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:attribute name="class">PageHeading</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PrivateCourses']"/>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">300</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/addnew.gif</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">1102.asp?CompanyID=<xsl:value-of select="/DATA/PARAM/@companyid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewCourse']"/>
                                                </xsl:element>
                                             <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23)">
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/ArrowUp.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="onclick">w=window.open(this.href,"Import","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                      <xsl:attribute name="href">11Import.asp?CompanyID=<xsl:value-of select="/DATA/PARAM/@companyid"/></xsl:attribute>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Import']"/>
                                                   </xsl:element>
                                             </xsl:if>
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
                        </xsl:if>

                        <xsl:if test="(/DATA/PARAM/@mode = 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Courses']"/>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="(/DATA/PARAM/@mode &gt; 1)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IncludedCourses']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:value-of select="/DATA/TXN/PTSORG/@orgname"/>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Folder']"/>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@mode = 0)">
                                    <xsl:element name="A">
                                       <xsl:attribute name="href">1212.asp?ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CourseCategorys']"/>
                                    </xsl:element>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                              </xsl:if>
                              <xsl:if test="(/DATA/PARAM/@orgid != 0)">
                                    <xsl:element name="A">
                                       <xsl:attribute name="onclick">w=window.open(this.href,"Report","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                       <xsl:attribute name="href">1360.asp?OrgID=<xsl:value-of select="/DATA/PARAM/@orgid"/></xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Report']"/>
                                    </xsl:element>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                              </xsl:if>
                              <xsl:if test="(/DATA/PARAM/@mode = 2)">
                                    <xsl:element name="A">
                                       <xsl:attribute name="onclick">w=window.open(this.href,"Courses","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                       <xsl:attribute name="href">1212.asp?OrgID=<xsl:value-of select="/DATA/PARAM/@orgid"/>&amp;CompanyID=<xsl:value-of select="/DATA/PARAM/@companyid"/>&amp;Mode=3&amp;contentpage=3</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IncludePublicCourses']"/>
                                    </xsl:element>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                              </xsl:if>
                              <xsl:if test="(/DATA/PARAM/@mode = 2)">
                                    <xsl:element name="A">
                                       <xsl:attribute name="onclick">w=window.open(this.href,"Courses","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                       <xsl:attribute name="href">1101.asp?OrgID=<xsl:value-of select="/DATA/PARAM/@orgid"/>&amp;CompanyID=<xsl:value-of select="/DATA/PARAM/@companyid"/>&amp;Mode=3&amp;contentpage=3</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IncludePrivateCourses']"/>
                                    </xsl:element>
                              </xsl:if>
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

                        <xsl:if test="(/DATA/PARAM/@mode &lt; 2)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">prompt</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CourseFindText']"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="(/DATA/PARAM/@mode &gt; 1)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">prompt</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FolderCoursesText']"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">600</xsl:attribute>
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
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">ColumnHeader</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SearchBy']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="SELECT">
                                 <xsl:attribute name="name">FindTypeID</xsl:attribute>
                                 <xsl:attribute name="id">FindTypeID</xsl:attribute>
                                 <xsl:for-each select="/DATA/TXN/PTSCOURSES/PTSFINDTYPEIDS/ENUM">
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
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/PARAM/@mode = 3)">
                           <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23) or (/DATA/SYSTEM/@usergroup = 51) or (/DATA/SYSTEM/@usergroup = 52)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">600</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:if test="(count(/DATA/TXN/PTSCOURSES/PTSCOURSE) &gt; 0)">
                                       <xsl:element name="INPUT">
                                          <xsl:attribute name="type">button</xsl:attribute>
                                          <xsl:attribute name="value">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Include']"/>
                                          </xsl:attribute>
                                          <xsl:attribute name="onclick">doSubmit(8,"")</xsl:attribute>
                                       </xsl:element>
                                    </xsl:if>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:element name="INPUT">
                                       <xsl:attribute name="type">button</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Close']"/>
                                       </xsl:attribute>
                                       <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[window.parent.parent.opener.location.reload();window.parent.close()]]></xsl:text></xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">1</xsl:attribute>
                                    <xsl:attribute name="height">6</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:if>

                        </xsl:if>
                        <xsl:if test="(/DATA/PARAM/@mode = 0) or (/DATA/PARAM/@mode = 1) or (/DATA/PARAM/@mode = 3)">
                           <xsl:if test="(/DATA/BOOKMARK/@searchtype != 0) or (/DATA/PARAM/@mode != 0)">
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
                                             <xsl:attribute name="width">11%</xsl:attribute>
                                             <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                             <xsl:attribute name="valign">Bottom</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Rating']"/>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="width">4%</xsl:attribute>
                                             <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                             <xsl:attribute name="valign">Bottom</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="width">39%</xsl:attribute>
                                             <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                             <xsl:attribute name="valign">Bottom</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CourseTrainer']"/>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="width">13%</xsl:attribute>
                                             <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                             <xsl:attribute name="valign">Bottom</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CourseType']"/>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="width">20%</xsl:attribute>
                                             <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                             <xsl:attribute name="valign">Bottom</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CourseLevel']"/>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="width">13%</xsl:attribute>
                                             <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                             <xsl:attribute name="valign">Bottom</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">6</xsl:attribute>
                                             <xsl:attribute name="height">2</xsl:attribute>
                                             <xsl:attribute name="bgcolor">#CCCCCC</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:for-each select="/DATA/TXN/PTSCOURSES/PTSCOURSE">
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
                                                <xsl:element name="A">
                                                   <xsl:attribute name="onclick">w=window.open(this.href,"Ratings","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                   <xsl:attribute name="href">1313.asp?CourseID=<xsl:value-of select="@courseid"/></xsl:attribute>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/star<xsl:value-of select="@rating"/>.gif</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                      <xsl:attribute name="alt"><xsl:value-of select="concat(@ratingcnt, ' ', /DATA/LANGUAGE/LABEL[@name='ClassesRated'])"/></xsl:attribute>
                                                      <xsl:attribute name="title"><xsl:value-of select="concat(@ratingcnt, ' ', /DATA/LANGUAGE/LABEL[@name='ClassesRated'])"/></xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:if test="(/DATA/PARAM/@mode = 3)">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">checkbox</xsl:attribute>
                                                   <xsl:attribute name="name"><xsl:value-of select="@courseid"/></xsl:attribute>
                                                   <xsl:attribute name="id"><xsl:value-of select="@courseid"/></xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/PARAM/@mode != 3)">
                                                <xsl:element name="TD">
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:if test="(@status &lt;= 1)">
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">green</xsl:attribute>
                                                      <xsl:value-of select="@coursename"/>
                                                      </xsl:element>
                                                   </xsl:if>
                                                   <xsl:if test="(@status = 2)">
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">purple</xsl:attribute>
                                                      <xsl:value-of select="@coursename"/>
                                                      </xsl:element>
                                                   </xsl:if>
                                                   <xsl:if test="(@status = 3)">
                                                      <xsl:value-of select="@coursename"/>
                                                   </xsl:if>
                                                   <xsl:if test="(@status = 4)">
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">red</xsl:attribute>
                                                      <xsl:value-of select="@coursename"/>
                                                      </xsl:element>
                                                   </xsl:if>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23) or (/DATA/PARAM/@mode = 1)">
                                                   <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23) or (@trainerid = 0)">
                                                         <xsl:element name="A">
                                                            <xsl:attribute name="href">1103.asp?CourseID=<xsl:value-of select="@courseid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                                            <xsl:element name="IMG">
                                                               <xsl:attribute name="src">Images/edit.gif</xsl:attribute>
                                                               <xsl:attribute name="border">0</xsl:attribute>
                                                               <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Preview']"/></xsl:attribute>
                                                               <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Preview']"/></xsl:attribute>
                                                            </xsl:element>
                                                         </xsl:element>
                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23)">
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                         <xsl:element name="A">
                                                            <xsl:attribute name="onclick">w=window.open(this.href,"Export","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                            <xsl:attribute name="href">ExportCourse.asp?CourseID=<xsl:value-of select="@courseid"/></xsl:attribute>
                                                            <xsl:element name="IMG">
                                                               <xsl:attribute name="src">Images/ArrowDown.gif</xsl:attribute>
                                                               <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                               <xsl:attribute name="border">0</xsl:attribute>
                                                               <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Export']"/></xsl:attribute>
                                                               <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Export']"/></xsl:attribute>
                                                            </xsl:element>
                                                         </xsl:element>
                                                   </xsl:if>
                                                </xsl:if>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">top</xsl:attribute>
                                                <xsl:variable name="tmp5"><xsl:value-of select="../PTSCOURSETYPES/ENUM[@id=current()/@coursetype]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp5]"/>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">top</xsl:attribute>
                                                <xsl:variable name="tmp6"><xsl:value-of select="../PTSCOURSELEVELS/ENUM[@id=current()/@courselevel]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp6]"/>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">top</xsl:attribute>
                                                <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23) and (/DATA/PARAM/@mode &lt;= 1)">
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="href">2311.asp?CourseID=<xsl:value-of select="@courseid"/>&amp;contentpage=<xsl:value-of select="/DATA/PARAM/@contentpage"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/lesson_status2.gif</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Lessons']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Lessons']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"preview","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">1330.asp?CourseID=<xsl:value-of select="@courseid"/></xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/preview.gif</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Preview']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Preview']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"CopyCourse","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">1105.asp?CourseID=<xsl:value-of select="@courseid"/></xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/copy.gif</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Copy']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Copy']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"blank","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">6811.asp?CourseID=<xsl:value-of select="@courseid"/></xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/homework.gif</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GradeHomework']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GradeHomework']"/></xsl:attribute>
                                                         </xsl:element>
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
                                                <xsl:attribute name="colspan">2</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:if test="(@video != 0)">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/video.gif</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(@audio != 0)">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/audio.gif</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(@quiz != 0)">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/quiz.gif</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                </xsl:if>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:if test="(/DATA/SYSTEM/@usergroup = 51) or (/DATA/SYSTEM/@usergroup = 52)">
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"trainer","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">0308.asp?TrainerID=<xsl:value-of select="@trainerid"/></xsl:attribute>
                                                      <xsl:value-of select="@trainername"/>
                                                      </xsl:element>
                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23) or (/DATA/SYSTEM/@usergroup = 31)">
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="href">0303.asp?TrainerID=<xsl:value-of select="@trainerid"/>&amp;contentpage=<xsl:value-of select="/DATA/PARAM/@contentpage"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                                      <xsl:value-of select="@trainername"/>
                                                      </xsl:element>
                                                   </xsl:if>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="colspan">3</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">top</xsl:attribute>
                                                <xsl:element name="font">
                                                   <xsl:attribute name="color">gray</xsl:attribute>
                                                   (#<xsl:value-of select="@courseid"/>)
                                                   <xsl:if test="(@grp != 0)">
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"Group","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">1119.asp?Grp=<xsl:value-of select="@grp"/></xsl:attribute>
                                                      (#<xsl:value-of select="@grp"/>)
                                                      </xsl:element>
                                                   </xsl:if>
                                                   <xsl:variable name="tmp3"><xsl:value-of select="../PTSSTATUSS/ENUM[@id=current()/@status]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp3]"/>
                                                    - 
                                                   <xsl:value-of select="@language"/>
                                                   <xsl:value-of select="concat(' (',@coursedate,')')"/>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:for-each>
                                       <xsl:choose>
                                          <xsl:when test="(count(/DATA/TXN/PTSCOURSES/PTSCOURSE) = 0)">
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
                           </xsl:if>

                        </xsl:if>
                        <xsl:if test="(/DATA/PARAM/@mode = 2)">
                           <xsl:if test="(/DATA/BOOKMARK/@searchtype != 0)">
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
                                             <xsl:attribute name="width">12%</xsl:attribute>
                                             <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                             <xsl:attribute name="valign">Bottom</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='RankSeq']"/>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="width">74%</xsl:attribute>
                                             <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                             <xsl:attribute name="valign">Bottom</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CourseTrainer']"/>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="width">5%</xsl:attribute>
                                             <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                             <xsl:attribute name="valign">Bottom</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="width">9%</xsl:attribute>
                                             <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                             <xsl:attribute name="valign">Bottom</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">4</xsl:attribute>
                                             <xsl:attribute name="height">2</xsl:attribute>
                                             <xsl:attribute name="bgcolor">#CCCCCC</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:for-each select="/DATA/TXN/PTSCOURSES/PTSCOURSE">
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
                                                <xsl:element name="A">
                                                   <xsl:attribute name="onclick">w=window.open(this.href,"Ratings","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                   <xsl:attribute name="href">1313.asp?CourseID=<xsl:value-of select="@courseid"/></xsl:attribute>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/star<xsl:value-of select="@rating"/>.gif</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                      <xsl:attribute name="alt"><xsl:value-of select="concat(@ratingcnt, ' ', /DATA/LANGUAGE/LABEL[@name='ClassesRated'])"/></xsl:attribute>
                                                      <xsl:attribute name="title"><xsl:value-of select="concat(@ratingcnt, ' ', /DATA/LANGUAGE/LABEL[@name='ClassesRated'])"/></xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:value-of select="@coursename"/>
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="color">purple</xsl:attribute>
                                                   (#<xsl:value-of select="@courseid"/>)
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="href">3003.asp?CourseID=<xsl:value-of select="@courseid"/>&amp;OrgID=<xsl:value-of select="/DATA/PARAM/@orgid"/>&amp;contentpage=<xsl:value-of select="/DATA/PARAM/@contentpage"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/Edit.gif</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/></xsl:attribute>
                                                         <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/></xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="onclick">w=window.open(this.href,"preview","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                      <xsl:attribute name="href">1330.asp?CourseID=<xsl:value-of select="@courseid"/></xsl:attribute>
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/Preview.gif</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Preview']"/></xsl:attribute>
                                                         <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Preview']"/></xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:if test="(@quiz != 0)">
                                                   <xsl:if test="(@coursetype = 0)">
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/quiz.gif</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                         </xsl:element>
                                                   </xsl:if>
                                                   <xsl:if test="(@coursetype = 1)">
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/quiz_no_retake.gif</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                         </xsl:element>
                                                   </xsl:if>
                                                   <xsl:if test="(@coursetype = 2)">
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/quiz_no_answer.gif</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                         </xsl:element>
                                                   </xsl:if>
                                                </xsl:if>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="b">
                                                <xsl:if test="(@status = 2)">
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="href">1101.asp?SearchText=<xsl:value-of select="/DATA/PARAM/@searchtext"/>&amp;FindTypeID=<xsl:value-of select="/DATA/PARAM/@findtypeid"/>&amp;Bookmark=<xsl:value-of select="/DATA/PARAM/@bookmark"/>&amp;Direction=<xsl:value-of select="/DATA/PARAM/@direction"/>&amp;contentpage=<xsl:value-of select="/DATA/PARAM/@contentpage"/>&amp;CompanyID=<xsl:value-of select="/DATA/PARAM/@companyid"/>&amp;OrgID=<xsl:value-of select="/DATA/PARAM/@orgid"/>&amp;Mode=<xsl:value-of select="/DATA/PARAM/@mode"/>&amp;ID=<xsl:value-of select="@courseid"/>&amp;OrgCourseAction=1&amp;Status=1&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@returnurl"/></xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/CheckGreen.gif</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Required']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Required']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(@status = 1)">
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="href">1101.asp?SearchText=<xsl:value-of select="/DATA/PARAM/@searchtext"/>&amp;FindTypeID=<xsl:value-of select="/DATA/PARAM/@findtypeid"/>&amp;Bookmark=<xsl:value-of select="/DATA/PARAM/@bookmark"/>&amp;Direction=<xsl:value-of select="/DATA/PARAM/@direction"/>&amp;contentpage=<xsl:value-of select="/DATA/PARAM/@contentpage"/>&amp;CompanyID=<xsl:value-of select="/DATA/PARAM/@companyid"/>&amp;OrgID=<xsl:value-of select="/DATA/PARAM/@orgid"/>&amp;Mode=<xsl:value-of select="/DATA/PARAM/@mode"/>&amp;ID=<xsl:value-of select="@courseid"/>&amp;OrgCourseAction=1&amp;Status=2&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@returnurl"/></xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/CheckGray.gif</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Recommended']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Recommended']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="href">1101.asp?SearchText=<xsl:value-of select="/DATA/PARAM/@searchtext"/>&amp;FindTypeID=<xsl:value-of select="/DATA/PARAM/@findtypeid"/>&amp;Bookmark=<xsl:value-of select="/DATA/PARAM/@bookmark"/>&amp;Direction=<xsl:value-of select="/DATA/PARAM/@direction"/>&amp;contentpage=<xsl:value-of select="/DATA/PARAM/@contentpage"/>&amp;CompanyID=<xsl:value-of select="/DATA/PARAM/@companyid"/>&amp;OrgID=<xsl:value-of select="/DATA/PARAM/@orgid"/>&amp;Mode=<xsl:value-of select="/DATA/PARAM/@mode"/>&amp;ID=<xsl:value-of select="@courseid"/>&amp;OrgCourseAction=2&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@returnurl"/></xsl:attribute>
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/Trash.gif</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Remove']"/></xsl:attribute>
                                                         <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Remove']"/></xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                </xsl:element>
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
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="font">
                                                   <xsl:attribute name="color">gray</xsl:attribute>
                                                <xsl:value-of select="@seq"/>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="colspan">3</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="onclick">w=window.open(this.href,"trainer","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                   <xsl:attribute name="href">0308.asp?TrainerID=<xsl:value-of select="@trainerid"/></xsl:attribute>
                                                <xsl:value-of select="@trainername"/>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:for-each>
                                       <xsl:choose>
                                          <xsl:when test="(count(/DATA/TXN/PTSCOURSES/PTSCOURSE) = 0)">
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
                           </xsl:if>

                        </xsl:if>
                        <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23) or (/DATA/SYSTEM/@usergroup = 51) or (/DATA/SYSTEM/@usergroup = 52)">
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
                                 <xsl:if test="(count(/DATA/TXN/PTSCOURSES/PTSCOURSE) &gt; 0) and (/DATA/PARAM/@mode = 3)">
                                    <xsl:element name="INPUT">
                                       <xsl:attribute name="type">button</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Include']"/>
                                       </xsl:attribute>
                                       <xsl:attribute name="onclick">doSubmit(8,"")</xsl:attribute>
                                    </xsl:element>
                                 </xsl:if>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:if test="(/DATA/PARAM/@mode = 3)">
                                    <xsl:element name="INPUT">
                                       <xsl:attribute name="type">button</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Close']"/>
                                       </xsl:attribute>
                                       <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[window.parent.parent.opener.location.reload();window.parent.close()]]></xsl:text></xsl:attribute>
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
                        </xsl:if>

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