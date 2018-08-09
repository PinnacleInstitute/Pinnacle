<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
   <xsl:include href="HTMLHeading.xsl"/>
   <xsl:include href="Bookmark.xsl"/>
   <xsl:include href="Include\wtSystem.xsl"/>
   <xsl:include href="Include\wtTab.xsl"/>
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
         <xsl:with-param name="pagename" select="'Prospect'"/>
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
         <xsl:attribute name="src">Include/codethattabpro.js</xsl:attribute>
         <xsl:text> </xsl:text>
      </xsl:element>

      <xsl:call-template name="DefineTab"/>

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
                     <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[
               ShowTab('TabSalesSteps',0);
            ]]></xsl:text>;doErrorMsg('<xsl:value-of select="concat($errmsg, $errmsgfld)"/>')</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[
               ShowTab('TabSalesSteps',0);
            ]]></xsl:text>;doErrorMsg('<xsl:value-of select="/DATA/ERROR"/>')</xsl:attribute>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
               <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[
               ShowTab('TabSalesSteps',0);
            ]]></xsl:text></xsl:attribute>
            </xsl:otherwise>
         </xsl:choose>

         <!--BEGIN PAGE-->
      <xsl:element name="DIV">
         <xsl:attribute name="id">wrapper600</xsl:attribute>
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
               <xsl:attribute name="name">Prospect</xsl:attribute>
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
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ViewDrip(){ 
               var url, win, id;
               id = document.getElementById('ProspectID').value;
               url = "11611.asp?target=2&targetid=" + id
               win = window.open(url,"DripCampaigns","top=100,left=100,height=200,width=525,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no");
               win.focus();
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function EditExtra(){ 
               var url, win, height;
               url = "8155.asp?prospecttypeid=" + document.getElementById('ProspectTypeID').value + "&prospectid=" + document.getElementById('ProspectID').value
               height = document.getElementById('Extra').value
                  win = window.open(url,"ExtraInfo","top=100,left=100,height=" + height + ",width=425,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no,scrollbars=1");
               win.focus();
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ViewForms(){ 
               var url, win;
               url = "9311.asp?companyid=" + document.getElementById('CompanyID').value + "&prospectid=" + document.getElementById('ProspectID').value
                  win = window.open(url,"Forms","top=100,left=100,height=300,width=425,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no,scrollbars=1");
               win.focus();
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ViewPages(id, pages){ 
               var url, win;
               url = "1507.asp?LeadCampaignID=" + id + "&Pages=" + pages
                  win = window.open(url,"ViewPages","top=100,left=100,height=300,width=350,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no");
               win.focus();
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ShowTab(tab, shw){ 
               document.getElementById('TabSalesSteps').style.display = 'none';
               document.getElementById('TabContactInfo').style.display = 'none';
               document.getElementById('TabDescription').style.display = 'none';
               document.getElementById('TabNotes').style.display = 'none';
               document.getElementById('TabEvents').style.display = 'none';
               document.getElementById('TabMail').style.display = 'none';
               document.getElementById('TabDocuments').style.display = 'none';
               document.getElementById(tab).style.display = '';
               if (shw > 0) {
                  content = window.document.getElementById('ProspectName');
                  if(content)
                     content.scrollIntoView();
               }   
               if ( tab == 'TabNotes' ) {
                  var src = document.getElementById('NotesFrame').src
                  if (src.indexOf("9011") < 0 ) {
                     var id = document.getElementById('ProspectID').value
                     var title = document.getElementById('ProspectName').value
                     src = '9011.asp?Height=400&OwnerType=81&OwnerID=' + id + '&Title=' + title
                     document.getElementById('NotesFrame').src = src
                  }   
               }   
               if ( tab == 'TabEvents' ) {
                  var src = document.getElementById('EventsFrame').src
                  if (src.indexOf("9611") < 0 ) {
                     var id = document.getElementById('ProspectID').value
                     src = '9611.asp?OwnerType=81&OwnerID=' + id 
                     document.getElementById('EventsFrame').src = src
                  }   
               }   
               if ( tab == 'TabMail' ) {
                  var mail = document.getElementById('IsMail').value
                  if (mail != 0 ) {
                     var src = document.getElementById('MailFrame').src
                     if (src.indexOf("0513") < 0 ) {
                        var pid = document.getElementById('ProspectID').value
                        var cid = document.getElementById('CompanyID').value
                        var mid = document.getElementById('MemberID').value
                        src = '0513.asp?OwnerType=81&OwnerID=' + pid + '&CompanyID=' + cid + '&MemberID=' + mid
                        document.getElementById('MailFrame').src = src
                     }   
                  }   
               }
               if ( tab == 'TabDocuments' ) {
                  var src = document.getElementById('DocumentsFrame').src
                  if (src.indexOf("8014") < 0 ) {
                     var id = document.getElementById('ProspectID').value
                     var move = document.getElementById('Move').value
                     src = '8014.asp?ParentType=81&ProspectID=' + id + '&MoveParent=' + move
                     document.getElementById('DocumentsFrame').src = src
                  }   
               }
              }]]></xsl:text>
               </xsl:element>

               <xsl:element name="TR">

                  <xsl:element name="TD">
                     <xsl:attribute name="width">10</xsl:attribute>
                  </xsl:element>

                  <xsl:element name="TD">
                     <xsl:attribute name="valign">top</xsl:attribute>
                     <xsl:attribute name="width">600</xsl:attribute>

                     <xsl:element name="TABLE">
                        <xsl:attribute name="border">0</xsl:attribute>
                        <xsl:attribute name="cellpadding">0</xsl:attribute>
                        <xsl:attribute name="cellspacing">0</xsl:attribute>
                        <xsl:attribute name="width">600</xsl:attribute>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">160</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">ProspectID</xsl:attribute>
                              <xsl:attribute name="id">ProspectID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@prospectid"/></xsl:attribute>
                           </xsl:element>

                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">ProspectID</xsl:attribute>
                              <xsl:attribute name="id">ProspectID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@prospectid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">SalesCampaignID</xsl:attribute>
                              <xsl:attribute name="id">SalesCampaignID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@salescampaignid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">LeadCampaignID</xsl:attribute>
                              <xsl:attribute name="id">LeadCampaignID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@leadcampaignid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">LeadPages</xsl:attribute>
                              <xsl:attribute name="id">LeadPages</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@leadpages"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">PresentID</xsl:attribute>
                              <xsl:attribute name="id">PresentID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@presentid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">PresentPages</xsl:attribute>
                              <xsl:attribute name="id">PresentPages</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@presentpages"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">IsMail</xsl:attribute>
                              <xsl:attribute name="id">IsMail</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@ismail"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Extra</xsl:attribute>
                              <xsl:attribute name="id">Extra</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@extra"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Move</xsl:attribute>
                              <xsl:attribute name="id">Move</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@move"/></xsl:attribute>
                           </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">380</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">220</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">380</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">PageHeading</xsl:attribute>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="src">Images/Prospect32.gif</xsl:attribute>
                                                <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/TXN/PTSPROSPECT/@prospectname"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                          <xsl:if test="(/DATA/SYSTEM/@usergroup != 41) or (contains(/DATA/SYSTEM/@useroptions, 's'))">
                                                <xsl:element name="A">
                                                   <xsl:attribute name="onclick">w=window.open(this.href,"shortcut","width=400, height=150");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                   <xsl:attribute name="href">9202.asp?EntityID=81&amp;ItemID=<xsl:value-of select="/DATA/TXN/PTSPROSPECT/@prospectid"/>&amp;Name=<xsl:value-of select="translate(/DATA/TXN/PTSPROSPECT/@prospectname,'&amp;',' ')"/>&amp;URL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/Shortcut.gif</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSPROSPECT/@code != 0)">
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:if test="(/DATA/TXN/PTSPROSPECT/@code &gt; 0)">
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="color">green</xsl:attribute>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Approved']"/>
                                                   </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(/DATA/TXN/PTSPROSPECT/@code &lt; 0)">
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="color">red</xsl:attribute>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Disapproved']"/>
                                                   </xsl:element>
                                                </xsl:if>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/SYSTEM/@usergroup = 41)">
                                                <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">hidden</xsl:attribute>
                                                   <xsl:attribute name="name">Code</xsl:attribute>
                                                   <xsl:attribute name="id">Code</xsl:attribute>
                                                   <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@code"/></xsl:attribute>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/SYSTEM/@usergroup != 41)">
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">text</xsl:attribute>
                                                <xsl:attribute name="name">Code</xsl:attribute>
                                                <xsl:attribute name="id">Code</xsl:attribute>
                                                <xsl:attribute name="size">1</xsl:attribute>
                                                <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@code"/></xsl:attribute>
                                                </xsl:element>
                                          </xsl:if>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">220</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:if test="(/DATA/SYSTEM/@userstatus = 1)">
                                                <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">button</xsl:attribute>
                                                   <xsl:attribute name="class">smbutton</xsl:attribute>
                                                   <xsl:attribute name="value">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Update']"/>
                                                   </xsl:attribute>
                                                   <xsl:attribute name="onclick">doSubmit(1,"")</xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/SYSTEM/@userstatus = 1) and (/DATA/PARAM/@popup = 0)">
                                                <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">button</xsl:attribute>
                                                   <xsl:attribute name="class">smbutton</xsl:attribute>
                                                   <xsl:attribute name="value">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='UpdateExit']"/>
                                                   </xsl:attribute>
                                                   <xsl:attribute name="onclick">doSubmit(2,"")</xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/PARAM/@popup = 0)">
                                                <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">button</xsl:attribute>
                                                   <xsl:attribute name="class">smbutton</xsl:attribute>
                                                   <xsl:attribute name="value">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Cancel']"/>
                                                   </xsl:attribute>
                                                   <xsl:attribute name="onclick">doSubmit(3,"")</xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
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
                                             <xsl:element name="BR"/>
                                          <xsl:if test="(/DATA/TXN/PTSPROSPECT/@status = 4)">
                                             <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23) or (/DATA/SYSTEM/@usergroup = 51) or (/DATA/SYSTEM/@usergroup = 52) or (contains(/DATA/SYSTEM/@useroptions, '6'))">
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="onclick">w=window.open(this.href,"Customer","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                      <xsl:attribute name="href">8153.asp?ProspectID=<xsl:value-of select="/DATA/TXN/PTSPROSPECT/@prospectid"/>&amp;ContentPage=3&amp;Popup=1</xsl:attribute>
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/Customersm.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                             </xsl:if>
                                          </xsl:if>
                                       </xsl:element>
                                    </xsl:element>

                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#000000</xsl:attribute>
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
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">top</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="height">17</xsl:attribute>
                                          <xsl:attribute name="bgcolor">#D8EEFB</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">middle</xsl:attribute>
                                          <xsl:element name="font">
                                             <xsl:attribute name="color">blue</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Prospect']"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ID']"/>
                                             <xsl:value-of select="/DATA/TXN/PTSPROSPECT/@prospectid"/>
                                             <xsl:if test="(/DATA/TXN/PTSPROSPECT/@salescampaignname != '')">
                                                (<xsl:value-of select="/DATA/TXN/PTSPROSPECT/@salescampaignname"/>)
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSPROSPECT/@prospecttypename != '')">
                                                (<xsl:value-of select="/DATA/TXN/PTSPROSPECT/@prospecttypename"/>)
                                             </xsl:if>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Since']"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/TXN/PTSPROSPECT/@createdate"/>
                                          <xsl:if test="(/DATA/TXN/PTSPROSPECT/@memberid != /DATA/SYSTEM/@memberid)">
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='for']"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/TXN/PTSPROSPECT/@membername"/>
                                          </xsl:if>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                              </xsl:element>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">3</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/PARAM/@ismail = 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">3</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">1</xsl:attribute>
                                 <xsl:attribute name="bgcolor">#004080</xsl:attribute>
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
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="height">18</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="b">
                                 <xsl:element name="font">
                                    <xsl:attribute name="color">red</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ValidEmail']"/>
                                 </xsl:element>
                                 </xsl:element>
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
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">1</xsl:attribute>
                                 <xsl:attribute name="bgcolor">#004080</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">3</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23) or (/DATA/SYSTEM/@usergroup = 51) or (/DATA/SYSTEM/@usergroup = 52)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">160</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MemberID']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">MemberID</xsl:attribute>
                                 <xsl:attribute name="id">MemberID</xsl:attribute>
                                 <xsl:attribute name="size">3</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@memberid"/></xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:if test="(/DATA/TXN/PTSPROSPECT/@memberid != 0)">
                                    <xsl:element name="A">
                                       <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                       <xsl:attribute name="onclick">w=window.open(this.href,"Member","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                       <xsl:attribute name="href">0403.asp?MemberID=<xsl:value-of select="/DATA/TXN/PTSPROSPECT/@memberid"/>&amp;Popup=1</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MemberID']"/>
                                    </xsl:element>
                                 </xsl:if>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">160</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AffiliateID']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">AffiliateID</xsl:attribute>
                                 <xsl:attribute name="id">AffiliateID</xsl:attribute>
                                 <xsl:attribute name="size">3</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@affiliateid"/></xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:if test="(/DATA/TXN/PTSPROSPECT/@affiliateid != 0)">
                                    <xsl:element name="A">
                                       <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                       <xsl:attribute name="onclick">w=window.open(this.href,"Affiliate","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                       <xsl:attribute name="href">0603.asp?AffiliateID=<xsl:value-of select="/DATA/TXN/PTSPROSPECT/@affiliateid"/>&amp;Popup=1</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AffiliateID']"/>
                                    </xsl:element>
                                 </xsl:if>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/SYSTEM/@usergroup &gt; 23) and (/DATA/SYSTEM/@usergroup != 51) and (/DATA/SYSTEM/@usergroup != 52)">
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">MemberID</xsl:attribute>
                              <xsl:attribute name="id">MemberID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@memberid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">AffiliateID</xsl:attribute>
                              <xsl:attribute name="id">AffiliateID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@affiliateid"/></xsl:attribute>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">160</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CompanyID']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">CompanyID</xsl:attribute>
                                 <xsl:attribute name="id">CompanyID</xsl:attribute>
                                 <xsl:attribute name="size">3</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@companyid"/></xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:if test="(/DATA/TXN/PTSPROSPECT/@companyid != 0)">
                                    <xsl:element name="A">
                                       <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                       <xsl:attribute name="href">3803.asp?CompanyID=<xsl:value-of select="/DATA/TXN/PTSPROSPECT/@companyid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CompanyID']"/>
                                    </xsl:element>
                                 </xsl:if>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="(/DATA/SYSTEM/@usergroup &gt; 23)">
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">CompanyID</xsl:attribute>
                              <xsl:attribute name="id">CompanyID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@companyid"/></xsl:attribute>
                           </xsl:element>
                        </xsl:if>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">160</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Name']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">ProspectName</xsl:attribute>
                              <xsl:attribute name="id">ProspectName</xsl:attribute>
                              <xsl:attribute name="size">60</xsl:attribute>
                              <xsl:attribute name="maxlength">60</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@prospectname"/></xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                              <xsl:element name="IMG">
                                 <xsl:attribute name="src">Images/Required.gif</xsl:attribute>
                                 <xsl:attribute name="alt">Required Field</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">160</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ProspectTypeID']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="SELECT">
                                 <xsl:attribute name="name">ProspectTypeID</xsl:attribute>
                                 <xsl:attribute name="id">ProspectTypeID</xsl:attribute>
                                 <xsl:for-each select="/DATA/TXN/PTSPROSPECTTYPES/ENUM">
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                       <xsl:if test="@selected"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="@name"/>
                                    </xsl:element>
                                 </xsl:for-each>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Potential']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">Potential</xsl:attribute>
                              <xsl:attribute name="id">Potential</xsl:attribute>
                              <xsl:attribute name="size">10</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@potential"/></xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">160</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Representing']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">Representing</xsl:attribute>
                              <xsl:attribute name="id">Representing</xsl:attribute>
                              <xsl:attribute name="size">18</xsl:attribute>
                              <xsl:attribute name="maxlength">20</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@representing"/></xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Priority']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">Priority</xsl:attribute>
                              <xsl:attribute name="id">Priority</xsl:attribute>
                              <xsl:attribute name="size">2</xsl:attribute>
                              <xsl:attribute name="maxlength">4</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@priority"/></xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Source']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">Source</xsl:attribute>
                              <xsl:attribute name="id">Source</xsl:attribute>
                              <xsl:attribute name="size">18</xsl:attribute>
                              <xsl:attribute name="maxlength">20</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@source"/></xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">160</xsl:attribute>
                              <xsl:attribute name="height">24</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SalesCampaignName']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="b">
                                 <xsl:if test="(/DATA/TXN/PTSPROSPECT/@salescampaignid != 0)">
                                    <xsl:value-of select="/DATA/TXN/PTSPROSPECT/@salescampaignname"/>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/TXN/PTSPROSPECT/@salescampaignid = 0)">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='None']"/>
                                 </xsl:if>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">button</xsl:attribute>
                                 <xsl:attribute name="class">smbutton</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Change']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick">doSubmit(5,"")</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/PARAM/@ismail != 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">3</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">600</xsl:attribute>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">298</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">4</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">298</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">298</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:element name="TABLE">
                                                <xsl:attribute name="border">0</xsl:attribute>
                                                <xsl:attribute name="cellpadding">0</xsl:attribute>
                                                <xsl:attribute name="cellspacing">0</xsl:attribute>
                                                <xsl:attribute name="width">298</xsl:attribute>
                                                <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>

                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">298</xsl:attribute>
                                                         <xsl:attribute name="align">center</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">298</xsl:attribute>
                                                         <xsl:attribute name="height">18</xsl:attribute>
                                                         <xsl:attribute name="bgcolor">#D8EEFB</xsl:attribute>
                                                         <xsl:attribute name="align">center</xsl:attribute>
                                                         <xsl:attribute name="valign">middle</xsl:attribute>
                                                            <xsl:element name="b">
                                                            <xsl:element name="font">
                                                               <xsl:attribute name="color">darkblue</xsl:attribute>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LeadWebsite']"/>
                                                            </xsl:element>
                                                            </xsl:element>
                                                            <xsl:if test="(/DATA/TXN/PTSPROSPECT/@leadcampaignid != 0)">
                                                                (#<xsl:value-of select="/DATA/TXN/PTSPROSPECT/@leadcampaignid"/>)
                                                            </xsl:if>
                                                      </xsl:element>
                                                   </xsl:element>

                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">298</xsl:attribute>
                                                         <xsl:attribute name="align">center</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                            <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, 'Z')) or (/DATA/SYSTEM/@usergroup &lt;= 23)">
                                                               <xsl:element name="font">
                                                                  <xsl:attribute name="color">blue</xsl:attribute>
                                                            <xsl:if test="(/DATA/TXN/PTSPROSPECT/@leadcampaignid != 0)">
                                                                  <xsl:element name="b">
                                                                  <xsl:value-of select="/DATA/PARAM/@leadname" disable-output-escaping="yes"/>
                                                                  </xsl:element>
                                                                  <xsl:element name="BR"/>
                                                                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LeadViews']"/>
                                                                  <xsl:text>:</xsl:text>
                                                                  <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                                  <xsl:element name="b">
                                                                  <xsl:value-of select="/DATA/TXN/PTSPROSPECT/@leadviews"/>
                                                                  </xsl:element>
                                                                  <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LeadReplies']"/>
                                                                  <xsl:text>:</xsl:text>
                                                                  <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                                  <xsl:element name="b">
                                                                  <xsl:value-of select="/DATA/TXN/PTSPROSPECT/@leadreplies"/>
                                                                  </xsl:element>
                                                                  <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                            </xsl:if>
                                                               <xsl:element name="INPUT">
                                                                  <xsl:attribute name="type">button</xsl:attribute>
                                                                  <xsl:attribute name="class">smbutton</xsl:attribute>
                                                                  <xsl:attribute name="value">
                                                                     <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Send']"/>
                                                                  </xsl:attribute>
                                                                  <xsl:attribute name="onclick">doSubmit(8,"")</xsl:attribute>
                                                               </xsl:element>
                                                               </xsl:element>
                                                            </xsl:if>
                                                      </xsl:element>
                                                   </xsl:element>

                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">4</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">298</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:element name="TABLE">
                                                <xsl:attribute name="border">0</xsl:attribute>
                                                <xsl:attribute name="cellpadding">0</xsl:attribute>
                                                <xsl:attribute name="cellspacing">0</xsl:attribute>
                                                <xsl:attribute name="width">298</xsl:attribute>
                                                <xsl:attribute name="style">border: 1px #5084A2 solid</xsl:attribute>

                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">298</xsl:attribute>
                                                         <xsl:attribute name="align">center</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">298</xsl:attribute>
                                                         <xsl:attribute name="height">18</xsl:attribute>
                                                         <xsl:attribute name="bgcolor">#D8EEFB</xsl:attribute>
                                                         <xsl:attribute name="align">center</xsl:attribute>
                                                         <xsl:attribute name="valign">middle</xsl:attribute>
                                                            <xsl:element name="b">
                                                            <xsl:element name="font">
                                                               <xsl:attribute name="color">darkblue</xsl:attribute>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PresentWebsite']"/>
                                                            </xsl:element>
                                                            </xsl:element>
                                                            <xsl:if test="(/DATA/TXN/PTSPROSPECT/@presentid != 0)">
                                                                (#<xsl:value-of select="/DATA/TXN/PTSPROSPECT/@presentid"/>)
                                                            </xsl:if>
                                                      </xsl:element>
                                                   </xsl:element>

                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">298</xsl:attribute>
                                                         <xsl:attribute name="align">center</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                            <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, 'z')) or (/DATA/SYSTEM/@usergroup &lt;= 23)">
                                                               <xsl:element name="font">
                                                                  <xsl:attribute name="color">blue</xsl:attribute>
                                                            <xsl:if test="(/DATA/TXN/PTSPROSPECT/@presentid != 0)">
                                                                  <xsl:element name="b">
                                                                  <xsl:value-of select="/DATA/PARAM/@presentname" disable-output-escaping="yes"/>
                                                                  </xsl:element>
                                                                  <xsl:element name="BR"/>
                                                                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PresentViews']"/>
                                                                  <xsl:text>:</xsl:text>
                                                                  <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                                  <xsl:element name="b">
                                                                  <xsl:value-of select="/DATA/TXN/PTSPROSPECT/@presentviews"/>
                                                                  </xsl:element>
                                                                  <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                                  <xsl:element name="A">
                                                                     <xsl:attribute name="href">javascript: ViewPages(document.getElementById('PresentID').value, document.getElementById('PresentPages').value)</xsl:attribute>
                                                                  <xsl:element name="u">
                                                                  <xsl:element name="font">
                                                                     <xsl:attribute name="color">blue</xsl:attribute>
                                                                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PresentPages']"/>
                                                                  <xsl:text>:</xsl:text>
                                                                  <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                                  </xsl:element>
                                                                  </xsl:element>
                                                                  </xsl:element>
                                                                  <xsl:element name="A">
                                                                     <xsl:attribute name="href">javascript: ViewPages(document.getElementById('PresentID').value, document.getElementById('PresentPages').value)</xsl:attribute>
                                                                  <xsl:element name="b">
                                                                  <xsl:element name="u">
                                                                  <xsl:element name="font">
                                                                     <xsl:attribute name="color">blue</xsl:attribute>
                                                                  <xsl:value-of select="/DATA/TXN/PTSPROSPECT/@presentpages"/>
                                                                  </xsl:element>
                                                                  </xsl:element>
                                                                  </xsl:element>
                                                                  <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                                  </xsl:element>
                                                            </xsl:if>
                                                               <xsl:element name="INPUT">
                                                                  <xsl:attribute name="type">button</xsl:attribute>
                                                                  <xsl:attribute name="class">smbutton</xsl:attribute>
                                                                  <xsl:attribute name="value">
                                                                     <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Send']"/>
                                                                  </xsl:attribute>
                                                                  <xsl:attribute name="onclick">doSubmit(6,"")</xsl:attribute>
                                                               </xsl:element>
                                                               </xsl:element>
                                                            </xsl:if>
                                                      </xsl:element>
                                                   </xsl:element>

                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
