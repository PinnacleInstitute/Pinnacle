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
         <xsl:with-param name="pagename" select="'Employee System'"/>
         <xsl:with-param name="includecalendar" select="true()"/>
         <xsl:with-param name="htmleditor"></xsl:with-param>
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
               ShowTab('TabHome',1);
            ]]></xsl:text>;doErrorMsg('<xsl:value-of select="concat($errmsg, $errmsgfld)"/>')</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[
               ShowTab('TabHome',1);
            ]]></xsl:text>;doErrorMsg('<xsl:value-of select="/DATA/ERROR"/>')</xsl:attribute>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
               <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[
               ShowTab('TabHome',1);
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
               <xsl:attribute name="name">Employee</xsl:attribute>
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
               var frame, url, frm, src, page, target='', style='', compare=0, load=0;

               switch(tab) {
               case 'TabHome':
                  frame = 'HomeFrame';
                  switch(shw) {
                     case 1: url = '0204.asp'; load=1; break;
                  } break;
               case 'TabCustomers':
                  frame = 'CustomersFrame';
                  switch(shw) {
                     case 1: url = '3801.asp?contentpage=3'; break;
                     case 2: url = '0401.asp?contentpage=3'; break;
                  } break;
               case 'TabTraining':
                  frame = 'TrainingFrame';
                  switch(shw) {
                     case 1: url = '0301.asp?contentpage=3'; break;
                     case 2: url = '1101.asp?contentpage=3'; break;
                     case 3: url = '3101.asp?contentpage=3'; break;
                  } break;
               case 'TabTools':
                  frame = 'ToolsFrame';
                  switch(shw) {
                     case 1: url = '1020.asp?contentpage=3'; break;
                     case 2: url = '8801.asp?contentpage=3&companyid=-1'; break;
                     case 3: url = '9501.asp?contentpage=3'; break;
                     case 4: url = '0060.asp?contentpage=3'; break;
                     case 5: url = 'Reports.asp?contentpage=3'; break;
                     case 6: url = '9901.asp'; target='Audit'; break;
                  } break;
               case 'TabSetup':
                  frame = 'SetupFrame';
                  switch(shw) {
                     case 1: url = '0003.asp?businessid=1'; break;
                     case 2: url = '0201.asp?contentpage=3'; break;
                     case 3: url = '9101.asp?contentpage=3'; break;
                     case 4: url = '1701.asp?contentpage=3'; break;
                     case 5: url = '6511.asp?contentpage=3'; break;
                  } break;
               case 'TabAccount':
                  frame = 'AccountFrame';
                  switch(shw) {
                     case 1: url = '9211.asp'; break;
                     case 2: url = '0103.asp?contentpage=3&popup=-1'; break;
                     case 3: url = '0106.asp?contentpage=3&popup=-1'; break;
              case 4: url = '0107.asp'; load=1; break;
          } break;
          }
          if( target.length > 0 ) {
                  win = window.open(url,target,style);
                  win.focus();
               }
               else {
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
               document.getElementById('TabHome').style.display = 'none';
               document.getElementById('TabCustomers').style.display = 'none';
               document.getElementById('TabTraining').style.display = 'none';
               document.getElementById('TabTools').style.display = 'none';
               document.getElementById('TabSetup').style.display = 'none';
               document.getElementById('TabAccount').style.display = 'none';
               document.getElementById(tab).style.display = '';
             }]]></xsl:text>
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

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">1000</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor"><xsl:value-of select="/DATA/PARAM/@menubehindcolor"/></xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:attribute name="height">50</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">1000</xsl:attribute>
                              <xsl:attribute name="bgcolor"><xsl:value-of select="/DATA/PARAM/@menubehindcolor"/></xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">middle</xsl:attribute>
                              <xsl:element name="DIV">
                                 <xsl:attribute name="style">float:left</xsl:attribute>
                                 <xsl:element name="IMG">
                                    <xsl:attribute name="src">Images/PinnacleMenuLogo.png</xsl:attribute>
                                    <xsl:attribute name="border">0</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="DIV">
                                 <xsl:attribute name="style">float:right</xsl:attribute>
