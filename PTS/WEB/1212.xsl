<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
   <xsl:include href="HTMLHeading.xsl"/>
   <xsl:include href="PageHeader.xsl"/>
   <xsl:include href="PageFooter.xsl"/>
   <xsl:include href="Bookmark.xsl"/>
   <xsl:output omit-xml-declaration="yes"/>

   <xsl:variable name="firstparent" select="0"/>

   <xsl:template name="TreeNode">
      <xsl:param name="parentid"/>

      <xsl:for-each select="/DATA/TXN/PTSCOURSECATEGORYS/PTSCOURSECATEGORY[@parentcategoryid=$parentid]">
         <xsl:variable name="nodeid" select="@coursecategoryid"/>
         <xsl:variable name="children" select="count(/DATA/TXN/PTSCOURSECATEGORYS/PTSCOURSECATEGORY[@parentcategoryid=$nodeid])"/>

         <xsl:element name="SPAN">
            <xsl:attribute name="class">Trigger</xsl:attribute>
            <xsl:attribute name="id">H<xsl:value-of select="$nodeid"/></xsl:attribute>
            <xsl:element name="TABLE">
               <xsl:attribute name="width">530</xsl:attribute>
               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="width">35</xsl:attribute>
                     <xsl:attribute name="height">100%</xsl:attribute>
                     <xsl:element name="TABLE">
                        <xsl:attribute name="height">100%</xsl:attribute>
                        <xsl:element name="TR">
                           <xsl:attribute name="align">center</xsl:attribute>
                           <xsl:attribute name="height">18</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">2</xsl:attribute>
                              <xsl:attribute name="valign">top</xsl:attribute>
                              <xsl:if test="$parentid!=$firstparent">
                                 <xsl:choose>
                                 <xsl:when test="position()=last()">
                                    <xsl:element name="DIV">
                                       <xsl:attribute name="height">9</xsl:attribute>
                                       <xsl:attribute name="class">TreeBar</xsl:attribute>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="height">9</xsl:attribute>
                                          <xsl:attribute name="width">2</xsl:attribute>
                                          <xsl:attribute name="src">Images/spacer.gif</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:when>
                                 <xsl:otherwise>
                                 <xsl:attribute name="class">TreeBar</xsl:attribute>
                                 </xsl:otherwise>
                                 </xsl:choose>
                              </xsl:if>
                           </xsl:element>

                           <xsl:element name="TD">
                              <xsl:attribute name="width">13</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:if test="$parentid!=$firstparent">
                                 <xsl:attribute name="class">TreeBarH</xsl:attribute>
                              </xsl:if>
                              <xsl:if test="($children > 0)">
                                 <xsl:element name="IMG">
                                    <xsl:attribute name="id">I<xsl:value-of select="$nodeid"/></xsl:attribute>
                                    <xsl:attribute name="src">Images/tree-plus.gif</xsl:attribute>
                                    <xsl:attribute name="onClick">showBranch('<xsl:value-of select="$nodeid"/>',<xsl:value-of select="$children"/>);</xsl:attribute>
                                 </xsl:element>
                              </xsl:if>
                           </xsl:element>

                           <xsl:element name="TD">
                              <xsl:attribute name="width">20</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IMG">
                                    <xsl:attribute name="id">N<xsl:value-of select="$nodeid"/></xsl:attribute>
                                 <xsl:attribute name="src">Images/tree-node.gif</xsl:attribute>
                                 <xsl:attribute name="onClick">showBranch('<xsl:value-of select="$nodeid"/>',<xsl:value-of select="$children"/>);openNode(<xsl:value-of select="$nodeid"/>);loadFrame(<xsl:value-of select="@coursecategoryid"/>);</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:if test="($parentid!=$firstparent) and (position()!=last())"><xsl:attribute name="class">TreeBar</xsl:attribute></xsl:if>
                           </xsl:element>

                           <xsl:element name="TD">
                              <xsl:attribute name="id">S<xsl:value-of select="$nodeid"/></xsl:attribute>
                           </xsl:element>

                        </xsl:element>

                     </xsl:element>

                  </xsl:element>

                  <xsl:element name="TD">
                     <xsl:attribute name="style">PADDING: 2px;</xsl:attribute>
                        <xsl:element name="A">
                           <xsl:attribute name="href">javascript: showBranch('<xsl:value-of select="$nodeid"/>',<xsl:value-of select="$children"/>);openNode(<xsl:value-of select="@coursecategoryid"/>);loadFrame(<xsl:value-of select="@coursecategoryid"/>);</xsl:attribute>
                        <xsl:value-of select="@coursecategoryname"/>
                        </xsl:element>
                        <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23) and (@coursecategoryid &gt; 0)">
                           <xsl:element name="A">
                              <xsl:attribute name="href">1202.asp?CategoryID=<xsl:value-of select="@coursecategoryid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                            - (new
                           </xsl:element>
                            | 
                           <xsl:element name="A">
                              <xsl:attribute name="href">1203.asp?CourseCategoryID=<xsl:value-of select="@coursecategoryid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                           edit
                           </xsl:element>
                            ) 
                        </xsl:if>
                  </xsl:element>

               </xsl:element>

            </xsl:element>

         </xsl:element>

         <xsl:element name="DIV">
            <xsl:if test="($parentid!=$firstparent) and (position()!=last())">
               <xsl:attribute name="class">TreeBar</xsl:attribute>
            </xsl:if>

            <xsl:element name="SPAN">
               <xsl:attribute name="class">Branch</xsl:attribute>
               <xsl:attribute name="id"><xsl:value-of select="$nodeid"/></xsl:attribute>

               <xsl:call-template name="TreeNode">
                  <xsl:with-param name="parentid" select="$nodeid"/>
               </xsl:call-template>

            </xsl:element>
         </xsl:element>
      </xsl:for-each>
   </xsl:template>

   <xsl:template match="/">

      <xsl:element name="HTML">

      <xsl:variable name="usergroup" select="/DATA/SYSTEM/@usergroup"/>

      <xsl:element name="link">
         <xsl:attribute name="rel">stylesheet</xsl:attribute>
         <xsl:attribute name="type">text/css</xsl:attribute>
         <xsl:attribute name="href">include/StyleSheet.css</xsl:attribute>
      </xsl:element>

      <xsl:element name="link">
         <xsl:attribute name="rel">stylesheet</xsl:attribute>
         <xsl:attribute name="type">text/css</xsl:attribute>
         <xsl:attribute name="href">include/TreeStyle.css</xsl:attribute>
      </xsl:element>

      <xsl:call-template name="HTMLHeading">
         <xsl:with-param name="pagename" select="'Course Catalog'"/>
         <xsl:with-param name="includecalendar" select="true()"/>
         <xsl:with-param name="htmleditor"></xsl:with-param>
         <xsl:with-param name="translate">google</xsl:with-param>
      </xsl:call-template>

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

         <xsl:element name="SCRIPT">
            <xsl:attribute name="language">JavaScript</xsl:attribute>
            <xsl:text disable-output-escaping="yes"><![CDATA[
            var openImg = new Image();
            openImg.src = "Images/tree-plus.gif";
            var closeImg = new Image();
            closeImg.src = "Images/tree-minus.gif";

            var nodeImg = new Image();
            nodeImg.src = "Images/tree-node.gif";

            var nodeOpenImg = new Image();
            nodeOpenImg.src = "Images/folder_open.gif";

            var nodeOpen = 0;
            function showBranch(branch, children){
               var objBranch = document.getElementById(branch).style;
               if(children > 0){
                  if(objBranch.display=="block"){objBranch.display="none";} else{objBranch.display="block";}
                  swapFolder(branch);
               }
            }

            function openNode(branch){
               objImg = document.getElementById('N' + String(branch) );
               objOldImg = document.getElementById('N' + String(nodeOpen) );
               if(nodeOpen != 0){objOldImg.src = nodeImg.src;};
               objImg.src = nodeOpenImg.src;
               nodeOpen = branch;
            }

            function swapFolder(branch){
               objImg = document.getElementById('I' + String(branch) );
               objClass = document.getElementById('S' + String(branch) );
               if(objImg.src.indexOf('Images/tree-minus.gif')>-1) {
                  objImg.src = openImg.src;
                  objClass.className = '';
               } else {
                  objImg.src = closeImg.src;
                  objClass.className = 'SubTreeBar';
               }
            }

            ]]></xsl:text>

         </xsl:element>

         <xsl:element name="STYLE">
            <xsl:attribute name="type">text/css</xsl:attribute>
            <xsl:attribute name="media">screen</xsl:attribute>
            <xsl:text disable-output-escaping="yes"><![CDATA[
            TABLE {BORDER: 0px; BORDER-SPACING: 0px; BORDER-COLLAPSE: collapse;}
            TD {PADDING: 0px;}
            .Branch{MARGIN-LEFT: 24px; DISPLAY: none;}
            ]]></xsl:text>

         </xsl:element>

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
               <xsl:attribute name="name">CourseCategory</xsl:attribute>
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
               <xsl:element name="INPUT">
                  <xsl:attribute name="type">hidden</xsl:attribute>
                  <xsl:attribute name="name">Bookmark</xsl:attribute>
                  <xsl:attribute name="id">Bookmark</xsl:attribute>
                  <xsl:attribute name="value"><xsl:value-of select="/DATA/BOOKMARK/@nextbookmark"/></xsl:attribute>
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
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function loadFrame(coursecategoryid){ 
               var frame = document.getElementById('frame');
               var orgid = document.getElementById('OrgID').value;
               var companyid = document.getElementById('CompanyID').value;
               var memberid = document.getElementById('MemberID').value;
               var content = document.getElementById('SearchText');
               frame.src="1114.asp?CategoryID=" + coursecategoryid + "&contentpage=1&MemberID=" + memberid + "&OrgID=" + orgid + "&companyid=" + companyid;
               if (content)
                  content.scrollIntoView();
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function searchClicked(){ 
               var text = document.getElementById('SearchText').value; 
               if(text==""){
                  alert("Enter search text.");
               }else{
                  var frame = document.getElementById('frame');
                  var memberid = document.getElementById('MemberID').value; 
                  var companyid = document.getElementById('CompanyID').value; 
                  var orgid = document.getElementById('OrgID').value; 
                  var content = document.getElementById('SearchText');
                  frame.src="1113.asp?SearchText=" + text + "&MemberID=" + memberid + "&CompanyID=" + companyid + "&OrgID=" + orgid;
                  content.scrollIntoView();            
               }
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function goClicked(){ 
               var id = document.getElementById('CourseID').value; 
               var grp = document.getElementById('Grp').value; 
               if(isNaN(id) || id==""){
                  if(isNaN(grp) || grp==""){
                     alert("Enter a Course #");
                  }else{
                     var frame = document.getElementById('frame');
                     var memberid = document.getElementById('MemberID').value; 
                     frame.src="1119.asp?Grp=" + grp + "&MemberID=" + memberid; 
                  }
               }else{
                  var frame = document.getElementById('frame');
                  var memberid = document.getElementById('MemberID').value; 
                  var companyid = document.getElementById('CompanyID').value; 
                  var orgid = document.getElementById('OrgID').value; 
                  frame.src="1115.asp?CourseID=" + id + "&MemberID=" + memberid + "&CompanyID=" + companyid + "&OrgID=" + orgid;
               }
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function favoriteClicked(){ 
               var frame = document.getElementById('frame');
               var memberid = document.getElementById('MemberID').value; 
               var orgid = document.getElementById('FavoriteID').value; 
               if( orgid != 0 ) {
                  var content = document.getElementById('SearchText');
                  frame.src="1116.asp?OrgID=" + orgid + "&MemberID=" + memberid;
                  content.scrollIntoView();            
               }
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function programClicked(){ 
               var frame = document.getElementById('frame');
               var memberid = document.getElementById('MemberID').value; 
               var orgid = document.getElementById('ProgramID').value; 
               if( orgid != 0 ) {
                  var content = document.getElementById('SearchText');
                  frame.src="1126.asp?OrgID=" + orgid + "&MemberID=" + memberid;
                  content.scrollIntoView();            
               }
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function HideFolder(){ 
               document.getElementById('HideFolder').style.display="none"; 
               document.getElementById('ShowFolder').style.display="block"; 
               document.getElementById('TreeView').style.display="none";
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ShowFolder(){ 
               document.getElementById('HideFolder').style.display="block"; 
               document.getElementById('ShowFolder').style.display="none"; 
               document.getElementById('TreeView').style.display="block";
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

                  <xsl:if test="/DATA/PARAM/@contentpage!=1">
                     <xsl:element name="TD">
                        <xsl:attribute name="width">10</xsl:attribute>
                     </xsl:element>
                  </xsl:if>
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
                              <xsl:attribute name="width">600</xsl:attribute>
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
                              <xsl:attribute name="name">OrgID</xsl:attribute>
                              <xsl:attribute name="id">OrgID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@orgid"/></xsl:attribute>
                           </xsl:element>

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
                                             <xsl:attribute name="src">Images/topics2.gif</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">500</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="TABLE">
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="cellpadding">0</xsl:attribute>
                                             <xsl:attribute name="cellspacing">0</xsl:attribute>
                                             <xsl:attribute name="width">500</xsl:attribute>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">500</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">500</xsl:attribute>
                                                      <xsl:attribute name="align">center</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:attribute name="class">PageHeading</xsl:attribute>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CourseCatalogue']"/>
                                                      <xsl:if test="(contains(/DATA/SYSTEM/@useroptions, 'U'))">
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            <xsl:element name="A">
                                                               <xsl:attribute name="onclick">w=window.open(this.href,"Tutorial","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                               <xsl:attribute name="href">Tutorial.asp?Lesson=114&amp;contentpage=3&amp;popup=1</xsl:attribute>
                                                               <xsl:element name="IMG">
                                                                  <xsl:attribute name="src">Images/Tutorial.gif</xsl:attribute>
                                                                  <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                  <xsl:attribute name="border">0</xsl:attribute>
                                                                  <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PinnacleTutorials']"/></xsl:attribute>
                                                                  <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PinnacleTutorials']"/></xsl:attribute>
                                                               </xsl:element>
                                                            </xsl:element>
                                                      </xsl:if>
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
                                                         <xsl:attribute name="width">500</xsl:attribute>
                                                         <xsl:attribute name="align">left</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:attribute name="class">Prompt</xsl:attribute>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CatalogInclude']"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="colspan">1</xsl:attribute>
                                                         <xsl:attribute name="height">6</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                </xsl:if>

                                                <xsl:if test="(/DATA/PARAM/@mode != 3)">
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">500</xsl:attribute>
                                                         <xsl:attribute name="align">left</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:attribute name="class">Prompt</xsl:attribute>
                                                         <xsl:if test="(/DATA/PARAM/@mode = 0)">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CatalogEmployee']"/>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/PARAM/@mode = 1)">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CatalogMember']"/>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/PARAM/@mode = 2) and (/DATA/PARAM/@catalog = 0)">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoCatalogMember']"/>
                                                         </xsl:if>
                                                         <xsl:if test="(/DATA/PARAM/@mode = 2) and (/DATA/PARAM/@catalog != 0)">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CatalogMember']"/>
                                                         </xsl:if>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="colspan">1</xsl:attribute>
                                                         <xsl:attribute name="height">6</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                </xsl:if>

                                                <xsl:if test="(/DATA/PARAM/@catalog != 0)">
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">500</xsl:attribute>
                                                         <xsl:attribute name="align">center</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:if test="(not(contains(/DATA/SYSTEM/@useroptions, '~$')))">
                                                         <xsl:element name="INPUT">
                                                            <xsl:attribute name="type">text</xsl:attribute>
                                                            <xsl:attribute name="name">SearchText</xsl:attribute>
                                                            <xsl:attribute name="id">SearchText</xsl:attribute>
                                                            <xsl:attribute name="size">20</xsl:attribute>
                                                         </xsl:element>
                                                         </xsl:if>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                         <xsl:if test="(not(contains(/DATA/SYSTEM/@useroptions, '~$')))">
                                                            <xsl:element name="INPUT">
                                                               <xsl:attribute name="type">button</xsl:attribute>
                                                               <xsl:attribute name="value">
                                                                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Search']"/>
                                                               </xsl:attribute>
                                                               <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[searchClicked()]]></xsl:text></xsl:attribute>
                                                            </xsl:element>
                                                         </xsl:if>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                         <xsl:if test="(not(contains(/DATA/SYSTEM/@useroptions, '~$')))">
                                                            <xsl:element name="A">
                                                               <xsl:attribute name="onclick">w=window.open(this.href,"Help","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                               <xsl:attribute name="href">Pagex.asp?Page=SearchHelp</xsl:attribute>
                                                               <xsl:element name="IMG">
                                                                  <xsl:attribute name="src">Images/LearnMore.gif</xsl:attribute>
                                                                  <xsl:attribute name="border">0</xsl:attribute>
                                                               </xsl:element>
                                                            </xsl:element>
                                                         </xsl:if>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CourseNo']"/>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                         <xsl:element name="INPUT">
                                                         <xsl:attribute name="type">text</xsl:attribute>
                                                         <xsl:attribute name="name">CourseID</xsl:attribute>
                                                         <xsl:attribute name="id">CourseID</xsl:attribute>
                                                         <xsl:attribute name="size">2</xsl:attribute>
                                                         </xsl:element>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Grp']"/>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                         <xsl:element name="INPUT">
                                                         <xsl:attribute name="type">text</xsl:attribute>
                                                         <xsl:attribute name="name">Grp</xsl:attribute>
                                                         <xsl:attribute name="id">Grp</xsl:attribute>
                                                         <xsl:attribute name="size">2</xsl:attribute>
                                                         </xsl:element>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                         <xsl:element name="INPUT">
                                                            <xsl:attribute name="type">button</xsl:attribute>
                                                            <xsl:attribute name="value">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Go']"/>
                                                            </xsl:attribute>
                                                            <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[goClicked()]]></xsl:text></xsl:attribute>
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

                                                <xsl:if test="(count(/DATA/TXN/PROGRAM) &gt; 1)">
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">500</xsl:attribute>
                                                         <xsl:attribute name="align">center</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Programs']"/>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                         <xsl:element name="SELECT">
                                                            <xsl:attribute name="name">ProgramID</xsl:attribute>
                                                            <xsl:attribute name="id">ProgramID</xsl:attribute>
                                                            <xsl:attribute name="onchange"><xsl:text disable-output-escaping="yes"><![CDATA[programClicked()]]></xsl:text></xsl:attribute>
                                                            <xsl:for-each select="/DATA/TXN/PROGRAM">
                                                               <xsl:element name="OPTION">
                                                                  <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                                                  <xsl:if test="@selected"><xsl:attribute name="SELECTED"/></xsl:if>
                                                                  <xsl:value-of select="@name"/>
                                                               </xsl:element>
                                                            </xsl:for-each>
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

                                                <xsl:if test="(count(/DATA/TXN/ORG) &gt; 1)">
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">500</xsl:attribute>
                                                         <xsl:attribute name="align">center</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Favorites']"/>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                         <xsl:element name="SELECT">
                                                            <xsl:attribute name="name">FavoriteID</xsl:attribute>
                                                            <xsl:attribute name="id">FavoriteID</xsl:attribute>
                                                            <xsl:attribute name="onchange"><xsl:text disable-output-escaping="yes"><![CDATA[favoriteClicked()]]></xsl:text></xsl:attribute>
                                                            <xsl:for-each select="/DATA/TXN/ORG">
                                                               <xsl:element name="OPTION">
                                                                  <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                                                  <xsl:if test="@selected"><xsl:attribute name="SELECTED"/></xsl:if>
                                                                  <xsl:value-of select="@name"/>
                                                               </xsl:element>
                                                            </xsl:for-each>
                                                         </xsl:element>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="colspan">1</xsl:attribute>
                                                         <xsl:attribute name="height">3</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                </xsl:if>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">500</xsl:attribute>
                                                      <xsl:attribute name="align">right</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:if test="(/DATA/PARAM/@mode = 0)">
                                                         <xsl:element name="INPUT">
                                                            <xsl:attribute name="type">button</xsl:attribute>
                                                            <xsl:attribute name="class">smbutton</xsl:attribute>
                                                            <xsl:attribute name="value">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ReturnCourses']"/>
                                                            </xsl:attribute>
                                                            <xsl:attribute name="onclick">doSubmit(5,"")</xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:if>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:if test="(/DATA/PARAM/@mode = 2)">
                                                         <xsl:element name="INPUT">
                                                            <xsl:attribute name="type">button</xsl:attribute>
                                                            <xsl:attribute name="class">smbutton</xsl:attribute>
                                                            <xsl:attribute name="value">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ReturnClasses']"/>
                                                            </xsl:attribute>
                                                            <xsl:attribute name="onclick">doSubmit(6,"")</xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:if>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:if test="(/DATA/PARAM/@popup = 1)">
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

                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>

                              </xsl:element>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">3</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">Prompt</xsl:attribute>
                              <xsl:element name="span">
                                 <xsl:attribute name="id">HideFolder</xsl:attribute>
                                 <xsl:attribute name="style">DISPLAY: block;</xsl:attribute>
                                 <xsl:element name="A">
                                    <xsl:attribute name="href">#_</xsl:attribute>
                                    <xsl:attribute name="onclick">HideFolder()</xsl:attribute>
                                    <xsl:element name="IMG">
                                       <xsl:attribute name="src">Images/FolderClose.gif</xsl:attribute>
                                       <xsl:attribute name="align">absmiddle</xsl:attribute>
                                       <xsl:attribute name="border">0</xsl:attribute>
                                       <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='HideFolder']"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='HideFolder']"/></xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ExpandFolder']"/>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">Prompt</xsl:attribute>
                              <xsl:element name="span">
                                 <xsl:attribute name="id">ShowFolder</xsl:attribute>
                                 <xsl:attribute name="style">DISPLAY: none;</xsl:attribute>
                                 <xsl:element name="A">
                                    <xsl:attribute name="href">#_</xsl:attribute>
                                    <xsl:attribute name="onclick">ShowFolder()</xsl:attribute>
                                    <xsl:element name="IMG">
                                       <xsl:attribute name="src">Images/FolderOpen.gif</xsl:attribute>
                                       <xsl:attribute name="align">absmiddle</xsl:attribute>
                                       <xsl:attribute name="border">0</xsl:attribute>
                                       <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ShowFolder']"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ShowFolder']"/></xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/PARAM/@catalog != 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">3</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="height">0</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="SPAN">
                                    <xsl:attribute name="id">TreeView</xsl:attribute>
                                    <xsl:attribute name="class">TreeView</xsl:attribute>
                                    <xsl:attribute name="style">WIDTH: 600; HEIGHT: 200; BORDER: none;</xsl:attribute>
                                    <xsl:call-template name="TreeNode">
                                       <xsl:with-param name="parentid" select="0"/>
                                    </xsl:call-template>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">3</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="(/DATA/PARAM/@catalog = 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="SPAN">
                                    <xsl:attribute name="id">TreeView</xsl:attribute>
                                    <xsl:attribute name="class">TreeView</xsl:attribute>
                                    <xsl:attribute name="style">WIDTH: 300; HEIGHT: 25; BORDER: none; OVERFLOW: visible;</xsl:attribute>
                                    <xsl:call-template name="TreeNode">
                                       <xsl:with-param name="parentid" select="0"/>
                                    </xsl:call-template>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">3</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">3</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#004080</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
                              <xsl:attribute name="height">3</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="IFRAME">
                                 <xsl:attribute name="src"></xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="height">1800</xsl:attribute>
                                 <xsl:attribute name="frmheight">1800</xsl:attribute>
                                 <xsl:attribute name="id">frame</xsl:attribute>
                                 <xsl:attribute name="name">frame</xsl:attribute>
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
                              <xsl:attribute name="colspan">1</xsl:attribute>
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