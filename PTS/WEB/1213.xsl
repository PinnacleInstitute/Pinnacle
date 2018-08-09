<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
   <xsl:include href="HTMLHeading.xsl"/>
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
               <xsl:attribute name="width">250</xsl:attribute>
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
                                 <xsl:attribute name="onClick">showBranch('<xsl:value-of select="$nodeid"/>',<xsl:value-of select="$children"/>);openNode(<xsl:value-of select="$nodeid"/>);</xsl:attribute>
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
                           <xsl:attribute name="href">#_</xsl:attribute>
                           <xsl:attribute name="onclick">SetCategory(<xsl:value-of select="$nodeid"/>);</xsl:attribute>
                        <xsl:value-of select="@coursecategoryname"/>
                        </xsl:element>
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
            nodeOpenImg.src = "Images/tree-node.gif";

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
         <xsl:attribute name="id">wrapper</xsl:attribute>
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
                  <xsl:attribute name="name">Bookmark</xsl:attribute>
                  <xsl:attribute name="id">Bookmark</xsl:attribute>
                  <xsl:attribute name="value"><xsl:value-of select="/DATA/BOOKMARK/@nextbookmark"/></xsl:attribute>
               </xsl:element>
               <!--BEGIN PAGE LAYOUT ROW-->
               <xsl:element name="TR">
                  <xsl:element name="TD">
                     <xsl:attribute name="width">750</xsl:attribute>
                  </xsl:element>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function SetCategory(C){ 
               window.opener.document.getElementById('CourseCategoryID').value = C;
               window.close();
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="TR">

                  <xsl:element name="TD">
                     <xsl:attribute name="valign">top</xsl:attribute>
                     <xsl:attribute name="width">300</xsl:attribute>

                     <xsl:element name="TABLE">
                        <xsl:attribute name="border">0</xsl:attribute>
                        <xsl:attribute name="cellpadding">0</xsl:attribute>
                        <xsl:attribute name="cellspacing">0</xsl:attribute>
                        <xsl:attribute name="width">300</xsl:attribute>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">300</xsl:attribute>
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
                              <xsl:attribute name="width">300</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">Prompt</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CatalogText']"/>
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
                              <xsl:attribute name="width">300</xsl:attribute>
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

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">300</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="SPAN">
                                 <xsl:attribute name="id">TreeView</xsl:attribute>
                                 <xsl:attribute name="class">TreeView</xsl:attribute>
                                 <xsl:attribute name="style">WIDTH: 300; HEIGHT: 400; BORDER: none;</xsl:attribute>
                                 <xsl:call-template name="TreeNode">
                                    <xsl:with-param name="parentid" select="0"/>
                                 </xsl:call-template>
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