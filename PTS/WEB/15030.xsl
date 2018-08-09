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
         <xsl:with-param name="pagename" select="'Nexxus Rewards'"/>
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
               <xsl:attribute name="name">Merchant</xsl:attribute>
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
          var mid = document.getElementById('MerchantID').value;
          var cid = document.getElementById('CompanyID').value;
          var frame, url, frm, src, page, target='', style='', compare=0, load=0, comingsoon=0;

          switch(tab) {
          case 'TabDashboard':
          frame = 'DashboardFrame';
          switch(shw) {
          case 1: url = '15031.asp?merchantid=' + mid + "&companyid=" + cid; load=1; break;
          case 2: url = 'm_15031.asp?merchantid=' + mid; target='Mobile'; style='top=100,left=100,height=492,width=322,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no'; break;
          } break;
          case 'TabReward':
          frame = 'RewardFrame';
          switch(shw) {
          case 1: url = '15101.asp?merchantid=' + mid; target="Shoppers"; break;
          case 2: url = '0922.asp?merchantid=' + mid; target="Bonuses"; break;
          case 3: url = '16301.asp?merchantid=' + mid; target="Statements"; break;
          } break;
          case 'TabAccount':
          frame = 'AccountFrame';
          switch(shw) {
          case 1: url = '15003.asp?merchantid=' + mid; break;
          case 2: url = '15008.asp?merchantid=' + mid; break;
          case 3: url = '0108.asp?popup=1&merchantid=' + mid; load=1; break;
          } break;
          case 'TabHelp':
          frame = 'HelpFrame';
          switch(shw) {
          case 1: url = '1713.asp?contentpage=3&popup=1&companyid=' + cid; target="AdminGuide"; break;
          case 2: url = '9506.asp?contentpage=3&popup=1&companyid=' + cid; target="AdminTicket"; break;
          } break;
          }
          if(comingsoon == 1) {
          alert('Coming Soon...');
          }
          else {
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
          }
         }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ShowFrame(tab){ 
          document.getElementById('TabDashboard').style.display = 'none';
          document.getElementById('TabReward').style.display = 'none';
          document.getElementById('TabAccount').style.display = 'none';
          document.getElementById('TabHelp').style.display = 'none';
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
                              <xsl:attribute name="name">MerchantID</xsl:attribute>
                              <xsl:attribute name="id">MerchantID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@merchantid"/></xsl:attribute>
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
                                    <xsl:element name="IMG">
                                       <xsl:attribute name="src">Images/Company/<xsl:value-of select="/DATA/PARAM/@companyid"/>/<xsl:value-of select="/DATA/PARAM/@header"/></xsl:attribute>
                                       <xsl:attribute name="border">0</xsl:attribute>
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
                                    <xsl:element name="IMG">
                                       <xsl:attribute name="src">Images/Company/<xsl:value-of select="/DATA/PARAM/@companyid"/>/<xsl:value-of select="/DATA/PARAM/@header"/></xsl:attribute>
                                       <xsl:attribute name="border">0</xsl:attribute>
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
                                    <xsl:element name="IMG">
                                       <xsl:attribute name="src">Images/Company/<xsl:value-of select="/DATA/PARAM/@companyid"/>/<xsl:value-of select="/DATA/PARAM/@header"/></xsl:attribute>
                                       <xsl:attribute name="border">0</xsl:attribute>
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
   var UserMenu = new CMenu(UserMenuDef, 'UserMenu'); UserMenu.create();
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
   var UserMenu = new CMenu(UserMenuDef, 'UserMenu'); UserMenu.create();
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
   var UserMenu = new CMenu(UserMenuDef, 'UserMenu'); UserMenu.create();
</xsl:element>

                                       </xsl:element>
                                    </xsl:if>
                                    <xsl:if test="(/DATA/PARAM/@menulogo = '')">
<xsl:element name="SCRIPT">
   <xsl:attribute name="language">JavaScript</xsl:attribute>
   var UserMenu = new CMenu(UserMenuDef, 'UserMenu'); UserMenu.create();
</xsl:element>

                                    </xsl:if>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:if>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">1000</xsl:attribute>
                                 <xsl:attribute name="colspan">2</xsl:attribute>
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
                                    <xsl:attribute name="valign">top</xsl:attribute>
<xsl:element name="SCRIPT">
   <xsl:attribute name="language">JavaScript</xsl:attribute>
   var UserMenu = new CMenu(UserMenuDef, 'UserMenu'); UserMenu.create();
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
                                    <xsl:attribute name="valign">top</xsl:attribute>
<xsl:element name="SCRIPT">
   <xsl:attribute name="language">JavaScript</xsl:attribute>
   var UserMenu = new CMenu(UserMenuDef, 'UserMenu'); UserMenu.create();
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
                                    <xsl:attribute name="valign">top</xsl:attribute>
<xsl:element name="SCRIPT">
   <xsl:attribute name="language">JavaScript</xsl:attribute>
   var UserMenu = new CMenu(UserMenuDef, 'UserMenu'); UserMenu.create();
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
                                    <xsl:element name="IMG">
                                       <xsl:attribute name="src">Images/Company/<xsl:value-of select="/DATA/PARAM/@companyid"/>/<xsl:value-of select="/DATA/PARAM/@header"/></xsl:attribute>
                                       <xsl:attribute name="border">0</xsl:attribute>
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
                                    <xsl:element name="IMG">
                                       <xsl:attribute name="src">Images/Company/<xsl:value-of select="/DATA/PARAM/@companyid"/>/<xsl:value-of select="/DATA/PARAM/@header"/></xsl:attribute>
                                       <xsl:attribute name="border">0</xsl:attribute>
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
                                    <xsl:element name="IMG">
                                       <xsl:attribute name="src">Images/Company/<xsl:value-of select="/DATA/PARAM/@companyid"/>/<xsl:value-of select="/DATA/PARAM/@header"/></xsl:attribute>
                                       <xsl:attribute name="border">0</xsl:attribute>
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
                                 <xsl:attribute name="height">600</xsl:attribute>
                                 <xsl:attribute name="frmheight">600</xsl:attribute>
                                 <xsl:attribute name="id">DashboardFrame</xsl:attribute>
                                 <xsl:attribute name="name">DashboardFrame</xsl:attribute>
                                 <xsl:attribute name="class">FrameNoScroll</xsl:attribute>
                                 <xsl:attribute name="scrolling">no</xsl:attribute>
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
                           <xsl:attribute name="id">TabReward</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">1000</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IFRAME">
                                 <xsl:attribute name="src"></xsl:attribute>
                                 <xsl:attribute name="width">1000</xsl:attribute>
                                 <xsl:attribute name="height">2000</xsl:attribute>
                                 <xsl:attribute name="frmheight">2000</xsl:attribute>
                                 <xsl:attribute name="id">RewardFrame</xsl:attribute>
                                 <xsl:attribute name="name">RewardFrame</xsl:attribute>
                                 <xsl:attribute name="class">FrameNoScroll</xsl:attribute>
                                 <xsl:attribute name="frameborder">0</xsl:attribute>
                                 <xsl:attribute name="onload">ShowFrame('TabReward')</xsl:attribute>
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
   UserMenu.run();
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