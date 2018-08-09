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
         <xsl:with-param name="pagename" select="'Commission'"/>
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
               <xsl:attribute name="onload">document.getElementById('CommDate').focus()</xsl:attribute>
            </xsl:otherwise>
         </xsl:choose>

         <!--BEGIN PAGE-->
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
               <xsl:attribute name="name">Commission</xsl:attribute>
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
                              <xsl:attribute name="width">160</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeading</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CommissionID']"/>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:value-of select="/DATA/TXN/PTSCOMMISSION/@commissionid"/>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">bottom</xsl:attribute>
                              <xsl:attribute name="class">PrevNext</xsl:attribute>
                              <xsl:element name="A">
                                 <xsl:attribute name="class">PageHeadingLink</xsl:attribute>
                                 <xsl:attribute name="href">0803.asp?PayoutID=<xsl:value-of select="/DATA/TXN/PTSCOMMISSION/@payoutid"/>&amp;ReturnURL=<xsl:value-of select="/DATA/SYSTEM/@pageURL"/>&amp;ReturnData=<xsl:value-of select="/DATA/SYSTEM/@pageData"/></xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Payout']"/>
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
                              <xsl:attribute name="width">160</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CommDate']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">CommDate</xsl:attribute>
                              <xsl:attribute name="id">CommDate</xsl:attribute>
                              <xsl:attribute name="size">15</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSCOMMISSION/@commdate"/></xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="IMG">
                                 <xsl:attribute name="name">Calendar</xsl:attribute>
                                 <xsl:attribute name="src">Images/Calendar.gif</xsl:attribute>
                                 <xsl:attribute name="width">16</xsl:attribute>
                                 <xsl:attribute name="height">16</xsl:attribute>
                                 <xsl:attribute name="border">0</xsl:attribute>
                                 <xsl:attribute name="onclick">CalendarPopup(document.forms[0], document.getElementById('CommDate'))</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">160</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Amount']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">Amount</xsl:attribute>
                              <xsl:attribute name="id">Amount</xsl:attribute>
                              <xsl:attribute name="size">10</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSCOMMISSION/@amount"/></xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Total']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">Total</xsl:attribute>
                              <xsl:attribute name="id">Total</xsl:attribute>
                              <xsl:attribute name="size">10</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSCOMMISSION/@total"/></xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Charge']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">Charge</xsl:attribute>
                              <xsl:attribute name="id">Charge</xsl:attribute>
                              <xsl:attribute name="size">10</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSCOMMISSION/@charge"/></xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">160</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CommTypeName']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">text</xsl:attribute>
                              <xsl:attribute name="name">CommType</xsl:attribute>
                              <xsl:attribute name="id">CommType</xsl:attribute>
                              <xsl:attribute name="size">2</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSCOMMISSION/@commtype"/></xsl:attribute>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:value-of select="/DATA/TXN/PTSCOMMISSION/@commtypename"/>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">160</xsl:attribute>
                              <xsl:attribute name="align">right</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Status']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">440</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="SELECT">
                                 <xsl:attribute name="name">Status</xsl:attribute>
                                 <xsl:attribute name="id">Status</xsl:attribute>
                                 <xsl:for-each select="/DATA/TXN/PTSCOMMISSION/PTSSTATUSS/ENUM">
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
                                       <xsl:if test="@selected"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:variable name="tmp1"><xsl:value-of select="current()/@name"/></xsl:variable><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$tmp1]"/>
                                    </xsl:element>
                                 </xsl:for-each>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/SYSTEM/@usergroup &lt;= 21) or (/DATA/SYSTEM/@usergroup = 51)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">160</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='OwnerType']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">OwnerType</xsl:attribute>
                                 <xsl:attribute name="id">OwnerType</xsl:attribute>
                                 <xsl:attribute name="size">2</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSCOMMISSION/@ownertype"/></xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">OwnerID</xsl:attribute>
                                 <xsl:attribute name="id">OwnerID</xsl:attribute>
                                 <xsl:attribute name="size">8</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSCOMMISSION/@ownerid"/></xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">160</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='RefID']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">RefID</xsl:attribute>
                                 <xsl:attribute name="id">RefID</xsl:attribute>
                                 <xsl:attribute name="size">10</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSCOMMISSION/@refid"/></xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">160</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PayoutID']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">440</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">PayoutID</xsl:attribute>
                                 <xsl:attribute name="id">PayoutID</xsl:attribute>
                                 <xsl:attribute name="size">10</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSCOMMISSION/@payoutid"/></xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/SYSTEM/@usergroup &gt; 21) and (/DATA/SYSTEM/@usergroup != 51)">
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">OwnerType</xsl:attribute>
                              <xsl:attribute name="id">OwnerType</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSCOMMISSION/@ownertype"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">OwnerID</xsl:attribute>
                              <xsl:attribute name="id">OwnerID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSCOMMISSION/@ownerid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">RefID</xsl:attribute>
                              <xsl:attribute name="id">RefID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSCOMMISSION/@refid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">PayoutID</xsl:attribute>
                              <xsl:attribute name="id">PayoutID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSCOMMISSION/@payoutid"/></xsl:attribute>
                           </xsl:element>
                        </xsl:if>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Description']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TEXTAREA">
                                 <xsl:attribute name="name">Description</xsl:attribute>
                                 <xsl:attribute name="id">Description</xsl:attribute>
                                 <xsl:attribute name="rows">2</xsl:attribute>
                                 <xsl:attribute name="cols">70</xsl:attribute>
                                 <xsl:attribute name="onkeyup"><xsl:text disable-output-escaping="yes"><![CDATA[if (value.length>100) {doMaxLenMsg(100); value=value.substring(0,100);}]]></xsl:text></xsl:attribute>
                                 <xsl:value-of select="/DATA/TXN/PTSCOMMISSION/@description"/>
                              </xsl:element>
                              <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                              <xsl:element name="IMG">
                                 <xsl:attribute name="src">Images/Required.gif</xsl:attribute>
                                 <xsl:attribute name="alt">Required Field</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Notes']"/>
                              <xsl:text>:</xsl:text>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TEXTAREA">
                                 <xsl:attribute name="name">Notes</xsl:attribute>
                                 <xsl:attribute name="id">Notes</xsl:attribute>
                                 <xsl:attribute name="rows">6</xsl:attribute>
                                 <xsl:attribute name="cols">72</xsl:attribute>
                                 <xsl:attribute name="onkeyup"><xsl:text disable-output-escaping="yes"><![CDATA[if (value.length>500) {doMaxLenMsg(500); value=value.substring(0,500);}]]></xsl:text></xsl:attribute>
                                 <xsl:value-of select="/DATA/TXN/PTSCOMMISSION/@notes"/>
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
                              <xsl:if test="(/DATA/PARAM/@popup = 0)">
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Cancel']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick">doSubmit(3,"")</xsl:attribute>
                                 </xsl:element>
                              </xsl:if>
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
      <!--END BODY-->

      </xsl:element>

   </xsl:template>
</xsl:stylesheet>