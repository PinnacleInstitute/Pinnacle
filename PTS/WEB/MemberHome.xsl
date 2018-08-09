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
         <xsl:with-param name="pagename" select="'Member System'"/>
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
         <xsl:attribute name="topmargin">0</xsl:attribute>
         <xsl:attribute name="leftmargin">10</xsl:attribute>
         <xsl:attribute name="bgcolor">#777777</xsl:attribute>
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
      <xsl:element name="DIV">
         <xsl:attribute name="id">wrapper1000</xsl:attribute>
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
                     <xsl:attribute name="width">0</xsl:attribute>
                  </xsl:element>
                  <xsl:element name="TD">
                     <xsl:attribute name="width">1000</xsl:attribute>
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
          case 1: url = 'MemberDashboard.asp?memberid=' + mid; load=1; break;
          case 2: url = 'MobileHome.asp?m=' + mid; target='Mobile'; style='top=100,left=100,height=492,width=322,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no'; break;
          } break;
          case 'TabMarketing':
          frame = 'MarketingFrame';
          switch(shw) {
          case 1: url = '8161.asp?memberid=' + mid; break;
          case 2: url = '8101.asp?memberid=' + mid + '&companyid=' + cid + '&contentpage=3'; break;
                  case 3: url = '8151.asp?memberid=' + mid + '&companyid=' + cid + '&contentpage=3'; break;
                  case 4: url = '1412.asp?pagetype=1&contentpage=3&popup=-1&companyid=' + cid + '&memberid=' + mid; compare=19; break;
                  case 5: url = '1412.asp?pagetype=2&contentpage=3&popup=-1&companyid=' + cid + '&memberid=' + mid; compare=19; break;
                  case 6: url = '12410.asp?entity=22&companyid=' + cid + '&memberid=' + mid; compare=19; break;
                  case 7: url = '12410.asp?entity=81&companyid=' + cid + '&memberid=' + mid; compare=19; break;
                  case 8: url = '12410.asp?entity=-81&companyid=' + cid + '&memberid=' + mid; compare=19; break;
            case 9: url = '12911.asp?memberid=' + mid; break;
            case 10: url = '15612.asp?companyid=' + cid + '&memberid=' + mid; break;
          } break;
          case 'TabProductivity':
          frame = 'ProductivityFrame';
          switch(shw) {
          case 1: url = '11711.asp?memberid=' + mid; break;
          case 2: url = '12610.asp?companyid=' + cid + '&memberid=' + mid; break;
                  case 3: url = '0445.asp?memberid=' + mid; target='performance'; style='top=100,left=100,height=350,width=400,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no'; break;
                  case 4: url = '7001.asp?memberid=' + mid + '&contentpage=3&popup=-1'; break;
                  case 5: url = 'Calendar.asp?memberid=' + mid + '&contentpage=3&popup=-1'; break;
                  case 6: url = '2511.asp?memberid=' + mid + '&contentpage=3&popup=-1'; break;
                  case 7: url = '7501.asp?memberid=' + mid + '&companyid=' + cid + '&contentpage=3&popup=-1'; break;
            case 8: url = '11760.asp?memberid=' + mid; target='ActivityReports'; break;
            case 9: url = '11721.asp?memberid=' + mid; break;
            case 10: url = '11712.asp?memberid=' + mid; break;
            case 99: url = '11702.asp?memberid=' + mid; load=1; break;
          } break;
          case 'TabLeadership':
          frame = 'LeadershipFrame';
          switch(shw) {
          case 1: url = '0410.asp?memberid=' + mid + '&contentpage=3&popup=-1'; break;
                  case 2: url = '1813.asp?memberid=' + mid + '&companyid=' + cid + '&contentpage=3&popup=-1'; break;
                  case 3: url = '0470.asp?memberid=' + mid; target='genealogy'; break;
                  case 4: url = '11710.asp?companyid=' + cid + '&memberid=' + mid; break;
               } break;
               case 'TabTraining':
                  frame = 'TrainingFrame';
                  switch(shw) {
                  case 1: url = '1311.asp?memberid=' + mid + '&companyid=' + cid + '&contentpage=3'; break;
                  case 2: url = '3411.asp?memberid=' + mid + '&companyid=' + cid + '&contentpage=3'; break;
                  case 3: url = '1212.asp?mode=2&memberid=' + mid + '&companyid=' + cid + '&contentpage=3'; break;
                  case 4: url = '9313.asp?pagetype=7&memberid=' + mid + '&companyid=' + cid; break;
               } break;
               case 'TabFinancial':
                  frame = 'FinancialFrame';
                  switch(shw) {
                  case 1: url = '0475.asp?code=2&memberid=' + mid + '&contentpage=3&popup=-1'; compare=15; break;
                  case 2: url = '0475.asp?code=1&memberid=' + mid + '&contentpage=3&popup=-1'; compare=15; break;
                  case 3: url = '0475.asp?code=3&memberid=' + mid + '&contentpage=3&popup=-1'; compare=15; break;
                  case 4: url = '0475.asp?code=4&memberid=' + mid + '&contentpage=3&popup=-1'; compare=15; break;
                  case 5: url = '0475.asp?code=5&memberid=' + mid + '&contentpage=3&popup=-1'; compare=15; break;
                  case 6: url = '0475.asp?code=6&memberid=' + mid + '&contentpage=3&popup=-1'; compare=15; break;
                  case 7: url = 'money.asp?memberid=' + mid;   target='Money'; break;
                  case 8: url = '0408.asp?referralid=' + mid; break;
                  } break;
               case 'TabResources':
                  frame = 'ResourcesFrame';
                  switch(shw) {
                  case 1: url = '7014.asp?template=1&memberid=' + mid + '&companyid=' + cid + '&contentpage=3'; compare=19; break;
                     case 2: url = '7014.asp?template=2&memberid=' + mid + '&companyid=' + cid + '&contentpage=3'; compare=19; break;
                     case 3: url = '11411.asp?companyid=' + cid + '&groupid=' + mid; break;
                     case 4: url = '9301.asp?pagetype=4&memberid=' + mid + '&companyid=' + cid + '&contentpage=3'; compare=20; break;
                     case 5: url = '9301.asp?pagetype=3&memberid=' + mid + '&companyid=' + cid + '&contentpage=3'; compare=20; break;
                     case 6: url = '9301.asp?pagetype=5&memberid=' + mid + '&companyid=' + cid + '&contentpage=3'; compare=20; break;
                     case 7: url = '9301.asp?pagetype=1&memberid=' + mid + '&companyid=' + cid + '&contentpage=3'; compare=20; break;
                     case 8: url = '9301.asp?pagetype=2&memberid=' + mid + '&companyid=' + cid + '&contentpage=3'; compare=20; break;
                     case 9: url = '9301.asp?pagetype=6&memberid=' + mid + '&companyid=' + cid + '&contentpage=3'; compare=20; break;
                     case 10: url = '8017.asp?parenttype=4&parentid=' + mid; break;
                     case 11: url = '1811.asp?memberid=' + mid + '&companyid=' + cid; break;
                     case 12: url = '0451.asp?groupid=' + mid + '&companyid=' + cid; break;
                     case 13: url = '3854.asp?groupid=' + mid + '&companyid=' + cid + '&popup=-1'; break;
                     case 14: url = '1411.asp?pagetype=1&groupid=' + mid + '&companyid=' + cid; compare=19; break;
                     case 15: url = '1411.asp?pagetype=2&groupid=' + mid + '&companyid=' + cid; compare=19; break;
                     case 16: url = '7711.asp?groupid=' + mid + '&companyid=' + cid; break;
                     case 17: url = '11811.asp?companyid=' + cid + '&groupid=' + mid; break;
                     case 18: url = '12303.asp?memberid=' + mid; break;
                     case 19: url = '11910.asp?memberid=' + mid + '&companyid=' + cid; break;
                     case 20: url = 'MenuColors.asp?groupid=' + mid; break;
                     case 21: url = '12601.asp?companyid=' + cid + '&memberid=' + mid; break;
                     case 22: url = '9301.asp?pagetype=7&memberid=' + mid + '&companyid=' + cid + '&contentpage=3'; compare=20; break;
                     case 23: url = '8821.asp?companyid=' + cid + '&memberid=' + mid; break;
                  } break;
               case 'TabAccount':
                  frame = 'AccountFrame';
                  switch(shw) {
                  case 1: url = '0463.asp?memberid=' + mid + '&contentpage=3&popup=-1'; break;
                     case 2: url = '0436.asp?memberid=' + mid + '&noclose=1'; break;
                     case 3: url = '0441.asp?memberid=' + mid + '&noclose=1'; break;
                     case 4: url = '9211.asp'; break;
                     case 5: url = '0103.asp?contentpage=3&popup=-1'; break;
              case 6: url = '0106.asp?contentpage=3&popup=-1'; break;
              case 7: url = '0107.asp'; load=1; break;
          } break;
          case 'TabHelp':
          frame = 'HelpFrame';
          switch(shw) {
          case 1: url = 'Tutorial.asp?contentpage=3';   target='Tutorial'; break;
          case 2: url = '1713.asp?contentpage=3&popup=1&companyid=' + cid; target='Guide'; break;
          case 3: url = '8013.asp?contentpage=3&companyid=' + cid; break;
               case 4: url = '9506.asp?contentpage=3&popup=1&companyid=' + cid; target='Ticket'; break;
          case 5: url = '4511.asp?contentpage=3'; break;
          case 6: url = '4011.asp?contentpage=3'; break;
          } break;
          }
          if( target.length > 0 ) {
                  win = window.open(url,target,style);
                  win.focus();
               }
               else {
                  if( tab == 'TabDashboard')
                     document.getElementById('TopMargin').style.display = 'none';
                  else
                     document.getElementById('TopMargin').style.display = '';

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
               document.getElementById('TabMarketing').style.display = 'none';
               document.getElementById('TabProductivity').style.display = 'none';
               document.getElementById('TabLeadership').style.display = 'none';
               document.getElementById('TabTraining').style.display = 'none';
               document.getElementById('TabFinancial').style.display = 'none';
               document.getElementById('TabResources').style.display = 'none';
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
                     <xsl:attribute name="width">0</xsl:attribute>
                  </xsl:element>

                  <xsl:element name="TD">
                     <xsl:attribute name="valign">top</xsl:attribute>
                     <xsl:attribute name="width">1000</xsl:attribute>

                     <xsl:element name="TABLE">
                        <xsl:attribute name="border">0</xsl:attribute>
                        <xsl:attribute name="cellpadding">0</xsl:attribute>
                        <xsl:attribute name="cellspacing">0</xsl:attribute>
                        <xsl:attribute name="width">1000</xsl:attribute>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">1000</xsl:attribute>
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

                        <xsl:if test="(/DATA/PARAM/@headerposition = 0)">
                           <xsl:if test="(/DATA/PARAM/@headeralign = 0)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">1000</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">top</xsl:attribute>
                                    <xsl:element name="A">
                                       <xsl:attribute name="href">#_</xsl:attribute>
                                       <xsl:attribute name="onclick">ShowTab('TabDashboard',1)</xsl:attribute>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/<xsl:value-of select="/DATA/SYSTEM/@headerimage"/></xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:if>

                           <xsl:if test="(/DATA/PARAM/@headeralign = 1)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">1000</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">top</xsl:attribute>
                                    <xsl:element name="A">
                                       <xsl:attribute name="href">#_</xsl:attribute>
                                       <xsl:attribute name="onclick">ShowTab('TabDashboard',1)</xsl:attribute>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/<xsl:value-of select="/DATA/SYSTEM/@headerimage"/></xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:if>

                           <xsl:if test="(/DATA/PARAM/@headeralign = 2)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">1000</xsl:attribute>
                                    <xsl:attribute name="align">right</xsl:attribute>
                                    <xsl:attribute name="valign">top</xsl:attribute>
                                    <xsl:element name="A">
                                       <xsl:attribute name="href">#_</xsl:attribute>
                                       <xsl:attribute name="onclick">ShowTab('TabDashboard',1)</xsl:attribute>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/<xsl:value-of select="/DATA/SYSTEM/@headerimage"/></xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:if>

                        </xsl:if>
                        <xsl:if test="(/DATA/PARAM/@menubackground = 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">1000</xsl:attribute>
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">1</xsl:attribute>
                                 <xsl:attribute name="bgcolor"><xsl:value-of select="/DATA/PARAM/@menubehindcolor"/></xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:if test="(/DATA/PARAM/@menualign = 0)">
                              <xsl:element name="TR">
                                 <xsl:attribute name="height">65</xsl:attribute>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">1000</xsl:attribute>
                                    <xsl:attribute name="bgcolor"><xsl:value-of select="/DATA/PARAM/@menubehindcolor"/></xsl:attribute>
                                    <xsl:attribute name="background">Imagesb/<xsl:value-of select="/DATA/PARAM/@menubehindimage"/></xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">middle</xsl:attribute>
<xsl:element name="SCRIPT">
   <xsl:attribute name="language">JavaScript</xsl:attribute>
   var MemberMenu = new CMenu(MemberMenuDef, 'MemberMenu'); MemberMenu.create();
</xsl:element>

                                 </xsl:element>
                              </xsl:element>
                           </xsl:if>

                           <xsl:if test="(/DATA/PARAM/@menualign = 1)">
                              <xsl:element name="TR">
                                 <xsl:attribute name="height">65</xsl:attribute>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">1000</xsl:attribute>
                                    <xsl:attribute name="bgcolor"><xsl:value-of select="/DATA/PARAM/@menubehindcolor"/></xsl:attribute>
                                    <xsl:attribute name="background">Imagesb/<xsl:value-of select="/DATA/PARAM/@menubehindimage"/></xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">middle</xsl:attribute>
<xsl:element name="SCRIPT">
   <xsl:attribute name="language">JavaScript</xsl:attribute>
   var MemberMenu = new CMenu(MemberMenuDef, 'MemberMenu'); MemberMenu.create();
</xsl:element>

                                 </xsl:element>
                              </xsl:element>
                           </xsl:if>

                           <xsl:if test="(/DATA/PARAM/@menualign = 2)">
                              <xsl:element name="TR">
                                 <xsl:attribute name="height">65</xsl:attribute>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">1000</xsl:attribute>
                                    <xsl:attribute name="bgcolor"><xsl:value-of select="/DATA/PARAM/@menubehindcolor"/></xsl:attribute>
                                    <xsl:attribute name="background">Imagesb/<xsl:value-of select="/DATA/PARAM/@menubehindimage"/></xsl:attribute>
                                    <xsl:attribute name="align">right</xsl:attribute>
                                    <xsl:attribute name="valign">middle</xsl:attribute>
                                    <xsl:if test="(/DATA/PARAM/@menulogo != '')">
                                       <xsl:element name="DIV">
                                          <xsl:attribute name="style">float:left; margin-left:20px;</xsl:attribute>
                                          <xsl:element name="A">
                                             <xsl:attribute name="href">#_</xsl:attribute>
                                             <xsl:attribute name="onclick">ShowTab('TabDashboard',1)</xsl:attribute>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/<xsl:value-of select="/DATA/PARAM/@menulogo"/></xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="DIV">
                                          <xsl:attribute name="style">float:right</xsl:attribute>
<xsl:element name="SCRIPT">
   <xsl:attribute name="language">JavaScript</xsl:attribute>
   var MemberMenu = new CMenu(MemberMenuDef, 'MemberMenu'); MemberMenu.create();
</xsl:element>

                                       </xsl:element>
                                    </xsl:if>
                                    <xsl:if test="(/DATA/PARAM/@menulogo = '')">
<xsl:element name="SCRIPT">
   <xsl:attribute name="language">JavaScript</xsl:attribute>
   var MemberMenu = new CMenu(MemberMenuDef, 'MemberMenu'); MemberMenu.create();
</xsl:element>

                                    </xsl:if>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:if>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">1000</xsl:attribute>
                                 <xsl:attribute name="height">1</xsl:attribute>
                                 <xsl:attribute name="bgcolor"><xsl:value-of select="/DATA/PARAM/@menubehindcolor"/></xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/PARAM/@menubackground != 0)">
                           <xsl:if test="(/DATA/PARAM/@menualign = 0)">
                              <xsl:element name="TR">
                                 <xsl:attribute name="height">65</xsl:attribute>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">1000</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">middle</xsl:attribute>
