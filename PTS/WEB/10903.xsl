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
         <xsl:with-param name="pagename" select="'Govid'"/>
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
                     <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[ShowType()]]></xsl:text>;doErrorMsg('<xsl:value-of select="concat($errmsg, $errmsgfld)"/>')</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[ShowType()]]></xsl:text>;doErrorMsg('<xsl:value-of select="/DATA/ERROR"/>')</xsl:attribute>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
               <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[ShowType()]]></xsl:text></xsl:attribute>
            </xsl:otherwise>
         </xsl:choose>

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
               <xsl:attribute name="name">Govid</xsl:attribute>
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
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ShowType(){ 
               var typ = document.getElementById('GType').value;
               var disp = 'none';
               if( typ > 3 ) disp = '';
               document.getElementById('Date1').style.display = disp;
               document.getElementById('Date2').style.display = disp;
               if( typ == 1 || typ == 2 ) {
                  document.getElementById('Issue').style.display = 'none';
               }
               else {
                  document.getElementById('Issue').style.display = '';
               }   
               if( typ == 5 || typ == 10 ) {
                  document.getElementById('State').style.display = '';
                  document.getElementById('CountryID').style.display = 'none';
               }
               else {
                  document.getElementById('State').style.display = 'none';
                  document.getElementById('CountryID').style.display = '';
               }   
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
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:if test="(/DATA/PARAM/@govidid != 0)">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Govid']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:variable name="tmp1"><xsl:value-of select="/DATA/TXN/PTSGOVID/PTSGTYPES/ENUM[@id=/DATA/TXN/PTSGOVID/@gtype]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp1]"/>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/PARAM/@govidid = 0)">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewGovid']"/>
                                 </xsl:if>
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
                              <xsl:attribute name="height">6</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">160</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GType']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="SELECT">
                                 <xsl:attribute name="name">GType</xsl:attribute>
                                 <xsl:attribute name="id">GType</xsl:attribute>
                                 <xsl:attribute name="onchange"><xsl:text disable-output-escaping="yes"><![CDATA[ShowType()]]></xsl:text></xsl:attribute>
                                 <xsl:for-each select="/DATA/TXN/PTSGOVID/PTSGTYPES/ENUM">
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                       <xsl:if test="@selected"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:variable name="tmp1"><xsl:value-of select="current()/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp1]"/>
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
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GNumber']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">GNumber</xsl:attribute>
                              <xsl:attribute name="id">GNumber</xsl:attribute>
                              <xsl:attribute name="size">40</xsl:attribute>
                              <xsl:attribute name="maxlength">50</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSGOVID/@gnumber"/></xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:attribute name="id">Issue</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">160</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Issuer']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="SELECT">
                                 <xsl:attribute name="name">CountryID</xsl:attribute>
                                 <xsl:attribute name="id">CountryID</xsl:attribute>
                                 <xsl:variable name="tmp"><xsl:value-of select="/DATA/PARAM/@countryid"/></xsl:variable>
                                 <xsl:for-each select="/DATA/TXN/PTSCOUNTRYS/ENUM">
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                       <xsl:if test="$tmp=@id"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="@name"/>
                                    </xsl:element>
                                 </xsl:for-each>
                              </xsl:element>
                              <xsl:element name="SELECT">
                                 <xsl:attribute name="name">State</xsl:attribute>
                                 <xsl:attribute name="id">State</xsl:attribute>
                                 <xsl:variable name="tmp"><xsl:value-of select="/DATA/PARAM/@state"/></xsl:variable>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value"></xsl:attribute>
                                    <xsl:if test="$tmp=''"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Select']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">AL</xsl:attribute>
                                    <xsl:if test="$tmp='AL'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Alabama']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">AK</xsl:attribute>
                                    <xsl:if test="$tmp='AK'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Alaska']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">AZ</xsl:attribute>
                                    <xsl:if test="$tmp='AZ'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Arizona']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">AR</xsl:attribute>
                                    <xsl:if test="$tmp='AR'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Arkansas']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">CA</xsl:attribute>
                                    <xsl:if test="$tmp='CA'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='California']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">CO</xsl:attribute>
                                    <xsl:if test="$tmp='CO'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Colorado']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">CT</xsl:attribute>
                                    <xsl:if test="$tmp='CT'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Conneticut']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">DE</xsl:attribute>
                                    <xsl:if test="$tmp='DE'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Delaware']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">FL</xsl:attribute>
                                    <xsl:if test="$tmp='FL'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Florida']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">GA</xsl:attribute>
                                    <xsl:if test="$tmp='GA'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Georgia']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">HI</xsl:attribute>
                                    <xsl:if test="$tmp='HI'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Hawaii']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">ID</xsl:attribute>
                                    <xsl:if test="$tmp='ID'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Idaho']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">IL</xsl:attribute>
                                    <xsl:if test="$tmp='IL'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Illinois']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">IN</xsl:attribute>
                                    <xsl:if test="$tmp='IN'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Indiana']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">IA</xsl:attribute>
                                    <xsl:if test="$tmp='IA'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Iowa']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">KS</xsl:attribute>
                                    <xsl:if test="$tmp='KS'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Kansas']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">KY</xsl:attribute>
                                    <xsl:if test="$tmp='KY'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Kentucky']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">LA</xsl:attribute>
                                    <xsl:if test="$tmp='LA'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Louisiana']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">ME</xsl:attribute>
                                    <xsl:if test="$tmp='ME'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Maine']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">MD</xsl:attribute>
                                    <xsl:if test="$tmp='MD'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Maryland']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">MA</xsl:attribute>
                                    <xsl:if test="$tmp='MA'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Massachusetts']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">MI</xsl:attribute>
                                    <xsl:if test="$tmp='MI'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Michigan']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">MN</xsl:attribute>
                                    <xsl:if test="$tmp='MN'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Minnesota']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">MS</xsl:attribute>
                                    <xsl:if test="$tmp='MS'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Mississippi']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">MO</xsl:attribute>
                                    <xsl:if test="$tmp='MO'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Missouri']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">MT</xsl:attribute>
                                    <xsl:if test="$tmp='MT'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Montana']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">NE</xsl:attribute>
                                    <xsl:if test="$tmp='NE'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Nebraska']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">NV</xsl:attribute>
                                    <xsl:if test="$tmp='NV'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Nevada']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">NH</xsl:attribute>
                                    <xsl:if test="$tmp='NH'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='New Hampshire']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">NJ</xsl:attribute>
                                    <xsl:if test="$tmp='NJ'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='New Jersey']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">NM</xsl:attribute>
                                    <xsl:if test="$tmp='NM'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='New Mexico']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">NY</xsl:attribute>
                                    <xsl:if test="$tmp='NY'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='New York']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">NC</xsl:attribute>
                                    <xsl:if test="$tmp='NC'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='North Carolina']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">ND</xsl:attribute>
                                    <xsl:if test="$tmp='ND'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='North Dakota']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">OH</xsl:attribute>
                                    <xsl:if test="$tmp='OH'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Ohio']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">OK</xsl:attribute>
                                    <xsl:if test="$tmp='OK'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Oklahoma']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">OR</xsl:attribute>
                                    <xsl:if test="$tmp='OR'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Oregon']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">PA</xsl:attribute>
                                    <xsl:if test="$tmp='PA'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Pennsylvania']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">RI</xsl:attribute>
                                    <xsl:if test="$tmp='RI'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Rhode Island']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">SC</xsl:attribute>
                                    <xsl:if test="$tmp='SC'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='South Carolina']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">SD</xsl:attribute>
                                    <xsl:if test="$tmp='SD'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='South Dakota']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">TN</xsl:attribute>
                                    <xsl:if test="$tmp='TN'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Tennessee']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">TX</xsl:attribute>
                                    <xsl:if test="$tmp='TX'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Texas']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">UT</xsl:attribute>
                                    <xsl:if test="$tmp='UT'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Utah']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">VT</xsl:attribute>
                                    <xsl:if test="$tmp='VT'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Vermont']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">VA</xsl:attribute>
                                    <xsl:if test="$tmp='VA'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Virginia']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">WA</xsl:attribute>
                                    <xsl:if test="$tmp='WA'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Washington']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">WD</xsl:attribute>
                                    <xsl:if test="$tmp='WD'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Washington DC']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">WV</xsl:attribute>
                                    <xsl:if test="$tmp='WV'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='West Virginia']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">WI</xsl:attribute>
                                    <xsl:if test="$tmp='WI'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Wisconsin']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">WY</xsl:attribute>
                                    <xsl:if test="$tmp='WY'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Wyoming']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">AS</xsl:attribute>
                                    <xsl:if test="$tmp='AS'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='American Samoa']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">GU</xsl:attribute>
                                    <xsl:if test="$tmp='GU'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Guam']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">MP</xsl:attribute>
                                    <xsl:if test="$tmp='MP'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Northern Mariana Islands']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">PR</xsl:attribute>
                                    <xsl:if test="$tmp='PR'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Puerto Rico']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">VI</xsl:attribute>
                                    <xsl:if test="$tmp='VI'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Virgin Islands']"/>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:attribute name="id">Date1</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">160</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IssueDate']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">IssueDate</xsl:attribute>
                              <xsl:attribute name="id">IssueDate</xsl:attribute>
                              <xsl:attribute name="size">10</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSGOVID/@issuedate"/></xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="IMG">
                                 <xsl:attribute name="name">Calendar</xsl:attribute>
                                 <xsl:attribute name="src">Images/Calendar.gif</xsl:attribute>
                                 <xsl:attribute name="width">16</xsl:attribute>
                                 <xsl:attribute name="height">16</xsl:attribute>
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="onclick">CalendarPopup(document.forms[0], document.getElementById('IssueDate'))</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:attribute name="id">Date2</xsl:attribute>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">160</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ExpDate']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">ExpDate</xsl:attribute>
                              <xsl:attribute name="id">ExpDate</xsl:attribute>
                              <xsl:attribute name="size">10</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSGOVID/@expdate"/></xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="IMG">
                                 <xsl:attribute name="name">Calendar</xsl:attribute>
                                 <xsl:attribute name="src">Images/Calendar.gif</xsl:attribute>
                                 <xsl:attribute name="width">16</xsl:attribute>
                                 <xsl:attribute name="height">16</xsl:attribute>
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="onclick">CalendarPopup(document.forms[0], document.getElementById('ExpDate'))</xsl:attribute>
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
                              <xsl:if test="(/DATA/SYSTEM/@userstatus = 1) and (/DATA/PARAM/@govidid = 0)">
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Add']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick">doSubmit(1,"")</xsl:attribute>
                                 </xsl:element>
                              </xsl:if>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:if test="(/DATA/SYSTEM/@userstatus = 1) and (/DATA/PARAM/@govidid != 0)">
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
                              <xsl:if test="(/DATA/SYSTEM/@userstatus = 1) and (/DATA/PARAM/@govidid != 0)">
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
                              <xsl:attribute name="height">18</xsl:attribute>
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