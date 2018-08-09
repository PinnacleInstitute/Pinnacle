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
         <xsl:attribute name="href">include/StyleSheetJoin.css</xsl:attribute>
      </xsl:element>

      <xsl:call-template name="HTMLHeading">
         <xsl:with-param name="pagename" select="'New Customer'"/>
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
               <xsl:attribute name="name">TellAll</xsl:attribute>
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
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ToggleType(){ 
               var payobj = TellAll.elements['PayType'];
               if( payobj != null ) {
                  var VisibleCard = 'none'; var VisibleCheck = 'none'; var VisibleCash = 'none'; var VisibleWallet = 'none'; var VisibleBitCoin = 'none'; var VisibleAddress = 'none';
                  var paytype=1;
                  var l = payobj.length;
                  if( l == null ) {
                     if( payobj.checked ) {
                        paytype = payobj.value
                     }
                  }
                  else {
                  for( i = 0; i < l; i++ ) {
                        if (payobj[i].checked) {
                           paytype = payobj[i].value;
                           i = l;
                        }
                     }
                  }
                  if (paytype >= 1 && paytype <= 4) VisibleCard = '';
                  if (paytype == 5) VisibleCheck = '';
                  if (paytype == 7) VisibleCash = '';
                  if (paytype <= 5) VisibleAddress = '';
                  if (paytype >= 11 && paytype <= 13) VisibleWallet = '';
                  if (paytype == 14) VisibleBitCoin = '';
                  document.getElementById('CardRows').style.display = VisibleCard;
                  document.getElementById('CheckRows').style.display = VisibleCheck;
                  document.getElementById('WalletRows').style.display = VisibleWallet;
                  document.getElementById('BitCoinRows').style.display = VisibleBitCoin;
                  document.getElementById('CashRows').style.display = VisibleCash;
                  document.getElementById('BillingAddress').style.display = VisibleAddress;
               }
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function CheckType(val){ 
               var payobj = TellAll.elements['PayType'];
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
               if( membership == 5 ) { disp = '' } else { disp = 'none' }
               document.getElementById('CCRequired').style.display = disp;
               if( membership == 5 ) { disp = 'none' } else { disp = '' }
               document.getElementById('Agree2').style.display = disp;
               //document.getElementById('Payment').style.display = disp;
               //document.getElementById('CardRows').style.display = disp;
               //document.getElementById('Secure').style.display = disp;
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ShowSIMNumber(){ 
               var list = document.getElementById('Data2');
               var simtype = list[list.selectedIndex].value;
               var disabled = true;
               if( simtype == 'My-Own' ) {disabled = false;}
               document.getElementById('Data3').disabled = disabled;
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ShowPhoneOptions(){ 
               var RadioButtons = TellAll.elements['Data1'];
               var length = RadioButtons.length
               var val = 1
               var disabled = true;
               for(var i = 0; i < length; i++) {
                  if(RadioButtons[i].checked) {val = RadioButtons[i].value;}
               }
               if( val == 1 ) disabled = false;
               document.getElementById('Data2').disabled = disabled;
               document.getElementById('Data3').disabled = disabled;
               document.getElementById('Data4').disabled = disabled;
               document.getElementById('Data5').disabled = disabled;
               document.getElementById('Data6').disabled = disabled;
               document.getElementById('Data7').disabled = disabled;
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ShowPhoneNumberOptions(){ 
               var RadioButtons = TellAll.elements['Data8'];
               var length = RadioButtons.length
               var val = 1
               var disabled = true;
               for(var i = 0; i < length; i++) {
                  if(RadioButtons[i].checked) {val = RadioButtons[i].value;}
               }
               var disabled = true;
               var disabled2 = false;
               if( val == 1 ) { disabled = false; disabled2 = true;}
               document.getElementById('Data9').disabled = disabled2;
               document.getElementById('Data10').disabled = disabled;
               document.getElementById('Data11').disabled = disabled;
               document.getElementById('Data12').disabled = disabled;
               document.getElementById('Data13').disabled = disabled;
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
               if( mode == 3 ) {
               ShowPhoneOptions();
               ShowSIMNumber();
               ShowPhoneNumberOptions();
               }
               if( mode == 4 ) {
               ToggleType();
               //ShowCC();
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
                     <xsl:attribute name="width">10</xsl:attribute>
                  </xsl:element>

                  <xsl:element name="TD">
                     <xsl:attribute name="valign">top</xsl:attribute>
                     <xsl:attribute name="width">750</xsl:attribute>

                     <xsl:element name="TABLE">
                        <xsl:attribute name="border">0</xsl:attribute>
                        <xsl:attribute name="cellpadding">0</xsl:attribute>
                        <xsl:attribute name="cellspacing">0</xsl:attribute>
                        <xsl:attribute name="width">750</xsl:attribute>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">50</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">160</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">540</xsl:attribute>
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
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">ReferredBy</xsl:attribute>
                              <xsl:attribute name="id">ReferredBy</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@referredby"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Placement</xsl:attribute>
                              <xsl:attribute name="id">Placement</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@placement"/></xsl:attribute>
                           </xsl:element>

                        <xsl:if test="(/DATA/PARAM/@badpayment != 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="width">750</xsl:attribute>
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
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="(/DATA/PARAM/@mode = 0) and (/DATA/PARAM/@referredby = '')">
                           <xsl:if test="(/DATA/PARAM/@getmemberid != 0)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">24</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="width">750</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:attribute name="class">PageHeading</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='GetMemberID']"/>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">6</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">50</xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">160</xsl:attribute>
                                    <xsl:attribute name="align">right</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MemberID']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">540</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="INPUT">
                                    <xsl:attribute name="type">text</xsl:attribute>
                                    <xsl:attribute name="name">MemberID</xsl:attribute>
                                    <xsl:attribute name="id">MemberID</xsl:attribute>
                                    <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@memberid"/></xsl:attribute>
                                    <xsl:attribute name="size">6</xsl:attribute>
                                    <xsl:attribute name="onfocus"><xsl:text disable-output-escaping="yes"><![CDATA[if(this.value==0){this.value=''}]]></xsl:text></xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="width">750</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="INPUT">
                                       <xsl:attribute name="type">button</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Continue']"/>
                                       </xsl:attribute>
                                       <xsl:attribute name="onclick">doSubmit(0,"")</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>

                           </xsl:if>
                           <xsl:if test="(/DATA/PARAM/@getmemberid = 0)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">24</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="width">750</xsl:attribute>
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

                           </xsl:if>
                        </xsl:if>
                        <xsl:if test="(/DATA/PARAM/@mode = 1)">
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">M</xsl:attribute>
                                 <xsl:attribute name="id">M</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@m"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Membership</xsl:attribute>
                                 <xsl:attribute name="id">Membership</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@membership"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">OrderOption</xsl:attribute>
                                 <xsl:attribute name="id">OrderOption</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@orderoption"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">BillDay</xsl:attribute>
                                 <xsl:attribute name="id">BillDay</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@billday"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">PayType</xsl:attribute>
                                 <xsl:attribute name="id">PayType</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@paytype"/></xsl:attribute>
                              </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/TXN/PTSHTMLFILE/DATA/comment()" disable-output-escaping="yes"/>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">1</xsl:attribute>
                                 <xsl:attribute name="bgcolor">#584b42</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:if test="(/DATA/PARAM/@referredby != '')">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="width">750</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="b">
                                       <xsl:element name="font">
                                          <xsl:attribute name="size">3</xsl:attribute>
                                          <xsl:attribute name="color">blue</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ReferredBy']"/>
                                       <xsl:text>:</xsl:text>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/PARAM/@referredby" disable-output-escaping="yes"/>
                                       </xsl:element>
                                    <xsl:if test="(/DATA/PARAM/@placement != '')">
                                          <xsl:element name="BR"/>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Placement']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          <xsl:value-of select="/DATA/PARAM/@placement" disable-output-escaping="yes"/>
                                    </xsl:if>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:if>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="b">
                                 <xsl:element name="font">
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
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="width">750</xsl:attribute>
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
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/PARAM/@mode = 2)">
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">M</xsl:attribute>
                                 <xsl:attribute name="id">M</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@m"/></xsl:attribute>
                              </xsl:element>
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
                                 <xsl:attribute name="name">OrderOption</xsl:attribute>
                                 <xsl:attribute name="id">OrderOption</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@orderoption"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">BillDay</xsl:attribute>
                                 <xsl:attribute name="id">BillDay</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@billday"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">IsAgree2</xsl:attribute>
                                 <xsl:attribute name="id">IsAgree2</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@isagree2"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Wallet</xsl:attribute>
                                 <xsl:attribute name="id">Wallet</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@wallet"/></xsl:attribute>
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
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data1</xsl:attribute>
                                 <xsl:attribute name="id">Data1</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data1"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data2</xsl:attribute>
                                 <xsl:attribute name="id">Data2</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data2"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data3</xsl:attribute>
                                 <xsl:attribute name="id">Data3</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data3"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data4</xsl:attribute>
                                 <xsl:attribute name="id">Data4</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data4"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data5</xsl:attribute>
                                 <xsl:attribute name="id">Data5</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data5"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data6</xsl:attribute>
                                 <xsl:attribute name="id">Data6</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data6"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data7</xsl:attribute>
                                 <xsl:attribute name="id">Data7</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data7"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data8</xsl:attribute>
                                 <xsl:attribute name="id">Data8</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data8"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data9</xsl:attribute>
                                 <xsl:attribute name="id">Data9</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data9"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data10</xsl:attribute>
                                 <xsl:attribute name="id">Data10</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data10"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data11</xsl:attribute>
                                 <xsl:attribute name="id">Data11</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data11"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data12</xsl:attribute>
                                 <xsl:attribute name="id">Data12</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data12"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data13</xsl:attribute>
                                 <xsl:attribute name="id">Data13</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data13"/></xsl:attribute>
                              </xsl:element>
                           <xsl:if test="(/DATA/PARAM/@nobanner = 0)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">6</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="width">750</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="IMG">
                                       <xsl:attribute name="src">Images/EnrollContact.png</xsl:attribute>
                                       <xsl:attribute name="border">0</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">6</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:if>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">50</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">700</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">prompt</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewMemberText']"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">750</xsl:attribute>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">50</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="class">InputHeading</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NameFirst']"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">340</xsl:attribute>
                                          <xsl:attribute name="class">InputHeading</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NameLast']"/>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">50</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                          <xsl:attribute name="align">right</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MemberName']"/>
                                          <xsl:text>:</xsl:text>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">NameFirst</xsl:attribute>
                                          <xsl:attribute name="id">NameFirst</xsl:attribute>
                                          <xsl:attribute name="size">25</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@namefirst"/></xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[if(this.value==''){alert('Oops, First Name Required!')};TitleCase(this);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">340</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">NameLast</xsl:attribute>
                                          <xsl:attribute name="id">NameLast</xsl:attribute>
                                          <xsl:attribute name="size">25</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@namelast"/></xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[if(this.value==''){alert('Oops, Last Name Required!')};TitleCase(this);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">50</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">160</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Email']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">540</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">Email</xsl:attribute>
                                 <xsl:attribute name="id">Email</xsl:attribute>
                                 <xsl:attribute name="size">60</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@email"/></xsl:attribute>
                                 <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[if(this.value==''){alert('Oops, Email Required!')};]]></xsl:text></xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">50</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">160</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Address']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">540</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">Street1</xsl:attribute>
                                 <xsl:attribute name="id">Street1</xsl:attribute>
                                 <xsl:attribute name="size">60</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSADDRESS/@street1"/></xsl:attribute>
                                 <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[if(this.value==''){alert('Oops, Mailing Address Required!')}; document.getElementById('Street1b').value = this.value;]]></xsl:text></xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">50</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">160</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">540</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">Street2</xsl:attribute>
                                 <xsl:attribute name="id">Street2</xsl:attribute>
                                 <xsl:attribute name="size">60</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSADDRESS/@street2"/></xsl:attribute>
                                 <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[document.getElementById('Street2b').value = this.value;]]></xsl:text></xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">750</xsl:attribute>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">50</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="class">InputHeading</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='City']"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">340</xsl:attribute>
                                          <xsl:attribute name="class">InputHeading</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='State']"/>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">50</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">City</xsl:attribute>
                                          <xsl:attribute name="id">City</xsl:attribute>
                                          <xsl:attribute name="size">27</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSADDRESS/@city"/></xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[if(this.value==''){alert('Oops, City Required!');}else{TitleCase(this);}; document.getElementById('Cityb').value = this.value;]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">340</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">State</xsl:attribute>
                                          <xsl:attribute name="id">State</xsl:attribute>
                                          <xsl:attribute name="size">27</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSADDRESS/@state"/></xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[if(this.value==''){alert('Oops, State Required!');}else{TitleCase(this);}; document.getElementById('Stateb').value = this.value;]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">750</xsl:attribute>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">50</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">100</xsl:attribute>
                                          <xsl:attribute name="class">InputHeading</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Zip']"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
                                          <xsl:attribute name="class">InputHeading</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CountryID']"/>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="TR">
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">50</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">160</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">100</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">Zip</xsl:attribute>
                                          <xsl:attribute name="id">Zip</xsl:attribute>
                                          <xsl:attribute name="size">8</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSADDRESS/@zip"/></xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[if(this.value==''){alert('Oops, Postal Code Required!')}; document.getElementById('Zipb').value = this.value;]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">440</xsl:attribute>
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
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">50</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">160</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Phone']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">540</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
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
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">1</xsl:attribute>
                                 <xsl:attribute name="bgcolor">#584b42</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">50</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">700</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">prompt</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LogonText']"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">50</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">160</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewLogon']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">540</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">prompt</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">NewLogon</xsl:attribute>
                                 <xsl:attribute name="id">NewLogon</xsl:attribute>
                                 <xsl:attribute name="size">20</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@newlogon"/></xsl:attribute>
                                 <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[FormatLogon(this);]]></xsl:text></xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LogonTip']"/>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">50</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">160</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewPassword']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">540</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">prompt</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">NewPassword</xsl:attribute>
                                 <xsl:attribute name="id">NewPassword</xsl:attribute>
                                 <xsl:attribute name="size">20</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@newpassword"/></xsl:attribute>
                                 <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[if(this.value==''){alert('Oops, Password Required!');}]]></xsl:text></xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PasswordText']"/>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Continue']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[document.getElementById('NoValidate').value = 0; doSubmit(2,"");]]></xsl:text></xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/PARAM/@mode = 3)">
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">M</xsl:attribute>
                                 <xsl:attribute name="id">M</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@m"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">IsAgree</xsl:attribute>
                                 <xsl:attribute name="id">IsAgree</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@isagree"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Wallet</xsl:attribute>
                                 <xsl:attribute name="id">Wallet</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@wallet"/></xsl:attribute>
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
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">6</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="width">750</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="IMG">
                                       <xsl:attribute name="src">Images/EnrollMembership.png</xsl:attribute>
                                       <xsl:attribute name="border">0</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">6</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:if>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">750</xsl:attribute>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">30</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">30</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">690</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">3</xsl:attribute>
                                             <xsl:attribute name="height">12</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">30</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">3</xsl:attribute>
                                             <xsl:attribute name="width">720</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:element name="font">
                                                <xsl:attribute name="size">4</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PHONEPLAN']"/>
                                             </xsl:element>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">3</xsl:attribute>
                                             <xsl:attribute name="height">12</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">30</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">30</xsl:attribute>
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
                                             <xsl:attribute name="width">690</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership19_1']"/>
                                                </xsl:element>
                                                <xsl:element name="BR"/>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership19_1a']"/>
                                                <xsl:element name="BR"/>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership19_1b']"/>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">3</xsl:attribute>
                                             <xsl:attribute name="height">12</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">30</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">30</xsl:attribute>
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
                                             <xsl:attribute name="width">690</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership19_2']"/>
                                                </xsl:element>
                                                <xsl:element name="BR"/>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership19_2a']"/>
                                                <xsl:element name="BR"/>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership19_2b']"/>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">3</xsl:attribute>
                                             <xsl:attribute name="height">12</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">30</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">30</xsl:attribute>
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
                                             <xsl:attribute name="width">690</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership19_3']"/>
                                                </xsl:element>
                                                <xsl:element name="BR"/>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership19_3a']"/>
                                                <xsl:element name="BR"/>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership19_3b']"/>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">3</xsl:attribute>
                                             <xsl:attribute name="height">12</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">30</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">30</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">radio</xsl:attribute>
                                             <xsl:attribute name="name">Membership</xsl:attribute>
                                             <xsl:attribute name="id">Membership</xsl:attribute>
                                             <xsl:attribute name="value">4</xsl:attribute>
                                             <xsl:if test="/DATA/PARAM/@membership=4">
                                                <xsl:attribute name="CHECKED"/>
                                             </xsl:if>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">690</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="b">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership19_4']"/>
                                                </xsl:element>
                                                <xsl:element name="BR"/>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership19_4a']"/>
                                                <xsl:element name="BR"/>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership19_4b']"/>
                                          </xsl:element>
                                       </xsl:element>

                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">750</xsl:attribute>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">30</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">30</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">160</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">530</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">4</xsl:attribute>
                                             <xsl:attribute name="height">12</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">30</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">3</xsl:attribute>
                                             <xsl:attribute name="width">720</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:element name="font">
                                                <xsl:attribute name="size">4</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PHONE']"/>
                                             </xsl:element>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">4</xsl:attribute>
                                             <xsl:attribute name="height">12</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">30</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">30</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">radio</xsl:attribute>
                                             <xsl:attribute name="name">Data1</xsl:attribute>
                                             <xsl:attribute name="id">Data1</xsl:attribute>
                                             <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[ShowPhoneOptions()]]></xsl:text></xsl:attribute>
                                             <xsl:attribute name="value">2</xsl:attribute>
                                             <xsl:if test="/DATA/PARAM/@data1=2">
                                                <xsl:attribute name="CHECKED"/>
                                             </xsl:if>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="width">690</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewPhone']"/>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">4</xsl:attribute>
                                             <xsl:attribute name="height">12</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">30</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">30</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">radio</xsl:attribute>
                                             <xsl:attribute name="name">Data1</xsl:attribute>
                                             <xsl:attribute name="id">Data1</xsl:attribute>
                                             <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[ShowPhoneOptions()]]></xsl:text></xsl:attribute>
                                             <xsl:attribute name="value">1</xsl:attribute>
                                             <xsl:if test="/DATA/PARAM/@data1=1">
                                                <xsl:attribute name="CHECKED"/>
                                             </xsl:if>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="width">690</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MyPhone']"/>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">4</xsl:attribute>
                                             <xsl:attribute name="height">6</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="width">60</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">160</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SimType']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">530</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="SELECT">
                                                <xsl:attribute name="name">Data2</xsl:attribute>
                                                <xsl:attribute name="id">Data2</xsl:attribute>
                                                <xsl:attribute name="onchange"><xsl:text disable-output-escaping="yes"><![CDATA[ShowSIMNumber()]]></xsl:text></xsl:attribute>
                                                <xsl:variable name="tmp"><xsl:value-of select="/DATA/PARAM/@data2"/></xsl:variable>
                                                <xsl:element name="OPTION">
                                                   <xsl:attribute name="value"></xsl:attribute>
                                                   <xsl:if test="$tmp=''"><xsl:attribute name="SELECTED"/></xsl:if>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Select']"/>
                                                </xsl:element>
                                                <xsl:element name="OPTION">
                                                   <xsl:attribute name="value">Standard-Sim</xsl:attribute>
                                                   <xsl:if test="$tmp='Standard-Sim'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StandardSim']"/>
                                                </xsl:element>
                                                <xsl:element name="OPTION">
                                                   <xsl:attribute name="value">Micro-Sim</xsl:attribute>
                                                   <xsl:if test="$tmp='Micro-Sim'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MicroSim']"/>
                                                </xsl:element>
                                                <xsl:element name="OPTION">
                                                   <xsl:attribute name="value">Nano-Sim</xsl:attribute>
                                                   <xsl:if test="$tmp='Nano-Sim'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NanoSim']"/>
                                                </xsl:element>
                                                <xsl:element name="OPTION">
                                                   <xsl:attribute name="value">My-Own</xsl:attribute>
                                                   <xsl:if test="$tmp='My-Own'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MyOwnSIM']"/>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SimNumber']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">text</xsl:attribute>
                                             <xsl:attribute name="name">Data3</xsl:attribute>
                                             <xsl:attribute name="id">Data3</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data3"/></xsl:attribute>
                                             <xsl:attribute name="maxlength">19</xsl:attribute>
                                             <xsl:attribute name="size">20</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">4</xsl:attribute>
                                             <xsl:attribute name="height">6</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="width">60</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">160</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PhoneLocked']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">530</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:attribute name="class">prompt</xsl:attribute>
                                             <xsl:element name="SELECT">
                                                <xsl:attribute name="name">Data4</xsl:attribute>
                                                <xsl:attribute name="id">Data4</xsl:attribute>
                                                <xsl:variable name="tmp"><xsl:value-of select="/DATA/PARAM/@data4"/></xsl:variable>
                                                <xsl:element name="OPTION">
                                                   <xsl:attribute name="value"></xsl:attribute>
                                                   <xsl:if test="$tmp=''"><xsl:attribute name="SELECTED"/></xsl:if>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Select']"/>
                                                </xsl:element>
                                                <xsl:element name="OPTION">
                                                   <xsl:attribute name="value">Locked</xsl:attribute>
                                                   <xsl:if test="$tmp='Locked'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LockedYes']"/>
                                                </xsl:element>
                                                <xsl:element name="OPTION">
                                                   <xsl:attribute name="value">Unlocked</xsl:attribute>
                                                   <xsl:if test="$tmp='Unlocked'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LockedNo']"/>
                                                </xsl:element>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PhoneLockedText']"/>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">4</xsl:attribute>
                                             <xsl:attribute name="height">6</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="width">60</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">160</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PhoneBrand']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">530</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">text</xsl:attribute>
                                             <xsl:attribute name="name">Data5</xsl:attribute>
                                             <xsl:attribute name="id">Data5</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data5"/></xsl:attribute>
                                             <xsl:attribute name="size">20</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">4</xsl:attribute>
                                             <xsl:attribute name="height">6</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="width">60</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">160</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PhoneModel']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">530</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">text</xsl:attribute>
                                             <xsl:attribute name="name">Data6</xsl:attribute>
                                             <xsl:attribute name="id">Data6</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data6"/></xsl:attribute>
                                             <xsl:attribute name="size">20</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">4</xsl:attribute>
                                             <xsl:attribute name="height">6</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="width">60</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">160</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PhoneIMIE']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">530</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:attribute name="class">prompt</xsl:attribute>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">text</xsl:attribute>
                                             <xsl:attribute name="name">Data7</xsl:attribute>
                                             <xsl:attribute name="id">Data7</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data7"/></xsl:attribute>
                                             <xsl:attribute name="size">20</xsl:attribute>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PhoneIMIEText']"/>
                                          </xsl:element>
                                       </xsl:element>

                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">750</xsl:attribute>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">30</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">30</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">160</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">530</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">4</xsl:attribute>
                                             <xsl:attribute name="height">12</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">30</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">3</xsl:attribute>
                                             <xsl:attribute name="width">720</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:element name="font">
                                                <xsl:attribute name="size">4</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PHONENUMBER']"/>
                                             </xsl:element>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">4</xsl:attribute>
                                             <xsl:attribute name="height">12</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">30</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">30</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">radio</xsl:attribute>
                                             <xsl:attribute name="name">Data8</xsl:attribute>
                                             <xsl:attribute name="id">Data8</xsl:attribute>
                                             <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[ShowPhoneNumberOptions()]]></xsl:text></xsl:attribute>
                                             <xsl:attribute name="value">2</xsl:attribute>
                                             <xsl:if test="/DATA/PARAM/@data8=2">
                                                <xsl:attribute name="CHECKED"/>
                                             </xsl:if>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="width">690</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewPhoneNumber']"/>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">4</xsl:attribute>
                                             <xsl:attribute name="height">6</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="width">60</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">160</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AreaCode']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">530</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">text</xsl:attribute>
                                             <xsl:attribute name="name">Data9</xsl:attribute>
                                             <xsl:attribute name="id">Data9</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data9"/></xsl:attribute>
                                             <xsl:attribute name="size">10</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">4</xsl:attribute>
                                             <xsl:attribute name="height">12</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">30</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">30</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">top</xsl:attribute>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">radio</xsl:attribute>
                                             <xsl:attribute name="name">Data8</xsl:attribute>
                                             <xsl:attribute name="id">Data8</xsl:attribute>
                                             <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[ShowPhoneNumberOptions()]]></xsl:text></xsl:attribute>
                                             <xsl:attribute name="value">1</xsl:attribute>
                                             <xsl:if test="/DATA/PARAM/@data8=1">
                                                <xsl:attribute name="CHECKED"/>
                                             </xsl:if>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="width">690</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="b">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MyPhoneNumber']"/>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">4</xsl:attribute>
                                             <xsl:attribute name="height">6</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="width">60</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">160</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PhoneNumber']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">530</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">text</xsl:attribute>
                                             <xsl:attribute name="name">Data10</xsl:attribute>
                                             <xsl:attribute name="id">Data10</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data10"/></xsl:attribute>
                                             <xsl:attribute name="size">20</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">4</xsl:attribute>
                                             <xsl:attribute name="height">6</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="width">60</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">160</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PhoneProvider']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">530</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">text</xsl:attribute>
                                             <xsl:attribute name="name">Data11</xsl:attribute>
                                             <xsl:attribute name="id">Data11</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data11"/></xsl:attribute>
                                             <xsl:attribute name="size">20</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">4</xsl:attribute>
                                             <xsl:attribute name="height">6</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="width">60</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">160</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ProviderAccount']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">530</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">text</xsl:attribute>
                                             <xsl:attribute name="name">Data12</xsl:attribute>
                                             <xsl:attribute name="id">Data12</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data12"/></xsl:attribute>
                                             <xsl:attribute name="size">20</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">4</xsl:attribute>
                                             <xsl:attribute name="height">6</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="width">60</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">160</xsl:attribute>
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ProviderPswd']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">530</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:attribute name="class">prompt</xsl:attribute>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">text</xsl:attribute>
                                             <xsl:attribute name="name">Data13</xsl:attribute>
                                             <xsl:attribute name="id">Data13</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data13"/></xsl:attribute>
                                             <xsl:attribute name="size">20</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="colspan">4</xsl:attribute>
                                             <xsl:attribute name="height">12</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">750</xsl:attribute>
                                             <xsl:attribute name="colspan">5</xsl:attribute>
                                             <xsl:attribute name="height">1</xsl:attribute>
                                             <xsl:attribute name="bgcolor">#584b42</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>

                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Back']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[document.getElementById('NoValidate').value = 1; doSubmit(1,"");]]></xsl:text></xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Continue']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[document.getElementById('NoValidate').value = 0; doSubmit(3,"");]]></xsl:text></xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/PARAM/@mode = 4)">
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">M</xsl:attribute>
                                 <xsl:attribute name="id">M</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@m"/></xsl:attribute>
                              </xsl:element>
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
                                 <xsl:attribute name="name">OrderOption</xsl:attribute>
                                 <xsl:attribute name="id">OrderOption</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@orderoption"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data1</xsl:attribute>
                                 <xsl:attribute name="id">Data1</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data1"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data2</xsl:attribute>
                                 <xsl:attribute name="id">Data2</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data2"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data3</xsl:attribute>
                                 <xsl:attribute name="id">Data3</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data3"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data4</xsl:attribute>
                                 <xsl:attribute name="id">Data4</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data4"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data5</xsl:attribute>
                                 <xsl:attribute name="id">Data5</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data5"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data6</xsl:attribute>
                                 <xsl:attribute name="id">Data6</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data6"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data7</xsl:attribute>
                                 <xsl:attribute name="id">Data7</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data7"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data8</xsl:attribute>
                                 <xsl:attribute name="id">Data8</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data8"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data9</xsl:attribute>
                                 <xsl:attribute name="id">Data9</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data9"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data10</xsl:attribute>
                                 <xsl:attribute name="id">Data10</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data10"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data11</xsl:attribute>
                                 <xsl:attribute name="id">Data11</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data11"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data12</xsl:attribute>
                                 <xsl:attribute name="id">Data12</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data12"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data13</xsl:attribute>
                                 <xsl:attribute name="id">Data13</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data13"/></xsl:attribute>
                              </xsl:element>
                           <xsl:if test="(/DATA/PARAM/@nobanner = 0)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">6</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="width">750</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="IMG">
                                       <xsl:attribute name="src">Images/EnrollPayment.png</xsl:attribute>
                                       <xsl:attribute name="border">0</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">6</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:if>

                           <xsl:if test="(/DATA/PARAM/@nobill = 0)">
                              <xsl:element name="TR">
                                 <xsl:attribute name="id">Payment</xsl:attribute>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="width">750</xsl:attribute>
                                    <xsl:attribute name="align">right</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="TABLE">
                                       <xsl:attribute name="border">0</xsl:attribute>
                                       <xsl:attribute name="cellpadding">0</xsl:attribute>
                                       <xsl:attribute name="cellspacing">0</xsl:attribute>
                                       <xsl:attribute name="width">750</xsl:attribute>

                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">750</xsl:attribute>
                                                <xsl:attribute name="align">center</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TR">
                                             <xsl:attribute name="id">Pay2</xsl:attribute>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">750</xsl:attribute>
                                                <xsl:attribute name="align">center</xsl:attribute>
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
                                                <xsl:attribute name="width">750</xsl:attribute>
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
                                                <xsl:if test="(contains(/DATA/PARAM/@paymentoptions, 'P'))">
                                                   <xsl:if test="(contains(/DATA/PARAM/@paymentoptions, 'L'))">
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                         <xsl:element name="INPUT">
                                                         <xsl:attribute name="type">radio</xsl:attribute>
                                                         <xsl:attribute name="name">PayType</xsl:attribute>
                                                         <xsl:attribute name="id">PayType</xsl:attribute>
                                                         <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[ToggleType();]]></xsl:text></xsl:attribute>
                                                         <xsl:attribute name="value">11</xsl:attribute>
                                                         <xsl:if test="/DATA/TXN/PTSBILLING/@paytype=11">
                                                            <xsl:attribute name="CHECKED"/>
                                                         </xsl:if>
                                                         </xsl:element>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/PayType11.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[CheckType(11);]]></xsl:text></xsl:attribute>
                                                         </xsl:element>
                                                   </xsl:if>
                                                   <xsl:if test="(contains(/DATA/PARAM/@paymentoptions, 'M'))">
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                         <xsl:element name="INPUT">
                                                         <xsl:attribute name="type">radio</xsl:attribute>
                                                         <xsl:attribute name="name">PayType</xsl:attribute>
                                                         <xsl:attribute name="id">PayType</xsl:attribute>
                                                         <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[ToggleType();]]></xsl:text></xsl:attribute>
                                                         <xsl:attribute name="value">12</xsl:attribute>
                                                         <xsl:if test="/DATA/TXN/PTSBILLING/@paytype=12">
                                                            <xsl:attribute name="CHECKED"/>
                                                         </xsl:if>
                                                         </xsl:element>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/PayType12.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[CheckType(12);]]></xsl:text></xsl:attribute>
                                                         </xsl:element>
                                                   </xsl:if>
                                                   <xsl:if test="(contains(/DATA/PARAM/@paymentoptions, 'N'))">
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                         <xsl:element name="INPUT">
                                                         <xsl:attribute name="type">radio</xsl:attribute>
                                                         <xsl:attribute name="name">PayType</xsl:attribute>
                                                         <xsl:attribute name="id">PayType</xsl:attribute>
                                                         <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[ToggleType();]]></xsl:text></xsl:attribute>
                                                         <xsl:attribute name="value">13</xsl:attribute>
                                                         <xsl:if test="/DATA/TXN/PTSBILLING/@paytype=13">
                                                            <xsl:attribute name="CHECKED"/>
                                                         </xsl:if>
                                                         </xsl:element>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/PayType13.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[CheckType(13);]]></xsl:text></xsl:attribute>
                                                         </xsl:element>
                                                   </xsl:if>
                                                   <xsl:if test="(contains(/DATA/PARAM/@paymentoptions, 'O'))">
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                         <xsl:element name="INPUT">
                                                         <xsl:attribute name="type">radio</xsl:attribute>
                                                         <xsl:attribute name="name">PayType</xsl:attribute>
                                                         <xsl:attribute name="id">PayType</xsl:attribute>
                                                         <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[ToggleType();]]></xsl:text></xsl:attribute>
                                                         <xsl:attribute name="value">14</xsl:attribute>
                                                         <xsl:if test="/DATA/TXN/PTSBILLING/@paytype=14">
                                                            <xsl:attribute name="CHECKED"/>
                                                         </xsl:if>
                                                         </xsl:element>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/PayType14.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[CheckType(14);]]></xsl:text></xsl:attribute>
                                                         </xsl:element>
                                                   </xsl:if>
                                                </xsl:if>
                                                <xsl:if test="(/DATA/PARAM/@cashpayment != 0)">
                                                   <xsl:if test="(contains(/DATA/PARAM/@paymentoptions, 'G'))">
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                         <xsl:element name="INPUT">
                                                         <xsl:attribute name="type">radio</xsl:attribute>
                                                         <xsl:attribute name="name">PayType</xsl:attribute>
                                                         <xsl:attribute name="id">PayType</xsl:attribute>
                                                         <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[ToggleType();]]></xsl:text></xsl:attribute>
                                                         <xsl:attribute name="value">7</xsl:attribute>
                                                         <xsl:if test="/DATA/TXN/PTSBILLING/@paytype=7">
                                                            <xsl:attribute name="CHECKED"/>
                                                         </xsl:if>
                                                         </xsl:element>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/PayType7.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[CheckType(7);]]></xsl:text></xsl:attribute>
                                                         </xsl:element>
                                                   </xsl:if>
                                                   <xsl:if test="(contains(/DATA/PARAM/@paymentoptions, 'H'))">
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                         <xsl:element name="INPUT">
                                                         <xsl:attribute name="type">radio</xsl:attribute>
                                                         <xsl:attribute name="name">PayType</xsl:attribute>
                                                         <xsl:attribute name="id">PayType</xsl:attribute>
                                                         <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[ToggleType();]]></xsl:text></xsl:attribute>
                                                         <xsl:attribute name="value">8</xsl:attribute>
                                                         <xsl:if test="/DATA/TXN/PTSBILLING/@paytype=8">
                                                            <xsl:attribute name="CHECKED"/>
                                                         </xsl:if>
                                                         </xsl:element>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/PayType8.gif</xsl:attribute>
                                                            <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                            <xsl:attribute name="border">0</xsl:attribute>
                                                            <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[CheckType(8);]]></xsl:text></xsl:attribute>
                                                         </xsl:element>
                                                   </xsl:if>
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
                                 <xsl:attribute name="id">CashRows</xsl:attribute>
                                 <xsl:attribute name="style">display:none</xsl:attribute>
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
                                                <xsl:attribute name="width">160</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">440</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:if test="(/DATA/PARAM/@companyid = 15)">
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
                                                   <xsl:attribute name="colspan">3</xsl:attribute>
                                                   <xsl:attribute name="width">600</xsl:attribute>
                                                   <xsl:attribute name="align">center</xsl:attribute>
                                                   <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:element name="b">
                                                   <xsl:element name="font">
                                                      <xsl:attribute name="color">blue</xsl:attribute>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CashPayment15']"/>
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
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:element name="TR">
                                 <xsl:attribute name="id">WalletRows</xsl:attribute>
                                 <xsl:attribute name="style">display:none</xsl:attribute>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
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
                                                <xsl:attribute name="width">160</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">440</xsl:attribute>
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
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='WalletName']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">440</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">text</xsl:attribute>
                                                <xsl:attribute name="name">Wallet</xsl:attribute>
                                                <xsl:attribute name="id">Wallet</xsl:attribute>
                                                <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@wallet"/></xsl:attribute>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images/Required.gif</xsl:attribute>
                                                   <xsl:attribute name="alt">Required Field</xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:element>

                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:element name="TR">
                                 <xsl:attribute name="id">BitCoinRows</xsl:attribute>
                                 <xsl:attribute name="style">display:none</xsl:attribute>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="width">600</xsl:attribute>
                                    <xsl:attribute name="align">right</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:if test="(/DATA/PARAM/@companyid != 17)">
                                       <xsl:element name="TABLE">
                                          <xsl:attribute name="border">0</xsl:attribute>
                                          <xsl:attribute name="cellpadding">0</xsl:attribute>
                                          <xsl:attribute name="cellspacing">0</xsl:attribute>
                                          <xsl:attribute name="width">600</xsl:attribute>

                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">160</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">440</xsl:attribute>
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
                                                <xsl:attribute name="align">center</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:attribute name="class">PageHeading</xsl:attribute>
                                                <xsl:element name="font">
                                                   <xsl:attribute name="color">red</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BitCoinPayments']"/>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:element>

                                       </xsl:element>
                                    </xsl:if>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:element name="TR">
                                 <xsl:attribute name="id">CardRows</xsl:attribute>
                                 <xsl:attribute name="style">display:none</xsl:attribute>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">50</xsl:attribute>
                                 </xsl:element>
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
                                                <xsl:attribute name="width">160</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">440</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">160</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CardNumber']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">440</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">text</xsl:attribute>
                                                <xsl:attribute name="name">CardNumber</xsl:attribute>
                                                <xsl:attribute name="id">CardNumber</xsl:attribute>
                                                <xsl:attribute name="size">25</xsl:attribute>
                                                <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@cardnumber"/></xsl:attribute>
                                                <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[var x = this.value; if(x.tolowercase() != 'paypal'){this.value = x.replace(/[^\d]/g, '')};]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:element>

                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">160</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CardDate']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">440</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="SELECT">
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
                                                <xsl:element name="SELECT">
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
                                                <xsl:attribute name="width">160</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CardName']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">440</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">text</xsl:attribute>
                                                <xsl:attribute name="name">CardName</xsl:attribute>
                                                <xsl:attribute name="id">CardName</xsl:attribute>
                                                <xsl:attribute name="size">25</xsl:attribute>
                                                <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@cardname"/></xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:element>

                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">160</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CardCode']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">440</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="INPUT">
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

                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:element name="TR">
                                 <xsl:attribute name="id">CheckRows</xsl:attribute>
                                 <xsl:attribute name="style">display:none</xsl:attribute>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">50</xsl:attribute>
                                 </xsl:element>
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
                                                <xsl:attribute name="width">160</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">440</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">160</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CheckBank']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">440</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">text</xsl:attribute>
                                                <xsl:attribute name="name">CheckBank</xsl:attribute>
                                                <xsl:attribute name="id">CheckBank</xsl:attribute>
                                                <xsl:attribute name="size">25</xsl:attribute>
                                                <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@checkbank"/></xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:element>

                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">160</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CheckRoute']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">440</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">text</xsl:attribute>
                                                <xsl:attribute name="name">CheckRoute</xsl:attribute>
                                                <xsl:attribute name="id">CheckRoute</xsl:attribute>
                                                <xsl:attribute name="size">15</xsl:attribute>
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
                                                <xsl:attribute name="width">160</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CheckAccount']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">440</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">text</xsl:attribute>
                                                <xsl:attribute name="name">CheckAccount</xsl:attribute>
                                                <xsl:attribute name="id">CheckAccount</xsl:attribute>
                                                <xsl:attribute name="size">25</xsl:attribute>
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
                                                <xsl:attribute name="width">160</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CheckAcctType']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">440</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="SELECT">
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
                                                <xsl:attribute name="width">160</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CheckName']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">440</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">text</xsl:attribute>
                                                <xsl:attribute name="name">CheckName</xsl:attribute>
                                                <xsl:attribute name="id">CheckName</xsl:attribute>
                                                <xsl:attribute name="size">25</xsl:attribute>
                                                <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSBILLING/@checkname"/></xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:element>

                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:element name="TR">
                                 <xsl:attribute name="id">BillingAddress</xsl:attribute>
                                 <xsl:attribute name="style">display:none</xsl:attribute>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">50</xsl:attribute>
                                 </xsl:element>
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
                                                <xsl:attribute name="width">160</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">440</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">160</xsl:attribute>
                                                <xsl:attribute name="align">right</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BillingAddress']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             </xsl:element>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">440</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">text</xsl:attribute>
                                                <xsl:attribute name="name">Street1b</xsl:attribute>
                                                <xsl:attribute name="id">Street1b</xsl:attribute>
                                                <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@street1b"/></xsl:attribute>
                                                <xsl:attribute name="size">60</xsl:attribute>
                                                <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[if(this.value==''){alert('Oops, Street Required!');}]]></xsl:text></xsl:attribute>
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
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">text</xsl:attribute>
                                                <xsl:attribute name="name">Street2b</xsl:attribute>
                                                <xsl:attribute name="id">Street2b</xsl:attribute>
                                                <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@street2b"/></xsl:attribute>
                                                <xsl:attribute name="size">60</xsl:attribute>
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
                                                         <xsl:attribute name="width">50</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">200</xsl:attribute>
                                                         <xsl:attribute name="class">InputHeading</xsl:attribute>
                                                         <xsl:attribute name="align">left</xsl:attribute>
                                                         <xsl:attribute name="valign">bottom</xsl:attribute>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='City']"/>
                                                      </xsl:element>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">240</xsl:attribute>
                                                         <xsl:attribute name="class">InputHeading</xsl:attribute>
                                                         <xsl:attribute name="align">left</xsl:attribute>
                                                         <xsl:attribute name="valign">bottom</xsl:attribute>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='State']"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">160</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">200</xsl:attribute>
                                                         <xsl:attribute name="align">left</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:element name="INPUT">
                                                         <xsl:attribute name="type">text</xsl:attribute>
                                                         <xsl:attribute name="name">Cityb</xsl:attribute>
                                                         <xsl:attribute name="id">Cityb</xsl:attribute>
                                                         <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@cityb"/></xsl:attribute>
                                                         <xsl:attribute name="size">27</xsl:attribute>
                                                         <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[if(this.value==''){alert('Oops, City Required!')}; TitleCase(this);]]></xsl:text></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">240</xsl:attribute>
                                                         <xsl:attribute name="align">left</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:element name="INPUT">
                                                         <xsl:attribute name="type">text</xsl:attribute>
                                                         <xsl:attribute name="name">Stateb</xsl:attribute>
                                                         <xsl:attribute name="id">Stateb</xsl:attribute>
                                                         <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@stateb"/></xsl:attribute>
                                                         <xsl:attribute name="size">27</xsl:attribute>
                                                         <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[if(this.value==''){alert('Oops, State Required!')}; TitleCase(this);]]></xsl:text></xsl:attribute>
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
                                                         <xsl:attribute name="width">50</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">100</xsl:attribute>
                                                         <xsl:attribute name="class">InputHeading</xsl:attribute>
                                                         <xsl:attribute name="align">left</xsl:attribute>
                                                         <xsl:attribute name="valign">bottom</xsl:attribute>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Zip']"/>
                                                      </xsl:element>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">340</xsl:attribute>
                                                         <xsl:attribute name="class">InputHeading</xsl:attribute>
                                                         <xsl:attribute name="align">left</xsl:attribute>
                                                         <xsl:attribute name="valign">bottom</xsl:attribute>
                                                         <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CountryID']"/>
                                                      </xsl:element>
                                                   </xsl:element>
                                                   <xsl:element name="TR">
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">160</xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">100</xsl:attribute>
                                                         <xsl:attribute name="align">left</xsl:attribute>
                                                         <xsl:attribute name="valign">center</xsl:attribute>
                                                         <xsl:element name="INPUT">
                                                         <xsl:attribute name="type">text</xsl:attribute>
                                                         <xsl:attribute name="name">Zipb</xsl:attribute>
                                                         <xsl:attribute name="id">Zipb</xsl:attribute>
                                                         <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@zipb"/></xsl:attribute>
                                                         <xsl:attribute name="size">8</xsl:attribute>
                                                         <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[if(this.value==''){alert('Oops, Postal Code Required!')};]]></xsl:text></xsl:attribute>
                                                         </xsl:element>
                                                      </xsl:element>
                                                      <xsl:element name="TD">
                                                         <xsl:attribute name="width">340</xsl:attribute>
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
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:element>

                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:attribute name="id">Secure</xsl:attribute>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="width">750</xsl:attribute>
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
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">6</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">750</xsl:attribute>
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">1</xsl:attribute>
                                    <xsl:attribute name="bgcolor">#584b42</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:element name="TR">
                                 <xsl:attribute name="id">Agree2</xsl:attribute>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="width">750</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="b">
                                    <xsl:element name="font">
                                       <xsl:attribute name="color">blue</xsl:attribute>
                                       <xsl:element name="INPUT">
                                       <xsl:attribute name="type">checkbox</xsl:attribute>
                                       <xsl:attribute name="name">IsAgree2</xsl:attribute>
                                       <xsl:attribute name="id">IsAgree2</xsl:attribute>
                                       <xsl:attribute name="value">1</xsl:attribute>
                                       <xsl:if test="(/DATA/PARAM/@isagree2 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsAgree2']"/>
                                       </xsl:element>
                                    <xsl:if test="(/DATA/PARAM/@companyid != 15)">
                                       <xsl:if test="(/DATA/PARAM/@billonetime = 0)">
                                             <xsl:if test="(/DATA/PARAM/@companyid = 13)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsAgree2Billed']"/>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/PARAM/@companyid != 13)">
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsAgree2Monthly']"/>
                                             </xsl:if>
                                       </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@billonetime = 2)">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsAgree2Annually']"/>
                                          </xsl:if>
                                          <xsl:if test="(/DATA/PARAM/@billonetime = 1)">
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsAgree2OneTime']"/>
                                          </xsl:if>
                                    </xsl:if>
                                    <xsl:if test="(/DATA/PARAM/@companyid = 15)">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsAgree2_15']"/>
                                    </xsl:if>
                                    </xsl:element>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:if test="(/DATA/PARAM/@billday != 0)">
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">3</xsl:attribute>
                                       <xsl:attribute name="height">12</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">3</xsl:attribute>
                                       <xsl:attribute name="width">750</xsl:attribute>
                                       <xsl:attribute name="align">center</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:if test="(/DATA/PARAM/@companyid = 11)">
                                             <xsl:element name="SELECT">
                                                <xsl:attribute name="name">BillDay</xsl:attribute>
                                                <xsl:attribute name="id">BillDay</xsl:attribute>
                                                <xsl:variable name="tmp"><xsl:value-of select="/DATA/PARAM/@billday"/></xsl:variable>
                                                <xsl:element name="OPTION">
                                                   <xsl:attribute name="value">1</xsl:attribute>
                                                   <xsl:if test="$tmp='1'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BillDay1']"/>
                                                </xsl:element>
                                                <xsl:element name="OPTION">
                                                   <xsl:attribute name="value">15</xsl:attribute>
                                                   <xsl:if test="$tmp='15'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BillDay15']"/>
                                                </xsl:element>
                                             </xsl:element>
                                       </xsl:if>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:if>

                           </xsl:if>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Back']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[document.getElementById('NoValidate').value = 1; doSubmit(2,"");]]></xsl:text></xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Continue']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[document.getElementById('NoValidate').value = 0; doSubmit(4,"");]]></xsl:text></xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/PARAM/@mode = 5)">
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">M</xsl:attribute>
                                 <xsl:attribute name="id">M</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@m"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">IsAgree</xsl:attribute>
                                 <xsl:attribute name="id">IsAgree</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@isagree"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Wallet</xsl:attribute>
                                 <xsl:attribute name="id">Wallet</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@wallet"/></xsl:attribute>
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
                                 <xsl:attribute name="name">OrderOption</xsl:attribute>
                                 <xsl:attribute name="id">OrderOption</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@orderoption"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">BillDay</xsl:attribute>
                                 <xsl:attribute name="id">BillDay</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@billday"/></xsl:attribute>
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
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data1</xsl:attribute>
                                 <xsl:attribute name="id">Data1</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data1"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data2</xsl:attribute>
                                 <xsl:attribute name="id">Data2</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data2"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data3</xsl:attribute>
                                 <xsl:attribute name="id">Data3</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data3"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data4</xsl:attribute>
                                 <xsl:attribute name="id">Data4</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data4"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data5</xsl:attribute>
                                 <xsl:attribute name="id">Data5</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data5"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data6</xsl:attribute>
                                 <xsl:attribute name="id">Data6</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data6"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data7</xsl:attribute>
                                 <xsl:attribute name="id">Data7</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data7"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data8</xsl:attribute>
                                 <xsl:attribute name="id">Data8</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data8"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data9</xsl:attribute>
                                 <xsl:attribute name="id">Data9</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data9"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data10</xsl:attribute>
                                 <xsl:attribute name="id">Data10</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data10"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data11</xsl:attribute>
                                 <xsl:attribute name="id">Data11</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data11"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data12</xsl:attribute>
                                 <xsl:attribute name="id">Data12</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data12"/></xsl:attribute>
                              </xsl:element>
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">Data13</xsl:attribute>
                                 <xsl:attribute name="id">Data13</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@data13"/></xsl:attribute>
                              </xsl:element>
                           <xsl:if test="(/DATA/PARAM/@nobanner = 0)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">6</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="width">750</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="IMG">
                                       <xsl:attribute name="src">Images/EnrollConfirm.png</xsl:attribute>
                                       <xsl:attribute name="border">0</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">6</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:if>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">750</xsl:attribute>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">100</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">325</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">325</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">100</xsl:attribute>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">325</xsl:attribute>
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
                                             <xsl:attribute name="width">325</xsl:attribute>
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
                                             <xsl:if test="(/DATA/TXN/PTSBILLING/@paytype = 7)">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CashPayment']"/>
                                                   <xsl:element name="BR"/>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSBILLING/@paytype = 11)">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='iPayout']"/>
                                                   <xsl:text>:</xsl:text>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/PARAM/@wallet" disable-output-escaping="yes"/>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSBILLING/@paytype = 12)">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PayQuicker']"/>
                                                   <xsl:text>:</xsl:text>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/PARAM/@wallet" disable-output-escaping="yes"/>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSBILLING/@paytype = 13)">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SolidTrust']"/>
                                                   <xsl:text>:</xsl:text>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:value-of select="/DATA/PARAM/@wallet" disable-output-escaping="yes"/>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSBILLING/@paytype = 14)">
                                                   <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BitCoinPayments']"/>
                                             </xsl:if>
                                             <xsl:if test="(/DATA/TXN/PTSBILLING/@paytype &lt; 7)">
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
                                             </xsl:if>
                                          </xsl:element>
                                       </xsl:element>

                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">1</xsl:attribute>
                                 <xsl:attribute name="bgcolor">#584b42</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="b">
                                    <xsl:element name="font">
                                       <xsl:attribute name="size">3</xsl:attribute>
                                       <xsl:attribute name="color">blue</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ReferredBy']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:value-of select="/DATA/PARAM/@referredby" disable-output-escaping="yes"/>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">50</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">700</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:if test="(/DATA/PARAM/@membership = 1)">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership19_1']"/>
                                       <xsl:element name="BR"/>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership19_1a']"/>
                                       <xsl:element name="BR"/>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership19_1b']"/>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/PARAM/@membership = 2)">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership19_2']"/>
                                       <xsl:element name="BR"/>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership19_2a']"/>
                                       <xsl:element name="BR"/>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership19_2b']"/>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/PARAM/@membership = 3)">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership19_3']"/>
                                       <xsl:element name="BR"/>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership19_3a']"/>
                                       <xsl:element name="BR"/>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership19_3b']"/>
                                 </xsl:if>
                                 <xsl:if test="(/DATA/PARAM/@membership = 4)">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership19_4']"/>
                                       <xsl:element name="BR"/>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership19_4a']"/>
                                       <xsl:element name="BR"/>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Membership19_4b']"/>
                                 </xsl:if>
                              </xsl:element>
                           </xsl:element>

                           <xsl:if test="(/DATA/PARAM/@shipping != '')">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">50</xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="width">700</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:attribute name="class">PageHeading</xsl:attribute>
                                       <xsl:value-of select="/DATA/PARAM/@shipping" disable-output-escaping="yes"/>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ShippingCharges']"/>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:if>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">1</xsl:attribute>
                                 <xsl:attribute name="bgcolor">#584b42</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:if test="(/DATA/PARAM/@data1 = 2)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">50</xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="width">700</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="b">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewPhone']"/>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>

                           </xsl:if>
                           <xsl:if test="(/DATA/PARAM/@data1 = 1)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">50</xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="width">700</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="b">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MyPhone']"/>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">6</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">50</xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">160</xsl:attribute>
                                    <xsl:attribute name="align">right</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SimType']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">540</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:value-of select="/DATA/PARAM/@data2" disable-output-escaping="yes"/>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:if test="(/DATA/PARAM/@data2 = 'My-Own')">
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">3</xsl:attribute>
                                       <xsl:attribute name="height">6</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">50</xsl:attribute>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">160</xsl:attribute>
                                       <xsl:attribute name="align">right</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SimNumber']"/>
                                       <xsl:text>:</xsl:text>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    </xsl:element>
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">540</xsl:attribute>
                                       <xsl:attribute name="align">left</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:value-of select="/DATA/PARAM/@data3" disable-output-escaping="yes"/>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:if>

                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">6</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">50</xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">160</xsl:attribute>
                                    <xsl:attribute name="align">right</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PhoneLocked']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">540</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:value-of select="/DATA/PARAM/@data4" disable-output-escaping="yes"/>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">6</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">50</xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">160</xsl:attribute>
                                    <xsl:attribute name="align">right</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PhoneBrand']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">540</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:value-of select="/DATA/PARAM/@data5" disable-output-escaping="yes"/>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">6</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">50</xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">160</xsl:attribute>
                                    <xsl:attribute name="align">right</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PhoneModel']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">540</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:value-of select="/DATA/PARAM/@data6" disable-output-escaping="yes"/>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">6</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">50</xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">160</xsl:attribute>
                                    <xsl:attribute name="align">right</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PhoneIMIE']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">540</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:value-of select="/DATA/PARAM/@data7" disable-output-escaping="yes"/>
                                 </xsl:element>
                              </xsl:element>

                           </xsl:if>
                           <xsl:if test="(/DATA/PARAM/@data8 = 2)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">50</xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="width">700</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="b">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewPhoneNumber']"/>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">6</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">50</xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">160</xsl:attribute>
                                    <xsl:attribute name="align">right</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AreaCode']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">540</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:value-of select="/DATA/PARAM/@data9" disable-output-escaping="yes"/>
                                 </xsl:element>
                              </xsl:element>

                           </xsl:if>
                           <xsl:if test="(/DATA/PARAM/@data8 = 1)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">50</xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="width">700</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="b">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MyPhoneNumber']"/>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">6</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">50</xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">160</xsl:attribute>
                                    <xsl:attribute name="align">right</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PhoneNumber']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">540</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:value-of select="/DATA/PARAM/@data10" disable-output-escaping="yes"/>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">6</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">50</xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">160</xsl:attribute>
                                    <xsl:attribute name="align">right</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PhoneProvider']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">540</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:value-of select="/DATA/PARAM/@data11" disable-output-escaping="yes"/>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">6</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">50</xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">160</xsl:attribute>
                                    <xsl:attribute name="align">right</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ProviderAccount']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">540</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:value-of select="/DATA/PARAM/@data12" disable-output-escaping="yes"/>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">6</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">50</xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">160</xsl:attribute>
                                    <xsl:attribute name="align">right</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ProviderPswd']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">540</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:value-of select="/DATA/PARAM/@data13" disable-output-escaping="yes"/>
                                 </xsl:element>
                              </xsl:element>

                           </xsl:if>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">1</xsl:attribute>
                                 <xsl:attribute name="bgcolor">#584b42</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="width">750</xsl:attribute>
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
                                    <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[doSubmit(5,""); this.disabled = true]]></xsl:text></xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/PARAM/@mode = 6)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/TXN/PTSHTMLFILE/DATA/comment()" disable-output-escaping="yes"/>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="width">750</xsl:attribute>
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
                                 <xsl:attribute name="colspan">3</xsl:attribute>
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
      </xsl:element>
      <!--END BODY-->

      </xsl:element>

   </xsl:template>
</xsl:stylesheet>