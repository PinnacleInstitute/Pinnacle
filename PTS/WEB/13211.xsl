<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
   <xsl:include href="HTMLHeading.xsl"/>
   <xsl:include href="Bookmark.xsl"/>
   <xsl:output omit-xml-declaration="yes"/>

   <xsl:template match="/">

      <xsl:variable name="usergroup" select="/DATA/SYSTEM/@usergroup"/>

      <xsl:element name="link">
         <xsl:attribute name="rel">stylesheet</xsl:attribute>
         <xsl:attribute name="type">text/css</xsl:attribute>
         <xsl:attribute name="href">include/StyleSheet12.css</xsl:attribute>
      </xsl:element>

      <xsl:call-template name="HTMLHeading">
         <xsl:with-param name="pagename" select="'News Home'"/>
         <xsl:with-param name="includecalendar" select="true()"/>
         <xsl:with-param name="htmleditor"></xsl:with-param>
      </xsl:call-template>

      <xsl:element name="SCRIPT">
         <xsl:attribute name="type">text/javascript</xsl:attribute>
         <xsl:attribute name="src">http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js</xsl:attribute>
         <xsl:text> </xsl:text>
      </xsl:element>

      <xsl:element name="SCRIPT">
         <xsl:attribute name="type">text/javascript</xsl:attribute>
         <xsl:attribute name="src">include/basicslide/bjqs-1.3.min.js</xsl:attribute>
         <xsl:text> </xsl:text>
      </xsl:element>

      <xsl:element name="LINK">
         <xsl:attribute name="rel">stylesheet</xsl:attribute>
         <xsl:attribute name="type">text/css</xsl:attribute>
         <xsl:attribute name="href">include/basicslide/bjqs.css</xsl:attribute>
         <xsl:attribute name="media">all</xsl:attribute>
      </xsl:element>

      <xsl:element name="SCRIPT">
         <xsl:attribute name="language">JavaScript</xsl:attribute>
         <xsl:text disable-output-escaping="yes"><![CDATA[
            $(function() {
               $("#Main").bjqs({
                  width:680,
                  height:350,
                  animduration:1000,
                  animspeed:7000,
                  showcontrols:true,
                  nexttext:">",
                  prevtext:"<",
                  showmarkers:true
               });
            });
         ]]></xsl:text>
      </xsl:element>

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
            <xsl:attribute name="width">750</xsl:attribute>
            <xsl:attribute name="align">left</xsl:attribute>

            <!--BEGIN FORM-->
            <xsl:element name="FORM">
               <xsl:attribute name="name">R180</xsl:attribute>
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
                     <xsl:attribute name="width">0</xsl:attribute>
                  </xsl:element>
                  <xsl:element name="TD">
                     <xsl:attribute name="width">750</xsl:attribute>
                  </xsl:element>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
                  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
                  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
                  var tmpID = '<xsl:value-of select="/DATA/SYSTEM/@ga_acctid"/>'
                  var tmpDomain = '<xsl:value-of select="/DATA/SYSTEM/@ga_domain"/>'
                  <xsl:text disable-output-escaping="yes">if( tmpID.length != 0 &amp;&amp; tmpDomain.length != 0 ) {</xsl:text>
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
                     <xsl:attribute name="width">1200</xsl:attribute>

                     <xsl:element name="TABLE">
                        <xsl:attribute name="border">0</xsl:attribute>
                        <xsl:attribute name="cellpadding">0</xsl:attribute>
                        <xsl:attribute name="cellspacing">0</xsl:attribute>
                        <xsl:attribute name="width">1200</xsl:attribute>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">1200</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">1200</xsl:attribute>
                              <xsl:attribute name="height">40</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">1200</xsl:attribute>
                                 <xsl:attribute name="height">40</xsl:attribute>
                                 <xsl:attribute name="style">border: 1px #cccccc solid; background-color: #FFFFFF</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">700</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                          <xsl:element name="TABLE">
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="cellpadding">0</xsl:attribute>
                                             <xsl:attribute name="cellspacing">0</xsl:attribute>
                                             <xsl:attribute name="width">700</xsl:attribute>
                                             <xsl:attribute name="style">border: 1px #cccccc solid; background-color: #f8f8f8</xsl:attribute>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">2</xsl:attribute>
                                                      <xsl:attribute name="height">12</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">20</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">680</xsl:attribute>
                                                      <xsl:attribute name="align">left</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="size">4</xsl:attribute>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TopNews']"/>
                                                         </xsl:element>
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
                                                      <xsl:attribute name="width">20</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">680</xsl:attribute>
                                                      <xsl:attribute name="align">left</xsl:attribute>
                                                      <xsl:attribute name="valign">top</xsl:attribute>
                                                      <xsl:element name="TABLE">
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="cellpadding">0</xsl:attribute>
                                                         <xsl:attribute name="cellspacing">0</xsl:attribute>
                                                         <xsl:attribute name="width">680</xsl:attribute>

                                                            <xsl:element name="TR">
                                                               <xsl:element name="TD">
                                                                  <xsl:attribute name="width">680</xsl:attribute>
                                                                  <xsl:attribute name="align">left</xsl:attribute>
                                                                  <xsl:attribute name="valign">center</xsl:attribute>
                                                                  <xsl:element name="DIV">
                                                                     <xsl:attribute name="style">margin-bottom:40px;</xsl:attribute>
                                                                  <xsl:element name="div">
                                                                     <xsl:attribute name="id">Main</xsl:attribute>
                                                                     <xsl:element name="ul">
                                                                        <xsl:attribute name="class">bjqs</xsl:attribute>
                                                                        <xsl:for-each select="/DATA/TXN/PTSNEWSS/PTSNEWS[@leadmain=1]">
                                                                           <xsl:element name="li">
                                                                        <xsl:element name="DIV">
                                                                           <xsl:attribute name="id">title</xsl:attribute>
                                                                           <xsl:attribute name="style">width:380; padding:10; background-color:#1c1c1c; float:left</xsl:attribute>
                                                                           <xsl:element name="A">
                                                                              <xsl:attribute name="href">#_</xsl:attribute>
                                                                              <xsl:attribute name="onclick">parent.ShowTab('TabStory', <xsl:value-of select="@newsid"/>)</xsl:attribute>
                                                                           <xsl:element name="font">
                                                                              <xsl:attribute name="size">5</xsl:attribute>
                                                                              <xsl:attribute name="color">white</xsl:attribute>
                                                                           <xsl:value-of select="@title"/>
                                                                           </xsl:element>
                                                                           </xsl:element>
                                                                        </xsl:element>
                                                                           <xsl:element name="A">
                                                                              <xsl:attribute name="href">#_</xsl:attribute>
                                                                              <xsl:attribute name="onclick">parent.ShowTab('TabStory', <xsl:value-of select="@newsid"/>)</xsl:attribute>
                                                                              <xsl:element name="IMG">
                                                                                 <xsl:attribute name="src">Images/News\<xsl:value-of select="/DATA/PARAM/@companyid"/>/<xsl:value-of select="@image"/></xsl:attribute>
                                                                                 <xsl:attribute name="width">400</xsl:attribute>
                                                                                 <xsl:attribute name="border">0</xsl:attribute>
                                                                              </xsl:element>
                                                                           </xsl:element>
                                                                        <xsl:element name="DIV">
                                                                           <xsl:attribute name="id">title</xsl:attribute>
                                                                           <xsl:attribute name="style">width:260; padding:10; float:right; position:absolute; top:0px; right:0px</xsl:attribute>
                                                                           <xsl:value-of select="DESCRIPTION/comment()" disable-output-escaping="yes"/>
                                                                        </xsl:element>
                                                                           </xsl:element>
                                                                        </xsl:for-each>
                                                                     </xsl:element>
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
                                                      <xsl:attribute name="height">12</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">20</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">680</xsl:attribute>
                                                      <xsl:attribute name="align">left</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="size">4</xsl:attribute>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='OtherTopNews']"/>
                                                         </xsl:element>
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
                                                      <xsl:attribute name="width">20</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">660</xsl:attribute>
                                                      <xsl:attribute name="align">left</xsl:attribute>
                                                      <xsl:attribute name="valign">top</xsl:attribute>
                                                      <xsl:element name="TABLE">
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="cellpadding">0</xsl:attribute>
                                                         <xsl:attribute name="cellspacing">0</xsl:attribute>
                                                         <xsl:attribute name="width">660</xsl:attribute>

                                                            <xsl:for-each select="/DATA/TXN/PTSNEWSS/PTSNEWS[@leadmain=2]">
                                                                  <xsl:element name="TR">
                                                                     <xsl:attribute name="height">30</xsl:attribute>
                                                                     <xsl:element name="TD">
                                                                        <xsl:attribute name="width">20</xsl:attribute>
                                                                     </xsl:element>
                                                                     <xsl:element name="TD">
                                                                        <xsl:attribute name="width">640</xsl:attribute>
                                                                        <xsl:attribute name="align">left</xsl:attribute>
                                                                        <xsl:attribute name="valign">center</xsl:attribute>
                                                                           <xsl:element name="b">
                                                                           <xsl:element name="font">
                                                                              <xsl:attribute name="color">1c1c1c</xsl:attribute>
                                                                              <xsl:element name="IMG">
                                                                                 <xsl:attribute name="src">Images/reddot.gif</xsl:attribute>
                                                                                 <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                                 <xsl:attribute name="border">0</xsl:attribute>
                                                                              </xsl:element>
                                                                              <xsl:element name="A">
                                                                                 <xsl:attribute name="href">#_</xsl:attribute>
                                                                                 <xsl:attribute name="onclick">parent.ShowTab('TabStory', <xsl:value-of select="@newsid"/>)</xsl:attribute>
                                                                              <xsl:value-of select="@title"/>
                                                                              </xsl:element>
                                                                           </xsl:element>
                                                                           </xsl:element>
                                                                     </xsl:element>
                                                                  </xsl:element>

                                                            </xsl:for-each>
                                                      </xsl:element>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">2</xsl:attribute>
                                                      <xsl:attribute name="height">24</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">20</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">4</xsl:attribute>
                                                      <xsl:attribute name="width">675</xsl:attribute>
                                                      <xsl:attribute name="align">left</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="TABLE">
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="cellpadding">0</xsl:attribute>
                                                         <xsl:attribute name="cellspacing">0</xsl:attribute>
                                                         <xsl:attribute name="width">675</xsl:attribute>

                                                            <xsl:element name="TR">
                                                               <xsl:element name="TD">
                                                                  <xsl:attribute name="width">225</xsl:attribute>
                                                                  <xsl:attribute name="align">center</xsl:attribute>
                                                               </xsl:element>
                                                               <xsl:element name="TD">
                                                                  <xsl:attribute name="width">225</xsl:attribute>
                                                                  <xsl:attribute name="align">center</xsl:attribute>
                                                               </xsl:element>
                                                               <xsl:element name="TD">
                                                                  <xsl:attribute name="width">225</xsl:attribute>
                                                                  <xsl:attribute name="align">center</xsl:attribute>
                                                               </xsl:element>
                                                            </xsl:element>
                                                            <xsl:for-each select="/DATA/TXN/PTSNEWSTOPICS/PTSNEWSTOPIC[position() mod 3 = 1]">
                                                                  <xsl:variable name="tmpRow"><xsl:value-of select="position()-1"/></xsl:variable>

                                                                  <xsl:element name="TR">
                                                                     <xsl:for-each select=".|following-sibling::PTSNEWSTOPIC[position() &lt; 3]">
                                                                           <xsl:variable name="tmpNewsTopicID"><xsl:value-of select="@newstopicid"/></xsl:variable>

                                                                           <xsl:element name="TD">
                                                                              <xsl:attribute name="width">225</xsl:attribute>
                                                                              <xsl:attribute name="align">left</xsl:attribute>
                                                                              <xsl:attribute name="valign">top</xsl:attribute>
                                                                              <xsl:element name="DIV">
                                                                                 <xsl:attribute name="class">NewsTopicContainer</xsl:attribute>
                                                                              <xsl:element name="DIV">
                                                                                 <xsl:attribute name="class">NewsTopicInnerContainer</xsl:attribute>
                                                                              <xsl:element name="DIV">
                                                                                 <xsl:attribute name="class">NewsTopicHeader NewsTopicHeader<xsl:value-of select="( ($tmpRow * 3) + position() ) mod 5"/></xsl:attribute>
                                                                                 <xsl:value-of select="@newstopicname"/>
                                                                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                                 <xsl:element name="A">
                                                                                    <xsl:attribute name="href">#_</xsl:attribute>
                                                                                    <xsl:attribute name="onclick">parent.ShowTab('TabTopic', <xsl:value-of select="@newstopicid"/>)</xsl:attribute>
                                                                                    <xsl:element name="IMG">
                                                                                       <xsl:attribute name="src">Images/preview2.gif</xsl:attribute>
                                                                                       <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                                       <xsl:attribute name="border">0</xsl:attribute>
                                                                                    </xsl:element>
                                                                                 </xsl:element>
                                                                              </xsl:element>
                                                                              <xsl:element name="DIV">
                                                                                 <xsl:attribute name="class">NewsTopicNews</xsl:attribute>
                                                                              <xsl:for-each select="/DATA/TXN/PTSTOPICS/PTSTOPIC[@status = $tmpNewsTopicID]">
                                                                                    <xsl:element name="DIV">
                                                                                       <xsl:attribute name="class">NewsTopicStory</xsl:attribute>
                                                                                    <xsl:if test="(position() = 1)">
                                                                                          <xsl:element name="A">
                                                                                             <xsl:attribute name="href">#_</xsl:attribute>
                                                                                             <xsl:attribute name="onclick">parent.ShowTab('TabStory', <xsl:value-of select="@newsid"/>)</xsl:attribute>
