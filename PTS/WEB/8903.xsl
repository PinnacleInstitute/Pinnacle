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
         <xsl:with-param name="pagename" select="'EmailList'"/>
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
                     <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[
               if (document.getElementById('SourceType').value == 1) {
                  ToggleSource();
                  ToggleCondition2();
                  ToggleCondition3();
               }
            ]]></xsl:text>;doErrorMsg('<xsl:value-of select="concat($errmsg, $errmsgfld)"/>')</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[
               if (document.getElementById('SourceType').value == 1) {
                  ToggleSource();
                  ToggleCondition2();
                  ToggleCondition3();
               }
            ]]></xsl:text>;doErrorMsg('<xsl:value-of select="/DATA/ERROR"/>')</xsl:attribute>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
               <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[
               if (document.getElementById('SourceType').value == 1) {
                  ToggleSource();
                  ToggleCondition2();
                  ToggleCondition3();
               }
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
               <xsl:attribute name="name">EmailList</xsl:attribute>
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
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ToggleSource(){ 
               if (document.getElementById('EmailSourceInclude').value == 'Top'){
                  document.getElementById('EmailSourceQuantity').style.visibility = 'visible';
                  document.getElementById('EmailSourceOrder').style.visibility = 'visible';
                  document.getElementById('EmailSourceOrderBy').style.visibility = 'visible';
                  document.all['SortBy'].style.visibility = 'visible';
               }else{
                  document.getElementById('EmailSourceQuantity').style.visibility = 'hidden';
                  document.getElementById('EmailSourceOrder').style.visibility = 'hidden';
                  document.getElementById('EmailSourceOrderBy').style.visibility = 'hidden';
                  document.all['SortBy').style.visibility = 'hidden';
               };
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ToggleCondition2(){ 
               if (document.getElementById('EmailSourceExpr1').value != 0){
                  document.getElementById('EmailSourceConnector2').style.visibility = 'visible';
                  document.getElementById('EmailSourceExpr2').style.visibility = 'visible';
                  document.getElementById('EmailSourceOper2').style.visibility = 'visible';
                  document.getElementById('EmailSourceValue2').style.visibility = 'visible';
               }else{
                  document.getElementById('EmailSourceConnector2').style.visibility = 'hidden';
                  document.getElementById('EmailSourceExpr2.style').visibility = 'hidden';
                  document.getElementById('EmailSourceOper2.style').visibility = 'hidden';
                  document.getElementById('EmailSourceValue2').style.visibility = 'hidden';
               };
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ToggleCondition3(){ 
               if (document.getElementById('EmailSourceExpr2').value != 0){
                  document.getElementById('EmailSourceConnector3').style.visibility = 'visible';
                  document.getElementById('EmailSourceExpr3').style.visibility = 'visible';
                  document.getElementById('EmailSourceOper3').style.visibility = 'visible';
                  document.getElementById('EmailSourceValue3').style.visibility = 'visible';
               }else{
                  document.getElementById('EmailSourceConnector3').style.visibility = 'hidden';
                  document.getElementById('EmailSourceExpr3').style.visibility = 'hidden';
                  document.getElementById('EmailSourceOper3').style.visibility = 'hidden';
                  document.getElementById('EmailSourceValue3').style.visibility = 'hidden';
               };
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
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">PageHeading</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EmailList']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:value-of select="/DATA/TXN/PTSEMAILLIST/@emaillistname"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">300</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">bottom</xsl:attribute>
                                          <xsl:attribute name="class">PrevNext</xsl:attribute>
                                          <xsl:element name="A">
                                             <xsl:attribute name="onclick">w=window.open(this.href,"EmailList","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                             <xsl:attribute name="href">8704.asp?EmailListID=<xsl:value-of select="/DATA/PARAM/@emaillistid"/></xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Preview']"/>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;|&amp;#160;</xsl:text>
                                          <xsl:if test="(/DATA/TXN/PTSEMAILLIST/@sourcetype = 0)">
                                             <xsl:element name="A">
                                                <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                                <xsl:attribute name="href">8702.asp?EmailListID=<xsl:value-of select="/DATA/PARAM/@emaillistid"/>&amp;CompanyID=<xsl:value-of select="/DATA/PARAM/@companyid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewEmailee']"/>
                                             </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;|&amp;#160;</xsl:text>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@companyid = 0) and (/DATA/TXN/PTSEMAILLIST/@sourcetype = 2)">
                                             <xsl:element name="A">
                                                <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                                <xsl:attribute name="onclick">w=window.open(this.href,"help","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                <xsl:attribute name="href">Pagex.asp?Page=8903help</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Help']"/>
                                             </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;|&amp;#160;</xsl:text>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@companyid != 0)">
                                             <xsl:element name="A">
                                                <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                                <xsl:attribute name="onclick">w=window.open(this.href,"help","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                <xsl:attribute name="href">Pagex.asp?Page=8903helpCompany</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Help']"/>
                                             </xsl:element>
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
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">prompt</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EmailListText']"/>
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
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EmailListID']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="height">18</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="b">
                              <xsl:value-of select="/DATA/TXN/PTSEMAILLIST/@emaillistid"/>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">160</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EmailListName']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">EmailListName</xsl:attribute>
                              <xsl:attribute name="id">EmailListName</xsl:attribute>
                              <xsl:attribute name="size">40</xsl:attribute>
                              <xsl:attribute name="maxlength">60</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSEMAILLIST/@emaillistname"/></xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                              <xsl:element name="IMG">
                                 <xsl:attribute name="src">Images/Required.gif</xsl:attribute>
                                 <xsl:attribute name="alt">Required Field</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/PARAM/@companyid = 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">160</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SourceType']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="SELECT">
                                    <xsl:attribute name="name">SourceType</xsl:attribute>
                                    <xsl:attribute name="id">SourceType</xsl:attribute>
                                    <xsl:attribute name="onchange"><xsl:text disable-output-escaping="yes"><![CDATA[doSubmit(5,'');]]></xsl:text></xsl:attribute>
                                    <xsl:for-each select="/DATA/TXN/PTSEMAILLIST/PTSSOURCETYPES/ENUM">
                                       <xsl:element name="OPTION">
                                          <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                          <xsl:if test="@selected"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:variable name="tmp1"><xsl:value-of select="current()/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp1]"/>
                                       </xsl:element>
                                    </xsl:for-each>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="(/DATA/PARAM/@companyid != 0)">
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">SourceType</xsl:attribute>
                              <xsl:attribute name="id">SourceType</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSEMAILLIST/@sourcetype"/></xsl:attribute>
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

                        <xsl:if test="(/DATA/PARAM/@companyid != 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">prompt</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CustomCompanyText']"/>
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
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CustomCompanyID']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="SELECT">
                                    <xsl:attribute name="name">CustomID</xsl:attribute>
                                    <xsl:attribute name="id">CustomID</xsl:attribute>
                                    <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/PTSEMAILLIST/@customid"/></xsl:variable>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">99</xsl:attribute>
                                       <xsl:if test="$tmp='99'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EmailList99']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">95</xsl:attribute>
                                       <xsl:if test="$tmp='95'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EmailList95']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">89</xsl:attribute>
                                       <xsl:if test="$tmp='89'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EmailList89']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">94</xsl:attribute>
                                       <xsl:if test="$tmp='94'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EmailList94']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">88</xsl:attribute>
                                       <xsl:if test="$tmp='88'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EmailList88']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">98</xsl:attribute>
                                       <xsl:if test="$tmp='98'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EmailList98']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">96</xsl:attribute>
                                       <xsl:if test="$tmp='96'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EmailList96']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">97</xsl:attribute>
                                       <xsl:if test="$tmp='97'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EmailList97']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">87</xsl:attribute>
                                       <xsl:if test="$tmp='87'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EmailList87']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">91</xsl:attribute>
                                       <xsl:if test="$tmp='91'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EmailList91']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">93</xsl:attribute>
                                       <xsl:if test="$tmp='93'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EmailList93']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">90</xsl:attribute>
                                       <xsl:if test="$tmp='90'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EmailList90']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">92</xsl:attribute>
                                       <xsl:if test="$tmp='92'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EmailList92']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">86</xsl:attribute>
                                       <xsl:if test="$tmp='86'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EmailList86']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">85</xsl:attribute>
                                       <xsl:if test="$tmp='85'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EmailList85']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">84</xsl:attribute>
                                       <xsl:if test="$tmp='84'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EmailList84']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">83</xsl:attribute>
                                       <xsl:if test="$tmp='83'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EmailList83']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">82</xsl:attribute>
                                       <xsl:if test="$tmp='82'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EmailList82']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">81</xsl:attribute>
                                       <xsl:if test="$tmp='81'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EmailList81']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">80</xsl:attribute>
                                       <xsl:if test="$tmp='80'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EmailList80']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">79</xsl:attribute>
                                       <xsl:if test="$tmp='79'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EmailList79']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">78</xsl:attribute>
                                       <xsl:if test="$tmp='78'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EmailList78']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">77</xsl:attribute>
                                       <xsl:if test="$tmp='77'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EmailList77']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">76</xsl:attribute>
                                       <xsl:if test="$tmp='76'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EmailList76']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">75</xsl:attribute>
                                       <xsl:if test="$tmp='75'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EmailList75']"/>
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
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CustomHelpText']"/>
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
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Param1']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">Param1</xsl:attribute>
                                 <xsl:attribute name="id">Param1</xsl:attribute>
                                 <xsl:attribute name="size">30</xsl:attribute>
                                 <xsl:attribute name="maxlength">30</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSEMAILLIST/@param1"/></xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">160</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Param2']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">Param2</xsl:attribute>
                                 <xsl:attribute name="id">Param2</xsl:attribute>
                                 <xsl:attribute name="size">30</xsl:attribute>
                                 <xsl:attribute name="maxlength">30</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSEMAILLIST/@param2"/></xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">160</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Param3']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">Param3</xsl:attribute>
                                 <xsl:attribute name="id">Param3</xsl:attribute>
                                 <xsl:attribute name="size">30</xsl:attribute>
                                 <xsl:attribute name="maxlength">30</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSEMAILLIST/@param3"/></xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">160</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Param4']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">Param4</xsl:attribute>
                                 <xsl:attribute name="id">Param4</xsl:attribute>
                                 <xsl:attribute name="size">30</xsl:attribute>
                                 <xsl:attribute name="maxlength">30</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSEMAILLIST/@param4"/></xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">160</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Param5']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">Param5</xsl:attribute>
                                 <xsl:attribute name="id">Param5</xsl:attribute>
                                 <xsl:attribute name="size">30</xsl:attribute>
                                 <xsl:attribute name="maxlength">30</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSEMAILLIST/@param5"/></xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/PARAM/@companyid = 0)">
                           <xsl:if test="(/DATA/TXN/PTSEMAILLIST/@sourcetype = 2)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="width">600</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:attribute name="class">prompt</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CustomText']"/>
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
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CustomID']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">440</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="INPUT">
                                    <xsl:attribute name="type">text</xsl:attribute>
                                    <xsl:attribute name="name">CustomID</xsl:attribute>
                                    <xsl:attribute name="id">CustomID</xsl:attribute>
                                    <xsl:attribute name="size">10</xsl:attribute>
                                    <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSEMAILLIST/@customid"/></xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">160</xsl:attribute>
                                    <xsl:attribute name="align">right</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Param1']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">440</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="INPUT">
                                    <xsl:attribute name="type">text</xsl:attribute>
                                    <xsl:attribute name="name">Param1</xsl:attribute>
                                    <xsl:attribute name="id">Param1</xsl:attribute>
                                    <xsl:attribute name="size">30</xsl:attribute>
                                    <xsl:attribute name="maxlength">30</xsl:attribute>
                                    <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSEMAILLIST/@param1"/></xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">160</xsl:attribute>
                                    <xsl:attribute name="align">right</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Param2']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">440</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="INPUT">
                                    <xsl:attribute name="type">text</xsl:attribute>
                                    <xsl:attribute name="name">Param2</xsl:attribute>
                                    <xsl:attribute name="id">Param2</xsl:attribute>
                                    <xsl:attribute name="size">30</xsl:attribute>
                                    <xsl:attribute name="maxlength">30</xsl:attribute>
                                    <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSEMAILLIST/@param2"/></xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">160</xsl:attribute>
                                    <xsl:attribute name="align">right</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Param3']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">440</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="INPUT">
                                    <xsl:attribute name="type">text</xsl:attribute>
                                    <xsl:attribute name="name">Param3</xsl:attribute>
                                    <xsl:attribute name="id">Param3</xsl:attribute>
                                    <xsl:attribute name="size">30</xsl:attribute>
                                    <xsl:attribute name="maxlength">30</xsl:attribute>
                                    <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSEMAILLIST/@param3"/></xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">160</xsl:attribute>
                                    <xsl:attribute name="align">right</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Param4']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">440</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="INPUT">
                                    <xsl:attribute name="type">text</xsl:attribute>
                                    <xsl:attribute name="name">Param4</xsl:attribute>
                                    <xsl:attribute name="id">Param4</xsl:attribute>
                                    <xsl:attribute name="size">30</xsl:attribute>
                                    <xsl:attribute name="maxlength">30</xsl:attribute>
                                    <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSEMAILLIST/@param4"/></xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">160</xsl:attribute>
                                    <xsl:attribute name="align">right</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Param5']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">440</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="INPUT">
                                    <xsl:attribute name="type">text</xsl:attribute>
                                    <xsl:attribute name="name">Param5</xsl:attribute>
                                    <xsl:attribute name="id">Param5</xsl:attribute>
                                    <xsl:attribute name="size">30</xsl:attribute>
                                    <xsl:attribute name="maxlength">30</xsl:attribute>
                                    <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSEMAILLIST/@param5"/></xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>

                           </xsl:if>
                           <xsl:if test="(/DATA/TXN/PTSEMAILLIST/@sourcetype = 1)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="width">600</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:attribute name="class">prompt</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='UserDefinedText']"/>
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
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EmailSourceID']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">440</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="SELECT">
                                       <xsl:attribute name="name">EmailSourceID</xsl:attribute>
                                       <xsl:attribute name="id">EmailSourceID</xsl:attribute>
                                       <xsl:attribute name="onchange"><xsl:text disable-output-escaping="yes"><![CDATA[doSubmit(5,'');]]></xsl:text></xsl:attribute>
                                       <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/PTSEMAILLIST/@emailsourceid"/></xsl:variable>
                                       <xsl:for-each select="/DATA/TXN/PTSEMAILSOURCES/ENUM">
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
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:if test="(/DATA/TXN/PTSEMAILLIST/@emailsourceid &gt; 0)">
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">160</xsl:attribute>
                                       <xsl:attribute name="align">right</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EmailSourceMisc']"/>
                                       <xsl:text>:</xsl:text>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">440</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="SELECT">
                                          <xsl:attribute name="name">EmailSourceMisc1</xsl:attribute>
                                          <xsl:attribute name="id">EmailSourceMisc1</xsl:attribute>
                                          <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/QUERYDATA/WTATTRIBUTE[position()=1]/@src"/></xsl:variable>
                                          <xsl:for-each select="/DATA/TXN/FIELDLIST/ENUM">
                                             <xsl:element name="OPTION">
                                                <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                                <xsl:if test="$tmp=@id"><xsl:attribute name="SELECTED"/></xsl:if>
                                                <xsl:value-of select="@name"/>
                                             </xsl:element>
                                          </xsl:for-each>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:element name="SELECT">
                                          <xsl:attribute name="name">EmailSourceMisc2</xsl:attribute>
                                          <xsl:attribute name="id">EmailSourceMisc2</xsl:attribute>
                                          <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/QUERYDATA/WTATTRIBUTE[position()=2]/@src"/></xsl:variable>
                                          <xsl:for-each select="/DATA/TXN/FIELDLIST/ENUM">
                                             <xsl:element name="OPTION">
                                                <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                                <xsl:if test="$tmp=@id"><xsl:attribute name="SELECTED"/></xsl:if>
                                                <xsl:value-of select="@name"/>
                                             </xsl:element>
                                          </xsl:for-each>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:element name="SELECT">
                                          <xsl:attribute name="name">EmailSourceMisc3</xsl:attribute>
                                          <xsl:attribute name="id">EmailSourceMisc3</xsl:attribute>
                                          <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/QUERYDATA/WTATTRIBUTE[position()=3]/@src"/></xsl:variable>
                                          <xsl:for-each select="/DATA/TXN/FIELDLIST/ENUM">
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
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">440</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="SELECT">
                                          <xsl:attribute name="name">EmailSourceMisc4</xsl:attribute>
                                          <xsl:attribute name="id">EmailSourceMisc4</xsl:attribute>
                                          <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/QUERYDATA/WTATTRIBUTE[position()=4]/@src"/></xsl:variable>
                                          <xsl:for-each select="/DATA/TXN/FIELDLIST/ENUM">
                                             <xsl:element name="OPTION">
                                                <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                                <xsl:if test="$tmp=@id"><xsl:attribute name="SELECTED"/></xsl:if>
                                                <xsl:value-of select="@name"/>
                                             </xsl:element>
                                          </xsl:for-each>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:element name="SELECT">
                                          <xsl:attribute name="name">EmailSourceMisc5</xsl:attribute>
                                          <xsl:attribute name="id">EmailSourceMisc5</xsl:attribute>
                                          <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/QUERYDATA/WTATTRIBUTE[position()=5]/@src"/></xsl:variable>
                                          <xsl:for-each select="/DATA/TXN/FIELDLIST/ENUM">
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
                                       <xsl:element name="SELECT">
                                          <xsl:attribute name="name">EmailSourceExpr1</xsl:attribute>
                                          <xsl:attribute name="id">EmailSourceExpr1</xsl:attribute>
                                          <xsl:attribute name="onchange"><xsl:text disable-output-escaping="yes"><![CDATA[ToggleCondition2();]]></xsl:text></xsl:attribute>
                                          <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/QUERYDATA/WTCONDITION[position()=1]/@expr"/></xsl:variable>
                                          <xsl:for-each select="/DATA/TXN/FIELDLIST/ENUM">
                                             <xsl:element name="OPTION">
                                                <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                                <xsl:if test="$tmp=@id"><xsl:attribute name="SELECTED"/></xsl:if>
                                                <xsl:value-of select="@name"/>
                                             </xsl:element>
                                          </xsl:for-each>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:element name="SELECT">
                                          <xsl:attribute name="name">EmailSourceOper1</xsl:attribute>
                                          <xsl:attribute name="id">EmailSourceOper1</xsl:attribute>
                                          <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/QUERYDATA/WTCONDITION[position()=1]/@oper"/></xsl:variable>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">0</xsl:attribute>
                                             <xsl:if test="$tmp='0'"><xsl:attribute name="SELECTED"/></xsl:if>
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">equal</xsl:attribute>
                                             <xsl:if test="$tmp='equal'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsEqual']"/>
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">not-equal</xsl:attribute>
                                             <xsl:if test="$tmp='not-equal'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsNotEqual']"/>
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">less</xsl:attribute>
                                             <xsl:if test="$tmp='less'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsLess']"/>
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">greater</xsl:attribute>
                                             <xsl:if test="$tmp='greater'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsGreater']"/>
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">less-equal</xsl:attribute>
                                             <xsl:if test="$tmp='less-equal'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsLessEqual']"/>
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">greater-equal</xsl:attribute>
                                             <xsl:if test="$tmp='greater-equal'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsGreaterEqual']"/>
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">starts</xsl:attribute>
                                             <xsl:if test="$tmp='starts'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Starts']"/>
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">contains</xsl:attribute>
                                             <xsl:if test="$tmp='contains'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Contains']"/>
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">not-contains</xsl:attribute>
                                             <xsl:if test="$tmp='not-contains'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NotContains']"/>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:element name="INPUT">
                                       <xsl:attribute name="type">text</xsl:attribute>
                                       <xsl:attribute name="name">EmailSourceValue1</xsl:attribute>
                                       <xsl:attribute name="id">EmailSourceValue1</xsl:attribute>
                                       <xsl:attribute name="size">15</xsl:attribute>
                                       <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/QUERYDATA/WTCONDITION[position()=1]/@value"/></xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>

                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">160</xsl:attribute>
                                       <xsl:attribute name="align">right</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="SELECT">
                                          <xsl:attribute name="name">EmailSourceConnector2</xsl:attribute>
                                          <xsl:attribute name="id">EmailSourceConnector2</xsl:attribute>
                                          <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/QUERYDATA/WTCONDITION[position()=2]/@connector"/></xsl:variable>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">0</xsl:attribute>
                                             <xsl:if test="$tmp='0'"><xsl:attribute name="SELECTED"/></xsl:if>
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">and</xsl:attribute>
                                             <xsl:if test="$tmp='and'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='And']"/>
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">or</xsl:attribute>
                                             <xsl:if test="$tmp='or'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Or']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">440</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="SELECT">
                                          <xsl:attribute name="name">EmailSourceExpr2</xsl:attribute>
                                          <xsl:attribute name="id">EmailSourceExpr2</xsl:attribute>
                                          <xsl:attribute name="onchange"><xsl:text disable-output-escaping="yes"><![CDATA[ToggleCondition3();]]></xsl:text></xsl:attribute>
                                          <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/QUERYDATA/WTCONDITION[position()=2]/@expr"/></xsl:variable>
                                          <xsl:for-each select="/DATA/TXN/FIELDLIST/ENUM">
                                             <xsl:element name="OPTION">
                                                <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                                <xsl:if test="$tmp=@id"><xsl:attribute name="SELECTED"/></xsl:if>
                                                <xsl:value-of select="@name"/>
                                             </xsl:element>
                                          </xsl:for-each>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:element name="SELECT">
                                          <xsl:attribute name="name">EmailSourceOper2</xsl:attribute>
                                          <xsl:attribute name="id">EmailSourceOper2</xsl:attribute>
                                          <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/QUERYDATA/WTCONDITION[position()=2]/@oper"/></xsl:variable>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">0</xsl:attribute>
                                             <xsl:if test="$tmp='0'"><xsl:attribute name="SELECTED"/></xsl:if>
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">equal</xsl:attribute>
                                             <xsl:if test="$tmp='equal'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsEqual']"/>
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">not-equal</xsl:attribute>
                                             <xsl:if test="$tmp='not-equal'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsNotEqual']"/>
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">less</xsl:attribute>
                                             <xsl:if test="$tmp='less'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsLess']"/>
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">greater</xsl:attribute>
                                             <xsl:if test="$tmp='greater'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsGreater']"/>
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">less-equal</xsl:attribute>
                                             <xsl:if test="$tmp='less-equal'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsLessEqual']"/>
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">greater-equal</xsl:attribute>
                                             <xsl:if test="$tmp='greater-equal'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsGreaterEqual']"/>
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">starts</xsl:attribute>
                                             <xsl:if test="$tmp='starts'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Starts']"/>
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">contains</xsl:attribute>
                                             <xsl:if test="$tmp='contains'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Contains']"/>
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">not-contains</xsl:attribute>
                                             <xsl:if test="$tmp='not-contains'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NotContains']"/>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:element name="INPUT">
                                       <xsl:attribute name="type">text</xsl:attribute>
                                       <xsl:attribute name="name">EmailSourceValue2</xsl:attribute>
                                       <xsl:attribute name="id">EmailSourceValue2</xsl:attribute>
                                       <xsl:attribute name="size">15</xsl:attribute>
                                       <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/QUERYDATA/WTCONDITION[position()=2]/@value"/></xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>

                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">160</xsl:attribute>
                                       <xsl:attribute name="align">right</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="SELECT">
                                          <xsl:attribute name="name">EmailSourceConnector3</xsl:attribute>
                                          <xsl:attribute name="id">EmailSourceConnector3</xsl:attribute>
                                          <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/QUERYDATA/WTCONDITION[position()=3]/@connector"/></xsl:variable>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">0</xsl:attribute>
                                             <xsl:if test="$tmp='0'"><xsl:attribute name="SELECTED"/></xsl:if>
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">and</xsl:attribute>
                                             <xsl:if test="$tmp='and'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='And']"/>
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">or</xsl:attribute>
                                             <xsl:if test="$tmp='or'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Or']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">440</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="SELECT">
                                          <xsl:attribute name="name">EmailSourceExpr3</xsl:attribute>
                                          <xsl:attribute name="id">EmailSourceExpr3</xsl:attribute>
                                          <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/QUERYDATA/WTCONDITION[position()=3]/@expr"/></xsl:variable>
                                          <xsl:for-each select="/DATA/TXN/FIELDLIST/ENUM">
                                             <xsl:element name="OPTION">
                                                <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                                <xsl:if test="$tmp=@id"><xsl:attribute name="SELECTED"/></xsl:if>
                                                <xsl:value-of select="@name"/>
                                             </xsl:element>
                                          </xsl:for-each>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:element name="SELECT">
                                          <xsl:attribute name="name">EmailSourceOper3</xsl:attribute>
                                          <xsl:attribute name="id">EmailSourceOper3</xsl:attribute>
                                          <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/QUERYDATA/WTCONDITION[position()=3]/@oper"/></xsl:variable>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">0</xsl:attribute>
                                             <xsl:if test="$tmp='0'"><xsl:attribute name="SELECTED"/></xsl:if>
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">equal</xsl:attribute>
                                             <xsl:if test="$tmp='equal'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsEqual']"/>
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">not-equal</xsl:attribute>
                                             <xsl:if test="$tmp='not-equal'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsNotEqual']"/>
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">less</xsl:attribute>
                                             <xsl:if test="$tmp='less'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsLess']"/>
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">greater</xsl:attribute>
                                             <xsl:if test="$tmp='greater'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsGreater']"/>
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">less-equal</xsl:attribute>
                                             <xsl:if test="$tmp='less-equal'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsLessEqual']"/>
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">greater-equal</xsl:attribute>
                                             <xsl:if test="$tmp='greater-equal'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsGreaterEqual']"/>
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">starts</xsl:attribute>
                                             <xsl:if test="$tmp='starts'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Starts']"/>
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">contains</xsl:attribute>
                                             <xsl:if test="$tmp='contains'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Contains']"/>
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">not-contains</xsl:attribute>
                                             <xsl:if test="$tmp='not-contains'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NotContains']"/>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:element name="INPUT">
                                       <xsl:attribute name="type">text</xsl:attribute>
                                       <xsl:attribute name="name">EmailSourceValue3</xsl:attribute>
                                       <xsl:attribute name="id">EmailSourceValue3</xsl:attribute>
                                       <xsl:attribute name="size">15</xsl:attribute>
                                       <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/QUERYDATA/WTCONDITION[position()=3]/@value"/></xsl:attribute>
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
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='HowManyEmails']"/>
                                       <xsl:text>:</xsl:text>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">440</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="SELECT">
                                          <xsl:attribute name="name">EmailSourceInclude</xsl:attribute>
                                          <xsl:attribute name="id">EmailSourceInclude</xsl:attribute>
                                          <xsl:attribute name="onchange"><xsl:text disable-output-escaping="yes"><![CDATA[ToggleSource();]]></xsl:text></xsl:attribute>
                                          <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/QUERYDATA/WTSELECT/@include"/></xsl:variable>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">All</xsl:attribute>
                                             <xsl:if test="$tmp='All'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='All']"/>
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">Top</xsl:attribute>
                                             <xsl:if test="$tmp='Top'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='First']"/>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:element name="INPUT">
                                       <xsl:attribute name="type">text</xsl:attribute>
                                       <xsl:attribute name="name">EmailSourceQuantity</xsl:attribute>
                                       <xsl:attribute name="id">EmailSourceQuantity</xsl:attribute>
                                       <xsl:attribute name="size">15</xsl:attribute>
                                       <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/QUERYDATA/WTSELECT/@qty"/></xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>

                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">160</xsl:attribute>
                                       <xsl:attribute name="align">right</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="div">
                                          <xsl:attribute name="id">SortBy</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SortBy']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">440</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="SELECT">
                                          <xsl:attribute name="name">EmailSourceOrderBy</xsl:attribute>
                                          <xsl:attribute name="id">EmailSourceOrderBy</xsl:attribute>
                                          <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/QUERYDATA/WTORDERBY/@name"/></xsl:variable>
                                          <xsl:for-each select="/DATA/TXN/FIELDLIST/ENUM">
                                             <xsl:element name="OPTION">
                                                <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                                <xsl:if test="$tmp=@id"><xsl:attribute name="SELECTED"/></xsl:if>
                                                <xsl:value-of select="@name"/>
                                             </xsl:element>
                                          </xsl:for-each>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:element name="SELECT">
                                          <xsl:attribute name="name">EmailSourceOrder</xsl:attribute>
                                          <xsl:attribute name="id">EmailSourceOrder</xsl:attribute>
                                          <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/QUERYDATA/WTORDERBY/@order"/></xsl:variable>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">asc</xsl:attribute>
                                             <xsl:if test="$tmp='asc'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Ascending']"/>
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">desc</xsl:attribute>
                                             <xsl:if test="$tmp='desc'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Descending']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>

                              </xsl:if>
                           </xsl:if>
                        </xsl:if>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">24</xsl:attribute>
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
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">button</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Cancel']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick">doSubmit(3,"")</xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:if test="(/DATA/SYSTEM/@userstatus = 1)">
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Delete']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick">doSubmit(4,'<xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ConfirmDelete']"/>')</xsl:attribute>
                                 </xsl:element>
                              </xsl:if>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:if test="(/DATA/TXN/PTSEMAILLIST/@sourcetype = 0)">
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='UploadEmailees']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick">doSubmit(6,"")</xsl:attribute>
                                 </xsl:element>
                              </xsl:if>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">24</xsl:attribute>
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