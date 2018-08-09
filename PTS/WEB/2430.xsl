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
         <xsl:with-param name="pagename" select="'My Lesson'"/>
         <xsl:with-param name="includecalendar" select="true()"/>
         <xsl:with-param name="htmleditor"></xsl:with-param>
         <xsl:with-param name="translate">google</xsl:with-param>
      </xsl:call-template>

      <xsl:element name="SCRIPT">
         <xsl:attribute name="language">JavaScript</xsl:attribute>
         <xsl:attribute name="src">Include/swfobject.js</xsl:attribute>
         <xsl:text> </xsl:text>
      </xsl:element>

      <xsl:element name="SCRIPT">
         <xsl:attribute name="language">JavaScript</xsl:attribute>
         <xsl:attribute name="src">Include/scorm.js</xsl:attribute>
         <xsl:text> </xsl:text>
      </xsl:element>

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
      <xsl:element name="DIV">
         <xsl:attribute name="id">wrapper750b</xsl:attribute>
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
               <xsl:attribute name="name">Lesson</xsl:attribute>
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

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function TestScorm(){    
               var api = window.API;
            if ( api == null )
               alert("NO API");
            else {   
               alert("Init: " + api.LMSInitialize('') );

               alert("Get StudentID: " + api.LMSGetValue('cmi.core.student_id') );
               alert("Get StudentName: " + api.LMSGetValue('cmi.core.student_name') );
               alert("Get Location: " + api.LMSGetValue('cmi.core.lesson_location') );
               alert("Get Lesson Status: " + api.LMSGetValue('cmi.core.lesson_status') );
               alert("Get Score Raw: " + api.LMSGetValue('cmi.core.score_raw') );
               alert("Get Total Time: " + api.LMSGetValue('cmi.core.total_time') );

               alert("Commit: " + api.LMSCommit('') );
               alert("Finish: " + api.LMSFinish('') );
            }   
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

                        <xsl:if test="(/DATA/TXN/PTSLESSON/@content = 1) and (/DATA/TXN/PTSLESSON/@mediatype = 0)">
                           <xsl:element name="SCRIPT">
                              <xsl:attribute name="language">JavaScript</xsl:attribute>
                              <xsl:text disable-output-escaping="yes"><![CDATA[ function UpdateTimer(){   }]]></xsl:text>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/TXN/PTSLESSON/@content != 1) or (/DATA/TXN/PTSLESSON/@mediatype != 0)">
                           <xsl:element name="SCRIPT">
                              <xsl:attribute name="language">JavaScript</xsl:attribute>
                              <xsl:text disable-output-escaping="yes"><![CDATA[ function UpdateTimer(){    
                  setTimeout("UpdateTimer()", 1000);
                  var secs = parseInt(document.getElementById('Seconds').value);
                  var length = parseInt(document.getElementById('LessonLength').value);
                  secs = secs + 1;
                  if( length > 6  ) {length = 180};
                  if( length <= 1 ) {length = 30};
                  if( length <= 6 ) {length = (length * 60) / 2};
                  document.getElementById('Seconds').value = secs;
                  if( secs == length)
                  {
                     var Complete = document.getElementById('Complete') 
                     if(Complete)
                        Complete.checked = 1;
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
                  document.getElementById('Timer').value = fmt;
                }]]></xsl:text>
                           </xsl:element>

                        </xsl:if>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">ScormStudentID</xsl:attribute>
                              <xsl:attribute name="id">ScormStudentID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@scormstudentid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">ScormStudentName</xsl:attribute>
                              <xsl:attribute name="id">ScormStudentName</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@scormstudentname"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">ScormLessonLocation</xsl:attribute>
                              <xsl:attribute name="id">ScormLessonLocation</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@scormlessonlocation"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">ScormLessonStatus</xsl:attribute>
                              <xsl:attribute name="id">ScormLessonStatus</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@scormlessonstatus"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">ScormScoreRaw</xsl:attribute>
                              <xsl:attribute name="id">ScormScoreRaw</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@scormscoreraw"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">ScormTotalTime</xsl:attribute>
                              <xsl:attribute name="id">ScormTotalTime</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@scormtotaltime"/></xsl:attribute>
                           </xsl:element>

                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Seconds</xsl:attribute>
                              <xsl:attribute name="id">Seconds</xsl:attribute>
                              <xsl:attribute name="value">0</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">MediaWidth</xsl:attribute>
                              <xsl:attribute name="id">MediaWidth</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSLESSON/@mediawidth"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">MediaHeight</xsl:attribute>
                              <xsl:attribute name="id">MediaHeight</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSLESSON/@mediaheight"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">LessonLength</xsl:attribute>
                              <xsl:attribute name="id">LessonLength</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSSESSIONLESSON/@lessonlength"/></xsl:attribute>
                           </xsl:element>

                        <xsl:if test="(/DATA/TXN/PTSLESSON/@content != 1) or (/DATA/TXN/PTSLESSON/@mediatype != 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">750</xsl:attribute>

                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">350</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                          <xsl:if test="(/DATA/PARAM/@sessionid != 0)">
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/notessm.gif</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="onclick">w=window.open(this.href,"Notes","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                   <xsl:attribute name="href">9005.asp?OwnerType=13&amp;OwnerID=<xsl:value-of select="/DATA/PARAM/@sessionid"/>&amp;Title=<xsl:value-of select="/DATA/TXN/PTSLESSON/@coursename"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ShowNotes']"/>
                                                </xsl:element>
                                          </xsl:if>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">400</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:if test="(not(contains(/DATA/TXN/PTSLESSON/@coursename, ':-')))">
                                             <xsl:element name="INPUT">
                                                <xsl:attribute name="type">text</xsl:attribute>
                                                <xsl:attribute name="name">Timer</xsl:attribute>
                                                <xsl:attribute name="id">Timer</xsl:attribute>
                                                <xsl:attribute name="value">00:00:00</xsl:attribute>
                                                <xsl:attribute name="style">BORDER:none; COLOR:black; BACKGROUND:#ffffff; TEXT-ALIGN:right;</xsl:attribute>
                                                <xsl:attribute name="DISABLED"/>
                                             </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(contains(/DATA/TXN/PTSLESSON/@coursename, ':-'))">
                                             <xsl:element name="INPUT">
                                                <xsl:attribute name="type">text</xsl:attribute>
                                                <xsl:attribute name="name">Timer</xsl:attribute>
                                                <xsl:attribute name="id">Timer</xsl:attribute>
                                                <xsl:attribute name="value">00:00:00</xsl:attribute>
                                                <xsl:attribute name="style">BORDER:none; COLOR:white; BACKGROUND:#ffffff; TEXT-ALIGN:right;</xsl:attribute>
                                             </xsl:element>
                                             </xsl:if>
                                       </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">750</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeading</xsl:attribute>
                              <xsl:value-of select="/DATA/TXN/PTSLESSON/@coursename"/>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">750</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeading</xsl:attribute>
                              <xsl:value-of select="/DATA/TXN/PTSLESSON/@lessonname"/>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(count(/DATA/TXN/TEXTOPTIONS/TEXTOPTION) &gt; 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='URLOption']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="SELECT">
                                    <xsl:attribute name="name">URLOption</xsl:attribute>
                                    <xsl:attribute name="id">URLOption</xsl:attribute>
                                    <xsl:attribute name="onchange"><xsl:text disable-output-escaping="yes"><![CDATA[doSubmit(0,"")]]></xsl:text></xsl:attribute>
                                    <xsl:variable name="tmp"><xsl:value-of select="/DATA/PARAM/@urloption"/></xsl:variable>
                                    <xsl:for-each select="/DATA/TXN/TEXTOPTIONS/TEXTOPTION">
                                       <xsl:element name="OPTION">
                                          <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                          <xsl:if test="$tmp=@id"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:value-of select="@name"/>
                                       </xsl:element>
                                    </xsl:for-each>
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
                        <xsl:if test="(/DATA/TXN/PTSLESSON/@content = 2) or (/DATA/TXN/PTSLESSON/@content = 4)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
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
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/TXN/PTSHTMLFILE/DATA/comment()" disable-output-escaping="yes"/>
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
                                 <xsl:attribute name="width">750</xsl:attribute>
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

                        </xsl:if>
                        <xsl:if test="(/DATA/TXN/PTSLESSON/@mediatype = 3) and (/DATA/TXN/PTSLESSON/@mediaurl != '')">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="IFRAME">
                                    <xsl:attribute name="src"><xsl:value-of select="/DATA/TXN/PTSLESSON/@mediaurl"/></xsl:attribute>
                                    <xsl:attribute name="width"><xsl:value-of select="/DATA/TXN/PTSLESSON/@mediawidth"/></xsl:attribute>
                                    <xsl:attribute name="height"><xsl:value-of select="/DATA/TXN/PTSLESSON/@mediaheight"/></xsl:attribute>
                                    <xsl:attribute name="frmheight"><xsl:value-of select="/DATA/TXN/PTSLESSON/@mediaheight"/></xsl:attribute>
                                    <xsl:element name="A">
                                       <xsl:attribute name="href"><xsl:value-of select="/DATA/TXN/PTSLESSON/@mediaurl"/></xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoFrameSupport']"/>
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
                        <xsl:if test="(/DATA/TXN/PTSLESSON/@mediatype &gt; 0) and (/DATA/TXN/PTSLESSON/@mediatype &lt; 3) and (/DATA/TXN/PTSLESSON/@mediaurl != '')">
                           <xsl:if test="(/DATA/PARAM/@player = 0)">
                              <xsl:if test="(/DATA/TXN/PTSLESSON/@mediatype = 1)">
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">750</xsl:attribute>
                                       <xsl:attribute name="align">center</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="VIDEO">
                                          <xsl:attribute name="controls">controls</xsl:attribute>
                                          <xsl:attribute name="autoplay">autoplay</xsl:attribute>
                                          <xsl:attribute name="width"><xsl:value-of select="/DATA/TXN/PTSLESSON/@mediawidth"/></xsl:attribute>
                                          <xsl:attribute name="height"><xsl:value-of select="/DATA/TXN/PTSLESSON/@mediaheight"/></xsl:attribute>
                                          <xsl:element name="SOURCE">
                                             <xsl:attribute name="type">video/mp4</xsl:attribute>
                                             <xsl:attribute name="src">
                                                <xsl:value-of select="/DATA/TXN/PTSLESSON/@mediaurl"/>
                                             </xsl:attribute>
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
                                       <xsl:attribute name="width">750</xsl:attribute>
                                       <xsl:attribute name="align">center</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:attribute name="class">prompt</xsl:attribute>
                                       <xsl:element name="A">
                                          <xsl:attribute name="href"><xsl:value-of select="/DATA/TXN/PTSLESSON/@mediaurl"/></xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PlayVideo']"/>
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
                              <xsl:if test="(/DATA/TXN/PTSLESSON/@mediatype = 2)">
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">750</xsl:attribute>
                                       <xsl:attribute name="align">center</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="AUDIO">
                                          <xsl:attribute name="controls">controls</xsl:attribute>
                                          <xsl:attribute name="autoplay">autoplay</xsl:attribute>
                                          <xsl:element name="SOURCE">
                                             <xsl:attribute name="type">audio/mpeg</xsl:attribute>
                                             <xsl:attribute name="src">
                                                <xsl:value-of select="/DATA/TXN/PTSLESSON/@mediaurl"/>
                                             </xsl:attribute>
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
                                       <xsl:attribute name="width">750</xsl:attribute>
                                       <xsl:attribute name="align">center</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:attribute name="class">prompt</xsl:attribute>
                                       <xsl:element name="A">
                                          <xsl:attribute name="href"><xsl:value-of select="/DATA/TXN/PTSLESSON/@mediaurl"/></xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PlayAudio']"/>
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
                           <xsl:if test="(/DATA/PARAM/@player = 1)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">750</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="EMBED">
                                       <xsl:attribute name="src"><xsl:value-of select="/DATA/TXN/PTSLESSON/@mediaurl"/></xsl:attribute>
                                       <xsl:attribute name="type">audio/x-pn-realaudio-plugin</xsl:attribute>
                                       <xsl:attribute name="width"><xsl:value-of select="/DATA/TXN/PTSLESSON/@mediawidth"/></xsl:attribute>
                                       <xsl:attribute name="height"><xsl:value-of select="/DATA/TXN/PTSLESSON/@mediaheight"/></xsl:attribute>
                                       <xsl:attribute name="controls">ImageWindow</xsl:attribute>
                                       <xsl:attribute name="autostart">false</xsl:attribute>
                                       <xsl:attribute name="console">Clip1</xsl:attribute>
                                       <xsl:attribute name="pluginspace">http://www.real.com/player/index.html?src=404</xsl:attribute>
                                    </xsl:element>
                                    <xsl:element name="BR"/>
                                    <xsl:element name="EMBED">
                                       <xsl:attribute name="src"><xsl:value-of select="/DATA/TXN/PTSLESSON/@mediaurl"/></xsl:attribute>
                                       <xsl:attribute name="type">audio/x-pn-realaudio-plugin</xsl:attribute>
                                       <xsl:attribute name="width"><xsl:value-of select="/DATA/TXN/PTSLESSON/@mediawidth"/></xsl:attribute>
                                       <xsl:attribute name="height">30</xsl:attribute>
                                       <xsl:attribute name="controls">StatusBar</xsl:attribute>
                                       <xsl:attribute name="autostart">false</xsl:attribute>
                                       <xsl:attribute name="console">Clip1</xsl:attribute>
                                       <xsl:attribute name="pluginspace">http://www.real.com/player/index.html?src=404</xsl:attribute>
                                    </xsl:element>
                                    <xsl:element name="BR"/>
                                    <xsl:element name="EMBED">
                                       <xsl:attribute name="src"><xsl:value-of select="/DATA/TXN/PTSLESSON/@mediaurl"/></xsl:attribute>
                                       <xsl:attribute name="type">audio/x-pn-realaudio-plugin</xsl:attribute>
                                       <xsl:attribute name="width"><xsl:value-of select="/DATA/TXN/PTSLESSON/@mediawidth"/></xsl:attribute>
                                       <xsl:attribute name="height">30</xsl:attribute>
                                       <xsl:attribute name="controls">ControlPanel</xsl:attribute>
                                       <xsl:attribute name="autostart">true</xsl:attribute>
                                       <xsl:attribute name="console">Clip1</xsl:attribute>
                                       <xsl:attribute name="pluginspace">http://www.real.com/player/index.html?src=404</xsl:attribute>
                                    </xsl:element>
                                    <xsl:element name="BR"/>
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
                                    <xsl:attribute name="width">750</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">bottom</xsl:attribute>
                                    <xsl:attribute name="class">prompt</xsl:attribute>
                                    <xsl:element name="A">
                                       <xsl:attribute name="onclick">w=window.open(this.href,"_Player","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                       <xsl:attribute name="href">http://www.real.com</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='RealDownloadText']"/>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">1</xsl:attribute>
                                    <xsl:attribute name="height">6</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:if test="(/DATA/TXN/PTSLESSON/@mediatype = 1)">
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">750</xsl:attribute>
                                       <xsl:attribute name="align">center</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:attribute name="class">prompt</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewRealPlayer']"/>
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
                           <xsl:if test="(/DATA/PARAM/@player = 2)">
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
                                    <script type="text/javascript">
                                       var flashvars = {videoURL: "<xsl:value-of select="/DATA/TXN/PTSLESSON/@mediaurl"/>"};
                                       var params = {allowfullscreen: "true", wmode: "transparent"};
                                       var attributes = {};
                                       swfobject.embedSWF("PinnaclePlayer.swf", "FlashContent", "480", "320", "9.0.0", false, flashvars, params, attributes);
                                    </script>
                                    <div id="FlashContent">
                                       <xsl:element name="A">
                                          <xsl:attribute name="onclick">w=window.open(this.href,"_Player","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                          <xsl:attribute name="href">http://www.adobe.com/go/getflashplayer</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LoadFlashPlayer']"/>
                                       </xsl:element>
                                    </div>
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
                        <xsl:if test="(/DATA/TXN/PTSLESSON/@content = 3) or (/DATA/TXN/PTSLESSON/@content = 4)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
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
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/TXN/PTSHTMLFILE/DATA/comment()" disable-output-escaping="yes"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/PARAM/@attachmentcount &gt; 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Attachments']"/>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="height">1</xsl:attribute>
                                 <xsl:attribute name="bgcolor">#004080</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:for-each select="/DATA/TXN/PTSATTACHMENTS/PTSATTACHMENT">
                                 <xsl:element name="TR">
                                    <xsl:attribute name="height">24</xsl:attribute>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">750</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="b">
                                             <xsl:if test="(@islink != 0)">
                                                <xsl:element name="A">
                                                   <xsl:attribute name="onclick">w=window.open(this.href,"blank","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                   <xsl:attribute name="href"><xsl:value-of select="@filename"/></xsl:attribute>
                                                <xsl:value-of select="@attachname"/>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(@islink = 0)">
                                                <xsl:element name="A">
                                                   <xsl:attribute name="onclick">w=window.open(this.href,"blank","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                   <xsl:attribute name="href">Attachments/23/<xsl:value-of select="concat(/DATA/PARAM/@lessonid,'/',@filename)"/></xsl:attribute>
                                                <xsl:value-of select="@attachname"/>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:if test="(@islink != 0)">
                                                <xsl:element name="A">
                                                   <xsl:attribute name="onclick">w=window.open(this.href,"blank","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                   <xsl:attribute name="href"><xsl:value-of select="@filename"/></xsl:attribute>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/Preview.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(@islink = 0)">
                                                <xsl:element name="A">
                                                   <xsl:attribute name="onclick">w=window.open(this.href,"blank","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                   <xsl:attribute name="href">Attachments/23/<xsl:value-of select="concat(/DATA/PARAM/@lessonid,'/',@filename)"/></xsl:attribute>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/Preview.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                             </xsl:if>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="font">
                                             <xsl:attribute name="color">gray</xsl:attribute>
                                          <xsl:value-of select="@description"/>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:if test="(@islink = 0)">
                                             <xsl:element name="font">
                                                <xsl:attribute name="color">purple</xsl:attribute>
                                             <xsl:value-of select="@filename"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:element name="font">
                                                <xsl:attribute name="color">purple</xsl:attribute>
                                             <xsl:value-of select="concat('(',@attachsize,'KB ',@attachdate,')')"/>
                                             </xsl:element>
                                       </xsl:if>
                                       <xsl:if test="(@islink != 0)">
                                             <xsl:if test="(@attachdate != '')">
                                                <xsl:element name="font">
                                                   <xsl:attribute name="color">purple</xsl:attribute>
                                                <xsl:value-of select="concat('(',@attachdate,')')"/>
                                                </xsl:element>
                                             </xsl:if>
                                       </xsl:if>
                                       <xsl:if test="(@secure &gt; 0)">
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:element name="font">
                                                <xsl:attribute name="color">red</xsl:attribute>
                                             <xsl:value-of select="concat('(',@secure,')')"/>
                                             </xsl:element>
                                       </xsl:if>
                                    </xsl:element>
                                 </xsl:element>

                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">1</xsl:attribute>
                                       <xsl:attribute name="height">2</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">750</xsl:attribute>
                                       <xsl:attribute name="height">1</xsl:attribute>
                                       <xsl:attribute name="bgcolor">#C0C0FF</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">1</xsl:attribute>
                                       <xsl:attribute name="height">2</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>

                           </xsl:for-each>
                        </xsl:if>
                        <xsl:if test="(count(/DATA/TXN/PTSHOMEWORKS/PTSHOMEWORK) &gt; 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Homework']"/>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">prompt</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='HomeworkText']"/>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">3</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
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

                           <xsl:for-each select="/DATA/TXN/PTSHOMEWORKS/PTSHOMEWORK">
                                 <xsl:element name="TR">
                                    <xsl:attribute name="height">24</xsl:attribute>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">750</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="b">
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/Homework.gif</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                          <xsl:value-of select="@name"/>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                          <xsl:element name="font">
                                             <xsl:attribute name="color">purple</xsl:attribute>
                                          (<xsl:value-of select="@weight"/>%)
                                          </xsl:element>
                                       <xsl:if test="(@score != 0)">
                                             <xsl:element name="font">
                                                <xsl:attribute name="color">blue</xsl:attribute>
                                             (<xsl:value-of select="@score"/>)
                                             </xsl:element>
                                       </xsl:if>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:if test="(@attachmentid != 0)">
                                             <xsl:element name="A">
                                                <xsl:attribute name="href">8003.asp?AttachmentID=<xsl:value-of select="@attachmentid"/>&amp;Mini=2&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/edit.gif</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EditHomework']"/></xsl:attribute>
                                                   <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EditHomework']"/></xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>
                                       </xsl:if>
                                       <xsl:if test="(@attachmentid = 0)">
                                          <xsl:if test="(@isgrade = 0)">
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">8002.asp?ParentID=<xsl:value-of select="/DATA/PARAM/@sessionlessonid"/>&amp;ParentType=24&amp;RefID=<xsl:value-of select="@homeworkid"/>&amp;Name=<xsl:value-of select="@name"/>&amp;Mini=2&amp;Score=100&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/upload.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                      <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AddHomework']"/></xsl:attribute>
                                                      <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AddHomework']"/></xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(@isgrade != 0)">
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">8002.asp?ParentID=<xsl:value-of select="/DATA/PARAM/@sessionlessonid"/>&amp;ParentType=24&amp;RefID=<xsl:value-of select="@homeworkid"/>&amp;Name=<xsl:value-of select="@name"/>&amp;Mini=2&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/upload.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                      <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AddHomework']"/></xsl:attribute>
                                                      <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AddHomework']"/></xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                          </xsl:if>
                                       </xsl:if>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>

                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">750</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:value-of select="DESCRIPTION/comment()" disable-output-escaping="yes"/>
                                    </xsl:element>
                                 </xsl:element>

                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">1</xsl:attribute>
                                       <xsl:attribute name="height">3</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">750</xsl:attribute>
                                       <xsl:attribute name="height">1</xsl:attribute>
                                       <xsl:attribute name="bgcolor">#C0C0FF</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">1</xsl:attribute>
                                       <xsl:attribute name="height">6</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>

                           </xsl:for-each>
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

                        <xsl:if test="(/DATA/PARAM/@popup &lt; 2)">
                           <xsl:if test="(/DATA/TXN/PTSLESSON/@content != 1) or (/DATA/TXN/PTSLESSON/@mediatype != 0)">
                              <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23) or (/DATA/SYSTEM/@usergroup = 41)">
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
                                       <xsl:attribute name="type">checkbox</xsl:attribute>
                                       <xsl:attribute name="name">Complete</xsl:attribute>
                                       <xsl:attribute name="id">Complete</xsl:attribute>
                                       <xsl:if test="/DATA/PARAM/@complete='on'">
                                          <xsl:attribute name="CHECKED"/>
                                       </xsl:if>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MarkComplete']"/>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">1</xsl:attribute>
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
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:if test="(/DATA/TXN/PTSLESSON/@quiz &gt; 1) and (/DATA/TXN/PTSSESSIONLESSON/@status &lt; 3)">
                                    <xsl:element name="INPUT">
                                       <xsl:attribute name="type">button</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TakeQuiz']"/>
                                       </xsl:attribute>
                                       <xsl:attribute name="onclick">doSubmit(1,"")</xsl:attribute>
                                    </xsl:element>
                                 </xsl:if>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:if test="(/DATA/TXN/PTSLESSON/@quiz &gt; 1) and (/DATA/PARAM/@sessionid = 0)">
                                    <xsl:element name="INPUT">
                                       <xsl:attribute name="type">button</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TakeQuiz']"/>
                                       </xsl:attribute>
                                       <xsl:attribute name="onclick">doSubmit(1,"")</xsl:attribute>
                                    </xsl:element>
                                 </xsl:if>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:if test="(/DATA/TXN/PTSLESSON/@quiz &gt; 1) and (/DATA/TXN/PTSSESSIONLESSON/@status &gt; 2)">
                                    <xsl:element name="INPUT">
                                       <xsl:attribute name="type">button</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ReviewQuiz']"/>
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
                                 <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 31) or (/DATA/SYSTEM/@usergroup &lt;= 23) or (/DATA/SYSTEM/@usergroup = 51) or (/DATA/SYSTEM/@usergroup = 52)">
                                    <xsl:element name="INPUT">
                                       <xsl:attribute name="type">button</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ReturnLesson']"/>
                                       </xsl:attribute>
                                       <xsl:attribute name="onclick">doSubmit(8,"")</xsl:attribute>
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
                        <xsl:if test="(/DATA/PARAM/@popup = 2)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:if test="(/DATA/TXN/PTSLESSON/@quiz &gt; 1) and (/DATA/TXN/PTSSESSIONLESSON/@status &lt; 3)">
                                    <xsl:element name="INPUT">
                                       <xsl:attribute name="type">button</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TakeQuiz']"/>
                                       </xsl:attribute>
                                       <xsl:attribute name="onclick">doSubmit(1,"")</xsl:attribute>
                                    </xsl:element>
                                 </xsl:if>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:if test="(/DATA/TXN/PTSLESSON/@quiz &gt; 1) and (/DATA/PARAM/@sessionid = 0)">
                                    <xsl:element name="INPUT">
                                       <xsl:attribute name="type">button</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TakeQuiz']"/>
                                       </xsl:attribute>
                                       <xsl:attribute name="onclick">doSubmit(1,"")</xsl:attribute>
                                    </xsl:element>
                                 </xsl:if>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:if test="(/DATA/TXN/PTSLESSON/@quiz &gt; 1) and (/DATA/TXN/PTSSESSIONLESSON/@status &gt; 2)">
                                    <xsl:element name="INPUT">
                                       <xsl:attribute name="type">button</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ReviewQuiz']"/>
                                       </xsl:attribute>
                                       <xsl:attribute name="onclick">doSubmit(5,"")</xsl:attribute>
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