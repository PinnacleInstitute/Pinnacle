<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
   <xsl:include href="HTMLHeading.xsl"/>
   <xsl:include href="Bookmark.xsl"/>
   <xsl:output omit-xml-declaration="yes"/>

   <xsl:template match="/">

      <xsl:variable name="usergroup" select="/DATA/SYSTEM/@usergroup"/>

      <xsl:element name="link">
         <xsl:attribute name="rel">stylesheet</xsl:attribute>
         <xsl:attribute name="type">text/css</xsl:attribute>
         <xsl:attribute name="href">include/StyleSheet5.css</xsl:attribute>
      </xsl:element>

      <xsl:call-template name="HTMLHeading">
         <xsl:with-param name="pagename" select="'New Affiliate'"/>
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
                     <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[ToggleType();]]></xsl:text>;doErrorMsg('<xsl:value-of select="concat($errmsg, $errmsgfld)"/>')</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[ToggleType();]]></xsl:text>;doErrorMsg('<xsl:value-of select="/DATA/ERROR"/>')</xsl:attribute>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
               <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[ToggleType();]]></xsl:text></xsl:attribute>
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
               <xsl:attribute name="name">Member</xsl:attribute>
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
                  document.getElementById('CheckRows').style.display = VisibleCheck;
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
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function TitleCase(obj){    
               var val = obj.value;
               obj.value = val.charAt(0).toUpperCase() + val.slice(1);;
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function FormatPhone(obj){    
               var val = obj.value;
               var newval = val.replace(/[^\d]/g, ''); 
               if( newval.length < 10 ) {
                  alert('Oops, Invalid Phone Number'); }
               else {
                  obj.value = newval.substring(0,3) + '-' + newval.substring(3,6) + '-' + newval.substring(6,10);
               }
             }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function FormatTaxID(obj){ 
               var taxidtype = document.getElementById('TaxIDType').value;
               var val = obj.value;
               var newval = val.replace(/[^\d]/g, ''); 
               if( taxidtype == 1 ) {
                  if( newval.length < 9 ) {
                     alert('Oops, Invalid Social Security Number'); }
                  else {
                     obj.value = newval.substring(0,3) + '-' + newval.substring(3,5) + '-' + newval.substring(5,9);
                  }
               }
               if( taxidtype == 2 ) {
                  if( newval.length < 9 ) {
                     alert('Oops, Invalid Employer Identification Number'); }
                  else {
                     obj.value = newval.substring(0,2) + '-' + newval.substring(2,9);
                  }
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
               var disp, computers = document.getElementById('Computers').value;
               if( computers == 0 ) { disp = 'none' } else { disp = '' }
               document.getElementById('Payment').style.display = disp;
               document.getElementById('CardRows').style.display = disp;
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
                              <xsl:attribute name="width">210</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">490</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/PARAM/@isadded = 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="IMG">
                                    <xsl:attribute name="src">Images\logo.png</xsl:attribute>
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

                           <xsl:if test="(/DATA/PARAM/@referredby != '')">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="width">750</xsl:attribute>
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
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="height">6</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:if>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">checkbox</xsl:attribute>
                                 <xsl:attribute name="name">IsAgree</xsl:attribute>
                                 <xsl:attribute name="id">IsAgree</xsl:attribute>
                                 <xsl:attribute name="value">1</xsl:attribute>
                                 <xsl:if test="(/DATA/PARAM/@isagree = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                 <xsl:element name="b">
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsAgree']"/>
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
                                          <xsl:attribute name="width">210</xsl:attribute>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">200</xsl:attribute>
                                          <xsl:attribute name="class">InputHeading</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">bottom</xsl:attribute>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NameFirst']"/>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">290</xsl:attribute>
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
                                          <xsl:attribute name="width">210</xsl:attribute>
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
                                          <xsl:attribute name="maxlength">30</xsl:attribute>
                                          <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@namefirst"/></xsl:attribute>
                                          <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[if(this.value==''){alert('Oops, First Name Required!')};TitleCase(this);]]></xsl:text></xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:element name="TD">
                                          <xsl:attribute name="width">290</xsl:attribute>
                                          <xsl:attribute name="align">left</xsl:attribute>
                                          <xsl:attribute name="valign">center</xsl:attribute>
                                          <xsl:element name="INPUT">
                                          <xsl:attribute name="type">text</xsl:attribute>
                                          <xsl:attribute name="name">NameLast</xsl:attribute>
                                          <xsl:attribute name="id">NameLast</xsl:attribute>
                                          <xsl:attribute name="size">25</xsl:attribute>
                                          <xsl:attribute name="maxlength">30</xsl:attribute>
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
                                 <xsl:attribute name="width">50</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">210</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CompanyName']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">490</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">CompanyName</xsl:attribute>
                                 <xsl:attribute name="id">CompanyName</xsl:attribute>
                                 <xsl:attribute name="size">60</xsl:attribute>
                                 <xsl:attribute name="maxlength">60</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@companyname"/></xsl:attribute>
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
                                 <xsl:attribute name="width">210</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Email']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">490</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">Email</xsl:attribute>
                                 <xsl:attribute name="id">Email</xsl:attribute>
                                 <xsl:attribute name="size">60</xsl:attribute>
                                 <xsl:attribute name="maxlength">80</xsl:attribute>
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
                                 <xsl:attribute name="width">210</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Address']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">490</xsl:attribute>
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
                                 <xsl:attribute name="width">210</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CityStateZip']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">490</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">City</xsl:attribute>
                                 <xsl:attribute name="id">City</xsl:attribute>
                                 <xsl:attribute name="size">20</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSADDRESS/@city"/></xsl:attribute>
                                 <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[if(this.value==''){alert('Oops, City Required!');}else{TitleCase(this);}; document.getElementById('Cityb').value = this.value;]]></xsl:text></xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="SELECT">
                                    <xsl:attribute name="name">State</xsl:attribute>
                                    <xsl:attribute name="id">State</xsl:attribute>
                                    <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[if(this.value==''){alert('Oops, State Required!');}; document.getElementById('Stateb').value = this.value;]]></xsl:text></xsl:attribute>
                                    <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/PTSADDRESS/@state"/></xsl:variable>
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
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">Zip</xsl:attribute>
                                 <xsl:attribute name="id">Zip</xsl:attribute>
                                 <xsl:attribute name="size">10</xsl:attribute>
                                 <xsl:attribute name="maxlength">5</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSADDRESS/@zip"/></xsl:attribute>
                                 <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ var zipCodePattern = /^\d{5}$|^\d{5}-\d{4}$/; if( ! zipCodePattern.test(this.value) ){alert('Oops, Invalid Zip Code')}; document.getElementById('Zipb').value = this.value;]]></xsl:text></xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">50</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">210</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Phone']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">490</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">Phone1</xsl:attribute>
                                 <xsl:attribute name="id">Phone1</xsl:attribute>
                                 <xsl:attribute name="size">20</xsl:attribute>
                                 <xsl:attribute name="maxlength">30</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@phone1"/></xsl:attribute>
                                 <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[FormatPhone(this);]]></xsl:text></xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">3</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">50</xsl:attribute>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">210</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TaxID']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">490</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="SELECT">
                                    <xsl:attribute name="name">TaxIDType</xsl:attribute>
                                    <xsl:attribute name="id">TaxIDType</xsl:attribute>
                                    <xsl:variable name="tmp"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@taxidtype"/></xsl:variable>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">1</xsl:attribute>
                                       <xsl:if test="$tmp='1'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TaxIDType1']"/>
                                    </xsl:element>
                                    <xsl:element name="OPTION">
                                       <xsl:attribute name="value">2</xsl:attribute>
                                       <xsl:if test="$tmp='2'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TaxIDType2']"/>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">TaxID</xsl:attribute>
                                 <xsl:attribute name="id">TaxID</xsl:attribute>
                                 <xsl:attribute name="size">15</xsl:attribute>
                                 <xsl:attribute name="maxlength">15</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/TXN/PTSMEMBER/@taxid"/></xsl:attribute>
                                 <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[FormatTaxID(this);]]></xsl:text></xsl:attribute>
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
                                 <xsl:attribute name="width">210</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewLogon']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">490</xsl:attribute>
                                 <xsl:attribute name="align">left</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">prompt</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">NewLogon</xsl:attribute>
                                 <xsl:attribute name="id">NewLogon</xsl:attribute>
                                 <xsl:attribute name="size">20</xsl:attribute>
                                 <xsl:attribute name="maxlength">80</xsl:attribute>
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
                                 <xsl:attribute name="width">210</xsl:attribute>
                                 <xsl:attribute name="align">right</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewPassword']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              </xsl:element>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">490</xsl:attribute>
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
                                    <xsl:element name="IMG">
                                       <xsl:attribute name="src">Images\Machine48.gif</xsl:attribute>
                                       <xsl:attribute name="align">absmiddle</xsl:attribute>
                                       <xsl:attribute name="border">0</xsl:attribute>
                                    </xsl:element>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:element name="b">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ComputersText1']"/>
                                    </xsl:element>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:element name="SELECT">
                                       <xsl:attribute name="name">Computers</xsl:attribute>
                                       <xsl:attribute name="id">Computers</xsl:attribute>
                                       <xsl:attribute name="onchange"><xsl:text disable-output-escaping="yes"><![CDATA[ShowCC();]]></xsl:text></xsl:attribute>
                                       <xsl:variable name="tmp"><xsl:value-of select="/DATA/PARAM/@computers"/></xsl:variable>
                                       <xsl:element name="OPTION">
                                          <xsl:attribute name="value">0</xsl:attribute>
                                          <xsl:if test="$tmp='0'"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Computers0']"/>
                                       </xsl:element>
                                       <xsl:element name="OPTION">
                                          <xsl:attribute name="value">1</xsl:attribute>
                                          <xsl:if test="$tmp='1'"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Computers1']"/>
                                       </xsl:element>
                                       <xsl:element name="OPTION">
                                          <xsl:attribute name="value">2</xsl:attribute>
                                          <xsl:if test="$tmp='2'"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Computers2']"/>
                                       </xsl:element>
                                       <xsl:element name="OPTION">
                                          <xsl:attribute name="value">3</xsl:attribute>
                                          <xsl:if test="$tmp='3'"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Computers3']"/>
                                       </xsl:element>
                                       <xsl:element name="OPTION">
                                          <xsl:attribute name="value">4</xsl:attribute>
                                          <xsl:if test="$tmp='4'"><xsl:attribute name="SELECTED"/></xsl:if>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Computers4']"/>
                                       </xsl:element>
                                    </xsl:element>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:element name="b">
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ComputersText2']"/>
                                    </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">checkbox</xsl:attribute>
                                 <xsl:attribute name="name">IsAgree2</xsl:attribute>
                                 <xsl:attribute name="id">IsAgree2</xsl:attribute>
                                 <xsl:attribute name="value">1</xsl:attribute>
                                 <xsl:if test="(/DATA/PARAM/@isagree2 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                                 <xsl:element name="b">
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='IsAgree2']"/>
                                 </xsl:element>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

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

                                          <xsl:element name="INPUT">
                                             <xsl:attribute name="type">hidden</xsl:attribute>
                                             <xsl:attribute name="name">PayType</xsl:attribute>
                                             <xsl:attribute name="id">PayType</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@paytype"/></xsl:attribute>
                                          </xsl:element>

                                       <xsl:element name="TR">
                                          <xsl:attribute name="id">Pay3</xsl:attribute>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">750</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images\PayType1.gif</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[CheckType(1);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images\PayType2.gif</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[CheckType(2);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images\PayType3.gif</xsl:attribute>
                                                   <xsl:attribute name="align">absmiddle</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[CheckType(3);]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="IMG">
                                                   <xsl:attribute name="src">Images\PayType4.gif</xsl:attribute>
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
                                                   <xsl:attribute name="src">Images\SymbolHelp.gif</xsl:attribute>
                                                   <xsl:attribute name="border">0</xsl:attribute>
                                                </xsl:element>
                                                <xsl:element name="SPAN">
                                                   <xsl:element name="IMG">
                                                      <xsl:attribute name="src">Images\SecurityCode.png</xsl:attribute>
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
                                             <xsl:attribute name="align">right</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CityStateZip']"/>
                                             <xsl:text>:</xsl:text>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                          </xsl:element>
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">440</xsl:attribute>
                                             <xsl:attribute name="align">left</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">text</xsl:attribute>
                                             <xsl:attribute name="name">Cityb</xsl:attribute>
                                             <xsl:attribute name="id">Cityb</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@cityb"/></xsl:attribute>
                                             <xsl:attribute name="size">20</xsl:attribute>
                                             <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[if(this.value==''){alert('Oops, City Required!')}; TitleCase(this);]]></xsl:text></xsl:attribute>
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="SELECT">
                                                <xsl:attribute name="name">Stateb</xsl:attribute>
                                                <xsl:attribute name="id">Stateb</xsl:attribute>
                                                <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[if(this.value==''){alert('Oops, State Required!')}]]></xsl:text></xsl:attribute>
                                                <xsl:variable name="tmp"><xsl:value-of select="/DATA/PARAM/@stateb"/></xsl:variable>
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
                                             </xsl:element>
                                             <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                             <xsl:element name="INPUT">
                                             <xsl:attribute name="type">text</xsl:attribute>
                                             <xsl:attribute name="name">Zipb</xsl:attribute>
                                             <xsl:attribute name="id">Zipb</xsl:attribute>
                                             <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@zipb"/></xsl:attribute>
                                             <xsl:attribute name="maxlength">5</xsl:attribute>
                                             <xsl:attribute name="size">10</xsl:attribute>
                                             <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[ var zipCodePattern = /^\d{5}$|^\d{5}-\d{4}$/; if( ! zipCodePattern.test(this.value) ){alert('Oops, Invalid Zip Code')};]]></xsl:text></xsl:attribute>
                                             </xsl:element>
                                          </xsl:element>
                                       </xsl:element>

                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:attribute name="id">CheckRows</xsl:attribute>
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
                                             <xsl:attribute name="colspan">2</xsl:attribute>
                                             <xsl:attribute name="width">440</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                             <xsl:attribute name="valign">center</xsl:attribute>
                                             <xsl:element name="IMG">
                                                <xsl:attribute name="src">Images\checkref.gif</xsl:attribute>
                                                <xsl:attribute name="border">0</xsl:attribute>
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
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="width">750</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:element name="IMG">
                                    <xsl:attribute name="src">Images\padlock.gif</xsl:attribute>
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

                           <xsl:if test="(/DATA/PARAM/@referredby != '')">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">3</xsl:attribute>
                                    <xsl:attribute name="width">750</xsl:attribute>
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
                           </xsl:if>

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
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Join']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[doSubmit(2,""); this.disabled = true]]></xsl:text></xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">24</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/PARAM/@isadded != 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">3</xsl:attribute>
                                 <xsl:attribute name="height">24</xsl:attribute>
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
                                    <xsl:if test="(/DATA/PARAM/@computers = 0)">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MemberAdded']"/>
                                    </xsl:if>
                                 <xsl:if test="(/DATA/PARAM/@computers != 0)">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MemberAdded1']"/>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/PARAM/@computers" disable-output-escaping="yes"/>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='MemberAdded2']"/>
                                 </xsl:if>
                              </xsl:element>
                           </xsl:element>

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

      </xsl:element>
      </xsl:element>
      <!--END BODY-->

   </xsl:template>
</xsl:stylesheet>