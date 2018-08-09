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
         <xsl:with-param name="pagename" select="/DATA/LANGUAGE/LABEL[@name='Find']"/>
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
            <xsl:attribute name="width">900</xsl:attribute>
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
            <xsl:attribute name="width">900</xsl:attribute>
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
         <!--BEGIN PAGE-->
      <xsl:element name="DIV">
         <xsl:attribute name="id">wrapper900</xsl:attribute>
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
               <xsl:attribute name="name">Member</xsl:attribute>
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
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ViewPerformance(id){ 
          var url, win;
          var cid = document.getElementById('CompanyID').value
          url = "0445.asp?memberid=" + id
          if( cid == 14) { url = "13504.asp?memberid=" + id }
          if( cid == 17) { url = "13804.asp?memberid=" + id }
          if( cid == 20) { url = "13904.asp?memberid=" + id }
          win = window.open(url,"Performance","top=100,left=100,height=650,width=450,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no");
          win.focus();
         }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function addFolder(id){ 
               var viewdrip = document.getElementById('ViewDrip').checked
               if( viewdrip == 0 ) {
                  var item = document.getElementById('ItemID').value
                  var url = "12502.asp?Entity=4&MemberID=0&FolderID=" + id + "&ItemID=" + item
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
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function popupFolder(id){ 
               var x = document.getElementById('CursorX').value;
               var y = document.getElementById('CursorY').value;
               var o = document.getElementById('folderpopup');
               document.getElementById('ItemID').value = id
               if( x != 0 ) {
                  o.style.left = x-50;
                  o.style.top = y-50;
               }
               popupWindow('folderpopup',true);
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

               <xsl:element name="TR">

                  <xsl:element name="TD">
                     <xsl:attribute name="width">10</xsl:attribute>
                  </xsl:element>

                  <xsl:element name="TD">
                     <xsl:attribute name="valign">top</xsl:attribute>
                     <xsl:attribute name="width">900</xsl:attribute>

                     <xsl:element name="TABLE">
                        <xsl:attribute name="border">0</xsl:attribute>
                        <xsl:attribute name="cellpadding">0</xsl:attribute>
                        <xsl:attribute name="cellspacing">0</xsl:attribute>
                        <xsl:attribute name="width">900</xsl:attribute>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">900</xsl:attribute>
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
                              <xsl:attribute name="name">ItemID</xsl:attribute>
                              <xsl:attribute name="id">ItemID</xsl:attribute>
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
                              <xsl:attribute name="width">900</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">900</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">PageHeading</xsl:attribute>
                                             <xsl:if test="(/DATA/PARAM/@mode &lt; 2)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Members']"/>
                                             </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@mode &gt; 1)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IncludedMembers']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/TXN/PTSORG/@orgname"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Folder']"/>
                                          </xsl:if>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">PageHeader</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@mode = 0)">
                                                <xsl:element name="A">
                                                   <xsl:attribute name="onclick">w=window.open(this.href,"Report","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                   <xsl:attribute name="href">3422.asp</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CertLookup']"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                </xsl:element>
                                                |
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="onclick">w=window.open(this.href,"NewMember","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                   <xsl:attribute name="href">0402.asp</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewMember']"/>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@mode = 1)">
                                                <xsl:if test="(/DATA/PARAM/@orgmemberid != 0)">
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="onclick">w=window.open(this.href,"ContactManager","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                      <xsl:attribute name="href">8161.asp?MemberID=<xsl:value-of select="/DATA/PARAM/@orgmemberid"/>&amp;ContentPage=3&amp;Popup=1</xsl:attribute>
                                                   <xsl:element name="b">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ContactManager']"/>
                                                   </xsl:element>
                                                   </xsl:element>
                                                </xsl:if>
                                             <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 21)">
                                                   |
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="onclick">w=window.open(this.href,"NewMember","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                      <xsl:attribute name="href">0402.asp?CompanyID=<xsl:value-of select="/DATA/PARAM/@companyid"/></xsl:attribute>
                                                   <xsl:element name="b">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewMember']"/>
                                                   </xsl:element>
                                                   </xsl:element>
                                             </xsl:if>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@mode = 2)">
                                                <xsl:element name="A">
                                                   <xsl:attribute name="onclick">w=window.open(this.href,"IncludeMember","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                   <xsl:attribute name="href">0401.asp?Mode=3&amp;CompanyID=<xsl:value-of select="/DATA/PARAM/@companyid"/>&amp;OrgID=<xsl:value-of select="/DATA/PARAM/@orgid"/>&amp;contentpage=3</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IncludeMember']"/>
                                                </xsl:element>
                                          </xsl:if>
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

                        <xsl:if test="(/DATA/PARAM/@mode &gt;= 2)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">600</xsl:attribute>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">100</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">500</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">100</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="src">Images/Member.gif</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">500</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:attribute name="class">prompt</xsl:attribute>
                                                <xsl:if test="(/DATA/PARAM/@mode &lt; 2)">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MemberFindText']"/>
                                                </xsl:if>
                                                <xsl:if test="(/DATA/PARAM/@mode = 2)">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FolderMembersText']"/>
                                                </xsl:if>
                                                <xsl:if test="(/DATA/PARAM/@mode = 3)">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IncludeMembersText']"/>
                                                </xsl:if>
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
                                 <xsl:attribute name="width">900</xsl:attribute>
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
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">900</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">ColumnHeader</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SearchBy']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="SELECT">
                                 <xsl:attribute name="name">FindTypeID</xsl:attribute>
                                 <xsl:attribute name="id">FindTypeID</xsl:attribute>
                                 <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/PTSMEMBERS/@findtypeid"/></xsl:variable>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">419</xsl:attribute>
                                    <xsl:if test="$tmp='419'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MemberName']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">401</xsl:attribute>
                                    <xsl:if test="$tmp='401'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MemberID']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">438</xsl:attribute>
                                    <xsl:if test="$tmp='438'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EnrollDate']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">430</xsl:attribute>
                                    <xsl:if test="$tmp='430'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Email']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">432</xsl:attribute>
                                    <xsl:if test="$tmp='432'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Phone1']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">470</xsl:attribute>
                                    <xsl:if test="$tmp='470'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GroupID']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">435</xsl:attribute>
                                    <xsl:if test="$tmp='435'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Status']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">471</xsl:attribute>
                                    <xsl:if test="$tmp='471'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Role']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">416</xsl:attribute>
                                    <xsl:if test="$tmp='416'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CompanyName']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">452</xsl:attribute>
                                    <xsl:if test="$tmp='452'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Reference']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">455</xsl:attribute>
                                    <xsl:if test="$tmp='455'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MasterID']"/>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SearchFor']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">SearchText</xsl:attribute>
                              <xsl:attribute name="id">SearchText</xsl:attribute>
                              <xsl:attribute name="size">20</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/BOOKMARK/@searchtext"/></xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">submit</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Go']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick">doSubmit(5,"")</xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="A">
                                    <xsl:attribute name="onclick">w=window.open(this.href,"LogonLookup","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                    <xsl:attribute name="href">0465.asp</xsl:attribute>
                                    <xsl:element name="IMG">
                                       <xsl:attribute name="src">Images/preview.gif</xsl:attribute>
                                       <xsl:attribute name="align">absmiddle</xsl:attribute>
                                       <xsl:attribute name="border">0</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="A">
                                    <xsl:attribute name="onclick">w=window.open(this.href,"LogonLookup","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                    <xsl:attribute name="href">0465.asp</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LogonLookup']"/>
                                 </xsl:element>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/PARAM/@mode = 3)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">900</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Include']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick">doSubmit(8,"")</xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Close']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[window.parent.opener.location.reload();window.close()]]></xsl:text></xsl:attribute>
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

                        <xsl:if test="(/DATA/BOOKMARK/@searchtype != 0) or (/DATA/PARAM/@mode != 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">900</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:call-template name="PreviousNext"/>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">900</xsl:attribute>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="width">10%</xsl:attribute>
                                          <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                          <xsl:attribute name="valign">Bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='#']"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="width">3%</xsl:attribute>
                                          <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                          <xsl:attribute name="valign">Bottom</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="width">25%</xsl:attribute>
                                          <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                          <xsl:attribute name="valign">Bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MemberName']"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="width">27%</xsl:attribute>
                                          <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                          <xsl:attribute name="valign">Bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Email']"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="width">10%</xsl:attribute>
                                          <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                          <xsl:attribute name="valign">Bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Status']"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="width">25%</xsl:attribute>
                                          <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                          <xsl:attribute name="valign">Bottom</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">6</xsl:attribute>
                                          <xsl:attribute name="height">2</xsl:attribute>
                                          <xsl:attribute name="bgcolor">#CCCCCC</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>

                                    <xsl:for-each select="/DATA/TXN/PTSMEMBERS/PTSMEMBER">
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
                                                <xsl:value-of select="@memberid"/>
                                             <xsl:if test="(@referralid != 0)">
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="color">gray</xsl:attribute>
                                                   <xsl:value-of select="@referralid"/>
                                                   </xsl:element>
                                             </xsl:if>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:if test="(/DATA/PARAM/@mode = 3)">
                                                   <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">checkbox</xsl:attribute>
                                                   <xsl:attribute name="name"><xsl:value-of select="@memberid"/></xsl:attribute>
                                                   <xsl:attribute name="id"><xsl:value-of select="@memberid"/></xsl:attribute>
                                                   </xsl:element>
                                             </xsl:if>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="@membername"/>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">0403.asp?MemberID=<xsl:value-of select="@memberid"/>&amp;OrgID=<xsl:value-of select="/DATA/PARAM/@orgid"/>&amp;contentpage=<xsl:value-of select="/DATA/PARAM/@contentpage"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/Edit.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                      <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/></xsl:attribute>
                                                      <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Edit']"/></xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="onclick">w=window.open(this.href,"_blank","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                   <xsl:attribute name="href">MemberHome.asp?MemberID=<xsl:value-of select="@memberid"/></xsl:attribute>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/Window.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                             <xsl:if test="(@title != 0)">
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/Company/<xsl:value-of select="/DATA/PARAM/@companyid"/>/Title<xsl:value-of select="@title"/>.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                             </xsl:if>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="@email"/>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:if test="(@status != 1)">
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/Status<xsl:value-of select="@status"/>.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(@status = 1)">
                                                <xsl:if test="(@qualify &lt;= 1)">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/Status-1.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(@qualify &gt; 1)">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/Status1.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                      </xsl:element>
                                                </xsl:if>
                                             </xsl:if>
                                             <xsl:if test="(@status &lt;= 2)">
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:value-of select="@level"/>
                                                <xsl:if test="(@ismaster != 0)">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/FastTrack.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FastTrack']"/></xsl:attribute>
                                                         <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FastTrack']"/></xsl:attribute>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(@promoid != 0)">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/OverDraft.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PromoID']"/></xsl:attribute>
                                                         <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PromoID']"/></xsl:attribute>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(@ismaster = 0) and (@memberid = @groupid)">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/GrpAdmin.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GrpAdmin']"/></xsl:attribute>
                                                         <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GrpAdmin']"/></xsl:attribute>
                                                      </xsl:element>
                                                </xsl:if>
                                                   <xsl:if test="(@qualify &lt;= 1)">
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">red</xsl:attribute>
                                                      B
                                                      </xsl:element>
                                                   </xsl:if>
                                                   <xsl:if test="(@qualify &gt; 1)">
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">green</xsl:attribute>
                                                      B
                                                      </xsl:element>
                                                   </xsl:if>
                                                   <xsl:if test="(@isincluded = 0)">
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">red</xsl:attribute>
                                                      P
                                                      </xsl:element>
                                                   </xsl:if>
                                                   <xsl:if test="(@isincluded != 0)">
                                                      <xsl:element name="font">
                                                         <xsl:attribute name="color">green</xsl:attribute>
                                                      P
                                                      </xsl:element>
                                                   </xsl:if>
                                             </xsl:if>
                                          </xsl:element>
                                          <xsl:if test="(/DATA/PARAM/@mode != 2)">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:if test="(/DATA/PARAM/@companyid = 12)">
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"Friends","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">14101.asp?MemberID=<xsl:value-of select="@memberid"/></xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/genealogy.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewFriends']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewFriends']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"Broadcasts","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">14401.asp?MemberID=<xsl:value-of select="@memberid"/>&amp;CompanyID=<xsl:value-of select="/DATA/PARAM/@companyid"/></xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/news.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewBroadcasts']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewBroadcasts']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"Ads","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">14301.asp?CompanyID=<xsl:value-of select="/DATA/PARAM/@companyid"/>&amp;MemberID=<xsl:value-of select="@memberid"/>&amp;Popup=1</xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/ad.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewAds']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewAds']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(/DATA/PARAM/@companyid = 16)">
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"Profiles","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">13711.asp?MemberID=<xsl:value-of select="@memberid"/></xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/profile.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='profiles']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='profiles']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(/DATA/PARAM/@companyid = 21)">
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"GiftCertificates","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">15901.asp?MemberID=<xsl:value-of select="@memberid"/></xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/certificate16.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GiftCertificates']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GiftCertificates']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, 'w')) or (/DATA/SYSTEM/@usergroup &lt;= 23) or (/DATA/SYSTEM/@usergroup = 51) or (/DATA/SYSTEM/@usergroup = 52)">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:if test="(contains(@role, 'P'))">
                                                         <xsl:element name="A">
                                                            <xsl:attribute name="onclick">w=window.open(this.href,"Finances","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                            <xsl:attribute name="href">0475.asp?MemberID=<xsl:value-of select="@memberid"/>&amp;Code=4&amp;ContentPage=3&amp;Popup=1</xsl:attribute>
                                                            <xsl:element name="IMG">
                                                               <xsl:attribute name="src">Images/financesm_a.gif</xsl:attribute>
                                                               <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                               <xsl:attribute name="border">0</xsl:attribute>
                                                               <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='finances']"/></xsl:attribute>
                                                               <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='finances']"/></xsl:attribute>
                                                            </xsl:element>
                                                         </xsl:element>
                                                   </xsl:if>
                                                   <xsl:if test="(not(contains(@role, 'P')))">
                                                         <xsl:element name="A">
                                                            <xsl:attribute name="onclick">w=window.open(this.href,"Finances","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                            <xsl:attribute name="href">0475.asp?MemberID=<xsl:value-of select="@memberid"/>&amp;Code=4&amp;ContentPage=3&amp;Popup=1</xsl:attribute>
                                                            <xsl:element name="IMG">
                                                               <xsl:attribute name="src">Images/financesm.gif</xsl:attribute>
                                                               <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                               <xsl:attribute name="border">0</xsl:attribute>
                                                               <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='finances']"/></xsl:attribute>
                                                               <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='finances']"/></xsl:attribute>
                                                            </xsl:element>
                                                         </xsl:element>
                                                   </xsl:if>
                                                </xsl:if>
                                                <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, '8'))">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"ShoppingCart","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">5250.asp?C=<xsl:value-of select="@companyid"/>&amp;Me=<xsl:value-of select="@memberid"/></xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/ShoppingCart.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='shoppingcart']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='shoppingcart']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, 'o')) or (/DATA/SYSTEM/@usergroup &lt;= 23) or (/DATA/SYSTEM/@usergroup = 51) or (/DATA/SYSTEM/@usergroup = 52)">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"Genealogy","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">0470.asp?MemberID=<xsl:value-of select="@memberid"/></xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/genealogy.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='genealogy']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='genealogy']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, 'm'))">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"SupportTickets","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">9506.asp?CompanyID=<xsl:value-of select="/DATA/PARAM/@companyid"/>&amp;T=04&amp;I=<xsl:value-of select="@memberid"/></xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/supportticketsm.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='supporttickets']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='supporttickets']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, 'G'))">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"Mentor","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">0410.asp?MemberID=<xsl:value-of select="@memberid"/>&amp;ContentPage=3&amp;Popup=1</xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/mentorsm.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='mentoring']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='mentoring']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(/DATA/PARAM/@orgmemberid != 0)">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"ContactManager","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">8163a.asp?OrgMemberID=<xsl:value-of select="/DATA/PARAM/@orgmemberid"/>&amp;MemberID=<xsl:value-of select="@memberid"/></xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/orgcontact.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='orgcontact']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='orgcontact']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, '2'))">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"Calendar","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">Calendar.asp?MemberID=<xsl:value-of select="@memberid"/></xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/calendarsm.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='calendar']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='calendar']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, 'H'))">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"Goals","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">7001.asp?MemberID=<xsl:value-of select="@memberid"/>&amp;ContentPage=3&amp;Popup=1</xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/goalsm.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='goals']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='goals']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, 'L'))">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"Assessments","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">3411.asp?MemberID=<xsl:value-of select="@memberid"/>&amp;ContentPage=3&amp;Popup=1</xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/Assessmentsm.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='assessments']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='assessments']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, 'K'))">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"Courses","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">1311.asp?MemberID=<xsl:value-of select="@memberid"/>&amp;ContentPage=3&amp;Popup=1</xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/Classsm.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='classes']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='classes']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:if test="(@status = 3)">
                                                <xsl:element name="TD">
                                                </xsl:element>
                                             </xsl:if>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@mode = 2)">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="b">
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="href">0401.asp?SearchText=<xsl:value-of select="/DATA/PARAM/@searchtext"/>&amp;FindTypeID=<xsl:value-of select="/DATA/PARAM/@findtypeid"/>&amp;Bookmark=<xsl:value-of select="/DATA/PARAM/@bookmark"/>&amp;Direction=<xsl:value-of select="/DATA/PARAM/@direction"/>&amp;contentpage=<xsl:value-of select="/DATA/PARAM/@contentpage"/>&amp;CompanyID=<xsl:value-of select="/DATA/PARAM/@companyid"/>&amp;OrgID=<xsl:value-of select="/DATA/PARAM/@orgid"/>&amp;Mode=<xsl:value-of select="/DATA/PARAM/@mode"/>&amp;RemoveID=<xsl:value-of select="@memberid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@returnurl"/></xsl:attribute>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Remove']"/>
                                                   </xsl:element>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:if>
                                       </xsl:element>
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
                                                <xsl:if test="(/DATA/PARAM/@mode = 0)">
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="color">gray</xsl:attribute>
                                                   <xsl:value-of select="@companyid"/>
                                                   </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(/DATA/PARAM/@mode = 1)">
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="color">gray</xsl:attribute>
                                                   <xsl:if test="(@sponsorid != 0)">
                                                      <xsl:value-of select="@sponsorid"/>
                                                   </xsl:if>
                                                <xsl:if test="(@sponsor2id != 0)">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:value-of select="@sponsor2id"/>
                                                </xsl:if>
                                                <xsl:if test="(@sponsor3id != 0)">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:value-of select="@sponsor3id"/>
                                                </xsl:if>
                                                   </xsl:element>
                                                </xsl:if>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:element name="font">
                                                <xsl:attribute name="color">gray</xsl:attribute>
                                                <xsl:value-of select="@enrolldate"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:variable name="tmp2"><xsl:value-of select="../PTSBILLINGS/ENUM[@id=current()/@billing]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp2]"/>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="font">
                                                <xsl:attribute name="color">purple</xsl:attribute>
                                                <xsl:if test="(/DATA/TXN/PTSMEMBER/@companyid != 17) or (/DATA/SYSTEM/@usergroup &lt;= 23) or (/DATA/SYSTEM/@usergroup = 51)">
                                                   <xsl:value-of select="@reference"/>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                </xsl:if>
                                                <xsl:if test="(@visitdate != '')">
                                                   (<xsl:value-of select="@visitdate"/>)
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                </xsl:if>
                                                <xsl:value-of select="@groupid"/>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:if test="(/DATA/PARAM/@mode != 2)">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, '[')) or (@companyid = 14) or (@companyid = 17) or (@companyid = 20)">
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="href">#_</xsl:attribute>
                                                         <xsl:attribute name="onclick">ViewPerformance(<xsl:value-of select="@memberid"/>)</xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/performance.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='performance']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='performance']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="onclick">w=window.open(this.href,"Notes","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                      <xsl:attribute name="href">9005.asp?OwnerType=04&amp;OwnerID=<xsl:value-of select="@memberid"/>&amp;Title=<xsl:value-of select="@membername"/></xsl:attribute>
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/notessm.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='notes']"/></xsl:attribute>
                                                         <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='notes']"/></xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                <xsl:if test="(count(/DATA/TXN/PTSADDFOLDERS/ENUM) &gt; 1)">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="href">#_</xsl:attribute>
                                                         <xsl:attribute name="onclick">popupFolder(<xsl:value-of select="@memberid"/>)</xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/FolderAdd.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AddFolder']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AddFolder']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(/DATA/PARAM/@companyid != 5) and (/DATA/PARAM/@companyid != 11) and (/DATA/PARAM/@companyid != 12)">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"_blank","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">Enroll.asp?C=<xsl:value-of select="@companyid"/>&amp;M=<xsl:value-of select="@memberid"/></xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/SymbolAdd.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='enroll']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='enroll']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(/DATA/PARAM/@companyid = 11)">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"_blank","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">Enroll.asp?C=<xsl:value-of select="@companyid"/>&amp;M=<xsl:value-of select="@memberid"/></xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/SymbolAdd.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='enroll']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='enroll']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"_blank","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">Enroll.asp?C=<xsl:value-of select="@companyid"/>&amp;M=<xsl:value-of select="@memberid"/>&amp;Retail=1</xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/SymbolAdd.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='enroll']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='enroll']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(/DATA/PARAM/@companyid = 12)">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"_blank","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">13201.asp?M=<xsl:value-of select="@memberid"/></xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/SymbolAdd.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='enroll']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='enroll']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(/DATA/PARAM/@companyid = 19)">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"_blank","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">14903.asp?M=<xsl:value-of select="@memberid"/></xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/SymbolAdd.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='newcustomer']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='newcustomer']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, 'l'))">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"_blank","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">11711.asp?MemberID=<xsl:value-of select="@memberid"/></xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/Activity.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='activity']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='activity']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                                      <xsl:attribute name="onclick">w=window.open(this.href,"Reports","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                      <xsl:attribute name="href">Reports.asp?M=<xsl:value-of select="@memberid"/>&amp;C=<xsl:value-of select="@companyid"/></xsl:attribute>
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/Reportsm.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CustomReports']"/></xsl:attribute>
                                                         <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CustomReports']"/></xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, 'h'))">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"Sales","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">8161.asp?MemberID=<xsl:value-of select="@memberid"/>&amp;ContentPage=3&amp;Popup=1</xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/Contactsm.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='viewcontacts']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='viewcontacts']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, 'E'))">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"Sales","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">8101.asp?MemberID=<xsl:value-of select="@memberid"/>&amp;ContentPage=3&amp;Popup=1</xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/Prospectsm.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='viewprospects']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='viewprospects']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, '6'))">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:element name="A">
                                                         <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                                         <xsl:attribute name="onclick">w=window.open(this.href,"Sales","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                         <xsl:attribute name="href">8151.asp?MemberID=<xsl:value-of select="@memberid"/>&amp;ContentPage=3&amp;Popup=1</xsl:attribute>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/Customersm.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='viewcustomers']"/></xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='viewcustomers']"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                </xsl:if>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="onclick">w=window.open(this.href,"Logon","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                      <xsl:attribute name="href">0104.asp?AuthUserID=<xsl:value-of select="@authuserid"/>&amp;ContentPage=3&amp;Popup=1</xsl:attribute>
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/logon.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='logon']"/></xsl:attribute>
                                                         <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='logon']"/></xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                             </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@mode = 2)">
                                             <xsl:element name="TD">
                                             </xsl:element>
                                          </xsl:if>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:if test="(position() mod 2)=1">
                                             <xsl:attribute name="class">GrayBar</xsl:attribute>
                                          </xsl:if>
                                          <xsl:if test="(position() mod 2)=0">
                                             <xsl:attribute name="class">WhiteBar</xsl:attribute>
                                          </xsl:if>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="@role"/>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">4</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="font">
                                                <xsl:attribute name="color">gray</xsl:attribute>
                                                M:
                                                <xsl:value-of select="@phone1"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                D:
                                                <xsl:value-of select="@phone2"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                N:
                                                <xsl:value-of select="@fax"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:if test="(@iscompany != 0)">
                                                   <xsl:value-of select="@companyname"/>
                                                </xsl:if>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:for-each>
                                    <xsl:choose>
                                       <xsl:when test="(count(/DATA/TXN/PTSMEMBERS/PTSMEMBER) = 0)">
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
                                    <xsl:attribute name="width">900</xsl:attribute>
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

                        <xsl:if test="(/DATA/PARAM/@mode = 3)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">900</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Include']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick">doSubmit(8,"")</xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Close']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[window.parent.opener.location.reload();window.close()]]></xsl:text></xsl:attribute>
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

                        <xsl:if test="(/DATA/PARAM/@popup != 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">900</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
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