<xsl:element name="SCRIPT">
   <xsl:attribute name="language">JavaScript</xsl:attribute>
   var MemberMenu = new CMenu(MemberMenuDef, 'MemberMenu'); MemberMenu.create();
</xsl:element>

                                 </xsl:element>
                              </xsl:element>
                           </xsl:if>

                           <xsl:if test="(/DATA/PARAM/@menualign = 1)">
                              <xsl:element name="TR">
                                 <xsl:attribute name="height">65</xsl:attribute>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">1000</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">middle</xsl:attribute>
<xsl:element name="SCRIPT">
   <xsl:attribute name="language">JavaScript</xsl:attribute>
   var MemberMenu = new CMenu(MemberMenuDef, 'MemberMenu'); MemberMenu.create();
</xsl:element>

                                 </xsl:element>
                              </xsl:element>
                           </xsl:if>

                           <xsl:if test="(/DATA/PARAM/@menualign = 2)">
                              <xsl:element name="TR">
                                 <xsl:attribute name="height">65</xsl:attribute>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">1000</xsl:attribute>
                                    <xsl:attribute name="align">right</xsl:attribute>
                                    <xsl:attribute name="valign">middle</xsl:attribute>
<xsl:element name="SCRIPT">
   <xsl:attribute name="language">JavaScript</xsl:attribute>
   var MemberMenu = new CMenu(MemberMenuDef, 'MemberMenu'); MemberMenu.create();
