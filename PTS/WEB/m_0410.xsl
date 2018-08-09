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
         <xsl:with-param name="pagename" select="'Member Mentoring'"/>
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
                     <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[
               window.location.hash = 'top';
            ]]></xsl:text>;doErrorMsg('<xsl:value-of select="concat($errmsg, $errmsgfld)"/>')</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[
               window.location.hash = 'top';
            ]]></xsl:text>;doErrorMsg('<xsl:value-of select="/DATA/ERROR"/>')</xsl:attribute>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
               <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[
               window.location.hash = 'top';
            ]]></xsl:text></xsl:attribute>
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
               <xsl:attribute name="name">Member</xsl:attribute>
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
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ViewMember(id){ 
               var url, win;
               url = "0421.asp?memberid=" + id
               win = window.open(url,"MemberInfo","top=100,left=100,height=200,width=330,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no");
               win.focus();
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ViewPerformance(id){ 
               var url, win;
               url = "0445.asp?memberid=" + id
               win = window.open(url,"Performance","top=100,left=100,height=350,width=400,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no");
               win.focus();
             }]]></xsl:text>
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
                              <xsl:attribute name="width">150%</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">150%</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23) or (/DATA/SYSTEM/@usergroup = 51) or (/DATA/SYSTEM/@usergroup = 52)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">300%</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:element name="IMG">
                                    <xsl:attribute name="src">Images/mentormd.gif</xsl:attribute>
                                    <xsl:attribute name="align">absmiddle</xsl:attribute>
                                    <xsl:attribute name="border">0</xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MentorSystem']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/PARAM/@title" disable-output-escaping="yes"/>
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
                                 <xsl:attribute name="width">300%</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MyMentorID']"/>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">MentorID</xsl:attribute>
                                 <xsl:attribute name="id">MentorID</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@mentorid"/></xsl:attribute>
                                 <xsl:attribute name="size">4</xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="class">smbutton</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Update']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick">doSubmit(1,"")</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">3</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/SYSTEM/@usergroup &gt; 23) and (/DATA/SYSTEM/@usergroup != 51) and (/DATA/SYSTEM/@usergroup != 52)">
                           <xsl:if test="(/DATA/PARAM/@changementor != 0)">
                              <xsl:if test="(/DATA/PARAM/@memberid = /DATA/SYSTEM/@memberid)">
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">2</xsl:attribute>
                                       <xsl:attribute name="width">300%</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:attribute name="class">PageHeading</xsl:attribute>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/mentormd.gif</xsl:attribute>
                                          <xsl:attribute name="align">absmiddle</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MentorSystem']"/>
                                       <xsl:text>:</xsl:text>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/PARAM/@title" disable-output-escaping="yes"/>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">2</xsl:attribute>
                                       <xsl:attribute name="height">3</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:if>

                              <xsl:if test="(/DATA/PARAM/@memberid = /DATA/SYSTEM/@memberid)">
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">2</xsl:attribute>
                                       <xsl:attribute name="width">300%</xsl:attribute>
                                       <xsl:attribute name="align">right</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MyMentorID']"/>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:element name="INPUT">
                                       <xsl:attribute name="type">text</xsl:attribute>
                                       <xsl:attribute name="name">MentorID</xsl:attribute>
                                       <xsl:attribute name="id">MentorID</xsl:attribute>
                                       <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@mentorid"/></xsl:attribute>
                                       <xsl:attribute name="size">4</xsl:attribute>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:element name="INPUT">
                                          <xsl:attribute name="type">button</xsl:attribute>
                                          <xsl:attribute name="class">smbutton</xsl:attribute>
                                          <xsl:attribute name="value">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Update']"/>
                                          </xsl:attribute>
                                          <xsl:attribute name="onclick">doSubmit(1,"")</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">2</xsl:attribute>
                                       <xsl:attribute name="height">3</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:if>

                              <xsl:if test="(/DATA/PARAM/@memberid != /DATA/SYSTEM/@memberid)">
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">150%</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:attribute name="class">PageHeading</xsl:attribute>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/mentormd.gif</xsl:attribute>
                                          <xsl:attribute name="align">absmiddle</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MentorSystem']"/>
                                       <xsl:text>:</xsl:text>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/PARAM/@title" disable-output-escaping="yes"/>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">2</xsl:attribute>
                                       <xsl:attribute name="height">3</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:if>

                           </xsl:if>
                           <xsl:if test="(/DATA/PARAM/@changementor = 0)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">150%</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:attribute name="class">PageHeading</xsl:attribute>
                                    <xsl:element name="IMG">
                                       <xsl:attribute name="src">Images/mentormd.gif</xsl:attribute>
                                       <xsl:attribute name="align">absmiddle</xsl:attribute>
                                       <xsl:attribute name="border">0</xsl:attribute>
                                    </xsl:element>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MentorSystem']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:value-of select="/DATA/PARAM/@title" disable-output-escaping="yes"/>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="height">3</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>

                           </xsl:if>
                        </xsl:if>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">300%</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">prompt</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MentoringText']"/>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/PARAM/@mentorid = 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">300%</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoMentor']"/>
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
                                 <xsl:attribute name="width">300%</xsl:attribute>
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

                        </xsl:if>
                        <xsl:if test="(/DATA/PARAM/@mentorid != 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">300%</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">top</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">300%</xsl:attribute>
                                    <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">300%</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">300%</xsl:attribute>
                                             <xsl:attribute name="height">18</xsl:attribute>
                                             <xsl:attribute name="bgcolor">#D8EEFB</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">middle</xsl:attribute>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/mentora_sm.gif</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="b">
                                                <xsl:element name="font">
                                                   <xsl:attribute name="color">darkblue</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MyMentor']"/>
                                                </xsl:element>
                                                </xsl:element>
                                             <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, 'U'))">
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="onclick">w=window.open(this.href,"Tutorial","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                      <xsl:attribute name="href">Tutorial.asp?Lesson=7&amp;contentpage=3&amp;popup=1</xsl:attribute>
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/Tutorial.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PinnacleTutorials']"/></xsl:attribute>
                                                         <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PinnacleTutorials']"/></xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                             </xsl:if>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">300%</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:attribute name="class">PageHeading</xsl:attribute>
                                                <xsl:element name="b">
                                                <xsl:if test="(/DATA/TXN/PTSMEMBER/@image != '')">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/Member/<xsl:value-of select="/DATA/TXN/PTSMEMBER/@image"/></xsl:attribute>
                                                         <xsl:attribute name="width">50</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                </xsl:if>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namefirst"/>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namelast"/>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="href">#_</xsl:attribute>
                                                      <xsl:attribute name="onclick">ViewMember(<xsl:value-of select="/DATA/PARAM/@mentorid"/>)</xsl:attribute>
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/preview.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewInfo']"/></xsl:attribute>
                                                         <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewInfo']"/></xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="href">mailto:<xsl:value-of select="/DATA/TXN/PTSMEMBER/@email"/></xsl:attribute>
                                                   <xsl:value-of select="/DATA/TXN/PTSMEMBER/@email"/>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                       </xsl:element>

                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">2</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">300%</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IFRAME">
                                 <xsl:attribute name="src">m_9011.asp?OwnerType=-4&amp;OwnerID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;NewDate=<xsl:value-of select="/DATA/PARAM/@newdate"/>&amp;Title=<xsl:value-of select="/DATA/PARAM/@title"/></xsl:attribute>
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="height">150</xsl:attribute>
                                 <xsl:attribute name="frmheight">150</xsl:attribute>
                                 <xsl:attribute name="id">NotesFrame</xsl:attribute>
                                 <xsl:attribute name="name">NotesFrame</xsl:attribute>
                                 <xsl:attribute name="class">FrameNoScroll</xsl:attribute>
                                 <xsl:attribute name="frameborder">0</xsl:attribute>
                                 <xsl:element name="A">
                                    <xsl:attribute name="href">m_9011.asp?OwnerType=-4&amp;OwnerID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;NewDate=<xsl:value-of select="/DATA/PARAM/@newdate"/>&amp;Title=<xsl:value-of select="/DATA/PARAM/@title"/></xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoFrameSupport']"/>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23) or (contains(/DATA/SYSTEM/@useroptions, 'g'))">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">300%</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">top</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">300%</xsl:attribute>
                                    <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">175%</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">125%</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="width">300%</xsl:attribute>
                                             <xsl:attribute name="height">18</xsl:attribute>
                                             <xsl:attribute name="bgcolor">#D8EEFB</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">middle</xsl:attribute>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/mentorb_sm.gif</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="b">
                                                <xsl:element name="font">
                                                   <xsl:attribute name="color">darkblue</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MyMentorees']"/>
                                                </xsl:element>
                                                </xsl:element>
                                             <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, 'U'))">
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="onclick">w=window.open(this.href,"Tutorial","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                      <xsl:attribute name="href">Tutorial.asp?Lesson=8&amp;contentpage=3&amp;popup=1</xsl:attribute>
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/Tutorial.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PinnacleTutorials']"/></xsl:attribute>
                                                         <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PinnacleTutorials']"/></xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                             </xsl:if>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">175%</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:attribute name="class">prompt</xsl:attribute>
                                                   <xsl:element name="b">
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="color">red</xsl:attribute>
                                                   <xsl:value-of select="/DATA/PARAM/@memberid" disable-output-escaping="yes"/>
                                                   </xsl:element>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:if test="(/DATA/PARAM/@changementor != 0)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MentorNumberText']"/>
                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/PARAM/@changementor = 0)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MentorNumberText2']"/>
                                                   </xsl:if>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">125%</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">mailto:<xsl:value-of select="/DATA/PARAM/@emails"/></xsl:attribute>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/emailsend.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                      <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='emailteam']"/></xsl:attribute>
                                                      <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='emailteam']"/></xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="onclick">w=window.open(this.href,"Genealogy","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                   <xsl:attribute name="href">0470.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;Line=3&amp;Only=1</xsl:attribute>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/mentoringteam.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                      <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='mentoringteam']"/></xsl:attribute>
                                                      <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='mentoringteam']"/></xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
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
                                 <xsl:attribute name="width">300%</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">300%</xsl:attribute>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="width">10%</xsl:attribute>
                                          <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                          <xsl:attribute name="valign">Bottom</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="width">70%</xsl:attribute>
                                          <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                          <xsl:attribute name="valign">Bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MemberName']"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="width">20%</xsl:attribute>
                                          <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                          <xsl:attribute name="valign">Bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Visit']"/>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">3</xsl:attribute>
                                          <xsl:attribute name="height">2</xsl:attribute>
                                          <xsl:attribute name="bgcolor">#CCCCCC</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:for-each select="/DATA/TXN/PTSMEMBERS/PTSMEMBER">
                                       <xsl:element name="TR">
                                          <xsl:attribute name="height">48</xsl:attribute>
                                          <xsl:if test="(position() mod 2)=1">
                                             <xsl:attribute name="class">GrayBar</xsl:attribute>
                                          </xsl:if>
                                          <xsl:if test="(position() mod 2)=0">
                                             <xsl:attribute name="class">WhiteBar</xsl:attribute>
                                          </xsl:if>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">%</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:if test="(@image != '')">
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/Member/<xsl:value-of select="@image"/></xsl:attribute>
                                                      <xsl:attribute name="width">25</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                             </xsl:if>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">%</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="b">
                                                <xsl:element name="font">
                                                   <xsl:attribute name="color">purple</xsl:attribute>
                                                   <xsl:value-of select="@namefirst"/>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:value-of select="@namelast"/>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">#_</xsl:attribute>
                                                   <xsl:attribute name="onclick">ViewMember(<xsl:value-of select="@memberid"/>)</xsl:attribute>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/preview.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                      <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewInfo']"/></xsl:attribute>
                                                      <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewInfo']"/></xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="BR"/>
                                                <xsl:element name="b">
                                                <xsl:if test="(@mentorid != 0)">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                                         <xsl:attribute name="href">0410.asp?MemberID=<xsl:value-of select="@memberid"/>&amp;M=<xsl:value-of select="/DATA/PARAM/@m"/>&amp;ContentPage=3&amp;Popup=0</xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/mentorsm.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='mentoring']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='mentoring']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(contains(@unit, '2'))">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"Calendar","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">Calendar.asp?MemberID=<xsl:value-of select="@memberid"/>&amp;M=1</xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/calendarsm.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='calendar']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='calendar']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(contains(@unit, 'H'))">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"Goals","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">7001.asp?MemberID=<xsl:value-of select="@memberid"/>&amp;M=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;ContentPage=3&amp;Popup=1</xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/goalsm.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='goals']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='goals']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(contains(@unit, 'h'))">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"Sales","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">8161.asp?MemberID=<xsl:value-of select="@memberid"/>&amp;M=1&amp;ContentPage=3&amp;Popup=1</xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/Contactsm.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='viewcontacts']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='viewcontacts']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(contains(@unit, 'E')) or (contains(@options, 'E'))">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"Sales","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">8101.asp?MemberID=<xsl:value-of select="@memberid"/>&amp;M=1&amp;ContentPage=3&amp;Popup=1</xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/Prospectsm.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='viewprospects']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='viewprospects']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(contains(@unit, '6'))">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"Sales","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">8151.asp?MemberID=<xsl:value-of select="@memberid"/>&amp;M=1&amp;ContentPage=3&amp;Popup=1</xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/Customersm.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='viewcustomers']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='viewcustomers']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(contains(@unit, 'L'))">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"Assessments","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">3411.asp?MemberID=<xsl:value-of select="@memberid"/>&amp;M=1&amp;ContentPage=3&amp;Popup=1</xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/Assessmentsm.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='assessments']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='assessments']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(contains(@unit, 'K'))">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"Courses","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">1314.asp?MemberID=<xsl:value-of select="@memberid"/>&amp;M=1&amp;ContentPage=3&amp;Popup=1</xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/Classsm.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='classes']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='classes']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(contains(@unit, 'F')) or (contains(@options, 'F')) or (contains(@options, 'f'))">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"Projects","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">7501.asp?MemberID=<xsl:value-of select="@memberid"/>&amp;CompanyID=<xsl:value-of select="@companyid"/>&amp;M=1&amp;ContentPage=3&amp;Popup=1</xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/Projectsm.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='projects']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='projects']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:if test="(@quantity = 0)">
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"Notes","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">0415.asp?MemberID=<xsl:value-of select="@memberid"/>&amp;M=1&amp;NewDate=<xsl:value-of select="/DATA/PARAM/@newdate"/></xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/notessm.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='notes']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='notes']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(@quantity &gt; 0)">
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"Notes","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">0415.asp?MemberID=<xsl:value-of select="@memberid"/>&amp;M=1&amp;NewDate=<xsl:value-of select="/DATA/PARAM/@newdate"/></xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/notessm1.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='notes']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='notes']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:if test="(not(@notifymentor))">
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                                         <xsl:attribute name="href">0417.asp?MemberID=<xsl:value-of select="@memberid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/notifysm.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='notifications']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='notifications']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(@notifymentor)">
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                                         <xsl:attribute name="href">0417.asp?MemberID=<xsl:value-of select="@memberid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/notifysm1.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='notifications']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='notifications']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">%</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="font">
                                                   <xsl:attribute name="color">purple</xsl:attribute>
                                                <xsl:value-of select="@visitdate"/>
                                                </xsl:element>
                                                <xsl:element name="BR"/>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                                   <xsl:attribute name="href">0410.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;RemoveID=<xsl:value-of select="@memberid"/>&amp;ContentPage=3&amp;Popup=0</xsl:attribute>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/Trash.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                      <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Remove']"/></xsl:attribute>
                                                      <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Remove']"/></xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:for-each>
                                    <xsl:choose>
                                       <xsl:when test="(count(/DATA/TXN/PTSMEMBERS/PTSMEMBER) = 0)">
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="colspan">3</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="class">NoItems</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoItems']"/>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:when>
                                    </xsl:choose>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">3</xsl:attribute>
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
                                 <xsl:attribute name="width">300%</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="b">
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TotalMembers']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/PARAM/@count" disable-output-escaping="yes"/>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">300%</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">button</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MarkRead']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick">doSubmit(2,"")</xsl:attribute>
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