<xsl:element name="IMG">
   <xsl:attribute name="src">Images/News\<xsl:value-of select="/DATA/PARAM/@companyid"/>\topic/<xsl:value-of select="@image"/></xsl:attribute>
   <xsl:attribute name="width">220</xsl:attribute>
   <xsl:attribute name="height">80</xsl:attribute>
   <xsl:attribute name="border">0</xsl:attribute>
</xsl:element>
                                                                                          </xsl:element>
                                                                                    </xsl:if>
                                                                                          <xsl:element name="IMG">
                                                                                             <xsl:attribute name="src">Images/reddot.gif</xsl:attribute>
                                                                                             <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                                             <xsl:attribute name="border">0</xsl:attribute>
                                                                                          </xsl:element>
                                                                                          <xsl:element name="A">
                                                                                             <xsl:attribute name="href">#_</xsl:attribute>
                                                                                             <xsl:attribute name="onclick">parent.ShowTab('TabStory', <xsl:value-of select="@newsid"/>)</xsl:attribute>
                                                                                          <xsl:value-of select="@title"/>
                                                                                          </xsl:element>
                                                                                    </xsl:element>
                                                                              </xsl:for-each>
                                                                              </xsl:element>
                                                                              </xsl:element>
                                                                              </xsl:element>
                                                                           </xsl:element>
                                                                     </xsl:for-each>
                                                                  </xsl:element>

                                                            </xsl:for-each>
                                                      </xsl:element>
                                                   </xsl:element>
                                                </xsl:element>

                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                          <xsl:element name="TABLE">
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="cellpadding">0</xsl:attribute>
                                             <xsl:attribute name="cellspacing">0</xsl:attribute>
                                             <xsl:attribute name="width">200</xsl:attribute>
                                             <xsl:attribute name="style">border: 1px #cccccc solid;</xsl:attribute>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">3</xsl:attribute>
                                                      <xsl:attribute name="height">12</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">10</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">180</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="size">4</xsl:attribute>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BreakingNews']"/>
                                                         </xsl:element>
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
                                                      <xsl:attribute name="width">10</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">180</xsl:attribute>
                                                      <xsl:attribute name="align">left</xsl:attribute>
                                                      <xsl:attribute name="valign">top</xsl:attribute>
                                                      <xsl:element name="TABLE">
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="cellpadding">0</xsl:attribute>
                                                         <xsl:attribute name="cellspacing">0</xsl:attribute>
                                                         <xsl:attribute name="width">180</xsl:attribute>

                                                            <xsl:for-each select="/DATA/TXN/PTSBREAKINGS/PTSBREAKING">
                                                                  <xsl:if test="(@image != '')">
                                                                     <xsl:element name="TR">
                                                                        <xsl:element name="TD">
                                                                           <xsl:attribute name="width">180</xsl:attribute>
                                                                           <xsl:attribute name="align">center</xsl:attribute>
                                                                           <xsl:attribute name="valign">center</xsl:attribute>
                                                                           <xsl:element name="A">
                                                                              <xsl:attribute name="href">#_</xsl:attribute>
                                                                              <xsl:attribute name="onclick">parent.ShowTab('TabStory', <xsl:value-of select="@newsid"/>)</xsl:attribute>
                                                                              <xsl:element name="IMG">
                                                                                 <xsl:attribute name="src">Images/News\<xsl:value-of select="/DATA/PARAM/@companyid"/>\break/<xsl:value-of select="@image"/></xsl:attribute>
                                                                                 <xsl:attribute name="width">150</xsl:attribute>
                                                                                 <xsl:attribute name="border">0</xsl:attribute>
                                                                              </xsl:element>
                                                                           </xsl:element>
                                                                        </xsl:element>
                                                                     </xsl:element>
                                                                  </xsl:if>

                                                                  <xsl:element name="TR">
                                                                     <xsl:element name="TD">
                                                                        <xsl:attribute name="width">180</xsl:attribute>
                                                                        <xsl:attribute name="align">left</xsl:attribute>
                                                                        <xsl:attribute name="valign">center</xsl:attribute>
                                                                        <xsl:element name="A">
                                                                           <xsl:attribute name="href">#_</xsl:attribute>
                                                                           <xsl:attribute name="onclick">parent.ShowTab('TabStory', <xsl:value-of select="@newsid"/>)</xsl:attribute>
                                                                        <xsl:element name="b">
                                                                        <xsl:element name="font">
                                                                           <xsl:attribute name="color">1c1c1c</xsl:attribute>
                                                                        <xsl:value-of select="@title"/>
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
                                                                  <xsl:element name="TR">
                                                                     <xsl:element name="TD">
                                                                        <xsl:attribute name="width">180</xsl:attribute>
                                                                        <xsl:attribute name="height">1</xsl:attribute>
                                                                        <xsl:attribute name="bgcolor">cccccc</xsl:attribute>
                                                                     </xsl:element>
                                                                  </xsl:element>
                                                                  <xsl:element name="TR">
                                                                     <xsl:element name="TD">
                                                                        <xsl:attribute name="colspan">1</xsl:attribute>
                                                                        <xsl:attribute name="height">6</xsl:attribute>
                                                                     </xsl:element>
                                                                  </xsl:element>

                                                            </xsl:for-each>
                                                      </xsl:element>
                                                   </xsl:element>
                                                </xsl:element>

                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                          <xsl:for-each select="/DATA/TXN/PTSADS/PTSAD">
                                                   <xsl:value-of select="MSG/comment()" disable-output-escaping="yes"/>
                                          </xsl:for-each>
                                       </xsl:element>
                                    </xsl:element>

                              </xsl:element>
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

      </xsl:element>
      <!--END BODY-->

   </xsl:template>
</xsl:stylesheet>