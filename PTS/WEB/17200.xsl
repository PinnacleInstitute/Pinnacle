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
         <xsl:with-param name="pagename" select="'Nexxus Barter'"/>
         <xsl:with-param name="includecalendar" select="true()"/>
         <xsl:with-param name="htmleditor"></xsl:with-param>
      </xsl:call-template>

      <xsl:element name="link">
         <xsl:attribute name="rel">stylesheet</xsl:attribute>
         <xsl:attribute name="type">text/css</xsl:attribute>
         <xsl:attribute name="href">include/Barter.css</xsl:attribute>
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
               LoadPage();
            ]]></xsl:text>;doErrorMsg('<xsl:value-of select="concat($errmsg, $errmsgfld)"/>')</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[
               LoadPage();
            ]]></xsl:text>;doErrorMsg('<xsl:value-of select="/DATA/ERROR"/>')</xsl:attribute>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
               <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[
               LoadPage();
            ]]></xsl:text></xsl:attribute>
            </xsl:otherwise>
         </xsl:choose>

         <!--BEGIN PAGE-->
      <xsl:element name="DIV">
         <xsl:attribute name="id">wrapper1200</xsl:attribute>
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
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function SelectBarterArea(){ 
          var pid = document.getElementById('AreaParentID').value;
          var url = "17010.asp?barterareaid=" + pid
          var win = window.open(url,"BarterArea","top=200,left=200,height=400,width=425,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no,scrollbars=1")
               win.focus();
         }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function SelectCategory(){ 
          var pid = document.getElementById('MainCategoryID').value;
          var url = "17112.asp?bartercategoryid=" + pid
          var win = window.open(url,"BarterCategory","top=200,left=200,height=500,width=325,resizable=yes,status=no,toolbar=no,menubar=no,location=no,titlebar=no,scrollbars=1")
               win.focus();
         }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ViewAds(){ 
          var cid = document.getElementById('ConsumerID').value;
          var url = "17201.asp?consumerid=" + cid
          var win = window.open(url,'MyAds')
          win.focus();
         }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function Suggestion(){ 
          var cid = document.getElementById('ConsumerID').value;
          var url = "9505.asp?companyid=21&category=144&t=151&i=" + cid + "&returnurl=9506.asp?contentpage=3%26popup=1%26companyid=21%26t=151%26i=" + cid
          var win = window.open(url,'Suggestion')
          win.focus();
         }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function UpdateLocation(id){ 
          document.getElementById('BarterAreaID').value = id;
          doSubmit(4,'');
         }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function UpdateCategory(id){ 
          document.getElementById('BarterCategoryID').value = id;
          doSubmit(4,'');
         }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function LoadPage(){ 
          var id = document.getElementById('BarterAreaID').value;
          if(id==0) {SelectBarterArea()}
          SetFilterOptions();
         }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function SetFilterOptions(){ 
          var str = document.getElementById('FilterOptions').value;
          if( str.includes("C") ) { SetFilter('Condition',1) } else  { SetFilter('Condition',0) }
          if( str.includes("P") ) { SetFilter('Payment',1) } else  { SetFilter('Payment',0) }
         }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function SetFilter(typ,opt){ 
          var obj = document.getElementById(typ+'Row');
          if (obj != undefined) {
            if(opt==0) {
              document.getElementById(typ+'Row').style.display = 'none';
              document.getElementById(typ+'Open').style.display = '';
              document.getElementById(typ+'Close').style.display = 'none';
            }
            else {
              document.getElementById(typ+'Row').style.display = '';
              document.getElementById(typ+'Open').style.display = 'none';
              document.getElementById(typ+'Close').style.display = '';
            }
          }
          str = '';
          var c_obj = document.getElementById('ConditionRow');
          if (c_obj != undefined) {
            if( c_obj.style.display == '' ) { str = str + 'C'; }
          }
          var p_obj = document.getElementById('PaymentRow');
          if (p_obj != undefined) {
            if( p_obj.style.display == '' ) { str = str + 'P'; }
          }
          document.getElementById('FilterOptions').value = str;
         }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ViewHelp(){ 
          var url = "pagex.asp?page=SearchHelp";
          var win = window.open(url,"SearchHelp");
          win.focus();
         }]]></xsl:text>
               </xsl:element>

               <xsl:element name="TR">

                  <xsl:element name="TD">
                     <xsl:attribute name="width">10</xsl:attribute>
                  </xsl:element>

                  <xsl:element name="TD">
                     <xsl:attribute name="valign">top</xsl:attribute>
                     <xsl:attribute name="width">1200</xsl:attribute>

                     <xsl:element name="TABLE">
                        <xsl:attribute name="border">0</xsl:attribute>
                        <xsl:attribute name="cellpadding">0</xsl:attribute>
                        <xsl:attribute name="cellspacing">0</xsl:attribute>
                        <xsl:attribute name="width">1200</xsl:attribute>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">1200</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">ConsumerID</xsl:attribute>
                              <xsl:attribute name="id">ConsumerID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@consumerid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">BarterAreaID</xsl:attribute>
                              <xsl:attribute name="id">BarterAreaID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@barterareaid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">MainCategoryID</xsl:attribute>
                              <xsl:attribute name="id">MainCategoryID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@maincategoryid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">BarterCategoryID</xsl:attribute>
                              <xsl:attribute name="id">BarterCategoryID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@bartercategoryid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">AreaParentID</xsl:attribute>
                              <xsl:attribute name="id">AreaParentID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@areaparentid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Title</xsl:attribute>
                              <xsl:attribute name="id">Title</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@title"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">ReferredBy</xsl:attribute>
                              <xsl:attribute name="id">ReferredBy</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@referredby"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">MainCategory</xsl:attribute>
                              <xsl:attribute name="id">MainCategory</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@maincategory"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">SubCategory</xsl:attribute>
                              <xsl:attribute name="id">SubCategory</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@subcategory"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">SubAreas</xsl:attribute>
                              <xsl:attribute name="id">SubAreas</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@subareas"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">BarterAreas</xsl:attribute>
                              <xsl:attribute name="id">BarterAreas</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@barterareas"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">FilterOptions</xsl:attribute>
                              <xsl:attribute name="id">FilterOptions</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@filteroptions"/></xsl:attribute>
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

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">1200</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">1200</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">900</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">PageHeadingLite</xsl:attribute>
                                             <xsl:attribute name="style">background-color:#ffffff</xsl:attribute>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="src">Images/Company/<xsl:value-of select="/DATA/PARAM/@companyid"/>/NexxusBarterMobile.png</xsl:attribute>
                                                <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                             </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">900</xsl:attribute>
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">PageHeadingLite</xsl:attribute>
                                             <xsl:attribute name="style">background-color:#ffffff</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@referredby != '')">
                                             <xsl:element name="SPAN">
                                                <xsl:attribute name="style">font-size:12pt; color:#c2c2c2;</xsl:attribute>
<xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ReferredBy']"/>
<xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
   <xsl:value-of select="/DATA/PARAM/@referredby" disable-output-escaping="yes"/>
