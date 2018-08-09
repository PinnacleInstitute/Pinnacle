<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
   <xsl:include href="HTMLHeading.xsl"/>
   <xsl:include href="Bookmark.xsl"/>
   <xsl:include href="Include\wtMenu.xsl"/>
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
         <xsl:with-param name="pagename" select="'Menu Colors'"/>
         <xsl:with-param name="includecalendar" select="true()"/>
         <xsl:with-param name="htmleditor"></xsl:with-param>
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
         <xsl:attribute name="src">Include/jscolor.js</xsl:attribute>
         <xsl:text> </xsl:text>
      </xsl:element>

      <xsl:call-template name="DefineMenu"/>

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
               <xsl:attribute name="name">Moption</xsl:attribute>
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
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor"><xsl:value-of select="/DATA/PARAM/@menubehindcolor"/></xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:attribute name="height">36</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="bgcolor"><xsl:value-of select="/DATA/PARAM/@menubehindcolor"/></xsl:attribute>
                              <xsl:attribute name="background">Imagesb/<xsl:value-of select="/DATA/PARAM/@menubehindimage"/></xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">top</xsl:attribute>
<xsl:element name="SCRIPT">
   <xsl:attribute name="language">JavaScript</xsl:attribute>
   var TestMenu = new CMenu(TestMenuDef, 'TestMenu'); TestMenu.create();
