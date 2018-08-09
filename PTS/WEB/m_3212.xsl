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
         <xsl:with-param name="pagename" select="'Assessment Questions'"/>
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
                     <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[UpdateTimer()]]></xsl:text>;doErrorMsg('<xsl:value-of select="concat($errmsg, $errmsgfld)"/>')</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[UpdateTimer()]]></xsl:text>;doErrorMsg('<xsl:value-of select="/DATA/ERROR"/>')</xsl:attribute>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
               <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[UpdateTimer()]]></xsl:text></xsl:attribute>
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
               <xsl:attribute name="name">AssessQuestion</xsl:attribute>
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
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function UpdateTimer(){ 
               setTimeout("UpdateTimer()", 1000);
               var secs = parseInt(document.getElementById('Seconds').value);
               var limit = parseInt(document.getElementById('TimeLimit').value);
               secs = secs + 1;
               document.getElementById('Seconds').value = secs;
               if( limit != '' && limit != '0' ) {
               if( secs >= (limit * 60))
               {
               alert('Your time has expired!');
               doSubmit(2,'');
               };
               };
               var seconds = secs % 60;
               var minutes = Math.floor((secs / 60) % 60 );
               var hours = Math.floor(secs / 3600);
               var fmt = "";
               if(hours > 0){ fmt = Math.floor(secs / 3600 ) + ":"};
               if(minutes < 10 ){ fmt = fmt + "0" };
               fmt = fmt + minutes + ":";
               if(seconds < 10 ){ fmt = fmt + "0" };
               fmt = fmt + seconds;
               if( limit != '' && limit != '0' ) {
               fmt = fmt + ' of ' + limit + ' min.';
               };
               document.getElementById('Timer').value = fmt;
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ValidRank(obj){ 
               var val = parseInt(obj.value);
               var nam = obj.name;
               var minval = parseInt(document.getElementById(nam + 'min').value);
               var maxval = parseInt(document.getElementById(nam + 'max').value);
               if (val < minval || val > maxval){ alert( minval + ' - ' + maxval ); }
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ValidPriority(obj){ 
               var val = parseInt(obj.value);
               var nam = obj.name;
               var minval = parseInt(document.getElementById(nam + 'min').value);
               var maxval = parseInt(document.getElementById(nam + 'max').value);
               if (val < minval || val > maxval){ alert( minval + ' - ' + maxval ); }
             }]]></xsl:text>
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

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ReportAssessment(){ 
               var aid = document.getElementById('AssessmentID').value;
               var maid = document.getElementById('MemberAssessID').value;
               var url = "m_3460.asp?assessmentid=" + aid + "&memberassessid=" + maid;
               var win = window.open(url,"AssessReport");
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
                              <xsl:attribute name="width">5%</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">95%</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">AssessmentID</xsl:attribute>
                              <xsl:attribute name="id">AssessmentID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@assessmentid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">MemberAssessID</xsl:attribute>
                              <xsl:attribute name="id">MemberAssessID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@memberassessid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">MemberID</xsl:attribute>
                              <xsl:attribute name="id">MemberID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@memberid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Identify</xsl:attribute>
                              <xsl:attribute name="id">Identify</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@identify"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Seconds</xsl:attribute>
                              <xsl:attribute name="id">Seconds</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@seconds"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">TimeLimit</xsl:attribute>
                              <xsl:attribute name="id">TimeLimit</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@timelimit"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Grp</xsl:attribute>
                              <xsl:attribute name="id">Grp</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@grp"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Count</xsl:attribute>
                              <xsl:attribute name="id">Count</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@count"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">AssessQuestionID</xsl:attribute>
                              <xsl:attribute name="id">AssessQuestionID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@assessquestionid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Questions</xsl:attribute>
                              <xsl:attribute name="id">Questions</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@questions"/></xsl:attribute>
                           </xsl:element>

                        <xsl:if test="(/DATA/PARAM/@identify &gt; 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IdentificationInfo']"/>
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
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="width">100%</xsl:attribute>
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
                                 <xsl:if test="(/DATA/PARAM/@popup = 0)">
                                    <xsl:element name="INPUT">
                                       <xsl:attribute name="type">button</xsl:attribute>
                                       <xsl:attribute name="class">smbutton</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ReturnMyAssessments']"/>
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
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/PARAM/@identify &lt;= 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                    <xsl:value-of select="/DATA/TXN/PTSASSESSMENT/@assessmentname"/>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">Timer</xsl:attribute>
                                 <xsl:attribute name="id">Timer</xsl:attribute>
                                 <xsl:attribute name="value">00:00:00</xsl:attribute>
                                 <xsl:attribute name="style">BORDER:none; COLOR:black; BACKGROUND:#eaeaea; TEXT-ALIGN:right;</xsl:attribute>
                                 <xsl:attribute name="DISABLED"/>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">1</xsl:attribute>
                                 <xsl:attribute name="bgcolor">#000000</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:if test="(/DATA/PARAM/@assessquestionid = 0)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="height">24</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">5%</xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">95%</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:attribute name="class">PageHeading</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AssessmentComplete']"/>
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
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="width">100%</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="INPUT">
                                       <xsl:attribute name="type">button</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewReport']"/>
                                       </xsl:attribute>
                                       <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[ReportAssessment()]]></xsl:text></xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="height">24</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>

                           </xsl:if>
                           <xsl:if test="(/DATA/PARAM/@assessquestionid != 0)">
                              <xsl:if test="(count(/DATA/TXN/PTSASSESSQUESTIONS/PTSASSESSQUESTION) = 0) and (/DATA/TXN/PTSASSESSQUESTION/@questiontype != 4)">
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">5%</xsl:attribute>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">95%</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:attribute name="class">Prompt</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoQuestionAvail']"/>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">2</xsl:attribute>
                                       <xsl:attribute name="height">6</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:if>

                              <xsl:if test="(/DATA/TXN/PTSASSESSQUESTION/@questiontype = 4)">
                                 <xsl:if test="(/DATA/TXN/PTSASSESSQUESTION/@mediatype = 1)">
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">2</xsl:attribute>
                                          <xsl:attribute name="width">100%</xsl:attribute>
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
                                       <xsl:attribute name="colspan">2</xsl:attribute>
                                       <xsl:attribute name="width">100%</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:value-of select="/DATA/TXN/PTSASSESSQUESTION/@question"/>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:if test="(/DATA/TXN/PTSASSESSQUESTION/@mediatype &gt; 1)">
                                             <xsl:if test="(contains(/DATA/TXN/PTSASSESSQUESTION/@mediafile,':'))">
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="onclick">w=window.open(this.href,"Video","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                      <xsl:attribute name="href">m_2431.asp?Video=<xsl:value-of select="/DATA/TXN/PTSASSESSQUESTION/@mediafile"/></xsl:attribute>
                                                   <xsl:element name="b">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PlayClip']"/>
                                                   </xsl:element>
                                                   </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(not(contains(/DATA/TXN/PTSASSESSQUESTION/@mediafile,':')))">
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="onclick">w=window.open(this.href,"Video","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                      <xsl:attribute name="href">m_2431.asp?Video=Sections\Assessment\<xsl:value-of select="concat(/DATA/PARAM/@assessmentid,'\',/DATA/TXN/PTSASSESSQUESTION/@mediafile)"/></xsl:attribute>
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
                                       <xsl:attribute name="colspan">2</xsl:attribute>
                                       <xsl:attribute name="height">6</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>

                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">5%</xsl:attribute>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">95%</xsl:attribute>
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
                                       <xsl:attribute name="width">5%</xsl:attribute>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">95%</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:value-of select="/DATA/TXN/PTSASSESSQUESTION/DESCRIPTION/comment()" disable-output-escaping="yes"/>
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
                                       <xsl:attribute name="height">24</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">5%</xsl:attribute>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">95%</xsl:attribute>
                                       <xsl:attribute name="align">center</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:attribute name="class">PageHeading</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AssessmentComplete']"/>
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
                                       <xsl:attribute name="width">5%</xsl:attribute>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">95%</xsl:attribute>
                                       <xsl:attribute name="align">center</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="A">
                                          <xsl:attribute name="onclick">w=window.open(this.href,"Report","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                          <xsl:attribute name="href">m_3460.asp?AssessmentID=<xsl:value-of select="/DATA/PARAM/@assessmentid"/>&amp;MemberAssessID=<xsl:value-of select="/DATA/PARAM/@memberassessid"/></xsl:attribute>
                                       <xsl:element name="b">
                                       <xsl:element name="font">
                                          <xsl:attribute name="size">3</xsl:attribute>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/Report.gif</xsl:attribute>
                                             <xsl:attribute name="align">absmiddle</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewReport']"/>
                                       </xsl:element>
                                       </xsl:element>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">2</xsl:attribute>
                                       <xsl:attribute name="height">24</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>

                              </xsl:if>
                              <xsl:if test="(/DATA/TXN/PTSASSESSQUESTION/@questiontype != 4)">
                                 <xsl:element name="TR">
                                    <xsl:for-each select="/DATA/TXN/PTSASSESSQUESTIONS/PTSASSESSQUESTION">
                                          <xsl:if test="(@questiontype &lt;= 2)">
                                             <xsl:element name="INPUT">
                                                <xsl:attribute name="type">hidden</xsl:attribute>
                                                <xsl:attribute name="name"><xsl:value-of select="@assessquestionid"/>min</xsl:attribute>
                                                <xsl:attribute name="id"><xsl:value-of select="@assessquestionid"/>min</xsl:attribute>
                                                <xsl:attribute name="value"><xsl:value-of select="@rankmin"/></xsl:attribute>
                                             </xsl:element>
                                             <xsl:element name="INPUT">
                                                <xsl:attribute name="type">hidden</xsl:attribute>
                                                <xsl:attribute name="name"><xsl:value-of select="@assessquestionid"/>max</xsl:attribute>
                                                <xsl:attribute name="id"><xsl:value-of select="@assessquestionid"/>max</xsl:attribute>
                                                <xsl:attribute name="value"><xsl:value-of select="@rankmax"/></xsl:attribute>
                                             </xsl:element>
                                          </xsl:if>

                                          <xsl:if test="(DESCRIPTION/comment() != '')">
                                             <xsl:if test="(position() != 1)">
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
                                             </xsl:if>

                                             <xsl:element name="TR">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">5%</xsl:attribute>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">95%</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:attribute name="class">prompt</xsl:attribute>
                                                   <xsl:value-of select="DESCRIPTION/comment()" disable-output-escaping="yes"/>
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
                                                   <xsl:attribute name="width">5%</xsl:attribute>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">95%</xsl:attribute>
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
                                          <xsl:if test="(@mediatype = 1)">
                                             <xsl:element name="TR">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">5%</xsl:attribute>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">95%</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Sections\Assessment\<xsl:value-of select="/DATA/PARAM/@assessmentid"/>\<xsl:value-of select="@mediafile"/></xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:if>

                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">5%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">top</xsl:attribute>
                                                <xsl:value-of select="position()"/>.
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">95%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:if test="(@questiontype = 1)">
                                                      <xsl:element name="INPUT">
                                                      <xsl:attribute name="type">text</xsl:attribute>
                                                      <xsl:attribute name="name"><xsl:value-of select="@assessquestionid"/></xsl:attribute>
                                                      <xsl:attribute name="id"><xsl:value-of select="@assessquestionid"/></xsl:attribute>
                                                      <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSASSESSANSWERS/PTSASSESSANSWER[@assessquestionid=current()/@assessquestionid]/@answer"/></xsl:attribute>
                                                      <xsl:attribute name="size">2</xsl:attribute>
                                                      <xsl:attribute name="onkeyup"><xsl:text disable-output-escaping="yes"><![CDATA[ValidPriority(this)]]></xsl:text></xsl:attribute>
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
                                                      <xsl:attribute name="onkeyup"><xsl:text disable-output-escaping="yes"><![CDATA[ValidRank(this)]]></xsl:text></xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                </xsl:if>
                                                   <xsl:value-of select="@question"/>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:if test="(@mediatype &gt; 1)">
                                                   <xsl:if test="(contains(@mediafile,':'))">
                                                         <xsl:element name="A">
                                                            <xsl:attribute name="onclick">w=window.open(this.href,"Video","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                            <xsl:attribute name="href">m_2431.asp?Video=<xsl:value-of select="@mediafile"/></xsl:attribute>
                                                         <xsl:element name="b">
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PlayClip']"/>
                                                         </xsl:element>
                                                         </xsl:element>
                                                   </xsl:if>
                                                   <xsl:if test="(not(contains(@mediafile,':')))">
                                                         <xsl:element name="A">
                                                            <xsl:attribute name="onclick">w=window.open(this.href,"Video","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                            <xsl:attribute name="href">m_2431.asp?Video=Sections\Assessment\<xsl:value-of select="concat(/DATA/PARAM/@assessmentid,'\',@mediafile)"/></xsl:attribute>
                                                         <xsl:element name="b">
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PlayClip']"/>
                                                         </xsl:element>
                                                         </xsl:element>
                                                   </xsl:if>
                                                </xsl:if>
                                             </xsl:element>
                                          </xsl:element>

                                          <xsl:if test="(@questiontype = 5)">
                                             <xsl:element name="TR">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">5%</xsl:attribute>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">95%</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:element name="TEXTAREA">
                                                      <xsl:attribute name="name"><xsl:value-of select="@assessquestionid"/></xsl:attribute>
                                                      <xsl:attribute name="id"><xsl:value-of select="@assessquestionid"/></xsl:attribute>
                                                      <xsl:attribute name="rows">6</xsl:attribute>
                                                      <xsl:attribute name="cols">35</xsl:attribute>
                                                      <xsl:attribute name="onkeyup"><xsl:text disable-output-escaping="yes"><![CDATA[if (value.length>500) {doMaxLenMsg(500); value=value.substring(0,500);}]]></xsl:text></xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSASSESSANSWERS/PTSASSESSANSWER[@assessquestionid=current()/@assessquestionid]/@answertext"/>
                                                   </xsl:element>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:if>

                                          <xsl:variable name="tmpMultiSelect"><xsl:value-of select="@multiselect"/></xsl:variable>

                                          <xsl:if test="(@questiontype = 3)">
                                             <xsl:element name="TR">
                                                <xsl:for-each select="/DATA/TXN/PTSASSESSCHOICES/PTSASSESSCHOICE[(@assessquestionid = current()/@assessquestionid)]">
                                                      <xsl:element name="TR">
                                                         <xsl:element name="TD">
                                                            <xsl:attribute name="width">5%</xsl:attribute>
                                                         </xsl:element>
                                                         <xsl:element name="TD">
                                                            <xsl:attribute name="width">95%</xsl:attribute>
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
                                                                  </xsl:element>
                                                            </xsl:if>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                            <xsl:value-of select="@choice"/>
                                                         </xsl:element>
                                                      </xsl:element>

                                                </xsl:for-each>
                                             </xsl:element>
                                          </xsl:if>

                                          <xsl:element name="TR">
                                          </xsl:element>
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="colspan">2</xsl:attribute>
                                                <xsl:attribute name="height">12</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>

                                    </xsl:for-each>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">2</xsl:attribute>
                                       <xsl:attribute name="height">6</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:if>

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
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:if test="(/DATA/PARAM/@assessquestionid != 0) and (/DATA/TXN/PTSASSESSQUESTION/@questiontype != 4)">
                                    <xsl:element name="INPUT">
                                       <xsl:attribute name="type">button</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Continue']"/>
                                       </xsl:attribute>
                                       <xsl:attribute name="onclick">doSubmit(2,"")</xsl:attribute>
                                    </xsl:element>
                                 </xsl:if>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:if test="(/DATA/PARAM/@popup = 0)">
                                    <xsl:element name="INPUT">
                                       <xsl:attribute name="type">button</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ReturnMyAssessments']"/>
                                       </xsl:attribute>
                                       <xsl:attribute name="onclick">doSubmit(3,"")</xsl:attribute>
                                    </xsl:element>
                                 </xsl:if>
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
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
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
      <!--END BODY-->

      </xsl:element>

   </xsl:template>
</xsl:stylesheet>