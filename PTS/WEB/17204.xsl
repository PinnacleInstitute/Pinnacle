<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
   <xsl:include href="HTMLHeading.xsl"/>
   <xsl:include href="CustomFields.xsl"/>
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
         <xsl:with-param name="pagename" select="/DATA/LANGUAGE/LABEL[@name='BarterAd']"/>
         <xsl:with-param name="includecalendar" select="true()"/>
         <xsl:with-param name="htmleditor"></xsl:with-param>
      </xsl:call-template>

      <xsl:element name="SCRIPT">
         <xsl:attribute name="type">text/javascript</xsl:attribute>
         <xsl:attribute name="src">https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js</xsl:attribute>
         <xsl:text> </xsl:text>
      </xsl:element>

      <xsl:element name="SCRIPT">
         <xsl:attribute name="type">text/javascript</xsl:attribute>
         <xsl:attribute name="src">include/basicslide/bjqs-1.3.min.js</xsl:attribute>
         <xsl:text> </xsl:text>
      </xsl:element>

      <xsl:element name="LINK">
         <xsl:attribute name="rel">stylesheet</xsl:attribute>
         <xsl:attribute name="type">text/css</xsl:attribute>
         <xsl:attribute name="href">include/basicslide/bjqs.css</xsl:attribute>
         <xsl:attribute name="media">all</xsl:attribute>
      </xsl:element>

      <xsl:element name="SCRIPT">
         <xsl:attribute name="language">JavaScript</xsl:attribute>
         <xsl:text disable-output-escaping="yes"><![CDATA[
            $(function() {
               $("#BARTERIMAGE").bjqs({
                  width:600,
                  height:450,
                  animduration:500,
                  animspeed:3000,
                  showcontrols:true,
                  nexttext:"<font size='5'>></font>",
                  prevtext:"<font size='5'><</font>",
                  showmarkers:true
               });
            });
         ]]></xsl:text>
      </xsl:element>

      <xsl:element name="SCRIPT">
         <xsl:attribute name="type">text/javascript</xsl:attribute>
         <xsl:attribute name="src">include/leaflet.js</xsl:attribute>
         <xsl:text> </xsl:text>
      </xsl:element>

      <xsl:element name="LINK">
         <xsl:attribute name="rel">stylesheet</xsl:attribute>
         <xsl:attribute name="type">text/css</xsl:attribute>
         <xsl:attribute name="href">include/leaflet.css</xsl:attribute>
      </xsl:element>

      <xsl:element name="SCRIPT">
         <xsl:attribute name="type">text/javascript</xsl:attribute>
         <xsl:attribute name="src">include/control.FullScreen.js</xsl:attribute>
         <xsl:text> </xsl:text>
      </xsl:element>

      <xsl:element name="LINK">
         <xsl:attribute name="rel">stylesheet</xsl:attribute>
         <xsl:attribute name="type">text/css</xsl:attribute>
         <xsl:attribute name="href">include/control.FullScreen.css</xsl:attribute>
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
         <xsl:attribute name="id">wrapper1000</xsl:attribute>
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
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ShowContact(){ 
          if( document.getElementById('ContactRow').style.display == 'none' ) {
            document.getElementById('ContactRow').style.display = '';
          }
          else {
            document.getElementById('ContactRow').style.display = 'none';
          }
         }]]></xsl:text>
               </xsl:element>

               <xsl:element name="TR">

                  <xsl:element name="TD">
                     <xsl:attribute name="width">10</xsl:attribute>
                  </xsl:element>

                  <xsl:element name="TD">
                     <xsl:attribute name="valign">top</xsl:attribute>
                     <xsl:attribute name="width">1000</xsl:attribute>

                     <xsl:element name="TABLE">
                        <xsl:attribute name="border">0</xsl:attribute>
                        <xsl:attribute name="cellpadding">0</xsl:attribute>
                        <xsl:attribute name="cellspacing">0</xsl:attribute>
                        <xsl:attribute name="width">1000</xsl:attribute>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">1000</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">1000</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">top</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">1000</xsl:attribute>
                                 <xsl:attribute name="style">background-color: #fcfde5;</xsl:attribute>
                                 <xsl:attribute name="class">box-gray</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">1000</xsl:attribute>
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
                                          <xsl:attribute name="width">1000</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="INPUT">
                                                <xsl:attribute name="type">button</xsl:attribute>
                                                <xsl:attribute name="value">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Reply']"/>
                                                </xsl:attribute>
                                                <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[ShowContact()]]></xsl:text></xsl:attribute>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="font">
                                                <xsl:attribute name="size">3</xsl:attribute>
                                             <xsl:value-of select="/DATA/PARAM/@areacategory" disable-output-escaping="yes"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
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

                                    <xsl:element name="TR">
                                       <xsl:attribute name="id">ContactRow</xsl:attribute>
                                       <xsl:attribute name="style">display:none</xsl:attribute>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">1000</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="font">
                                             <xsl:attribute name="size">3</xsl:attribute>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/TXN/PTSBARTERAD/@contactname"/>
                                          <xsl:if test="(/DATA/TXN/PTSBARTERAD/@isemail = 1)">
                                                <xsl:element name="BR"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Email']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="onclick">w=window.open(this.href,"_blank","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                   <xsl:attribute name="href">mailto:<xsl:value-of select="/DATA/TXN/PTSBARTERAD/@contactemail"/></xsl:attribute>
                                                <xsl:value-of select="/DATA/TXN/PTSBARTERAD/@contactemail"/>
                                                </xsl:element>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/TXN/PTSBARTERAD/@isphone = 1)">
                                                <xsl:element name="BR"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Phone']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/TXN/PTSBARTERAD/@contactphone"/>
                                             <xsl:if test="(/DATA/TXN/PTSBARTERAD/@istext = 1)">
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:element name="b">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TextMe']"/>
                                                   </xsl:element>
                                             </xsl:if>
                                          </xsl:if>
                                             <xsl:element name="BR"/><xsl:element name="BR"/>
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
                           <xsl:element name="TD">
                              <xsl:attribute name="width">1000</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="font">
                                    <xsl:attribute name="size">5</xsl:attribute>
                                    <xsl:value-of select="/DATA/TXN/PTSBARTERAD/@title"/>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    -
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:if test="(/DATA/PARAM/@noprice = 0)">
                                       <xsl:value-of select="/DATA/TXN/PTSBARTERAD/@price"/>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 </xsl:if>
                                 </xsl:element>
                                 <xsl:element name="font">
                                    <xsl:attribute name="size">3</xsl:attribute>
                                    <xsl:value-of select="/DATA/PARAM/@location" disable-output-escaping="yes"/>
                                 </xsl:element>
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
                              <xsl:attribute name="width">1000</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">1000</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">400</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">600</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                          <xsl:if test="(/DATA/TXN/PTSBARTERAD/@images != 0)">
                                             <xsl:element name="DIV">
                                                <xsl:attribute name="style">margin-bottom:5px;</xsl:attribute>
                                             <xsl:element name="div">
                                                <xsl:attribute name="id">BARTERIMAGE</xsl:attribute>
                                                <xsl:element name="ul">
                                                   <xsl:attribute name="class">bjqs</xsl:attribute>
                                                   <xsl:for-each select="/DATA/TXN/PTSBARTERIMAGES/PTSBARTERIMAGE[@ext!='']">
                                                      <xsl:element name="li">
                                                      <xsl:if test="(@title != 'x')">
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/barter/<xsl:value-of select="concat(@barterimageid,'l.',@ext)"/></xsl:attribute>
                                                            <xsl:attribute name="width">600</xsl:attribute>
                                                            <xsl:attribute name="height">450</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="title"><xsl:value-of select="@title"/></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:if>
                                                      <xsl:if test="(@title = 'x')">
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/barter/<xsl:value-of select="concat(@barterimageid,'l.',@ext)"/></xsl:attribute>
                                                            <xsl:attribute name="width">600</xsl:attribute>
                                                            <xsl:attribute name="height">450</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:if>
                                                      </xsl:element>
                                                   </xsl:for-each>
                                                </xsl:element>
                                             </xsl:element>

                                             </xsl:element>
                                                <xsl:element name="BR"/><xsl:element name="BR"/><xsl:element name="BR"/>
                                          </xsl:if>
                                             <xsl:element name="font">
                                                <xsl:attribute name="size">3</xsl:attribute>
                                                <xsl:value-of select="/DATA/TXN/PTSBARTERAD/DESCRIPTION/comment()" disable-output-escaping="yes"/>
                                             </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">400</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">top</xsl:attribute>
                                          <xsl:element name="TABLE">
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="cellpadding">0</xsl:attribute>
                                             <xsl:attribute name="cellspacing">0</xsl:attribute>
                                             <xsl:attribute name="width">400</xsl:attribute>

                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">400</xsl:attribute>
                                                      <xsl:attribute name="align">left</xsl:attribute>
                                                   </xsl:element>
                                                </xsl:element>
                                                <xsl:if test="(/DATA/TXN/PTSBARTERAD/@ismap = 1) and (/DATA/PARAM/@latitude != 0)">
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">400</xsl:attribute>
                                                         <xsl:attribute name="align">center</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:element name="DIV">
                                                            <xsl:attribute name="id">Map</xsl:attribute>
                                                            <xsl:attribute name="style">width:300px; height:300px;</xsl:attribute>
                                                         </xsl:element>
                                                         <xsl:element name="script">
                                                            var mymap = L.map("Map").setView([<xsl:value-of select="/DATA/PARAM/@latitude"/>, <xsl:value-of select="/DATA/PARAM/@longitude"/>], 13);
                                                            L.tileLayer("https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoiYm9id29vZDU2IiwiYSI6ImNpdzJkbjdsZDA4YWsyb211cDN0ZTBtNDcifQ.N6KnGJe0MqEdpEdotkyF_w", {
                                                            maxZoom: 18,
                                                            attribution: "Nexxus Map Data OpenStreetMap",
                                                            id: "mapbox.streets"
                                                            }).addTo(mymap);
                                                            mymap.attributionControl.setPrefix(false);
                                                            var fsControl = new L.Control.FullScreen();
                                                            mymap.addControl(fsControl);
                                                            L.marker([<xsl:value-of select="/DATA/PARAM/@latitude"/>, <xsl:value-of select="/DATA/PARAM/@longitude"/>]).addTo(mymap);
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
                                                         <xsl:attribute name="width">400</xsl:attribute>
                                                         <xsl:attribute name="align">center</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="size">3</xsl:attribute>
                                                            <xsl:value-of select="/DATA/TXN/PTSBARTERAD/@mapstreet1"/>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            <xsl:value-of select="/DATA/TXN/PTSBARTERAD/@mapstreet2"/>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            <xsl:value-of select="/DATA/TXN/PTSBARTERAD/@mapcity"/>
                                                            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                            <xsl:value-of select="/DATA/TXN/PTSBARTERAD/@mapzip"/>
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
                                                         <xsl:attribute name="width">400</xsl:attribute>
                                                         <xsl:attribute name="align">center</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:element name="font">
                                                            <xsl:attribute name="size">3</xsl:attribute>
                                                            <xsl:element name="A">
                                                               <xsl:attribute name="onclick">w=window.open(this.href,"new","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                                               <xsl:attribute name="href"><xsl:value-of select="/DATA/PARAM/@googleurl"/></xsl:attribute>
                                                            <xsl:element name="font">
                                                               <xsl:attribute name="color">purple</xsl:attribute>
                                                            <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GoogleMaps']"/>
                                                            </xsl:element>
                                                            </xsl:element>
                                                         </xsl:element>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="colspan">1</xsl:attribute>
                                                         <xsl:attribute name="height">18</xsl:attribute>
                                                      </xsl:element>
                                                   </xsl:element>

                                                </xsl:if>
                                                <xsl:element name="TR">
                                                   <xsl:element name="TD">
                                                      <xsl:attribute name="width">400</xsl:attribute>
                                                      <xsl:attribute name="align">left</xsl:attribute>
                                                      <xsl:attribute name="valign">center</xsl:attribute>
                                                      <xsl:element name="TABLE">
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="cellpadding">0</xsl:attribute>
                                                         <xsl:attribute name="cellspacing">0</xsl:attribute>
                                                         <xsl:attribute name="width">400</xsl:attribute>

                                                            <xsl:element name="TR">
                                                               <xsl:element name="TD">
                                                                  <xsl:attribute name="width">40</xsl:attribute>
                                                                  <xsl:attribute name="align">left</xsl:attribute>
                                                               </xsl:element>
                                                               <xsl:element name="TD">
                                                                  <xsl:attribute name="width">360</xsl:attribute>
                                                                  <xsl:attribute name="align">left</xsl:attribute>
                                                               </xsl:element>
                                                            </xsl:element>
                                                            <xsl:element name="TR">
                                                               <xsl:element name="TD">
                                                                  <xsl:attribute name="width">40</xsl:attribute>
                                                               </xsl:element>
                                                               <xsl:element name="TD">
                                                                  <xsl:attribute name="width">360</xsl:attribute>
                                                                  <xsl:attribute name="align">left</xsl:attribute>
                                                                  <xsl:attribute name="valign">center</xsl:attribute>
                                                                  <xsl:element name="TABLE">
                                                                     <xsl:attribute name="border">0</xsl:attribute>
                                                                     <xsl:attribute name="cellpadding">0</xsl:attribute>
                                                                     <xsl:attribute name="cellspacing">0</xsl:attribute>
                                                                     <xsl:attribute name="width">360</xsl:attribute>

                                                                        <xsl:element name="TR">
                                                                           <xsl:element name="TD">
                                                                              <xsl:attribute name="width">360</xsl:attribute>
                                                                              <xsl:attribute name="align">left</xsl:attribute>
                                                                           </xsl:element>
                                                                        </xsl:element>
                                                                        <xsl:if test="(/DATA/PARAM/@nocondition = 0)">
                                                                           <xsl:element name="TR">
                                                                              <xsl:element name="TD">
                                                                                 <xsl:attribute name="width">360</xsl:attribute>
                                                                                 <xsl:attribute name="align">left</xsl:attribute>
                                                                                 <xsl:attribute name="valign">center</xsl:attribute>
                                                                                 <xsl:element name="font">
                                                                                    <xsl:attribute name="size">3</xsl:attribute>
                                                                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Condition']"/>
                                                                                    <xsl:text>:</xsl:text>
                                                                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                                                    <xsl:element name="b">
                                                                                    <xsl:variable name="tmp3"><xsl:value-of select="/DATA/TXN/PTSBARTERAD/PTSCONDITIONS/ENUM[@id=/DATA/TXN/PTSBARTERAD/@condition]/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp3]"/>
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

                                                                        </xsl:if>
                                                                        <xsl:for-each select="/DATA/TXN/FIELDS/FIELD">
                                                                           <xsl:call-template name="CustomFields">
                                                                              <xsl:with-param name="margin" select="0"/>
                                                                              <xsl:with-param name="secure" select="0"/>
                                                                              <xsl:with-param name="display" select="1"/>
                                                                           </xsl:call-template>
                                                                        </xsl:for-each>

                                                                  </xsl:element>
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
                                          <xsl:attribute name="colspan">2</xsl:attribute>
                                          <xsl:attribute name="height">6</xsl:attribute>
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

                        <xsl:if test="(contains(/DATA/TXN/PTSBARTERAD/@options, 'F'))">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">1000</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/TXN/PTSHTMLFILE/DATA/comment()" disable-output-escaping="yes"/>
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
                              <xsl:attribute name="width">1000</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">top</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">1000</xsl:attribute>
                                 <xsl:attribute name="style">background-color: #cefad2;</xsl:attribute>
                                 <xsl:attribute name="class">box-gray</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">1000</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
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
                                          <xsl:attribute name="width">1000</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AcceptedPayments']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                          <xsl:if test="(/DATA/PARAM/@barterpaymentpoints != 0)">
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                -
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentPoints']"/>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@barterpaymentcash != 0)">
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                -
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentCash']"/>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@barterpaymentcc != 0)">
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                -
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentCC']"/>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@barterpaymentpp != 0)">
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                -
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentPP']"/>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@barterpaymentbtc != 0)">
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                -
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentBTC']"/>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@barterpaymentnxc != 0)">
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                -
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentNXC']"/>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@barterpaymenteth != 0)">
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                -
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentETH']"/>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@barterpaymentetc != 0)">
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                -
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentETC']"/>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@barterpaymentltc != 0)">
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                -
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentLTC']"/>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@barterpaymentdash != 0)">
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                -
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentDASH']"/>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@barterpaymentmonero != 0)">
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                -
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentMonero']"/>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@barterpaymentsteem != 0)">
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                -
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentSteem']"/>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@barterpaymentripple != 0)">
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                -
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentRipple']"/>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@barterpaymentdoge != 0)">
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                -
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentDoge']"/>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@barterpaymentgcr != 0)">
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                -
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentGCR']"/>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@barterpaymentother != 0)">
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                -
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BarterPaymentOther']"/>
                                          </xsl:if>
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
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">1000</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">top</xsl:attribute>
                              <xsl:element name="TABLE">
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="cellpadding">0</xsl:attribute>
                                 <xsl:attribute name="cellspacing">0</xsl:attribute>
                                 <xsl:attribute name="width">1000</xsl:attribute>
                                 <xsl:attribute name="style">background-color: #fcfde5;</xsl:attribute>
                                 <xsl:attribute name="class">box-gray</xsl:attribute>

                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">1000</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
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
                                          <xsl:attribute name="width">1000</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSBARTERAD/@language"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                             -
                                             <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                             <xsl:if test="(/DATA/TXN/PTSBARTERAD/@iscontact != 0)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ContactMe']"/>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSBARTERAD/@iscontact = 0)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='DontContactMe']"/>
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
                                          <xsl:attribute name="width">1000</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:attribute name="style">font-size:8pt;</xsl:attribute>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PostID']"/>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSBARTERAD/@barteradid"/>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Posted']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/TXN/PTSBARTERAD/@postdate"/>
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
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">1</xsl:attribute>
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

      </xsl:element>
      </xsl:element>
      <!--END BODY-->

      </xsl:element>

   </xsl:template>
</xsl:stylesheet>