<xsl:element name="BR"/>
                                             </xsl:element>
                                          </xsl:if>
                                             <xsl:value-of select="/DATA/PARAM/@title" disable-output-escaping="yes"/>
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

                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">1200</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">1200</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">900</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:attribute name="height">36</xsl:attribute>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">900</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">PageHeadingLite</xsl:attribute>
                                          <xsl:if test="(/DATA/PARAM/@maincategory = '')">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AllCategories']"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@maincategory != '')">
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">#_</xsl:attribute>
                                                   <xsl:attribute name="onclick">UpdateCategory(0)</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AllCategories']"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                </xsl:element>
                                                /
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:if test="(/DATA/PARAM/@subcategory = '')">
                                                   <xsl:value-of select="/DATA/PARAM/@maincategory" disable-output-escaping="yes"/>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/PARAM/@subcategory != '')">
                                                   <xsl:element name="A">
                                                      <xsl:attribute name="href">#_</xsl:attribute>
                                                      <xsl:attribute name="onclick">UpdateCategory(<xsl:value-of select="/DATA/PARAM/@maincategoryid"/>)</xsl:attribute>
                                                   <xsl:value-of select="/DATA/PARAM/@maincategory" disable-output-escaping="yes"/>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   </xsl:element>
                                                   /
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/PARAM/@subcategory" disable-output-escaping="yes"/>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             </xsl:if>
                                          </xsl:if>
                                             <xsl:element name="A">
                                                <xsl:attribute name="href">#_</xsl:attribute>
                                                <xsl:attribute name="onclick">SelectCategory()</xsl:attribute>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/lookup24.png</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LookupCategory']"/></xsl:attribute>
                                                   <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LookupCategory']"/></xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">PageHeadingLite</xsl:attribute>
                                             <xsl:element name="A">
                                                <xsl:attribute name="href">#_</xsl:attribute>
                                                <xsl:attribute name="onclick">ViewAds()</xsl:attribute>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/myads24.png</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewMyAds']"/></xsl:attribute>
                                                   <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewMyAds']"/></xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:element name="A">
                                                <xsl:attribute name="href">#_</xsl:attribute>
                                                <xsl:attribute name="onclick">ViewAds()</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MyAds']"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="A">
                                                <xsl:attribute name="href">#_</xsl:attribute>
                                                <xsl:attribute name="onclick">Suggestion()</xsl:attribute>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/BarterSuggestion.png</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewMyAds']"/></xsl:attribute>
                                                   <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ViewMyAds']"/></xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:element name="A">
                                                <xsl:attribute name="href">#_</xsl:attribute>
                                                <xsl:attribute name="onclick">Suggestion()</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Suggestion']"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
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

                        <xsl:element name="TR">
                           <xsl:attribute name="height">10</xsl:attribute>
                        </xsl:element>

                        <xsl:if test="(/DATA/PARAM/@barterareaid != 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">1200</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">top</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">1200</xsl:attribute>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">200</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">800</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">200</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">190</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:element name="TABLE">
                                                <xsl:attribute name="border">0</xsl:attribute>
                                                <xsl:attribute name="cellpadding">0</xsl:attribute>
                                                <xsl:attribute name="cellspacing">0</xsl:attribute>
                                                <xsl:attribute name="width">190</xsl:attribute>
                                                <xsl:attribute name="style">background-color: #fcfde5; margin-right:10px</xsl:attribute>
                                                <xsl:attribute name="class">box-gray</xsl:attribute>

                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">190</xsl:attribute>
                                                         <xsl:attribute name="align">left</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:if test="(/DATA/PARAM/@subareas != 0)">
                                                      <xsl:element name="TR">
                                                         <xsl:element name="TD">
                                                            <xsl:attribute name="colspan">1</xsl:attribute>
                                                            <xsl:attribute name="height">12</xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                      <xsl:element name="TR">
                                                         <xsl:element name="TD">
                                                            <xsl:attribute name="width">190</xsl:attribute>
                                                            <xsl:attribute name="align">center</xsl:attribute>
                                                            <xsl:attribute name="valign">top</xsl:attribute>
                                                            <xsl:element name="SELECT">
                                                               <xsl:attribute name="name">BarterSubAreaID</xsl:attribute>
                                                               <xsl:attribute name="id">BarterSubAreaID</xsl:attribute>
                                                               <xsl:variable name="tmp"><xsl:value-of select="/DATA/PARAM/@bartersubareaid"/></xsl:variable>
                                                               <xsl:for-each select="/DATA/TXN/PTSBARTERAREAS/ENUM">
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
                                                         <xsl:attribute name="colspan">1</xsl:attribute>
                                                         <xsl:attribute name="height">12</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">190</xsl:attribute>
                                                         <xsl:attribute name="align">center</xsl:attribute>
                                                         <xsl:attribute name="valign">top</xsl:attribute>
                                                         <xsl:element name="INPUT">
                                                         <xsl:attribute name="type">checkbox</xsl:attribute>
                                                         <xsl:attribute name="name">SearchAll</xsl:attribute>
                                                         <xsl:attribute name="id">SearchAll</xsl:attribute>
                                                         <xsl:attribute name="value">1</xsl:attribute>
                                                         <xsl:if test="(/DATA/PARAM/@searchall = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SearchAll']"/>
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
                                                         <xsl:attribute name="width">190</xsl:attribute>
                                                         <xsl:attribute name="align">center</xsl:attribute>
                                                         <xsl:attribute name="valign">top</xsl:attribute>
                                                         <xsl:element name="INPUT">
                                                         <xsl:attribute name="type">checkbox</xsl:attribute>
                                                         <xsl:attribute name="name">IsImages</xsl:attribute>
                                                         <xsl:attribute name="id">IsImages</xsl:attribute>
                                                         <xsl:attribute name="value">1</xsl:attribute>
                                                         <xsl:if test="(/DATA/PARAM/@isimages = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsImage']"/>
                                                         </xsl:element>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="colspan">1</xsl:attribute>
                                                         <xsl:attribute name="height">12</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>

                                                   <xsl:if test="(/DATA/PARAM/@noprice = 0)">
                                                      <xsl:element name="TR">
                                                         <xsl:element name="TD">
                                                            <xsl:attribute name="width">190</xsl:attribute>
                                                            <xsl:attribute name="align">center</xsl:attribute>
                                                            <xsl:attribute name="valign">center</xsl:attribute>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MinPrice']"/>
                                                            <xsl:text>:</xsl:text>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                            <xsl:element name="INPUT">
                                                            <xsl:attribute name="type">text</xsl:attribute>
                                                            <xsl:attribute name="name">MinPrice</xsl:attribute>
                                                            <xsl:attribute name="id">MinPrice</xsl:attribute>
                                                            <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@minprice"/></xsl:attribute>
                                                            <xsl:attribute name="size">5</xsl:attribute>
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
                                                            <xsl:attribute name="width">190</xsl:attribute>
                                                            <xsl:attribute name="align">center</xsl:attribute>
                                                            <xsl:attribute name="valign">center</xsl:attribute>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MaxPrice']"/>
                                                            <xsl:text>:</xsl:text>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                            <xsl:element name="INPUT">
                                                            <xsl:attribute name="type">text</xsl:attribute>
                                                            <xsl:attribute name="name">MaxPrice</xsl:attribute>
                                                            <xsl:attribute name="id">MaxPrice</xsl:attribute>
                                                            <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@maxprice"/></xsl:attribute>
                                                            <xsl:attribute name="size">5</xsl:attribute>
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
                                                   <xsl:if test="(/DATA/PARAM/@nocondition = 0)">
                                                      <xsl:element name="TR">
                                                         <xsl:element name="TD">
                                                            <xsl:attribute name="colspan">1</xsl:attribute>
                                                            <xsl:attribute name="height">6</xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                      <xsl:element name="TR">
                                                         <xsl:element name="TD">
                                                            <xsl:attribute name="width">190</xsl:attribute>
                                                            <xsl:attribute name="align">center</xsl:attribute>
                                                            <xsl:attribute name="valign">center</xsl:attribute>
                                                            <xsl:element name="font">
                                                               <xsl:attribute name="size">3</xsl:attribute>
                                                               <xsl:element name="A">
                                                                  <xsl:attribute name="href">#_</xsl:attribute>
                                                                  <xsl:attribute name="onclick">SetFilter('Condition',0)</xsl:attribute>
                                                                  <xsl:element name="IMG">
                                                                     <xsl:attribute name="src">Images/arrow-button-up.gif</xsl:attribute>
                                                                     <xsl:attribute name="id">ConditionClose</xsl:attribute>
                                                                     <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                     <xsl:attribute name="border">0</xsl:attribute>
                                                                  </xsl:element>
                                                               </xsl:element>
                                                               <xsl:element name="A">
                                                                  <xsl:attribute name="href">#_</xsl:attribute>
                                                                  <xsl:attribute name="onclick">SetFilter('Condition',1)</xsl:attribute>
                                                                  <xsl:element name="IMG">
                                                                     <xsl:attribute name="src">Images/arrow-button-down.gif</xsl:attribute>
                                                                     <xsl:attribute name="id">ConditionOpen</xsl:attribute>
                                                                     <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                     <xsl:attribute name="border">0</xsl:attribute>
                                                                  </xsl:element>
                                                               </xsl:element>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Condition']"/>
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
                                                         <xsl:attribute name="id">ConditionRow</xsl:attribute>
                                                         <xsl:element name="TD">
                                                            <xsl:attribute name="width">190</xsl:attribute>
                                                            <xsl:attribute name="align">left</xsl:attribute>
                                                            <xsl:attribute name="valign">center</xsl:attribute>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                               <xsl:element name="INPUT">
                                                               <xsl:attribute name="type">checkbox</xsl:attribute>
                                                               <xsl:attribute name="name">Condition0</xsl:attribute>
                                                               <xsl:attribute name="id">Condition0</xsl:attribute>
                                                               <xsl:attribute name="value">1</xsl:attribute>
                                                               <xsl:if test="(/DATA/PARAM/@condition0 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Any']"/>
                                                               </xsl:element>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                               <xsl:element name="INPUT">
                                                               <xsl:attribute name="type">checkbox</xsl:attribute>
                                                               <xsl:attribute name="name">Condition1</xsl:attribute>
                                                               <xsl:attribute name="id">Condition1</xsl:attribute>
                                                               <xsl:attribute name="value">1</xsl:attribute>
                                                               <xsl:if test="(/DATA/PARAM/@condition1 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='New']"/>
                                                               </xsl:element>
                                                               <xsl:element name="BR"/>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                               <xsl:element name="INPUT">
                                                               <xsl:attribute name="type">checkbox</xsl:attribute>
                                                               <xsl:attribute name="name">Condition2</xsl:attribute>
                                                               <xsl:attribute name="id">Condition2</xsl:attribute>
                                                               <xsl:attribute name="value">1</xsl:attribute>
                                                               <xsl:if test="(/DATA/PARAM/@condition2 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LikeNew']"/>
                                                               </xsl:element>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                               <xsl:element name="INPUT">
                                                               <xsl:attribute name="type">checkbox</xsl:attribute>
                                                               <xsl:attribute name="name">Condition3</xsl:attribute>
                                                               <xsl:attribute name="id">Condition3</xsl:attribute>
                                                               <xsl:attribute name="value">1</xsl:attribute>
                                                               <xsl:if test="(/DATA/PARAM/@condition3 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Exellent']"/>
                                                               </xsl:element>
                                                               <xsl:element name="BR"/>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                               <xsl:element name="INPUT">
                                                               <xsl:attribute name="type">checkbox</xsl:attribute>
                                                               <xsl:attribute name="name">Condition4</xsl:attribute>
                                                               <xsl:attribute name="id">Condition4</xsl:attribute>
                                                               <xsl:attribute name="value">1</xsl:attribute>
                                                               <xsl:if test="(/DATA/PARAM/@condition4 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Good']"/>
                                                               </xsl:element>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                               <xsl:element name="INPUT">
                                                               <xsl:attribute name="type">checkbox</xsl:attribute>
                                                               <xsl:attribute name="name">Condition5</xsl:attribute>
                                                               <xsl:attribute name="id">Condition5</xsl:attribute>
                                                               <xsl:attribute name="value">1</xsl:attribute>
                                                               <xsl:if test="(/DATA/PARAM/@condition5 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Fair']"/>
                                                               </xsl:element>
                                                               <xsl:element name="BR"/>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                               <xsl:element name="INPUT">
                                                               <xsl:attribute name="type">checkbox</xsl:attribute>
                                                               <xsl:attribute name="name">Condition6</xsl:attribute>
                                                               <xsl:attribute name="id">Condition6</xsl:attribute>
                                                               <xsl:attribute name="value">1</xsl:attribute>
                                                               <xsl:if test="(/DATA/PARAM/@condition6 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Poor']"/>
                                                               </xsl:element>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                               <xsl:element name="INPUT">
                                                               <xsl:attribute name="type">checkbox</xsl:attribute>
                                                               <xsl:attribute name="name">Condition7</xsl:attribute>
                                                               <xsl:attribute name="id">Condition7</xsl:attribute>
                                                               <xsl:attribute name="value">1</xsl:attribute>
                                                               <xsl:if test="(/DATA/PARAM/@condition7 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Salvage']"/>
                                                               </xsl:element>
                                                               <xsl:element name="BR"/><xsl:element name="BR"/>
                                                         </xsl:element>
                                                      </xsl:element>

                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/PARAM/@noprice = 0)">
                                                      <xsl:element name="TR">
                                                         <xsl:element name="TD">
                                                            <xsl:attribute name="colspan">1</xsl:attribute>
                                                            <xsl:attribute name="height">6</xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                      <xsl:element name="TR">
                                                         <xsl:element name="TD">
                                                            <xsl:attribute name="width">190</xsl:attribute>
                                                            <xsl:attribute name="align">center</xsl:attribute>
                                                            <xsl:attribute name="valign">center</xsl:attribute>
                                                            <xsl:element name="font">
                                                               <xsl:attribute name="size">3</xsl:attribute>
                                                               <xsl:element name="A">
                                                                  <xsl:attribute name="href">#_</xsl:attribute>
                                                                  <xsl:attribute name="onclick">SetFilter('Payment',0)</xsl:attribute>
                                                                  <xsl:element name="IMG">
                                                                     <xsl:attribute name="src">Images/arrow-button-up.gif</xsl:attribute>
                                                                     <xsl:attribute name="id">PaymentClose</xsl:attribute>
                                                                     <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                     <xsl:attribute name="border">0</xsl:attribute>
                                                                     <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LookupArea']"/></xsl:attribute>
                                                                     <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LookupArea']"/></xsl:attribute>
                                                                  </xsl:element>
                                                               </xsl:element>
                                                               <xsl:element name="A">
                                                                  <xsl:attribute name="href">#_</xsl:attribute>
                                                                  <xsl:attribute name="onclick">SetFilter('Payment',1)</xsl:attribute>
                                                                  <xsl:element name="IMG">
                                                                     <xsl:attribute name="src">Images/arrow-button-down.gif</xsl:attribute>
                                                                     <xsl:attribute name="id">PaymentOpen</xsl:attribute>
                                                                     <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                     <xsl:attribute name="border">0</xsl:attribute>
                                                                  </xsl:element>
                                                               </xsl:element>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Payments']"/>
                                                            </xsl:element>
                                                         </xsl:element>
                                                      </xsl:element>

                                                      <xsl:element name="TR">
                                                         <xsl:attribute name="id">PaymentRow</xsl:attribute>
                                                         <xsl:element name="TD">
                                                            <xsl:attribute name="width">190</xsl:attribute>
                                                            <xsl:attribute name="align">left</xsl:attribute>
                                                            <xsl:attribute name="valign">center</xsl:attribute>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                               <xsl:element name="INPUT">
                                                               <xsl:attribute name="type">checkbox</xsl:attribute>
                                                               <xsl:attribute name="name">Payment0</xsl:attribute>
                                                               <xsl:attribute name="id">Payment0</xsl:attribute>
                                                               <xsl:attribute name="value">1</xsl:attribute>
                                                               <xsl:if test="(/DATA/PARAM/@payment0 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Any']"/>
                                                               </xsl:element>
                                                               <xsl:element name="BR"/>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                               <xsl:element name="INPUT">
                                                               <xsl:attribute name="type">checkbox</xsl:attribute>
                                                               <xsl:attribute name="name">Payment1</xsl:attribute>
                                                               <xsl:attribute name="id">Payment1</xsl:attribute>
                                                               <xsl:attribute name="value">1</xsl:attribute>
                                                               <xsl:if test="(/DATA/PARAM/@payment1 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentPoints']"/>
                                                               </xsl:element>
                                                               <xsl:element name="BR"/>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                               <xsl:element name="INPUT">
                                                               <xsl:attribute name="type">checkbox</xsl:attribute>
                                                               <xsl:attribute name="name">Payment2</xsl:attribute>
                                                               <xsl:attribute name="id">Payment2</xsl:attribute>
                                                               <xsl:attribute name="value">1</xsl:attribute>
                                                               <xsl:if test="(/DATA/PARAM/@payment2 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentCash']"/>
                                                               </xsl:element>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                               <xsl:element name="INPUT">
                                                               <xsl:attribute name="type">checkbox</xsl:attribute>
                                                               <xsl:attribute name="name">Payment3</xsl:attribute>
                                                               <xsl:attribute name="id">Payment3</xsl:attribute>
                                                               <xsl:attribute name="value">1</xsl:attribute>
                                                               <xsl:if test="(/DATA/PARAM/@payment3 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentCC']"/>
                                                               </xsl:element>
                                                               <xsl:element name="BR"/>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                               <xsl:element name="INPUT">
                                                               <xsl:attribute name="type">checkbox</xsl:attribute>
                                                               <xsl:attribute name="name">Payment4</xsl:attribute>
                                                               <xsl:attribute name="id">Payment4</xsl:attribute>
                                                               <xsl:attribute name="value">1</xsl:attribute>
                                                               <xsl:if test="(/DATA/PARAM/@payment4 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentPP']"/>
                                                               </xsl:element>
                                                               <xsl:element name="BR"/>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                               <xsl:element name="INPUT">
                                                               <xsl:attribute name="type">checkbox</xsl:attribute>
                                                               <xsl:attribute name="name">Payment5</xsl:attribute>
                                                               <xsl:attribute name="id">Payment5</xsl:attribute>
                                                               <xsl:attribute name="value">1</xsl:attribute>
                                                               <xsl:if test="(/DATA/PARAM/@payment5 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentBTC']"/>
                                                               </xsl:element>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                               <xsl:element name="INPUT">
                                                               <xsl:attribute name="type">checkbox</xsl:attribute>
                                                               <xsl:attribute name="name">Payment6</xsl:attribute>
                                                               <xsl:attribute name="id">Payment6</xsl:attribute>
                                                               <xsl:attribute name="value">1</xsl:attribute>
                                                               <xsl:if test="(/DATA/PARAM/@payment6 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentNXC']"/>
                                                               </xsl:element>
                                                               <xsl:element name="BR"/>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                               <xsl:element name="INPUT">
                                                               <xsl:attribute name="type">checkbox</xsl:attribute>
                                                               <xsl:attribute name="name">Payment7</xsl:attribute>
                                                               <xsl:attribute name="id">Payment7</xsl:attribute>
                                                               <xsl:attribute name="value">1</xsl:attribute>
                                                               <xsl:if test="(/DATA/PARAM/@payment7 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentETH']"/>
                                                               </xsl:element>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                               <xsl:element name="INPUT">
                                                               <xsl:attribute name="type">checkbox</xsl:attribute>
                                                               <xsl:attribute name="name">Payment8</xsl:attribute>
                                                               <xsl:attribute name="id">Payment8</xsl:attribute>
                                                               <xsl:attribute name="value">1</xsl:attribute>
                                                               <xsl:if test="(/DATA/PARAM/@payment8 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentETC']"/>
                                                               </xsl:element>
                                                               <xsl:element name="BR"/>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                               <xsl:element name="INPUT">
                                                               <xsl:attribute name="type">checkbox</xsl:attribute>
                                                               <xsl:attribute name="name">Payment9</xsl:attribute>
                                                               <xsl:attribute name="id">Payment9</xsl:attribute>
                                                               <xsl:attribute name="value">1</xsl:attribute>
                                                               <xsl:if test="(/DATA/PARAM/@payment9 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentLTC']"/>
                                                               </xsl:element>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                               <xsl:element name="INPUT">
                                                               <xsl:attribute name="type">checkbox</xsl:attribute>
                                                               <xsl:attribute name="name">Payment10</xsl:attribute>
                                                               <xsl:attribute name="id">Payment10</xsl:attribute>
                                                               <xsl:attribute name="value">1</xsl:attribute>
                                                               <xsl:if test="(/DATA/PARAM/@payment10 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentDASH']"/>
                                                               </xsl:element>
                                                               <xsl:element name="BR"/>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                               <xsl:element name="INPUT">
                                                               <xsl:attribute name="type">checkbox</xsl:attribute>
                                                               <xsl:attribute name="name">Payment11</xsl:attribute>
                                                               <xsl:attribute name="id">Payment11</xsl:attribute>
                                                               <xsl:attribute name="value">1</xsl:attribute>
                                                               <xsl:if test="(/DATA/PARAM/@payment11 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentMonero']"/>
                                                               </xsl:element>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                               <xsl:element name="INPUT">
                                                               <xsl:attribute name="type">checkbox</xsl:attribute>
                                                               <xsl:attribute name="name">Payment12</xsl:attribute>
                                                               <xsl:attribute name="id">Payment12</xsl:attribute>
                                                               <xsl:attribute name="value">1</xsl:attribute>
                                                               <xsl:if test="(/DATA/PARAM/@payment12 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentSteem']"/>
                                                               </xsl:element>
                                                               <xsl:element name="BR"/>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                               <xsl:element name="INPUT">
                                                               <xsl:attribute name="type">checkbox</xsl:attribute>
                                                               <xsl:attribute name="name">Payment13</xsl:attribute>
                                                               <xsl:attribute name="id">Payment13</xsl:attribute>
                                                               <xsl:attribute name="value">1</xsl:attribute>
                                                               <xsl:if test="(/DATA/PARAM/@payment13 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentRipple']"/>
                                                               </xsl:element>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                               <xsl:element name="INPUT">
                                                               <xsl:attribute name="type">checkbox</xsl:attribute>
                                                               <xsl:attribute name="name">Payment14</xsl:attribute>
                                                               <xsl:attribute name="id">Payment14</xsl:attribute>
                                                               <xsl:attribute name="value">1</xsl:attribute>
                                                               <xsl:if test="(/DATA/PARAM/@payment14 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentDoge']"/>
                                                               </xsl:element>
                                                               <xsl:element name="BR"/>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                               <xsl:element name="INPUT">
                                                               <xsl:attribute name="type">checkbox</xsl:attribute>
                                                               <xsl:attribute name="name">Payment15</xsl:attribute>
                                                               <xsl:attribute name="id">Payment15</xsl:attribute>
                                                               <xsl:attribute name="value">1</xsl:attribute>
                                                               <xsl:if test="(/DATA/PARAM/@payment15 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentGCR']"/>
                                                               </xsl:element>
                                                               <xsl:element name="BR"/>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                               <xsl:element name="INPUT">
                                                               <xsl:attribute name="type">checkbox</xsl:attribute>
                                                               <xsl:attribute name="name">Payment16</xsl:attribute>
                                                               <xsl:attribute name="id">Payment16</xsl:attribute>
                                                               <xsl:attribute name="value">1</xsl:attribute>
                                                               <xsl:if test="(/DATA/PARAM/@payment16 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentOther']"/>
                                                               </xsl:element>
                                                               <xsl:element name="BR"/><xsl:element name="BR"/>
                                                         </xsl:element>
                                                      </xsl:element>

                                                   </xsl:if>
                                                   <xsl:element name="TR">
                                                      <xsl:attribute name="height">50</xsl:attribute>
                                                   </xsl:element>

                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">800</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:element name="TABLE">
                                                <xsl:attribute name="border">0</xsl:attribute>
                                                <xsl:attribute name="cellpadding">0</xsl:attribute>
                                                <xsl:attribute name="cellspacing">0</xsl:attribute>
                                                <xsl:attribute name="width">800</xsl:attribute>

                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">800</xsl:attribute>
                                                         <xsl:attribute name="align">left</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">800</xsl:attribute>
                                                         <xsl:attribute name="align">center</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:element name="INPUT">
                                                         <xsl:attribute name="type">text</xsl:attribute>
                                                         <xsl:attribute name="name">SearchText</xsl:attribute>
                                                         <xsl:attribute name="id">SearchText</xsl:attribute>
                                                         <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@searchtext"/></xsl:attribute>
                                                         <xsl:attribute name="size">50</xsl:attribute>
                                                         </xsl:element>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                         <xsl:element name="INPUT">
                                                            <xsl:attribute name="type">submit</xsl:attribute>
                                                            <xsl:attribute name="value">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Search']"/>
                                                            </xsl:attribute>
                                                            <xsl:attribute name="onclick">doSubmit(5,"")</xsl:attribute>
                                                         </xsl:element>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                         <xsl:element name="INPUT">
                                                            <xsl:attribute name="type">button</xsl:attribute>
                                                            <xsl:attribute name="value">
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='?']"/>
                                                            </xsl:attribute>
                                                            <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[ViewHelp()]]></xsl:text></xsl:attribute>
                                                         </xsl:element>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                         <xsl:element name="SELECT">
                                                            <xsl:attribute name="name">View</xsl:attribute>
                                                            <xsl:attribute name="id">View</xsl:attribute>
                                                            <xsl:variable name="tmp"><xsl:value-of select="/DATA/PARAM/@view"/></xsl:variable>
                                                            <xsl:element name="OPTION">
                                                               <xsl:attribute name="value">1</xsl:attribute>
                                                               <xsl:if test="$tmp='1'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ListView']"/>
                                                            </xsl:element>
                                                            <xsl:element name="OPTION">
                                                               <xsl:attribute name="value">2</xsl:attribute>
                                                               <xsl:if test="$tmp='2'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ThumbView']"/>
                                                            </xsl:element>
                                                            <xsl:element name="OPTION">
                                                               <xsl:attribute name="value">3</xsl:attribute>
                                                               <xsl:if test="$tmp='3'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GridView']"/>
                                                            </xsl:element>
                                                         </xsl:element>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                         <xsl:element name="SELECT">
                                                            <xsl:attribute name="name">Sort</xsl:attribute>
                                                            <xsl:attribute name="id">Sort</xsl:attribute>
                                                            <xsl:variable name="tmp"><xsl:value-of select="/DATA/PARAM/@sort"/></xsl:variable>
                                                            <xsl:element name="OPTION">
                                                               <xsl:attribute name="value">1</xsl:attribute>
                                                               <xsl:if test="$tmp='1'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MostReleventSort']"/>
                                                            </xsl:element>
                                                            <xsl:element name="OPTION">
                                                               <xsl:attribute name="value">2</xsl:attribute>
                                                               <xsl:if test="$tmp='2'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MostCurrentSort']"/>
                                                            </xsl:element>
                                                            <xsl:element name="OPTION">
                                                               <xsl:attribute name="value">3</xsl:attribute>
                                                               <xsl:if test="$tmp='3'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LowPriceSort']"/>
                                                            </xsl:element>
                                                            <xsl:element name="OPTION">
                                                               <xsl:attribute name="value">4</xsl:attribute>
                                                               <xsl:if test="$tmp='4'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='HighPriceSort']"/>
                                                            </xsl:element>
                                                         </xsl:element>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                         <xsl:element name="INPUT">
                                                            <xsl:attribute name="type">button</xsl:attribute>
                                                            <xsl:attribute name="class">smbutton</xsl:attribute>
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

                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">800</xsl:attribute>
                                                         <xsl:attribute name="align">right</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:call-template name="PreviousNext"/>
                                                      </xsl:element>
                                                   </xsl:element>

                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">800</xsl:attribute>
                                                         <xsl:attribute name="height">2</xsl:attribute>
                                                         <xsl:attribute name="bgcolor">#CCCCCC</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>

                                                   <xsl:if test="(/DATA/PARAM/@view &lt;= 2)">
                                                      <xsl:for-each select="/DATA/TXN/PTSBARTERADS/PTSBARTERAD">
                                                            <xsl:element name="TR">
                                                               <xsl:attribute name="height">30</xsl:attribute>
                                                               <xsl:element name="TD">
                                                                  <xsl:attribute name="width">800</xsl:attribute>
                                                                  <xsl:attribute name="align">left</xsl:attribute>
                                                                  <xsl:attribute name="valign">middle</xsl:attribute>
                                                                     <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                  <xsl:if test="(/DATA/PARAM/@view = 2)">
                                                                        <xsl:if test="(not(@image))">
                                                                           <xsl:element name="IMG">
                                                                              <xsl:attribute name="src">Images/barter/defaults.gif</xsl:attribute>
                                                                              <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                              <xsl:attribute name="border">0</xsl:attribute>
                                                                           </xsl:element>
                                                                        </xsl:if>
                                                                        <xsl:if test="(@image)">
                                                                           <xsl:element name="IMG">
                                                                              <xsl:attribute name="src">Images/barter/<xsl:value-of select="@image"/></xsl:attribute>
                                                                              <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                              <xsl:attribute name="border">0</xsl:attribute>
                                                                           </xsl:element>
                                                                        </xsl:if>
                                                                        <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                                  </xsl:if>
                                                                     <xsl:element name="font">
                                                                        <xsl:attribute name="size">2</xsl:attribute>
                                                                        <xsl:attribute name="color">gray</xsl:attribute>
                                                                     <xsl:value-of select="@postdate"/>
                                                                     </xsl:element>
                                                                     <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                  <xsl:if test="(contains(@options, 'C'))">
                                                                        <xsl:element name="A">
                                                                           <xsl:attribute name="onclick">w=window.open(this.href,"_blank","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                                           <xsl:attribute name="href">17204.asp?BarterAdID=<xsl:value-of select="@barteradid"/></xsl:attribute>
                                                                        <xsl:element name="font">
                                                                           <xsl:attribute name="size">4</xsl:attribute>
                                                                           <xsl:attribute name="color">blue</xsl:attribute>
                                                                        <xsl:value-of select="@title"/>
                                                                        </xsl:element>
                                                                        </xsl:element>
                                                                  </xsl:if>
                                                                  <xsl:if test="(not(contains(@options, 'C')))">
                                                                        <xsl:element name="A">
                                                                           <xsl:attribute name="onclick">w=window.open(this.href,"_blank","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                                           <xsl:attribute name="href">17204.asp?BarterAdID=<xsl:value-of select="@barteradid"/></xsl:attribute>
                                                                        <xsl:element name="font">
                                                                           <xsl:attribute name="size">3</xsl:attribute>
                                                                        <xsl:value-of select="@title"/>
                                                                        </xsl:element>
                                                                        </xsl:element>
                                                                  </xsl:if>
                                                                     <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                  <xsl:if test="(not(contains(@options, 'A')))">
                                                                        -
                                                                        <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                        <xsl:if test="(contains(@options, 'C'))">
                                                                           <xsl:element name="font">
                                                                              <xsl:attribute name="size">3</xsl:attribute>
                                                                              <xsl:attribute name="color">blue</xsl:attribute>
                                                                           <xsl:value-of select="@price"/>
                                                                           </xsl:element>
                                                                        </xsl:if>
                                                                        <xsl:if test="(not(contains(@options, 'C')))">
                                                                           <xsl:element name="font">
                                                                              <xsl:attribute name="size">3</xsl:attribute>
                                                                           <xsl:value-of select="@price"/>
                                                                           </xsl:element>
                                                                        </xsl:if>
                                                                        <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                  </xsl:if>
                                                                     <xsl:value-of select="concat('(',@location,' ',@zip,')')"/>
                                                                     <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                     <xsl:element name="font">
                                                                        <xsl:attribute name="size">2</xsl:attribute>
                                                                        <xsl:if test="(@images = 1)">
                                                                           <xsl:element name="font">
                                                                              <xsl:attribute name="color">orange</xsl:attribute>
                                                                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='pic']"/>
                                                                           </xsl:element>
                                                                           <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                        </xsl:if>
                                                                        <xsl:if test="(@images &gt; 1)">
                                                                           <xsl:element name="font">
                                                                              <xsl:attribute name="color">orange</xsl:attribute>
                                                                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='pics']"/>
                                                                           </xsl:element>
                                                                           <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                        </xsl:if>
                                                                        <xsl:if test="(@ismap != 0)">
                                                                           <xsl:element name="font">
                                                                              <xsl:attribute name="color">green</xsl:attribute>
                                                                           <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='map']"/>
                                                                           </xsl:element>
                                                                           <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                        </xsl:if>
                                                                     </xsl:element>
                                                               </xsl:element>
                                                            </xsl:element>

                                                      </xsl:for-each>
                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/PARAM/@view = 3)">
                                                      <xsl:element name="TR">
                                                         <xsl:element name="TD">
                                                            <xsl:attribute name="width">800</xsl:attribute>
                                                            <xsl:attribute name="align">left</xsl:attribute>
                                                            <xsl:attribute name="valign">top</xsl:attribute>
                                                            <xsl:for-each select="/DATA/TXN/PTSBARTERADS/PTSBARTERAD">
                                                                  <xsl:if test="(not(contains(@options, 'C')))">
                                                                     <xsl:element name="DIV">
                                                                        <xsl:attribute name="id">box</xsl:attribute>
                                                                        <xsl:attribute name="class">BarterBox</xsl:attribute>
                                                                     <xsl:if test="(not(contains(@options, 'A')))">
                                                                        <xsl:element name="DIV">
                                                                           <xsl:attribute name="id">price</xsl:attribute>
                                                                           <xsl:attribute name="class">BarterPrice</xsl:attribute>
                                                                           <xsl:value-of select="@price"/>
                                                                        </xsl:element>
                                                                     </xsl:if>
                                                                        <xsl:if test="(not(@image))">
                                                                           <xsl:element name="IMG">
                                                                              <xsl:attribute name="src">Images/barter/defaultm.gif</xsl:attribute>
                                                                              <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                              <xsl:attribute name="border">0</xsl:attribute>
                                                                           </xsl:element>
                                                                        </xsl:if>
                                                                        <xsl:if test="(@image)">
                                                                           <xsl:element name="IMG">
                                                                              <xsl:attribute name="src">Images/barter/<xsl:value-of select="@image"/></xsl:attribute>
                                                                              <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                              <xsl:attribute name="border">0</xsl:attribute>
                                                                           </xsl:element>
                                                                        </xsl:if>
                                                                        <xsl:element name="BR"/>
                                                                        <xsl:element name="font">
                                                                           <xsl:attribute name="size">2</xsl:attribute>
                                                                           <xsl:attribute name="color">gray</xsl:attribute>
                                                                        <xsl:value-of select="@postdate"/>
                                                                        </xsl:element>
                                                                        <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                     <xsl:if test="(contains(@options, 'C'))">
                                                                           <xsl:element name="A">
                                                                              <xsl:attribute name="onclick">w=window.open(this.href,"_blank","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                                              <xsl:attribute name="href">17204.asp?BarterAdID=<xsl:value-of select="@barteradid"/></xsl:attribute>
                                                                           <xsl:element name="font">
                                                                              <xsl:attribute name="size">4</xsl:attribute>
                                                                              <xsl:attribute name="color">blue</xsl:attribute>
                                                                           <xsl:value-of select="@title"/>
                                                                           </xsl:element>
                                                                           </xsl:element>
                                                                     </xsl:if>
                                                                     <xsl:if test="(not(contains(@options, 'C')))">
                                                                           <xsl:element name="A">
                                                                              <xsl:attribute name="onclick">w=window.open(this.href,"_blank","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                                              <xsl:attribute name="href">17204.asp?BarterAdID=<xsl:value-of select="@barteradid"/></xsl:attribute>
                                                                           <xsl:element name="font">
                                                                              <xsl:attribute name="size">3</xsl:attribute>
                                                                           <xsl:value-of select="@title"/>
                                                                           </xsl:element>
                                                                           </xsl:element>
                                                                     </xsl:if>
                                                                        <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                        -
                                                                        <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                        <xsl:value-of select="concat('(',@location,' ',@zip,')')"/>
                                                                        <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                        <xsl:element name="font">
                                                                           <xsl:attribute name="size">2</xsl:attribute>
                                                                           <xsl:if test="(@images = 1)">
                                                                              <xsl:element name="font">
                                                                                 <xsl:attribute name="color">orange</xsl:attribute>
                                                                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='pic']"/>
                                                                              </xsl:element>
                                                                              <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                           </xsl:if>
                                                                           <xsl:if test="(@images &gt; 1)">
                                                                              <xsl:element name="font">
                                                                                 <xsl:attribute name="color">orange</xsl:attribute>
                                                                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='pics']"/>
                                                                              </xsl:element>
                                                                              <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                           </xsl:if>
                                                                           <xsl:if test="(@ismap != 0)">
                                                                              <xsl:element name="font">
                                                                                 <xsl:attribute name="color">green</xsl:attribute>
                                                                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='map']"/>
                                                                              </xsl:element>
                                                                              <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                           </xsl:if>
                                                                        </xsl:element>
                                                                     </xsl:element>
                                                                  </xsl:if>
                                                                  <xsl:if test="(contains(@options, 'C'))">
                                                                     <xsl:element name="DIV">
                                                                        <xsl:attribute name="id">box</xsl:attribute>
                                                                        <xsl:attribute name="class">BarterBox2</xsl:attribute>
                                                                     <xsl:if test="(not(contains(@options, 'A')))">
                                                                        <xsl:element name="DIV">
                                                                           <xsl:attribute name="id">price</xsl:attribute>
                                                                           <xsl:attribute name="class">BarterPrice2</xsl:attribute>
                                                                           <xsl:value-of select="@price"/>
                                                                        </xsl:element>
                                                                     </xsl:if>
                                                                        <xsl:if test="(not(@image))">
                                                                           <xsl:element name="IMG">
                                                                              <xsl:attribute name="src">Images/barter/defaultm.gif</xsl:attribute>
                                                                              <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                              <xsl:attribute name="border">0</xsl:attribute>
                                                                           </xsl:element>
                                                                        </xsl:if>
                                                                        <xsl:if test="(@image)">
                                                                           <xsl:element name="IMG">
                                                                              <xsl:attribute name="src">Images/barter/<xsl:value-of select="@image"/></xsl:attribute>
                                                                              <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                                              <xsl:attribute name="border">0</xsl:attribute>
                                                                           </xsl:element>
                                                                        </xsl:if>
                                                                        <xsl:element name="BR"/>
                                                                        <xsl:element name="font">
                                                                           <xsl:attribute name="size">2</xsl:attribute>
                                                                           <xsl:attribute name="color">gray</xsl:attribute>
                                                                        <xsl:value-of select="@postdate"/>
                                                                        </xsl:element>
                                                                        <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                     <xsl:if test="(contains(@options, 'C'))">
                                                                           <xsl:element name="A">
                                                                              <xsl:attribute name="onclick">w=window.open(this.href,"_blank","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                                              <xsl:attribute name="href">17204.asp?BarterAdID=<xsl:value-of select="@barteradid"/></xsl:attribute>
                                                                           <xsl:element name="font">
                                                                              <xsl:attribute name="size">4</xsl:attribute>
                                                                              <xsl:attribute name="color">blue</xsl:attribute>
                                                                           <xsl:value-of select="@title"/>
                                                                           </xsl:element>
                                                                           </xsl:element>
                                                                     </xsl:if>
                                                                     <xsl:if test="(not(contains(@options, 'C')))">
                                                                           <xsl:element name="A">
                                                                              <xsl:attribute name="onclick">w=window.open(this.href,"_blank","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                                              <xsl:attribute name="href">17204.asp?BarterAdID=<xsl:value-of select="@barteradid"/></xsl:attribute>
                                                                           <xsl:element name="font">
                                                                              <xsl:attribute name="size">3</xsl:attribute>
                                                                           <xsl:value-of select="@title"/>
                                                                           </xsl:element>
                                                                           </xsl:element>
                                                                     </xsl:if>
                                                                        <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                        -
                                                                        <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                        <xsl:value-of select="concat('(',@location,' ',@zip,')')"/>
                                                                        <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                        <xsl:element name="font">
                                                                           <xsl:attribute name="size">2</xsl:attribute>
                                                                           <xsl:if test="(@images = 1)">
                                                                              <xsl:element name="font">
                                                                                 <xsl:attribute name="color">orange</xsl:attribute>
                                                                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='pic']"/>
                                                                              </xsl:element>
                                                                              <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                           </xsl:if>
                                                                           <xsl:if test="(@images &gt; 1)">
                                                                              <xsl:element name="font">
                                                                                 <xsl:attribute name="color">orange</xsl:attribute>
                                                                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='pics']"/>
                                                                              </xsl:element>
                                                                              <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                           </xsl:if>
                                                                           <xsl:if test="(@ismap != 0)">
                                                                              <xsl:element name="font">
                                                                                 <xsl:attribute name="color">green</xsl:attribute>
                                                                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='map']"/>
                                                                              </xsl:element>
                                                                              <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                                           </xsl:if>
                                                                        </xsl:element>
                                                                     </xsl:element>
                                                                  </xsl:if>
                                                            </xsl:for-each>
                                                         </xsl:element>
                                                      </xsl:element>

                                                   </xsl:if>
                                                   <xsl:if test="(count(/DATA/TXN/PTSBARTERADS/PTSBARTERAD) = 0)">
                                                      <xsl:element name="TR">
                                                         <xsl:attribute name="height">30</xsl:attribute>
                                                         <xsl:element name="TD">
                                                            <xsl:attribute name="width">800</xsl:attribute>
                                                            <xsl:attribute name="align">left</xsl:attribute>
                                                            <xsl:attribute name="valign">center</xsl:attribute>
                                                            <xsl:attribute name="class">NoItems</xsl:attribute>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                               <xsl:element name="font">
                                                                  <xsl:attribute name="size">3</xsl:attribute>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoItems']"/>
                                                               </xsl:element>
                                                         </xsl:element>
                                                      </xsl:element>
                                                   </xsl:if>

                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">800</xsl:attribute>
                                                         <xsl:attribute name="height">2</xsl:attribute>
                                                         <xsl:attribute name="bgcolor">#CCCCCC</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>

                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">800</xsl:attribute>
                                                         <xsl:attribute name="align">right</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:call-template name="PreviousNext"/>
                                                      </xsl:element>
                                                   </xsl:element>

                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">200</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:for-each select="/DATA/TXN/PTSADCAMPAIGNS/PTSADCAMPAIGN">
                                                   <xsl:if test="(not(contains(@options, 'C')))">
                                                      <xsl:element name="DIV">
                                                         <xsl:attribute name="id">box</xsl:attribute>
                                                         <xsl:attribute name="class">AdBox</xsl:attribute>
                                                      <xsl:if test="(not(contains(@options, 'A')))">
                                                         <xsl:element name="DIV">
                                                            <xsl:attribute name="id">price</xsl:attribute>
                                                            <xsl:attribute name="class">AdPrice</xsl:attribute>
                                                            <xsl:value-of select="@price"/>
                                                         </xsl:element>
                                                      </xsl:if>
                                                         <xsl:if test="(not(@image))">
                                                            <xsl:element name="IMG">
                                                               <xsl:attribute name="src">Images/barter/defaultm.gif</xsl:attribute>
                                                               <xsl:attribute name="width">180</xsl:attribute>
                                                               <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                               <xsl:attribute name="border">0</xsl:attribute>
                                                            </xsl:element>
                                                         </xsl:if>
                                                         <xsl:if test="(@image)">
                                                            <xsl:element name="IMG">
                                                               <xsl:attribute name="src">Images/barter/<xsl:value-of select="@image"/></xsl:attribute>
                                                               <xsl:attribute name="width">180</xsl:attribute>
                                                               <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                               <xsl:attribute name="border">0</xsl:attribute>
                                                            </xsl:element>
                                                         </xsl:if>
                                                         <xsl:element name="BR"/>
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="size">2</xsl:attribute>
                                                            <xsl:attribute name="color">gray</xsl:attribute>
                                                         <xsl:value-of select="@postdate"/>
                                                         </xsl:element>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:if test="(contains(@options, 'C'))">
                                                            <xsl:element name="A">
                                                               <xsl:attribute name="onclick">w=window.open(this.href,"_blank","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                               <xsl:attribute name="href">17204.asp?BarterAdID=<xsl:value-of select="@barteradid"/></xsl:attribute>
                                                            <xsl:element name="font">
                                                               <xsl:attribute name="size">4</xsl:attribute>
                                                               <xsl:attribute name="color">blue</xsl:attribute>
                                                            <xsl:value-of select="@title"/>
                                                            </xsl:element>
                                                            </xsl:element>
                                                      </xsl:if>
                                                      <xsl:if test="(not(contains(@options, 'C')))">
                                                            <xsl:element name="A">
                                                               <xsl:attribute name="onclick">w=window.open(this.href,"_blank","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                               <xsl:attribute name="href">17204.asp?BarterAdID=<xsl:value-of select="@barteradid"/></xsl:attribute>
                                                            <xsl:element name="font">
                                                               <xsl:attribute name="size">3</xsl:attribute>
                                                            <xsl:value-of select="@title"/>
                                                            </xsl:element>
                                                            </xsl:element>
                                                      </xsl:if>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                         -
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                         <xsl:value-of select="concat('(',@location,' ',@zip,')')"/>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="size">2</xsl:attribute>
                                                            <xsl:if test="(@images = 1)">
                                                               <xsl:element name="font">
                                                                  <xsl:attribute name="color">orange</xsl:attribute>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='pic']"/>
                                                               </xsl:element>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            </xsl:if>
                                                            <xsl:if test="(@images &gt; 1)">
                                                               <xsl:element name="font">
                                                                  <xsl:attribute name="color">orange</xsl:attribute>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='pics']"/>
                                                               </xsl:element>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            </xsl:if>
                                                            <xsl:if test="(@ismap != 0)">
                                                               <xsl:element name="font">
                                                                  <xsl:attribute name="color">green</xsl:attribute>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='map']"/>
                                                               </xsl:element>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            </xsl:if>
                                                         </xsl:element>
                                                      </xsl:element>
                                                   </xsl:if>
                                                   <xsl:if test="(contains(@options, 'C'))">
                                                      <xsl:element name="DIV">
                                                         <xsl:attribute name="id">box</xsl:attribute>
                                                         <xsl:attribute name="class">AdBox2</xsl:attribute>
                                                      <xsl:if test="(not(contains(@options, 'A')))">
                                                         <xsl:element name="DIV">
                                                            <xsl:attribute name="id">price</xsl:attribute>
                                                            <xsl:attribute name="class">AdPrice2</xsl:attribute>
                                                            <xsl:value-of select="@price"/>
                                                         </xsl:element>
                                                      </xsl:if>
                                                         <xsl:if test="(not(@image))">
                                                            <xsl:element name="IMG">
                                                               <xsl:attribute name="src">Images/barter/defaultm.gif</xsl:attribute>
                                                               <xsl:attribute name="width">180</xsl:attribute>
                                                               <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                               <xsl:attribute name="border">0</xsl:attribute>
                                                            </xsl:element>
                                                         </xsl:if>
                                                         <xsl:if test="(@image)">
                                                            <xsl:element name="IMG">
                                                               <xsl:attribute name="src">Images/barter/<xsl:value-of select="@image"/></xsl:attribute>
                                                               <xsl:attribute name="width">180</xsl:attribute>
                                                               <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                               <xsl:attribute name="border">0</xsl:attribute>
                                                            </xsl:element>
                                                         </xsl:if>
                                                         <xsl:element name="BR"/>
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="size">2</xsl:attribute>
                                                            <xsl:attribute name="color">gray</xsl:attribute>
                                                         <xsl:value-of select="@postdate"/>
                                                         </xsl:element>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                      <xsl:if test="(contains(@options, 'C'))">
                                                            <xsl:element name="A">
                                                               <xsl:attribute name="onclick">w=window.open(this.href,"_blank","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                               <xsl:attribute name="href">17204.asp?BarterAdID=<xsl:value-of select="@barteradid"/></xsl:attribute>
                                                            <xsl:element name="font">
                                                               <xsl:attribute name="size">4</xsl:attribute>
                                                               <xsl:attribute name="color">blue</xsl:attribute>
                                                            <xsl:value-of select="@title"/>
                                                            </xsl:element>
                                                            </xsl:element>
                                                      </xsl:if>
                                                      <xsl:if test="(not(contains(@options, 'C')))">
                                                            <xsl:element name="A">
                                                               <xsl:attribute name="onclick">w=window.open(this.href,"_blank","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                               <xsl:attribute name="href">17204.asp?BarterAdID=<xsl:value-of select="@barteradid"/></xsl:attribute>
                                                            <xsl:element name="font">
                                                               <xsl:attribute name="size">3</xsl:attribute>
                                                            <xsl:value-of select="@title"/>
                                                            </xsl:element>
                                                            </xsl:element>
                                                      </xsl:if>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                         -
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                         <xsl:value-of select="concat('(',@location,' ',@zip,')')"/>
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="size">2</xsl:attribute>
                                                            <xsl:if test="(@images = 1)">
                                                               <xsl:element name="font">
                                                                  <xsl:attribute name="color">orange</xsl:attribute>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='pic']"/>
                                                               </xsl:element>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            </xsl:if>
                                                            <xsl:if test="(@images &gt; 1)">
                                                               <xsl:element name="font">
                                                                  <xsl:attribute name="color">orange</xsl:attribute>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='pics']"/>
                                                               </xsl:element>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            </xsl:if>
                                                            <xsl:if test="(@ismap != 0)">
                                                               <xsl:element name="font">
                                                                  <xsl:attribute name="color">green</xsl:attribute>
                                                               <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='map']"/>
                                                               </xsl:element>
                                                               <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            </xsl:if>
                                                         </xsl:element>
                                                      </xsl:element>
                                                   </xsl:if>
                                             </xsl:for-each>
                                          </xsl:element>
                                       </xsl:element>

                                 </xsl:element>
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

      </xsl:element>
      </xsl:element>
      <!--END BODY-->

      </xsl:element>

   </xsl:template>
</xsl:stylesheet>