<xsl:element name="SCRIPT">
   <xsl:attribute name="language">JavaScript</xsl:attribute>
   var EmployeeMenu = new CMenu(EmployeeMenuDef, 'EmployeeMenu'); EmployeeMenu.create();
</xsl:element>

                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">1000</xsl:attribute>
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor"><xsl:value-of select="/DATA/PARAM/@menubehindcolor"/></xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:attribute name="id">TabHome</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">1000</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IFRAME">
                                 <xsl:attribute name="src"></xsl:attribute>
                                 <xsl:attribute name="width">1000</xsl:attribute>
                                 <xsl:attribute name="height">2000</xsl:attribute>
                                 <xsl:attribute name="frmheight">2000</xsl:attribute>
                                 <xsl:attribute name="id">HomeFrame</xsl:attribute>
                                 <xsl:attribute name="name">HomeFrame</xsl:attribute>
                                 <xsl:attribute name="class">FrameNoScroll</xsl:attribute>
                                 <xsl:attribute name="frameborder">0</xsl:attribute>
                                 <xsl:attribute name="onload">ShowFrame('TabHome')</xsl:attribute>
                                 <xsl:element name="A">
                                    <xsl:attribute name="href"></xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoFrameSupport']"/>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:attribute name="id">TabCustomers</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">1000</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IFRAME">
                                 <xsl:attribute name="src"></xsl:attribute>
                                 <xsl:attribute name="width">1000</xsl:attribute>
                                 <xsl:attribute name="height">2000</xsl:attribute>
                                 <xsl:attribute name="frmheight">2000</xsl:attribute>
                                 <xsl:attribute name="id">CustomersFrame</xsl:attribute>
                                 <xsl:attribute name="name">CustomersFrame</xsl:attribute>
                                 <xsl:attribute name="class">FrameNoScroll</xsl:attribute>
                                 <xsl:attribute name="frameborder">0</xsl:attribute>
                                 <xsl:attribute name="onload">ShowFrame('TabCustomers')</xsl:attribute>
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
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">1000</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IFRAME">
                                 <xsl:attribute name="src"></xsl:attribute>
                                 <xsl:attribute name="width">1000</xsl:attribute>
                                 <xsl:attribute name="height">2000</xsl:attribute>
                                 <xsl:attribute name="frmheight">2000</xsl:attribute>
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
                           <xsl:attribute name="id">TabTools</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">1000</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IFRAME">
                                 <xsl:attribute name="src"></xsl:attribute>
                                 <xsl:attribute name="width">1000</xsl:attribute>
                                 <xsl:attribute name="height">2000</xsl:attribute>
                                 <xsl:attribute name="frmheight">2000</xsl:attribute>
                                 <xsl:attribute name="id">ToolsFrame</xsl:attribute>
                                 <xsl:attribute name="name">ToolsFrame</xsl:attribute>
                                 <xsl:attribute name="class">FrameNoScroll</xsl:attribute>
                                 <xsl:attribute name="frameborder">0</xsl:attribute>
                                 <xsl:attribute name="onload">ShowFrame('TabTools')</xsl:attribute>
                                 <xsl:element name="A">
                                    <xsl:attribute name="href"></xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoFrameSupport']"/>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:attribute name="id">TabSetup</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">1000</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IFRAME">
                                 <xsl:attribute name="src"></xsl:attribute>
                                 <xsl:attribute name="width">1000</xsl:attribute>
                                 <xsl:attribute name="height">2000</xsl:attribute>
                                 <xsl:attribute name="frmheight">2000</xsl:attribute>
                                 <xsl:attribute name="id">SetupFrame</xsl:attribute>
                                 <xsl:attribute name="name">SetupFrame</xsl:attribute>
                                 <xsl:attribute name="class">FrameNoScroll</xsl:attribute>
                                 <xsl:attribute name="frameborder">0</xsl:attribute>
                                 <xsl:attribute name="onload">ShowFrame('TabSetup')</xsl:attribute>
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
                              <xsl:attribute name="colspan">2</xsl:attribute>
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
   EmployeeMenu.run();
   ]]></xsl:text>
</xsl:element>

      </xsl:element>
      </xsl:element>
      <!--END BODY-->

      </xsl:element>

   </xsl:template>
</xsl:stylesheet>