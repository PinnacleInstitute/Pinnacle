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
         <xsl:with-param name="pagename" select="/DATA/LANGUAGE/LABEL[@name='Ads']"/>
         <xsl:with-param name="includecalendar" select="true()"/>
         <xsl:with-param name="htmleditor"></xsl:with-param>
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
               <xsl:attribute name="onload">document.getElementById('SearchText').focus()</xsl:attribute>
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
            <xsl:attribute name="width">750</xsl:attribute>
            <xsl:attribute name="align">left</xsl:attribute>

            <!--BEGIN FORM-->
            <xsl:element name="FORM">
               <xsl:attribute name="name">Ad</xsl:attribute>
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
                                          <xsl:attribute name="width">400</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">400</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">400</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:attribute name="class">PageHeading</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FindAd']"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">400</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="src">Images/addnew.gif</xsl:attribute>
                                                <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:element name="A">
                                                <xsl:attribute name="href">14303.asp?CompanyID=<xsl:value-of select="/DATA/PARAM/@companyid"/>&amp;MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewAd']"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="src">Images/AdTrack.gif</xsl:attribute>
                                                <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:element name="A">
                                                <xsl:attribute name="onclick">w=window.open(this.href,"AdTrack","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                <xsl:attribute name="href">14701.asp?CompanyID=<xsl:value-of select="/DATA/PARAM/@companyid"/></xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AdTrack']"/>
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
                              <xsl:attribute name="height">2</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">800</xsl:attribute>
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
                              <xsl:attribute name="width">800</xsl:attribute>
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
                                 <xsl:for-each select="/DATA/TXN/PTSADS/PTSFINDTYPEIDS/ENUM">
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                       <xsl:if test="@selected"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:variable name="tmp2"><xsl:value-of select="current()/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp2]"/>
                                    </xsl:element>
                                 </xsl:for-each>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SearchFor']"/>
                              <xsl:text>:</xsl:text>
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
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='View']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick">doSubmit(5,"")</xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">button</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ResetPriorities']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick">doSubmit(10,'<xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ConfirmResetAll']"/>')</xsl:attribute>
                              </xsl:element>
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
                                       <xsl:attribute name="width">10%</xsl:attribute>
                                       <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                       <xsl:attribute name="valign">Bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StartDate']"/>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="width">45%</xsl:attribute>
                                       <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                       <xsl:attribute name="valign">Bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AdName']"/>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="align">center</xsl:attribute>
                                       <xsl:attribute name="width">10%</xsl:attribute>
                                       <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                       <xsl:attribute name="valign">Bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Status']"/>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="align">center</xsl:attribute>
                                       <xsl:attribute name="width">10%</xsl:attribute>
                                       <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                       <xsl:attribute name="valign">Bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MaxPlace']"/>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="align">center</xsl:attribute>
                                       <xsl:attribute name="width">10%</xsl:attribute>
                                       <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                       <xsl:attribute name="valign">Bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Places']"/>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="align">center</xsl:attribute>
                                       <xsl:attribute name="width">10%</xsl:attribute>
                                       <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                       <xsl:attribute name="valign">Bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Clicks']"/>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="align">center</xsl:attribute>
                                       <xsl:attribute name="width">10%</xsl:attribute>
                                       <xsl:attribute name="class">ColumnTitle</xsl:attribute>
                                       <xsl:attribute name="valign">Bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ClickRate']"/>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">7</xsl:attribute>
                                       <xsl:attribute name="height">2</xsl:attribute>
                                       <xsl:attribute name="bgcolor">#CCCCCC</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>

                                 <xsl:for-each select="/DATA/TXN/PTSADS/PTSAD">
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                       <xsl:if test="(position() mod 2)=1">
                                          <xsl:attribute name="class">GrayBar</xsl:attribute>
                                       </xsl:if>
                                       <xsl:if test="(position() mod 2)=0">
                                          <xsl:attribute name="class">WhiteBar</xsl:attribute>
                                       </xsl:if>
                                          <xsl:attribute name="colspan">2</xsl:attribute>
                                          <xsl:attribute name="height">6</xsl:attribute>
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
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="@startdate"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:if test="(@status &lt;= 1)">
                                                <xsl:element name="font">
                                                   <xsl:attribute name="color">green</xsl:attribute>
                                                <xsl:value-of select="@adname"/>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:if test="(@status = 2)">
                                                <xsl:value-of select="@adname"/>
                                             </xsl:if>
                                             <xsl:if test="(@status = 3)">
                                                <xsl:element name="font">
                                                   <xsl:attribute name="color">red</xsl:attribute>
                                                <xsl:value-of select="@adname"/>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:element name="A">
                                                <xsl:attribute name="href">14303.asp?AdID=<xsl:value-of select="@adid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/Edit.gif</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:element name="font">
                                                <xsl:attribute name="color">blue</xsl:attribute>
                                             <xsl:value-of select="@adid"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:element name="A">
                                                <xsl:attribute name="href">14301.asp?CompanyID=<xsl:value-of select="/DATA/PARAM/@companyid"/>&amp;MemberID=<xsl:value-of select="/DATA/PARAM/@memberid"/>&amp;CopyID=<xsl:value-of select="@adid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/copy.gif</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='copyAd']"/></xsl:attribute>
                                                   <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='copyAd']"/></xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:variable name="tmp3"><xsl:value-of select="../PTSSTATUSS/ENUM[@id=current()/@status]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp3]"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="@maxplace"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="@places"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="@clicks"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="align">center</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="@clickrate"/>
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
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">6</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="font">
                                             <xsl:attribute name="color">purple</xsl:attribute>
                                             <xsl:if test="(/DATA/PARAM/@memberid = 0) and (@membername != '')">
                                                <xsl:element name="font">
                                                   <xsl:attribute name="color">gray</xsl:attribute>
                                                <xsl:value-of select="@membername"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                const(-)
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                </xsl:element>
                                             </xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Place']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:if test="(@placement = 0)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AnyPage']"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:if>
                                             <xsl:if test="(@placement = 1)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MainPage']"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:if>
                                          <xsl:if test="(@placement = 2)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CategoryPage']"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="@refid"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:if>
                                             <xsl:if test="(@placement = 4)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Email']"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Position']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:value-of select="@priority"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:if test="(@rotation != '')">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Rotation']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:value-of select="@rotation"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:if>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Order']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:value-of select="@porder"/>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Weight']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:value-of select="@weight"/>
                                          </xsl:element>
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
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="@enddate"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="colspan">6</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="font">
                                             <xsl:attribute name="color">gray</xsl:attribute>
                                          <xsl:if test="(@zip != '') or (@city != '') or (@mta != '') or (@state != '')">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Location']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="@zip"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="@city"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="@mta"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="@state"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:if>
                                          <xsl:if test="(@startage != 0) or (@endage != 0)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StartAge']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="@startage"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='EndAge']"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="@endage"/>
                                          </xsl:if>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:for-each>
                                 <xsl:choose>
                                    <xsl:when test="(count(/DATA/TXN/PTSADS/PTSAD) = 0)">
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">7</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="class">NoItems</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoItems']"/>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:when>
                                 </xsl:choose>

                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">7</xsl:attribute>
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

      </xsl:element>
      </xsl:element>
      <!--END BODY-->

      </xsl:element>

   </xsl:template>
</xsl:stylesheet>