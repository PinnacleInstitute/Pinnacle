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
         <xsl:with-param name="pagename" select="'Business Tracker'"/>
         <xsl:with-param name="includecalendar" select="true()"/>
         <xsl:with-param name="htmleditor"></xsl:with-param>
         <xsl:with-param name="viewport">width=device-width</xsl:with-param>
         <xsl:with-param name="translate">google</xsl:with-param>
      </xsl:call-template>

      <!--BEGIN BODY-->
      <xsl:element name="BODY">
         <xsl:attribute name="topmargin">0</xsl:attribute>
         <xsl:attribute name="leftmargin">0</xsl:attribute>
         <xsl:attribute name="background">Images/bg.jpg</xsl:attribute>
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
               ShowTab('Home',1);
            ]]></xsl:text>;doErrorMsg('<xsl:value-of select="concat($errmsg, $errmsgfld)"/>')</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[
               ShowTab('Home',1);
            ]]></xsl:text>;doErrorMsg('<xsl:value-of select="/DATA/ERROR"/>')</xsl:attribute>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
               <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[
               ShowTab('Home',1);
            ]]></xsl:text></xsl:attribute>
            </xsl:otherwise>
         </xsl:choose>

         <!--BEGIN PAGE-->
      <xsl:element name="DIV">
         <xsl:attribute name="id">wrapperMobile</xsl:attribute>
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
               <xsl:attribute name="name">Sims</xsl:attribute>
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
                     <xsl:attribute name="width">100%</xsl:attribute>
                  </xsl:element>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ShowTab(tab, shw){ 
               var mid = document.getElementById('M').value;
               var cid = document.getElementById('C').value;
               var frame, url, frm, src, page, target='', style='', compare=0, load=0;

               switch(tab) {
               case 'TabMarketing':
               frame = 'MarketingFrame';
               switch(shw) {
               case 1: url = 'm_8162.asp?memberid=' + mid; break;
               case 2: url = 'm_8161.asp?memberid=' + mid; break;
               } break;
               case 'TabProductivity':
               frame = 'ProductivityFrame';
               switch(shw) {
               case 1: url = 'm_11702.asp?companyid=' + cid + '&memberid=' + mid; break;
               case 2: url = 'm_11712.asp?companyid=' + cid + '&memberid=' + mid; break;
               case 3: url = 'm_11710.asp?companyid=' + cid + '&memberid=' + mid; break;
               case 4: url = 'm_12610.asp?companyid=' + cid + '&memberid=' + mid; break;
               } break;
               case 'TabFinancial':
               frame = 'FinancialFrame';
               switch(shw) {
               case 1: url = 'm_1022.asp?memberid=' + mid; break;
               case 2: url = 'm_0408.asp?referralid=' + mid; break;
               } break;
               case 'TabAccount':
               frame = 'AccountFrame';
               switch(shw) {
               case 1: url = 'm_0463.asp?memberid=' + mid; break;
               case 2: url = 'm_0436.asp?memberid=' + mid; break;
               case 3: url = 'm_0103.asp?contentpage=3&popup=-1'; break;
               case 4: url = 'm_0106.asp?contentpage=3&popup=-1'; break;
               } break;
               case 'TabHelp':
               frame = 'HelpFrame';
               switch(shw) {
               case 1: url = 'm_1713.asp?companyid=' + cid; break;
               case 2: url = 'm_8013.asp?companyid=' + cid; break;
               case 3: url = 'm_9506.asp?companyid=' + cid; break;
               } break;
               }
               if( target.length > 0 ) {
               win = window.open(url,target,style);
               win.focus();
               }
               else {
               document.getElementById('Home').style.display = 'none';
               document.getElementById('Footer').style.display = '';
               document.getElementById('TabMarketing').style.display = 'none';
               document.getElementById('TabProductivity').style.display = 'none';
               document.getElementById('TabFinancial').style.display = 'none';
               document.getElementById('TabHelp').style.display = 'none';
               document.getElementById('TabAccount').style.display = 'none';
               document.getElementById(tab).style.display = '';
               if( tab == 'Home' ) { document.getElementById('Footer').style.display = 'none'; }

               frm = document.getElementById(frame);
               src = frm.src;
               if( compare == 0 ) { compare = url.indexOf('.') }
               page = url.substring(0,compare);
               if (load == 1 || src.indexOf(page) < 0 ) {
               frm.src = url
               }
               }
             }]]></xsl:text>
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
                              <xsl:attribute name="width">100%</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">M</xsl:attribute>
                              <xsl:attribute name="id">M</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@m"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">C</xsl:attribute>
                              <xsl:attribute name="id">C</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@c"/></xsl:attribute>
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
                           <xsl:attribute name="id">Home</xsl:attribute>
                           <xsl:attribute name="style">background:#eaeaea; height:440px;</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="height">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="height">440</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">20%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">20%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">60%</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:if test="(InStr(reqSysUserOptions,"h") != 0)">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">100%</xsl:attribute>
                                             <xsl:attribute name="colspan">3</xsl:attribute>
                                             <xsl:attribute name="height">1</xsl:attribute>
                                             <xsl:attribute name="bgcolor">#ddd</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:attribute name="height">62</xsl:attribute>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">20%</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="src">Images/m_Contact.gif</xsl:attribute>
                                                <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="width">80%</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:attribute name="class">BigHeading</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Contacts']"/>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">100%</xsl:attribute>
                                             <xsl:attribute name="colspan">3</xsl:attribute>
                                             <xsl:attribute name="height">1</xsl:attribute>
                                             <xsl:attribute name="bgcolor">#ddd</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:attribute name="height">50</xsl:attribute>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">20%</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">20%</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="src">Images/m_ContactAdd.gif</xsl:attribute>
                                                <xsl:attribute name="width">48</xsl:attribute>
                                                <xsl:attribute name="height">48</xsl:attribute>
                                                <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">60%</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:attribute name="class">MenuHeading</xsl:attribute>
                                             <xsl:element name="A">
                                                <xsl:attribute name="href">#_</xsl:attribute>
                                                <xsl:attribute name="onclick">ShowTab('TabMarketing', 1)</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AddContact']"/>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">100%</xsl:attribute>
                                             <xsl:attribute name="colspan">3</xsl:attribute>
                                             <xsl:attribute name="height">1</xsl:attribute>
                                             <xsl:attribute name="bgcolor">#ddd</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:attribute name="height">50</xsl:attribute>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">20%</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">20%</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="src">Images/m_Contact.gif</xsl:attribute>
                                                <xsl:attribute name="width">48</xsl:attribute>
                                                <xsl:attribute name="height">48</xsl:attribute>
                                                <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">60%</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:attribute name="class">MenuHeading</xsl:attribute>
                                             <xsl:element name="A">
                                                <xsl:attribute name="href">#_</xsl:attribute>
                                                <xsl:attribute name="onclick">ShowTab('TabMarketing', 2)</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewContacts']"/>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                    </xsl:if>
                                    <xsl:if test="(InStr(reqSysUserOptions,"l") != 0)">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">100%</xsl:attribute>
                                             <xsl:attribute name="colspan">3</xsl:attribute>
                                             <xsl:attribute name="height">1</xsl:attribute>
                                             <xsl:attribute name="bgcolor">#ddd</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:attribute name="height">62</xsl:attribute>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">20%</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="src">Images/m_Activities.gif</xsl:attribute>
                                                <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="width">80%</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:attribute name="class">BigHeading</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Activities']"/>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">100%</xsl:attribute>
                                             <xsl:attribute name="colspan">3</xsl:attribute>
                                             <xsl:attribute name="height">1</xsl:attribute>
                                             <xsl:attribute name="bgcolor">#ddd</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:attribute name="height">50</xsl:attribute>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">20%</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">20%</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="src">Images/m_ActivitiesAdd.gif</xsl:attribute>
                                                <xsl:attribute name="width">48</xsl:attribute>
                                                <xsl:attribute name="height">48</xsl:attribute>
                                                <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">60%</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:attribute name="class">MenuHeading</xsl:attribute>
                                             <xsl:element name="A">
                                                <xsl:attribute name="href">#_</xsl:attribute>
                                                <xsl:attribute name="onclick">ShowTab('TabProductivity', 1)</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LogActivity']"/>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">100%</xsl:attribute>
                                             <xsl:attribute name="colspan">3</xsl:attribute>
                                             <xsl:attribute name="height">1</xsl:attribute>
                                             <xsl:attribute name="bgcolor">#ddd</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:attribute name="height">50</xsl:attribute>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">20%</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">20%</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="src">Images/m_Activities.gif</xsl:attribute>
                                                <xsl:attribute name="width">48</xsl:attribute>
                                                <xsl:attribute name="height">48</xsl:attribute>
                                                <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">60%</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:attribute name="class">MenuHeading</xsl:attribute>
                                             <xsl:element name="A">
                                                <xsl:attribute name="href">#_</xsl:attribute>
                                                <xsl:attribute name="onclick">ShowTab('TabProductivity', 2)</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Statistics']"/>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">100%</xsl:attribute>
                                             <xsl:attribute name="colspan">3</xsl:attribute>
                                             <xsl:attribute name="height">1</xsl:attribute>
                                             <xsl:attribute name="bgcolor">#ddd</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:attribute name="height">50</xsl:attribute>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">20%</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">20%</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="src">Images/m_LeaderBoard.gif</xsl:attribute>
                                                <xsl:attribute name="width">48</xsl:attribute>
                                                <xsl:attribute name="height">48</xsl:attribute>
                                                <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">60%</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:attribute name="class">MenuHeading</xsl:attribute>
                                             <xsl:element name="A">
                                                <xsl:attribute name="href">#_</xsl:attribute>
                                                <xsl:attribute name="onclick">ShowTab('TabProductivity', 3)</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LeaderBoard']"/>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:if test="(InStr(reqSysUserOptions,"*") != 0)">
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">100%</xsl:attribute>
                                                <xsl:attribute name="colspan">3</xsl:attribute>
                                                <xsl:attribute name="height">1</xsl:attribute>
                                                <xsl:attribute name="bgcolor">#ddd</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>

                                          <xsl:element name="TR">
                                             <xsl:attribute name="height">50</xsl:attribute>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">20%</xsl:attribute>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">20%</xsl:attribute>
                                                <xsl:attribute name="align">center</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/m_Contest.gif</xsl:attribute>
                                                   <xsl:attribute name="width">48</xsl:attribute>
                                                   <xsl:attribute name="height">48</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">60%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:attribute name="class">MenuHeading</xsl:attribute>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">#_</xsl:attribute>
                                                   <xsl:attribute name="onclick">ShowTab('TabProductivity', 4)</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewContests']"/>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:element>

                                       </xsl:if>
                                    </xsl:if>
                                    <xsl:if test="(InStr(reqSysUserOptions,"w") != 0)">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">100%</xsl:attribute>
                                             <xsl:attribute name="colspan">3</xsl:attribute>
                                             <xsl:attribute name="height">1</xsl:attribute>
                                             <xsl:attribute name="bgcolor">#ddd</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:attribute name="height">62</xsl:attribute>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">20%</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="src">Images/m_Finance.gif</xsl:attribute>
                                                <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="width">80%</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:attribute name="class">BigHeading</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Finances']"/>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:if test="(InStr(reqSysUserOptions,"V") != 0)">
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">100%</xsl:attribute>
                                                <xsl:attribute name="colspan">3</xsl:attribute>
                                                <xsl:attribute name="height">1</xsl:attribute>
                                                <xsl:attribute name="bgcolor">#ddd</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>

                                          <xsl:element name="TR">
                                             <xsl:attribute name="height">50</xsl:attribute>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">20%</xsl:attribute>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">20%</xsl:attribute>
                                                <xsl:attribute name="align">center</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/m_CreditCard.gif</xsl:attribute>
                                                   <xsl:attribute name="width">48</xsl:attribute>
                                                   <xsl:attribute name="height">48</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">60%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:attribute name="class">MenuHeading</xsl:attribute>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">#_</xsl:attribute>
                                                   <xsl:attribute name="onclick">ShowTab('TabFinancial', 1)</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Payments']"/>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:element>

                                       </xsl:if>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">100%</xsl:attribute>
                                             <xsl:attribute name="colspan">3</xsl:attribute>
                                             <xsl:attribute name="height">1</xsl:attribute>
                                             <xsl:attribute name="bgcolor">#ddd</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:attribute name="height">50</xsl:attribute>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">20%</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">20%</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="src">Images/m_Genealogy.gif</xsl:attribute>
                                                <xsl:attribute name="width">48</xsl:attribute>
                                                <xsl:attribute name="height">48</xsl:attribute>
                                                <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">60%</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:attribute name="class">MenuHeading</xsl:attribute>
                                             <xsl:element name="A">
                                                <xsl:attribute name="href">#_</xsl:attribute>
                                                <xsl:attribute name="onclick">ShowTab('TabFinancial', 2)</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Referrals']"/>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                    </xsl:if>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">100%</xsl:attribute>
                                          <xsl:attribute name="colspan">3</xsl:attribute>
                                          <xsl:attribute name="height">1</xsl:attribute>
                                          <xsl:attribute name="bgcolor">#ddd</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="height">62</xsl:attribute>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">20%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/m_Member.gif</xsl:attribute>
                                             <xsl:attribute name="align">absmiddle</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">2</xsl:attribute>
                                          <xsl:attribute name="width">80%</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">BigHeading</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Account']"/>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:if test="(InStr(reqSysUserOptions,"I") != 0)">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">100%</xsl:attribute>
                                             <xsl:attribute name="colspan">3</xsl:attribute>
                                             <xsl:attribute name="height">1</xsl:attribute>
                                             <xsl:attribute name="bgcolor">#ddd</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:attribute name="height">50</xsl:attribute>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">20%</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">20%</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="src">Images/m_Member.gif</xsl:attribute>
                                                <xsl:attribute name="width">48</xsl:attribute>
                                                <xsl:attribute name="height">48</xsl:attribute>
                                                <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">60%</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:attribute name="class">MenuHeading</xsl:attribute>
                                             <xsl:element name="A">
                                                <xsl:attribute name="href">#_</xsl:attribute>
                                                <xsl:attribute name="onclick">ShowTab('TabAccount', 1)</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Profile']"/>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                    </xsl:if>
                                    <xsl:if test="(InStr(reqSysUserOptions,"V") != 0)">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">100%</xsl:attribute>
                                             <xsl:attribute name="colspan">3</xsl:attribute>
                                             <xsl:attribute name="height">1</xsl:attribute>
                                             <xsl:attribute name="bgcolor">#ddd</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:attribute name="height">50</xsl:attribute>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">20%</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">20%</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="src">Images/m_CreditCard.gif</xsl:attribute>
                                                <xsl:attribute name="width">48</xsl:attribute>
                                                <xsl:attribute name="height">48</xsl:attribute>
                                                <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">60%</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:attribute name="class">MenuHeading</xsl:attribute>
                                             <xsl:element name="A">
                                                <xsl:attribute name="href">#_</xsl:attribute>
                                                <xsl:attribute name="onclick">ShowTab('TabAccount', 2)</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BillingMethod']"/>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                    </xsl:if>
                                    <xsl:if test="(/DATA/SYSTEM/@usergroup != 1)">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">100%</xsl:attribute>
                                             <xsl:attribute name="colspan">3</xsl:attribute>
                                             <xsl:attribute name="height">1</xsl:attribute>
                                             <xsl:attribute name="bgcolor">#ddd</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:attribute name="height">50</xsl:attribute>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">20%</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">20%</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="src">Images/m_Logon.gif</xsl:attribute>
                                                <xsl:attribute name="width">48</xsl:attribute>
                                                <xsl:attribute name="height">48</xsl:attribute>
                                                <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">60%</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:attribute name="class">MenuHeading</xsl:attribute>
                                             <xsl:element name="A">
                                                <xsl:attribute name="href">#_</xsl:attribute>
                                                <xsl:attribute name="onclick">ShowTab('TabAccount', 3)</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ChangeLogon']"/>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                    </xsl:if>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">100%</xsl:attribute>
                                          <xsl:attribute name="colspan">3</xsl:attribute>
                                          <xsl:attribute name="height">1</xsl:attribute>
                                          <xsl:attribute name="bgcolor">#ddd</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="height">50</xsl:attribute>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">20%</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">20%</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/m_Logon.gif</xsl:attribute>
                                             <xsl:attribute name="width">48</xsl:attribute>
                                             <xsl:attribute name="height">48</xsl:attribute>
                                             <xsl:attribute name="align">absmiddle</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">60%</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">MenuHeading</xsl:attribute>
                                          <xsl:element name="A">
                                             <xsl:attribute name="href">#_</xsl:attribute>
                                             <xsl:attribute name="onclick">ShowTab('TabAccount', 4)</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ChangePassword']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:if test="(InStr(reqSysUserOptions,"S") != 0) or (InStr(reqSysUserOptions,"R") != 0) or (InStr(reqSysUserOptions,"m") != 0)">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">100%</xsl:attribute>
                                             <xsl:attribute name="colspan">3</xsl:attribute>
                                             <xsl:attribute name="height">1</xsl:attribute>
                                             <xsl:attribute name="bgcolor">#ddd</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:attribute name="height">62</xsl:attribute>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">20%</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="src">Images/m_Help.gif</xsl:attribute>
                                                <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="width">80%</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:attribute name="class">BigHeading</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Help']"/>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:if test="(InStr(reqSysUserOptions,"S") != 0)">
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">100%</xsl:attribute>
                                                <xsl:attribute name="colspan">3</xsl:attribute>
                                                <xsl:attribute name="height">1</xsl:attribute>
                                                <xsl:attribute name="bgcolor">#ddd</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>

                                          <xsl:element name="TR">
                                             <xsl:attribute name="height">50</xsl:attribute>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">20%</xsl:attribute>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">20%</xsl:attribute>
                                                <xsl:attribute name="align">center</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/m_Help2.gif</xsl:attribute>
                                                   <xsl:attribute name="width">48</xsl:attribute>
                                                   <xsl:attribute name="height">48</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">60%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:attribute name="class">MenuHeading</xsl:attribute>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">#_</xsl:attribute>
                                                   <xsl:attribute name="onclick">ShowTab('TabHelp', 1)</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FAQ']"/>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:element>

                                       </xsl:if>
                                       <xsl:if test="(InStr(reqSysUserOptions,"R") != 0)">
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">100%</xsl:attribute>
                                                <xsl:attribute name="colspan">3</xsl:attribute>
                                                <xsl:attribute name="height">1</xsl:attribute>
                                                <xsl:attribute name="bgcolor">#ddd</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>

                                          <xsl:element name="TR">
                                             <xsl:attribute name="height">50</xsl:attribute>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">20%</xsl:attribute>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">20%</xsl:attribute>
                                                <xsl:attribute name="align">center</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/m_Docs.gif</xsl:attribute>
                                                   <xsl:attribute name="width">48</xsl:attribute>
                                                   <xsl:attribute name="height">48</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">60%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:attribute name="class">MenuHeading</xsl:attribute>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">#_</xsl:attribute>
                                                   <xsl:attribute name="onclick">ShowTab('TabHelp', 2)</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Docs']"/>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:element>

                                       </xsl:if>
                                       <xsl:if test="(InStr(reqSysUserOptions,"m") != 0)">
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">100%</xsl:attribute>
                                                <xsl:attribute name="colspan">3</xsl:attribute>
                                                <xsl:attribute name="height">1</xsl:attribute>
                                                <xsl:attribute name="bgcolor">#ddd</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>

                                          <xsl:element name="TR">
                                             <xsl:attribute name="height">50</xsl:attribute>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">20%</xsl:attribute>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">20%</xsl:attribute>
                                                <xsl:attribute name="align">center</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/m_SupportTicket.gif</xsl:attribute>
                                                   <xsl:attribute name="width">48</xsl:attribute>
                                                   <xsl:attribute name="height">48</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">60%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:attribute name="class">MenuHeading</xsl:attribute>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">#_</xsl:attribute>
                                                   <xsl:attribute name="onclick">ShowTab('TabHelp', 3)</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Tickets']"/>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:element>

                                       </xsl:if>
                                    </xsl:if>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:attribute name="id">TabMarketing</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IFRAME">
                                 <xsl:attribute name="src"></xsl:attribute>
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="height">440</xsl:attribute>
                                 <xsl:attribute name="frmheight">440</xsl:attribute>
                                 <xsl:attribute name="id">MarketingFrame</xsl:attribute>
                                 <xsl:attribute name="name">MarketingFrame</xsl:attribute>
                                 <xsl:attribute name="frameborder">0</xsl:attribute>
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
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IFRAME">
                                 <xsl:attribute name="src"></xsl:attribute>
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="height">440</xsl:attribute>
                                 <xsl:attribute name="frmheight">440</xsl:attribute>
                                 <xsl:attribute name="id">ProductivityFrame</xsl:attribute>
                                 <xsl:attribute name="name">ProductivityFrame</xsl:attribute>
                                 <xsl:attribute name="frameborder">0</xsl:attribute>
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
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IFRAME">
                                 <xsl:attribute name="src"></xsl:attribute>
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="height">440</xsl:attribute>
                                 <xsl:attribute name="frmheight">440</xsl:attribute>
                                 <xsl:attribute name="id">FinancialFrame</xsl:attribute>
                                 <xsl:attribute name="name">FinancialFrame</xsl:attribute>
                                 <xsl:attribute name="frameborder">0</xsl:attribute>
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
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IFRAME">
                                 <xsl:attribute name="src"></xsl:attribute>
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="height">440</xsl:attribute>
                                 <xsl:attribute name="frmheight">440</xsl:attribute>
                                 <xsl:attribute name="id">HelpFrame</xsl:attribute>
                                 <xsl:attribute name="name">HelpFrame</xsl:attribute>
                                 <xsl:attribute name="frameborder">0</xsl:attribute>
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
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IFRAME">
                                 <xsl:attribute name="src"></xsl:attribute>
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="height">440</xsl:attribute>
                                 <xsl:attribute name="frmheight">440</xsl:attribute>
                                 <xsl:attribute name="id">AccountFrame</xsl:attribute>
                                 <xsl:attribute name="name">AccountFrame</xsl:attribute>
                                 <xsl:attribute name="frameborder">0</xsl:attribute>
                                 <xsl:element name="A">
                                    <xsl:attribute name="href"></xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoFrameSupport']"/>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:attribute name="id">Footer</xsl:attribute>
                           <xsl:attribute name="style">background:#666;</xsl:attribute>
                           <xsl:attribute name="height">42</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100%</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">middle</xsl:attribute>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">button</xsl:attribute>
                                 <xsl:attribute name="class">bigbutton</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Home']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[ShowTab('Home',false);]]></xsl:text></xsl:attribute>
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