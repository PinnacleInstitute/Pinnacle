<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
   <xsl:include href="HTMLHeading.xsl"/>
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
         <xsl:with-param name="pagename" select="'Mobile System'"/>
         <xsl:with-param name="includecalendar" select="true()"/>
         <xsl:with-param name="htmleditor"></xsl:with-param>
         <xsl:with-param name="viewport">width=device-width</xsl:with-param>
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
         <xsl:attribute name="topmargin">0</xsl:attribute>
         <xsl:attribute name="leftmargin">5</xsl:attribute>
         <xsl:variable name="background">
            <xsl:choose>
               <xsl:when test="string-length(/DATA/PARAM/@pageimage)!=0">
                  <xsl:value-of select="/DATA/PARAM/@pageimage"/>
               </xsl:when>
               <xsl:otherwise>bg7.jpg</xsl:otherwise>
            </xsl:choose>
         </xsl:variable>
         <xsl:attribute name="background">Images/<xsl:value-of select="$background"/></xsl:attribute>
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
               ShowTab('TabDashboard',1);
            ]]></xsl:text>;doErrorMsg('<xsl:value-of select="concat($errmsg, $errmsgfld)"/>')</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[
               ShowTab('TabDashboard',1);
            ]]></xsl:text>;doErrorMsg('<xsl:value-of select="/DATA/ERROR"/>')</xsl:attribute>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
               <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[
               ShowTab('TabDashboard',1);
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
               <xsl:attribute name="name">Business</xsl:attribute>
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
                     <xsl:attribute name="width">0%</xsl:attribute>
                  </xsl:element>
                  <xsl:element name="TD">
                     <xsl:attribute name="width">100%</xsl:attribute>
                  </xsl:element>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ShowTab(tab, shw){ 
          var mid = document.getElementById('MemberID').value;
          var cid = document.getElementById('CompanyID').value;
          var frame, url, frm, src, page, target='', style='', compare=0, load=0;

          switch(tab) {
          case 'TabDashboard':
          frame = 'DashboardFrame';
          switch(shw) {
          case 1: url = 'm_MemberDashboard.asp?memberid=' + mid; load=1; break;
          } break;
          case 'TabProductivity':
          frame = 'ProductivityFrame';
          switch(shw) {
          case 1: url = 'm_11702.asp?companyid=' + cid + '&memberid=' + mid; break;
          case 2: url = 'm_11711.asp?companyid=' + cid + '&memberid=' + mid; break;
          case 3: url = 'm_11710.asp?companyid=' + cid + '&memberid=' + mid; break;
          case 4: url = 'm_11712.asp?companyid=' + cid + '&memberid=' + mid; break;
          case 5: url = 'm_12610.asp?companyid=' + cid + '&memberid=' + mid; break;
          case 6: url = 'm_11721.asp?memberid=' + mid; break;
          case 7: url = '11760.asp?mobile=1&memberid=' + mid; target='ActivityReports'; break;
          } break;
          case 'TabMarketing':
          frame = 'MarketingFrame';
          switch(shw) {
          case 1: url = 'm_8162q.asp?memberid=' + mid; load=1; break;
          case 2: url = 'm_8161.asp?memberid=' + mid; break;
          case 3: url = 'm_1412.asp?pagetype=1'; compare=21; break;
          case 4: url = 'm_1412.asp?pagetype=2'; compare=21; break;
          } break;
          case 'TabTraining':
          frame = 'TrainingFrame';
          switch(shw) {
          case 1: url = 'm_1311.asp?memberid=' + mid + '&companyid=' + cid + '&contentpage=3'; break;
          case 2: url = 'm_3411.asp?memberid=' + mid + '&companyid=' + cid + '&contentpage=3'; break;
          case 3: url = 'm_1212.asp?mode=2&memberid=' + mid + '&companyid=' + cid + '&contentpage=3'; break;
          case 4: url = 'm_9313.asp?pagetype=7&memberid=' + mid + '&companyid=' + cid; break;
          case 5: url = 'm_0410.asp?memberid=' + mid; break;
          } break;
          case 'TabFinancial':
          frame = 'FinancialFrame';
          switch(shw) {
          case 1: url = 'm_1022.asp?memberid=' + mid; break;
          case 2: url = 'm_0408.asp?referralid=' + mid; break;
          case 3: url = 'm_10400.asp?memberid=' + mid; break;
          } break;

          case 'TabAccount':
          frame = 'AccountFrame';
          switch(shw) {
          case 1: url = 'm_0463.asp?memberid=' + mid; break;
          case 2: url = 'm_0436.asp?memberid=' + mid; break;
          case 3: url = 'm_0103.asp?contentpage=3&popup=-1'; break;
          case 4: url = 'm_0106.asp?contentpage=3&popup=-1'; break;
          case 7: url = '0107.asp'; load=1; break;
          } break;
          case 'TabHelp':
          frame = 'HelpFrame';
          switch(shw) {
          case 1: url = 'm_1713.asp?companyid=' + cid; break;
          case 2: url = 'm_8013.asp?companyid=' + cid; break;
          case 3: url = 'm_9506.asp?companyid=' + cid; break;
          case 4: url = 'MemberHome.asp?memberid=' + mid; target='MemberHome'; break;
          } break;
          }
          if( target.length > 0 ) {
          win = window.open(url,target,style);
          win.focus();
          }
          else {
          if( tab == 'Home' ) { ShowFrame(tab) }

          frm = document.getElementById(frame);
          src = frm.src;
          if( compare == 0 ) { compare = url.indexOf('.') }
          page = url.substring(0,compare);
          if (load == 1 || src.indexOf(page) < 0 ) {frm.src = url} else {ShowFrame(tab)}
          }
         }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ShowFrame(tab){ 
          document.getElementById('TabDashboard').style.display = 'none';
          document.getElementById('TabProductivity').style.display = 'none';
          document.getElementById('TabMarketing').style.display = 'none';
          document.getElementById('TabTraining').style.display = 'none';
          document.getElementById('TabFinancial').style.display = 'none';
          document.getElementById('TabHelp').style.display = 'none';
          document.getElementById('TabAccount').style.display = 'none';
          document.getElementById(tab).style.display = '';
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
                     <xsl:attribute name="width">0%</xsl:attribute>
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
                              <xsl:attribute name="width">100%</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">MemberID</xsl:attribute>
                              <xsl:attribute name="id">MemberID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@memberid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">CompanyID</xsl:attribute>
                              <xsl:attribute name="id">CompanyID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@companyid"/></xsl:attribute>
                           </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IMG">
                                 <xsl:attribute name="src">Images/<xsl:value-of select="/DATA/PARAM/@header"/></xsl:attribute>
                                 <xsl:attribute name="border">0</xsl:attribute>
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
                           <xsl:attribute name="height">36</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="bgcolor"><xsl:value-of select="/DATA/PARAM/@menubehindcolor"/></xsl:attribute>
                              <xsl:attribute name="background">Imagesb/<xsl:value-of select="/DATA/PARAM/@menubehindimage"/></xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">top</xsl:attribute>
<xsl:element name="SCRIPT">
   <xsl:attribute name="language">JavaScript</xsl:attribute>
   var MemberMenu = new CMenu(MemberMenuDef, 'MemberMenu'); MemberMenu.create();
</xsl:element>

                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:attribute name="id">TabDashboard</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IFRAME">
                                 <xsl:attribute name="src"></xsl:attribute>
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="height">700</xsl:attribute>
                                 <xsl:attribute name="frmheight">700</xsl:attribute>
                                 <xsl:attribute name="id">DashboardFrame</xsl:attribute>
                                 <xsl:attribute name="name">DashboardFrame</xsl:attribute>
                                 <xsl:attribute name="class">FrameNoScroll</xsl:attribute>
                                 <xsl:attribute name="frameborder">0</xsl:attribute>
                                 <xsl:attribute name="onload">ShowFrame('TabDashboard')</xsl:attribute>
                                 <xsl:element name="A">
                                    <xsl:attribute name="href"></xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoFrameSupport']"/>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:attribute name="id">TabProductivity</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IFRAME">
                                 <xsl:attribute name="src"></xsl:attribute>
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="height">700</xsl:attribute>
                                 <xsl:attribute name="frmheight">700</xsl:attribute>
                                 <xsl:attribute name="id">ProductivityFrame</xsl:attribute>
                                 <xsl:attribute name="name">ProductivityFrame</xsl:attribute>
                                 <xsl:attribute name="class">FrameNoScroll</xsl:attribute>
                                 <xsl:attribute name="frameborder">0</xsl:attribute>
                                 <xsl:attribute name="onload">ShowFrame('TabProductivity')</xsl:attribute>
                                 <xsl:element name="A">
                                    <xsl:attribute name="href"></xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoFrameSupport']"/>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:attribute name="id">TabMarketing</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IFRAME">
                                 <xsl:attribute name="src"></xsl:attribute>
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="height">700</xsl:attribute>
                                 <xsl:attribute name="frmheight">700</xsl:attribute>
                                 <xsl:attribute name="id">MarketingFrame</xsl:attribute>
                                 <xsl:attribute name="name">MarketingFrame</xsl:attribute>
                                 <xsl:attribute name="class">FrameNoScroll</xsl:attribute>
                                 <xsl:attribute name="frameborder">0</xsl:attribute>
                                 <xsl:attribute name="onload">ShowFrame('TabMarketing')</xsl:attribute>
                                 <xsl:element name="A">
                                    <xsl:attribute name="href"></xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoFrameSupport']"/>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:attribute name="id">TabTraining</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IFRAME">
                                 <xsl:attribute name="src"></xsl:attribute>
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="height">700</xsl:attribute>
                                 <xsl:attribute name="frmheight">700</xsl:attribute>
                                 <xsl:attribute name="id">TrainingFrame</xsl:attribute>
                                 <xsl:attribute name="name">TrainingFrame</xsl:attribute>
                                 <xsl:attribute name="class">FrameNoScroll</xsl:attribute>
                                 <xsl:attribute name="frameborder">0</xsl:attribute>
                                 <xsl:attribute name="onload">ShowFrame('TabTraining')</xsl:attribute>
                                 <xsl:element name="A">
                                    <xsl:attribute name="href"></xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoFrameSupport']"/>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:attribute name="id">TabFinancial</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IFRAME">
                                 <xsl:attribute name="src"></xsl:attribute>
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="height">700</xsl:attribute>
                                 <xsl:attribute name="frmheight">700</xsl:attribute>
                                 <xsl:attribute name="id">FinancialFrame</xsl:attribute>
                                 <xsl:attribute name="name">FinancialFrame</xsl:attribute>
                                 <xsl:attribute name="class">FrameNoScroll</xsl:attribute>
                                 <xsl:attribute name="frameborder">0</xsl:attribute>
                                 <xsl:attribute name="onload">ShowFrame('TabFinancial')</xsl:attribute>
                                 <xsl:element name="A">
                                    <xsl:attribute name="href"></xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoFrameSupport']"/>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:attribute name="id">TabHelp</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IFRAME">
                                 <xsl:attribute name="src"></xsl:attribute>
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="height">700</xsl:attribute>
                                 <xsl:attribute name="frmheight">700</xsl:attribute>
                                 <xsl:attribute name="id">HelpFrame</xsl:attribute>
                                 <xsl:attribute name="name">HelpFrame</xsl:attribute>
                                 <xsl:attribute name="class">FrameNoScroll</xsl:attribute>
                                 <xsl:attribute name="frameborder">0</xsl:attribute>
                                 <xsl:attribute name="onload">ShowFrame('TabHelp')</xsl:attribute>
                                 <xsl:element name="A">
                                    <xsl:attribute name="href"></xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoFrameSupport']"/>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:attribute name="id">TabAccount</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IFRAME">
                                 <xsl:attribute name="src"></xsl:attribute>
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="height">700</xsl:attribute>
                                 <xsl:attribute name="frmheight">700</xsl:attribute>
                                 <xsl:attribute name="id">AccountFrame</xsl:attribute>
                                 <xsl:attribute name="name">AccountFrame</xsl:attribute>
                                 <xsl:attribute name="class">FrameNoScroll</xsl:attribute>
                                 <xsl:attribute name="frameborder">0</xsl:attribute>
                                 <xsl:attribute name="onload">ShowFrame('TabAccount')</xsl:attribute>
                                 <xsl:element name="A">
                                    <xsl:attribute name="href"></xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoFrameSupport']"/>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="div">
                                 <xsl:attribute name="id">google_translate_element</xsl:attribute>
                                 <xsl:text> </xsl:text>
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

<xsl:element name="SCRIPT">
   <xsl:attribute name="language">JavaScript</xsl:attribute>
   <xsl:text disable-output-escaping="yes"><![CDATA[
   MemberMenu.run();
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
      <!--END BODY-->

      </xsl:element>

   </xsl:template>
</xsl:stylesheet>