<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
   <xsl:include href="HTMLHeading.xsl"/>
   <xsl:include href="CustomFields.xsl"/>
   <xsl:include href="Bookmark.xsl"/>
   <xsl:output omit-xml-declaration="yes"/>

   <xsl:variable name="firstparent" select="0"/>

   <xsl:template name="TreeNode">
      <xsl:param name="parentid"/>

      <xsl:for-each select="/DATA/TXN/PTSBARTERCATEGORYS/PTSBARTERCATEGORY[@parentid=$parentid]">
         <xsl:variable name="nodeid" select="@bartercategoryid"/>
         <xsl:variable name="children" select="count(/DATA/TXN/PTSBARTERCATEGORYS/PTSBARTERCATEGORY[@parentid=$nodeid])"/>

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
                                 <xsl:attribute name="onClick">showBranch('<xsl:value-of select="$nodeid"/>',<xsl:value-of select="$children"/>);openNode(<xsl:value-of select="$nodeid"/>);SetCategory(<xsl:value-of select="@bartercategoryid"/>,<xsl:value-of select="@children"/>);</xsl:attribute>
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
                     <xsl:if test="(@children != 0)">
                           <xsl:element name="A">
                              <xsl:attribute name="href">#_</xsl:attribute>
                              <xsl:attribute name="onclick">SetCategory(<xsl:value-of select="@bartercategoryid"/>,<xsl:value-of select="@children"/>);</xsl:attribute>
                           <xsl:element name="font">
                              <xsl:attribute name="size">4</xsl:attribute>
                           <xsl:value-of select="@bartercategoryname"/>
                           </xsl:element>
                           </xsl:element>
                     </xsl:if>
                     <xsl:if test="(@children = 0)">
                           <xsl:element name="A">
                              <xsl:attribute name="href">#_</xsl:attribute>
                              <xsl:attribute name="onclick">SetCategory(<xsl:value-of select="@bartercategoryid"/>,<xsl:value-of select="@children"/>);</xsl:attribute>
                           <xsl:element name="font">
                              <xsl:attribute name="size">3</xsl:attribute>
                           <xsl:value-of select="@bartercategoryname"/>
                           </xsl:element>
                           </xsl:element>
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
         <xsl:with-param name="pagename" select="/DATA/LANGUAGE/LABEL[@name='BarterAd']"/>
         <xsl:with-param name="includecalendar" select="true()"/>
         <xsl:with-param name="htmleditor">simple2</xsl:with-param>
      </xsl:call-template>

      <!--BEGIN BODY-->
      <xsl:element name="BODY">
         <xsl:attribute name="topmargin">0</xsl:attribute>
         <xsl:attribute name="leftmargin">10</xsl:attribute>
         <xsl:attribute name="background">Images/bg7.jpg</xsl:attribute>
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
               <xsl:attribute name="onload">document.getElementById('ConsumerID').focus()</xsl:attribute>
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
         <xsl:attribute name="id">wrapper850box</xsl:attribute>
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
               <xsl:attribute name="name">BarterAd</xsl:attribute>
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
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function SetCategory(id,children){ 
          if( children == 0 ) {
            var CityAreas = document.getElementById('CityAreas').value;
            var aid = document.getElementById('BarterArea2ID').value;
            if( CityAreas != 0 && aid == 0 ) {
              alert('Select City Area first to continue.'); 
            }  
            else {  
              document.getElementById('BarterCategoryID').value = id;
              doSubmit(0,'');
            }
          }
         }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function SetCityArea(id){ 
          document.getElementById('BarterArea2ID').value = id;
         }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function UpdateLocation(id){ 
          document.getElementById('BarterArea1ID').value = id;
          doSubmit(0,'');
         }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function SelectBarterArea(){ 
          document.getElementById('BarterArea2ID').value = 0;
          document.getElementById('BarterCategoryID').value = 0;
          var pid = document.getElementById('AreaParentID').value;
          var url = "17010.asp?barterareaid=" + pid
          var win = window.open(url,"BarterArea","top=200,left=200,height=400,width=425,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no,scrollbars=1")
               win.focus();
         }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function BarterImages(){ 
          var baid = document.getElementById('BarterAdID').value;
          var url = "17311.asp?BarterAdID=" + baid
          var win = window.open(url,"BarterImages","top=100,left=100,height=400,width=650,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no");
          win.focus();
         }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function UpdateImages(){ 
          doSubmit(5,'');
         }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function UpdateStatus(stat){ 
          document.getElementById('Status').value = stat;
          doSubmit(5,'');
         }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function BarterCredits(){ 
          var id = document.getElementById('BarterAdID').value
          var cid = document.getElementById('ConsumerID').value
          var url = "17411.asp?ConsumerID=" + cid + "&BarterAdID=" + id
          var win = window.open(url,"BarterCredits","top=100,left=100,height=550,width=500,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no");
          win.focus();
         }]]></xsl:text>
               </xsl:element>

               <xsl:element name="TR">

                  <xsl:element name="TD">
                     <xsl:attribute name="width">10</xsl:attribute>
                  </xsl:element>

                  <xsl:element name="TD">
                     <xsl:attribute name="valign">top</xsl:attribute>
                     <xsl:attribute name="width">850</xsl:attribute>

                     <xsl:element name="TABLE">
                        <xsl:attribute name="border">0</xsl:attribute>
                        <xsl:attribute name="cellpadding">0</xsl:attribute>
                        <xsl:attribute name="cellspacing">0</xsl:attribute>
                        <xsl:attribute name="width">850</xsl:attribute>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">850</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">BarterAdID</xsl:attribute>
                              <xsl:attribute name="id">BarterAdID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@barteradid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">AreaCategory</xsl:attribute>
                              <xsl:attribute name="id">AreaCategory</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@areacategory"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">CityAreas</xsl:attribute>
                              <xsl:attribute name="id">CityAreas</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@cityareas"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">AreaParentID</xsl:attribute>
                              <xsl:attribute name="id">AreaParentID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@areaparentid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">IsCustomFields</xsl:attribute>
                              <xsl:attribute name="id">IsCustomFields</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@iscustomfields"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Mode</xsl:attribute>
                              <xsl:attribute name="id">Mode</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@mode"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">NoPrice</xsl:attribute>
                              <xsl:attribute name="id">NoPrice</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@noprice"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">NoCondition</xsl:attribute>
                              <xsl:attribute name="id">NoCondition</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@nocondition"/></xsl:attribute>
                           </xsl:element>

                        <xsl:if test="(/DATA/PARAM/@mode = 0)">
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">BarterCategoryID</xsl:attribute>
                                 <xsl:attribute name="id">BarterCategoryID</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@bartercategoryid"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">BarterArea1ID</xsl:attribute>
                                 <xsl:attribute name="id">BarterArea1ID</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@barterarea1id"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">BarterArea2ID</xsl:attribute>
                                 <xsl:attribute name="id">BarterArea2ID</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@barterarea2id"/></xsl:attribute>
                              </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">850</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewBarterAd']"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">850</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeadingLite</xsl:attribute>
                                    <xsl:attribute name="style">background-color:#ffffff</xsl:attribute>
                                    <xsl:value-of select="/DATA/PARAM/@areacategory" disable-output-escaping="yes"/>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:element name="A">
                                       <xsl:attribute name="href">#_</xsl:attribute>
                                       <xsl:attribute name="onclick">SelectBarterArea()</xsl:attribute>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/lookup24.png</xsl:attribute>
                                          <xsl:attribute name="align">absmiddle</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                          <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LookupArea']"/></xsl:attribute>
                                          <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LookupArea']"/></xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:if test="(/DATA/PARAM/@cityareas != 0)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">1</xsl:attribute>
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">850</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:attribute name="class">PageHeadingLite</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SelectCityArea']"/>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">1</xsl:attribute>
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:for-each select="/DATA/TXN/PTSBARTERAREAS/PTSBARTERAREA">
                                    <xsl:if test="(@barterareaname != '')">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">850</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">radio</xsl:attribute>
                                                <xsl:attribute name="name">Radio</xsl:attribute>
                                                <xsl:attribute name="id">Radio</xsl:attribute>
                                                <xsl:attribute name="onclick">SetCityArea(<xsl:value-of select="@barterareaid"/>)</xsl:attribute>
                                                <xsl:attribute name="value">0</xsl:attribute>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="font">
                                                   <xsl:attribute name="size">4</xsl:attribute>
                                                <xsl:value-of select="@barterareaname"/>
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

                              </xsl:for-each>
                           </xsl:if>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">850</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeadingLite</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SelectCategory']"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
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
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">850</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Cancel']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick">doSubmit(3,"")</xsl:attribute>
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
                        <xsl:if test="(/DATA/PARAM/@mode = 1)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">850</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                    <xsl:if test="(/DATA/PARAM/@barteradid = 0)">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewBarterAd']"/>
                                       <xsl:text>:</xsl:text>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    </xsl:if>
                                    <xsl:if test="(/DATA/PARAM/@barteradid != 0)">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterAd']"/>
                                       <xsl:text>:</xsl:text>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    </xsl:if>
                                    <xsl:value-of select="/DATA/PARAM/@areacategory" disable-output-escaping="yes"/>
                              </xsl:element>
                           </xsl:element>

                           <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 23) or (/DATA/SYSTEM/@usergroup = 51)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">850</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">top</xsl:attribute>
                                    <xsl:element name="TABLE">
                                       <xsl:attribute name="border">0</xsl:attribute>
                                       <xsl:attribute name="cellpadding">0</xsl:attribute>
                                       <xsl:attribute name="cellspacing">0</xsl:attribute>
                                       <xsl:attribute name="width">850</xsl:attribute>
                                       <xsl:attribute name="style">background-color: #fcfde5;</xsl:attribute>
                                       <xsl:attribute name="class">box-gray</xsl:attribute>

                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">850</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="colspan">1</xsl:attribute>
                                                <xsl:attribute name="height">12</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">850</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ConsumerID']"/>
                                                   <xsl:text>:</xsl:text>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">text</xsl:attribute>
                                                   <xsl:attribute name="name">ConsumerID</xsl:attribute>
                                                   <xsl:attribute name="id">ConsumerID</xsl:attribute>
                                                   <xsl:attribute name="size">3</xsl:attribute>
                                                   <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBARTERAD/@consumerid"/></xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterArea1ID']"/>
                                                   <xsl:text>:</xsl:text>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">text</xsl:attribute>
                                                   <xsl:attribute name="name">BarterArea1ID</xsl:attribute>
                                                   <xsl:attribute name="id">BarterArea1ID</xsl:attribute>
                                                   <xsl:attribute name="size">3</xsl:attribute>
                                                   <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBARTERAD/@barterarea1id"/></xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterArea2ID']"/>
                                                   <xsl:text>:</xsl:text>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">text</xsl:attribute>
                                                   <xsl:attribute name="name">BarterArea2ID</xsl:attribute>
                                                   <xsl:attribute name="id">BarterArea2ID</xsl:attribute>
                                                   <xsl:attribute name="size">3</xsl:attribute>
                                                   <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBARTERAD/@barterarea2id"/></xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterCategoryID']"/>
                                                   <xsl:text>:</xsl:text>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">text</xsl:attribute>
                                                   <xsl:attribute name="name">BarterCategoryID</xsl:attribute>
                                                   <xsl:attribute name="id">BarterCategoryID</xsl:attribute>
                                                   <xsl:attribute name="size">3</xsl:attribute>
                                                   <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBARTERAD/@bartercategoryid"/></xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Options']"/>
                                                   <xsl:text>:</xsl:text>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">text</xsl:attribute>
                                                   <xsl:attribute name="name">Options</xsl:attribute>
                                                   <xsl:attribute name="id">Options</xsl:attribute>
                                                   <xsl:attribute name="size">5</xsl:attribute>
                                                   <xsl:attribute name="maxlength">20</xsl:attribute>
                                                   <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBARTERAD/@options"/></xsl:attribute>
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
                                                <xsl:attribute name="width">850</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Status']"/>
                                                   <xsl:text>:</xsl:text>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:element name="SELECT">
                                                      <xsl:attribute name="name">Status</xsl:attribute>
                                                      <xsl:attribute name="id">Status</xsl:attribute>
                                                      <xsl:for-each select="/DATA/TXN/PTSBARTERAD/PTSSTATUSS/ENUM">
                                                         <xsl:element name="OPTION">
                                                            <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                                            <xsl:if test="@selected"><xsl:attribute name="SELECTED"/></xsl:if>
                                                            <xsl:variable name="tmp3"><xsl:value-of select="current()/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp3]"/>
                                                         </xsl:element>
                                                      </xsl:for-each>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PostDate']"/>
                                                   <xsl:text>:</xsl:text>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">text</xsl:attribute>
                                                   <xsl:attribute name="name">PostDate</xsl:attribute>
                                                   <xsl:attribute name="id">PostDate</xsl:attribute>
                                                   <xsl:attribute name="size">15</xsl:attribute>
                                                   <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBARTERAD/@postdate"/></xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="name">Calendar</xsl:attribute>
                                                      <xsl:attribute name="src">Images/Calendar.gif</xsl:attribute>
                                                      <xsl:attribute name="width">16</xsl:attribute>
                                                      <xsl:attribute name="height">16</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                      <xsl:attribute name="onclick">CalendarPopup(document.forms[0], document.getElementById('PostDate'))</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='UpdateDate']"/>
                                                   <xsl:text>:</xsl:text>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">text</xsl:attribute>
                                                   <xsl:attribute name="name">UpdateDate</xsl:attribute>
                                                   <xsl:attribute name="id">UpdateDate</xsl:attribute>
                                                   <xsl:attribute name="size">15</xsl:attribute>
                                                   <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBARTERAD/@updatedate"/></xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="name">Calendar</xsl:attribute>
                                                      <xsl:attribute name="src">Images/Calendar.gif</xsl:attribute>
                                                      <xsl:attribute name="width">16</xsl:attribute>
                                                      <xsl:attribute name="height">16</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                      <xsl:attribute name="onclick">CalendarPopup(document.forms[0], document.getElementById('UpdateDate'))</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EndDate']"/>
                                                   <xsl:text>:</xsl:text>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">text</xsl:attribute>
                                                   <xsl:attribute name="name">EndDate</xsl:attribute>
                                                   <xsl:attribute name="id">EndDate</xsl:attribute>
                                                   <xsl:attribute name="size">15</xsl:attribute>
                                                   <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBARTERAD/@enddate"/></xsl:attribute>
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
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="colspan">1</xsl:attribute>
                                                <xsl:attribute name="height">12</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>

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
                           <xsl:if test="(/DATA/SYSTEM/@usergroup &gt; 23) and (/DATA/SYSTEM/@usergroup != 51)">
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">hidden</xsl:attribute>
                                    <xsl:attribute name="name">ConsumerID</xsl:attribute>
                                    <xsl:attribute name="id">ConsumerID</xsl:attribute>
                                    <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBARTERAD/@consumerid"/></xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">hidden</xsl:attribute>
                                    <xsl:attribute name="name">BarterArea1ID</xsl:attribute>
                                    <xsl:attribute name="id">BarterArea1ID</xsl:attribute>
                                    <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBARTERAD/@barterarea1id"/></xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">hidden</xsl:attribute>
                                    <xsl:attribute name="name">BarterArea2ID</xsl:attribute>
                                    <xsl:attribute name="id">BarterArea2ID</xsl:attribute>
                                    <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBARTERAD/@barterarea2id"/></xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">hidden</xsl:attribute>
                                    <xsl:attribute name="name">BarterCategoryID</xsl:attribute>
                                    <xsl:attribute name="id">BarterCategoryID</xsl:attribute>
                                    <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBARTERAD/@bartercategoryid"/></xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">hidden</xsl:attribute>
                                    <xsl:attribute name="name">Options</xsl:attribute>
                                    <xsl:attribute name="id">Options</xsl:attribute>
                                    <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBARTERAD/@options"/></xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">hidden</xsl:attribute>
                                    <xsl:attribute name="name">Status</xsl:attribute>
                                    <xsl:attribute name="id">Status</xsl:attribute>
                                    <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBARTERAD/@status"/></xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">hidden</xsl:attribute>
                                    <xsl:attribute name="name">PostDate</xsl:attribute>
                                    <xsl:attribute name="id">PostDate</xsl:attribute>
                                    <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBARTERAD/@postdate"/></xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">hidden</xsl:attribute>
                                    <xsl:attribute name="name">UpdateDate</xsl:attribute>
                                    <xsl:attribute name="id">UpdateDate</xsl:attribute>
                                    <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBARTERAD/@updatedate"/></xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">hidden</xsl:attribute>
                                    <xsl:attribute name="name">EndDate</xsl:attribute>
                                    <xsl:attribute name="id">EndDate</xsl:attribute>
                                    <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBARTERAD/@enddate"/></xsl:attribute>
                                 </xsl:element>

                           </xsl:if>
                           <xsl:if test="(/DATA/PARAM/@barteradid != 0)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">850</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">top</xsl:attribute>
                                    <xsl:element name="TABLE">
                                       <xsl:attribute name="border">0</xsl:attribute>
                                       <xsl:attribute name="cellpadding">0</xsl:attribute>
                                       <xsl:attribute name="cellspacing">0</xsl:attribute>
                                       <xsl:attribute name="width">850</xsl:attribute>
                                       <xsl:attribute name="style">background-color: #fcfde5;</xsl:attribute>
                                       <xsl:attribute name="class">box-gray</xsl:attribute>

                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">750</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">100</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
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
                                                <xsl:attribute name="width">750</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Status']"/>
                                                   <xsl:text>:</xsl:text>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:element name="b">
                                                   <xsl:variable name="tmp3"><xsl:value-of select="/DATA/TXN/PTSBARTERAD/PTSSTATUSS/ENUM[@id=/DATA/TXN/PTSBARTERAD/@status]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp3]"/>
                                                   </xsl:element>
                                                <xsl:if test="(/DATA/TXN/PTSBARTERAD/@status = 2)">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PostDate']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:element name="b">
                                                      <xsl:value-of select="/DATA/TXN/PTSBARTERAD/@postdate"/>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EndDate']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:element name="b">
                                                      <xsl:value-of select="/DATA/TXN/PTSBARTERAD/@enddate"/>
                                                      </xsl:element>
                                                </xsl:if>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='UpdateDate']"/>
                                                   <xsl:text>:</xsl:text>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:element name="b">
                                                   <xsl:value-of select="/DATA/TXN/PTSBARTERAD/@updatedate"/>
                                                   </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">100</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:if test="(/DATA/PARAM/@barteradid != 0)">
                                                      <xsl:element name="INPUT">
                                                         <xsl:attribute name="type">button</xsl:attribute>
                                                         <xsl:attribute name="class">smbutton</xsl:attribute>
                                                         <xsl:attribute name="value">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Update']"/>
                                                         </xsl:attribute>
                                                         <xsl:attribute name="onclick">doSubmit(5,"")</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:element name="INPUT">
                                                         <xsl:attribute name="type">button</xsl:attribute>
                                                         <xsl:attribute name="class">smbutton</xsl:attribute>
                                                         <xsl:attribute name="value">
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Return']"/>
                                                         </xsl:attribute>
                                                         <xsl:attribute name="onclick">doSubmit(3,"")</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
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
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">1</xsl:attribute>
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>

                           </xsl:if>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">850</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">top</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">850</xsl:attribute>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">475</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">25</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">350</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">475</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:element name="TABLE">
                                                <xsl:attribute name="border">0</xsl:attribute>
                                                <xsl:attribute name="cellpadding">0</xsl:attribute>
                                                <xsl:attribute name="cellspacing">0</xsl:attribute>
                                                <xsl:attribute name="width">475</xsl:attribute>
                                                <xsl:attribute name="style">margin-left:7px;</xsl:attribute>
                                                <xsl:attribute name="class">box-gray</xsl:attribute>

                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">100</xsl:attribute>
                                                         <xsl:attribute name="align">right</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">375</xsl:attribute>
                                                         <xsl:attribute name="align">left</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="colspan">2</xsl:attribute>
                                                         <xsl:attribute name="width">475</xsl:attribute>
                                                         <xsl:attribute name="align">left</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:attribute name="class">PageHeader</xsl:attribute>
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="size">2</xsl:attribute>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ContactInfo']"/>
                                                         </xsl:element>
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
                                                         <xsl:attribute name="width">100</xsl:attribute>
                                                         <xsl:attribute name="align">right</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ContactName']"/>
                                                         <xsl:text>:</xsl:text>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                      </xsl:element>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">375</xsl:attribute>
                                                         <xsl:attribute name="align">left</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:element name="INPUT">
                                                         <xsl:attribute name="type">text</xsl:attribute>
                                                         <xsl:attribute name="name">ContactName</xsl:attribute>
                                                         <xsl:attribute name="id">ContactName</xsl:attribute>
                                                         <xsl:attribute name="size">40</xsl:attribute>
                                                         <xsl:attribute name="maxlength">40</xsl:attribute>
                                                         <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBARTERAD/@contactname"/></xsl:attribute>
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
                                                         <xsl:attribute name="width">100</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">375</xsl:attribute>
                                                         <xsl:attribute name="align">left</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:element name="INPUT">
                                                         <xsl:attribute name="type">checkbox</xsl:attribute>
                                                         <xsl:attribute name="name">IsEmail</xsl:attribute>
                                                         <xsl:attribute name="id">IsEmail</xsl:attribute>
                                                         <xsl:attribute name="value">1</xsl:attribute>
                                                         <xsl:if test="(/DATA/TXN/PTSBARTERAD/@isemail = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsEmail']"/>
                                                         </xsl:element>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                         <xsl:element name="INPUT">
                                                         <xsl:attribute name="type">text</xsl:attribute>
                                                         <xsl:attribute name="name">ContactEmail</xsl:attribute>
                                                         <xsl:attribute name="id">ContactEmail</xsl:attribute>
                                                         <xsl:attribute name="size">40</xsl:attribute>
                                                         <xsl:attribute name="maxlength">80</xsl:attribute>
                                                         <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBARTERAD/@contactemail"/></xsl:attribute>
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
                                                         <xsl:attribute name="width">100</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">375</xsl:attribute>
                                                         <xsl:attribute name="align">left</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:element name="INPUT">
                                                         <xsl:attribute name="type">checkbox</xsl:attribute>
                                                         <xsl:attribute name="name">IsPhone</xsl:attribute>
                                                         <xsl:attribute name="id">IsPhone</xsl:attribute>
                                                         <xsl:attribute name="value">1</xsl:attribute>
                                                         <xsl:if test="(/DATA/TXN/PTSBARTERAD/@isphone = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsPhone']"/>
                                                         </xsl:element>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                         <xsl:element name="INPUT">
                                                         <xsl:attribute name="type">text</xsl:attribute>
                                                         <xsl:attribute name="name">ContactPhone</xsl:attribute>
                                                         <xsl:attribute name="id">ContactPhone</xsl:attribute>
                                                         <xsl:attribute name="size">40</xsl:attribute>
                                                         <xsl:attribute name="maxlength">40</xsl:attribute>
                                                         <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBARTERAD/@contactphone"/></xsl:attribute>
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
                                                         <xsl:attribute name="width">100</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">375</xsl:attribute>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                         <xsl:element name="INPUT">
                                                         <xsl:attribute name="type">checkbox</xsl:attribute>
                                                         <xsl:attribute name="name">IsText</xsl:attribute>
                                                         <xsl:attribute name="id">IsText</xsl:attribute>
                                                         <xsl:attribute name="value">1</xsl:attribute>
                                                         <xsl:if test="(/DATA/TXN/PTSBARTERAD/@istext = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsText']"/>
                                                         </xsl:element>
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
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">25</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">350</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:if test="(/DATA/PARAM/@barteradid != 0)">
                                                <xsl:for-each select="/DATA/TXN/PTSBARTERIMAGES/PTSBARTERIMAGE">
                                                      <xsl:if test="(@ext != '')">
                                                            <xsl:element name="IMG">
                                                               <xsl:attribute name="src">Images/barter//<xsl:value-of select="concat(@barterimageid,'s.',@ext)"/></xsl:attribute>
                                                               <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                               <xsl:attribute name="border">0</xsl:attribute>
                                                            </xsl:element>
                                                      </xsl:if>
                                                </xsl:for-each>
                                                   <xsl:element name="BR"/><xsl:element name="BR"/>
                                                   <xsl:element name="INPUT">
                                                      <xsl:attribute name="type">button</xsl:attribute>
                                                      <xsl:attribute name="class">bigbutton</xsl:attribute>
                                                      <xsl:attribute name="value">
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AddImages']"/>
                                                      </xsl:attribute>
                                                      <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[BarterImages()]]></xsl:text></xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="BR"/><xsl:element name="BR"/>
                                                   <xsl:if test="(/DATA/TXN/PTSBARTERAD/@options != '')">
                                                      <xsl:element name="b">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Features']"/>
                                                      <xsl:text>:</xsl:text>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                      </xsl:element>
                                                   </xsl:if>
                                                <xsl:if test="(contains(/DATA/TXN/PTSBARTERAD/@options, 'C'))">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/Feature_Title.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Feature_Title']"/></xsl:attribute>
                                                         <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Feature_Title']"/></xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                </xsl:if>
                                                <xsl:if test="(contains(/DATA/TXN/PTSBARTERAD/@options, 'd'))">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/Feature_Images.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Feature_Images']"/></xsl:attribute>
                                                         <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Feature_Images']"/></xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                </xsl:if>
                                                <xsl:if test="(contains(/DATA/TXN/PTSBARTERAD/@options, 'D'))">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/Feature_Images2.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Feature_Images+']"/></xsl:attribute>
                                                         <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Feature_Images+']"/></xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                </xsl:if>
                                                <xsl:if test="(contains(/DATA/TXN/PTSBARTERAD/@options, 'E'))">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/Feature_Editor.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Feature_Editor']"/></xsl:attribute>
                                                         <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Feature_Editor']"/></xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                </xsl:if>
                                                <xsl:if test="(contains(/DATA/TXN/PTSBARTERAD/@options, 'F'))">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/Feature_Long.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Feature_Long']"/></xsl:attribute>
                                                         <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Feature_Long']"/></xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                </xsl:if>
                                                <xsl:if test="(contains(/DATA/TXN/PTSBARTERAD/@options, 'G'))">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/Feature_Listing.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Feature_Listing']"/></xsl:attribute>
                                                         <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Feature_Listing']"/></xsl:attribute>
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
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">800</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">top</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">800</xsl:attribute>
                                    <xsl:attribute name="style">background-color: #e3e4f5; margin-left:7px;</xsl:attribute>
                                    <xsl:attribute name="class">box-gray</xsl:attribute>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">800</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">1</xsl:attribute>
                                             <xsl:attribute name="height">12</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">800</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Title']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">text</xsl:attribute>
                                                <xsl:attribute name="name">Title</xsl:attribute>
                                                <xsl:attribute name="id">Title</xsl:attribute>
                                                <xsl:attribute name="size">80</xsl:attribute>
                                                <xsl:attribute name="maxlength">100</xsl:attribute>
                                                <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBARTERAD/@title"/></xsl:attribute>
                                                </xsl:element>
                                             <xsl:if test="(/DATA/PARAM/@noprice = 0)">
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Price']"/>
                                                   <xsl:text>:</xsl:text>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">text</xsl:attribute>
                                                   <xsl:attribute name="name">Price</xsl:attribute>
                                                   <xsl:attribute name="id">Price</xsl:attribute>
                                                   <xsl:attribute name="size">10</xsl:attribute>
                                                   <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBARTERAD/@price"/></xsl:attribute>
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

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">800</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Location']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">text</xsl:attribute>
                                                <xsl:attribute name="name">Location</xsl:attribute>
                                                <xsl:attribute name="id">Location</xsl:attribute>
                                                <xsl:attribute name="size">40</xsl:attribute>
                                                <xsl:attribute name="maxlength">40</xsl:attribute>
                                                <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBARTERAD/@location"/></xsl:attribute>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Zip']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">text</xsl:attribute>
                                                <xsl:attribute name="name">Zip</xsl:attribute>
                                                <xsl:attribute name="id">Zip</xsl:attribute>
                                                <xsl:attribute name="size">10</xsl:attribute>
                                                <xsl:attribute name="maxlength">10</xsl:attribute>
                                                <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBARTERAD/@zip"/></xsl:attribute>
                                                </xsl:element>
                                             <xsl:if test="(/DATA/PARAM/@nocondition = 0)">
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Condition']"/>
                                                   <xsl:text>:</xsl:text>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:element name="SELECT">
                                                      <xsl:attribute name="name">Condition</xsl:attribute>
                                                      <xsl:attribute name="id">Condition</xsl:attribute>
                                                      <xsl:for-each select="/DATA/TXN/PTSBARTERAD/PTSCONDITIONS/ENUM">
                                                         <xsl:element name="OPTION">
                                                            <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                                            <xsl:if test="@selected"><xsl:attribute name="SELECTED"/></xsl:if>
                                                            <xsl:variable name="tmp4"><xsl:value-of select="current()/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp4]"/>
                                                         </xsl:element>
                                                      </xsl:for-each>
                                                   </xsl:element>
                                             </xsl:if>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">1</xsl:attribute>
                                             <xsl:attribute name="height">24</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">775</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="TABLE">
                                                <xsl:attribute name="border">0</xsl:attribute>
                                                <xsl:attribute name="cellpadding">0</xsl:attribute>
                                                <xsl:attribute name="cellspacing">0</xsl:attribute>
                                                <xsl:attribute name="width">775</xsl:attribute>

                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">200</xsl:attribute>
                                                         <xsl:attribute name="align">left</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">575</xsl:attribute>
                                                         <xsl:attribute name="align">right</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">200</xsl:attribute>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Description']"/>
                                                      </xsl:element>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">575</xsl:attribute>
                                                         <xsl:attribute name="align">right</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:element name="i">
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="size">2</xsl:attribute>
                                                            <xsl:attribute name="color">blue</xsl:attribute>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='DescriptionText']"/>
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
                                             <xsl:attribute name="height">6</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">800</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:if test="(not(contains(/DATA/TXN/PTSBARTERAD/@options, 'E')))">
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:element name="TEXTAREA">
                                                      <xsl:attribute name="name">Description</xsl:attribute>
                                                      <xsl:attribute name="id">Description</xsl:attribute>
                                                      <xsl:attribute name="rows">10</xsl:attribute>
                                                      <xsl:attribute name="cols">95</xsl:attribute>
                                                      <xsl:attribute name="onkeyup"><xsl:text disable-output-escaping="yes"><![CDATA[if (value.length>4000) {doMaxLenMsg(4000); value=value.substring(0,4000);}]]></xsl:text></xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSBARTERAD/DESCRIPTION/comment()" disable-output-escaping="yes"/>
                                                   </xsl:element>
                                                   <xsl:element name="BR"/><xsl:element name="BR"/>
                                             </xsl:if>
                                             <xsl:if test="(contains(/DATA/TXN/PTSBARTERAD/@options, 'E'))">
                                                   <xsl:element name="TEXTAREA">
                                                      <xsl:attribute name="name">Description</xsl:attribute>
                                                      <xsl:attribute name="id">Description</xsl:attribute>
                                                      <xsl:attribute name="rows">10</xsl:attribute>
                                                      <xsl:attribute name="cols">95</xsl:attribute>
                                                      <xsl:attribute name="onkeyup"><xsl:text disable-output-escaping="yes"><![CDATA[if (value.length>4000) {doMaxLenMsg(4000); value=value.substring(0,4000);}]]></xsl:text></xsl:attribute>
                                                      <xsl:value-of select="/DATA/TXN/PTSBARTERAD/DESCRIPTION/comment()" disable-output-escaping="yes"/>
                                                   </xsl:element>
                                                   <xsl:element name="SCRIPT">
                                                      <xsl:attribute name="language">JavaScript1.2</xsl:attribute>
                                                      <![CDATA[   CKEDITOR.replace('Description', { toolbar:'simple2', wordcount:{showParagraphs:false,showCharCount:true,countSpacesAsChars:true,countHTML:true,maxCharCount:4000}, height:200 } );  ]]>
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
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:if test="(/DATA/PARAM/@iscustomfields != 0)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">800</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">top</xsl:attribute>
                                    <xsl:element name="TABLE">
                                       <xsl:attribute name="border">0</xsl:attribute>
                                       <xsl:attribute name="cellpadding">0</xsl:attribute>
                                       <xsl:attribute name="cellspacing">0</xsl:attribute>
                                       <xsl:attribute name="width">800</xsl:attribute>
                                       <xsl:attribute name="style">background-color: #e3e4f5; margin-left:7px;</xsl:attribute>
                                       <xsl:attribute name="class">box-gray</xsl:attribute>

                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">100</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">700</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="colspan">2</xsl:attribute>
                                                <xsl:attribute name="width">800</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:attribute name="class">PageHeader</xsl:attribute>
                                                <xsl:element name="font">
                                                   <xsl:attribute name="size">2</xsl:attribute>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Details']"/>
                                                   <xsl:text>:</xsl:text>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/TXN/PTSBARTERCATEGORY/@bartercategoryname"/>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="colspan">2</xsl:attribute>
                                                <xsl:attribute name="height">12</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>

                                          <xsl:for-each select="/DATA/TXN/FIELDS/FIELD">
                                             <xsl:call-template name="CustomFields">
                                                <xsl:with-param name="margin" select="0"/>
                                                <xsl:with-param name="secure" select="0"/>
                                             </xsl:call-template>
                                          </xsl:for-each>

                                          <xsl:element name="TR">
                                             <xsl:attribute name="height">12</xsl:attribute>
                                          </xsl:element>

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

                           <xsl:if test="(contains(/DATA/TXN/PTSBARTERAD/@options, 'F'))">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">825</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">top</xsl:attribute>
                                    <xsl:element name="TABLE">
                                       <xsl:attribute name="border">0</xsl:attribute>
                                       <xsl:attribute name="cellpadding">0</xsl:attribute>
                                       <xsl:attribute name="cellspacing">0</xsl:attribute>
                                       <xsl:attribute name="width">825</xsl:attribute>
                                       <xsl:attribute name="style">background-color: #e3e4f5; margin-left:7px;</xsl:attribute>
                                       <xsl:attribute name="class">box-gray</xsl:attribute>

                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">825</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">825</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:attribute name="class">PageHeader</xsl:attribute>
                                                <xsl:element name="font">
                                                   <xsl:attribute name="size">2</xsl:attribute>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LongDescription']"/>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:element>

                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">825</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="TEXTAREA">
                                                   <xsl:attribute name="name">Data</xsl:attribute>
                                                   <xsl:attribute name="id">Data</xsl:attribute>
                                                   <xsl:attribute name="rows">20</xsl:attribute>
                                                   <xsl:attribute name="cols">90</xsl:attribute>
                                                   <xsl:value-of select="/DATA/TXN/PTSHTMLFILE/DATA/comment()" disable-output-escaping="yes"/>
                                                </xsl:element>
                                                <xsl:element name="SCRIPT">
                                                   <xsl:attribute name="language">JavaScript1.2</xsl:attribute>
                                                   <![CDATA[   CKEDITOR.replace('Data', { toolbar:'simple2', wordcount:{showCharCount:true}, height:400 } );  ]]>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:element>

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

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">800</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">top</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">800</xsl:attribute>
                                    <xsl:attribute name="style">background-color: #cefad2; margin-left:7px;</xsl:attribute>
                                    <xsl:attribute name="class">box-gray</xsl:attribute>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">800</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">800</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:attribute name="class">PageHeader</xsl:attribute>
                                             <xsl:element name="font">
                                                <xsl:attribute name="size">2</xsl:attribute>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AcceptedPayments']"/>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">1</xsl:attribute>
                                             <xsl:attribute name="height">12</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">800</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">checkbox</xsl:attribute>
                                                <xsl:attribute name="name">BarterPaymentPoints</xsl:attribute>
                                                <xsl:attribute name="id">BarterPaymentPoints</xsl:attribute>
                                                <xsl:attribute name="value">1</xsl:attribute>
                                                <xsl:if test="(/DATA/PARAM/@barterpaymentpoints = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentPoints']"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">checkbox</xsl:attribute>
                                                <xsl:attribute name="name">BarterPaymentCash</xsl:attribute>
                                                <xsl:attribute name="id">BarterPaymentCash</xsl:attribute>
                                                <xsl:attribute name="value">1</xsl:attribute>
                                                <xsl:if test="(/DATA/PARAM/@barterpaymentcash = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentCash']"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">checkbox</xsl:attribute>
                                                <xsl:attribute name="name">BarterPaymentCC</xsl:attribute>
                                                <xsl:attribute name="id">BarterPaymentCC</xsl:attribute>
                                                <xsl:attribute name="value">1</xsl:attribute>
                                                <xsl:if test="(/DATA/PARAM/@barterpaymentcc = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentCC']"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">checkbox</xsl:attribute>
                                                <xsl:attribute name="name">BarterPaymentPP</xsl:attribute>
                                                <xsl:attribute name="id">BarterPaymentPP</xsl:attribute>
                                                <xsl:attribute name="value">1</xsl:attribute>
                                                <xsl:if test="(/DATA/PARAM/@barterpaymentpp = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentPP']"/>
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
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">checkbox</xsl:attribute>
                                                <xsl:attribute name="name">BarterPaymentBTC</xsl:attribute>
                                                <xsl:attribute name="id">BarterPaymentBTC</xsl:attribute>
                                                <xsl:attribute name="value">1</xsl:attribute>
                                                <xsl:if test="(/DATA/PARAM/@barterpaymentbtc = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentBTC']"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">checkbox</xsl:attribute>
                                                <xsl:attribute name="name">BarterPaymentNXC</xsl:attribute>
                                                <xsl:attribute name="id">BarterPaymentNXC</xsl:attribute>
                                                <xsl:attribute name="value">1</xsl:attribute>
                                                <xsl:if test="(/DATA/PARAM/@barterpaymentnxc = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentNXC']"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">checkbox</xsl:attribute>
                                                <xsl:attribute name="name">BarterPaymentETH</xsl:attribute>
                                                <xsl:attribute name="id">BarterPaymentETH</xsl:attribute>
                                                <xsl:attribute name="value">1</xsl:attribute>
                                                <xsl:if test="(/DATA/PARAM/@barterpaymenteth = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentETH']"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">checkbox</xsl:attribute>
                                                <xsl:attribute name="name">BarterPaymentETC</xsl:attribute>
                                                <xsl:attribute name="id">BarterPaymentETC</xsl:attribute>
                                                <xsl:attribute name="value">1</xsl:attribute>
                                                <xsl:if test="(/DATA/PARAM/@barterpaymentetc = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentETC']"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">checkbox</xsl:attribute>
                                                <xsl:attribute name="name">BarterPaymentLTC</xsl:attribute>
                                                <xsl:attribute name="id">BarterPaymentLTC</xsl:attribute>
                                                <xsl:attribute name="value">1</xsl:attribute>
                                                <xsl:if test="(/DATA/PARAM/@barterpaymentltc = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentLTC']"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">checkbox</xsl:attribute>
                                                <xsl:attribute name="name">BarterPaymentDASH</xsl:attribute>
                                                <xsl:attribute name="id">BarterPaymentDASH</xsl:attribute>
                                                <xsl:attribute name="value">1</xsl:attribute>
                                                <xsl:if test="(/DATA/PARAM/@barterpaymentdash = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentDASH']"/>
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
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">checkbox</xsl:attribute>
                                                <xsl:attribute name="name">BarterPaymentMonero</xsl:attribute>
                                                <xsl:attribute name="id">BarterPaymentMonero</xsl:attribute>
                                                <xsl:attribute name="value">1</xsl:attribute>
                                                <xsl:if test="(/DATA/PARAM/@barterpaymentmonero = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentMonero']"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">checkbox</xsl:attribute>
                                                <xsl:attribute name="name">BarterPaymentSteem</xsl:attribute>
                                                <xsl:attribute name="id">BarterPaymentSteem</xsl:attribute>
                                                <xsl:attribute name="value">1</xsl:attribute>
                                                <xsl:if test="(/DATA/PARAM/@barterpaymentsteem = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentSteem']"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">checkbox</xsl:attribute>
                                                <xsl:attribute name="name">BarterPaymentRipple</xsl:attribute>
                                                <xsl:attribute name="id">BarterPaymentRipple</xsl:attribute>
                                                <xsl:attribute name="value">1</xsl:attribute>
                                                <xsl:if test="(/DATA/PARAM/@barterpaymentripple = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentRipple']"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">checkbox</xsl:attribute>
                                                <xsl:attribute name="name">BarterPaymentDoge</xsl:attribute>
                                                <xsl:attribute name="id">BarterPaymentDoge</xsl:attribute>
                                                <xsl:attribute name="value">1</xsl:attribute>
                                                <xsl:if test="(/DATA/PARAM/@barterpaymentdoge = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentDoge']"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">checkbox</xsl:attribute>
                                                <xsl:attribute name="name">BarterPaymentGCR</xsl:attribute>
                                                <xsl:attribute name="id">BarterPaymentGCR</xsl:attribute>
                                                <xsl:attribute name="value">1</xsl:attribute>
                                                <xsl:if test="(/DATA/PARAM/@barterpaymentgcr = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentGCR']"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">checkbox</xsl:attribute>
                                                <xsl:attribute name="name">BarterPaymentOther</xsl:attribute>
                                                <xsl:attribute name="id">BarterPaymentOther</xsl:attribute>
                                                <xsl:attribute name="value">1</xsl:attribute>
                                                <xsl:if test="(/DATA/PARAM/@barterpaymentother = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentOther']"/>
                                                </xsl:element>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">1</xsl:attribute>
                                             <xsl:attribute name="height">12</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>

                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">450</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">top</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">450</xsl:attribute>
                                    <xsl:attribute name="style">margin-left:7px;</xsl:attribute>
                                    <xsl:attribute name="class">box-gray</xsl:attribute>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">100</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">350</xsl:attribute>
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
                                             <xsl:attribute name="width">450</xsl:attribute>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">checkbox</xsl:attribute>
                                             <xsl:attribute name="name">IsMap</xsl:attribute>
                                             <xsl:attribute name="id">IsMap</xsl:attribute>
                                             <xsl:attribute name="value">1</xsl:attribute>
                                             <xsl:if test="(/DATA/TXN/PTSBARTERAD/@ismap = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsMap']"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:if test="(/DATA/PARAM/@maperr != 0)">
                                                <xsl:element name="font">
                                                   <xsl:attribute name="color">red</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MapErr']"/>
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
                                             <xsl:attribute name="width">100</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MapStreet1']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">350</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">text</xsl:attribute>
                                             <xsl:attribute name="name">MapStreet1</xsl:attribute>
                                             <xsl:attribute name="id">MapStreet1</xsl:attribute>
                                             <xsl:attribute name="size">40</xsl:attribute>
                                             <xsl:attribute name="maxlength">60</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBARTERAD/@mapstreet1"/></xsl:attribute>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="i">
                                             <xsl:element name="font">
                                                <xsl:attribute name="size">2</xsl:attribute>
                                                <xsl:attribute name="color">blue</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Optional']"/>
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
                                             <xsl:attribute name="width">100</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MapStreet2']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">350</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">text</xsl:attribute>
                                             <xsl:attribute name="name">MapStreet2</xsl:attribute>
                                             <xsl:attribute name="id">MapStreet2</xsl:attribute>
                                             <xsl:attribute name="size">40</xsl:attribute>
                                             <xsl:attribute name="maxlength">60</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBARTERAD/@mapstreet2"/></xsl:attribute>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="i">
                                             <xsl:element name="font">
                                                <xsl:attribute name="size">2</xsl:attribute>
                                                <xsl:attribute name="color">blue</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Optional']"/>
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
                                             <xsl:attribute name="width">100</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MapCity']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">350</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">text</xsl:attribute>
                                             <xsl:attribute name="name">MapCity</xsl:attribute>
                                             <xsl:attribute name="id">MapCity</xsl:attribute>
                                             <xsl:attribute name="size">30</xsl:attribute>
                                             <xsl:attribute name="maxlength">30</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBARTERAD/@mapcity"/></xsl:attribute>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">text</xsl:attribute>
                                             <xsl:attribute name="name">MapZip</xsl:attribute>
                                             <xsl:attribute name="id">MapZip</xsl:attribute>
                                             <xsl:attribute name="size">10</xsl:attribute>
                                             <xsl:attribute name="maxlength">10</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBARTERAD/@mapzip"/></xsl:attribute>
                                             </xsl:element>
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
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">850</xsl:attribute>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Language']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="SELECT">
                                    <xsl:attribute name="name">Language</xsl:attribute>
                                    <xsl:attribute name="id">Language</xsl:attribute>
                                    <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/PTSBARTERAD/@language"/></xsl:variable>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">en</xsl:attribute>
                                       <xsl:if test="$tmp='en'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='English']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">af</xsl:attribute>
                                       <xsl:if test="$tmp='af'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Afrikaans']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">sq</xsl:attribute>
                                       <xsl:if test="$tmp='sq'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Albanian']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">ar</xsl:attribute>
                                       <xsl:if test="$tmp='ar'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Arabic']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">hy</xsl:attribute>
                                       <xsl:if test="$tmp='hy'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Armenian']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">eu</xsl:attribute>
                                       <xsl:if test="$tmp='eu'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Basque']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">be</xsl:attribute>
                                       <xsl:if test="$tmp='be'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Belarusian']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">bn</xsl:attribute>
                                       <xsl:if test="$tmp='bn'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Bengali']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">bs</xsl:attribute>
                                       <xsl:if test="$tmp='bs'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Bosnian']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">bg</xsl:attribute>
                                       <xsl:if test="$tmp='bg'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Bulgarian']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">ca</xsl:attribute>
                                       <xsl:if test="$tmp='ca'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Catalan']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">ce</xsl:attribute>
                                       <xsl:if test="$tmp='ce'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Chechen']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">zh</xsl:attribute>
                                       <xsl:if test="$tmp='zh'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Chinese']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">co</xsl:attribute>
                                       <xsl:if test="$tmp='co'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Croatian']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">cs</xsl:attribute>
                                       <xsl:if test="$tmp='cs'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Czech']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">da</xsl:attribute>
                                       <xsl:if test="$tmp='da'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Danish']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">nl</xsl:attribute>
                                       <xsl:if test="$tmp='nl'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Dutch']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">et</xsl:attribute>
                                       <xsl:if test="$tmp='et'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Estonia']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">fo</xsl:attribute>
                                       <xsl:if test="$tmp='fo'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Faroese']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">fil</xsl:attribute>
                                       <xsl:if test="$tmp='fil'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Filipino']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">fi</xsl:attribute>
                                       <xsl:if test="$tmp='fi'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Finnish']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">fr</xsl:attribute>
                                       <xsl:if test="$tmp='fr'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='French']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">de</xsl:attribute>
                                       <xsl:if test="$tmp='de'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='German']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">he</xsl:attribute>
                                       <xsl:if test="$tmp='he'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Hebrew']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">hi</xsl:attribute>
                                       <xsl:if test="$tmp='hi'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Hindi']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">hu</xsl:attribute>
                                       <xsl:if test="$tmp='hu'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Hungarian']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">ga</xsl:attribute>
                                       <xsl:if test="$tmp='ga'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Irish']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">is</xsl:attribute>
                                       <xsl:if test="$tmp='is'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Icelandic']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">it</xsl:attribute>
                                       <xsl:if test="$tmp='it'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Italian']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">ja</xsl:attribute>
                                       <xsl:if test="$tmp='ja'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Japanese']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">ko</xsl:attribute>
                                       <xsl:if test="$tmp='ko'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Korean']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">mt</xsl:attribute>
                                       <xsl:if test="$tmp='mt'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Maltese']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">mn</xsl:attribute>
                                       <xsl:if test="$tmp='mn'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Mongolian']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">no</xsl:attribute>
                                       <xsl:if test="$tmp='no'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Norwegian']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">pt</xsl:attribute>
                                       <xsl:if test="$tmp='pt'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Portuguese']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">ru</xsl:attribute>
                                       <xsl:if test="$tmp='ru'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Russian']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">sr</xsl:attribute>
                                       <xsl:if test="$tmp='sr'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Serbian']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">es</xsl:attribute>
                                       <xsl:if test="$tmp='es'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Spanish']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">sv</xsl:attribute>
                                       <xsl:if test="$tmp='sv'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Swedish']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">th</xsl:attribute>
                                       <xsl:if test="$tmp='th'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Thai']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">tr</xsl:attribute>
                                       <xsl:if test="$tmp='tr'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Turkish']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">vi</xsl:attribute>
                                       <xsl:if test="$tmp='vi'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Vietnamese']"/>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">850</xsl:attribute>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="font">
                                    <xsl:attribute name="size">3</xsl:attribute>
                                    <xsl:element name="INPUT">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:attribute name="name">IsMore</xsl:attribute>
                                    <xsl:attribute name="id">IsMore</xsl:attribute>
                                    <xsl:attribute name="value">1</xsl:attribute>
                                    <xsl:if test="(/DATA/TXN/PTSBARTERAD/@ismore = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsMore']"/>
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
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">850</xsl:attribute>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="font">
                                    <xsl:attribute name="size">3</xsl:attribute>
                                    <xsl:element name="INPUT">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:attribute name="name">IsContact</xsl:attribute>
                                    <xsl:attribute name="id">IsContact</xsl:attribute>
                                    <xsl:attribute name="value">1</xsl:attribute>
                                    <xsl:if test="(/DATA/TXN/PTSBARTERAD/@iscontact = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsContact']"/>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">24</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:if test="(/DATA/PARAM/@barteradid = 0)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">1</xsl:attribute>
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">850</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="INPUT">
                                       <xsl:attribute name="type">button</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Add']"/>
                                       </xsl:attribute>
                                       <xsl:attribute name="onclick">doSubmit(6,"")</xsl:attribute>
                                    </xsl:element>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:element name="INPUT">
                                       <xsl:attribute name="type">button</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Cancel']"/>
                                       </xsl:attribute>
                                       <xsl:attribute name="onclick">doSubmit(3,"")</xsl:attribute>
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

                           <xsl:if test="(/DATA/PARAM/@barteradid != 0)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">1</xsl:attribute>
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">850</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="INPUT">
                                       <xsl:attribute name="type">button</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Update']"/>
                                       </xsl:attribute>
                                       <xsl:attribute name="onclick">doSubmit(5,"")</xsl:attribute>
                                    </xsl:element>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:if test="(/DATA/TXN/PTSBARTERAD/@status = 1)">
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">button</xsl:attribute>
                                             <xsl:attribute name="value">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Publish']"/>
                                             </xsl:attribute>
                                             <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[UpdateStatus(2)]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    </xsl:if>
                                    <xsl:if test="(/DATA/TXN/PTSBARTERAD/@status = 2)">
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">button</xsl:attribute>
                                             <xsl:attribute name="value">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SoldStatus']"/>
                                             </xsl:attribute>
                                             <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[UpdateStatus(3)]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    </xsl:if>
                                    <xsl:if test="(/DATA/TXN/PTSBARTERAD/@status = 2)">
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">button</xsl:attribute>
                                             <xsl:attribute name="value">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='InactivateStatus']"/>
                                             </xsl:attribute>
                                             <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[UpdateStatus(4)]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    </xsl:if>
                                    <xsl:if test="(/DATA/TXN/PTSBARTERAD/@status = 2)">
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">button</xsl:attribute>
                                             <xsl:attribute name="value">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CancelStatus']"/>
                                             </xsl:attribute>
                                             <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[UpdateStatus(5)]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    </xsl:if>
                                    <xsl:if test="(/DATA/TXN/PTSBARTERAD/@status &gt; 2)">
                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">button</xsl:attribute>
                                             <xsl:attribute name="value">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Activate']"/>
                                             </xsl:attribute>
                                             <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[UpdateStatus(2)]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    </xsl:if>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:element name="INPUT">
                                       <xsl:attribute name="type">button</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Return']"/>
                                       </xsl:attribute>
                                       <xsl:attribute name="onclick">doSubmit(3,"")</xsl:attribute>
                                    </xsl:element>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:element name="INPUT">
                                       <xsl:attribute name="type">button</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Delete']"/>
                                       </xsl:attribute>
                                       <xsl:attribute name="onclick">doSubmit(4,'<xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ConfirmDelete']"/>')</xsl:attribute>
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

                        </xsl:if>
                     </xsl:element>

                  </xsl:element>
                  <!--END CONTENT COLUMN-->

               </xsl:element>

            </xsl:element>
            <!--END FORM-->

         </xsl:element>
         <!--END PAGE-->

      </xsl:element>
      </xsl:element>
      <!--END BODY-->

      </xsl:element>

   </xsl:template>
</xsl:stylesheet>