</xsl:element>

                                 </xsl:element>
                              </xsl:element>
                           </xsl:if>

                        </xsl:if>
                        <xsl:if test="(/DATA/PARAM/@headerposition = 1)">
                           <xsl:if test="(/DATA/PARAM/@headeralign = 0)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">1000</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">top</xsl:attribute>
                                    <xsl:element name="A">
                                       <xsl:attribute name="href">#_</xsl:attribute>
                                       <xsl:attribute name="onclick">ShowTab('TabDashboard',1)</xsl:attribute>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/<xsl:value-of select="/DATA/SYSTEM/@headerimage"/></xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:if>

                           <xsl:if test="(/DATA/PARAM/@headeralign = 1)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">1000</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">top</xsl:attribute>
                                    <xsl:element name="A">
                                       <xsl:attribute name="href">#_</xsl:attribute>
                                       <xsl:attribute name="onclick">ShowTab('TabDashboard',1)</xsl:attribute>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/<xsl:value-of select="/DATA/SYSTEM/@headerimage"/></xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:if>

                           <xsl:if test="(/DATA/PARAM/@headeralign = 2)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">1000</xsl:attribute>
                                    <xsl:attribute name="align">right</xsl:attribute>
                                    <xsl:attribute name="valign">top</xsl:attribute>
                                    <xsl:element name="A">
                                       <xsl:attribute name="href">#_</xsl:attribute>
                                       <xsl:attribute name="onclick">ShowTab('TabDashboard',1)</xsl:attribute>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/<xsl:value-of select="/DATA/SYSTEM/@headerimage"/></xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:if>

                        </xsl:if>
                        <xsl:element name="TR">
                           <xsl:attribute name="id">TopMargin</xsl:attribute>
                           <xsl:attribute name="height">6</xsl:attribute>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:attribute name="id">TabDashboard</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">1000</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IFRAME">
                                 <xsl:attribute name="src"></xsl:attribute>
                                 <xsl:attribute name="width">1000</xsl:attribute>
                                 <xsl:attribute name="height">1000</xsl:attribute>
                                 <xsl:attribute name="frmheight">1000</xsl:attribute>
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
                           <xsl:attribute name="id">TabMarketing</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">1000</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IFRAME">
                                 <xsl:attribute name="src"></xsl:attribute>
                                 <xsl:attribute name="width">1000</xsl:attribute>
                                 <xsl:attribute name="height">2000</xsl:attribute>
                                 <xsl:attribute name="frmheight">2000</xsl:attribute>
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
                           <xsl:attribute name="id">TabProductivity</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">1000</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IFRAME">
                                 <xsl:attribute name="src"></xsl:attribute>
                                 <xsl:attribute name="width">1000</xsl:attribute>
                                 <xsl:attribute name="height">2000</xsl:attribute>
                                 <xsl:attribute name="frmheight">2000</xsl:attribute>
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
                           <xsl:attribute name="id">TabLeadership</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">1000</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IFRAME">
                                 <xsl:attribute name="src"></xsl:attribute>
                                 <xsl:attribute name="width">1000</xsl:attribute>
                                 <xsl:attribute name="height">2000</xsl:attribute>
                                 <xsl:attribute name="frmheight">2000</xsl:attribute>
                                 <xsl:attribute name="id">LeadershipFrame</xsl:attribute>
                                 <xsl:attribute name="name">LeadershipFrame</xsl:attribute>
                                 <xsl:attribute name="class">FrameNoScroll</xsl:attribute>
                                 <xsl:attribute name="frameborder">0</xsl:attribute>
                                 <xsl:attribute name="onload">ShowFrame('TabLeadership')</xsl:attribute>
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
                              <xsl:attribute name="width">1000</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IFRAME">
                                 <xsl:attribute name="src"></xsl:attribute>
                                 <xsl:attribute name="width">1000</xsl:attribute>
                                 <xsl:attribute name="height">2500</xsl:attribute>
                                 <xsl:attribute name="frmheight">2500</xsl:attribute>
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
                              <xsl:attribute name="width">1000</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IFRAME">
                                 <xsl:attribute name="src"></xsl:attribute>
                                 <xsl:attribute name="width">1000</xsl:attribute>
                                 <xsl:attribute name="height">2000</xsl:attribute>
                                 <xsl:attribute name="frmheight">2000</xsl:attribute>
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
                           <xsl:attribute name="id">TabResources</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">1000</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IFRAME">
                                 <xsl:attribute name="src"></xsl:attribute>
                                 <xsl:attribute name="width">1000</xsl:attribute>
                                 <xsl:attribute name="height">2000</xsl:attribute>
                                 <xsl:attribute name="frmheight">2000</xsl:attribute>
                                 <xsl:attribute name="id">ResourcesFrame</xsl:attribute>
                                 <xsl:attribute name="name">ResourcesFrame</xsl:attribute>
                                 <xsl:attribute name="class">FrameNoScroll</xsl:attribute>
                                 <xsl:attribute name="frameborder">0</xsl:attribute>
                                 <xsl:attribute name="onload">ShowFrame('TabResources')</xsl:attribute>
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
                              <xsl:attribute name="width">1000</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IFRAME">
                                 <xsl:attribute name="src"></xsl:attribute>
                                 <xsl:attribute name="width">1000</xsl:attribute>
                                 <xsl:attribute name="height">2000</xsl:attribute>
                                 <xsl:attribute name="frmheight">2000</xsl:attribute>
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
                              <xsl:attribute name="width">1000</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IFRAME">
                                 <xsl:attribute name="src"></xsl:attribute>
                                 <xsl:attribute name="width">1000</xsl:attribute>
                                 <xsl:attribute name="height">2000</xsl:attribute>
                                 <xsl:attribute name="frmheight">2000</xsl:attribute>
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
                              <xsl:attribute name="width">1000</xsl:attribute>
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
      </xsl:element>
      <!--END BODY-->

      </xsl:element>

   </xsl:template>
</xsl:stylesheet>