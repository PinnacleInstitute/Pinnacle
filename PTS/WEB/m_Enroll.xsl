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
         <xsl:with-param name="pagename" select="'New Member'"/>
         <xsl:with-param name="includecalendar" select="true()"/>
         <xsl:with-param name="htmleditor"></xsl:with-param>
         <xsl:with-param name="viewport">width=device-width</xsl:with-param>
         <xsl:with-param name="translate">google</xsl:with-param>
      </xsl:call-template>

      <!--BEGIN BODY-->
      <xsl:element name="BODY">
         <xsl:attribute name="topmargin">0</xsl:attribute>
         <xsl:attribute name="leftmargin">0</xsl:attribute>
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
                     <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[Init();]]></xsl:text>;doErrorMsg('<xsl:value-of select="concat($errmsg, $errmsgfld)"/>')</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[Init();]]></xsl:text>;doErrorMsg('<xsl:value-of select="/DATA/ERROR"/>')</xsl:attribute>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
               <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[Init();]]></xsl:text></xsl:attribute>
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
            <xsl:attribute name="width">100%</xsl:attribute>
            <xsl:attribute name="align">left</xsl:attribute>

            <!--BEGIN FORM-->
            <xsl:element name="FORM">
               <xsl:attribute name="name">Business</xsl:attribute>
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
                     <xsl:attribute name="width">0</xsl:attribute>
                  </xsl:element>
                  <xsl:element name="TD">
                     <xsl:attribute name="width">100%</xsl:attribute>
                  </xsl:element>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ToggleType(){ 
               var payobj = Business.elements['PayType'];
               if( payobj != null ) {
                  var VisibleCard = 'none'; var VisibleCheck = 'none';
                  var paytype=1;
                  var l = payobj.length;
                  if( l == null ) {
                     if( payobj.checked ) {
                        paytype = payobj.value
                     }
                  }
                  else
                  {
                     for( i = 0; i < l; i++ ) {
                        if (payobj[i].checked) {
                           paytype = payobj[i].value;
                           i = l;
                        }
                     }
                  }
               if (paytype >= 1 && paytype <= 4) VisibleCard = '';
               if (paytype == 5) VisibleCheck = '';
               document.getElementById('CardRows').style.display = VisibleCard;
               document.getElementById('CheckRows').style.display = VisibleCheck;
               }
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function CheckType(val){ 
               var payobj = Business.elements['PayType'];
               if( payobj != null ) {
                  var l = payobj.length;
                  for( i = 0; i < l; i++ ) {
                     if (payobj[i].value == val) {
                        payobj[i].checked=true;
                        i = l;
                     }
                  }
                  ToggleType();
               }
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function TitleCase(obj){ 
               var val = obj.value;
               if ( val.length == 2 ) {
               obj.value = val.charAt(0).toUpperCase() + val.charAt(1).toUpperCase();
               }
               else {
               obj.value = val.charAt(0).toUpperCase() + val.slice(1);
               }
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function FormatPhone(obj){ 
               var val = obj.value;
               var newval = val.replace(/[^\d]/g, '');
               if( newval.length == 10 ) {
               obj.value = newval.substring(0,3) + '-' + newval.substring(3,6) + '-' + newval.substring(6,10);
               }
               if( newval.length == 11 ) {
               obj.value = newval.substring(0,1) + '-' + newval.substring(1,4) + '-' + newval.substring(4,7) + '-' + newval.substring(7,11);
               }
               if( newval.length == 12 ) {
               obj.value = newval.substring(0,2) + '-' + newval.substring(2,5) + '-' + newval.substring(5,8) + '-' + newval.substring(8,12);
               }
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function FormatCardCode(obj){ 
               var val = obj.value;
               var newval = val.replace(/[^\d]/g, '');
               obj.value = newval.substring(0,4);
               //if( newval.length < 3 ) {
               //alert('Oops, Invalid Security Code');
               //}
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function FormatLogon(obj){ 
               var val = obj.value;
               var newval = val.replace(/[^0-9a-zA-Z]/g, '');
               obj.value = newval;
               if( newval.length < 6 ) {
               alert('Oops, Logon must be at least 6 characters or numbers.');
               }
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ShowCC(){ 
               var disp, membership = document.getElementById('Membership').value;
               if( membership < 5 ) { disp = 'none' } else { disp = '' }
               document.getElementById('CCRequired').style.display = disp;
               if( membership < 5 ) { disp = '' } else { disp = 'none' }
               document.getElementById('Agree2').style.display = disp;
               //document.getElementById('Payment').style.display = disp;
               //document.getElementById('CardRows').style.display = disp;
               //document.getElementById('Secure').style.display = disp;
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function Init(){ 
               var mode = document.getElementById('Mode').value;
               if( mode == 1 ) {
               //ShowTaxIDType();
               }
               if( mode == 2 ) {
               // do nothing
               }
               if( mode == 4 ) {
               ToggleType();
               ShowCC();
               }
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function MsgBox(msg){ 
               alert(msg);
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="TR">

                  <xsl:element name="TD">
                     <xsl:attribute name="width">0</xsl:attribute>
                  </xsl:element>

                  <xsl:element name="TD">
                     <xsl:attribute name="valign">top</xsl:attribute>
                     <xsl:attribute name="width">100%</xsl:attribute>

                     <xsl:element name="TABLE">
                        <xsl:attribute name="border">0</xsl:attribute>
                        <xsl:attribute name="cellpadding">0</xsl:attribute>
                        <xsl:attribute name="cellspacing">0</xsl:attribute>
                        <xsl:attribute name="width">100%</xsl:attribute>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">25%</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">75%</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Mode</xsl:attribute>
                              <xsl:attribute name="id">Mode</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@mode"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">NewMemberID</xsl:attribute>
                              <xsl:attribute name="id">NewMemberID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@newmemberid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">BillingID</xsl:attribute>
                              <xsl:attribute name="id">BillingID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@billingid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">PayID</xsl:attribute>
                              <xsl:attribute name="id">PayID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@payid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">TokenOwner</xsl:attribute>
                              <xsl:attribute name="id">TokenOwner</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@tokenowner"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">TokenType</xsl:attribute>
                              <xsl:attribute name="id">TokenType</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@tokentype"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Token</xsl:attribute>
                              <xsl:attribute name="id">Token</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@token"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">PayDesc</xsl:attribute>
                              <xsl:attribute name="id">PayDesc</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@paydesc"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">NoValidate</xsl:attribute>
                              <xsl:attribute name="id">NoValidate</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@novalidate"/></xsl:attribute>
                           </xsl:element>

                        <xsl:if test="(/DATA/PARAM/@badpayment != 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:element name="font">
                                    <xsl:attribute name="color">red</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BadPaymentText']"/>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="(/DATA/PARAM/@mode = 1)">
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Membership</xsl:attribute>
                                 <xsl:attribute name="id">Membership</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@membership"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">PayType</xsl:attribute>
                                 <xsl:attribute name="id">PayType</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@paytype"/></xsl:attribute>
                              </xsl:element>
                           <xsl:if test="(/DATA/PARAM/@referredby = '')">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="height">24</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="width">100%</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:attribute name="class">PageHeading</xsl:attribute>
                                    <xsl:element name="font">
                                       <xsl:attribute name="color">red</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoReferral1']"/>
                                       <xsl:element name="BR"/><xsl:element name="BR"/>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoReferral2']"/>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="height">24</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:if>

                           <xsl:if test="(/DATA/PARAM/@referredby != '')">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="height">6</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="width">100%</xsl:attribute>
                                    <xsl:attribute name="align">right</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:value-of select="/DATA/TXN/PTSHTMLFILE/DATA/comment()" disable-output-escaping="yes"/>
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
                                    <xsl:attribute name="width">100%</xsl:attribute>
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="height">1</xsl:attribute>
                                    <xsl:attribute name="bgcolor">#584b42</xsl:attribute>
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
                                    <xsl:attribute name="width">100%</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="b">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ReferredBy']"/>
                                       <xsl:text>:</xsl:text>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/PARAM/@referredby" disable-output-escaping="yes"/>
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
                                    <xsl:attribute name="width">100%</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="b">
                                    <xsl:element name="font">
                                       <xsl:attribute name="size">4</xsl:attribute>
                                       <xsl:attribute name="color">blue</xsl:attribute>
                                       <xsl:element name="INPUT">
                                       <xsl:attribute name="type">checkbox</xsl:attribute>
                                       <xsl:attribute name="name">IsAgree</xsl:attribute>
                                       <xsl:attribute name="id">IsAgree</xsl:attribute>
                                       <xsl:attribute name="value">1</xsl:attribute>
                                       <xsl:if test="(/DATA/PARAM/@isagree = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsAgree']"/>
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
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="width">100%</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="INPUT">
                                       <xsl:attribute name="type">button</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Continue']"/>
                                       </xsl:attribute>
                                       <xsl:attribute name="onclick">doSubmit(1,"")</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>

                           </xsl:if>
                        </xsl:if>
                        <xsl:if test="(/DATA/PARAM/@mode = 2)">
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">IsAgree</xsl:attribute>
                                 <xsl:attribute name="id">IsAgree</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@isagree"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Membership</xsl:attribute>
                                 <xsl:attribute name="id">Membership</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@membership"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">IsAgree2</xsl:attribute>
                                 <xsl:attribute name="id">IsAgree2</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@isagree2"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">PayType</xsl:attribute>
                                 <xsl:attribute name="id">PayType</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@paytype"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CardNumber</xsl:attribute>
                                 <xsl:attribute name="id">CardNumber</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@cardnumber"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CardMo</xsl:attribute>
                                 <xsl:attribute name="id">CardMo</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@cardmo"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CardYr</xsl:attribute>
                                 <xsl:attribute name="id">CardYr</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@cardyr"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CardName</xsl:attribute>
                                 <xsl:attribute name="id">CardName</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@cardname"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CardCode</xsl:attribute>
                                 <xsl:attribute name="id">CardCode</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@cardcode"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CheckBank</xsl:attribute>
                                 <xsl:attribute name="id">CheckBank</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@checkbank"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CheckRoute</xsl:attribute>
                                 <xsl:attribute name="id">CheckRoute</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@checkroute"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CheckAccount</xsl:attribute>
                                 <xsl:attribute name="id">CheckAccount</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@checkaccount"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CheckAcctType</xsl:attribute>
                                 <xsl:attribute name="id">CheckAcctType</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@checkaccttype"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CheckName</xsl:attribute>
                                 <xsl:attribute name="id">CheckName</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@checkname"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Street1b</xsl:attribute>
                                 <xsl:attribute name="id">Street1b</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@street1b"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Street2b</xsl:attribute>
                                 <xsl:attribute name="id">Street2b</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@street2b"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Cityb</xsl:attribute>
                                 <xsl:attribute name="id">Cityb</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@cityb"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Stateb</xsl:attribute>
                                 <xsl:attribute name="id">Stateb</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@stateb"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Zipb</xsl:attribute>
                                 <xsl:attribute name="id">Zipb</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@zipb"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CountryIDb</xsl:attribute>
                                 <xsl:attribute name="id">CountryIDb</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@countryidb"/></xsl:attribute>
                              </xsl:element>
                           <xsl:if test="(/DATA/PARAM/@nobanner = 0)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="height">6</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="width">100%</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="IMG">
                                       <xsl:attribute name="src">Images/m_EnrollContact.png</xsl:attribute>
                                       <xsl:attribute name="border">0</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="height">6</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:if>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">prompt</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewMemberText']"/>
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
                                 <xsl:attribute name="width">25%</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NameFirst']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">75%</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="class">bigtext</xsl:attribute>
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">NameFirst</xsl:attribute>
                                 <xsl:attribute name="id">NameFirst</xsl:attribute>
                                 <xsl:attribute name="size">20</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@namefirst"/></xsl:attribute>
                                 <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[TitleCase(this);]]></xsl:text></xsl:attribute>
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
                                 <xsl:attribute name="width">25%</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NameLast']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">75%</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="class">bigtext</xsl:attribute>
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">NameLast</xsl:attribute>
                                 <xsl:attribute name="id">NameLast</xsl:attribute>
                                 <xsl:attribute name="size">20</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@namelast"/></xsl:attribute>
                                 <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[TitleCase(this);]]></xsl:text></xsl:attribute>
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
                                 <xsl:attribute name="width">25%</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CompanyName']"/>
                                    <xsl:element name="A">
                                       <xsl:attribute name="href">#_</xsl:attribute>
                                       <xsl:attribute name="onclick">MsgBox('<xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CompanyNameTip']"/>');</xsl:attribute>
                                       <xsl:element name="IMG">
                                          <xsl:attribute name="src">Images/TipQuestion.gif</xsl:attribute>
                                          <xsl:attribute name="border">0</xsl:attribute>
                                          <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CompanyNameTip']"/></xsl:attribute>
                                          <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CompanyNameTip']"/></xsl:attribute>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">75%</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="class">bigtext</xsl:attribute>
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">CompanyName</xsl:attribute>
                                 <xsl:attribute name="id">CompanyName</xsl:attribute>
                                 <xsl:attribute name="size">20</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@companyname"/></xsl:attribute>
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
                                 <xsl:attribute name="width">25%</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Email']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">75%</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="class">bigtext</xsl:attribute>
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">Email</xsl:attribute>
                                 <xsl:attribute name="id">Email</xsl:attribute>
                                 <xsl:attribute name="size">20</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@email"/></xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:if test="(/DATA/PARAM/@textemail != 0)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">25%</xsl:attribute>
                                    <xsl:attribute name="align">right</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Email2']"/>
                                       <xsl:element name="A">
                                          <xsl:attribute name="href">#_</xsl:attribute>
                                          <xsl:attribute name="onclick">MsgBox('<xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Email2Tip']"/>');</xsl:attribute>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/TipQuestion.gif</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
                                             <xsl:attribute name="alt"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Email2Tip']"/></xsl:attribute>
                                             <xsl:attribute name="title"><xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Email2Tip']"/></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">75%</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="INPUT">
                                    <xsl:attribute name="class">bigtext</xsl:attribute>
                                    <xsl:attribute name="type">text</xsl:attribute>
                                    <xsl:attribute name="name">Email2</xsl:attribute>
                                    <xsl:attribute name="id">Email2</xsl:attribute>
                                    <xsl:attribute name="size">20</xsl:attribute>
                                    <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@email2"/></xsl:attribute>
                                    </xsl:element>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:element name="A">
                                          <xsl:attribute name="onclick">w=window.open(this.href,"Help","");if (window.focus) {w.focus();};return false;</xsl:attribute>
                                          <xsl:attribute name="href">Page.asp?Page=Email2</xsl:attribute>
                                          <xsl:element name="IMG">
                                             <xsl:attribute name="src">Images/LearnMore.gif</xsl:attribute>
                                             <xsl:attribute name="border">0</xsl:attribute>
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
                           </xsl:if>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">25%</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Phone']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">75%</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="class">bigtext</xsl:attribute>
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">Phone1</xsl:attribute>
                                 <xsl:attribute name="id">Phone1</xsl:attribute>
                                 <xsl:attribute name="size">20</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@phone1"/></xsl:attribute>
                                 <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[FormatPhone(this);]]></xsl:text></xsl:attribute>
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
                                 <xsl:attribute name="width">25%</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MailingAddress']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">75%</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="class">bigtext</xsl:attribute>
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">Street1</xsl:attribute>
                                 <xsl:attribute name="id">Street1</xsl:attribute>
                                 <xsl:attribute name="size">20</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSADDRESS/@street1"/></xsl:attribute>
                                 <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[document.getElementById('Street1b').value = this.value;]]></xsl:text></xsl:attribute>
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
                                 <xsl:attribute name="width">25%</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Street2']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">75%</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="class">bigtext</xsl:attribute>
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">Street2</xsl:attribute>
                                 <xsl:attribute name="id">Street2</xsl:attribute>
                                 <xsl:attribute name="size">20</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSADDRESS/@street2"/></xsl:attribute>
                                 <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[document.getElementById('Street2b').value = this.value;]]></xsl:text></xsl:attribute>
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
                                 <xsl:attribute name="width">25%</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='City']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">75%</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="class">bigtext</xsl:attribute>
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">City</xsl:attribute>
                                 <xsl:attribute name="id">City</xsl:attribute>
                                 <xsl:attribute name="size">20</xsl:attribute>
                                 <xsl:attribute name="maxlength">30</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSADDRESS/@city"/></xsl:attribute>
                                 <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[TitleCase(this); document.getElementById('Cityb').value = this.value;]]></xsl:text></xsl:attribute>
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
                                 <xsl:attribute name="width">25%</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='State']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">75%</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="class">bigtext</xsl:attribute>
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">State</xsl:attribute>
                                 <xsl:attribute name="id">State</xsl:attribute>
                                 <xsl:attribute name="size">20</xsl:attribute>
                                 <xsl:attribute name="maxlength">30</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSADDRESS/@state"/></xsl:attribute>
                                 <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[TitleCase(this); document.getElementById('Stateb').value = this.value;]]></xsl:text></xsl:attribute>
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
                                 <xsl:attribute name="width">25%</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Zip']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">75%</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="class">bigtext</xsl:attribute>
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">Zip</xsl:attribute>
                                 <xsl:attribute name="id">Zip</xsl:attribute>
                                 <xsl:attribute name="size">20</xsl:attribute>
                                 <xsl:attribute name="maxlength">20</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSADDRESS/@zip"/></xsl:attribute>
                                 <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[document.getElementById('Zipb').value = this.value;]]></xsl:text></xsl:attribute>
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
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CountryID']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="SELECT">
                                    <xsl:attribute name="name">CountryID</xsl:attribute>
                                    <xsl:attribute name="id">CountryID</xsl:attribute>
                                    <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[document.getElementById('CountryIDb').value = this.value;]]></xsl:text></xsl:attribute>
                                    <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/PTSADDRESS/@countryid"/></xsl:variable>
                                    <xsl:for-each select="/DATA/TXN/PTSCOUNTRYS/ENUM">
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
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">1</xsl:attribute>
                                 <xsl:attribute name="bgcolor">#584b42</xsl:attribute>
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
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">prompt</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LogonText']"/>
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
                                 <xsl:attribute name="width">25%</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewLogon']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">75%</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">prompt</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="class">bigtext</xsl:attribute>
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">NewLogon</xsl:attribute>
                                 <xsl:attribute name="id">NewLogon</xsl:attribute>
                                 <xsl:attribute name="size">15</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@newlogon"/></xsl:attribute>
                                 <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[FormatLogon(this);]]></xsl:text></xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LogonTip']"/>
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
                                 <xsl:attribute name="width">25%</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewPassword']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">75%</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">prompt</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="class">bigtext</xsl:attribute>
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">NewPassword</xsl:attribute>
                                 <xsl:attribute name="id">NewPassword</xsl:attribute>
                                 <xsl:attribute name="size">15</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@newpassword"/></xsl:attribute>
                                 <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[if(this.value==''){alert('Oops, Password Required!');}]]></xsl:text></xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PasswordText']"/>
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
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="class">bigbutton</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Continue']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[document.getElementById('NoValidate').value = 0; doSubmit(2,"");]]></xsl:text></xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/PARAM/@mode = 3)">
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">IsAgree</xsl:attribute>
                                 <xsl:attribute name="id">IsAgree</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@isagree"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">NameFirst</xsl:attribute>
                                 <xsl:attribute name="id">NameFirst</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@namefirst"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">NameLast</xsl:attribute>
                                 <xsl:attribute name="id">NameLast</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@namelast"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CompanyName</xsl:attribute>
                                 <xsl:attribute name="id">CompanyName</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@companyname"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Email</xsl:attribute>
                                 <xsl:attribute name="id">Email</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@email"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Reference</xsl:attribute>
                                 <xsl:attribute name="id">Reference</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@reference"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Street1</xsl:attribute>
                                 <xsl:attribute name="id">Street1</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSADDRESS/@street1"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Street2</xsl:attribute>
                                 <xsl:attribute name="id">Street2</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSADDRESS/@street2"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">City</xsl:attribute>
                                 <xsl:attribute name="id">City</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSADDRESS/@city"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">State</xsl:attribute>
                                 <xsl:attribute name="id">State</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSADDRESS/@state"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Zip</xsl:attribute>
                                 <xsl:attribute name="id">Zip</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSADDRESS/@zip"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CountryID</xsl:attribute>
                                 <xsl:attribute name="id">CountryID</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSADDRESS/@countryid"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Phone1</xsl:attribute>
                                 <xsl:attribute name="id">Phone1</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@phone1"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">NewLogon</xsl:attribute>
                                 <xsl:attribute name="id">NewLogon</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@newlogon"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">NewPassword</xsl:attribute>
                                 <xsl:attribute name="id">NewPassword</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@newpassword"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">IsAgree2</xsl:attribute>
                                 <xsl:attribute name="id">IsAgree2</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@isagree2"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">PayType</xsl:attribute>
                                 <xsl:attribute name="id">PayType</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@paytype"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CardNumber</xsl:attribute>
                                 <xsl:attribute name="id">CardNumber</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@cardnumber"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CardMo</xsl:attribute>
                                 <xsl:attribute name="id">CardMo</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@cardmo"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CardYr</xsl:attribute>
                                 <xsl:attribute name="id">CardYr</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@cardyr"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CardName</xsl:attribute>
                                 <xsl:attribute name="id">CardName</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@cardname"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CardCode</xsl:attribute>
                                 <xsl:attribute name="id">CardCode</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@cardcode"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CheckBank</xsl:attribute>
                                 <xsl:attribute name="id">CheckBank</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@checkbank"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CheckRoute</xsl:attribute>
                                 <xsl:attribute name="id">CheckRoute</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@checkroute"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CheckAccount</xsl:attribute>
                                 <xsl:attribute name="id">CheckAccount</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@checkaccount"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CheckAcctType</xsl:attribute>
                                 <xsl:attribute name="id">CheckAcctType</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@checkaccttype"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CheckName</xsl:attribute>
                                 <xsl:attribute name="id">CheckName</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@checkname"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Street1b</xsl:attribute>
                                 <xsl:attribute name="id">Street1b</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@street1b"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Street2b</xsl:attribute>
                                 <xsl:attribute name="id">Street2b</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@street2b"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Cityb</xsl:attribute>
                                 <xsl:attribute name="id">Cityb</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@cityb"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Stateb</xsl:attribute>
                                 <xsl:attribute name="id">Stateb</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@stateb"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Zipb</xsl:attribute>
                                 <xsl:attribute name="id">Zipb</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@zipb"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CountryIDb</xsl:attribute>
                                 <xsl:attribute name="id">CountryIDb</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@countryidb"/></xsl:attribute>
                              </xsl:element>
                           <xsl:if test="(/DATA/PARAM/@nobanner = 0)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="height">6</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="width">100%</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="IMG">
                                       <xsl:attribute name="src">Images/m_EnrollMembership.png</xsl:attribute>
                                       <xsl:attribute name="border">0</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="height">6</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:if>

                           <xsl:if test="(/DATA/PARAM/@companyid = 7)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="width">100%</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="IMG">
                                       <xsl:attribute name="src">Images/company/7//FreeTrial.png</xsl:attribute>
                                       <xsl:attribute name="border">0</xsl:attribute>
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
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="width">300%</xsl:attribute>
                                    <xsl:attribute name="align">right</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="TABLE">
                                       <xsl:attribute name="border">0</xsl:attribute>
                                       <xsl:attribute name="cellpadding">0</xsl:attribute>
                                       <xsl:attribute name="cellspacing">0</xsl:attribute>
                                       <xsl:attribute name="width">300%</xsl:attribute>

                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">30%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">270%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
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
                                                <xsl:attribute name="width">30%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">top</xsl:attribute>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">radio</xsl:attribute>
                                                <xsl:attribute name="name">Membership</xsl:attribute>
                                                <xsl:attribute name="id">Membership</xsl:attribute>
                                                <xsl:attribute name="value">3</xsl:attribute>
                                                <xsl:if test="/DATA/PARAM/@membership=3">
                                                   <xsl:attribute name="CHECKED"/>
                                                </xsl:if>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">270%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="font">
                                                   <xsl:attribute name="size">4</xsl:attribute>
                                                   <xsl:if test="(/DATA/PARAM/@nobill = 0)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership7_3']"/>
                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/PARAM/@nobill != 0)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership7_3a']"/>
                                                   </xsl:if>
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
                                                <xsl:attribute name="width">30%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">top</xsl:attribute>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">radio</xsl:attribute>
                                                <xsl:attribute name="name">Membership</xsl:attribute>
                                                <xsl:attribute name="id">Membership</xsl:attribute>
                                                <xsl:attribute name="value">1</xsl:attribute>
                                                <xsl:if test="/DATA/PARAM/@membership=1">
                                                   <xsl:attribute name="CHECKED"/>
                                                </xsl:if>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">270%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="font">
                                                   <xsl:attribute name="size">4</xsl:attribute>
                                                   <xsl:if test="(/DATA/PARAM/@nobill = 0)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership7_1']"/>
                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/PARAM/@nobill != 0)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership7_1a']"/>
                                                   </xsl:if>
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

                           </xsl:if>
                           <xsl:if test="(/DATA/PARAM/@companyid = 18)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="width">100%</xsl:attribute>
                                    <xsl:attribute name="align">right</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="TABLE">
                                       <xsl:attribute name="border">0</xsl:attribute>
                                       <xsl:attribute name="cellpadding">0</xsl:attribute>
                                       <xsl:attribute name="cellspacing">0</xsl:attribute>
                                       <xsl:attribute name="width">100%</xsl:attribute>

                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">10%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">90%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
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
                                                <xsl:attribute name="width">10%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">top</xsl:attribute>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">radio</xsl:attribute>
                                                <xsl:attribute name="name">Membership</xsl:attribute>
                                                <xsl:attribute name="id">Membership</xsl:attribute>
                                                <xsl:attribute name="value">1</xsl:attribute>
                                                <xsl:if test="/DATA/PARAM/@membership=1">
                                                   <xsl:attribute name="CHECKED"/>
                                                </xsl:if>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">90%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership18_1']"/>
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
                                                <xsl:attribute name="width">10%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">top</xsl:attribute>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">radio</xsl:attribute>
                                                <xsl:attribute name="name">Membership</xsl:attribute>
                                                <xsl:attribute name="id">Membership</xsl:attribute>
                                                <xsl:attribute name="value">2</xsl:attribute>
                                                <xsl:if test="/DATA/PARAM/@membership=2">
                                                   <xsl:attribute name="CHECKED"/>
                                                </xsl:if>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">90%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership18_2']"/>
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
                                                <xsl:attribute name="width">10%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">top</xsl:attribute>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">radio</xsl:attribute>
                                                <xsl:attribute name="name">Membership</xsl:attribute>
                                                <xsl:attribute name="id">Membership</xsl:attribute>
                                                <xsl:attribute name="value">3</xsl:attribute>
                                                <xsl:if test="/DATA/PARAM/@membership=3">
                                                   <xsl:attribute name="CHECKED"/>
                                                </xsl:if>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">90%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership18_3']"/>
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

                           </xsl:if>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="class">bigbutton</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Back']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[document.getElementById('NoValidate').value = 1; doSubmit(1,"");]]></xsl:text></xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="class">bigbutton</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Continue']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[document.getElementById('NoValidate').value = 0; doSubmit(3,"");]]></xsl:text></xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/PARAM/@mode = 4)">
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">IsAgree</xsl:attribute>
                                 <xsl:attribute name="id">IsAgree</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@isagree"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">NameFirst</xsl:attribute>
                                 <xsl:attribute name="id">NameFirst</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@namefirst"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">NameLast</xsl:attribute>
                                 <xsl:attribute name="id">NameLast</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@namelast"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CompanyName</xsl:attribute>
                                 <xsl:attribute name="id">CompanyName</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@companyname"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Email</xsl:attribute>
                                 <xsl:attribute name="id">Email</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@email"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Reference</xsl:attribute>
                                 <xsl:attribute name="id">Reference</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@reference"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Street1</xsl:attribute>
                                 <xsl:attribute name="id">Street1</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSADDRESS/@street1"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Street2</xsl:attribute>
                                 <xsl:attribute name="id">Street2</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSADDRESS/@street2"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">City</xsl:attribute>
                                 <xsl:attribute name="id">City</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSADDRESS/@city"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">State</xsl:attribute>
                                 <xsl:attribute name="id">State</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSADDRESS/@state"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Zip</xsl:attribute>
                                 <xsl:attribute name="id">Zip</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSADDRESS/@zip"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CountryID</xsl:attribute>
                                 <xsl:attribute name="id">CountryID</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSADDRESS/@countryid"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Phone1</xsl:attribute>
                                 <xsl:attribute name="id">Phone1</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@phone1"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">NewLogon</xsl:attribute>
                                 <xsl:attribute name="id">NewLogon</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@newlogon"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">NewPassword</xsl:attribute>
                                 <xsl:attribute name="id">NewPassword</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@newpassword"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Membership</xsl:attribute>
                                 <xsl:attribute name="id">Membership</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@membership"/></xsl:attribute>
                              </xsl:element>
                           <xsl:if test="(/DATA/PARAM/@nobanner = 0)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="height">6</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="width">100%</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="IMG">
                                       <xsl:attribute name="src">Images/m_EnrollPayment.png</xsl:attribute>
                                       <xsl:attribute name="border">0</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="height">6</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:if>

                           <xsl:if test="(/DATA/PARAM/@companyid = 7)">
                              <xsl:if test="(/DATA/PARAM/@nobill = 0)">
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">3</xsl:attribute>
                                       <xsl:attribute name="width">100%</xsl:attribute>
                                       <xsl:attribute name="align">center</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="b">
                                       <xsl:element name="font">
                                          <xsl:attribute name="color">red</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoPaymentText']"/>
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
                              </xsl:if>

                              <xsl:if test="(/DATA/PARAM/@nobill != 0)">
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">3</xsl:attribute>
                                       <xsl:attribute name="width">100%</xsl:attribute>
                                       <xsl:attribute name="align">center</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="b">
                                       <xsl:element name="font">
                                          <xsl:attribute name="color">red</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NoPaymentText2']"/>
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
                              </xsl:if>

                           </xsl:if>
                           <xsl:if test="(/DATA/PARAM/@nobill = 0)">
                              <xsl:element name="TR">
                                 <xsl:attribute name="id">Payment</xsl:attribute>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="width">320%</xsl:attribute>
                                    <xsl:attribute name="align">right</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="TABLE">
                                       <xsl:attribute name="border">0</xsl:attribute>
                                       <xsl:attribute name="cellpadding">0</xsl:attribute>
                                       <xsl:attribute name="cellspacing">0</xsl:attribute>
                                       <xsl:attribute name="width">320%</xsl:attribute>

                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">320%</xsl:attribute>
                                                <xsl:attribute name="align">center</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TR">
                                             <xsl:attribute name="id">Pay2</xsl:attribute>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">320%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:attribute name="class">prompt</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PaymentText']"/>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="colspan">1</xsl:attribute>
                                                <xsl:attribute name="height">12</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>

                                          <xsl:element name="TR">
                                             <xsl:attribute name="id">Pay3</xsl:attribute>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">320%</xsl:attribute>
                                                <xsl:attribute name="align">center</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:if test="(contains(/DATA/PARAM/@paymentoptions, 'A'))">
                                                      <xsl:element name="INPUT">
                                                      <xsl:attribute name="type">radio</xsl:attribute>
                                                      <xsl:attribute name="name">PayType</xsl:attribute>
                                                      <xsl:attribute name="id">PayType</xsl:attribute>
                                                      <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[ToggleType();]]></xsl:text></xsl:attribute>
                                                      <xsl:attribute name="value">1</xsl:attribute>
                                                      <xsl:if test="/DATA/TXN/PTSBILLING/@paytype=1">
                                                         <xsl:attribute name="CHECKED"/>
                                                      </xsl:if>
                                                      </xsl:element>
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/PayType1.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[CheckType(1);]]></xsl:text></xsl:attribute>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(contains(/DATA/PARAM/@paymentoptions, 'B'))">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:element name="INPUT">
                                                      <xsl:attribute name="type">radio</xsl:attribute>
                                                      <xsl:attribute name="name">PayType</xsl:attribute>
                                                      <xsl:attribute name="id">PayType</xsl:attribute>
                                                      <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[ToggleType();]]></xsl:text></xsl:attribute>
                                                      <xsl:attribute name="value">2</xsl:attribute>
                                                      <xsl:if test="/DATA/TXN/PTSBILLING/@paytype=2">
                                                         <xsl:attribute name="CHECKED"/>
                                                      </xsl:if>
                                                      </xsl:element>
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/PayType2.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[CheckType(2);]]></xsl:text></xsl:attribute>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(contains(/DATA/PARAM/@paymentoptions, 'C'))">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:element name="INPUT">
                                                      <xsl:attribute name="type">radio</xsl:attribute>
                                                      <xsl:attribute name="name">PayType</xsl:attribute>
                                                      <xsl:attribute name="id">PayType</xsl:attribute>
                                                      <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[ToggleType();]]></xsl:text></xsl:attribute>
                                                      <xsl:attribute name="value">3</xsl:attribute>
                                                      <xsl:if test="/DATA/TXN/PTSBILLING/@paytype=3">
                                                         <xsl:attribute name="CHECKED"/>
                                                      </xsl:if>
                                                      </xsl:element>
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/PayType3.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[CheckType(3);]]></xsl:text></xsl:attribute>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(contains(/DATA/PARAM/@paymentoptions, 'D'))">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:element name="INPUT">
                                                      <xsl:attribute name="type">radio</xsl:attribute>
                                                      <xsl:attribute name="name">PayType</xsl:attribute>
                                                      <xsl:attribute name="id">PayType</xsl:attribute>
                                                      <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[ToggleType();]]></xsl:text></xsl:attribute>
                                                      <xsl:attribute name="value">4</xsl:attribute>
                                                      <xsl:if test="/DATA/TXN/PTSBILLING/@paytype=4">
                                                         <xsl:attribute name="CHECKED"/>
                                                      </xsl:if>
                                                      </xsl:element>
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/PayType4.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[CheckType(4);]]></xsl:text></xsl:attribute>
                                                      </xsl:element>
                                                </xsl:if>
                                                <xsl:if test="(contains(/DATA/PARAM/@paymentoptions, 'E'))">
                                                      <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                      <xsl:element name="INPUT">
                                                      <xsl:attribute name="type">radio</xsl:attribute>
                                                      <xsl:attribute name="name">PayType</xsl:attribute>
                                                      <xsl:attribute name="id">PayType</xsl:attribute>
                                                      <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[ToggleType();]]></xsl:text></xsl:attribute>
                                                      <xsl:attribute name="value">5</xsl:attribute>
                                                      <xsl:if test="/DATA/TXN/PTSBILLING/@paytype=5">
                                                         <xsl:attribute name="CHECKED"/>
                                                      </xsl:if>
                                                      </xsl:element>
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/PayType5.gif</xsl:attribute>
                                                         <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
                                                         <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[CheckType(5);]]></xsl:text></xsl:attribute>
                                                      </xsl:element>
                                                </xsl:if>
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
                                 <xsl:attribute name="id">CardRows</xsl:attribute>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="width">100%</xsl:attribute>
                                    <xsl:attribute name="align">right</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="TABLE">
                                       <xsl:attribute name="border">0</xsl:attribute>
                                       <xsl:attribute name="cellpadding">0</xsl:attribute>
                                       <xsl:attribute name="cellspacing">0</xsl:attribute>
                                       <xsl:attribute name="width">100%</xsl:attribute>

                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">33%</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">67%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">33%</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CardNumber']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">67%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="class">bigtext</xsl:attribute>
                                                <xsl:attribute name="type">text</xsl:attribute>
                                                <xsl:attribute name="name">CardNumber</xsl:attribute>
                                                <xsl:attribute name="id">CardNumber</xsl:attribute>
                                                <xsl:attribute name="size">20</xsl:attribute>
                                                <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@cardnumber"/></xsl:attribute>
                                                <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[var x = this.value; if(x.tolowercase() != 'paypal'){this.value = x.replace(/[^\d]/g, '')};]]></xsl:text></xsl:attribute>
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
                                                <xsl:attribute name="width">33%</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CardMo']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">67%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="SELECT">
                                                <xsl:attribute name="class">bigtext</xsl:attribute>
                                                   <xsl:attribute name="name">CardMo</xsl:attribute>
                                                   <xsl:attribute name="id">CardMo</xsl:attribute>
                                                   <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/PTSBILLING/@cardmo"/></xsl:variable>
                                                   <xsl:element name="OPTION">
                                                      <xsl:attribute name="value"></xsl:attribute>
                                                      <xsl:if test="$tmp=''"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Select']"/>
                                                   </xsl:element>
                                                   <xsl:element name="OPTION">
                                                      <xsl:attribute name="value">1</xsl:attribute>
                                                      <xsl:if test="$tmp='1'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='January']"/>
                                                   </xsl:element>
                                                   <xsl:element name="OPTION">
                                                      <xsl:attribute name="value">2</xsl:attribute>
                                                      <xsl:if test="$tmp='2'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='February']"/>
                                                   </xsl:element>
                                                   <xsl:element name="OPTION">
                                                      <xsl:attribute name="value">3</xsl:attribute>
                                                      <xsl:if test="$tmp='3'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='March']"/>
                                                   </xsl:element>
                                                   <xsl:element name="OPTION">
                                                      <xsl:attribute name="value">4</xsl:attribute>
                                                      <xsl:if test="$tmp='4'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='April']"/>
                                                   </xsl:element>
                                                   <xsl:element name="OPTION">
                                                      <xsl:attribute name="value">5</xsl:attribute>
                                                      <xsl:if test="$tmp='5'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='May']"/>
                                                   </xsl:element>
                                                   <xsl:element name="OPTION">
                                                      <xsl:attribute name="value">6</xsl:attribute>
                                                      <xsl:if test="$tmp='6'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='June']"/>
                                                   </xsl:element>
                                                   <xsl:element name="OPTION">
                                                      <xsl:attribute name="value">7</xsl:attribute>
                                                      <xsl:if test="$tmp='7'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='July']"/>
                                                   </xsl:element>
                                                   <xsl:element name="OPTION">
                                                      <xsl:attribute name="value">8</xsl:attribute>
                                                      <xsl:if test="$tmp='8'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='August']"/>
                                                   </xsl:element>
                                                   <xsl:element name="OPTION">
                                                      <xsl:attribute name="value">9</xsl:attribute>
                                                      <xsl:if test="$tmp='9'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='September']"/>
                                                   </xsl:element>
                                                   <xsl:element name="OPTION">
                                                      <xsl:attribute name="value">10</xsl:attribute>
                                                      <xsl:if test="$tmp='10'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='October']"/>
                                                   </xsl:element>
                                                   <xsl:element name="OPTION">
                                                      <xsl:attribute name="value">11</xsl:attribute>
                                                      <xsl:if test="$tmp='11'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='November']"/>
                                                   </xsl:element>
                                                   <xsl:element name="OPTION">
                                                      <xsl:attribute name="value">12</xsl:attribute>
                                                      <xsl:if test="$tmp='12'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='December']"/>
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
                                                <xsl:attribute name="width">33%</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CardYr']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">67%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="SELECT">
                                                <xsl:attribute name="class">bigtext</xsl:attribute>
                                                   <xsl:attribute name="name">CardYr</xsl:attribute>
                                                   <xsl:attribute name="id">CardYr</xsl:attribute>
                                                   <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/PTSBILLING/@cardyr"/></xsl:variable>
                                                   <xsl:element name="OPTION">
                                                      <xsl:attribute name="value"></xsl:attribute>
                                                      <xsl:if test="$tmp=''"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Select']"/>
                                                   </xsl:element>
                                                   <xsl:element name="OPTION">
                                                      <xsl:attribute name="value">13</xsl:attribute>
                                                      <xsl:if test="$tmp='13'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='2013']"/>
                                                   </xsl:element>
                                                   <xsl:element name="OPTION">
                                                      <xsl:attribute name="value">14</xsl:attribute>
                                                      <xsl:if test="$tmp='14'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='2014']"/>
                                                   </xsl:element>
                                                   <xsl:element name="OPTION">
                                                      <xsl:attribute name="value">15</xsl:attribute>
                                                      <xsl:if test="$tmp='15'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='2015']"/>
                                                   </xsl:element>
                                                   <xsl:element name="OPTION">
                                                      <xsl:attribute name="value">16</xsl:attribute>
                                                      <xsl:if test="$tmp='16'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='2016']"/>
                                                   </xsl:element>
                                                   <xsl:element name="OPTION">
                                                      <xsl:attribute name="value">17</xsl:attribute>
                                                      <xsl:if test="$tmp='17'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='2017']"/>
                                                   </xsl:element>
                                                   <xsl:element name="OPTION">
                                                      <xsl:attribute name="value">18</xsl:attribute>
                                                      <xsl:if test="$tmp='18'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='2018']"/>
                                                   </xsl:element>
                                                   <xsl:element name="OPTION">
                                                      <xsl:attribute name="value">19</xsl:attribute>
                                                      <xsl:if test="$tmp='19'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='2019']"/>
                                                   </xsl:element>
                                                   <xsl:element name="OPTION">
                                                      <xsl:attribute name="value">20</xsl:attribute>
                                                      <xsl:if test="$tmp='20'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='2020']"/>
                                                   </xsl:element>
                                                   <xsl:element name="OPTION">
                                                      <xsl:attribute name="value">21</xsl:attribute>
                                                      <xsl:if test="$tmp='21'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='2021']"/>
                                                   </xsl:element>
                                                   <xsl:element name="OPTION">
                                                      <xsl:attribute name="value">22</xsl:attribute>
                                                      <xsl:if test="$tmp='22'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='2022']"/>
                                                   </xsl:element>
                                                   <xsl:element name="OPTION">
                                                      <xsl:attribute name="value">23</xsl:attribute>
                                                      <xsl:if test="$tmp='23'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='2023']"/>
                                                   </xsl:element>
                                                   <xsl:element name="OPTION">
                                                      <xsl:attribute name="value">24</xsl:attribute>
                                                      <xsl:if test="$tmp='24'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='2024']"/>
                                                   </xsl:element>
                                                   <xsl:element name="OPTION">
                                                      <xsl:attribute name="value">25</xsl:attribute>
                                                      <xsl:if test="$tmp='25'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='2025']"/>
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
                                                <xsl:attribute name="width">33%</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CardName']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">67%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="class">bigtext</xsl:attribute>
                                                <xsl:attribute name="type">text</xsl:attribute>
                                                <xsl:attribute name="name">CardName</xsl:attribute>
                                                <xsl:attribute name="id">CardName</xsl:attribute>
                                                <xsl:attribute name="size">20</xsl:attribute>
                                                <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@cardname"/></xsl:attribute>
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
                                                <xsl:attribute name="width">33%</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CardCode']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">67%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="class">bigtext</xsl:attribute>
                                                <xsl:attribute name="type">text</xsl:attribute>
                                                <xsl:attribute name="name">CardCode</xsl:attribute>
                                                <xsl:attribute name="id">CardCode</xsl:attribute>
                                                <xsl:attribute name="size">2</xsl:attribute>
                                                <xsl:attribute name="maxlength">4</xsl:attribute>
                                                <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@cardcode"/></xsl:attribute>
                                                <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[FormatCardCode(this);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">#</xsl:attribute>
                                                   <xsl:attribute name="class">tooltip</xsl:attribute>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/SymbolHelp.gif</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="SPAN">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/SecurityCode.png</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
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
                                 <xsl:attribute name="id">CheckRows</xsl:attribute>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="width">100%</xsl:attribute>
                                    <xsl:attribute name="align">right</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="TABLE">
                                       <xsl:attribute name="border">0</xsl:attribute>
                                       <xsl:attribute name="cellpadding">0</xsl:attribute>
                                       <xsl:attribute name="cellspacing">0</xsl:attribute>
                                       <xsl:attribute name="width">100%</xsl:attribute>

                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">33%</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">67%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">33%</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CheckBank']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">67%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="class">bigtext</xsl:attribute>
                                                <xsl:attribute name="type">text</xsl:attribute>
                                                <xsl:attribute name="name">CheckBank</xsl:attribute>
                                                <xsl:attribute name="id">CheckBank</xsl:attribute>
                                                <xsl:attribute name="size">20</xsl:attribute>
                                                <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@checkbank"/></xsl:attribute>
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
                                                <xsl:attribute name="width">33%</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CheckRoute']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">67%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="class">bigtext</xsl:attribute>
                                                <xsl:attribute name="type">text</xsl:attribute>
                                                <xsl:attribute name="name">CheckRoute</xsl:attribute>
                                                <xsl:attribute name="id">CheckRoute</xsl:attribute>
                                                <xsl:attribute name="size">20</xsl:attribute>
                                                <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@checkroute"/></xsl:attribute>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">#</xsl:attribute>
                                                   <xsl:attribute name="class">tooltip</xsl:attribute>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/SymbolHelp.gif</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="SPAN">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/checkref.gif</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
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

                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">33%</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CheckAccount']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">67%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="class">bigtext</xsl:attribute>
                                                <xsl:attribute name="type">text</xsl:attribute>
                                                <xsl:attribute name="name">CheckAccount</xsl:attribute>
                                                <xsl:attribute name="id">CheckAccount</xsl:attribute>
                                                <xsl:attribute name="size">20</xsl:attribute>
                                                <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@checkaccount"/></xsl:attribute>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="A">
                                                   <xsl:attribute name="href">#</xsl:attribute>
                                                   <xsl:attribute name="class">tooltip</xsl:attribute>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/SymbolHelp.gif</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:element name="SPAN">
                                                      <xsl:element name="IMG">
                                                         <xsl:attribute name="src">Images/checkref.gif</xsl:attribute>
                                                         <xsl:attribute name="border">0</xsl:attribute>
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

                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">33%</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CheckAcctType']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">67%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="SELECT">
                                                <xsl:attribute name="class">bigtext</xsl:attribute>
                                                   <xsl:attribute name="name">CheckAcctType</xsl:attribute>
                                                   <xsl:attribute name="id">CheckAcctType</xsl:attribute>
                                                   <xsl:for-each select="/DATA/TXN/PTSBILLING/PTSCHECKACCTTYPES/ENUM">
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
                                                <xsl:attribute name="colspan">2</xsl:attribute>
                                                <xsl:attribute name="height">6</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>

                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">33%</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CheckName']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">67%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="class">bigtext</xsl:attribute>
                                                <xsl:attribute name="type">text</xsl:attribute>
                                                <xsl:attribute name="name">CheckName</xsl:attribute>
                                                <xsl:attribute name="id">CheckName</xsl:attribute>
                                                <xsl:attribute name="size">20</xsl:attribute>
                                                <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@checkname"/></xsl:attribute>
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
                                 <xsl:attribute name="id">BillingAddress</xsl:attribute>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="width">100%</xsl:attribute>
                                    <xsl:attribute name="align">right</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="TABLE">
                                       <xsl:attribute name="border">0</xsl:attribute>
                                       <xsl:attribute name="cellpadding">0</xsl:attribute>
                                       <xsl:attribute name="cellspacing">0</xsl:attribute>
                                       <xsl:attribute name="width">100%</xsl:attribute>

                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">33%</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">67%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">33%</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BillingAddress']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">67%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="class">bigtext</xsl:attribute>
                                                <xsl:attribute name="type">text</xsl:attribute>
                                                <xsl:attribute name="name">Street1b</xsl:attribute>
                                                <xsl:attribute name="id">Street1b</xsl:attribute>
                                                <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@street1b"/></xsl:attribute>
                                                <xsl:attribute name="size">20</xsl:attribute>
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
                                                <xsl:attribute name="width">33%</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Street2']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">67%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="class">bigtext</xsl:attribute>
                                                <xsl:attribute name="type">text</xsl:attribute>
                                                <xsl:attribute name="name">Street2b</xsl:attribute>
                                                <xsl:attribute name="id">Street2b</xsl:attribute>
                                                <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@street2b"/></xsl:attribute>
                                                <xsl:attribute name="size">20</xsl:attribute>
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
                                                <xsl:attribute name="width">33%</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='City']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">67%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="class">bigtext</xsl:attribute>
                                                <xsl:attribute name="type">text</xsl:attribute>
                                                <xsl:attribute name="name">Cityb</xsl:attribute>
                                                <xsl:attribute name="id">Cityb</xsl:attribute>
                                                <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@cityb"/></xsl:attribute>
                                                <xsl:attribute name="size">20</xsl:attribute>
                                                <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[TitleCase(this);]]></xsl:text></xsl:attribute>
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
                                                <xsl:attribute name="width">33%</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='State']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">67%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="class">bigtext</xsl:attribute>
                                                <xsl:attribute name="type">text</xsl:attribute>
                                                <xsl:attribute name="name">Stateb</xsl:attribute>
                                                <xsl:attribute name="id">Stateb</xsl:attribute>
                                                <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@stateb"/></xsl:attribute>
                                                <xsl:attribute name="size">20</xsl:attribute>
                                                <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[TitleCase(this);]]></xsl:text></xsl:attribute>
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
                                                <xsl:attribute name="width">33%</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Zip']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">67%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="class">bigtext</xsl:attribute>
                                                <xsl:attribute name="type">text</xsl:attribute>
                                                <xsl:attribute name="name">Zipb</xsl:attribute>
                                                <xsl:attribute name="id">Zipb</xsl:attribute>
                                                <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@zipb"/></xsl:attribute>
                                                <xsl:attribute name="size">20</xsl:attribute>
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
                                                <xsl:attribute name="colspan">2</xsl:attribute>
                                                <xsl:attribute name="width">100%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CountryID']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                          </xsl:element>

                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="colspan">2</xsl:attribute>
                                                <xsl:attribute name="width">100%</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="SELECT">
                                                   <xsl:attribute name="name">CountryIDb</xsl:attribute>
                                                   <xsl:attribute name="id">CountryIDb</xsl:attribute>
                                                   <xsl:variable name="tmp"><xsl:value-of select="/DATA/PARAM/@countryidb"/></xsl:variable>
                                                   <xsl:for-each select="/DATA/TXN/PTSCOUNTRYS/ENUM">
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
                                 <xsl:attribute name="id">Secure</xsl:attribute>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="width">100%</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:attribute name="class">PageHeading</xsl:attribute>
                                    <xsl:element name="IMG">
                                       <xsl:attribute name="src">Images/padlock.gif</xsl:attribute>
                                       <xsl:attribute name="align">absmiddle</xsl:attribute>
                                       <xsl:attribute name="border">0</xsl:attribute>
                                    </xsl:element>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:element name="b">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SecurePayment']"/>
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
                                    <xsl:attribute name="width">100%</xsl:attribute>
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="height">1</xsl:attribute>
                                    <xsl:attribute name="bgcolor">#584b42</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:element name="TR">
                                 <xsl:attribute name="id">Agree2</xsl:attribute>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="width">100%</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="b">
                                    <xsl:element name="font">
                                       <xsl:attribute name="size">4</xsl:attribute>
                                       <xsl:attribute name="color">blue</xsl:attribute>
                                       <xsl:element name="INPUT">
                                       <xsl:attribute name="type">checkbox</xsl:attribute>
                                       <xsl:attribute name="name">IsAgree2</xsl:attribute>
                                       <xsl:attribute name="id">IsAgree2</xsl:attribute>
                                       <xsl:attribute name="value">1</xsl:attribute>
                                       <xsl:if test="(/DATA/PARAM/@isagree2 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsAgree2']"/>
                                       </xsl:element>
                                    </xsl:element>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>

                           </xsl:if>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="class">bigbutton</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Back']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[document.getElementById('NoValidate').value = 1; doSubmit(2,"");]]></xsl:text></xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="class">bigbutton</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Continue']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[document.getElementById('NoValidate').value = 0; doSubmit(4,"");]]></xsl:text></xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/PARAM/@mode = 5)">
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">IsAgree</xsl:attribute>
                                 <xsl:attribute name="id">IsAgree</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@isagree"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">NameFirst</xsl:attribute>
                                 <xsl:attribute name="id">NameFirst</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@namefirst"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">NameLast</xsl:attribute>
                                 <xsl:attribute name="id">NameLast</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@namelast"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CompanyName</xsl:attribute>
                                 <xsl:attribute name="id">CompanyName</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@companyname"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Email</xsl:attribute>
                                 <xsl:attribute name="id">Email</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@email"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Reference</xsl:attribute>
                                 <xsl:attribute name="id">Reference</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@reference"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Street1</xsl:attribute>
                                 <xsl:attribute name="id">Street1</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSADDRESS/@street1"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Street2</xsl:attribute>
                                 <xsl:attribute name="id">Street2</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSADDRESS/@street2"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">City</xsl:attribute>
                                 <xsl:attribute name="id">City</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSADDRESS/@city"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">State</xsl:attribute>
                                 <xsl:attribute name="id">State</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSADDRESS/@state"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Zip</xsl:attribute>
                                 <xsl:attribute name="id">Zip</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSADDRESS/@zip"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CountryID</xsl:attribute>
                                 <xsl:attribute name="id">CountryID</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSADDRESS/@countryid"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Phone1</xsl:attribute>
                                 <xsl:attribute name="id">Phone1</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@phone1"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">NewLogon</xsl:attribute>
                                 <xsl:attribute name="id">NewLogon</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@newlogon"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">NewPassword</xsl:attribute>
                                 <xsl:attribute name="id">NewPassword</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@newpassword"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Membership</xsl:attribute>
                                 <xsl:attribute name="id">Membership</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@membership"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">IsAgree2</xsl:attribute>
                                 <xsl:attribute name="id">IsAgree2</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@isagree2"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">PayType</xsl:attribute>
                                 <xsl:attribute name="id">PayType</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@paytype"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CardNumber</xsl:attribute>
                                 <xsl:attribute name="id">CardNumber</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@cardnumber"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CardMo</xsl:attribute>
                                 <xsl:attribute name="id">CardMo</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@cardmo"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CardYr</xsl:attribute>
                                 <xsl:attribute name="id">CardYr</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@cardyr"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CardName</xsl:attribute>
                                 <xsl:attribute name="id">CardName</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@cardname"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CardCode</xsl:attribute>
                                 <xsl:attribute name="id">CardCode</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@cardcode"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CheckBank</xsl:attribute>
                                 <xsl:attribute name="id">CheckBank</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@checkbank"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CheckRoute</xsl:attribute>
                                 <xsl:attribute name="id">CheckRoute</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@checkroute"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CheckAccount</xsl:attribute>
                                 <xsl:attribute name="id">CheckAccount</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@checkaccount"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CheckAcctType</xsl:attribute>
                                 <xsl:attribute name="id">CheckAcctType</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@checkaccttype"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CheckName</xsl:attribute>
                                 <xsl:attribute name="id">CheckName</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@checkname"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Street1b</xsl:attribute>
                                 <xsl:attribute name="id">Street1b</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@street1b"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Street2b</xsl:attribute>
                                 <xsl:attribute name="id">Street2b</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@street2b"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Cityb</xsl:attribute>
                                 <xsl:attribute name="id">Cityb</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@cityb"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Stateb</xsl:attribute>
                                 <xsl:attribute name="id">Stateb</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@stateb"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Zipb</xsl:attribute>
                                 <xsl:attribute name="id">Zipb</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@zipb"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">CountryIDb</xsl:attribute>
                                 <xsl:attribute name="id">CountryIDb</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@countryidb"/></xsl:attribute>
                              </xsl:element>
                           <xsl:if test="(/DATA/PARAM/@nobanner = 0)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="height">6</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="width">100%</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="IMG">
                                       <xsl:attribute name="src">Images/m_EnrollConfirm.png</xsl:attribute>
                                       <xsl:attribute name="border">0</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="height">6</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:if>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">100%</xsl:attribute>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">50%</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">50%</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">50%</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namefirst"/>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namelast"/>
                                                </xsl:element>
                                                <xsl:element name="BR"/>
                                                <xsl:value-of select="/DATA/TXN/PTSMEMBER/@companyname"/>
                                                <xsl:element name="BR"/>
                                                <xsl:value-of select="/DATA/TXN/PTSMEMBER/@email"/>
                                                <xsl:element name="BR"/>
                                                <xsl:if test="(/DATA/PARAM/@companyid = 7)">
                                                   <xsl:value-of select="/DATA/TXN/PTSMEMBER/@reference"/>
                                                   <xsl:element name="BR"/>
                                                </xsl:if>
                                                <xsl:value-of select="/DATA/TXN/PTSMEMBER/@phone1"/>
                                                <xsl:element name="BR"/>
                                                <xsl:value-of select="/DATA/TXN/PTSADDRESS/@street1"/>
                                                <xsl:element name="BR"/>
                                                <xsl:value-of select="/DATA/TXN/PTSADDRESS/@city"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/TXN/PTSADDRESS/@state"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/TXN/PTSADDRESS/@zip"/>
                                                <xsl:element name="BR"/>
                                                <xsl:value-of select="/DATA/PARAM/@countryname" disable-output-escaping="yes"/>
                                                <xsl:element name="BR"/>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Logon']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/TXN/PTSMEMBER/@newlogon"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/TXN/PTSMEMBER/@newpassword"/>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">50%</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:if test="(/DATA/PARAM/@nopayment = 0) and (/DATA/PARAM/@nobill = 0)">
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BillingInfo']"/>
                                                </xsl:element>
                                                <xsl:element name="BR"/>
                                             <xsl:if test="(/DATA/TXN/PTSBILLING/@paytype &gt;= 1) and (/DATA/TXN/PTSBILLING/@paytype &lt;= 4)">
                                                   <xsl:value-of select="/DATA/TXN/PTSBILLING/@cardnumber"/>
                                                   <xsl:element name="BR"/>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Expires']"/>
                                                   <xsl:text>:</xsl:text>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/TXN/PTSBILLING/@cardmo"/>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/TXN/PTSBILLING/@cardyr"/>
                                                   <xsl:element name="BR"/>
                                                   <xsl:value-of select="/DATA/TXN/PTSBILLING/@cardname"/>
                                                   <xsl:element name="BR"/>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Code']"/>
                                                   <xsl:text>:</xsl:text>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/TXN/PTSBILLING/@cardcode"/>
                                                   <xsl:element name="BR"/>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSBILLING/@paytype = 5)">
                                                   <xsl:value-of select="/DATA/TXN/PTSBILLING/@checkbank"/>
                                                   <xsl:element name="BR"/>
                                                   <xsl:value-of select="/DATA/TXN/PTSBILLING/@checkroute"/>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/TXN/PTSBILLING/@checkaccount"/>
                                                   <xsl:element name="BR"/>
                                                   <xsl:if test="(/DATA/TXN/PTSBILLING/@checkaccttype = 1)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Checking']"/>
                                                   </xsl:if>
                                                   <xsl:if test="(/DATA/TXN/PTSBILLING/@checkaccttype = 2)">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Savings']"/>
                                                   </xsl:if>
                                                   <xsl:element name="BR"/>
                                                   <xsl:value-of select="/DATA/TXN/PTSBILLING/@checkname"/>
                                                   <xsl:element name="BR"/>
                                             </xsl:if>
                                                <xsl:value-of select="/DATA/PARAM/@street1b" disable-output-escaping="yes"/>
                                                <xsl:element name="BR"/>
                                                <xsl:value-of select="/DATA/PARAM/@cityb" disable-output-escaping="yes"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/PARAM/@stateb" disable-output-escaping="yes"/>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:value-of select="/DATA/PARAM/@zipb" disable-output-escaping="yes"/>
                                                <xsl:element name="BR"/>
                                                <xsl:value-of select="/DATA/PARAM/@countrynameb" disable-output-escaping="yes"/>
                                                <xsl:element name="BR"/><xsl:element name="BR"/>
                                             </xsl:if>
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
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">1</xsl:attribute>
                                 <xsl:attribute name="bgcolor">#584b42</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:if test="(/DATA/PARAM/@companyid = 7)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="width">100%</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:attribute name="class">PageHeading</xsl:attribute>
                                    <xsl:if test="(/DATA/PARAM/@nobill = 0)">
                                          <xsl:if test="(/DATA/PARAM/@membership = 1)">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership7_1']"/>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@membership = 3)">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership7_3']"/>
                                          </xsl:if>
                                    </xsl:if>
                                    <xsl:if test="(/DATA/PARAM/@nobill != 0)">
                                          <xsl:if test="(/DATA/PARAM/@membership = 1)">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership7_1a']"/>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@membership = 3)">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership7_3a']"/>
                                          </xsl:if>
                                    </xsl:if>
                                 </xsl:element>
                              </xsl:element>

                           </xsl:if>
                           <xsl:if test="(/DATA/PARAM/@companyid = 18)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="width">100%</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:attribute name="class">PageHeading</xsl:attribute>
                                       <xsl:if test="(/DATA/PARAM/@membership = 1)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership18_1']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@membership = 2)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership18_2']"/>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@membership = 3)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership18_3']"/>
                                       </xsl:if>
                                 </xsl:element>
                              </xsl:element>

                           </xsl:if>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Back']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[document.getElementById('NoValidate').value = 1; doSubmit(3,"");]]></xsl:text></xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Confirm']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[this.disabled = true; doSubmit(5,"");]]></xsl:text></xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/PARAM/@mode = 6)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/TXN/PTSHTMLFILE/DATA/comment()" disable-output-escaping="yes"/>
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
                                 <xsl:attribute name="width">100%</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
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
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
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