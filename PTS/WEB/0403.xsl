<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
   <xsl:include href="HTMLHeading.xsl"/>
   <xsl:include href="PageHeader.xsl"/>
   <xsl:include href="PageFooter.xsl"/>
   <xsl:include href="Bookmark.xsl"/>
   <xsl:include href="Include\wtMenu.xsl"/>
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
         <xsl:with-param name="pagename" select="'Member'"/>
         <xsl:with-param name="includecalendar" select="true()"/>
         <xsl:with-param name="htmleditor">editor</xsl:with-param>
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

      <xsl:element name="SCRIPT">
         <xsl:attribute name="language">JavaScript</xsl:attribute>
         <xsl:attribute name="src">Include/codethattabpro.js</xsl:attribute>
         <xsl:text> </xsl:text>
      </xsl:element>

      <xsl:call-template name="DefineMenu"/>

      <xsl:call-template name="DefineTab"/>

      <!--BEGIN BODY-->
      <xsl:element name="BODY">
         <xsl:if test="/DATA/PARAM/@contentpage=1 or /DATA/PARAM/@contentpage=3">
            <xsl:attribute name="topmargin">0</xsl:attribute>
            <xsl:attribute name="leftmargin">0</xsl:attribute>
         </xsl:if>
         <xsl:if test="/DATA/PARAM/@contentpage!=1 and /DATA/PARAM/@contentpage!=3">
            <xsl:attribute name="topmargin">0</xsl:attribute>
            <xsl:attribute name="leftmargin">10</xsl:attribute>
         </xsl:if>
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
               ShowTab('TabContact',0);
            ]]></xsl:text>;doErrorMsg('<xsl:value-of select="concat($errmsg, $errmsgfld)"/>')</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[
               ShowTab('TabContact',0);
            ]]></xsl:text>;doErrorMsg('<xsl:value-of select="/DATA/ERROR"/>')</xsl:attribute>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
               <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[
               ShowTab('TabContact',0);
            ]]></xsl:text></xsl:attribute>
            </xsl:otherwise>
         </xsl:choose>

         <!--BEGIN PAGE-->
      <xsl:element name="DIV">
         <xsl:attribute name="id">wrapper800</xsl:attribute>
         <xsl:element name="A">
            <xsl:attribute name="name">top</xsl:attribute>
         </xsl:element>
         <xsl:element name="TABLE">
            <xsl:attribute name="border">0</xsl:attribute>
            <xsl:attribute name="cellpadding">0</xsl:attribute>
            <xsl:attribute name="cellspacing">0</xsl:attribute>
            <xsl:if test="/DATA/PARAM/@contentpage=0">
               <xsl:attribute name="width">750</xsl:attribute>
            </xsl:if>
            <xsl:if test="/DATA/PARAM/@contentpage=1">
               <xsl:attribute name="width">600</xsl:attribute>
            </xsl:if>
            <xsl:if test="/DATA/PARAM/@contentpage=2 or /DATA/PARAM/@contentpage=3">
               <xsl:attribute name="width">610</xsl:attribute>
            </xsl:if>
            <xsl:attribute name="align">left</xsl:attribute>

            <!--BEGIN FORM-->
            <xsl:element name="FORM">
               <xsl:attribute name="name">Member</xsl:attribute>
               <xsl:attribute name="method">post</xsl:attribute>

               <xsl:element name="INPUT">
                  <xsl:attribute name="type">hidden</xsl:attribute>
                  <xsl:attribute name="name">ActionCode</xsl:attribute>
                  <xsl:attribute name="id">ActionCode</xsl:attribute>
                  <xsl:attribute name="value"></xsl:attribute>
               </xsl:element>
               <xsl:element name="INPUT">
                  <xsl:attribute name="type">hidden</xsl:attribute>
                  <xsl:attribute name="name">ContentPage</xsl:attribute>
                  <xsl:attribute name="id">ContentPage</xsl:attribute>
                  <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@contentpage"/></xsl:attribute>
               </xsl:element>
               <!--BEGIN PAGE LAYOUT ROW-->
               <xsl:element name="TR">
                  <xsl:if test="/DATA/PARAM/@contentpage!=1">
                     <xsl:element name="TD">
                        <xsl:attribute name="width">10</xsl:attribute>
                     </xsl:element>
                  </xsl:if>
                  <xsl:element name="TD">
                     <xsl:attribute name="width">740</xsl:attribute>
                  </xsl:element>
               </xsl:element>

               <!--HEADER ROW-->
               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="colspan">2</xsl:attribute>
                     <xsl:if test="/DATA/PARAM/@contentpage!=1 and /DATA/PARAM/@contentpage!=3">
                        <xsl:call-template name="PageHeader"/>
                     </xsl:if>
                  </xsl:element>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function EditExtra(){ 
               var url, win, height;
               url = "0455.asp?companyid=" + document.getElementById('CompanyID').value + "&memberid=" + document.getElementById('MemberID').value
               height = document.getElementById('Extra').value
                  win = window.open(url,"ExtraInfo","top=100,left=100,height=" + height + ",width=425,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no,scrollbars=1");
               win.focus();
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function EditBVQV(){ 
               var url, win, height;
               url = "0459.asp?memberid=" + document.getElementById('MemberID').value
               win = window.open(url,"ExtraInfo","top=100,left=100,height=300,width=400,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no,scrollbars=1");
               win.focus();
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ViewForms(){ 
               var url, win;
               url = "9311.asp?companyid=" + document.getElementById('CompanyID').value + "&memberid=" + document.getElementById('MemberID').value
                  win = window.open(url,"Forms","top=100,left=100,height=300,width=425,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no,scrollbars=1");
               win.focus();
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ViewTitles(){ 
               var url, win;
               url = "5711.asp?memberid=" + document.getElementById('MemberID').value
                  win = window.open(url,"Titles","top=100,left=100,height=300,width=425,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no,scrollbars=1");
               win.focus();
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ViewCampaign(){ 
            var id = document.getElementById('WebsiteID').value;
            if( id != 0 )
            {
               var url, win;
               var member = document.getElementById('MemberID').value;
               url = "pp.asp?p=" + id + "&m=" + member + "&preview=1"
               win = window.open(url,'Presentation');
               win.focus();
            }
              }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ViewDownlines(){ 
               var url, win;
               url = "5404.asp?memberid=" + document.getElementById('MemberID').value
                  win = window.open(url,"Teams","top=100,left=100,height=200,width=300,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no,scrollbars=1");
               win.focus();
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ViewIncome(id){ 
               var url, win;
               url = "0491.asp?memberid=" + id
               win = window.open(url,"Income","top=100,left=100,height=275,width=300,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no");
               win.focus();
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ViewSponsorTeams(id){ 
               var url, win, company;
               company = document.getElementById('CompanyID').value
               url = "0471.asp?memberid=" + id + "&companyid=" + company
               if( company == 9 ) { url = url + "&s2=1" }
            win = window.open(url,"Teams","top=100,left=100,height=200,width=300,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no");
            win.focus();
          }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ViewDashboard(id){ 
          var url, win, cid;
          cid = document.getElementById('CompanyID').value
          if( cid == 14) { url = "13504.asp?memberid=" + id }
          if( cid == 17) { url = "13804.asp?memberid=" + id }
          if( cid == 20) { url = "13904.asp?memberid=" + id }
          win = window.open(url,"Dashboard","top=100,left=100,height=650,width=450,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no");
          win.focus();
         }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ViewWalletInfo(id){ 
          var url, win;
          url = "WalletInfo.asp?memberid=" + id 
          win = window.open(url,"WalletInfo","top=100,left=100,height=425,width=650,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no");
          win.focus();
         }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ShowTab(tab, shw){ 
               document.getElementById('TabStatus').style.display = 'none';
               document.getElementById('TabBilling').style.display = 'none';
               document.getElementById('TabNotes').style.display = 'none';
               document.getElementById('TabMsgs').style.display = 'none';
               document.getElementById('TabContact').style.display = 'none';
               document.getElementById('TabAccess').style.display = 'none';
               document.getElementById('TabGroup').style.display = 'none';
               //document.getElementById('TabBusiness').style.display = 'none';
               document.getElementById('TabFolders').style.display = 'none';
               document.getElementById(tab).style.display = '';
               if (shw > 0) {
               content = window.document.getElementById('Email2');
               if(content)
               content.scrollIntoView();
               }
               if ( tab == 'TabContact' ) {
               var src = document.getElementById('AddressFrame').src
               if (src.indexOf("3711.") < 0 ) {
                     var id = document.getElementById('MemberID').value
                     var companyid = document.getElementById('CompanyID').value
                     src = '3711.asp?OwnerType=4&OwnerID=' + id + '&Companyid=' + companyid
                     document.getElementById('AddressFrame').src = src
                  }   
               }   
               if ( tab == 'TabNotes' ) {
                  var src = document.getElementById('NotesFrame').src
                  if (src.indexOf("9011.") < 0 ) {
                     var id = document.getElementById('MemberID').value
                     var title = document.getElementById('MemberName').value
                     src = '9011.asp?Height=250&OwnerType=4&OwnerID=' + id + '&Title=' + title
                     document.getElementById('NotesFrame').src = src
                  }   
               }   
               if ( tab == 'TabMsgs' ) {
                  var src = document.getElementById('MsgsFrame').src
                  if (src.indexOf("9701.") < 0 ) {
                     var id = document.getElementById('MemberID').value
                     src = '9701.asp?Height=250&OwnerType=4&OwnerID=' + id
                     document.getElementById('MsgsFrame').src = src
                  }
               }
               if ( tab == 'TabFolders' ) {
                  var obj = document.getElementById('FoldersFrame')
                  var src = obj.src
                  if (src.indexOf("12511") < 0 ) {
                     var mid = document.getElementById('MemberID').value
                     src = '12511.asp?entity=4&popup=1&itemid=' + mid + '&memberid=0'
                     obj.src = src
                  }
               }
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="TR">

                  <xsl:if test="/DATA/PARAM/@contentpage!=1">
                     <xsl:element name="TD">
                        <xsl:attribute name="width">10</xsl:attribute>
                     </xsl:element>
                  </xsl:if>
                  <xsl:element name="TD">
                     <xsl:attribute name="valign">top</xsl:attribute>
                     <xsl:attribute name="width">800</xsl:attribute>

                     <xsl:element name="TABLE">
                        <xsl:attribute name="border">0</xsl:attribute>
                        <xsl:attribute name="cellpadding">0</xsl:attribute>
                        <xsl:attribute name="cellspacing">0</xsl:attribute>
                        <xsl:attribute name="width">800</xsl:attribute>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">160</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">640</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23) or (/DATA/SYSTEM/@usergroup = 51)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">800</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
<xsl:element name="SCRIPT">
   <xsl:attribute name="language">JavaScript</xsl:attribute>
   var MemberMenu = new CMenu(MemberMenuDef, 'MemberMenu'); MemberMenu.create();
</xsl:element>

                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">MemberID</xsl:attribute>
                              <xsl:attribute name="id">MemberID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@memberid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">MemberName</xsl:attribute>
                              <xsl:attribute name="id">MemberName</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@membername"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Extra</xsl:attribute>
                              <xsl:attribute name="id">Extra</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@extra"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">ParentID</xsl:attribute>
                              <xsl:attribute name="id">ParentID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@parentid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">MemberOptions</xsl:attribute>
                              <xsl:attribute name="id">MemberOptions</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@memberoptions"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Token</xsl:attribute>
                              <xsl:attribute name="id">Token</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@token"/></xsl:attribute>
                           </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">160</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeader</xsl:attribute>
                              <xsl:element name="IMG">
                                 <xsl:attribute name="src">Images/Member.gif</xsl:attribute>
                                 <xsl:attribute name="border">0</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">640</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 #
                                 <xsl:value-of select="/DATA/TXN/PTSMEMBER/@memberid"/>
                                 -
                                 <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namefirst"/>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namelast"/>
                              <xsl:if test="(/DATA/TXN/PTSMEMBER/@title != 0)">
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:element name="IMG">
                                       <xsl:attribute name="src">Images/Company/<xsl:value-of select="/DATA/PARAM/@companyid"/>/Title<xsl:value-of select="/DATA/TXN/PTSMEMBER/@title"/>.gif</xsl:attribute>
                                       <xsl:attribute name="align">absmiddle</xsl:attribute>
                                       <xsl:attribute name="border">0</xsl:attribute>
                                    </xsl:element>
                              </xsl:if>
                              <xsl:if test="(/DATA/PARAM/@companyid = 14) or (/DATA/PARAM/@companyid = 17) or (/DATA/PARAM/@companyid = 20)">
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:element name="A">
                                       <xsl:attribute name="href">#_</xsl:attribute>
                                       <xsl:attribute name="onclick">ViewDashboard(<xsl:value-of select="/DATA/PARAM/@memberid"/>)</xsl:attribute>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/performance.gif</xsl:attribute>
                                          <xsl:attribute name="align">absmiddle</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                          <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='performance']"/></xsl:attribute>
                                          <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='performance']"/></xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                              </xsl:if>
                              <xsl:if test="(/DATA/TXN/PTSMEMBER/@companyid = 17)">
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:element name="A">
                                       <xsl:attribute name="href">#_</xsl:attribute>
                                       <xsl:attribute name="onclick">ViewWalletInfo(<xsl:value-of select="/DATA/PARAM/@memberid"/>)</xsl:attribute>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/Company/17/gcr32.gif</xsl:attribute>
                                          <xsl:attribute name="align">absmiddle</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                          <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='WalletInfo']"/></xsl:attribute>
                                          <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='WalletInfo']"/></xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                              </xsl:if>
                              <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23) or (/DATA/SYSTEM/@usergroup = 51) or (/DATA/SYSTEM/@usergroup = 52)">
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, 's'))">
                                       <xsl:element name="A">
                                          <xsl:attribute name="onclick">w=window.open(this.href,"shortcut","width=400, height=150");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                          <xsl:attribute name="href">9202.asp?EntityID=04&amp;ItemID=<xsl:value-of select="/DATA/TXN/PTSMEMBER/@memberid"/>&amp;Name=<xsl:value-of select="translate(/DATA/TXN/PTSMEMBER/@companyname,'&amp;',' ')"/>&amp;URL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/></xsl:attribute>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/Shortcut.gif</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:if>
                              </xsl:if>
                              <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, 'U'))">
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:element name="A">
                                       <xsl:attribute name="onclick">w=window.open(this.href,"Tutorial","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                       <xsl:attribute name="href">Tutorial.asp?Lesson=5&amp;contentpage=3&amp;popup=1</xsl:attribute>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/Tutorial.gif</xsl:attribute>
                                          <xsl:attribute name="align">absmiddle</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                          <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PinnacleTutorials']"/></xsl:attribute>
                                          <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PinnacleTutorials']"/></xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                              </xsl:if>
                                 <xsl:if test="(/DATA/TXN/PTSMEMBER/@iscompany != 0)">
                                    <xsl:element name="BR"/>
                                    <xsl:value-of select="/DATA/TXN/PTSMEMBER/@companyname"/>
                                 </xsl:if>
                                 <xsl:element name="BR"/>
                                 <xsl:element name="font">
                                    <xsl:attribute name="size">2</xsl:attribute>
                                    <xsl:attribute name="color">purple</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='VisitDate']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:value-of select="/DATA/TXN/PTSMEMBER/@visitdate"/>
                                    <xsl:element name="BR"/>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EnrollDate']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:value-of select="/DATA/TXN/PTSMEMBER/@enrolldate"/>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:if test="(/DATA/TXN/PTSMEMBER/@billing = 3)">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PaidDate']"/>
                                       <xsl:text>:</xsl:text>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/TXN/PTSMEMBER/@paiddate"/>
                                    </xsl:if>
                                 </xsl:element>
                                 <xsl:element name="font">
                                    <xsl:attribute name="size">2</xsl:attribute>
                                    <xsl:attribute name="color">blue</xsl:attribute>
                                    <xsl:element name="BR"/>
                                    (<xsl:value-of select="concat(/DATA/PARAM/@pv,'/',/DATA/PARAM/@bv)"/>)
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:if test="(/DATA/PARAM/@products != '')">
                                       <xsl:value-of select="/DATA/PARAM/@products" disable-output-escaping="yes"/>
                                    </xsl:if>
                                 </xsl:element>
                                 <xsl:if test="(/DATA/PARAM/@showqualify != 0)">
                                    <xsl:element name="font">
                                       <xsl:attribute name="size">2</xsl:attribute>
                                    <xsl:element name="BR"/>
                                    <xsl:if test="(/DATA/TXN/PTSMEMBER/@qualify &lt;= 1)">
                                       <xsl:element name="font">
                                          <xsl:attribute name="color">red</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NotBonusQualified']"/>
                                       </xsl:element>
                                    </xsl:if>
                                    <xsl:if test="(/DATA/TXN/PTSMEMBER/@qualify &gt; 1)">
                                       <xsl:element name="font">
                                          <xsl:attribute name="color">green</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BonusQualified']"/>
                                       </xsl:element>
                                    </xsl:if>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    /
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:if test="(/DATA/TXN/PTSMEMBER/@isincluded = 0)">
                                       <xsl:element name="font">
                                          <xsl:attribute name="color">red</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NotPayoutQualified']"/>
                                       </xsl:element>
                                    </xsl:if>
                                    <xsl:if test="(/DATA/TXN/PTSMEMBER/@isincluded != 0)">
                                       <xsl:element name="font">
                                          <xsl:attribute name="color">green</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PayoutQualified']"/>
                                       </xsl:element>
                                    </xsl:if>
                                    </xsl:element>
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
                              <xsl:attribute name="width">800</xsl:attribute>
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
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@companyid = 12)">
                                    <xsl:element name="A">
                                       <xsl:attribute name="onclick">w=window.open(this.href,"Friends","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                       <xsl:attribute name="href">14101.asp?MemberID=<xsl:value-of select="/DATA/TXN/PTSMEMBER/@memberid"/></xsl:attribute>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/genealogy.gif</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                          <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewFriends']"/></xsl:attribute>
                                          <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewFriends']"/></xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:element name="A">
                                       <xsl:attribute name="onclick">w=window.open(this.href,"Broadcasts","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                       <xsl:attribute name="href">14401.asp?MemberID=<xsl:value-of select="/DATA/TXN/PTSMEMBER/@memberid"/>&amp;CompanyID=<xsl:value-of select="/DATA/TXN/PTSMEMBER/@companyid"/></xsl:attribute>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/news.gif</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                          <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewBroadcasts']"/></xsl:attribute>
                                          <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewBroadcasts']"/></xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:element name="A">
                                       <xsl:attribute name="onclick">w=window.open(this.href,"Ads","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                       <xsl:attribute name="href">14311.asp?MemberID=<xsl:value-of select="/DATA/TXN/PTSMEMBER/@memberid"/>&amp;CompanyID=<xsl:value-of select="/DATA/TXN/PTSMEMBER/@companyid"/></xsl:attribute>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/ad.gif</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                          <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewAds']"/></xsl:attribute>
                                          <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewAds']"/></xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                              </xsl:if>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">640</xsl:attribute>
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
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:if test="(/DATA/SYSTEM/@userstatus = 1) and (/DATA/PARAM/@popup = 0)">
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="class">smbutton</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='UpdateExit']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick">doSubmit(9,"")</xsl:attribute>
                                 </xsl:element>
                              </xsl:if>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
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
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

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
                                 <xsl:attribute name="width">640</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">CompanyID</xsl:attribute>
                                 <xsl:attribute name="id">CompanyID</xsl:attribute>
                                 <xsl:attribute name="size">2</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@companyid"/></xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="(/DATA/SYSTEM/@usergroup &gt; 23)">
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">CompanyID</xsl:attribute>
                              <xsl:attribute name="id">CompanyID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@companyid"/></xsl:attribute>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="(/DATA/TXN/PTSMEMBER/@companyid != 21)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">160</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Custom']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">640</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">Role</xsl:attribute>
                                 <xsl:attribute name="id">Role</xsl:attribute>
                                 <xsl:attribute name="size">15</xsl:attribute>
                                 <xsl:attribute name="maxlength">15</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@role"/></xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:if test="(/DATA/TXN/PTSMEMBER/@companyid = 16)">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Credit']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:element name="INPUT">
                                    <xsl:attribute name="type">text</xsl:attribute>
                                    <xsl:attribute name="name">Process</xsl:attribute>
                                    <xsl:attribute name="id">Process</xsl:attribute>
                                    <xsl:attribute name="size">2</xsl:attribute>
                                    <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@process"/></xsl:attribute>
                                    </xsl:element>
                                 </xsl:if>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="(/DATA/TXN/PTSMEMBER/@companyid = 21)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">160</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NexxusRewards']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">640</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="SELECT">
                                    <xsl:attribute name="name">Role</xsl:attribute>
                                    <xsl:attribute name="id">Role</xsl:attribute>
                                    <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@role"/></xsl:variable>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">0</xsl:attribute>
                                       <xsl:if test="$tmp='0'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NotQualified']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">1</xsl:attribute>
                                       <xsl:if test="$tmp='1'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SalesAffiliate']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">2</xsl:attribute>
                                       <xsl:if test="$tmp='2'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Supervisor']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">3</xsl:attribute>
                                       <xsl:if test="$tmp='3'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Manager']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">4</xsl:attribute>
                                       <xsl:if test="$tmp='4'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Director']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">5</xsl:attribute>
                                       <xsl:if test="$tmp='5'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='VP']"/>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">160</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ReferralID']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">640</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">ReferralID</xsl:attribute>
                              <xsl:attribute name="id">ReferralID</xsl:attribute>
                              <xsl:attribute name="size">5</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@referralid"/></xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="font">
                                 <xsl:attribute name="color">blue</xsl:attribute>
                                 <xsl:element name="A">
                                    <xsl:attribute name="onclick">w=window.open(this.href,"Enroller","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                    <xsl:attribute name="href">0403.asp?MemberID=<xsl:value-of select="/DATA/TXN/PTSMEMBER/@referralid"/>&amp;contentpage=3&amp;Popup=1</xsl:attribute>
                                 <xsl:value-of select="/DATA/PARAM/@sponsorname" disable-output-escaping="yes"/>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MentorID']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">MentorID</xsl:attribute>
                              <xsl:attribute name="id">MentorID</xsl:attribute>
                              <xsl:attribute name="size">5</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@mentorid"/></xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:if test="(/DATA/TXN/PTSMEMBER/@companyid = 5)">
                                    <xsl:element name="A">
                                       <xsl:attribute name="href">#_</xsl:attribute>
                                       <xsl:attribute name="onclick">ViewDownlines(<xsl:value-of select="/DATA/TXN/PTSMEMBER/@memberid"/>)</xsl:attribute>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/genealogy.gif</xsl:attribute>
                                          <xsl:attribute name="align">absmiddle</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="A">
                                       <xsl:attribute name="href">#_</xsl:attribute>
                                       <xsl:attribute name="onclick">ViewIncome(<xsl:value-of select="/DATA/TXN/PTSMEMBER/@memberid"/>)</xsl:attribute>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/financesm.gif</xsl:attribute>
                                          <xsl:attribute name="align">absmiddle</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="A">
                                       <xsl:attribute name="onclick">w=window.open(this.href,"Machines","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                       <xsl:attribute name="href">10711.asp?MemberID=<xsl:value-of select="/DATA/TXN/PTSMEMBER/@memberid"/></xsl:attribute>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/machine16.gif</xsl:attribute>
                                          <xsl:attribute name="align">absmiddle</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="A">
                                       <xsl:attribute name="onclick">w=window.open(this.href,"Customers","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                       <xsl:attribute name="href">0449.asp?MemberID=<xsl:value-of select="/DATA/TXN/PTSMEMBER/@memberid"/></xsl:attribute>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/customer16.gif</xsl:attribute>
                                          <xsl:attribute name="align">absmiddle</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                              </xsl:if>
                              <xsl:if test="(/DATA/TXN/PTSMEMBER/@companyid = 9)">
                                    <xsl:element name="A">
                                       <xsl:attribute name="href">#_</xsl:attribute>
                                       <xsl:attribute name="onclick">ViewSponsorTeams(<xsl:value-of select="/DATA/TXN/PTSMEMBER/@memberid"/>)</xsl:attribute>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/genealogy.gif</xsl:attribute>
                                          <xsl:attribute name="align">absmiddle</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                              </xsl:if>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">160</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:if test="(/DATA/TXN/PTSMEMBER/@companyid != 21)">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SponsorID']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/TXN/PTSMEMBER/@companyid = 21)">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ShopperID']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:if>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">640</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">SponsorID</xsl:attribute>
                              <xsl:attribute name="id">SponsorID</xsl:attribute>
                              <xsl:attribute name="size">5</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@sponsorid"/></xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:if test="(/DATA/TXN/PTSMEMBER/@companyid = 13) or (/DATA/TXN/PTSMEMBER/@companyid = 14) or (/DATA/TXN/PTSMEMBER/@companyid = 17)">
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MatrixWidth']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">Process</xsl:attribute>
                                 <xsl:attribute name="id">Process</xsl:attribute>
                                 <xsl:attribute name="size">2</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@process"/></xsl:attribute>
                                 </xsl:element>
                              </xsl:if>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Sponsor2ID']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">Sponsor2ID</xsl:attribute>
                              <xsl:attribute name="id">Sponsor2ID</xsl:attribute>
                              <xsl:attribute name="size">5</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@sponsor2id"/></xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Sponsor3ID']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">Sponsor3ID</xsl:attribute>
                              <xsl:attribute name="id">Sponsor3ID</xsl:attribute>
                              <xsl:attribute name="size">5</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@sponsor3id"/></xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:if test="(/DATA/PARAM/@binary &gt; 0)">
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Pos']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:if test="(/DATA/TXN/PTSMEMBER/@pos = 0)">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BinaryLeft']"/>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/TXN/PTSMEMBER/@pos = 1)">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BinaryRight']"/>
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
                              <xsl:attribute name="width">160</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">640</xsl:attribute>
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
                                 <xsl:attribute name="width">800</xsl:attribute>
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
                                       <xsl:attribute name="width">440</xsl:attribute>
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
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MemberName']"/>
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
                                       <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@namefirst"/></xsl:attribute>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/Required.gif</xsl:attribute>
                                          <xsl:attribute name="alt">Required Field</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">440</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="INPUT">
                                       <xsl:attribute name="type">text</xsl:attribute>
                                       <xsl:attribute name="name">NameLast</xsl:attribute>
                                       <xsl:attribute name="id">NameLast</xsl:attribute>
                                       <xsl:attribute name="size">25</xsl:attribute>
                                       <xsl:attribute name="maxlength">30</xsl:attribute>
                                       <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@namelast"/></xsl:attribute>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/Required.gif</xsl:attribute>
                                          <xsl:attribute name="alt">Required Field</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">160</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">640</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">IsCompany</xsl:attribute>
                              <xsl:attribute name="id">IsCompany</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:if test="(/DATA/TXN/PTSMEMBER/@iscompany = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsCompany']"/>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">160</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CompanyName']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">640</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">CompanyName</xsl:attribute>
                              <xsl:attribute name="id">CompanyName</xsl:attribute>
                              <xsl:attribute name="size">55</xsl:attribute>
                              <xsl:attribute name="maxlength">60</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@companyname"/></xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/TXN/PTSMEMBER/@companyid != 17) or (/DATA/SYSTEM/@usergroup &lt;= 21)">
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
                                 <xsl:attribute name="width">640</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">Email</xsl:attribute>
                                 <xsl:attribute name="id">Email</xsl:attribute>
                                 <xsl:attribute name="size">55</xsl:attribute>
                                 <xsl:attribute name="maxlength">80</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@email"/></xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:element name="IMG">
                                    <xsl:attribute name="src">Images/Required.gif</xsl:attribute>
                                    <xsl:attribute name="alt">Required Field</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/TXN/PTSMEMBER/@companyid = 17) and (/DATA/SYSTEM/@usergroup &gt; 21)">
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Email</xsl:attribute>
                                 <xsl:attribute name="id">Email</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@email"/></xsl:attribute>
                              </xsl:element>

                           <xsl:element name="TR">
                              <xsl:attribute name="height">18</xsl:attribute>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">160</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Email']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">640</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="b">
                                 <xsl:value-of select="/DATA/TXN/PTSMEMBER/@email"/>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="font">
                                    <xsl:attribute name="color">blue</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EmailLocked']"/>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">160</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Email2']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">640</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">Email2</xsl:attribute>
                              <xsl:attribute name="id">Email2</xsl:attribute>
                              <xsl:attribute name="size">55</xsl:attribute>
                              <xsl:attribute name="maxlength">80</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@email2"/></xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="A">
                                    <xsl:attribute name="onclick">w=window.open(this.href,"Help","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                    <xsl:attribute name="href">Page.asp?Page=Email2</xsl:attribute>
                                    <xsl:element name="IMG">
                                       <xsl:attribute name="src">Images/LearnMore.gif</xsl:attribute>
                                       <xsl:attribute name="border">0</xsl:attribute>
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
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">800</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
<xsl:element name="SCRIPT">
   <xsl:attribute name="language">JavaScript</xsl:attribute>
   var MemberTab = new CTabSet("MemberTab"); MemberTab.create(MemberTabDef);
</xsl:element>

                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:attribute name="id">TabNotes</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">800</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IFRAME">
                                 <xsl:attribute name="src"></xsl:attribute>
                                 <xsl:attribute name="width">625</xsl:attribute>
                                 <xsl:attribute name="height">250</xsl:attribute>
                                 <xsl:attribute name="frmheight">250</xsl:attribute>
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
                           <xsl:attribute name="id">TabFolders</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">800</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IFRAME">
                                 <xsl:attribute name="src"></xsl:attribute>
                                 <xsl:attribute name="width">625</xsl:attribute>
                                 <xsl:attribute name="height">200</xsl:attribute>
                                 <xsl:attribute name="frmheight">200</xsl:attribute>
                                 <xsl:attribute name="id">FoldersFrame</xsl:attribute>
                                 <xsl:attribute name="name">FoldersFrame</xsl:attribute>
                                 <xsl:attribute name="class">FrameNoScroll</xsl:attribute>
                                 <xsl:attribute name="frameborder">0</xsl:attribute>
                                 <xsl:element name="A">
                                    <xsl:attribute name="href"></xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoFrameSupport']"/>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/TXN/PTSMEMBER/@ismsg = 1)">
                           <xsl:element name="TR">
                              <xsl:attribute name="id">TabMsgs</xsl:attribute>
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">800</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="IFRAME">
                                    <xsl:attribute name="src"></xsl:attribute>
                                    <xsl:attribute name="width">625</xsl:attribute>
                                    <xsl:attribute name="height">1000</xsl:attribute>
                                    <xsl:attribute name="frmheight">1000</xsl:attribute>
                                    <xsl:attribute name="id">MsgsFrame</xsl:attribute>
                                    <xsl:attribute name="name">MsgsFrame</xsl:attribute>
                                    <xsl:attribute name="class">FrameNoScroll</xsl:attribute>
                                    <xsl:attribute name="frameborder">0</xsl:attribute>
                                    <xsl:element name="A">
                                       <xsl:attribute name="href"></xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoFrameSupport']"/>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="(/DATA/TXN/PTSMEMBER/@ismsg != 1)">
                           <xsl:element name="TR">
                              <xsl:attribute name="id">TabMsgs</xsl:attribute>
                           </xsl:element>
                        </xsl:if>

                        <xsl:element name="TR">
                           <xsl:attribute name="id">TabStatus</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">800</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">800</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">640</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23) or (/DATA/SYSTEM/@usergroup = 51) or (/DATA/SYSTEM/@usergroup = 52)">
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
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EnrollDate']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">640</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">text</xsl:attribute>
                                             <xsl:attribute name="name">EnrollDate</xsl:attribute>
                                             <xsl:attribute name="id">EnrollDate</xsl:attribute>
                                             <xsl:attribute name="size">15</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@enrolldate"/></xsl:attribute>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="name">Calendar</xsl:attribute>
                                                <xsl:attribute name="src">Images/Calendar.gif</xsl:attribute>
                                                <xsl:attribute name="width">16</xsl:attribute>
                                                <xsl:attribute name="height">16</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                                <xsl:attribute name="onclick">CalendarPopup(document.forms[0], document.getElementById('EnrollDate'))</xsl:attribute>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="src">Images/Required.gif</xsl:attribute>
                                                <xsl:attribute name="alt">Required Field</xsl:attribute>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EndDate']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">text</xsl:attribute>
                                             <xsl:attribute name="name">EndDate</xsl:attribute>
                                             <xsl:attribute name="id">EndDate</xsl:attribute>
                                             <xsl:attribute name="size">10</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@enddate"/></xsl:attribute>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="name">Calendar</xsl:attribute>
                                                <xsl:attribute name="src">Images/Calendar.gif</xsl:attribute>
                                                <xsl:attribute name="width">16</xsl:attribute>
                                                <xsl:attribute name="height">16</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                                <xsl:attribute name="onclick">CalendarPopup(document.forms[0], document.getElementById('EndDate'))</xsl:attribute>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:if test="(/DATA/SYSTEM/@usergroup = 1) or (/DATA/SYSTEM/@usergroup = 51)">
                                                <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">button</xsl:attribute>
                                                   <xsl:attribute name="class">smbutton</xsl:attribute>
                                                   <xsl:attribute name="value">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EditBVQV']"/>
                                                   </xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[EditBVQV()]]></xsl:text></xsl:attribute>
                                                </xsl:element>
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
                                             <xsl:attribute name="width">160</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">640</xsl:attribute>
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
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Status']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">640</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="SELECT">
                                                <xsl:attribute name="name">Status</xsl:attribute>
                                                <xsl:attribute name="id">Status</xsl:attribute>
                                                <xsl:for-each select="/DATA/TXN/PTSMEMBER/PTSSTATUSS/ENUM">
                                                   <xsl:element name="OPTION">
                                                      <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                                      <xsl:if test="@selected"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:variable name="tmp1"><xsl:value-of select="current()/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp1]"/>
                                                   </xsl:element>
                                                </xsl:for-each>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:if test="(/DATA/PARAM/@companyid &gt;= 5)">
                                                <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">button</xsl:attribute>
                                                   <xsl:attribute name="class">smbutton</xsl:attribute>
                                                   <xsl:attribute name="value">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MoveDownline']"/>
                                                   </xsl:attribute>
                                                   <xsl:attribute name="onclick">doSubmit(13,'<xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ConfirmMove']"/>')</xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:if test="(/DATA/TXN/PTSMEMBER/@isremoved = 0) and ((/DATA/TXN/PTSMEMBER/@status = 1) or (/DATA/TXN/PTSMEMBER/@status = 3) or (/DATA/TXN/PTSMEMBER/@status = 5))">
                                                <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">button</xsl:attribute>
                                                   <xsl:attribute name="class">smbutton</xsl:attribute>
                                                   <xsl:attribute name="value">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ChangeStatus']"/>
                                                   </xsl:attribute>
                                                   <xsl:attribute name="onclick">doSubmit(8,"")</xsl:attribute>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">checkbox</xsl:attribute>
                                             <xsl:attribute name="name">IsRemoved</xsl:attribute>
                                             <xsl:attribute name="id">IsRemoved</xsl:attribute>
                                             <xsl:attribute name="value">1</xsl:attribute>
                                             <xsl:if test="(/DATA/TXN/PTSMEMBER/@isremoved = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsRemoved']"/>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">160</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Level']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">640</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">text</xsl:attribute>
                                             <xsl:attribute name="name">Level</xsl:attribute>
                                             <xsl:attribute name="id">Level</xsl:attribute>
                                             <xsl:attribute name="size">2</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@level"/></xsl:attribute>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TrialDays']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">text</xsl:attribute>
                                             <xsl:attribute name="name">TrialDays</xsl:attribute>
                                             <xsl:attribute name="id">TrialDays</xsl:attribute>
                                             <xsl:attribute name="size">2</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@trialdays"/></xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">160</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StatusDate']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">640</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">text</xsl:attribute>
                                             <xsl:attribute name="name">StatusDate</xsl:attribute>
                                             <xsl:attribute name="id">StatusDate</xsl:attribute>
                                             <xsl:attribute name="size">10</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@statusdate"/></xsl:attribute>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="name">Calendar</xsl:attribute>
                                                <xsl:attribute name="src">Images/Calendar.gif</xsl:attribute>
                                                <xsl:attribute name="width">16</xsl:attribute>
                                                <xsl:attribute name="height">16</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                                <xsl:attribute name="onclick">CalendarPopup(document.forms[0], document.getElementById('StatusDate'))</xsl:attribute>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StatusChange']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="SELECT">
                                                <xsl:attribute name="name">StatusChange</xsl:attribute>
                                                <xsl:attribute name="id">StatusChange</xsl:attribute>
                                                <xsl:for-each select="/DATA/TXN/PTSMEMBER/PTSSTATUSCHANGES/ENUM">
                                                   <xsl:element name="OPTION">
                                                      <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                                      <xsl:if test="@selected"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:variable name="tmp3"><xsl:value-of select="current()/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp3]"/>
                                                   </xsl:element>
                                                </xsl:for-each>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LevelChange']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">text</xsl:attribute>
                                             <xsl:attribute name="name">LevelChange</xsl:attribute>
                                             <xsl:attribute name="id">LevelChange</xsl:attribute>
                                             <xsl:attribute name="size">1</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@levelchange"/></xsl:attribute>
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
                                             <xsl:attribute name="width">640</xsl:attribute>
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

                                       <xsl:if test="(count(/DATA/TXN/PTSTITLES/ENUM) &gt; 1)">
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
                                                <xsl:attribute name="width">640</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="SELECT">
                                                   <xsl:attribute name="name">Title</xsl:attribute>
                                                   <xsl:attribute name="id">Title</xsl:attribute>
                                                   <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@title"/></xsl:variable>
                                                   <xsl:for-each select="/DATA/TXN/PTSTITLES/ENUM">
                                                      <xsl:element name="OPTION">
                                                         <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                                         <xsl:if test="$tmp=@id"><xsl:attribute name="SELECTED"/></xsl:if>
                                                         <xsl:value-of select="@name"/>
                                                      </xsl:element>
                                                   </xsl:for-each>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, 'v')) or (/DATA/SYSTEM/@usergroup != 41)">
                                                   <xsl:element name="INPUT">
                                                      <xsl:attribute name="type">button</xsl:attribute>
                                                      <xsl:attribute name="class">smbutton</xsl:attribute>
                                                      <xsl:attribute name="value">
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TitleHistory']"/>
                                                      </xsl:attribute>
                                                      <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[ViewTitles()]]></xsl:text></xsl:attribute>
                                                   </xsl:element>
                                                </xsl:if>
                                             </xsl:element>
                                          </xsl:element>

                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">160</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Title2']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">640</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="SELECT">
                                                   <xsl:attribute name="name">Title2</xsl:attribute>
                                                   <xsl:attribute name="id">Title2</xsl:attribute>
                                                   <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@title2"/></xsl:variable>
                                                   <xsl:for-each select="/DATA/TXN/PTSTITLES/ENUM">
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
                                                <xsl:attribute name="width">160</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MinTitle']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">640</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="SELECT">
                                                   <xsl:attribute name="name">MinTitle</xsl:attribute>
                                                   <xsl:attribute name="id">MinTitle</xsl:attribute>
                                                   <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@mintitle"/></xsl:variable>
                                                   <xsl:for-each select="/DATA/TXN/PTSTITLES/ENUM">
                                                      <xsl:element name="OPTION">
                                                         <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                                         <xsl:if test="$tmp=@id"><xsl:attribute name="SELECTED"/></xsl:if>
                                                         <xsl:value-of select="@name"/>
                                                      </xsl:element>
                                                   </xsl:for-each>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TitleDate']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">text</xsl:attribute>
                                                <xsl:attribute name="name">TitleDate</xsl:attribute>
                                                <xsl:attribute name="id">TitleDate</xsl:attribute>
                                                <xsl:attribute name="size">10</xsl:attribute>
                                                <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@titledate"/></xsl:attribute>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="name">Calendar</xsl:attribute>
                                                   <xsl:attribute name="src">Images/Calendar.gif</xsl:attribute>
                                                   <xsl:attribute name="width">16</xsl:attribute>
                                                   <xsl:attribute name="height">16</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick">CalendarPopup(document.forms[0], document.getElementById('TitleDate'))</xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:element>

                                       </xsl:if>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">160</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Qualify']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">640</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="SELECT">
                                                <xsl:attribute name="name">Qualify</xsl:attribute>
                                                <xsl:attribute name="id">Qualify</xsl:attribute>
                                                <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@qualify"/></xsl:variable>
                                                <xsl:element name="OPTION">
                                                   <xsl:attribute name="value">0</xsl:attribute>
                                                   <xsl:if test="$tmp='0'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                </xsl:element>
                                                <xsl:element name="OPTION">
                                                   <xsl:attribute name="value">1</xsl:attribute>
                                                   <xsl:if test="$tmp='1'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='QualifyNo']"/>
                                                </xsl:element>
                                                <xsl:element name="OPTION">
                                                   <xsl:attribute name="value">2</xsl:attribute>
                                                   <xsl:if test="$tmp='2'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='QualifyYes']"/>
                                                </xsl:element>
                                                <xsl:element name="OPTION">
                                                   <xsl:attribute name="value">3</xsl:attribute>
                                                   <xsl:if test="$tmp='3'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='QualifyLock']"/>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='QualifyDate']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">text</xsl:attribute>
                                             <xsl:attribute name="name">QualifyDate</xsl:attribute>
                                             <xsl:attribute name="id">QualifyDate</xsl:attribute>
                                             <xsl:attribute name="size">10</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@qualifydate"/></xsl:attribute>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="name">Calendar</xsl:attribute>
                                                <xsl:attribute name="src">Images/Calendar.gif</xsl:attribute>
                                                <xsl:attribute name="width">16</xsl:attribute>
                                                <xsl:attribute name="height">16</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                                <xsl:attribute name="onclick">CalendarPopup(document.forms[0], document.getElementById('QualifyDate'))</xsl:attribute>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="font">
                                                <xsl:attribute name="color">blue</xsl:attribute>
                                             (<xsl:value-of select="concat(/DATA/TXN/PTSMEMBER/@bv, '|',/DATA/TXN/PTSMEMBER/@qv)"/>)
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="font">
                                                <xsl:attribute name="color">purple</xsl:attribute>
                                             (<xsl:value-of select="/DATA/TXN/PTSMEMBER/@qv4"/>)
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">160</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">640</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">checkbox</xsl:attribute>
                                             <xsl:attribute name="name">IsIncluded</xsl:attribute>
                                             <xsl:attribute name="id">IsIncluded</xsl:attribute>
                                             <xsl:attribute name="value">1</xsl:attribute>
                                             <xsl:if test="(/DATA/TXN/PTSMEMBER/@isincluded = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsIncluded']"/>
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
                                             <xsl:attribute name="width">160</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsMsg']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">640</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="SELECT">
                                                <xsl:attribute name="name">IsMsg</xsl:attribute>
                                                <xsl:attribute name="id">IsMsg</xsl:attribute>
                                                <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@ismsg"/></xsl:variable>
                                                <xsl:element name="OPTION">
                                                   <xsl:attribute name="value">0</xsl:attribute>
                                                   <xsl:if test="$tmp='0'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Msg-Off']"/>
                                                </xsl:element>
                                                <xsl:element name="OPTION">
                                                   <xsl:attribute name="value">1</xsl:attribute>
                                                   <xsl:if test="$tmp='1'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Msg-On']"/>
                                                </xsl:element>
                                                <xsl:element name="OPTION">
                                                   <xsl:attribute name="value">2</xsl:attribute>
                                                   <xsl:if test="$tmp='2'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Msg-Unsubscribe']"/>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                    </xsl:if>
                                    <xsl:if test="(/DATA/SYSTEM/@usergroup &gt; 23) and (/DATA/SYSTEM/@usergroup != 51) and (/DATA/SYSTEM/@usergroup != 52)">
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">hidden</xsl:attribute>
                                             <xsl:attribute name="name">EnrollDate</xsl:attribute>
                                             <xsl:attribute name="id">EnrollDate</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@enrolldate"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">hidden</xsl:attribute>
                                             <xsl:attribute name="name">EndDate</xsl:attribute>
                                             <xsl:attribute name="id">EndDate</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@enddate"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">hidden</xsl:attribute>
                                             <xsl:attribute name="name">PaidDate</xsl:attribute>
                                             <xsl:attribute name="id">PaidDate</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@paiddate"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">hidden</xsl:attribute>
                                             <xsl:attribute name="name">AutoShipDate</xsl:attribute>
                                             <xsl:attribute name="id">AutoShipDate</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@autoshipdate"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">hidden</xsl:attribute>
                                             <xsl:attribute name="name">Title</xsl:attribute>
                                             <xsl:attribute name="id">Title</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@title"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">hidden</xsl:attribute>
                                             <xsl:attribute name="name">MinTitle</xsl:attribute>
                                             <xsl:attribute name="id">MinTitle</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@mintitle"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">hidden</xsl:attribute>
                                             <xsl:attribute name="name">TitleDate</xsl:attribute>
                                             <xsl:attribute name="id">TitleDate</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@titledate"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">hidden</xsl:attribute>
                                             <xsl:attribute name="name">Qualify</xsl:attribute>
                                             <xsl:attribute name="id">Qualify</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@qualify"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">hidden</xsl:attribute>
                                             <xsl:attribute name="name">QualifyDate</xsl:attribute>
                                             <xsl:attribute name="id">QualifyDate</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@qualifydate"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">hidden</xsl:attribute>
                                             <xsl:attribute name="name">Status</xsl:attribute>
                                             <xsl:attribute name="id">Status</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@status"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">hidden</xsl:attribute>
                                             <xsl:attribute name="name">IsRemoved</xsl:attribute>
                                             <xsl:attribute name="id">IsRemoved</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@isremoved"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">hidden</xsl:attribute>
                                             <xsl:attribute name="name">Level</xsl:attribute>
                                             <xsl:attribute name="id">Level</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@level"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">hidden</xsl:attribute>
                                             <xsl:attribute name="name">StatusDate</xsl:attribute>
                                             <xsl:attribute name="id">StatusDate</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@statusdate"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">hidden</xsl:attribute>
                                             <xsl:attribute name="name">StatusChange</xsl:attribute>
                                             <xsl:attribute name="id">StatusChange</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@statuschange"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">hidden</xsl:attribute>
                                             <xsl:attribute name="name">LevelChange</xsl:attribute>
                                             <xsl:attribute name="id">LevelChange</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@levelchange"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">hidden</xsl:attribute>
                                             <xsl:attribute name="name">TrialDays</xsl:attribute>
                                             <xsl:attribute name="id">TrialDays</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@trialdays"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">hidden</xsl:attribute>
                                             <xsl:attribute name="name">Process</xsl:attribute>
                                             <xsl:attribute name="id">Process</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@process"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">hidden</xsl:attribute>
                                             <xsl:attribute name="name">BusAccts</xsl:attribute>
                                             <xsl:attribute name="id">BusAccts</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@busaccts"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">hidden</xsl:attribute>
                                             <xsl:attribute name="name">MaxMembers</xsl:attribute>
                                             <xsl:attribute name="id">MaxMembers</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@maxmembers"/></xsl:attribute>
                                          </xsl:element>

                                       <xsl:if test="(/DATA/SYSTEM/@usermode = 10)">
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
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Status']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">640</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:variable name="tmp1"><xsl:value-of select="/DATA/TXN/PTSMEMBER/PTSSTATUSS/ENUM[@id=/DATA/TXN/PTSMEMBER/@status]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp1]"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:if test="(/DATA/TXN/PTSMEMBER/@status = 1) or (/DATA/TXN/PTSMEMBER/@status = 3) or (/DATA/TXN/PTSMEMBER/@status = 5)">
                                                   <xsl:element name="INPUT">
                                                      <xsl:attribute name="type">button</xsl:attribute>
                                                      <xsl:attribute name="value">
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ChangeStatus']"/>
                                                      </xsl:attribute>
                                                      <xsl:attribute name="onclick">doSubmit(8,"")</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:if>
                                             </xsl:element>
                                          </xsl:element>

                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">160</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Level']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">640</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/TXN/PTSMEMBER/@level"/>
                                             </xsl:element>
                                          </xsl:element>

                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">160</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EnrollDate']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">640</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/TXN/PTSMEMBER/@enrolldate"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EndDate']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/TXN/PTSMEMBER/@enddate"/>
                                             </xsl:element>
                                          </xsl:element>

                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">160</xsl:attribute>
                                                <xsl:attribute name="height">18</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PaidDate']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">640</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/TXN/PTSMEMBER/@paiddate"/>
                                             </xsl:element>
                                          </xsl:element>

                                          <xsl:if test="(/DATA/TXN/PTSMEMBER/@statuschange != 0)">
                                             <xsl:element name="TR">
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">160</xsl:attribute>
                                                   <xsl:attribute name="height">18</xsl:attribute>
                                                   <xsl:attribute name="align">right</xsl:attribute>
                                                   <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StatusDate']"/>
                                                   <xsl:text>:</xsl:text>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                </xsl:element>
                                                <xsl:element name="TD">
                                                   <xsl:attribute name="width">640</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:value-of select="/DATA/TXN/PTSMEMBER/@statusdate"/>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StatusChange']"/>
                                                   <xsl:text>:</xsl:text>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:variable name="tmp3"><xsl:value-of select="/DATA/TXN/PTSMEMBER/PTSSTATUSCHANGES/ENUM[@id=/DATA/TXN/PTSMEMBER/@statuschange]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp3]"/>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LevelChange']"/>
                                                   <xsl:text>:</xsl:text>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/TXN/PTSMEMBER/@levelchange"/>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:if>

                                          <xsl:variable name="tmpTitle"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@title"/></xsl:variable>

                                          <xsl:if test="(count(/DATA/TXN/PTSTITLES/ENUM) &gt; 1)">
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
                                                   <xsl:attribute name="width">640</xsl:attribute>
                                                   <xsl:attribute name="align">left</xsl:attribute>
                                                   <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:value-of select="/DATA/TXN/PTSTITLES/ENUM[@id=$tmpTitle]/@name"/>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="color">blue</xsl:attribute>
                                                   (<xsl:value-of select="concat(/DATA/TXN/PTSMEMBER/@bv, '|',/DATA/TXN/PTSMEMBER/@qv)"/>)
                                                   </xsl:element>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:if>

                                       </xsl:if>
                                    </xsl:if>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:attribute name="id">TabBilling</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">800</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">800</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">640</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23) or (/DATA/SYSTEM/@usergroup = 51)">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="height">6</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="width">800</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/financesm.gif</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                </xsl:element>
                                             <xsl:if test="(/DATA/TXN/PTSMEMBER/@billingid = 0)">
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/newnote.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                             </xsl:if>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="onclick">w=window.open(this.href,"Billing","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                   <xsl:attribute name="href">0436.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/></xsl:attribute>
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BillingMethod']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                </xsl:element>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/PARAM/@billingmethod" disable-output-escaping="yes"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:if>

                                    <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23) or (/DATA/SYSTEM/@usergroup = 51)">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="width">800</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/financesm.gif</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                </xsl:element>
                                             <xsl:if test="(/DATA/TXN/PTSMEMBER/@payid = 0)">
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/newnote.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                             </xsl:if>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="onclick">w=window.open(this.href,"Payout","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                   <xsl:attribute name="href">0441.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/></xsl:attribute>
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PayoutMethod']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/PARAM/@payoutmethod" disable-output-escaping="yes"/>
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
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Billing']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">640</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="SELECT">
                                             <xsl:attribute name="name">Billing</xsl:attribute>
                                             <xsl:attribute name="id">Billing</xsl:attribute>
                                             <xsl:for-each select="/DATA/TXN/PTSMEMBER/PTSBILLINGS/ENUM">
                                                <xsl:element name="OPTION">
                                                   <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                                   <xsl:if test="@selected"><xsl:attribute name="SELECTED"/></xsl:if>
                                                   <xsl:variable name="tmp1"><xsl:value-of select="current()/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp1]"/>
                                                </xsl:element>
                                             </xsl:for-each>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:if test="(/DATA/TXN/PTSMEMBER/@companyid = 2) or (/DATA/TXN/PTSMEMBER/@companyid = 5) or (/DATA/TXN/PTSMEMBER/@companyid = 6) or (/DATA/TXN/PTSMEMBER/@companyid = 7)">
                                             <xsl:element name="INPUT">
                                                <xsl:attribute name="type">button</xsl:attribute>
                                                <xsl:attribute name="class">smbutton</xsl:attribute>
                                                <xsl:attribute name="value">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CreditPayment']"/>
                                                </xsl:attribute>
                                                <xsl:attribute name="onclick">doSubmit(12,'<xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ConfirmCredit']"/>')</xsl:attribute>
                                             </xsl:element>
                                          </xsl:if>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:if test="(/DATA/TXN/PTSMEMBER/@companyid = 5)">
                                             <xsl:element name="INPUT">
                                                <xsl:attribute name="type">button</xsl:attribute>
                                                <xsl:attribute name="class">smbutton</xsl:attribute>
                                                <xsl:attribute name="value">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PayPalPayment']"/>
                                                </xsl:attribute>
                                                <xsl:attribute name="onclick">doSubmit(15,'<xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ConfirmPayPal']"/>')</xsl:attribute>
                                             </xsl:element>
                                          </xsl:if>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PaidDate']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">640</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">PaidDate</xsl:attribute>
                                          <xsl:attribute name="id">PaidDate</xsl:attribute>
                                          <xsl:attribute name="size">10</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@paiddate"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="name">Calendar</xsl:attribute>
                                             <xsl:attribute name="src">Images/Calendar.gif</xsl:attribute>
                                             <xsl:attribute name="width">16</xsl:attribute>
                                             <xsl:attribute name="height">16</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="onclick">CalendarPopup(document.forms[0], document.getElementById('PaidDate'))</xsl:attribute>
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
                                          <xsl:attribute name="width">640</xsl:attribute>
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
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Price']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">640</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Price</xsl:attribute>
                                          <xsl:attribute name="id">Price</xsl:attribute>
                                          <xsl:attribute name="size">8</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@price"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='InitPrice']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">InitPrice</xsl:attribute>
                                          <xsl:attribute name="id">InitPrice</xsl:attribute>
                                          <xsl:attribute name="size">8</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@initprice"/></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Options2']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">640</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Options2</xsl:attribute>
                                          <xsl:attribute name="id">Options2</xsl:attribute>
                                          <xsl:attribute name="size">40</xsl:attribute>
                                          <xsl:attribute name="maxlength">40</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@options2"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="A">
                                                <xsl:attribute name="onclick">w=window.open(this.href,"Help","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                <xsl:attribute name="href">Page.asp?Page=MemberOptions2</xsl:attribute>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/LearnMore.gif</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
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

                        <xsl:element name="TR">
                           <xsl:attribute name="id">TabGroup</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">800</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">800</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">640</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23) or (not(contains(/DATA/SYSTEM/@useroptions, '~:')))">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">160</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GroupID']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">640</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">text</xsl:attribute>
                                             <xsl:attribute name="name">GroupID</xsl:attribute>
                                             <xsl:attribute name="id">GroupID</xsl:attribute>
                                             <xsl:attribute name="size">10</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@groupid"/></xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:if>

                                    <xsl:if test="(/DATA/SYSTEM/@usergroup &gt; 23) and (contains(/DATA/SYSTEM/@useroptions, '~^'))">
                                       <xsl:element name="INPUT">
                                          <xsl:attribute name="type">hidden</xsl:attribute>
                                          <xsl:attribute name="name">GroupID</xsl:attribute>
                                          <xsl:attribute name="id">GroupID</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@groupid"/></xsl:attribute>
                                       </xsl:element>
                                    </xsl:if>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:if test="(/DATA/PARAM/@refname != '')">
                                                <xsl:value-of select="/DATA/PARAM/@refname" disable-output-escaping="yes"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/PARAM/@refname = '')">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Reference']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:if>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">640</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Reference</xsl:attribute>
                                          <xsl:attribute name="id">Reference</xsl:attribute>
                                          <xsl:attribute name="size">15</xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@reference"/></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Referring']"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:if test="(/DATA/PARAM/@refname != '')">
                                                <xsl:value-of select="/DATA/PARAM/@refname" disable-output-escaping="yes"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/PARAM/@refname = '')">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Reference']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:if>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">640</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Referral</xsl:attribute>
                                          <xsl:attribute name="id">Referral</xsl:attribute>
                                          <xsl:attribute name="size">15</xsl:attribute>
                                          <xsl:attribute name="maxlength">15</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@referral"/></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='WalletName']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">640</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">ConfLine</xsl:attribute>
                                          <xsl:attribute name="id">ConfLine</xsl:attribute>
                                          <xsl:attribute name="size">30</xsl:attribute>
                                          <xsl:attribute name="maxlength">40</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@confline"/></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:attribute name="id">TabAccess</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">800</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">800</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">640</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
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
                                          <xsl:attribute name="width">800</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">prompt</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='OptionsText']"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
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
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Options']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">640</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Options</xsl:attribute>
                                          <xsl:attribute name="id">Options</xsl:attribute>
                                          <xsl:attribute name="size">20</xsl:attribute>
                                          <xsl:attribute name="maxlength">20</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@options"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">button</xsl:attribute>
                                             <xsl:attribute name="class">smbutton</xsl:attribute>
                                             <xsl:attribute name="value">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/>
                                             </xsl:attribute>
                                             <xsl:attribute name="onclick">doSubmit(16,"")</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">2</xsl:attribute>
                                          <xsl:attribute name="height">6</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:if test="(/DATA/PARAM/@options != '')">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">160</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='DefaultOptions']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">640</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/PARAM/@options" disable-output-escaping="yes"/>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="height">6</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:if>

                                    <xsl:if test="(/DATA/PARAM/@binary &gt; 0)">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">160</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Pos']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">640</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="SELECT">
                                                <xsl:attribute name="name">Pos</xsl:attribute>
                                                <xsl:attribute name="id">Pos</xsl:attribute>
                                                <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@pos"/></xsl:variable>
                                                <xsl:element name="OPTION">
                                                   <xsl:attribute name="value">0</xsl:attribute>
                                                   <xsl:if test="$tmp='0'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BinaryLeft']"/>
                                                </xsl:element>
                                                <xsl:element name="OPTION">
                                                   <xsl:attribute name="value">1</xsl:attribute>
                                                   <xsl:if test="$tmp='1'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BinaryRight']"/>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BinaryPlacement']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="SELECT">
                                                <xsl:attribute name="name">Binary</xsl:attribute>
                                                <xsl:attribute name="id">Binary</xsl:attribute>
                                                <xsl:variable name="tmp"><xsl:value-of select="/DATA/PARAM/@binary"/></xsl:variable>
                                                <xsl:element name="OPTION">
                                                   <xsl:attribute name="value">1</xsl:attribute>
                                                   <xsl:if test="$tmp='1'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PlaceWeak']"/>
                                                </xsl:element>
                                                <xsl:element name="OPTION">
                                                   <xsl:attribute name="value">4</xsl:attribute>
                                                   <xsl:if test="$tmp='4'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PlaceStrong']"/>
                                                </xsl:element>
                                                <xsl:element name="OPTION">
                                                   <xsl:attribute name="value">2</xsl:attribute>
                                                   <xsl:if test="$tmp='2'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PlaceLeft']"/>
                                                </xsl:element>
                                                <xsl:element name="OPTION">
                                                   <xsl:attribute name="value">3</xsl:attribute>
                                                   <xsl:if test="$tmp='3'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PlaceRight']"/>
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
                                    </xsl:if>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">800</xsl:attribute>
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
                                          <xsl:attribute name="width">800</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">prompt</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SecurityLevelText']"/>
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
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Secure']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">640</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Secure</xsl:attribute>
                                          <xsl:attribute name="id">Secure</xsl:attribute>
                                          <xsl:attribute name="size">2</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@secure"/></xsl:attribute>
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
                                          <xsl:attribute name="width">800</xsl:attribute>
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
                                          <xsl:attribute name="width">800</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">prompt</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AccessLimitText']"/>
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
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AccessLimit']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">640</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">AccessLimit</xsl:attribute>
                                          <xsl:attribute name="id">AccessLimit</xsl:attribute>
                                          <xsl:attribute name="size">50</xsl:attribute>
                                          <xsl:attribute name="maxlength">50</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@accesslimit"/></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='QuizLimit']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">640</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="SELECT">
                                             <xsl:attribute name="name">QuizLimit</xsl:attribute>
                                             <xsl:attribute name="id">QuizLimit</xsl:attribute>
                                             <xsl:for-each select="/DATA/TXN/PTSMEMBER/PTSQUIZLIMITS/ENUM">
                                                <xsl:element name="OPTION">
                                                   <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                                   <xsl:if test="@selected"><xsl:attribute name="SELECTED"/></xsl:if>
                                                   <xsl:variable name="tmp1"><xsl:value-of select="current()/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp1]"/>
                                                </xsl:element>
                                             </xsl:for-each>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 22)">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="height">6</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">800</xsl:attribute>
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
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Identification']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">640</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="TEXTAREA">
                                                <xsl:attribute name="name">Identification</xsl:attribute>
                                                <xsl:attribute name="id">Identification</xsl:attribute>
                                                <xsl:attribute name="rows">2</xsl:attribute>
                                                <xsl:attribute name="cols">50</xsl:attribute>
                                                <xsl:attribute name="onkeyup"><xsl:text disable-output-escaping="yes"><![CDATA[if (value.length>150) {doMaxLenMsg(150); value=value.substring(0,150);}]]></xsl:text></xsl:attribute>
                                                <xsl:value-of select="/DATA/TXN/PTSMEMBER/@identification"/>
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
                                             <xsl:attribute name="width">800</xsl:attribute>
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
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='UserAccess']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">640</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="SELECT">
                                                <xsl:attribute name="name">UserGroup</xsl:attribute>
                                                <xsl:attribute name="id">UserGroup</xsl:attribute>
                                                <xsl:for-each select="/DATA/TXN/PTSMEMBER/PTSUSERGROUPS/ENUM">
                                                   <xsl:element name="OPTION">
                                                      <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                                      <xsl:if test="@selected"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:variable name="tmp1"><xsl:value-of select="current()/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp1]"/>
                                                   </xsl:element>
                                                </xsl:for-each>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="SELECT">
                                                <xsl:attribute name="name">UserStatus</xsl:attribute>
                                                <xsl:attribute name="id">UserStatus</xsl:attribute>
                                                <xsl:for-each select="/DATA/TXN/PTSMEMBER/PTSUSERSTATUSS/ENUM">
                                                   <xsl:element name="OPTION">
                                                      <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                                      <xsl:if test="@selected"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:variable name="tmp2"><xsl:value-of select="current()/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp2]"/>
                                                   </xsl:element>
                                                </xsl:for-each>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                    </xsl:if>
                                    <xsl:if test="(/DATA/SYSTEM/@usergroup &gt; 22)">
                                       <xsl:element name="INPUT">
                                          <xsl:attribute name="type">hidden</xsl:attribute>
                                          <xsl:attribute name="name">Identification</xsl:attribute>
                                          <xsl:attribute name="id">Identification</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@identification"/></xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="INPUT">
                                          <xsl:attribute name="type">hidden</xsl:attribute>
                                          <xsl:attribute name="name">UserGroup</xsl:attribute>
                                          <xsl:attribute name="id">UserGroup</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@usergroup"/></xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="INPUT">
                                          <xsl:attribute name="type">hidden</xsl:attribute>
                                          <xsl:attribute name="name">UserStatus</xsl:attribute>
                                          <xsl:attribute name="id">UserStatus</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@userstatus"/></xsl:attribute>
                                       </xsl:element>
                                    </xsl:if>

                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:attribute name="id">TabContact</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">800</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">800</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">640</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">2</xsl:attribute>
                                          <xsl:attribute name="width">800</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, 'q')) and (/DATA/PARAM/@extra != 0)">
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
                                          <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, 't'))">
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
                                          <xsl:attribute name="width">800</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="IFRAME">
                                             <xsl:attribute name="src"></xsl:attribute>
                                             <xsl:attribute name="width">625</xsl:attribute>
                                             <xsl:attribute name="height">180</xsl:attribute>
                                             <xsl:attribute name="frmheight">180</xsl:attribute>
                                             <xsl:attribute name="id">AddressFrame</xsl:attribute>
                                             <xsl:attribute name="name">AddressFrame</xsl:attribute>
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
                                          <xsl:attribute name="width">800</xsl:attribute>
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
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Phone1']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">640</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Phone1</xsl:attribute>
                                          <xsl:attribute name="id">Phone1</xsl:attribute>
                                          <xsl:attribute name="size">30</xsl:attribute>
                                          <xsl:attribute name="maxlength">30</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@phone1"/></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Phone2']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">640</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Phone2</xsl:attribute>
                                          <xsl:attribute name="id">Phone2</xsl:attribute>
                                          <xsl:attribute name="size">30</xsl:attribute>
                                          <xsl:attribute name="maxlength">30</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@phone2"/></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Fax']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">640</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Fax</xsl:attribute>
                                          <xsl:attribute name="id">Fax</xsl:attribute>
                                          <xsl:attribute name="size">30</xsl:attribute>
                                          <xsl:attribute name="maxlength">30</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@fax"/></xsl:attribute>
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
                                          <xsl:attribute name="width">800</xsl:attribute>
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

                                    <xsl:if test="(count(DATA/TXN/PTSLANGUAGES/ENUM) != 0)">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="height">3</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">160</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PreferredLanguage']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">640</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="SELECT">
                                                <xsl:attribute name="name">Icons</xsl:attribute>
                                                <xsl:attribute name="id">Icons</xsl:attribute>
                                                <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@icons"/></xsl:variable>
                                                <xsl:for-each select="/DATA/TXN/PTSLANGUAGES/ENUM">
                                                   <xsl:element name="OPTION">
                                                      <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                                      <xsl:if test="$tmp=@id"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:value-of select="@name"/>
                                                   </xsl:element>
                                                </xsl:for-each>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:if>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">2</xsl:attribute>
                                          <xsl:attribute name="height">3</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AutoShipDate']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">640</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">AutoShipDate</xsl:attribute>
                                          <xsl:attribute name="id">AutoShipDate</xsl:attribute>
                                          <xsl:attribute name="size">10</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@autoshipdate"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="name">Calendar</xsl:attribute>
                                             <xsl:attribute name="src">Images/Calendar.gif</xsl:attribute>
                                             <xsl:attribute name="width">16</xsl:attribute>
                                             <xsl:attribute name="height">16</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="onclick">CalendarPopup(document.forms[0], document.getElementById('AutoShipDate'))</xsl:attribute>
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
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Timezone']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">640</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="SELECT">
                                             <xsl:attribute name="name">Timezone</xsl:attribute>
                                             <xsl:attribute name="id">Timezone</xsl:attribute>
                                             <xsl:for-each select="/DATA/TXN/PTSMEMBER/PTSTIMEZONES/ENUM">
                                                <xsl:element name="OPTION">
                                                   <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                                   <xsl:if test="@selected"><xsl:attribute name="SELECTED"/></xsl:if>
                                                   <xsl:variable name="tmp1"><xsl:value-of select="current()/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp1]"/>
                                                </xsl:element>
                                             </xsl:for-each>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, 'x')) or (/DATA/SYSTEM/@usergroup &lt;= 23) or (/DATA/SYSTEM/@usergroup = 51) or (/DATA/SYSTEM/@usergroup = 52)">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="height">3</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">160</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Govid']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">640</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:variable name="tmp1"><xsl:value-of select="/DATA/TXN/PTSGOVID/PTSGTYPES/ENUM[@id=/DATA/TXN/PTSGOVID/@gtype]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp1]"/>
                                                :
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSGOVID/@gnumber"/>
                                                </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="INPUT">
                                                <xsl:attribute name="type">button</xsl:attribute>
                                                <xsl:attribute name="class">smbutton</xsl:attribute>
                                                <xsl:attribute name="value">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/>
                                                </xsl:attribute>
                                                <xsl:attribute name="onclick">doSubmit(14,"")</xsl:attribute>
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
                                          <xsl:attribute name="width">800</xsl:attribute>
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
                                          <xsl:attribute name="width">800</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">Prompt</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ImageHelp']"/>
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
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Image']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">640</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">button</xsl:attribute>
                                             <xsl:attribute name="value">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Upload']"/>
                                             </xsl:attribute>
                                             <xsl:attribute name="onclick">doSubmit(6,"")</xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:if test="(/DATA/TXN/PTSMEMBER/@image != '')">
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="src">Images/Member/<xsl:value-of select="/DATA/TXN/PTSMEMBER/@image"/></xsl:attribute>
                                                <xsl:attribute name="width">100</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                             </xsl:element>
                                          </xsl:if>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:if test="(/DATA/SYSTEM/@usergroup != 41) or (contains(/DATA/SYSTEM/@useroptions, 'h')) or (contains(/DATA/SYSTEM/@useroptions, 'E')) or (contains(/DATA/SYSTEM/@useroptions, '6'))">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="height">6</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">800</xsl:attribute>
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
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Signature']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">640</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="A">
                                                <xsl:attribute name="onclick">w=window.open(this.href,"Signature","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                <xsl:attribute name="href">6111.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/></xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MoreSignatures']"/>
                                             </xsl:element>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="width">800</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="TEXTAREA">
                                                <xsl:attribute name="name">Signature</xsl:attribute>
                                                <xsl:attribute name="id">Signature</xsl:attribute>
                                                <xsl:attribute name="rows">10</xsl:attribute>
                                                <xsl:attribute name="cols">72</xsl:attribute>
                                                <xsl:attribute name="onkeyup"><xsl:text disable-output-escaping="yes"><![CDATA[if (value.length>1000) {doMaxLenMsg(1000); value=value.substring(0,1000);}]]></xsl:text></xsl:attribute>
                                                <xsl:value-of select="/DATA/TXN/PTSMEMBER/SIGNATURE/comment()" disable-output-escaping="yes"/>
                                             </xsl:element>
                                             <xsl:element name="SCRIPT">
                                                <xsl:attribute name="language">JavaScript1.2</xsl:attribute>
                                                <![CDATA[   CKEDITOR.replace('Signature', { height:200 } );  ]]>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">800</xsl:attribute>
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="height">1</xsl:attribute>
                                             <xsl:attribute name="bgcolor">#8080FF</xsl:attribute>
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
                                             <xsl:attribute name="width">800</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:attribute name="class">prompt</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SignatureText']"/>
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
                                          <xsl:attribute name="width">800</xsl:attribute>
                                          <xsl:attribute name="colspan">2</xsl:attribute>
                                          <xsl:attribute name="height">1</xsl:attribute>
                                          <xsl:attribute name="bgcolor">#8080FF</xsl:attribute>
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
                                          <xsl:attribute name="width">800</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">prompt</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SocNetText']"/>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">2</xsl:attribute>
                                          <xsl:attribute name="height">3</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="height">36</xsl:attribute>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FaceBookUser']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">640</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">FaceBook</xsl:attribute>
                                          <xsl:attribute name="id">FaceBook</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@facebook"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/social-FaceBook.png</xsl:attribute>
                                             <xsl:attribute name="align">absmiddle</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="height">36</xsl:attribute>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TwitterUser']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">640</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Twitter</xsl:attribute>
                                          <xsl:attribute name="id">Twitter</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@twitter"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/social-Twitter.png</xsl:attribute>
                                             <xsl:attribute name="align">absmiddle</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="height">36</xsl:attribute>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GoogleUser']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">640</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Google</xsl:attribute>
                                          <xsl:attribute name="id">Google</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@google"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/social-Google.png</xsl:attribute>
                                             <xsl:attribute name="align">absmiddle</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="height">36</xsl:attribute>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PinterestUser']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">640</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Pinterest</xsl:attribute>
                                          <xsl:attribute name="id">Pinterest</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@pinterest"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/social-Pinterest.png</xsl:attribute>
                                             <xsl:attribute name="align">absmiddle</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="height">36</xsl:attribute>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TumblrUser']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">640</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Tumblr</xsl:attribute>
                                          <xsl:attribute name="id">Tumblr</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@tumblr"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/social-Tumblr.png</xsl:attribute>
                                             <xsl:attribute name="align">absmiddle</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="height">36</xsl:attribute>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LinkedInUser']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">640</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">LinkedIn</xsl:attribute>
                                          <xsl:attribute name="id">LinkedIn</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@linkedin"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/social-LinkedIn.png</xsl:attribute>
                                             <xsl:attribute name="align">absmiddle</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="height">36</xsl:attribute>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MySpaceUser']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">640</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">MySpace</xsl:attribute>
                                          <xsl:attribute name="id">MySpace</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@myspace"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/social-MySpace.png</xsl:attribute>
                                             <xsl:attribute name="align">absmiddle</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:element name="TR">
                                       <xsl:attribute name="height">36</xsl:attribute>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SkypeUser']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">640</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Skype</xsl:attribute>
                                          <xsl:attribute name="id">Skype</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@skype"/></xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/social-Skype.png</xsl:attribute>
                                             <xsl:attribute name="align">absmiddle</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
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
                              <xsl:attribute name="width">800</xsl:attribute>
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
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">800</xsl:attribute>
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
                                    <xsl:attribute name="onclick">doSubmit(9,"")</xsl:attribute>
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
                              <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23) or (/DATA/SYSTEM/@usergroup = 51)">
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Delete']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick">doSubmit(4,'<xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ConfirmDelete']"/>')</xsl:attribute>
                                 </xsl:element>
                              </xsl:if>
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
                  <!--END CONTENT COLUMN-->

               </xsl:element>

               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="colspan">2</xsl:attribute>
                     <xsl:if test="/DATA/PARAM/@contentpage!=1 and /DATA/PARAM/@contentpage!=3">
                        <xsl:call-template name="PageFooter"/>
                     </xsl:if>
                  </xsl:element>
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