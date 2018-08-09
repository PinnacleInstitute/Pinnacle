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
         <xsl:with-param name="pagename" select="'Contact Manager'"/>
         <xsl:with-param name="includecalendar" select="true()"/>
         <xsl:with-param name="htmleditor"></xsl:with-param>
         <xsl:with-param name="translate">google</xsl:with-param>
      </xsl:call-template>

      <xsl:element name="SCRIPT">
         <xsl:attribute name="language">JavaScript</xsl:attribute>
         <xsl:attribute name="src">Include/AJAX.js</xsl:attribute>
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
                     <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[
               InitCursor();
            ]]></xsl:text>;doErrorMsg('<xsl:value-of select="concat($errmsg, $errmsgfld)"/>')</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[
               InitCursor();
            ]]></xsl:text>;doErrorMsg('<xsl:value-of select="/DATA/ERROR"/>')</xsl:attribute>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
               <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[
               InitCursor();
            ]]></xsl:text></xsl:attribute>
            </xsl:otherwise>
         </xsl:choose>

         <xsl:element name="DIV">
            <xsl:attribute name="id">folderpopup</xsl:attribute>
            <xsl:attribute name="style">display:none; border:solid 1px #333; position:absolute; left:100px; top:100px; z-index:1</xsl:attribute>
         <xsl:element name="DIV">
            <xsl:attribute name="style">background:blue; color:white; height=8px; padding:2px; text-align:center;</xsl:attribute>
            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AddFolder']"/>
         </xsl:element>
         <xsl:element name="DIV">
            <xsl:attribute name="style">background:#ddd; padding:5px;</xsl:attribute>
         <xsl:element name="TD">
            <xsl:attribute name="width">800</xsl:attribute>
            <xsl:attribute name="align">left</xsl:attribute>
            <xsl:attribute name="valign">center</xsl:attribute>
            <xsl:element name="SELECT">
               <xsl:attribute name="name">AddFolders</xsl:attribute>
               <xsl:attribute name="id">AddFolders</xsl:attribute>
               <xsl:attribute name="onchange"><xsl:text disable-output-escaping="yes"><![CDATA[addFolder(this.options[this.selectedIndex].value);]]></xsl:text></xsl:attribute>
               <xsl:for-each select="/DATA/TXN/PTSADDFOLDERS/ENUM">
                  <xsl:element name="OPTION">
                     <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                     <xsl:if test="@selected"><xsl:attribute name="SELECTED"/></xsl:if>
                     <xsl:value-of select="@name"/>
                  </xsl:element>
               </xsl:for-each>
            </xsl:element>
         </xsl:element>
         <xsl:element name="TD">
            <xsl:attribute name="width">800</xsl:attribute>
            <xsl:attribute name="align">left</xsl:attribute>
            <xsl:attribute name="valign">center</xsl:attribute>
            <xsl:element name="INPUT">
            <xsl:attribute name="type">checkbox</xsl:attribute>
            <xsl:attribute name="name">ViewDrip</xsl:attribute>
            <xsl:attribute name="id">ViewDrip</xsl:attribute>
            </xsl:element>
         </xsl:element>
            <xsl:element name="font">
               <xsl:attribute name="size">2</xsl:attribute>
            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewDrip']"/>
            </xsl:element>
            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
            <xsl:element name="INPUT">
               <xsl:attribute name="type">button</xsl:attribute>
               <xsl:attribute name="class">smbutton</xsl:attribute>
               <xsl:attribute name="value">
                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Close']"/>
               </xsl:attribute>
               <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[popupWindow('folderpopup',false);]]></xsl:text></xsl:attribute>
            </xsl:element>
         </xsl:element>
         </xsl:element>
         <xsl:element name="DIV">
            <xsl:attribute name="id">emailpopup</xsl:attribute>
            <xsl:attribute name="style">display:none; border:solid 1px #333; position:absolute; left:100px; top:100px; z-index:1</xsl:attribute>
         <xsl:element name="DIV">
            <xsl:attribute name="style">background:blue; color:white; height=8px; padding:2px; text-align:center;</xsl:attribute>
            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EmailContact']"/>
         </xsl:element>
         <xsl:element name="DIV">
            <xsl:attribute name="style">background:#ddd; padding:5px;</xsl:attribute>
         <xsl:element name="TD">
            <xsl:attribute name="width">800</xsl:attribute>
            <xsl:attribute name="align">left</xsl:attribute>
            <xsl:attribute name="valign">center</xsl:attribute>
            <xsl:element name="SELECT">
               <xsl:attribute name="name">SendEmail</xsl:attribute>
               <xsl:attribute name="id">SendEmail</xsl:attribute>
               <xsl:attribute name="onchange"><xsl:text disable-output-escaping="yes"><![CDATA[sendEmail(this.options[this.selectedIndex].value);]]></xsl:text></xsl:attribute>
               <xsl:for-each select="/DATA/TXN/PTSPAGES/ENUM">
                  <xsl:element name="OPTION">
                     <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                     <xsl:if test="@selected"><xsl:attribute name="SELECTED"/></xsl:if>
                     <xsl:value-of select="@name"/>
                  </xsl:element>
               </xsl:for-each>
            </xsl:element>
         </xsl:element>
         <xsl:element name="TD">
            <xsl:attribute name="width">800</xsl:attribute>
            <xsl:attribute name="align">left</xsl:attribute>
            <xsl:attribute name="valign">center</xsl:attribute>
            <xsl:element name="INPUT">
            <xsl:attribute name="type">checkbox</xsl:attribute>
            <xsl:attribute name="name">AutoEmail</xsl:attribute>
            <xsl:attribute name="id">AutoEmail</xsl:attribute>
            </xsl:element>
         </xsl:element>
            <xsl:element name="font">
               <xsl:attribute name="size">2</xsl:attribute>
            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AutoEmail']"/>
            </xsl:element>
            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
            <xsl:element name="INPUT">
               <xsl:attribute name="type">button</xsl:attribute>
               <xsl:attribute name="class">smbutton</xsl:attribute>
               <xsl:attribute name="value">
                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Close']"/>
               </xsl:attribute>
               <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[popupWindow('emailpopup',false);]]></xsl:text></xsl:attribute>
            </xsl:element>
         </xsl:element>
         </xsl:element>
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
                  <xsl:attribute name="value"><xsl:value-of select="5"/></xsl:attribute>
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
                     <xsl:attribute name="width">10</xsl:attribute>
                  </xsl:element>
                  <xsl:element name="TD">
                     <xsl:attribute name="width">740</xsl:attribute>
                  </xsl:element>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function Search(){ 
               var url, win, FindTypeID, SearchText, MemberID, Status;
               FindTypeID = document.getElementById('FindTypeID').value
               SearchText = document.getElementById('SearchText').value
               MemberID = document.getElementById('MemberID').value
               Status = document.getElementById('Status').value
               url = "2218.asp?FindTypeID=" + FindTypeID + "&SearchText=" + SearchText + "&MemberID=" + MemberID + "&Status=" + Status
               win = window.open(url,"Export");
               win.focus();
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function Distribute(){ 
               var url, win, FindTypeID, SearchText, MemberID, Status;
               FindTypeID = document.getElementById('FindTypeID').value
               SearchText = document.getElementById('SearchText').value
               MemberID = document.getElementById('MemberID').value
               Status = document.getElementById('Status').value
               url = "2227.asp?FindTypeID=" + FindTypeID + "&SearchText=" + SearchText + "&MemberID=" + MemberID + "&Status=" + Status
               win = window.open(url,"Distribute");
               win.focus();
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function addFolder(id){ 
               var viewdrip = document.getElementById('ViewDrip').checked
               if( viewdrip == 0 ) {
                  var member = document.getElementById('MemberID').value
                  var prospect = document.getElementById('ProspectID').value
                  var url = "12502.asp?Entity=22&MemberID=" + member + "&FolderID=" + id + "&ItemID=" + prospect
                  sendAJAX( url );
               }
               else {
                  var url = "11410.asp?folderid=" + id
                  var win = window.open(url,"DripCampaign","top=100,left=100,height=400,width=600,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no");
                  win.focus();
               }
               document.getElementById('AddFolders').value = 0;
               document.getElementById('ViewDrip').checked = 0;
               popupWindow('folderpopup',false);
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function sendEmail(id){ 
               var autoemail = document.getElementById('AutoEmail').checked
               var pid = document.getElementById('ProspectID').value
               var cid = document.getElementById('CompanyID').value
               var mid = document.getElementById('MemberID').value
               var url = ".asp?OwnerType=22&OwnerID=" + pid + "&MemberID=" + mid + "&CompanyID=" + cid + "&TemplateID=" + id
               if( autoemail != 0 ) {
                  url = "0502a" + url;
                  sendAJAX( url );
               }
               else {
                  url = "0502" + url;
                  var win = window.open(url,"Mail","top=50,left=50,height=625,width=625,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no");
                  win.focus();
               }
               document.getElementById('SendEmail').value = 0;
               document.getElementById('AutoEmail').checked = 0;
               popupWindow('emailpopup',false);
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function popupFolder(id){ 
               var x = document.getElementById('CursorX').value;
               var y = document.getElementById('CursorY').value;
               var o = document.getElementById('folderpopup');
               document.getElementById('ProspectID').value = id
               if( x != 0 ) {
                  o.style.left = x-50;
                  o.style.top = y-50;
               }
               popupWindow('folderpopup',true);
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function popupEmail(id){ 
               var x = document.getElementById('CursorX').value;
               var y = document.getElementById('CursorY').value;
               var o = document.getElementById('emailpopup');
               document.getElementById('ProspectID').value = id
               o.style.left = x-50;
               o.style.top = y-50;
               popupWindow('emailpopup',true);
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function popupWindow(e,d){ 
               var obj = document.getElementById(e);
               if(d)
               obj.style.display = 'block';
               else
               obj.style.display = 'none';
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function InitCursor(){ 
               if(window.addEventListener) {
               document.body.addEventListener('mousemove',getCursorXY,false);
               }
               else if(window.attachEvent) {
               document.body.attachEvent('onmousemove',getCursorXY);
               }
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function getCursorXY(e){ 
               document.getElementById('CursorX').value = e.pageX;
               document.getElementById('CursorY').value = e.pageY;
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ViewNotes(id,nam){ 
               var url = "9005.asp?OwnerType=22&OwnerID=" + id + "&Title=" + nam;
               var win = window.open(url,"Notes","top=50,left=50,height=400,width=625,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no");
               win.focus();
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function NewContact(){ 
          var mid = document.getElementById('MemberID').value;
          var ret = '8161.asp?memberid=' + mid;
          window.location = "8162.asp?memberid=" + mid + "&returnurl=" + ret;
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
                     <xsl:attribute name="width">800</xsl:attribute>

                     <xsl:element name="TABLE">
                        <xsl:attribute name="border">0</xsl:attribute>
                        <xsl:attribute name="cellpadding">0</xsl:attribute>
                        <xsl:attribute name="cellspacing">0</xsl:attribute>
                        <xsl:attribute name="width">800</xsl:attribute>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">800</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">CompanyID</xsl:attribute>
                              <xsl:attribute name="id">CompanyID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@companyid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">MemberID</xsl:attribute>
                              <xsl:attribute name="id">MemberID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@memberid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">ProspectID</xsl:attribute>
                              <xsl:attribute name="id">ProspectID</xsl:attribute>
                              <xsl:attribute name="value">0</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">CursorX</xsl:attribute>
                              <xsl:attribute name="id">CursorX</xsl:attribute>
                              <xsl:attribute name="value">0</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">CursorY</xsl:attribute>
                              <xsl:attribute name="id">CursorY</xsl:attribute>
                              <xsl:attribute name="value">0</xsl:attribute>
                           </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">800</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">800</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">250</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">550</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">250</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">PageHeading</xsl:attribute>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="src">Images/Suspect.gif</xsl:attribute>
                                                <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Leads']"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">550</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">prompt PageHeader</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FindLeadText']"/>
                                       </xsl:element>
                                    </xsl:element>

                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/PARAM/@m != 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">800</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                    <xsl:element name="font">
                                       <xsl:attribute name="color">red</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Mentoring']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    </xsl:element>
                                    <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namefirst"/>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namelast"/>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">800</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">ColumnHeader</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SearchBy']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="SELECT">
                                 <xsl:attribute name="name">FindTypeID</xsl:attribute>
                                 <xsl:attribute name="id">FindTypeID</xsl:attribute>
                                 <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/PTSPROSPECTS/@findtypeid"/></xsl:variable>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">8127</xsl:attribute>
                                    <xsl:if test="$tmp='8127'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ContactName']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">8145</xsl:attribute>
                                    <xsl:if test="$tmp='8145'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CreateDate']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">8173</xsl:attribute>
                                    <xsl:if test="$tmp='8173'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Priority']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">8129</xsl:attribute>
                                    <xsl:if test="$tmp='8129'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Email']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">8130</xsl:attribute>
                                    <xsl:if test="$tmp='8130'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Phone1']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">8175</xsl:attribute>
                                    <xsl:if test="$tmp='8175'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Source']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">8122</xsl:attribute>
                                    <xsl:if test="$tmp='8122'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Comment']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">8123</xsl:attribute>
                                    <xsl:if test="$tmp='8123'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Representing']"/>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SearchFor']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">SearchText</xsl:attribute>
                              <xsl:attribute name="id">SearchText</xsl:attribute>
                              <xsl:attribute name="size">15</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/BOOKMARK/@searchtext"/></xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">submit</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Go']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick">doSubmit(5,"")</xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">button</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewContact']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[NewContact()]]></xsl:text></xsl:attribute>
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
                              <xsl:attribute name="width">800</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">ColumnHeader</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SearchIn']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="SELECT">
                                 <xsl:attribute name="name">FolderID</xsl:attribute>
                                 <xsl:attribute name="id">FolderID</xsl:attribute>
                                 <xsl:variable name="tmp"><xsl:value-of select="/DATA/PARAM/@folderid"/></xsl:variable>
                                 <xsl:for-each select="/DATA/TXN/PTSFOLDERS/ENUM">
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                       <xsl:if test="$tmp=@id"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="@name"/>
                                    </xsl:element>
                                 </xsl:for-each>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='OrStatus']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="SELECT">
                                 <xsl:attribute name="name">Status</xsl:attribute>
                                 <xsl:attribute name="id">Status</xsl:attribute>
                                 <xsl:variable name="tmp"><xsl:value-of select="/DATA/PARAM/@status"/></xsl:variable>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">-20</xsl:attribute>
                                    <xsl:if test="$tmp='-20'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='All']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">-21</xsl:attribute>
                                    <xsl:if test="$tmp='-21'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StatusNew']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">-22</xsl:attribute>
                                    <xsl:if test="$tmp='-22'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StatusActive']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">-23</xsl:attribute>
                                    <xsl:if test="$tmp='-23'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StatusLive']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">-30</xsl:attribute>
                                    <xsl:if test="$tmp='-30'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    ----------
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">-2</xsl:attribute>
                                    <xsl:if test="$tmp='-2'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StatusCallBack']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">-3</xsl:attribute>
                                    <xsl:if test="$tmp='-3'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StatusContact1']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">-4</xsl:attribute>
                                    <xsl:if test="$tmp='-4'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StatusContact2']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">-5</xsl:attribute>
                                    <xsl:if test="$tmp='-5'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StatusContact3']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">-6</xsl:attribute>
                                    <xsl:if test="$tmp='-6'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StatusInvite']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">-7</xsl:attribute>
                                    <xsl:if test="$tmp='-7'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StatusPresent']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">-8</xsl:attribute>
                                    <xsl:if test="$tmp='-8'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StatusClose']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">-9</xsl:attribute>
                                    <xsl:if test="$tmp='-9'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StatusNoContact']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">-10</xsl:attribute>
                                    <xsl:if test="$tmp='-10'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StatusDead']"/>
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
                              <xsl:attribute name="width">800</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:call-template name="PreviousNext"/>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">800</xsl:attribute>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="width">35%</xsl:attribute>
                                       <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                       <xsl:attribute name="valign">Bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ContactName']"/>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="width">10%</xsl:attribute>
                                       <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                       <xsl:attribute name="valign">Bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Status']"/>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="align">center</xsl:attribute>
                                       <xsl:attribute name="width">8%</xsl:attribute>
                                       <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                       <xsl:attribute name="valign">Bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Priority']"/>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="width">22%</xsl:attribute>
                                       <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                       <xsl:attribute name="valign">Bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TimeZone']"/>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="width">13%</xsl:attribute>
                                       <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                       <xsl:attribute name="valign">Bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Source']"/>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="width">12%</xsl:attribute>
                                       <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                       <xsl:attribute name="valign">Bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CreateDate']"/>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">6</xsl:attribute>
                                       <xsl:attribute name="height">2</xsl:attribute>
                                       <xsl:attribute name="bgcolor">#CCCCCC</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>

                                 <xsl:for-each select="/DATA/TXN/PTSPROSPECTS/PTSPROSPECT">
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
                                             <xsl:element name="b">
                                             <xsl:value-of select="@contactname"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:element name="A">
                                                <xsl:attribute name="href">8163.asp?ProspectID=<xsl:value-of select="@prospectid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/Edit.gif</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/></xsl:attribute>
                                                   <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/></xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>
                                          <xsl:if test="(count(/DATA/TXN/PTSPAGES/ENUM) &gt; 1)">
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">#_</xsl:attribute>
                                                   <xsl:attribute name="onclick">popupEmail(<xsl:value-of select="@prospectid"/>)</xsl:attribute>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/email.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                      <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EmailProspect']"/></xsl:attribute>
                                                      <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EmailProspect']"/></xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(count(/DATA/TXN/PTSADDFOLDERS/ENUM) &gt; 1)">
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">#_</xsl:attribute>
                                                   <xsl:attribute name="onclick">popupFolder(<xsl:value-of select="@prospectid"/>)</xsl:attribute>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/FolderAdd.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                      <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AddFolder']"/></xsl:attribute>
                                                      <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AddFolder']"/></xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                          </xsl:if>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:element name="A">
                                                <xsl:attribute name="href">#_</xsl:attribute>
                                                <xsl:attribute name="onclick">ViewNotes(<xsl:value-of select="@prospectid"/>,"<xsl:value-of select="@contactname"/>");</xsl:attribute>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/notessm.gif</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='notes']"/></xsl:attribute>
                                                   <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='notes']"/></xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                          <xsl:if test="(@code != 0)">
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:if test="(@code &gt; 0)">
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/SymbolCheck.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(@code &lt; 0)">
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/SymbolDelete.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:if>
                                          </xsl:if>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:if test="(@status = -1)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StatusNew']"/>
                                             </xsl:if>
                                             <xsl:if test="(@status = -2)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StatusCallBack']"/>
                                             </xsl:if>
                                             <xsl:if test="(@status = -3)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StatusContact1']"/>
                                             </xsl:if>
                                             <xsl:if test="(@status = -4)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StatusContact2']"/>
                                             </xsl:if>
                                             <xsl:if test="(@status = -5)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StatusContact3']"/>
                                             </xsl:if>
                                             <xsl:if test="(@status = -6)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StatusInvite']"/>
                                             </xsl:if>
                                             <xsl:if test="(@status = -7)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StatusPresent']"/>
                                             </xsl:if>
                                             <xsl:if test="(@status = -8)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StatusClose']"/>
                                             </xsl:if>
                                             <xsl:if test="(@status = -9)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StatusNoContact']"/>
                                             </xsl:if>
                                             <xsl:if test="(@status = -10)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StatusDead']"/>
                                             </xsl:if>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="@priority"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:variable name="tmp4"><xsl:value-of select="../PTSTIMEZONES/ENUM[@id=current()/@timezone]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp4]"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="@source"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="@createdate"/>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:if test="(position() mod 2)=1">
                                          <xsl:attribute name="class">GrayBar</xsl:attribute>
                                       </xsl:if>
                                       <xsl:if test="(position() mod 2)=0">
                                          <xsl:attribute name="class">WhiteBar</xsl:attribute>
                                       </xsl:if>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">4</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="font">
                                             <xsl:attribute name="color">gray</xsl:attribute>
                                             <xsl:element name="font">
                                                <xsl:attribute name="color">blue</xsl:attribute>
                                             <xsl:value-of select="@representing"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes"> </xsl:text>
                                             <xsl:value-of select="@phone1"/>
                                             <xsl:text disable-output-escaping="yes"> </xsl:text>
                                             <xsl:value-of select="@phone2"/>
                                             <xsl:text disable-output-escaping="yes"> </xsl:text>
                                             <xsl:value-of select="@street"/>
                                             <xsl:text disable-output-escaping="yes"> </xsl:text>
                                             <xsl:value-of select="@unit"/>
                                             <xsl:text disable-output-escaping="yes"> </xsl:text>
                                             <xsl:value-of select="@city"/>
                                             <xsl:text disable-output-escaping="yes"> </xsl:text>
                                             <xsl:value-of select="@state"/>
                                             <xsl:text disable-output-escaping="yes"> </xsl:text>
                                             <xsl:value-of select="@zip"/>
                                             <xsl:text disable-output-escaping="yes"> </xsl:text>
                                             <xsl:value-of select="@country"/>
                                             <xsl:text disable-output-escaping="yes"> </xsl:text>
                                             <xsl:value-of select="@email"/>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">2</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="font">
                                             <xsl:attribute name="color">gray</xsl:attribute>
                                             <xsl:value-of select="@nextdate"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:value-of select="@nexttime"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:if test="(@salescampaignid != 0) or (@prospecttypeid != 0)">
                                       <xsl:element name="TR">
                                          <xsl:if test="(position() mod 2)=1">
                                             <xsl:attribute name="class">GrayBar</xsl:attribute>
                                          </xsl:if>
                                          <xsl:if test="(position() mod 2)=0">
                                             <xsl:attribute name="class">WhiteBar</xsl:attribute>
                                          </xsl:if>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">6</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="font">
                                                <xsl:attribute name="color">gray</xsl:attribute>
                                                <xsl:value-of select="@salescampaignname"/>
                                                /
                                                <xsl:value-of select="@prospecttypename"/>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:if>
                                 </xsl:for-each>
                                 <xsl:choose>
                                    <xsl:when test="(count(/DATA/TXN/PTSPROSPECTS/PTSPROSPECT) = 0)">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">6</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="class">NoItems</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoItems']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:when>
                                 </xsl:choose>

                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">6</xsl:attribute>
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
                                 <xsl:attribute name="width">800</xsl:attribute>
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