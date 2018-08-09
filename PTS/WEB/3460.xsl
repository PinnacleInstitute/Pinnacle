<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
   <xsl:include href="HTMLHeading.xsl"/>
   <xsl:include href="ReportHeader.xsl"/>
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
         <xsl:with-param name="pagename" select="'Assessment Report'"/>
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
         <xsl:attribute name="id">wrapper650</xsl:attribute>
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
               <xsl:attribute name="name">MemberAssess</xsl:attribute>
               <xsl:attribute name="method">post</xsl:attribute>

               <xsl:element name="INPUT">
                  <xsl:attribute name="type">hidden</xsl:attribute>
                  <xsl:attribute name="name">ActionCode</xsl:attribute>
                  <xsl:attribute name="id">ActionCode</xsl:attribute>
                  <xsl:attribute name="value"></xsl:attribute>
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

               <!--HEADER ROW-->
               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="colspan">2</xsl:attribute>
                     <xsl:call-template name="ReportHeader"/>
                  </xsl:element>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
                  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
                  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
                  var tmpID = '<xsl:value-of select="/DATA/SYSTEM/@ga_acctid"/>'
                  var tmpDomain = '<xsl:value-of select="/DATA/SYSTEM/@ga_domain"/>'
                  var tmpAction = '<xsl:value-of select="/DATA/SYSTEM/@actioncode"/>'
                  <xsl:text disable-output-escaping="yes">if( tmpID.length != 0 &amp;&amp; tmpDomain.length != 0 &amp;&amp; (tmpAction = '0') ) {</xsl:text>
                     ga('create', tmpID, tmpDomain);
                     ga('send', 'pageview');
                  }
               </xsl:element>
               <xsl:element name="TR">

                  <xsl:element name="TD">
                     <xsl:attribute name="width">10</xsl:attribute>
                  </xsl:element>

                  <xsl:element name="TD">
                     <xsl:attribute name="valign">top</xsl:attribute>
                     <xsl:attribute name="width">655</xsl:attribute>

                     <xsl:element name="TABLE">
                        <xsl:attribute name="border">0</xsl:attribute>
                        <xsl:attribute name="cellpadding">0</xsl:attribute>
                        <xsl:attribute name="cellspacing">0</xsl:attribute>
                        <xsl:attribute name="width">655</xsl:attribute>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">5</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">20</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">630</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">3</xsl:attribute>
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">5</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">650</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:element name="IMG">
                                    <xsl:attribute name="src">Images/Report.gif</xsl:attribute>
                                    <xsl:attribute name="align">absmiddle</xsl:attribute>
                                    <xsl:attribute name="border">0</xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@assessmentname"/>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">5</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">650</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:value-of select="/DATA/TXN/PTSMEMBER/@membername"/>
                                 <xsl:element name="BR"/>
                                 <xsl:value-of select="/DATA/TXN/PTSMEMBERASSESS/@completedate"/>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">5</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">650</xsl:attribute>
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#000000</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">3</xsl:attribute>
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/TXN/PTSASSESSMENT/@assessmenttype = 2)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="width">655</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:element name="A">
                                    <xsl:attribute name="onclick">w=window.open(this.href,"ExternalAssessment","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                    <xsl:attribute name="href"><xsl:value-of select="/DATA/PARAM/@externalurl"/></xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ReviewAssessment']"/>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="(/DATA/TXN/PTSMEMBERASSESS/@status = 1)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">24</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="width">655</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PassCert']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/TXN/PTSMEMBERASSESS/@result"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">24</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="(/DATA/TXN/PTSMEMBERASSESS/@status = 2)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">24</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="width">655</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:element name="font">
                                    <xsl:attribute name="color">red</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FailCert']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/TXN/PTSMEMBERASSESS/@result"/>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">24</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="(/DATA/TXN/PTSASSESSMENT/@assessmenttype = 1) and (/DATA/TXN/PTSASSESSMENT/@resulttype != 3)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">5</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">20</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">630</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/TXN/PTSHTMLFILE/DATA/comment()" disable-output-escaping="yes"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">5</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">20</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">630</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:value-of select="/DATA/TXN/PTSMEMBERASSESS/@result"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/TXN/PTSASSESSMENT/@assessmenttype = 1) and (/DATA/TXN/PTSASSESSQUESTION/@questiontype = 4)">
                           <xsl:if test="(/DATA/TXN/PTSASSESSQUESTION/@mediatype = 1)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="width">655</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="IMG">
                                       <xsl:attribute name="src">Sections\Assessment\<xsl:value-of select="/DATA/PARAM/@assessmentid"/>\<xsl:value-of select="/DATA/TXN/PTSASSESSQUESTION/@mediafile"/></xsl:attribute>
                                       <xsl:attribute name="border">0</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:if>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="width">655</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/TXN/PTSASSESSQUESTION/@question"/>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:if test="(/DATA/TXN/PTSASSESSQUESTION/@mediatype &gt; 1)">
                                    <xsl:if test="(contains(/DATA/TXN/PTSASSESSQUESTION/@mediafile,':'))">
                                          <xsl:element name="A">
                                             <xsl:attribute name="onclick">w=window.open(this.href,"Video","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                             <xsl:attribute name="href">2431.asp?Video=<xsl:value-of select="/DATA/TXN/PTSASSESSQUESTION/@mediafile"/></xsl:attribute>
                                          <xsl:element name="b">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PlayClip']"/>
                                          </xsl:element>
                                          </xsl:element>
                                    </xsl:if>
                                    <xsl:if test="(not(contains(/DATA/TXN/PTSASSESSQUESTION/@mediafile,':')))">
                                          <xsl:element name="A">
                                             <xsl:attribute name="onclick">w=window.open(this.href,"Video","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                             <xsl:attribute name="href">2431.asp?Video=Sections\Assessment\<xsl:value-of select="concat(/DATA/PARAM/@assessmentid,'\',/DATA/TXN/PTSASSESSQUESTION/@mediafile)"/></xsl:attribute>
                                          <xsl:element name="b">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PlayClip']"/>
                                          </xsl:element>
                                          </xsl:element>
                                    </xsl:if>
                                    </xsl:if>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">5</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">650</xsl:attribute>
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">1</xsl:attribute>
                                 <xsl:attribute name="bgcolor">#004080</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">5</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">650</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/TXN/PTSASSESSQUESTION/DESCRIPTION/comment()" disable-output-escaping="yes"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">5</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">650</xsl:attribute>
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#000000</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">3</xsl:attribute>
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(count(/DATA/TXN/PTSCOURSES/PTSCOURSE) &gt; 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">5</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">650</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='RecommendedCourses']"/>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">5</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">650</xsl:attribute>
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">1</xsl:attribute>
                                 <xsl:attribute name="bgcolor">#004080</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="width">650</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">650</xsl:attribute>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">65</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">460</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">55</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">70</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:for-each select="/DATA/TXN/PTSCOURSES/PTSCOURSE">
                                             <xsl:element name="TR">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="colspan">4</xsl:attribute>
                                                   <xsl:attribute name="height">3</xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TR">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">65</xsl:attribute>
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
                                                   <xsl:attribute name="width">460</xsl:attribute>
                                                   <xsl:attribute name="align"></xsl:attribute>
                                                   <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:if test="(@coursedate = /DATA/SYSTEM/@currdate)">
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/new.gif</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:if>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="href">1120.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;CourseID=<xsl:value-of select="@courseid"/>&amp;OrgCourseID=<xsl:value-of select="@orgcourseid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                                      <xsl:element name="b">
                                                      <xsl:value-of select="@coursename"/>
                                                      </xsl:element>
                                                      </xsl:element>
                                                      <xsl:if test="(/DATA/PARAM/@memberid &gt; 0)">
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                         <xsl:element name="A">
                                                            <xsl:attribute name="href">1120.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;CourseID=<xsl:value-of select="@courseid"/>&amp;OrgCourseID=<xsl:value-of select="@orgcourseid"/>&amp;Register=1&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                                            <xsl:element name="IMG">
                                                               <xsl:attribute name="src">Images/Register.gif</xsl:attribute>
                                                               <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                               <xsl:attribute name="border">0</xsl:attribute>
                                                               <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Register']"/></xsl:attribute>
                                                               <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Register']"/></xsl:attribute>
                                                            </xsl:element>
                                                         </xsl:element>
                                                      </xsl:if>
                                                       (#<xsl:value-of select="@courseid"/>)
                                                      <xsl:element name="b">
                                                       - 
                                                      </xsl:element>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"trainer","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">0308.asp?TrainerID=<xsl:value-of select="@trainerid"/></xsl:attribute>
                                                      <xsl:value-of select="@trainername"/>
                                                      </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">55</xsl:attribute>
                                                   <xsl:attribute name="align">right</xsl:attribute>
                                                   <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="@courselength"/>
                                                       min.
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">70</xsl:attribute>
                                                   <xsl:attribute name="align">right</xsl:attribute>
                                                   <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:value-of select="@language"/>
                                                </xsl:element>
                                             </xsl:element>

                                             <xsl:element name="TR">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">65</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">top</xsl:attribute>
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
                                                   <xsl:attribute name="colspan">3</xsl:attribute>
                                                   <xsl:attribute name="width">585</xsl:attribute>
                                                   <xsl:attribute name="align"></xsl:attribute>
                                                   <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:value-of select="@description"/>
                                                </xsl:element>
                                             </xsl:element>

                                       </xsl:for-each>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">5</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">650</xsl:attribute>
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">1</xsl:attribute>
                                 <xsl:attribute name="bgcolor">#000000</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/PARAM/@displayquestions = 1)">
                           <xsl:if test="(count(/DATA/TXN/PTSASSESSQUESTIONS/PTSASSESSQUESTION) = 0)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">5</xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">20</xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">630</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:attribute name="class">Prompt</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoQuestionAvail']"/>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">6</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:if>

                           <xsl:if test="(count(/DATA/TXN/PTSASSESSQUESTIONS/PTSASSESSQUESTION) &gt; 0) and (/DATA/TXN/PTSASSESSMENT/@resulttype != 3)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">5</xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="width">650</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:attribute name="class">PageHeading</xsl:attribute>
                                    <xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@assessmentname"/>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">5</xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">650</xsl:attribute>
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="height">1</xsl:attribute>
                                    <xsl:attribute name="bgcolor">#004080</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">6</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:if test="(count(/DATA/TXN/PTSASSESSQUESTIONS/PTSASSESSQUESTION) &gt; 0)">
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">5</xsl:attribute>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">20</xsl:attribute>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">630</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@description"/>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">3</xsl:attribute>
                                       <xsl:attribute name="height">6</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:if>

                           </xsl:if>
                           <xsl:element name="TR">
                              <xsl:for-each select="/DATA/TXN/PTSASSESSQUESTIONS/PTSASSESSQUESTION">
                                    <xsl:if test="(/DATA/TXN/PTSASSESSANSWERS/PTSASSESSANSWER[@assessquestionid=current()/@assessquestionid]/@answer != '') and (@description != '') and (@questiontype != 4)">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">5</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">650</xsl:attribute>
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="height">1</xsl:attribute>
                                             <xsl:attribute name="bgcolor">#004080</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">3</xsl:attribute>
                                             <xsl:attribute name="height">6</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">5</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">20</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">630</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:attribute name="class">prompt</xsl:attribute>
                                             <xsl:value-of select="@description"/>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">3</xsl:attribute>
                                             <xsl:attribute name="height">6</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">5</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">20</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">630</xsl:attribute>
                                             <xsl:attribute name="height">1</xsl:attribute>
                                             <xsl:attribute name="bgcolor">#004080</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">3</xsl:attribute>
                                             <xsl:attribute name="height">6</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>

                                    </xsl:if>
                                    <xsl:if test="(/DATA/TXN/PTSASSESSANSWERS/PTSASSESSANSWER[@assessquestionid=current()/@assessquestionid]/@answer != '') and (@questiontype != 4)">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">5</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">20</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="position()"/>.
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">630</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:if test="(@questiontype = 1)">
                                                   <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">text</xsl:attribute>
                                                   <xsl:attribute name="name"><xsl:value-of select="@assessquestionid"/></xsl:attribute>
                                                   <xsl:attribute name="id"><xsl:value-of select="@assessquestionid"/></xsl:attribute>
                                                   <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSASSESSANSWERS/PTSASSESSANSWER[@assessquestionid=current()/@assessquestionid]/@answer"/></xsl:attribute>
                                                   <xsl:attribute name="size">2</xsl:attribute>
                                                   <xsl:attribute name="DISABLED"/>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:if>
                                             <xsl:if test="(@questiontype = 2)">
                                                   <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">text</xsl:attribute>
                                                   <xsl:attribute name="name"><xsl:value-of select="@assessquestionid"/></xsl:attribute>
                                                   <xsl:attribute name="id"><xsl:value-of select="@assessquestionid"/></xsl:attribute>
                                                   <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSASSESSANSWERS/PTSASSESSANSWER[@assessquestionid=current()/@assessquestionid]/@answer"/></xsl:attribute>
                                                   <xsl:attribute name="size">2</xsl:attribute>
                                                   <xsl:attribute name="DISABLED"/>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:if>
                                                <xsl:value-of select="@question"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:if>

                                    <xsl:if test="(@questiontype = 5)">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="width">25</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">630</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="font">
                                                <xsl:attribute name="color">blue</xsl:attribute>
                                             <xsl:value-of select="/DATA/TXN/PTSASSESSANSWERS/PTSASSESSANSWER[@assessquestionid=current()/@assessquestionid]/@answertext"/>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:if>

                                    <xsl:variable name="tmpMultiSelect"><xsl:value-of select="@multiselect"/></xsl:variable>

                                    <xsl:if test="(@questiontype = 3) and (/DATA/TXN/PTSASSESSANSWERS/PTSASSESSANSWER[@assessquestionid=current()/@assessquestionid]/@answer != '')">
                                       <xsl:element name="TR">
                                          <xsl:for-each select="/DATA/TXN/PTSASSESSCHOICES/PTSASSESSCHOICE[(@assessquestionid = current()/@assessquestionid)]">
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">5</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">20</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">630</xsl:attribute>
                                                      <xsl:attribute name="align">left</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:if test="($tmpMultiSelect = 0)">
                                                            <xsl:element name="INPUT">
                                                            <xsl:attribute name="type">radio</xsl:attribute>
                                                            <xsl:attribute name="name"><xsl:value-of select="@assessquestionid"/></xsl:attribute>
                                                            <xsl:attribute name="id"><xsl:value-of select="@assessquestionid"/></xsl:attribute>
                                                            <xsl:attribute name="value"><xsl:value-of select="@assesschoiceid"/></xsl:attribute>
                                                            <xsl:if test="/DATA/TXN/PTSASSESSANSWERS/PTSASSESSANSWER[@assesschoiceid=current()/@assesschoiceid]">
                                                               <xsl:attribute name="CHECKED"/>
                                                            </xsl:if>
                                                            <xsl:attribute name="DISABLED"/>
                                                            </xsl:element>
                                                      </xsl:if>
                                                      <xsl:if test="($tmpMultiSelect != 0)">
                                                            <xsl:element name="INPUT">
                                                            <xsl:attribute name="type">checkbox</xsl:attribute>
                                                            <xsl:attribute name="name">C<xsl:value-of select="@assesschoiceid"/></xsl:attribute>
                                                            <xsl:attribute name="id">C<xsl:value-of select="@assesschoiceid"/></xsl:attribute>
                                                            <xsl:if test="/DATA/TXN/PTSASSESSANSWERS/PTSASSESSANSWER[@assesschoiceid=current()/@assesschoiceid]">
                                                               <xsl:attribute name="CHECKED"/>
                                                            </xsl:if>
                                                            <xsl:attribute name="DISABLED"/>
                                                            </xsl:element>
                                                      </xsl:if>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:value-of select="@choice"/>
                                                   </xsl:element>
                                                </xsl:element>

                                          </xsl:for-each>
                                       </xsl:element>
                                    </xsl:if>

                                    <xsl:if test="(/DATA/TXN/PTSASSESSANSWERS/PTSASSESSANSWER[@assessquestionid=current()/@assessquestionid]/@answer != '')">
                                       <xsl:element name="TR">
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">3</xsl:attribute>
                                             <xsl:attribute name="height">6</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:if>

                              </xsl:for-each>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">3</xsl:attribute>
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">3</xsl:attribute>
                              <xsl:attribute name="width">655</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeading</xsl:attribute>
                              <xsl:if test="(/DATA/TXN/PTSMEMBERASSESS/@status = 1) and ((/DATA/TXN/PTSMEMBERASSESS/@nocertificate = 0) or (/DATA/SYSTEM/@usergroup != 41))">
                                 <xsl:if test="(/DATA/TXN/PTSMEMBERASSESS/@iscustomcertificate = 0)">
                                       <xsl:element name="A">
                                          <xsl:attribute name="onclick">w=window.open(this.href,"Certificate","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                          <xsl:attribute name="href">3438.asp?MemberAssessID=<xsl:value-of select="/DATA/TXN/PTSMEMBERASSESS/@memberassessid"/>&amp;MemberID=<xsl:value-of select="/DATA/TXN/PTSMEMBERASSESS/@memberid"/></xsl:attribute>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/Certificate48.gif</xsl:attribute>
                                             <xsl:attribute name="align">absmiddle</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Certificate']"/></xsl:attribute>
                                             <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Certificate']"/></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:element name="A">
                                          <xsl:attribute name="onclick">w=window.open(this.href,"Certificate","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                          <xsl:attribute name="href">3438.asp?MemberAssessID=<xsl:value-of select="/DATA/TXN/PTSMEMBERASSESS/@memberassessid"/>&amp;MemberID=<xsl:value-of select="/DATA/TXN/PTSMEMBERASSESS/@memberid"/></xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PrintCertification']"/>
                                       </xsl:element>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/TXN/PTSMEMBERASSESS/@iscustomcertificate != 0)">
                                       <xsl:element name="A">
                                          <xsl:attribute name="onclick">w=window.open(this.href,"Certificate","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                          <xsl:attribute name="href">3107.asp?MemberAssessID=<xsl:value-of select="/DATA/TXN/PTSMEMBERASSESS/@memberassessid"/>&amp;I=1</xsl:attribute>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/Certificate48.gif</xsl:attribute>
                                             <xsl:attribute name="align">absmiddle</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Certificate']"/></xsl:attribute>
                                             <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Certificate']"/></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:element name="A">
                                          <xsl:attribute name="onclick">w=window.open(this.href,"Certificate","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                          <xsl:attribute name="href">3107.asp?MemberAssessID=<xsl:value-of select="/DATA/TXN/PTSMEMBERASSESS/@memberassessid"/>&amp;I=1</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PrintCertification']"/>
                                       </xsl:element>
                                 </xsl:if>
                              </xsl:if>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">3</xsl:attribute>
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">3</xsl:attribute>
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">3</xsl:attribute>
                              <xsl:attribute name="width">655</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
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
                              <xsl:attribute name="colspan">3</xsl:attribute>
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