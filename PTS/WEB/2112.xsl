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
         <xsl:with-param name="pagename" select="/DATA/LANGUAGE/LABEL[@name='Quiz']"/>
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
               <xsl:attribute name="name">QuizQuestion</xsl:attribute>
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
                     <xsl:call-template name="PageHeader"/>
                  </xsl:element>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function CheckIdentity(){  
               var url, win
               url = "0427.asp?memberid=" + document.getElementById('MemberID').value;
                  win = window.open(url,"Identify","top=200,left=200,height=150,width=430,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no");
               win.focus();
             }]]></xsl:text>
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
                              <xsl:attribute name="width">50</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">15</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">685</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Identify</xsl:attribute>
                              <xsl:attribute name="id">Identify</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@identify"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">MemberID</xsl:attribute>
                              <xsl:attribute name="id">MemberID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@memberid"/></xsl:attribute>
                           </xsl:element>

                        <xsl:if test="(/DATA/PARAM/@identify &gt; 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IdentificationInfo']"/>
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
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IdentifyMember']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[CheckIdentity();]]></xsl:text></xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="class">smbutton</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ReturnLesson']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick">doSubmit(5,"")</xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="class">smbutton</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ReturnClass']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick">doSubmit(3,"")</xsl:attribute>
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
                        <xsl:if test="(/DATA/PARAM/@identify &lt;= 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Quiz']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/TXN/PTSLESSON/@lessonname"/>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="colspan">3</xsl:attribute>
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

                           <xsl:if test="(/DATA/PARAM/@sessionid &gt; 0)">
                              <xsl:if test="(/DATA/PARAM/@review != 0)">
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">3</xsl:attribute>
                                       <xsl:attribute name="width">750</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:attribute name="class">Prompt</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='QuizHelpMemberReview']"/>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">3</xsl:attribute>
                                       <xsl:attribute name="height">6</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:if>

                              <xsl:if test="(/DATA/PARAM/@review = 0)">
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">3</xsl:attribute>
                                       <xsl:attribute name="width">750</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:attribute name="class">Prompt</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='QuizHelpMember']"/>
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
                           <xsl:if test="(/DATA/PARAM/@sessionid = 0)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="width">750</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:attribute name="class">Prompt</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='QuizHelpTrainer']"/>
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
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="colspan">3</xsl:attribute>
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
                                 <xsl:attribute name="width">50</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:if test="(/DATA/PARAM/@review != 0)">
                                    <xsl:if test="(/DATA/PARAM/@yourgrade &lt; /DATA/TXN/PTSLESSON/@passinggrade)">
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/lesson_status3.gif</xsl:attribute>
                                             <xsl:attribute name="align">middle</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                          </xsl:element>
                                    </xsl:if>
                                    <xsl:if test="(/DATA/PARAM/@yourgrade &gt;= /DATA/TXN/PTSLESSON/@passinggrade)">
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/lesson_status4.gif</xsl:attribute>
                                             <xsl:attribute name="align">middle</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                          </xsl:element>
                                    </xsl:if>
                                 </xsl:if>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">700</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:if test="(/DATA/PARAM/@review != 0)">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='YourGrade']"/>
                                       <xsl:text>:</xsl:text>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/PARAM/@yourgrade"/>%
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PassingGrade']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:value-of select="/DATA/TXN/PTSLESSON/@passinggrade"/>%
                                     (
                                    <xsl:value-of select="/DATA/PARAM/@passingpoints" disable-output-escaping="yes"/>
                                     / 
                                    <xsl:value-of select="/DATA/PARAM/@totalpoints" disable-output-escaping="yes"/>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PTS']"/>
                                    )
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
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="colspan">3</xsl:attribute>
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
                                 <xsl:attribute name="width">750</xsl:attribute>
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
                              <xsl:for-each select="/DATA/TXN/PTSQUIZQUESTIONS/PTSQUIZQUESTION[position() and @question != '']">
                                    <xsl:sort select="@seq" data-type="number"/>
                                    <xsl:if test="(@mediatype = 1)">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">50</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="width">700</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="src">Sections\Course\<xsl:value-of select="/DATA/PARAM/@courseid"/>\<xsl:value-of select="@mediafile"/></xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:if>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">50</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@review != 0) and (/DATA/PARAM/@quizlimit != 2)">
                                             <xsl:if test="(/DATA/TXN/PTSQUIZANSWERS/PTSQUIZANSWER[@quizchoiceid = current()/@quizchoiceid])">
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/GreenCheck.gif</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(not(/DATA/TXN/PTSQUIZANSWERS/PTSQUIZANSWER[@quizchoiceid = current()/@quizchoiceid]))">
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/RedCheck.gif</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                             </xsl:if>
                                          </xsl:if>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">2</xsl:attribute>
                                          <xsl:attribute name="width">700</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="position()"/>.
                                             <xsl:value-of select="@question"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:if test="(@mediatype &gt; 1)">
                                             <xsl:if test="(contains(@mediafile,':'))">
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="onclick">w=window.open(this.href,"Video","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                      <xsl:attribute name="href">2431.asp?Video=<xsl:value-of select="@mediafile"/></xsl:attribute>
                                                   <xsl:element name="b">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PlayClip']"/>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(not(contains(@mediafile,':')))">
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="onclick">w=window.open(this.href,"Video","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                      <xsl:attribute name="href">2431.asp?Video=Sections\Course\<xsl:value-of select="concat(/DATA/PARAM/@courseid,'\',@mediafile)"/></xsl:attribute>
                                                   <xsl:element name="b">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PlayClip']"/>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   </xsl:element>
                                             </xsl:if>
                                          </xsl:if>
                                              (
                                             <xsl:value-of select="@points"/>
                                              pts)
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:for-each select="./PTSQUIZCHOICEIDS/ENUM[position()]">
                                             <xsl:if test="(/DATA/PARAM/@review = 0) or (/DATA/PARAM/@quizlimit = 2)">
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">2</xsl:attribute>
                                                      <xsl:attribute name="width">65</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">685</xsl:attribute>
                                                      <xsl:attribute name="align">left</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="INPUT">
                                                      <xsl:attribute name="type">radio</xsl:attribute>
                                                      <xsl:attribute name="name"><xsl:value-of select="../../@quizquestionid"/></xsl:attribute>
                                                      <xsl:attribute name="id"><xsl:value-of select="../../@quizquestionid"/></xsl:attribute>
                                                      <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                                      <xsl:if test="/DATA/TXN/PTSQUIZANSWERS/PTSQUIZANSWER[@quizchoiceid=current()/@id]">
                                                         <xsl:attribute name="CHECKED"/>
                                                      </xsl:if>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:value-of select="@name"/>
                                                   </xsl:element>
                                                </xsl:element>

                                             </xsl:if>
                                             <xsl:if test="(/DATA/PARAM/@review != 0) and (/DATA/PARAM/@quizlimit != 2)">
                                                <xsl:if test="(not(@selected) )">
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="colspan">2</xsl:attribute>
                                                         <xsl:attribute name="width">65</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">685</xsl:attribute>
                                                         <xsl:attribute name="align">left</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:element name="INPUT">
                                                         <xsl:attribute name="type">radio</xsl:attribute>
                                                         <xsl:attribute name="name"><xsl:value-of select="../../@quizquestionid"/></xsl:attribute>
                                                         <xsl:attribute name="id"><xsl:value-of select="../../@quizquestionid"/></xsl:attribute>
                                                         <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                                         <xsl:if test="/DATA/TXN/PTSQUIZANSWERS/PTSQUIZANSWER[@quizchoiceid=current()/@id]">
                                                            <xsl:attribute name="CHECKED"/>
                                                         </xsl:if>
                                                         </xsl:element>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                         <xsl:value-of select="@name"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                </xsl:if>

                                                <xsl:if test="(@selected )">
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="colspan">2</xsl:attribute>
                                                         <xsl:attribute name="width">65</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">685</xsl:attribute>
                                                         <xsl:attribute name="align">left</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:element name="INPUT">
                                                         <xsl:attribute name="type">radio</xsl:attribute>
                                                         <xsl:attribute name="name"><xsl:value-of select="../../@quizquestionid"/></xsl:attribute>
                                                         <xsl:attribute name="id"><xsl:value-of select="../../@quizquestionid"/></xsl:attribute>
                                                         <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                                         <xsl:if test="/DATA/TXN/PTSQUIZANSWERS/PTSQUIZANSWER[@quizchoiceid=current()/@id]">
                                                            <xsl:attribute name="CHECKED"/>
                                                         </xsl:if>
                                                         </xsl:element>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                         <xsl:element name="b">
                                                         <xsl:value-of select="@name"/>
                                                         </xsl:element>
                                                      </xsl:element>
                                                   </xsl:element>
                                                </xsl:if>

                                             </xsl:if>
                                       </xsl:for-each>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">3</xsl:attribute>
                                          <xsl:attribute name="height">12</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:if test="(/DATA/PARAM/@review != 0) and (@explain != '')">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="width">65</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">685</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:attribute name="class">prompt</xsl:attribute>
                                             <xsl:element name="b">
                                                <xsl:if test="(/DATA/TXN/PTSQUIZANSWERS/PTSQUIZANSWER[@quizchoiceid = current()/@quizchoiceid])">
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="color">green</xsl:attribute>
                                                   <xsl:value-of select="@explain"/>
                                                   </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(not(/DATA/TXN/PTSQUIZANSWERS/PTSQUIZANSWER[@quizchoiceid = current()/@quizchoiceid]))">
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="color">red</xsl:attribute>
                                                   <xsl:value-of select="@explain"/>
                                                   </xsl:element>
                                                </xsl:if>
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

                              </xsl:for-each>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">700</xsl:attribute>
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">1</xsl:attribute>
                                 <xsl:attribute name="bgcolor">#004080</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:if test="(/DATA/PARAM/@popup &lt; 2)">
                              <xsl:if test="(/DATA/PARAM/@sessionid &gt; 0)">
                                 <xsl:if test="(/DATA/PARAM/@review = 0) or ((/DATA/PARAM/@review != 0) and (/DATA/TXN/PTSLESSON/@ispassquiz = 0) and (/DATA/PARAM/@quizlimit = 0))">
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">3</xsl:attribute>
                                          <xsl:attribute name="width">750</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">Grade</xsl:attribute>
                                          <xsl:attribute name="id">Grade</xsl:attribute>
                                          <xsl:if test="/DATA/PARAM/@grade='on'">
                                             <xsl:attribute name="CHECKED"/>
                                          </xsl:if>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GradeQuizAfter']"/>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">3</xsl:attribute>
                                          <xsl:attribute name="height">12</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:if>

                              </xsl:if>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">hidden</xsl:attribute>
                                    <xsl:attribute name="name">NextLessonID</xsl:attribute>
                                    <xsl:attribute name="id">NextLessonID</xsl:attribute>
                                    <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@nextlessonid"/></xsl:attribute>
                                 </xsl:element>

                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="width">750</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:if test="(/DATA/PARAM/@nextlessonid != 0)">
                                       <xsl:element name="INPUT">
                                          <xsl:attribute name="type">button</xsl:attribute>
                                          <xsl:attribute name="value">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NextLesson']"/>
                                          </xsl:attribute>
                                          <xsl:attribute name="onclick">doSubmit(2,"")</xsl:attribute>
                                       </xsl:element>
                                    </xsl:if>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:if test="(count(/DATA/TXN/PTSSESSIONLESSONS/PTSSESSIONLESSON) &gt; 1)">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GoToLesson']"/>
                                    </xsl:if>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:if test="(count(/DATA/TXN/PTSSESSIONLESSONS/PTSSESSIONLESSON) &gt; 1)">
                                       <xsl:element name="SELECT">
                                          <xsl:attribute name="name">LessonID</xsl:attribute>
                                          <xsl:attribute name="id">LessonID</xsl:attribute>
                                          <xsl:attribute name="onchange"><xsl:text disable-output-escaping="yes"><![CDATA[doSubmit(4,"")]]></xsl:text></xsl:attribute>
                                          <xsl:variable name="tmp"><xsl:value-of select="/DATA/PARAM/@lessonid"/></xsl:variable>
                                          <xsl:for-each select="/DATA/TXN/PTSSESSIONLESSONS/PTSSESSIONLESSON">
                                             <xsl:element name="OPTION">
                                                <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                                <xsl:if test="$tmp=@id"><xsl:attribute name="SELECTED"/></xsl:if>
                                                <xsl:value-of select="@name"/>
                                             </xsl:element>
                                          </xsl:for-each>
                                       </xsl:element>
                                    </xsl:if>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:if test="(/DATA/PARAM/@sessionid &gt; 0)">
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">3</xsl:attribute>
                                       <xsl:attribute name="width">750</xsl:attribute>
                                       <xsl:attribute name="align">center</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:if test="(/DATA/PARAM/@review = 0)">
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">button</xsl:attribute>
                                             <xsl:attribute name="value">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GradeQuizNow']"/>
                                             </xsl:attribute>
                                             <xsl:attribute name="onclick">doSubmit(1,"")</xsl:attribute>
                                          </xsl:element>
                                       </xsl:if>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:if test="(/DATA/PARAM/@autoquiz = 0)">
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">button</xsl:attribute>
                                             <xsl:attribute name="value">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ReturnLesson']"/>
                                             </xsl:attribute>
                                             <xsl:attribute name="onclick">doSubmit(5,"")</xsl:attribute>
                                          </xsl:element>
                                       </xsl:if>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:element name="INPUT">
                                          <xsl:attribute name="type">button</xsl:attribute>
                                          <xsl:attribute name="value">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ReturnClass']"/>
                                          </xsl:attribute>
                                          <xsl:attribute name="onclick">doSubmit(3,"")</xsl:attribute>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:if test="(/DATA/PARAM/@review != 0) and (/DATA/TXN/PTSLESSON/@ispassquiz = 0)">
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">button</xsl:attribute>
                                             <xsl:attribute name="value">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GradeQuizNow']"/>
                                             </xsl:attribute>
                                             <xsl:attribute name="onclick">doSubmit(1,"")</xsl:attribute>
                                          </xsl:element>
                                       </xsl:if>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:if test="(/DATA/PARAM/@review != 0) and (/DATA/PARAM/@quizlimit = 0)">
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">button</xsl:attribute>
                                             <xsl:attribute name="value">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='RetakeQuiz']"/>
                                             </xsl:attribute>
                                             <xsl:attribute name="onclick">doSubmit(6,"")</xsl:attribute>
                                          </xsl:element>
                                       </xsl:if>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">3</xsl:attribute>
                                       <xsl:attribute name="height">12</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:if>

                              <xsl:if test="(/DATA/PARAM/@sessionid = 0)">
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">3</xsl:attribute>
                                       <xsl:attribute name="width">750</xsl:attribute>
                                       <xsl:attribute name="align">center</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="INPUT">
                                          <xsl:attribute name="type">button</xsl:attribute>
                                          <xsl:attribute name="value">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Continue']"/>
                                          </xsl:attribute>
                                          <xsl:attribute name="onclick">doSubmit(5,"")</xsl:attribute>
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

                           </xsl:if>
                           <xsl:if test="(/DATA/PARAM/@popup = 2)">
                              <xsl:if test="(/DATA/PARAM/@sessionid &gt; 0)">
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">3</xsl:attribute>
                                       <xsl:attribute name="width">750</xsl:attribute>
                                       <xsl:attribute name="align">center</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:if test="(/DATA/PARAM/@review = 0)">
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">button</xsl:attribute>
                                             <xsl:attribute name="value">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GradeQuizNow']"/>
                                             </xsl:attribute>
                                             <xsl:attribute name="onclick">doSubmit(1,"")</xsl:attribute>
                                          </xsl:element>
                                       </xsl:if>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:if test="(/DATA/PARAM/@review != 0) and (/DATA/TXN/PTSLESSON/@ispassquiz = 0)">
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">button</xsl:attribute>
                                             <xsl:attribute name="value">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GradeQuizNow']"/>
                                             </xsl:attribute>
                                             <xsl:attribute name="onclick">doSubmit(1,"")</xsl:attribute>
                                          </xsl:element>
                                       </xsl:if>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:if test="(/DATA/PARAM/@review != 0) and (/DATA/PARAM/@quizlimit = 0)">
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">button</xsl:attribute>
                                             <xsl:attribute name="value">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='RetakeQuiz']"/>
                                             </xsl:attribute>
                                             <xsl:attribute name="onclick">doSubmit(6,"")</xsl:attribute>
                                          </xsl:element>
                                       </xsl:if>
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
                                       <xsl:attribute name="colspan">3</xsl:attribute>
                                       <xsl:attribute name="height">12</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:if>

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