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
         <xsl:attribute name="href">include/StyleSheet12.css</xsl:attribute>
      </xsl:element>

      <xsl:call-template name="HTMLHeading">
         <xsl:with-param name="pagename" select="'Right 180 News'"/>
         <xsl:with-param name="includecalendar" select="true()"/>
         <xsl:with-param name="htmleditor"></xsl:with-param>
         <xsl:with-param name="translate">google</xsl:with-param>
      </xsl:call-template>

      <xsl:element name="SCRIPT">
         <xsl:attribute name="type">text/javascript</xsl:attribute>
         <xsl:attribute name="src">http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js</xsl:attribute>
         <xsl:text> </xsl:text>
      </xsl:element>

      <xsl:element name="SCRIPT">
         <xsl:attribute name="type">text/javascript</xsl:attribute>
         <xsl:attribute name="src">include/jcarousel/jquery.jcarousel.min.js</xsl:attribute>
         <xsl:text> </xsl:text>
      </xsl:element>

      <xsl:element name="LINK">
         <xsl:attribute name="rel">stylesheet</xsl:attribute>
         <xsl:attribute name="type">text/css</xsl:attribute>
         <xsl:attribute name="href">include/jcarousel/r180a.css</xsl:attribute>
         <xsl:attribute name="media">all</xsl:attribute>
      </xsl:element>

      <xsl:element name="SCRIPT">
         <xsl:attribute name="language">JavaScript</xsl:attribute>
         <xsl:text disable-output-escaping="yes"><![CDATA[
            function Strategic_initCallback(carousel) {
               carousel.clip.hover(function() {
                  carousel.stopAuto();
                  }, function() {
                  carousel.startAuto();
               });
            };
            jQuery(document).ready(function() {
               jQuery("#Strategic").jcarousel({
                  vertical:false,
                  scroll:1,
                  auto:7,
                  wrap:"circular",
                  initCallback: Strategic_initCallback
               });
            });
         ]]></xsl:text>
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
               $("#HDR").bjqs({
                  width:700,
                  height:100,
                  animduration:2000,
                  animspeed:2000,
                  showcontrols:false,
                  showmarkers:false
               });
            });
         ]]></xsl:text>
      </xsl:element>

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
         <xsl:variable name="background">
            <xsl:choose>
               <xsl:when test="string-length(/DATA/PARAM/@pageimage)!=0">
                  <xsl:value-of select="/DATA/PARAM/@pageimage"/>
               </xsl:when>
               <xsl:otherwise>bg12.jpg</xsl:otherwise>
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
         <xsl:attribute name="id">wrapper1200</xsl:attribute>
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
                     <xsl:attribute name="width">1200</xsl:attribute>
                  </xsl:element>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function Subscribe(){ 
               var url, win;
               var mid = document.getElementById('MemberID').value;
               url = "13201.asp?m=" + mid
               win = window.open(url,"Enroll");
               win.focus();
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ShowTab(tab, shw){ 
               var url, target='', style='';
               var mid = document.getElementById('MemberID').value;
               var cid = document.getElementById('CompanyID').value;
               var gid = document.getElementById('G').value;

               switch(tab) {
               case 'TabHome': url = '13210.asp'; break;
               case 'TabCompany': url = '13220.asp?option=' + shw; target="CompanyInfo"; break;
               case 'TabTopic': url = '13212.asp?t=' + shw; break;
               case 'TabSearch': url = '13214.asp'; break;
               case 'TabStory': url = '13213.asp?s=' + shw + '&g=' + gid; break;
               case 'TabMember':
               switch(shw) {
               case 1: url = '14101.asp?memberid=' + mid; target="MyFriends"; break;
               case 2: url = '14403.asp?memberid=' + mid; target="Broadcasts"; break;
               case 3: url = '14401.asp?memberid=' + mid; target="Broadcasts"; break;
               case 4: url = '0463.asp?memberid=' + mid + '&contentpage=3&popup=1'; target="Profile"; break;
               case 5: url = '0441.asp?memberid=' + mid; target="PayoutMethod"; break;
               case 6: url = '0103.asp?contentpage=3&popup=1'; target="ChangeLogon"; break;
               case 7: url = '0106.asp?contentpage=3&popup=1'; target="ChangePassword"; break;
               case 8: url = '1713.asp?contentpage=3&popup=1' + '&companyid=' + cid; target="FAQ"; break;
               case 9: url = '9506.asp?contentpage=3&popup=1' + '&companyid=' + cid; target="SupportTicket"; break;
               case 10: url = '13221.asp?memberid=' + mid; target="Group"; break;
               }
               break;
               }
               if( target.length > 0 && url.length > 0 ) {
                  win = window.open(url,target,style);
                  win.focus();
               }
               else {
                  if( url.length > 0 ) { window.location = url   }
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
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">G</xsl:attribute>
                              <xsl:attribute name="id">G</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@g"/></xsl:attribute>
                           </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">1200</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">1200</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">250</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">700</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">250</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">250</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/<xsl:value-of select="/DATA/PARAM/@logo1"/></xsl:attribute>
                                             <xsl:attribute name="width">250</xsl:attribute>
                                             <xsl:attribute name="height">100</xsl:attribute>
                                             <xsl:attribute name="align">top</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">700</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="DIV">
                                             <xsl:attribute name="style">margin-bottom:5px;</xsl:attribute>
                                          <xsl:element name="div">
                                             <xsl:attribute name="id">HDR</xsl:attribute>
                                             <xsl:element name="ul">
                                                <xsl:attribute name="class">bjqs</xsl:attribute>
                                                <xsl:for-each select="/DATA/TXN/HDRS/HDR">
                                                   <xsl:element name="li">
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/Company\<xsl:value-of select="/DATA/PARAM/@companyid"/>/<xsl:value-of select="@image"/></xsl:attribute>
                                                      <xsl:attribute name="width">700</xsl:attribute>
                                                      <xsl:attribute name="height">100</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                                   </xsl:element>
                                                </xsl:for-each>
                                             </xsl:element>
                                          </xsl:element>

                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">250</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/<xsl:value-of select="/DATA/PARAM/@logo2"/></xsl:attribute>
                                             <xsl:attribute name="width">250</xsl:attribute>
                                             <xsl:attribute name="height">100</xsl:attribute>
                                             <xsl:attribute name="align">top</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">1200</xsl:attribute>
                              <xsl:attribute name="height">36</xsl:attribute>
                              <xsl:attribute name="bgcolor"><xsl:value-of select="/DATA/PARAM/@menubehindcolor"/></xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">1200</xsl:attribute>
                                 <xsl:attribute name="height">36</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="bgcolor"><xsl:value-of select="/DATA/PARAM/@menubehindcolor"/></xsl:attribute>
                                          <xsl:attribute name="background">Imagesb/<xsl:value-of select="/DATA/PARAM/@menubehindimage"/></xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">middle</xsl:attribute>
<xsl:element name="SCRIPT">
   <xsl:attribute name="language">JavaScript</xsl:attribute>
   var NewsMenu = new CMenu(NewsMenuDef, 'NewsMenu'); NewsMenu.create();
</xsl:element>

                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="bgcolor"><xsl:value-of select="/DATA/PARAM/@menubehindcolor"/></xsl:attribute>
                                          <xsl:attribute name="background">Imagesb/<xsl:value-of select="/DATA/PARAM/@menubehindimage"/></xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">middle</xsl:attribute>
                                          <xsl:element name="font">
                                             <xsl:attribute name="color"><xsl:value-of select="/DATA/PARAM/@menutopcolor"/></xsl:attribute>
                                          <xsl:if test="(/DATA/SYSTEM/@usergroup &gt; 41)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Logon']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">text</xsl:attribute>
                                                <xsl:attribute name="name">Lgn</xsl:attribute>
                                                <xsl:attribute name="id">Lgn</xsl:attribute>
                                                <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@lgn"/></xsl:attribute>
                                                <xsl:attribute name="size">10</xsl:attribute>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Password']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">password</xsl:attribute>
                                                <xsl:attribute name="name">Pwd</xsl:attribute>
                                                <xsl:attribute name="id">Pwd</xsl:attribute>
                                                <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@pwd"/></xsl:attribute>
                                                <xsl:attribute name="size">10</xsl:attribute>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">submit</xsl:attribute>
                                                   <xsl:attribute name="class">smbutton</xsl:attribute>
                                                   <xsl:attribute name="value">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SignIn']"/>
                                                   </xsl:attribute>
                                                   <xsl:attribute name="onclick">doSubmit(1,"")</xsl:attribute>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">button</xsl:attribute>
                                                   <xsl:attribute name="class">smbutton</xsl:attribute>
                                                   <xsl:attribute name="value">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Subscribe']"/>
                                                   </xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[Subscribe()]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">checkbox</xsl:attribute>
                                                <xsl:attribute name="name">Remember</xsl:attribute>
                                                <xsl:attribute name="id">Remember</xsl:attribute>
                                                <xsl:attribute name="value">1</xsl:attribute>
                                                <xsl:if test="(/DATA/PARAM/@remember = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Remember']"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                          </xsl:if>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">1200</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor"><xsl:value-of select="/DATA/PARAM/@menubehindcolor"/></xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">1200</xsl:attribute>
                              <xsl:attribute name="height">125</xsl:attribute>
                              <xsl:attribute name="bgcolor">1c1c1c</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">1200</xsl:attribute>
                                 <xsl:attribute name="height">125</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">20</xsl:attribute>
                                             <xsl:attribute name="style">background-color:1c1c1c;</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">1160</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="DIV">
                                             <xsl:attribute name="style">background-color:1c1c1c; padding-top:10px; height:90px</xsl:attribute>
                                          <xsl:element name="ul">
                                             <xsl:attribute name="id">Strategic</xsl:attribute>
                                             <xsl:attribute name="class">jcarousel-skin-r180a</xsl:attribute>
                                             <xsl:for-each select="/DATA/TXN/PTSSTRATEGICS/PTSSTRATEGIC">
                                                <xsl:element name="li">
                                                         <xsl:element name="A">
                                                            <xsl:attribute name="href">#_</xsl:attribute>
                                                            <xsl:attribute name="onclick">ShowTab('TabStory', <xsl:value-of select="@newsid"/>)</xsl:attribute>
                                                            <xsl:element name="IMG">
                                                               <xsl:attribute name="src">Images/News\<xsl:value-of select="/DATA/PARAM/@c"/>\thumb/<xsl:value-of select="@image"/></xsl:attribute>
                                                               <xsl:attribute name="width">75</xsl:attribute>
                                                               <xsl:attribute name="height">75</xsl:attribute>
                                                               <xsl:attribute name="hspace">10</xsl:attribute>
                                                               <xsl:attribute name="align">left</xsl:attribute>
                                                               <xsl:attribute name="border">0</xsl:attribute>
                                                            </xsl:element>
                                                         </xsl:element>
                                                         <xsl:element name="A">
                                                            <xsl:attribute name="href">#_</xsl:attribute>
                                                            <xsl:attribute name="onclick">ShowTab('TabStory', <xsl:value-of select="@newsid"/>)</xsl:attribute>
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="color">b6b6b6</xsl:attribute>
                                                         <xsl:value-of select="@title"/>
                                                         </xsl:element>
                                                         </xsl:element>
                                                </xsl:element>
                                             </xsl:for-each>
                                          </xsl:element>

                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">20</xsl:attribute>
                                             <xsl:attribute name="style">background-color:1c1c1c;</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>

                              </xsl:element>
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

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">3</xsl:attribute>
                                          <xsl:attribute name="width">1200</xsl:attribute>
                                          <xsl:attribute name="height">40</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="TABLE">
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="cellpadding">0</xsl:attribute>
                                             <xsl:attribute name="cellspacing">0</xsl:attribute>
                                             <xsl:attribute name="width">1200</xsl:attribute>
                                             <xsl:attribute name="height">40</xsl:attribute>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="colspan">2</xsl:attribute>
                                                      <xsl:attribute name="height">6</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">1000</xsl:attribute>
                                                      <xsl:attribute name="align">left</xsl:attribute>
                                                      <xsl:attribute name="valign">middle</xsl:attribute>
<xsl:element name="SCRIPT">
   <xsl:attribute name="language">JavaScript</xsl:attribute>
   var TopicMenu = new CMenu(TopicMenuDef, 'TopicMenu'); TopicMenu.create();
</xsl:element>

                                                   </xsl:element>
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">200</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="DIV">
                                                         <xsl:attribute name="id">gk-social-icons</xsl:attribute>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="class">gk-twitter-icon</xsl:attribute>
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"new","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">http://twitter.com/drjakebaker</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="class">gk-facebook-icon</xsl:attribute>
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"new","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">https://www.facebook.com/DrJakeBaker</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="class">gk-pinterest-icon</xsl:attribute>
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"new","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">http://pinterest.com/docjake54</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="class">gk-gplus-icon</xsl:attribute>
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"new","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">https://plus.google.com/?gpsrc=gplp0&amp;partnerid=gplp0#</xsl:attribute>
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

                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                              </xsl:element>
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
                                          <xsl:attribute name="colspan">4</xsl:attribute>
                                          <xsl:attribute name="height">12</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">4</xsl:attribute>
                                          <xsl:attribute name="width">1200</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">SearchText</xsl:attribute>
                                          <xsl:attribute name="id">SearchText</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@searchtext"/></xsl:attribute>
                                          <xsl:attribute name="size">20</xsl:attribute>
                                          <xsl:attribute name="style">background-color: #cccccc</xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">submit</xsl:attribute>
                                             <xsl:attribute name="value">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Search']"/>
                                             </xsl:attribute>
                                             <xsl:attribute name="onclick">doSubmit(5,"")</xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="A">
                                             <xsl:attribute name="onclick">w=window.open(this.href,"Help","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                             <xsl:attribute name="href">pagex.asp?Page=SearchHelp</xsl:attribute>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="src">Images/LearnMore.gif</xsl:attribute>
                                                <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="SELECT">
                                             <xsl:attribute name="name">Term</xsl:attribute>
                                             <xsl:attribute name="id">Term</xsl:attribute>
                                             <xsl:attribute name="onchange"><xsl:text disable-output-escaping="yes"><![CDATA[
                           var ONE_DAY = 1000 * 60 * 60 * 24;
                           var fromdate = new Date();
                           var todate = new Date();
                           var term = document.getElementById('Term').value;
                           switch(term) {
                           case "0":
                           document.getElementById('FromDate').value = '1/1/2013'
                           break;
                           case "1":
                           break;
                           case "2":
                           fromdate.setTime(fromdate.getTime() - ONE_DAY );
                           todate = fromdate;
                           break;
                           case "3":
                           var d = fromdate.getDay();
                           if( d == 0 ) { d = 7 }
                           fromdate.setTime(fromdate.getTime() - ( (d-1) * ONE_DAY ) );
                           break;
                           case "4":
                           fromdate.setTime(fromdate.getTime() - ( ONE_DAY * 6 ) );
                           break;
                           case "5":
                           var td = todate.getDay();
                           if( td == 0 ){ td = 7 }
                           todate.setTime(todate.getTime() - ( td * ONE_DAY ) );
                           fromdate.setTime(todate.getTime() - ( 6 * ONE_DAY ) );
                           break;
                           case "6":
                           fromdate.setDate(1);
                           break;
                           case "7":
                           fromdate.setTime(fromdate.getTime() - ( ONE_DAY * 29 ) );
                           break;
                           case "8":
                           todate.setDate(1);
                           todate.setTime(todate.getTime() - ONE_DAY );
                           fromdate.setTime(todate.getTime());
                           fromdate.setDate(1);
                           break;
                           case "9":
                           fromdate.setMonth(0);
                           fromdate.setDate(1);
                           break;
                           case "10":
                           todate.setMonth(0);
                           todate.setDate(1);
                           todate.setTime(todate.getTime() - ONE_DAY );
                           fromdate.setTime(todate.getTime());
                           fromdate.setMonth(0);
                           fromdate.setDate(1);
                           break;
                           }
                           if(term!="0"){document.getElementById('FromDate').value = fromdate.getMonth()+1 + "/" + fromdate.getDate() + "/" + fromdate.getFullYear();}
                           document.getElementById('ToDate').value = todate.getMonth()+1 + "/" + todate.getDate() + "/" + todate.getFullYear();
                        ]]></xsl:text></xsl:attribute>
                                             <xsl:variable name="tmp"><xsl:value-of select="/DATA/PARAM/@term"/></xsl:variable>
                                             <xsl:element name="OPTION">
                                                <xsl:attribute name="value">0</xsl:attribute>
                                                <xsl:if test="$tmp='0'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AllNews']"/>
                                             </xsl:element>
                                             <xsl:element name="OPTION">
                                                <xsl:attribute name="value">1</xsl:attribute>
                                                <xsl:if test="$tmp='1'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Today']"/>
                                             </xsl:element>
                                             <xsl:element name="OPTION">
                                                <xsl:attribute name="value">2</xsl:attribute>
                                                <xsl:if test="$tmp='2'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Yesterday']"/>
                                             </xsl:element>
                                             <xsl:element name="OPTION">
                                                <xsl:attribute name="value">3</xsl:attribute>
                                                <xsl:if test="$tmp='3'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ThisWeek']"/>
                                             </xsl:element>
                                             <xsl:element name="OPTION">
                                                <xsl:attribute name="value">4</xsl:attribute>
                                                <xsl:if test="$tmp='4'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Prev7Days']"/>
                                             </xsl:element>
                                             <xsl:element name="OPTION">
                                                <xsl:attribute name="value">5</xsl:attribute>
                                                <xsl:if test="$tmp='5'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PrevWeek']"/>
                                             </xsl:element>
                                             <xsl:element name="OPTION">
                                                <xsl:attribute name="value">6</xsl:attribute>
                                                <xsl:if test="$tmp='6'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ThisMonth']"/>
                                             </xsl:element>
                                             <xsl:element name="OPTION">
                                                <xsl:attribute name="value">7</xsl:attribute>
                                                <xsl:if test="$tmp='7'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Prev30Days']"/>
                                             </xsl:element>
                                             <xsl:element name="OPTION">
                                                <xsl:attribute name="value">8</xsl:attribute>
                                                <xsl:if test="$tmp='8'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PrevMonth']"/>
                                             </xsl:element>
                                             <xsl:element name="OPTION">
                                                <xsl:attribute name="value">9</xsl:attribute>
                                                <xsl:if test="$tmp='9'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ThisYear']"/>
                                             </xsl:element>
                                             <xsl:element name="OPTION">
                                                <xsl:attribute name="value">10</xsl:attribute>
                                                <xsl:if test="$tmp='10'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PrevYear']"/>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='From']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">FromDate</xsl:attribute>
                                          <xsl:attribute name="id">FromDate</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@fromdate"/></xsl:attribute>
                                          <xsl:attribute name="size">10</xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="name">Calendar</xsl:attribute>
                                             <xsl:attribute name="src">Images/Calendar.gif</xsl:attribute>
                                             <xsl:attribute name="width">16</xsl:attribute>
                                             <xsl:attribute name="height">16</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="onclick">CalendarPopup(document.forms[0], document.getElementById('FromDate'))</xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='To']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">ToDate</xsl:attribute>
                                          <xsl:attribute name="id">ToDate</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@todate"/></xsl:attribute>
                                          <xsl:attribute name="size">10</xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="name">Calendar</xsl:attribute>
                                             <xsl:attribute name="src">Images/Calendar.gif</xsl:attribute>
                                             <xsl:attribute name="width">16</xsl:attribute>
                                             <xsl:attribute name="height">16</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="onclick">CalendarPopup(document.forms[0], document.getElementById('ToDate'))</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">4</xsl:attribute>
                                          <xsl:attribute name="height">12</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">20</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">870</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                          <xsl:element name="TABLE">
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="cellpadding">0</xsl:attribute>
                                             <xsl:attribute name="cellspacing">0</xsl:attribute>
                                             <xsl:attribute name="width">870</xsl:attribute>
                                             <xsl:attribute name="style">border: 1px #cccccc solid;</xsl:attribute>

                                                <xsl:if test="(/DATA/PARAM/@issearch = 0)">
                                                   <xsl:element name="TR">
                                                   </xsl:element>
                                                </xsl:if>

                                                <xsl:if test="(/DATA/PARAM/@issearch != 0)">
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">870</xsl:attribute>
                                                         <xsl:attribute name="align">left</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:attribute name="align">right</xsl:attribute>
                                                         <xsl:call-template name="PreviousNext"/>
                                                         <xsl:element name="TABLE">
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="cellpadding">0</xsl:attribute>
                                                            <xsl:attribute name="cellspacing">0</xsl:attribute>
                                                            <xsl:attribute name="width">870</xsl:attribute>
                                                            <xsl:element name="TR">
                                                               <xsl:element name="TD">
                                                                  <xsl:attribute name="align">left</xsl:attribute>
                                                                  <xsl:attribute name="width">100%</xsl:attribute>
                                                                  <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                                                  <xsl:attribute name="valign">Bottom</xsl:attribute>
                                                               </xsl:element>
                                                            </xsl:element>
                                                            <xsl:element name="TR">
                                                               <xsl:element name="TD">
                                                                  <xsl:attribute name="height">2</xsl:attribute>
                                                                  <xsl:attribute name="bgcolor">#CCCCCC</xsl:attribute>
                                                               </xsl:element>
                                                            </xsl:element>

                                                            <xsl:for-each select="/DATA/TXN/PTSNEWSS/PTSNEWS">
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
                                                                     <xsl:if test="(@image != '')">
                                                                           <xsl:element name="A">
                                                                              <xsl:attribute name="href">#_</xsl:attribute>
                                                                              <xsl:attribute name="onclick">ShowTab('TabStory', <xsl:value-of select="@newsid"/>)</xsl:attribute>
                                                                              <xsl:element name="IMG">
                                                                                 <xsl:attribute name="src">Images/News\<xsl:value-of select="/DATA/PARAM/@companyid"/>/<xsl:value-of select="@image"/></xsl:attribute>
                                                                                 <xsl:attribute name="width">200</xsl:attribute>
                                                                                 <xsl:attribute name="hspace">10</xsl:attribute>
                                                                                 <xsl:attribute name="align">left</xsl:attribute>
                                                                                 <xsl:attribute name="border">0</xsl:attribute>
                                                                              </xsl:element>
                                                                           </xsl:element>
                                                                     </xsl:if>
                                                                        <xsl:element name="A">
                                                                           <xsl:attribute name="href">#_</xsl:attribute>
                                                                           <xsl:attribute name="onclick">ShowTab('TabStory', <xsl:value-of select="@newsid"/>)</xsl:attribute>
                                                                        <xsl:element name="b">
                                                                        <xsl:value-of select="@title"/>
                                                                        </xsl:element>
                                                                        <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                        </xsl:element>
                                                                        <xsl:element name="A">
                                                                           <xsl:attribute name="href">#_</xsl:attribute>
                                                                           <xsl:attribute name="onclick">ShowTab('TabStory', <xsl:value-of select="@newsid"/>)</xsl:attribute>
                                                                           <xsl:element name="IMG">
                                                                              <xsl:attribute name="src">Images/preview2.gif</xsl:attribute>
                                                                              <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                              <xsl:attribute name="border">0</xsl:attribute>
                                                                           </xsl:element>
                                                                        </xsl:element>
                                                                        <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                        <xsl:element name="font">
                                                                           <xsl:attribute name="color">gray</xsl:attribute>
                                                                        <xsl:value-of select="@activedate"/>
                                                                        </xsl:element>
                                                                        <xsl:element name="BR"/>
                                                                        <xsl:element name="font">
                                                                           <xsl:attribute name="color">blue</xsl:attribute>
                                                                        <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Tags']"/>
                                                                        <xsl:text>:</xsl:text>
                                                                        <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                                        <xsl:value-of select="@tags"/>
                                                                        </xsl:element>
                                                                        <xsl:element name="BR"/>
                                                                        <xsl:value-of select="DESCRIPTION/comment()" disable-output-escaping="yes"/>
                                                                  </xsl:element>
                                                               </xsl:element>
                                                               <xsl:element name="TR">
                                                                  <xsl:element name="TD">
                                                                  <xsl:if test="(position() mod 2)=1">
                                                                     <xsl:attribute name="class">GrayBar</xsl:attribute>
                                                                  </xsl:if>
                                                                  <xsl:if test="(position() mod 2)=0">
                                                                     <xsl:attribute name="class">WhiteBar</xsl:attribute>
                                                                  </xsl:if>
                                                                     <xsl:attribute name="colspan">2</xsl:attribute>
                                                                     <xsl:attribute name="height">12</xsl:attribute>
                                                                  </xsl:element>
                                                               </xsl:element>
                                                            </xsl:for-each>
                                                            <xsl:choose>
                                                               <xsl:when test="(count(/DATA/TXN/PTSNEWSS/PTSNEWS) = 0)">
                                                                  <xsl:element name="TR">
                                                                     <xsl:element name="TD">
                                                                        <xsl:attribute name="colspan">1</xsl:attribute>
                                                                        <xsl:attribute name="align">left</xsl:attribute>
                                                                        <xsl:attribute name="class">NoItems</xsl:attribute>
                                                                        <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoItems']"/>
                                                                     </xsl:element>
                                                                  </xsl:element>
                                                               </xsl:when>
                                                            </xsl:choose>

                                                            <xsl:element name="TR">
                                                               <xsl:element name="TD">
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
                                                            <xsl:attribute name="width">870</xsl:attribute>
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

                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">10</xsl:attribute>
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

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">1200</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/TXN/PTSFOOTER/DATA/comment()" disable-output-escaping="yes"/>
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
                              <xsl:attribute name="width">1200</xsl:attribute>
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
   TopicMenu.run();
   NewsMenu.run();
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