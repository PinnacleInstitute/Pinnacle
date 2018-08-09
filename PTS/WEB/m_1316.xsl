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
         <xsl:with-param name="pagename" select="'Program Summary'"/>
         <xsl:with-param name="includecalendar" select="true()"/>
         <xsl:with-param name="htmleditor"></xsl:with-param>
         <xsl:with-param name="viewport">width=device-width</xsl:with-param>
         <xsl:with-param name="translate">google</xsl:with-param>
      </xsl:call-template>

      <!--BEGIN BODY-->
      <xsl:element name="BODY">
         <xsl:attribute name="topmargin">0</xsl:attribute>
         <xsl:attribute name="leftmargin">0</xsl:attribute>
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
         <xsl:element name="A">
            <xsl:attribute name="name">top</xsl:attribute>
         </xsl:element>
         <xsl:element name="TABLE">
            <xsl:attribute name="border">0</xsl:attribute>
            <xsl:attribute name="cellpadding">0</xsl:attribute>
            <xsl:attribute name="cellspacing">0</xsl:attribute>
            <xsl:attribute name="width">100%</xsl:attribute>
            <xsl:attribute name="align">left</xsl:attribute>

            <!--BEGIN FORM-->
            <xsl:element name="FORM">
               <xsl:attribute name="name">Session</xsl:attribute>
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
                     <xsl:attribute name="width">0</xsl:attribute>
                  </xsl:element>
                  <xsl:element name="TD">
                     <xsl:attribute name="width">100%</xsl:attribute>
                  </xsl:element>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function PrintCertificate(){ 
               var url, win, custom;
               custom = document.getElementById('IsCustomCertificate').value;
               if( custom == 0 ) { url = '2839' } else  { url = '2838' }
               url = url + ".asp?orgid=" + document.getElementById('ProgramID').value + "&memberid=" + document.getElementById('MemberID').value;
               win = window.open(url,"Certificate");
               win.focus();
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="TR">

                  <xsl:element name="TD">
                     <xsl:attribute name="width">0</xsl:attribute>
                  </xsl:element>

                  <xsl:element name="TD">
                     <xsl:attribute name="valign">top</xsl:attribute>
                     <xsl:attribute name="width">100%</xsl:attribute>

                     <xsl:element name="TABLE">
                        <xsl:attribute name="border">0</xsl:attribute>
                        <xsl:attribute name="cellpadding">0</xsl:attribute>
                        <xsl:attribute name="cellspacing">0</xsl:attribute>
                        <xsl:attribute name="width">100%</xsl:attribute>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">8%</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">92%</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">ProgramID</xsl:attribute>
                              <xsl:attribute name="id">ProgramID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@programid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">MemberID</xsl:attribute>
                              <xsl:attribute name="id">MemberID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@memberid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">IsCustomCertificate</xsl:attribute>
                              <xsl:attribute name="id">IsCustomCertificate</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSORG/@iscustomcertificate"/></xsl:attribute>
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
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeading</xsl:attribute>
                              <xsl:value-of select="/DATA/TXN/PTSORG/@orgname"/>
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
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/TXN/PTSORG/DESCRIPTION/comment()" disable-output-escaping="yes"/>
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
                              <xsl:attribute name="width">100%</xsl:attribute>
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
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">100%</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">83%</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">17%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">83%</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ProgramCredits']"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">17%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/PARAM/@programcredits" disable-output-escaping="yes"/>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">83%</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ProgramReqCredits']"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">17%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/PARAM/@programreqcredits" disable-output-escaping="yes"/>
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
                                          <xsl:attribute name="width">100%</xsl:attribute>
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
                                          <xsl:attribute name="width">83%</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TotalCredits']"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">17%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/PARAM/@totalcredits" disable-output-escaping="yes"/>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">83%</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TotalReqCredits']"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">17%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/PARAM/@totalreqcredits" disable-output-escaping="yes"/>
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
                                          <xsl:attribute name="width">100%</xsl:attribute>
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
                                          <xsl:attribute name="width">83%</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MissingCredits']"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">17%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/PARAM/@missingcredits" disable-output-escaping="yes"/>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">83%</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MissingReqCredits']"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">17%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/PARAM/@missingreqcredits" disable-output-escaping="yes"/>
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
                                          <xsl:attribute name="width">100%</xsl:attribute>
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

                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeading</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='RegisteredCourses']"/>
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
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="b">
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CourseName']"/>
                              </xsl:element>
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
                              <xsl:attribute name="width">100%</xsl:attribute>
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

                        <xsl:for-each select="/DATA/TXN/PTSSESSIONS/PTSSESSION[(@courseid != 0)]">
                              <xsl:element name="TR">
                                 <xsl:if test="(position() mod 2)">
                                    <xsl:attribute name="class">GrayBar</xsl:attribute>
                                 </xsl:if>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">8%</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:if test="(@status = 1)">
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/lesson_status0.gif</xsl:attribute>
                                             <xsl:attribute name="align">middle</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LessonStatus0']"/></xsl:attribute>
                                             <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LessonStatus0']"/></xsl:attribute>
                                          </xsl:element>
                                       </xsl:if>
                                       <xsl:if test="(@status = 2)">
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/lesson_status1.gif</xsl:attribute>
                                             <xsl:attribute name="align">middle</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LessonStatus1']"/></xsl:attribute>
                                             <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LessonStatus1']"/></xsl:attribute>
                                          </xsl:element>
                                       </xsl:if>
                                       <xsl:if test="(@status = 5)">
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/lesson_status2.gif</xsl:attribute>
                                             <xsl:attribute name="align">middle</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LessonStatus2']"/></xsl:attribute>
                                             <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LessonStatus2']"/></xsl:attribute>
                                          </xsl:element>
                                       </xsl:if>
                                       <xsl:if test="(@status = 6)">
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/lesson_status3.gif</xsl:attribute>
                                             <xsl:attribute name="align">middle</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LessonStatus3']"/></xsl:attribute>
                                             <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LessonStatus3']"/></xsl:attribute>
                                          </xsl:element>
                                       </xsl:if>
                                       <xsl:if test="(@status = 7)">
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/lesson_status4.gif</xsl:attribute>
                                             <xsl:attribute name="align">middle</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LessonStatus4']"/></xsl:attribute>
                                             <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LessonStatus4']"/></xsl:attribute>
                                          </xsl:element>
                                       </xsl:if>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">92%</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:if test="(@ocstatus = 2)">
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/CheckGreen.gif</xsl:attribute>
                                             <xsl:attribute name="align">absmiddle</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Required']"/></xsl:attribute>
                                             <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Required']"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    </xsl:if>
                                       <xsl:value-of select="@coursename"/>
                                       <xsl:element name="font">
                                          <xsl:attribute name="color">purple</xsl:attribute>
                                        (#<xsl:value-of select="@sessionid"/>)
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:value-of select="@startdate"/>
                                       -
                                       <xsl:value-of select="@completedate"/>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:if test="(@status = 6) or (@status = 7)">
                                          <xsl:element name="font">
                                             <xsl:attribute name="color">blue</xsl:attribute>
                                          -
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Grade']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:if test="(@status = 6)">
                                             -
                                             <xsl:element name="font">
                                                <xsl:attribute name="color">red</xsl:attribute>
                                             <xsl:value-of select="@grade"/>
                                             </xsl:element>
                                       </xsl:if>
                                       <xsl:if test="(@status = 7)">
                                             -
                                             <xsl:value-of select="@grade"/>
                                       </xsl:if>
                                          </xsl:element>
                                       </xsl:if>
                                       -
                                       <xsl:element name="font">
                                          <xsl:attribute name="color">purple</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Credits']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:if test="(@status = 7)">
                                             -
                                             <xsl:value-of select="@credit"/>
                                       </xsl:if>
                                       <xsl:if test="(@status != 7)">
                                             -
                                             <xsl:element name="font">
                                                <xsl:attribute name="color">gray</xsl:attribute>
                                             <xsl:value-of select="@credit"/>
                                             </xsl:element>
                                       </xsl:if>
                                       </xsl:element>
                                 </xsl:element>
                              </xsl:element>

                        </xsl:for-each>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100%</xsl:attribute>
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
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeading</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='UnregisteredCourses']"/>
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
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">100%</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">83%</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">17%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">83%</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CourseName']"/>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">17%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Credits']"/>
                                          </xsl:element>
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
                                          <xsl:attribute name="width">100%</xsl:attribute>
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

                                    <xsl:for-each select="/DATA/TXN/PTSSESSIONS/PTSSESSION[(@courseid = 0)]">
                                          <xsl:element name="TR">
                                             <xsl:if test="(position() mod 2)">
                                                <xsl:attribute name="class">GrayBar</xsl:attribute>
                                             </xsl:if>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">83%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:if test="(@ocstatus = 2)">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/CheckGreen.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Required']"/></xsl:attribute>
                                                         <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Required']"/></xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                </xsl:if>
                                                   <xsl:value-of select="@coursename"/>
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="color">purple</xsl:attribute>
                                                    (#<xsl:value-of select="@sessionid"/>)
                                                   </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">17%</xsl:attribute>
                                                <xsl:attribute name="align">center</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="@credit"/>
                                             </xsl:element>
                                          </xsl:element>

                                    </xsl:for-each>
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
                              <xsl:attribute name="width">100%</xsl:attribute>
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
                              <xsl:attribute name="width">100%</xsl:attribute>
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
      <!--END BODY-->

      </xsl:element>

   </xsl:template>
</xsl:stylesheet>