</xsl:element>

                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor"><xsl:value-of select="/DATA/PARAM/@menubehindcolor"/></xsl:attribute>
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
                                       <xsl:attribute name="width">100</xsl:attribute>
                                       <xsl:attribute name="class">InputHeading</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Text']"/>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">100</xsl:attribute>
                                       <xsl:attribute name="class">InputHeading</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Background']"/>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">240</xsl:attribute>
                                       <xsl:attribute name="class">InputHeading</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Texture']"/>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">160</xsl:attribute>
                                       <xsl:attribute name="align">right</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TopMenu']"/>
                                       <xsl:text>:</xsl:text>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">100</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="INPUT">
                                       <xsl:attribute name="class">color</xsl:attribute>
                                       <xsl:attribute name="type">text</xsl:attribute>
                                       <xsl:attribute name="name">MenuTopColor</xsl:attribute>
                                       <xsl:attribute name="id">MenuTopColor</xsl:attribute>
                                       <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@menutopcolor"/></xsl:attribute>
                                       <xsl:attribute name="size">10</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">100</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="INPUT">
                                       <xsl:attribute name="class">color</xsl:attribute>
                                       <xsl:attribute name="type">text</xsl:attribute>
                                       <xsl:attribute name="name">MenuTopBGColor</xsl:attribute>
                                       <xsl:attribute name="id">MenuTopBGColor</xsl:attribute>
                                       <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@menutopbgcolor"/></xsl:attribute>
                                       <xsl:attribute name="size">10</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">240</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="SELECT">
                                          <xsl:attribute name="name">MenuTopImage</xsl:attribute>
                                          <xsl:attribute name="id">MenuTopImage</xsl:attribute>
                                          <xsl:variable name="tmp"><xsl:value-of select="/DATA/PARAM/@menutopimage"/></xsl:variable>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value"></xsl:attribute>
                                             <xsl:if test="$tmp=''"><xsl:attribute name="SELECTED"/></xsl:if>
                                             
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">circles.png</xsl:attribute>
                                             <xsl:if test="$tmp='circles.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             Circles.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">crossed_stripes.png</xsl:attribute>
                                             <xsl:if test="$tmp='crossed_stripes.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             crossed_stripes.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">crosses.png</xsl:attribute>
                                             <xsl:if test="$tmp='crosses.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             crosses.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">dark_circles.png</xsl:attribute>
                                             <xsl:if test="$tmp='dark_circles.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             dark_circles.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">dark_matter.png</xsl:attribute>
                                             <xsl:if test="$tmp='dark_matter.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             dark_matter.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">diamonds.png</xsl:attribute>
                                             <xsl:if test="$tmp='diamonds.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             diamonds.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">foil.png</xsl:attribute>
                                             <xsl:if test="$tmp='foil.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             foil.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">gun_metal.png</xsl:attribute>
                                             <xsl:if test="$tmp='gun_metal.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             gun_metal.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">knitted-netting.png</xsl:attribute>
                                             <xsl:if test="$tmp='knitted-netting.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             knitted_netting.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">littleknobs.png</xsl:attribute>
                                             <xsl:if test="$tmp='littleknobs.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             littleknobs.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">merely_cubed.png</xsl:attribute>
                                             <xsl:if test="$tmp='merely_cubed.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             merely_cubed.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">micro_carbon.png</xsl:attribute>
                                             <xsl:if test="$tmp='micro_carbon.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             micro_carbon.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">small-crackle.png</xsl:attribute>
                                             <xsl:if test="$tmp='small-crackle.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             small_crackle.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">soft_pad.png</xsl:attribute>
                                             <xsl:if test="$tmp='soft_pad.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             soft_pad.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">white_carbon.png</xsl:attribute>
                                             <xsl:if test="$tmp='white_carbon.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             white_carbon.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">zigzag.png</xsl:attribute>
                                             <xsl:if test="$tmp='zigzag.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             zigzag.png
                                          </xsl:element>
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
                                       <xsl:attribute name="width">100</xsl:attribute>
                                       <xsl:attribute name="class">InputHeading</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Text']"/>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">100</xsl:attribute>
                                       <xsl:attribute name="class">InputHeading</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Background']"/>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">240</xsl:attribute>
                                       <xsl:attribute name="class">InputHeading</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Texture']"/>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">160</xsl:attribute>
                                       <xsl:attribute name="align">right</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SubMenu']"/>
                                       <xsl:text>:</xsl:text>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">100</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="INPUT">
                                       <xsl:attribute name="class">color</xsl:attribute>
                                       <xsl:attribute name="type">text</xsl:attribute>
                                       <xsl:attribute name="name">MenuColor</xsl:attribute>
                                       <xsl:attribute name="id">MenuColor</xsl:attribute>
                                       <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@menucolor"/></xsl:attribute>
                                       <xsl:attribute name="size">10</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">100</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="INPUT">
                                       <xsl:attribute name="class">color</xsl:attribute>
                                       <xsl:attribute name="type">text</xsl:attribute>
                                       <xsl:attribute name="name">MenuBGColor</xsl:attribute>
                                       <xsl:attribute name="id">MenuBGColor</xsl:attribute>
                                       <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@menubgcolor"/></xsl:attribute>
                                       <xsl:attribute name="size">10</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">240</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="SELECT">
                                          <xsl:attribute name="name">MenuImage</xsl:attribute>
                                          <xsl:attribute name="id">MenuImage</xsl:attribute>
                                          <xsl:variable name="tmp"><xsl:value-of select="/DATA/PARAM/@menuimage"/></xsl:variable>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value"></xsl:attribute>
                                             <xsl:if test="$tmp=''"><xsl:attribute name="SELECTED"/></xsl:if>
                                             
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">circles.png</xsl:attribute>
                                             <xsl:if test="$tmp='circles.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             Circles.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">crossed_stripes.png</xsl:attribute>
                                             <xsl:if test="$tmp='crossed_stripes.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             crossed_stripes.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">crosses.png</xsl:attribute>
                                             <xsl:if test="$tmp='crosses.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             crosses.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">dark_circles.png</xsl:attribute>
                                             <xsl:if test="$tmp='dark_circles.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             dark_circles.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">dark_matter.png</xsl:attribute>
                                             <xsl:if test="$tmp='dark_matter.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             dark_matter.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">diamonds.png</xsl:attribute>
                                             <xsl:if test="$tmp='diamonds.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             diamonds.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">foil.png</xsl:attribute>
                                             <xsl:if test="$tmp='foil.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             foil.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">gun_metal.png</xsl:attribute>
                                             <xsl:if test="$tmp='gun_metal.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             gun_metal.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">knitted-netting.png</xsl:attribute>
                                             <xsl:if test="$tmp='knitted-netting.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             knitted_netting.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">littleknobs.png</xsl:attribute>
                                             <xsl:if test="$tmp='littleknobs.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             littleknobs.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">merely_cubed.png</xsl:attribute>
                                             <xsl:if test="$tmp='merely_cubed.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             merely_cubed.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">micro_carbon.png</xsl:attribute>
                                             <xsl:if test="$tmp='micro_carbon.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             micro_carbon.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">small-crackle.png</xsl:attribute>
                                             <xsl:if test="$tmp='small-crackle.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             small_crackle.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">soft_pad.png</xsl:attribute>
                                             <xsl:if test="$tmp='soft_pad.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             soft_pad.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">white_carbon.png</xsl:attribute>
                                             <xsl:if test="$tmp='white_carbon.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             white_carbon.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">zigzag.png</xsl:attribute>
                                             <xsl:if test="$tmp='zigzag.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             zigzag.png
                                          </xsl:element>
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
                                       <xsl:attribute name="width">100</xsl:attribute>
                                       <xsl:attribute name="class">InputHeading</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Text']"/>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">340</xsl:attribute>
                                       <xsl:attribute name="class">InputHeading</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Background']"/>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">160</xsl:attribute>
                                       <xsl:attribute name="align">right</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MouseOver']"/>
                                       <xsl:text>:</xsl:text>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">100</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="INPUT">
                                       <xsl:attribute name="class">color</xsl:attribute>
                                       <xsl:attribute name="type">text</xsl:attribute>
                                       <xsl:attribute name="name">MenuOverColor</xsl:attribute>
                                       <xsl:attribute name="id">MenuOverColor</xsl:attribute>
                                       <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@menuovercolor"/></xsl:attribute>
                                       <xsl:attribute name="size">10</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">340</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="INPUT">
                                       <xsl:attribute name="class">color</xsl:attribute>
                                       <xsl:attribute name="type">text</xsl:attribute>
                                       <xsl:attribute name="name">MenuOverBGColor</xsl:attribute>
                                       <xsl:attribute name="id">MenuOverBGColor</xsl:attribute>
                                       <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@menuoverbgcolor"/></xsl:attribute>
                                       <xsl:attribute name="size">10</xsl:attribute>
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
                                       <xsl:attribute name="width">100</xsl:attribute>
                                       <xsl:attribute name="class">InputHeading</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Border']"/>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">340</xsl:attribute>
                                       <xsl:attribute name="class">InputHeading</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Divider']"/>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">160</xsl:attribute>
                                       <xsl:attribute name="align">right</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MenuLines']"/>
                                       <xsl:text>:</xsl:text>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">100</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="INPUT">
                                       <xsl:attribute name="class">color</xsl:attribute>
                                       <xsl:attribute name="type">text</xsl:attribute>
                                       <xsl:attribute name="name">MenuBDColor</xsl:attribute>
                                       <xsl:attribute name="id">MenuBDColor</xsl:attribute>
                                       <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@menubdcolor"/></xsl:attribute>
                                       <xsl:attribute name="size">10</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">340</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="INPUT">
                                       <xsl:attribute name="class">color</xsl:attribute>
                                       <xsl:attribute name="type">text</xsl:attribute>
                                       <xsl:attribute name="name">MenuDividerColor</xsl:attribute>
                                       <xsl:attribute name="id">MenuDividerColor</xsl:attribute>
                                       <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@menudividercolor"/></xsl:attribute>
                                       <xsl:attribute name="size">10</xsl:attribute>
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
                                       <xsl:attribute name="width">100</xsl:attribute>
                                       <xsl:attribute name="class">InputHeading</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Shadow']"/>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">100</xsl:attribute>
                                       <xsl:attribute name="class">InputHeading</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Behind']"/>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">240</xsl:attribute>
                                       <xsl:attribute name="class">InputHeading</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">bottom</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Texture']"/>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">160</xsl:attribute>
                                       <xsl:attribute name="align">right</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Highlights']"/>
                                       <xsl:text>:</xsl:text>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">100</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="INPUT">
                                       <xsl:attribute name="class">color</xsl:attribute>
                                       <xsl:attribute name="type">text</xsl:attribute>
                                       <xsl:attribute name="name">MenuShadowColor</xsl:attribute>
                                       <xsl:attribute name="id">MenuShadowColor</xsl:attribute>
                                       <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@menushadowcolor"/></xsl:attribute>
                                       <xsl:attribute name="size">10</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">100</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="INPUT">
                                       <xsl:attribute name="class">color</xsl:attribute>
                                       <xsl:attribute name="type">text</xsl:attribute>
                                       <xsl:attribute name="name">MenuBehindColor</xsl:attribute>
                                       <xsl:attribute name="id">MenuBehindColor</xsl:attribute>
                                       <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@menubehindcolor"/></xsl:attribute>
                                       <xsl:attribute name="size">10</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">240</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="SELECT">
                                          <xsl:attribute name="name">MenuBehindImage</xsl:attribute>
                                          <xsl:attribute name="id">MenuBehindImage</xsl:attribute>
                                          <xsl:variable name="tmp"><xsl:value-of select="/DATA/PARAM/@menubehindimage"/></xsl:variable>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value"></xsl:attribute>
                                             <xsl:if test="$tmp=''"><xsl:attribute name="SELECTED"/></xsl:if>
                                             
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">circles.png</xsl:attribute>
                                             <xsl:if test="$tmp='circles.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             Circles.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">crossed_stripes.png</xsl:attribute>
                                             <xsl:if test="$tmp='crossed_stripes.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             crossed_stripes.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">crosses.png</xsl:attribute>
                                             <xsl:if test="$tmp='crosses.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             crosses.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">dark_circles.png</xsl:attribute>
                                             <xsl:if test="$tmp='dark_circles.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             dark_circles.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">dark_matter.png</xsl:attribute>
                                             <xsl:if test="$tmp='dark_matter.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             dark_matter.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">diamonds.png</xsl:attribute>
                                             <xsl:if test="$tmp='diamonds.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             diamonds.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">foil.png</xsl:attribute>
                                             <xsl:if test="$tmp='foil.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             foil.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">gun_metal.png</xsl:attribute>
                                             <xsl:if test="$tmp='gun_metal.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             gun_metal.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">knitted-netting.png</xsl:attribute>
                                             <xsl:if test="$tmp='knitted-netting.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             knitted_netting.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">littleknobs.png</xsl:attribute>
                                             <xsl:if test="$tmp='littleknobs.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             littleknobs.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">merely_cubed.png</xsl:attribute>
                                             <xsl:if test="$tmp='merely_cubed.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             merely_cubed.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">micro_carbon.png</xsl:attribute>
                                             <xsl:if test="$tmp='micro_carbon.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             micro_carbon.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">small-crackle.png</xsl:attribute>
                                             <xsl:if test="$tmp='small-crackle.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             small_crackle.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">soft_pad.png</xsl:attribute>
                                             <xsl:if test="$tmp='soft_pad.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             soft_pad.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">white_carbon.png</xsl:attribute>
                                             <xsl:if test="$tmp='white_carbon.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             white_carbon.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">zigzag.png</xsl:attribute>
                                             <xsl:if test="$tmp='zigzag.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             zigzag.png
                                          </xsl:element>
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">paven.png</xsl:attribute>
                                             <xsl:if test="$tmp='paven.png'"><xsl:attribute name="SELECTED"/></xsl:if>
                                             paven.png
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>
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
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">button</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Preview']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick">doSubmit(3,"")</xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">button</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Update']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick">doSubmit(1,"")</xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">button</xsl:attribute>
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Defaults']"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="onclick">doSubmit(2,"")</xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:if test="(/DATA/PARAM/@updated = 1)">
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Apply']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[window.parent.doSubmit(0,"");]]></xsl:text></xsl:attribute>
                                 </xsl:element>
                              </xsl:if>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:if test="(/DATA/PARAM/@updated = 1)">
                                 <xsl:element name="b">
                                 <xsl:element name="font">
                                    <xsl:attribute name="color">red</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Updated']"/>
                                 </xsl:element>
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

<xsl:element name="SCRIPT">
   <xsl:attribute name="language">JavaScript</xsl:attribute>
   <xsl:text disable-output-escaping="yes"><![CDATA[
   TestMenu.run();
   ]]></xsl:text>
</xsl:element>

      </xsl:element>
      </xsl:element>
      <!--END BODY-->

      </xsl:element>

   </xsl:template>
</xsl:stylesheet>