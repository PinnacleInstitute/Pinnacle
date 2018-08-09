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
         <xsl:attribute name="href">include/StyleSheet5.css</xsl:attribute>
      </xsl:element>

      <xsl:call-template name="HTMLHeading">
         <xsl:with-param name="pagename" select="'Change Purchase'"/>
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
                     <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[ShowPrice();]]></xsl:text>;doErrorMsg('<xsl:value-of select="concat($errmsg, $errmsgfld)"/>')</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[ShowPrice();]]></xsl:text>;doErrorMsg('<xsl:value-of select="/DATA/ERROR"/>')</xsl:attribute>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
               <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[ShowPrice();]]></xsl:text></xsl:attribute>
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
               <xsl:attribute name="name">CloudZow</xsl:attribute>
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
               //var payobj = Member.elements['PayType'];
               var payobj = document.getElementById('PayType');
               if( payobj != null ) {
               //var countryid = document.getElementById('CountryID').value;
               var VisibleCard = 'none'; var VisibleCheck = 'none';
               var paytype = payobj.value;
               //var l = payobj.length;
               //for( i = 0; i < l; i++ ) {
               //   if (payobj[i].checked) {
               //      paytype = payobj[i].value;
               //      i = l;
               //   }
               //}
               //if (paytype == 5) {
               //   if ( countryid != 224 ) {
               //      paytype = 1;
               //      document.getElementById('PayType').value = paytype;
               //      alert("Electronic Checks not available outside the United States");
               //   }
               //}
               if (paytype >= 1 && paytype <= 4) VisibleCard = '';
               if (paytype == 5) VisibleCheck = '';
               document.getElementById('CardRows').style.display = VisibleCard;
               //document.getElementById('CheckRows').style.display = VisibleCheck;
               }
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function CheckType(val){ 
               //var payobj = Member.elements['PayType'];
               //if( payobj != null ) {
               //   var l = payobj.length;
               //   for( i = 0; i < l; i++ ) {
               //      if (payobj[i].value == val) {
               //         payobj[i].checked=true;
               //         i = l;
               //      }
               //   }
               ToggleType();
               }
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function FormatCardCode(obj){ 
               var val = obj.value;
               var newval = val.replace(/[^\d]/g, '');
               obj.value = newval.substring(0,4);
               if( newval.length < 3 ) {
               alert('Oops, Invalid Security Code');
               }
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ShowCC(){ 
               var disp, computers = document.getElementById('Computers').value;
               if( computers == 0 ) { disp = 'none' } else { disp = '' }
               document.getElementById('Agree2').style.display = disp;
               document.getElementById('Payment').style.display = disp;
               document.getElementById('CardRows').style.display = disp;
               document.getElementById('Secure').style.display = disp;
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ShowPrice(){ 
               var ismaster = document.getElementById('IsMaster').value;
               var fasttrack = document.getElementById('FastTrack').checked;
               var computers = document.getElementById('Computers').value;
               var money = document.getElementById('ZowMoney').checked;
               var university = document.getElementById('ZowUniversity').checked;
               var price = computers * 5;
               if( money ) { price = price + 15 }
               if( university ) { price = price + 15 }
               if( ismaster != 0 ) {
                  price = price - 30;
                  if(price < 0) { price = 0 }
               }   
               else {
                  if(fasttrack) {
                     price = 40;
                  }
               }
               document.getElementById('Price').value = 'Monthly: ' + formatCurrency( price );
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function ShowFastTrack(){ 
               var disp, fasttrack = document.getElementById('FastTrack').checked;
               if(fasttrack) { disp = 'none' } else { disp = '' }
               document.getElementById('ComputersRow').style.display = disp;
               document.getElementById('MoneyRow').style.display = disp;
               document.getElementById('UniversityRow').style.display = disp;
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function formatCurrency(num){ 
               num = num.toString().replace(/\$|\,/g,'');
               if(isNaN(num))
               num = "0";
               sign = (num == (num = Math.abs(num)));
               num = Math.floor(num*100+0.50000000001);
               cents = num%100;
               num = Math.floor(num/100).toString();
               if(cents<10)
               cents = "0" + cents;
               for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
               num = num.substring(0,num.length-(4*i+3))+','+
               num.substring(num.length-(4*i+3));
               return (((sign)?'':'-') + '$' + num + '.' + cents);
               //return (((sign)?'':'-') + '$' + num);
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
                              <xsl:attribute name="width">100</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">500</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">BillingID</xsl:attribute>
                              <xsl:attribute name="id">BillingID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@billingid"/></xsl:attribute>
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
                              <xsl:attribute name="name">IsMaster</xsl:attribute>
                              <xsl:attribute name="id">IsMaster</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@ismaster"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Processor</xsl:attribute>
                              <xsl:attribute name="id">Processor</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@processor"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">MemberToken</xsl:attribute>
                              <xsl:attribute name="id">MemberToken</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@membertoken"/></xsl:attribute>
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
                              <xsl:attribute name="name">PayType</xsl:attribute>
                              <xsl:attribute name="id">PayType</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@paytype"/></xsl:attribute>
                           </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
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
                              <xsl:attribute name="width">600</xsl:attribute>
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
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namefirst"/>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/TXN/PTSMEMBER/@namelast"/>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:if test="(/DATA/TXN/PTSMEMBER/@ismaster != 0)">
                                    <xsl:element name="font">
                                       <xsl:attribute name="color">blue</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='OnFastTrack']"/>
                                    </xsl:element>
                                 </xsl:if>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/PARAM/@result != 0)">
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
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:element name="font">
                                    <xsl:attribute name="color">blue</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SuccessfulChange']"/>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/TXN/PTSMEMBER/@price"/>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:if test="(/DATA/PARAM/@result = 2)">
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
                                    <xsl:attribute name="class">PageHeading</xsl:attribute>
                                    <xsl:element name="font">
                                       <xsl:attribute name="color">blue</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FastTrackCharge']"/>
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
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Continue']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick">doSubmit(3,"")</xsl:attribute>
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
                        <xsl:if test="(/DATA/PARAM/@result = 0)">
                           <xsl:if test="(/DATA/TXN/PTSMEMBER/@ismaster = 0)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">100</xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">500</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="b">
                                       <xsl:element name="INPUT">
                                       <xsl:attribute name="type">checkbox</xsl:attribute>
                                       <xsl:attribute name="name">FastTrack</xsl:attribute>
                                       <xsl:attribute name="id">FastTrack</xsl:attribute>
                                       <xsl:attribute name="value">1</xsl:attribute>
                                       <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[ShowFastTrack();ShowPrice();]]></xsl:text></xsl:attribute>
                                       <xsl:if test="(/DATA/PARAM/@fasttrack = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FastTrack']"/>
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
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">500</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FastTrack1']"/>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">100</xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">500</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FastTrack2']"/>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">100</xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">500</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FastTrack3']"/>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">100</xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">500</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FastTrack4']"/>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">100</xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">500</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FastTrack5']"/>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">100</xsl:attribute>
                                 </xsl:element>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">500</xsl:attribute>
                                    <xsl:attribute name="align">left</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FastTrack6']"/>
                                 </xsl:element>
                              </xsl:element>

                           </xsl:if>
                           <xsl:if test="(/DATA/TXN/PTSMEMBER/@ismaster != 0)">
                              <xsl:element name="INPUT">
                                 <xsl:attribute name="type">hidden</xsl:attribute>
                                 <xsl:attribute name="name">FastTrack</xsl:attribute>
                                 <xsl:attribute name="id">FastTrack</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@fasttrack"/></xsl:attribute>
                              </xsl:element>
                           </xsl:if>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">18</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:attribute name="id">ComputersRow</xsl:attribute>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">100</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:if test="(/DATA/TXN/PTSMEMBER/@ismaster = 0)">
                                       <xsl:element name="b">
                                       <xsl:element name="font">
                                          <xsl:attribute name="size">4</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='OR']"/>
                                       </xsl:element>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    </xsl:if>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">500</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="b">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ComputersText1']"/>
                                    </xsl:element>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:element name="SELECT">
                                       <xsl:attribute name="name">Computers</xsl:attribute>
                                       <xsl:attribute name="id">Computers</xsl:attribute>
                                       <xsl:attribute name="onchange"><xsl:text disable-output-escaping="yes"><![CDATA[ShowPrice();]]></xsl:text></xsl:attribute>
                                       <xsl:variable name="tmp"><xsl:value-of select="/DATA/PARAM/@computers"/></xsl:variable>
                                       <xsl:if test="(/DATA/PARAM/@activecomputers &lt;= 0)">
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">0</xsl:attribute>
                                             <xsl:if test="$tmp='0'"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Computers0']"/>
                                          </xsl:element>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@activecomputers &lt;= 1)">
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">1</xsl:attribute>
                                             <xsl:if test="$tmp='1'"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Computers1']"/>
                                          </xsl:element>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@activecomputers &lt;= 2)">
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">2</xsl:attribute>
                                             <xsl:if test="$tmp='2'"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Computers2']"/>
                                          </xsl:element>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@activecomputers &lt;= 3)">
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">3</xsl:attribute>
                                             <xsl:if test="$tmp='3'"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Computers3']"/>
                                          </xsl:element>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@activecomputers &lt;= 4)">
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">4</xsl:attribute>
                                             <xsl:if test="$tmp='4'"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Computers4']"/>
                                          </xsl:element>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@activecomputers &lt;= 5)">
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">5</xsl:attribute>
                                             <xsl:if test="$tmp='5'"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Computers5']"/>
                                          </xsl:element>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@activecomputers &lt;= 6)">
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">6</xsl:attribute>
                                             <xsl:if test="$tmp='6'"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Computers6']"/>
                                          </xsl:element>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@activecomputers &lt;= 7)">
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">7</xsl:attribute>
                                             <xsl:if test="$tmp='7'"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Computers7']"/>
                                          </xsl:element>
                                       </xsl:if>
                                       <xsl:if test="(/DATA/PARAM/@activecomputers &lt;= 8)">
                                          <xsl:element name="OPTION">
                                             <xsl:attribute name="value">8</xsl:attribute>
                                             <xsl:if test="$tmp='8'"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Computers8']"/>
                                          </xsl:element>
                                       </xsl:if>
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
                              <xsl:attribute name="id">MoneyRow</xsl:attribute>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">100</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">500</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="b">
                                    <xsl:element name="INPUT">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:attribute name="name">ZowMoney</xsl:attribute>
                                    <xsl:attribute name="id">ZowMoney</xsl:attribute>
                                    <xsl:attribute name="value">1</xsl:attribute>
                                    <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[ShowPrice();]]></xsl:text></xsl:attribute>
                                    <xsl:if test="(/DATA/PARAM/@zowmoney = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ZowMoney']"/>
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
                              <xsl:attribute name="id">UniversityRow</xsl:attribute>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">100</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">500</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="b">
                                    <xsl:element name="INPUT">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:attribute name="name">ZowUniversity</xsl:attribute>
                                    <xsl:attribute name="id">ZowUniversity</xsl:attribute>
                                    <xsl:attribute name="value">1</xsl:attribute>
                                    <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[ShowPrice();]]></xsl:text></xsl:attribute>
                                    <xsl:if test="(/DATA/PARAM/@zowuniversity = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ZowUniversity']"/>
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
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">Price</xsl:attribute>
                                 <xsl:attribute name="id">Price</xsl:attribute>
                                 <xsl:attribute name="size">15</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@price"/></xsl:attribute>
                                 <xsl:attribute name="style">BORDER:none; COLOR:blue; BACKGROUND:#e7e7e6; TEXT-ALIGN:center; FONT-BOLD:true;</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">6</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:if test="(/DATA/TXN/PTSMEMBER/@billingid = 0)">
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
                                    <xsl:attribute name="width">600</xsl:attribute>
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
                                    </xsl:element>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>

                              <xsl:element name="TR">
                                 <xsl:attribute name="id">Payment</xsl:attribute>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="width">750</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
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
                                             <xsl:element name="TD">
                                                <xsl:attribute name="colspan">1</xsl:attribute>
                                                <xsl:attribute name="height">12</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">750</xsl:attribute>
                                                <xsl:attribute name="height">1</xsl:attribute>
                                                <xsl:attribute name="bgcolor">#584b42</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="colspan">1</xsl:attribute>
                                                <xsl:attribute name="height">12</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>

                                          <xsl:element name="TR">
                                             <xsl:attribute name="id">Pay2</xsl:attribute>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">750</xsl:attribute>
                                                <xsl:attribute name="align">left</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:attribute name="class">prompt</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PaymentText']"/>
                                             </xsl:element>
                                          </xsl:element>
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="colspan">1</xsl:attribute>
                                                <xsl:attribute name="height">6</xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>

                                          <xsl:element name="TR">
                                             <xsl:attribute name="id">Pay3</xsl:attribute>
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">750</xsl:attribute>
                                                <xsl:attribute name="align">center</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/PayType1.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                      <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[CheckType(1);]]></xsl:text></xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/PayType2.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                      <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[CheckType(2);]]></xsl:text></xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/PayType3.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                      <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[CheckType(3);]]></xsl:text></xsl:attribute>
                                                   </xsl:element>
                                                   <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images/PayType4.gif</xsl:attribute>
                                                      <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                      <xsl:attribute name="border">0</xsl:attribute>
                                                      <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[CheckType(4);]]></xsl:text></xsl:attribute>
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
                                 <xsl:attribute name="id">CardRows</xsl:attribute>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="width">600</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
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
                                                <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[var x = this.value; var filter  = /[^0-9]/; if (filter.test(x)) alert('Oops, Please enter digits only for your Credit Card Number');]]></xsl:text></xsl:attribute>
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
                                                      <xsl:attribute name="value">12</xsl:attribute>
                                                      <xsl:if test="$tmp='12'"><xsl:attribute name="SELECTED"/></xsl:if>
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='2012']"/>
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
                                                         <xsl:attribute name="width">100</xsl:attribute>
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
                                                         <xsl:attribute name="width">100</xsl:attribute>
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
                                                         <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                                         <xsl:element name="IMG">
                                                            <xsl:attribute name="src">Images/Required.gif</xsl:attribute>
                                                            <xsl:attribute name="alt">Required Field</xsl:attribute>
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
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:attribute name="id">Secure</xsl:attribute>
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">2</xsl:attribute>
                                    <xsl:attribute name="width">600</xsl:attribute>
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
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Change']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick">doSubmit(2,"")</xsl:attribute>
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
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="height">24</xsl:attribute>
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