<xsl:element name="SCRIPT">
   <xsl:attribute name="language">JavaScript</xsl:attribute>
   var ProspectTab = new CTabSet("ProspectTab"); ProspectTab.create(ProspectTabDef);
</xsl:element>

                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:attribute name="id">TabSalesSteps</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">2</xsl:attribute>
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">prompt</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EditStatusText']"/>
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
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">prompt</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EditStatusText2']"/>
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
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">prompt</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EditDatesText']"/>
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
                                          <xsl:attribute name="width">600</xsl:attribute>
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
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewSalesStatus']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="SELECT">
                                             <xsl:attribute name="name">Status</xsl:attribute>
                                             <xsl:attribute name="id">Status</xsl:attribute>
                                             <xsl:for-each select="/DATA/TXN/PTSSTATUSS/ENUM">
                                                <xsl:element name="OPTION">
                                                   <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                                   <xsl:if test="@selected"><xsl:attribute name="SELECTED"/></xsl:if>
                                                   <xsl:value-of select="@name"/>
                                                </xsl:element>
                                             </xsl:for-each>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:if test="(/DATA/TXN/PTSPROSPECT/@rsvp != 0)">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='RSVP']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/TXN/PTSPROSPECT/@rsvp"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:if>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NextEvent']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="SELECT">
                                             <xsl:attribute name="name">NextEvent</xsl:attribute>
                                             <xsl:attribute name="id">NextEvent</xsl:attribute>
                                             <xsl:for-each select="/DATA/TXN/PTSPROSPECT/PTSNEXTEVENTS/ENUM">
                                                <xsl:element name="OPTION">
                                                   <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                                   <xsl:if test="@selected"><xsl:attribute name="SELECTED"/></xsl:if>
                                                   <xsl:variable name="tmp1"><xsl:value-of select="current()/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp1]"/>
                                                </xsl:element>
                                             </xsl:for-each>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='on']"/>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">NextDate</xsl:attribute>
                                          <xsl:attribute name="id">NextDate</xsl:attribute>
                                          <xsl:attribute name="size">10</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@nextdate"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="name">Calendar</xsl:attribute>
                                             <xsl:attribute name="src">Images/Calendar.gif</xsl:attribute>
                                             <xsl:attribute name="width">16</xsl:attribute>
                                             <xsl:attribute name="height">16</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="onclick">CalendarPopup(document.forms[0], document.getElementById('NextDate'))</xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Time']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">NextTime</xsl:attribute>
                                          <xsl:attribute name="id">NextTime</xsl:attribute>
                                          <xsl:attribute name="size">6</xsl:attribute>
                                          <xsl:attribute name="maxlength">8</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@nexttime"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">button</xsl:attribute>
                                             <xsl:attribute name="class">smbutton</xsl:attribute>
                                             <xsl:attribute name="value">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Clear']"/>
                                             </xsl:attribute>
                                             <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[document.getElementById('NextEvent').value=0;document.getElementById('NextDate').value="";document.getElementById('NextTime').value="";document.getElementById('Reminder').value=0;document.getElementById('RemindDate').value=""]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Reminder']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="SELECT">
                                             <xsl:attribute name="name">Reminder</xsl:attribute>
                                             <xsl:attribute name="id">Reminder</xsl:attribute>
                                             <xsl:for-each select="/DATA/TXN/PTSPROSPECT/PTSREMINDERS/ENUM">
                                                <xsl:element name="OPTION">
                                                   <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                                   <xsl:if test="@selected"><xsl:attribute name="SELECTED"/></xsl:if>
                                                   <xsl:variable name="tmp1"><xsl:value-of select="current()/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp1]"/>
                                                </xsl:element>
                                             </xsl:for-each>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='RemindDate']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">RemindDate</xsl:attribute>
                                          <xsl:attribute name="id">RemindDate</xsl:attribute>
                                          <xsl:attribute name="size">14</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@reminddate"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="name">Calendar</xsl:attribute>
                                             <xsl:attribute name="src">Images/Calendar.gif</xsl:attribute>
                                             <xsl:attribute name="width">16</xsl:attribute>
                                             <xsl:attribute name="height">16</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="onclick">CalendarPopup(document.forms[0], document.getElementById('RemindDate'))</xsl:attribute>
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
                                          <xsl:attribute name="width">600</xsl:attribute>
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
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CreateDate']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">prompt</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">CreateDate</xsl:attribute>
                                          <xsl:attribute name="id">CreateDate</xsl:attribute>
                                          <xsl:attribute name="size">10</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@createdate"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="name">Calendar</xsl:attribute>
                                             <xsl:attribute name="src">Images/Calendar.gif</xsl:attribute>
                                             <xsl:attribute name="width">16</xsl:attribute>
                                             <xsl:attribute name="height">16</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="onclick">CalendarPopup(document.forms[0], document.getElementById('CreateDate'))</xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CreateDateText']"/>
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
                                          <xsl:attribute name="width">160</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
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

                                    <xsl:if test="(count(/DATA/TXN/PTSSALESSTEPS/PTSSALESSTEP) != 0)">
                                       <xsl:for-each select="/DATA/TXN/PTSSALESSTEPS/PTSSALESSTEP[(@dateno != 0)]">
                                             <xsl:element name="TR">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">160</xsl:attribute>
                                                   <xsl:attribute name="align">right</xsl:attribute>
                                                   <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:value-of select="@salesstepname"/>
                                                      :
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">440</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:attribute name="class">prompt</xsl:attribute>
                                                   <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">text</xsl:attribute>
                                                   <xsl:attribute name="name">Date<xsl:value-of select="@dateno"/></xsl:attribute>
                                                   <xsl:attribute name="id">Date<xsl:value-of select="@dateno"/></xsl:attribute>
                                                   <xsl:attribute name="value"><xsl:value-of select="@data"/></xsl:attribute>
                                                   <xsl:attribute name="size">8</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="name">Calendar</xsl:attribute>
                                                      <xsl:attribute name="src">Images/Calendar.gif</xsl:attribute>
                                                      <xsl:attribute name="width">16</xsl:attribute>
                                                      <xsl:attribute name="height">16</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                      <xsl:attribute name="onclick">CalendarPopup(document.forms[0], document.getElementById('Date<xsl:value-of select="@dateno"/>'))</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:value-of select="@description"/>
                                                </xsl:element>
                                             </xsl:element>

                                       </xsl:for-each>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="height">6</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">160</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">440</xsl:attribute>
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
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FBDate']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">prompt</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">FBDate</xsl:attribute>
                                          <xsl:attribute name="id">FBDate</xsl:attribute>
                                          <xsl:attribute name="size">10</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@fbdate"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="name">Calendar</xsl:attribute>
                                             <xsl:attribute name="src">Images/Calendar.gif</xsl:attribute>
                                             <xsl:attribute name="width">16</xsl:attribute>
                                             <xsl:attribute name="height">16</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="onclick">CalendarPopup(document.forms[0], document.getElementById('FBDate'))</xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FBDateText']"/>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CloseDate']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">prompt</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">CloseDate</xsl:attribute>
                                          <xsl:attribute name="id">CloseDate</xsl:attribute>
                                          <xsl:attribute name="size">10</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@closedate"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="name">Calendar</xsl:attribute>
                                             <xsl:attribute name="src">Images/Calendar.gif</xsl:attribute>
                                             <xsl:attribute name="width">16</xsl:attribute>
                                             <xsl:attribute name="height">16</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="onclick">CalendarPopup(document.forms[0], document.getElementById('CloseDate'))</xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CloseDateText']"/>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='DeadDate']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">prompt</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">DeadDate</xsl:attribute>
                                          <xsl:attribute name="id">DeadDate</xsl:attribute>
                                          <xsl:attribute name="size">10</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@deaddate"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="name">Calendar</xsl:attribute>
                                             <xsl:attribute name="src">Images/Calendar.gif</xsl:attribute>
                                             <xsl:attribute name="width">16</xsl:attribute>
                                             <xsl:attribute name="height">16</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="onclick">CalendarPopup(document.forms[0], document.getElementById('DeadDate'))</xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='DeadDateText']"/>
                                       </xsl:element>
                                    </xsl:element>

                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:attribute name="id">TabContactInfo</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">2</xsl:attribute>
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:if test="((contains(/DATA/SYSTEM/@useroptions, 'r')) or (/DATA/SYSTEM/@usergroup != 41)) and (/DATA/PARAM/@extra != 0)">
                                             <xsl:element name="INPUT">
                                                <xsl:attribute name="type">button</xsl:attribute>
                                                <xsl:attribute name="class">smbutton</xsl:attribute>
                                                <xsl:attribute name="value">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ExtraInfo']"/>
                                                </xsl:attribute>
                                                <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[EditExtra()]]></xsl:text></xsl:attribute>
                                             </xsl:element>
                                          </xsl:if>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, 'u')) or (/DATA/SYSTEM/@usergroup != 41)">
                                             <xsl:element name="INPUT">
                                                <xsl:attribute name="type">button</xsl:attribute>
                                                <xsl:attribute name="class">smbutton</xsl:attribute>
                                                <xsl:attribute name="value">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Forms']"/>
                                                </xsl:attribute>
                                                <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[ViewForms()]]></xsl:text></xsl:attribute>
                                             </xsl:element>
                                          </xsl:if>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">2</xsl:attribute>
                                          <xsl:element name="TABLE">
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="cellpadding">0</xsl:attribute>
                                             <xsl:attribute name="cellspacing">0</xsl:attribute>
                                             <xsl:attribute name="width">600</xsl:attribute>
                                             <xsl:element name="TR">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">160</xsl:attribute>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">200</xsl:attribute>
                                                   <xsl:attribute name="class">InputHeading</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">bottom</xsl:attribute>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NameFirst']"/>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">240</xsl:attribute>
                                                   <xsl:attribute name="class">InputHeading</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">bottom</xsl:attribute>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NameLast']"/>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TR">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">160</xsl:attribute>
                                                   <xsl:attribute name="align">right</xsl:attribute>
                                                   <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ContactName']"/>
                                                   <xsl:text>:</xsl:text>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">200</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">text</xsl:attribute>
                                                   <xsl:attribute name="name">NameFirst</xsl:attribute>
                                                   <xsl:attribute name="id">NameFirst</xsl:attribute>
                                                   <xsl:attribute name="size">25</xsl:attribute>
                                                   <xsl:attribute name="maxlength">30</xsl:attribute>
                                                   <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@namefirst"/></xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">240</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">text</xsl:attribute>
                                                   <xsl:attribute name="name">NameLast</xsl:attribute>
                                                   <xsl:attribute name="id">NameLast</xsl:attribute>
                                                   <xsl:attribute name="size">25</xsl:attribute>
                                                   <xsl:attribute name="maxlength">30</xsl:attribute>
                                                   <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@namelast"/></xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Title']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Title</xsl:attribute>
                                          <xsl:attribute name="id">Title</xsl:attribute>
                                          <xsl:attribute name="size">30</xsl:attribute>
                                          <xsl:attribute name="maxlength">30</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@title"/></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Email']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Email</xsl:attribute>
                                          <xsl:attribute name="id">Email</xsl:attribute>
                                          <xsl:attribute name="size">58</xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@email"/></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Phone1']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Phone1</xsl:attribute>
                                          <xsl:attribute name="id">Phone1</xsl:attribute>
                                          <xsl:attribute name="size">20</xsl:attribute>
                                          <xsl:attribute name="maxlength">30</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@phone1"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Phone2']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Phone2</xsl:attribute>
                                          <xsl:attribute name="id">Phone2</xsl:attribute>
                                          <xsl:attribute name="size">20</xsl:attribute>
                                          <xsl:attribute name="maxlength">30</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@phone2"/></xsl:attribute>
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
                                          <xsl:attribute name="width">160</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
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
                                          <xsl:element name="TABLE">
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="cellpadding">0</xsl:attribute>
                                             <xsl:attribute name="cellspacing">0</xsl:attribute>
                                             <xsl:attribute name="width">600</xsl:attribute>
                                             <xsl:element name="TR">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">160</xsl:attribute>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">294</xsl:attribute>
                                                   <xsl:attribute name="class">InputHeading</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">bottom</xsl:attribute>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Street']"/>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">146</xsl:attribute>
                                                   <xsl:attribute name="class">InputHeading</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">bottom</xsl:attribute>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Unit']"/>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TR">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">160</xsl:attribute>
                                                   <xsl:attribute name="align">right</xsl:attribute>
                                                   <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Address']"/>
                                                   <xsl:text>:</xsl:text>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">294</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">text</xsl:attribute>
                                                   <xsl:attribute name="name">Street</xsl:attribute>
                                                   <xsl:attribute name="id">Street</xsl:attribute>
                                                   <xsl:attribute name="size">40</xsl:attribute>
                                                   <xsl:attribute name="maxlength">60</xsl:attribute>
                                                   <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@street"/></xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">146</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">text</xsl:attribute>
                                                   <xsl:attribute name="name">Unit</xsl:attribute>
                                                   <xsl:attribute name="id">Unit</xsl:attribute>
                                                   <xsl:attribute name="size">10</xsl:attribute>
                                                   <xsl:attribute name="maxlength">40</xsl:attribute>
                                                   <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@unit"/></xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">2</xsl:attribute>
                                          <xsl:element name="TABLE">
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="cellpadding">0</xsl:attribute>
                                             <xsl:attribute name="cellspacing">0</xsl:attribute>
                                             <xsl:attribute name="width">600</xsl:attribute>
                                             <xsl:element name="TR">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">160</xsl:attribute>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">200</xsl:attribute>
                                                   <xsl:attribute name="class">InputHeading</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">bottom</xsl:attribute>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='City']"/>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">240</xsl:attribute>
                                                   <xsl:attribute name="class">InputHeading</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">bottom</xsl:attribute>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='State']"/>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TR">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">160</xsl:attribute>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">200</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">text</xsl:attribute>
                                                   <xsl:attribute name="name">City</xsl:attribute>
                                                   <xsl:attribute name="id">City</xsl:attribute>
                                                   <xsl:attribute name="size">25</xsl:attribute>
                                                   <xsl:attribute name="maxlength">30</xsl:attribute>
                                                   <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@city"/></xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">240</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">text</xsl:attribute>
                                                   <xsl:attribute name="name">State</xsl:attribute>
                                                   <xsl:attribute name="id">State</xsl:attribute>
                                                   <xsl:attribute name="size">25</xsl:attribute>
                                                   <xsl:attribute name="maxlength">30</xsl:attribute>
                                                   <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@state"/></xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">2</xsl:attribute>
                                          <xsl:element name="TABLE">
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="cellpadding">0</xsl:attribute>
                                             <xsl:attribute name="cellspacing">0</xsl:attribute>
                                             <xsl:attribute name="width">600</xsl:attribute>
                                             <xsl:element name="TR">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">160</xsl:attribute>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">200</xsl:attribute>
                                                   <xsl:attribute name="class">InputHeading</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">bottom</xsl:attribute>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Zip']"/>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">240</xsl:attribute>
                                                   <xsl:attribute name="class">InputHeading</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">bottom</xsl:attribute>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Country']"/>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TR">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">160</xsl:attribute>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">200</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">text</xsl:attribute>
                                                   <xsl:attribute name="name">Zip</xsl:attribute>
                                                   <xsl:attribute name="id">Zip</xsl:attribute>
                                                   <xsl:attribute name="size">25</xsl:attribute>
                                                   <xsl:attribute name="maxlength">20</xsl:attribute>
                                                   <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@zip"/></xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">240</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">text</xsl:attribute>
                                                   <xsl:attribute name="name">Country</xsl:attribute>
                                                   <xsl:attribute name="id">Country</xsl:attribute>
                                                   <xsl:attribute name="size">25</xsl:attribute>
                                                   <xsl:attribute name="maxlength">30</xsl:attribute>
                                                   <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@country"/></xsl:attribute>
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
                                          <xsl:attribute name="width">160</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
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
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Website']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Website</xsl:attribute>
                                          <xsl:attribute name="id">Website</xsl:attribute>
                                          <xsl:attribute name="size">60</xsl:attribute>
                                          <xsl:attribute name="maxlength">80</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@website"/></xsl:attribute>
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
                                          <xsl:attribute name="width">600</xsl:attribute>
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
                                          <xsl:attribute name="width">160</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">checkbox</xsl:attribute>
                                          <xsl:attribute name="name">NoDistribute</xsl:attribute>
                                          <xsl:attribute name="id">NoDistribute</xsl:attribute>
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="(/DATA/TXN/PTSPROSPECT/@nodistribute = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoDistribute']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23)">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">160</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">440</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='DistributorID']"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">text</xsl:attribute>
                                             <xsl:attribute name="name">DistributorID</xsl:attribute>
                                             <xsl:attribute name="id">DistributorID</xsl:attribute>
                                             <xsl:attribute name="size">3</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@distributorid"/></xsl:attribute>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='on']"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">text</xsl:attribute>
                                             <xsl:attribute name="name">DistributeDate</xsl:attribute>
                                             <xsl:attribute name="id">DistributeDate</xsl:attribute>
                                             <xsl:attribute name="size">10</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@distributedate"/></xsl:attribute>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="name">Calendar</xsl:attribute>
                                                <xsl:attribute name="src">Images/Calendar.gif</xsl:attribute>
                                                <xsl:attribute name="width">16</xsl:attribute>
                                                <xsl:attribute name="height">16</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                                <xsl:attribute name="onclick">CalendarPopup(document.forms[0], document.getElementById('DistributeDate'))</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:if>

                                    <xsl:if test="(/DATA/SYSTEM/@usergroup &gt; 23) and (/DATA/TXN/PTSPROSPECT/@distributorid != 0)">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">160</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">440</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='DistributorID']"/>
                                             <xsl:value-of select="/DATA/TXN/PTSPROSPECT/@distributorid"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='on']"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/TXN/PTSPROSPECT/@distributedate"/>
                                          </xsl:element>
                                       </xsl:element>

                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">hidden</xsl:attribute>
                                             <xsl:attribute name="name">DistributorID</xsl:attribute>
                                             <xsl:attribute name="id">DistributorID</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@distributorid"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">hidden</xsl:attribute>
                                             <xsl:attribute name="name">DistributeDate</xsl:attribute>
                                             <xsl:attribute name="id">DistributeDate</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@distributedate"/></xsl:attribute>
                                          </xsl:element>

                                    </xsl:if>
                                    <xsl:if test="(/DATA/TXN/PTSPROSPECT/@iscopyurl != 0)">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="height">6</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">160</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">440</xsl:attribute>
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
                                             <xsl:attribute name="width">160</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">440</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="INPUT">
                                                <xsl:attribute name="type">button</xsl:attribute>
                                                <xsl:attribute name="value">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CopySystem']"/>
                                                </xsl:attribute>
                                                <xsl:attribute name="onclick">doSubmit(7,"")</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                    </xsl:if>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:attribute name="id">TabDescription</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">2</xsl:attribute>
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Description']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">2</xsl:attribute>
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="TEXTAREA">
                                             <xsl:attribute name="name">Description</xsl:attribute>
                                             <xsl:attribute name="id">Description</xsl:attribute>
                                             <xsl:attribute name="rows">10</xsl:attribute>
                                             <xsl:attribute name="cols">72</xsl:attribute>
                                             <xsl:attribute name="onkeyup"><xsl:text disable-output-escaping="yes"><![CDATA[if (value.length>2000) {doMaxLenMsg(2000); value=value.substring(0,2000);}]]></xsl:text></xsl:attribute>
                                             <xsl:value-of select="/DATA/TXN/PTSPROSPECT/@description"/>
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
                                          <xsl:attribute name="width">600</xsl:attribute>
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
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">prompt</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EditChangeStatusText']"/>
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
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ChangeTo']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="SELECT">
                                             <xsl:attribute name="name">ChangeStatus</xsl:attribute>
                                             <xsl:attribute name="id">ChangeStatus</xsl:attribute>
                                             <xsl:for-each select="/DATA/TXN/PTSCHANGESTATUSS/ENUM">
                                                <xsl:element name="OPTION">
                                                   <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                                   <xsl:if test="@selected"><xsl:attribute name="SELECTED"/></xsl:if>
                                                   <xsl:value-of select="@name"/>
                                                </xsl:element>
                                             </xsl:for-each>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='on']"/>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">ChangeDate</xsl:attribute>
                                          <xsl:attribute name="id">ChangeDate</xsl:attribute>
                                          <xsl:attribute name="size">14</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@changedate"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="name">Calendar</xsl:attribute>
                                             <xsl:attribute name="src">Images/Calendar.gif</xsl:attribute>
                                             <xsl:attribute name="width">16</xsl:attribute>
                                             <xsl:attribute name="height">16</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="onclick">CalendarPopup(document.forms[0], document.getElementById('ChangeDate'))</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:if test="(/DATA/PARAM/@emailid != 0)">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="height">6</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">600</xsl:attribute>
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
                                             <xsl:attribute name="width">160</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SendEmail']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">440</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="font">
                                                <xsl:attribute name="color">blue</xsl:attribute>
                                             <xsl:value-of select="/DATA/TXN/PTSEMAIL/@emailname"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='on']"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">text</xsl:attribute>
                                             <xsl:attribute name="name">EmailDate</xsl:attribute>
                                             <xsl:attribute name="id">EmailDate</xsl:attribute>
                                             <xsl:attribute name="size">14</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@emaildate"/></xsl:attribute>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="name">Calendar</xsl:attribute>
                                                <xsl:attribute name="src">Images/Calendar.gif</xsl:attribute>
                                                <xsl:attribute name="width">16</xsl:attribute>
                                                <xsl:attribute name="height">16</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                                <xsl:attribute name="onclick">CalendarPopup(document.forms[0], document.getElementById('EmailDate'))</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                    </xsl:if>
                                    <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23)">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">160</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EmailID']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">440</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">text</xsl:attribute>
                                             <xsl:attribute name="name">EmailID</xsl:attribute>
                                             <xsl:attribute name="id">EmailID</xsl:attribute>
                                             <xsl:attribute name="size">10</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@emailid"/></xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:if>

                                    <xsl:if test="(/DATA/SYSTEM/@usergroup &gt; 23)">
                                       <xsl:element name="INPUT">
                                          <xsl:attribute name="type">hidden</xsl:attribute>
                                          <xsl:attribute name="name">EmailID</xsl:attribute>
                                          <xsl:attribute name="id">EmailID</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@emailid"/></xsl:attribute>
                                       </xsl:element>
                                    </xsl:if>

                                    <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23) or (contains(/DATA/SYSTEM/@useroptions, 'W'))">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="height">6</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">600</xsl:attribute>
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
                                             <xsl:attribute name="width">160</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EmailStatus']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">440</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="SELECT">
                                                <xsl:attribute name="name">EmailStatus</xsl:attribute>
                                                <xsl:attribute name="id">EmailStatus</xsl:attribute>
                                                <xsl:for-each select="/DATA/TXN/PTSPROSPECT/PTSEMAILSTATUSS/ENUM">
                                                   <xsl:element name="OPTION">
                                                      <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                                      <xsl:if test="@selected"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:variable name="tmp1"><xsl:value-of select="current()/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp1]"/>
                                                   </xsl:element>
                                                </xsl:for-each>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewsLetterID']"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">text</xsl:attribute>
                                             <xsl:attribute name="name">NewsLetterID</xsl:attribute>
                                             <xsl:attribute name="id">NewsLetterID</xsl:attribute>
                                             <xsl:attribute name="size">5</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSPROSPECT/@newsletterid"/></xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                    </xsl:if>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:attribute name="id">TabNotes</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IFRAME">
                                 <xsl:attribute name="src"></xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="height">400</xsl:attribute>
                                 <xsl:attribute name="frmheight">400</xsl:attribute>
                                 <xsl:attribute name="id">NotesFrame</xsl:attribute>
                                 <xsl:attribute name="name">NotesFrame</xsl:attribute>
                                 <xsl:attribute name="class">FrameNoScroll</xsl:attribute>
                                 <xsl:attribute name="frameborder">0</xsl:attribute>
                                 <xsl:element name="A">
                                    <xsl:attribute name="href"></xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoFrameSupport']"/>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:attribute name="id">TabEvents</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IFRAME">
                                 <xsl:attribute name="src"></xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="height">400</xsl:attribute>
                                 <xsl:attribute name="frmheight">400</xsl:attribute>
                                 <xsl:attribute name="id">EventsFrame</xsl:attribute>
                                 <xsl:attribute name="name">EventsFrame</xsl:attribute>
                                 <xsl:attribute name="class">FrameNoScroll</xsl:attribute>
                                 <xsl:attribute name="frameborder">0</xsl:attribute>
                                 <xsl:element name="A">
                                    <xsl:attribute name="href"></xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoFrameSupport']"/>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:attribute name="id">TabMail</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">prompt</xsl:attribute>
                                 <xsl:if test="(/DATA/PARAM/@ismail = 0)">
                                    <xsl:element name="BR"/><xsl:element name="BR"/><xsl:element name="BR"/>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoEmailText']"/>
                                 </xsl:if>
                                 <xsl:element name="IFRAME">
                                    <xsl:attribute name="src"></xsl:attribute>
                                    <xsl:attribute name="width">600</xsl:attribute>
                                    <xsl:attribute name="height">400</xsl:attribute>
                                    <xsl:attribute name="frmheight">400</xsl:attribute>
                                    <xsl:attribute name="id">MailFrame</xsl:attribute>
                                    <xsl:attribute name="name">MailFrame</xsl:attribute>
                                    <xsl:attribute name="class">FrameNoScroll</xsl:attribute>
                                    <xsl:attribute name="frameborder">0</xsl:attribute>
                                    <xsl:element name="A">
                                       <xsl:attribute name="href"></xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoFrameSupport']"/>
                                    </xsl:element>
                                 </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:attribute name="id">TabDocuments</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IFRAME">
                                 <xsl:attribute name="src"></xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="height">400</xsl:attribute>
                                 <xsl:attribute name="frmheight">400</xsl:attribute>
                                 <xsl:attribute name="id">DocumentsFrame</xsl:attribute>
                                 <xsl:attribute name="name">DocumentsFrame</xsl:attribute>
                                 <xsl:attribute name="class">FrameNoScroll</xsl:attribute>
                                 <xsl:attribute name="frameborder">0</xsl:attribute>
                                 <xsl:element name="A">
                                    <xsl:attribute name="href"></xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoFrameSupport']"/>
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
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#004080</xsl:attribute>
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
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:if test="(/DATA/SYSTEM/@userstatus = 1)">
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Update']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick">doSubmit(1,"")</xsl:attribute>
                                 </xsl:element>
                              </xsl:if>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:if test="(/DATA/SYSTEM/@userstatus = 1) and (/DATA/PARAM/@popup = 0)">
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='UpdateExit']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick">doSubmit(2,"")</xsl:attribute>
                                 </xsl:element>
                              </xsl:if>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:if test="(/DATA/PARAM/@popup = 0)">
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Cancel']"/>
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
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:if test="(/DATA/SYSTEM/@userstatus = 1) and (/DATA/TXN/PTSPROSPECT/@affiliateid = 0)">
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Delete']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick">doSubmit(4,'<xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ConfirmDeleteProspect']"/>')</xsl:attribute>
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