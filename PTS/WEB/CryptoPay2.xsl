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
         <xsl:with-param name="pagename" select="'Crypto Payment'"/>
         <xsl:with-param name="includecalendar" select="true()"/>
         <xsl:with-param name="htmleditor"></xsl:with-param>
         <xsl:with-param name="translate">google</xsl:with-param>
      </xsl:call-template>

      <xsl:element name="SCRIPT">
         <xsl:attribute name="language">JavaScript</xsl:attribute>
         <xsl:attribute name="src">Include/AJAX.js</xsl:attribute>
         <xsl:text> </xsl:text>
      </xsl:element>

      <xsl:element name="SCRIPT">
         <xsl:attribute name="language">JavaScript</xsl:attribute>
         <xsl:attribute name="src">Include/clipboard.min.js</xsl:attribute>
         <xsl:text> </xsl:text>
      </xsl:element>

      <xsl:element name="SCRIPT">
         <xsl:attribute name="language">JavaScript</xsl:attribute>
         <xsl:attribute name="src">Include/RewardOrder.js</xsl:attribute>
         <xsl:text> </xsl:text>
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
                     <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[
               Init();
            ]]></xsl:text>;doErrorMsg('<xsl:value-of select="concat($errmsg, $errmsgfld)"/>')</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[
               Init();
            ]]></xsl:text>;doErrorMsg('<xsl:value-of select="/DATA/ERROR"/>')</xsl:attribute>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
               <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[
               Init();
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
               <xsl:attribute name="name">Reward</xsl:attribute>
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
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function LogonDigitsOnly(obj){ 
          var val = obj.value;
          if(val.indexOf('@') === -1)   {
          obj.value = val.replace(/\D/g,'');
          }
         }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function NewShopper(){ 
          var mid = document.getElementById('MerchantID').value;
          var url = "NewShopper.asp?m=" + mid
          var win = window.open(url);
         }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function GetCoinPrice(){ 
          var coin = document.getElementById('PayType').value - 2;
          var url = "CoinPrice.asp?c=" + coin
          var xmlhttp;
          if (window.XMLHttpRequest) {
            // code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
          }
          else {
            // code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
          }
          xmlhttp.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
              document.getElementById('CoinPrice').value = this.responseText;
            }
          };
          xmlhttp.open("GET", url, true);
          xmlhttp.send();
         }]]></xsl:text>
               </xsl:element>

               <xsl:element name="SCRIPT">
                  <xsl:attribute name="language">JavaScript</xsl:attribute>
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function Init(){ 
          var orderprocess = document.getElementById('OrderProcess').value;
          var ordertype = document.getElementById('OrderType').value;
          if( orderprocess == 2 ) {
            try {
              GetCryptoPayment();
              new Clipboard('#CopyButton');
              var isdemo = document.getElementById('IsDemo').value;
              if( isdemo == 0 ) { UpdateTimer(); }
            }
            catch(err) {
              alert(err.message);
            }  
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
                              <xsl:attribute name="width">600</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">MerchantID</xsl:attribute>
                              <xsl:attribute name="id">MerchantID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@merchantid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">ConsumerID</xsl:attribute>
                              <xsl:attribute name="id">ConsumerID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@consumerid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">ConsumerName</xsl:attribute>
                              <xsl:attribute name="id">ConsumerName</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@consumername"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">MerchantName</xsl:attribute>
                              <xsl:attribute name="id">MerchantName</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@merchantname"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">StaffName</xsl:attribute>
                              <xsl:attribute name="id">StaffName</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@staffname"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">StaffID</xsl:attribute>
                              <xsl:attribute name="id">StaffID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@staffid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">IsPin</xsl:attribute>
                              <xsl:attribute name="id">IsPin</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@ispin"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">IsTicket</xsl:attribute>
                              <xsl:attribute name="id">IsTicket</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@isticket"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">IsApprove</xsl:attribute>
                              <xsl:attribute name="id">IsApprove</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@isapprove"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">IsAwards</xsl:attribute>
                              <xsl:attribute name="id">IsAwards</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@isawards"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">AcceptedCoins</xsl:attribute>
                              <xsl:attribute name="id">AcceptedCoins</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@acceptedcoins"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">NXC</xsl:attribute>
                              <xsl:attribute name="id">NXC</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@nxc"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">RewardPoints</xsl:attribute>
                              <xsl:attribute name="id">RewardPoints</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@rewardpoints"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">RewardValue</xsl:attribute>
                              <xsl:attribute name="id">RewardValue</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@rewardvalue"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">RewardValueRaw</xsl:attribute>
                              <xsl:attribute name="id">RewardValueRaw</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@rewardvalueraw"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">OrderType</xsl:attribute>
                              <xsl:attribute name="id">OrderType</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@ordertype"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">OrderProcess</xsl:attribute>
                              <xsl:attribute name="id">OrderProcess</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@orderprocess"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">Payment2ID</xsl:attribute>
                              <xsl:attribute name="id">Payment2ID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@payment2id"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">CoinType</xsl:attribute>
                              <xsl:attribute name="id">CoinType</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@cointype"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">CryptoStatus</xsl:attribute>
                              <xsl:attribute name="id">CryptoStatus</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@cryptostatus"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">CoinToken</xsl:attribute>
                              <xsl:attribute name="id">CoinToken</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@cointoken"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">CurrencyCode</xsl:attribute>
                              <xsl:attribute name="id">CurrencyCode</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@currencycode"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">IsDemo</xsl:attribute>
                              <xsl:attribute name="id">IsDemo</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@isdemo"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">ReplaceURL</xsl:attribute>
                              <xsl:attribute name="id">ReplaceURL</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@replaceurl"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">PayDate</xsl:attribute>
                              <xsl:attribute name="id">PayDate</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@paydate"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">AwardName</xsl:attribute>
                              <xsl:attribute name="id">AwardName</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@awardname"/></xsl:attribute>
                           </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewOrder3']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/PARAM/@merchantname" disable-output-escaping="yes"/>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 #<xsl:value-of select="/DATA/PARAM/@merchantid"/>
                              <xsl:if test="(/DATA/PARAM/@isdemo != 0)">
                                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                    <xsl:element name="font">
                                       <xsl:attribute name="color">red</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Demo']"/>
                                    </xsl:element>
                              </xsl:if>
                           </xsl:element>
                        </xsl:element>

                        <xsl:if test="(/DATA/PARAM/@orderprocess = 2)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ProcessCryptoPaymentButton3']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[ProcessCryptoPayment()]]></xsl:text></xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                        </xsl:if>

                        <xsl:if test="(/DATA/PARAM/@orderprocess = 0)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">550</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">top</xsl:attribute>
                                 <xsl:element name="TABLE">
                                    <xsl:attribute name="border">0</xsl:attribute>
                                    <xsl:attribute name="cellpadding">0</xsl:attribute>
                                    <xsl:attribute name="cellspacing">0</xsl:attribute>
                                    <xsl:attribute name="width">550</xsl:attribute>
                                    <xsl:attribute name="style">border:1px solid; border-radius:20px; border-color:#cccccc; padding:10px; BACKGROUND-COLOR: #d1fa99</xsl:attribute>

                                       <xsl:element name="TR">
                                          <xsl:element name="TD">
                                             <xsl:attribute name="width">550</xsl:attribute>
                                             <xsl:attribute name="align">center</xsl:attribute>
                                          </xsl:element>
                                       </xsl:element>
                                       <xsl:if test="(/DATA/PARAM/@cryptostatus = 'OK')">
                                          <xsl:element name="TR">
                                             <xsl:element name="TD">
                                                <xsl:attribute name="width">550</xsl:attribute>
                                                <xsl:attribute name="align">center</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="font">
                                                   <xsl:attribute name="size">4</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ExistingMember']"/>
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
                                                <xsl:attribute name="width">550</xsl:attribute>
                                                <xsl:attribute name="align">center</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='LogonConsumer3']"/>
                                                <xsl:text>:</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="INPUT">
                                                <xsl:attribute name="type">text</xsl:attribute>
                                                <xsl:attribute name="name">LogonConsumer</xsl:attribute>
                                                <xsl:attribute name="id">LogonConsumer</xsl:attribute>
                                                <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@logonconsumer"/></xsl:attribute>
                                                <xsl:attribute name="size">20</xsl:attribute>
                                                <xsl:attribute name="onblur"><xsl:text disable-output-escaping="yes"><![CDATA[LogonDigitsOnly(this);]]></xsl:text></xsl:attribute>
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
                                                <xsl:attribute name="width">550</xsl:attribute>
                                                <xsl:attribute name="align">center</xsl:attribute>
                                                <xsl:attribute name="valign">center</xsl:attribute>
                                                <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">button</xsl:attribute>
                                                   <xsl:attribute name="class">hugebutton</xsl:attribute>
                                                   <xsl:attribute name="value">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Continue']"/>
                                                   </xsl:attribute>
                                                   <xsl:attribute name="onclick">doSubmit(2,"")</xsl:attribute>
                                                </xsl:element>
                                                <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                                <xsl:element name="INPUT">
                                                   <xsl:attribute name="type">button</xsl:attribute>
                                                   <xsl:attribute name="class">bigbutton</xsl:attribute>
                                                   <xsl:attribute name="value">
                                                      <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NewMember']"/>
                                                   </xsl:attribute>
                                                   <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[NewShopper()]]></xsl:text></xsl:attribute>
                                                </xsl:element>
                                             </xsl:element>
                                          </xsl:element>

                                       </xsl:if>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                        </xsl:if>
                        <xsl:if test="(/DATA/PARAM/@orderprocess = 1)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">2</xsl:attribute>
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="font">
                                    <xsl:attribute name="size">3</xsl:attribute>
                                    <xsl:attribute name="color">blue</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ConsumerName']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:element name="b">
                                    <xsl:value-of select="/DATA/PARAM/@consumername" disable-output-escaping="yes"/>
                                    </xsl:element>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:element name="INPUT">
                                       <xsl:attribute name="type">button</xsl:attribute>
                                       <xsl:attribute name="class">smbutton</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Change']"/>
                                       </xsl:attribute>
                                       <xsl:attribute name="onclick">doSubmit(0,"")</xsl:attribute>
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

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
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
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PayDate']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="font">
                                    <xsl:attribute name="size">3</xsl:attribute>
                                 <xsl:value-of select="/DATA/PARAM/@paydate" disable-output-escaping="yes"/>
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
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='RewardType']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="font">
                                    <xsl:attribute name="size">3</xsl:attribute>
                                 <xsl:value-of select="/DATA/PARAM/@awardname" disable-output-escaping="yes"/>
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
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='PayType']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="SELECT">
                                    <xsl:attribute name="name">PayType</xsl:attribute>
                                    <xsl:attribute name="id">PayType</xsl:attribute>
                                    <xsl:attribute name="onchange"><xsl:text disable-output-escaping="yes"><![CDATA[GetCoinPrice();]]></xsl:text></xsl:attribute>
                                    <xsl:variable name="tmp"><xsl:value-of select="/DATA/PARAM/@paytype"/></xsl:variable>
                                    <xsl:if test="(contains(/DATA/PARAM/@acceptedcoins, ',1,'))">
                                       <xsl:element name="OPTION">
                                          <xsl:attribute name="value">3</xsl:attribute>
                                          <xsl:if test="$tmp='3'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Coin1']"/>
                                       </xsl:element>
                                    </xsl:if>
                                    <xsl:if test="(contains(/DATA/PARAM/@acceptedcoins, ',2,'))">
                                       <xsl:element name="OPTION">
                                          <xsl:attribute name="value">4</xsl:attribute>
                                          <xsl:if test="$tmp='4'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Coin2']"/>
                                       </xsl:element>
                                    </xsl:if>
                                    <xsl:if test="(contains(/DATA/PARAM/@acceptedcoins, ',3,'))">
                                       <xsl:element name="OPTION">
                                          <xsl:attribute name="value">5</xsl:attribute>
                                          <xsl:if test="$tmp='5'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Coin3']"/>
                                       </xsl:element>
                                    </xsl:if>
                                    <xsl:if test="(contains(/DATA/PARAM/@acceptedcoins, ',4,'))">
                                       <xsl:element name="OPTION">
                                          <xsl:attribute name="value">6</xsl:attribute>
                                          <xsl:if test="$tmp='6'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Coin4']"/>
                                       </xsl:element>
                                    </xsl:if>
                                    <xsl:if test="(contains(/DATA/PARAM/@acceptedcoins, ',5,'))">
                                       <xsl:element name="OPTION">
                                          <xsl:attribute name="value">7</xsl:attribute>
                                          <xsl:if test="$tmp='7'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Coin5']"/>
                                       </xsl:element>
                                    </xsl:if>
                                    <xsl:if test="(contains(/DATA/PARAM/@acceptedcoins, ',6,'))">
                                       <xsl:element name="OPTION">
                                          <xsl:attribute name="value">8</xsl:attribute>
                                          <xsl:if test="$tmp='8'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Coin6']"/>
                                       </xsl:element>
                                    </xsl:if>
                                    <xsl:if test="(contains(/DATA/PARAM/@acceptedcoins, ',7,'))">
                                       <xsl:element name="OPTION">
                                          <xsl:attribute name="value">9</xsl:attribute>
                                          <xsl:if test="$tmp='9'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Coin7']"/>
                                       </xsl:element>
                                    </xsl:if>
                                    <xsl:if test="(contains(/DATA/PARAM/@acceptedcoins, ',8,'))">
                                       <xsl:element name="OPTION">
                                          <xsl:attribute name="value">10</xsl:attribute>
                                          <xsl:if test="$tmp='10'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Coin8']"/>
                                       </xsl:element>
                                    </xsl:if>
                                    <xsl:if test="(contains(/DATA/PARAM/@acceptedcoins, ',9,'))">
                                       <xsl:element name="OPTION">
                                          <xsl:attribute name="value">11</xsl:attribute>
                                          <xsl:if test="$tmp='11'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Coin9']"/>
                                       </xsl:element>
                                    </xsl:if>
                                    <xsl:if test="(contains(/DATA/PARAM/@acceptedcoins, ',10,'))">
                                       <xsl:element name="OPTION">
                                          <xsl:attribute name="value">12</xsl:attribute>
                                          <xsl:if test="$tmp='12'"><xsl:attribute name="SELECTED"/></xsl:if>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Coin10']"/>
                                       </xsl:element>
                                    </xsl:if>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">CoinPrice</xsl:attribute>
                                 <xsl:attribute name="id">CoinPrice</xsl:attribute>
                                 <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@coinprice"/></xsl:attribute>
                                 <xsl:attribute name="style">BORDER:none;background:transparent;color:blue</xsl:attribute>
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
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TotalAmount']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="font">
                                    <xsl:attribute name="size">3</xsl:attribute>
                                 <xsl:value-of select="/DATA/PARAM/@totalamountformat" disable-output-escaping="yes"/>
                                 </xsl:element>
                                 <xsl:element name="BR"/>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="font">
                                    <xsl:attribute name="color">blue</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TotalAmountText3']"/>
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
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NetAmount']"/>
                                 <xsl:text>:</xsl:text>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="font">
                                    <xsl:attribute name="size">3</xsl:attribute>
                                 <xsl:value-of select="/DATA/PARAM/@netamountformat" disable-output-escaping="yes"/>
                                 </xsl:element>
                                 <xsl:element name="BR"/>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="font">
                                    <xsl:attribute name="color">blue</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='NetAmountText3']"/>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>

                           <xsl:if test="(/DATA/PARAM/@description != '')">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">600</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Description']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:element name="font">
                                       <xsl:attribute name="size">3</xsl:attribute>
                                    <xsl:value-of select="/DATA/PARAM/@description" disable-output-escaping="yes"/>
                                    </xsl:element>
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
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="class">bigbutton</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AddCrypto']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick">doSubmit(5,"")</xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StartOver']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick">doSubmit(0,"")</xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
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

                        </xsl:if>
                        <xsl:if test="(/DATA/PARAM/@orderprocess = 2)">
                           <xsl:element name="TR">
                              <xsl:attribute name="id">MessageRow</xsl:attribute>
                              <xsl:attribute name="style">background:darkblue</xsl:attribute>
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                 <xsl:attribute name="type">text</xsl:attribute>
                                 <xsl:attribute name="name">MessageBox</xsl:attribute>
                                 <xsl:attribute name="id">MessageBox</xsl:attribute>
                                 <xsl:attribute name="value">15:00 Awaiting Payment...</xsl:attribute>
                                 <xsl:attribute name="style">BORDER:none;background:transparent;color:white;text-align:center;width:100%</xsl:attribute>
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
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="font">
                                    <xsl:attribute name="size">4</xsl:attribute>
                                    <xsl:attribute name="color">blue</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='QRtext']"/>
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
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="IMG">
                                    <xsl:attribute name="src"><xsl:value-of select="/DATA/PARAM/@qr_url"/></xsl:attribute>
                                    <xsl:attribute name="id">QRCode</xsl:attribute>
                                    <xsl:attribute name="border">0</xsl:attribute>
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
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="IMG">
                                       <xsl:attribute name="src">Images/Coin<xsl:value-of select="/DATA/PARAM/@cointype"/>.gif</xsl:attribute>
                                       <xsl:attribute name="align">absmiddle</xsl:attribute>
                                       <xsl:attribute name="border">0</xsl:attribute>
                                    </xsl:element>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:element name="b">
                                    <xsl:element name="font">
                                       <xsl:attribute name="size">4</xsl:attribute>
                                    <xsl:value-of select="/DATA/PARAM/@qr_name" disable-output-escaping="yes"/>
                                    </xsl:element>
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
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="font">
                                    <xsl:attribute name="size">3</xsl:attribute>
                                    <xsl:element name="INPUT">
                                    <xsl:attribute name="class">bigtext</xsl:attribute>
                                    <xsl:attribute name="type">text</xsl:attribute>
                                    <xsl:attribute name="name">QRAmount</xsl:attribute>
                                    <xsl:attribute name="id">QRAmount</xsl:attribute>
                                    <xsl:attribute name="value">Coins: <xsl:value-of select="/DATA/PARAM/@qr_amount"/></xsl:attribute>
                                    <xsl:attribute name="size">20</xsl:attribute>
                                    <xsl:attribute name="style">BORDER:none;background:transparent;color:black;text-align:center;</xsl:attribute>
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

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="font">
                                    <xsl:attribute name="size">3</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='QR_Label']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:element name="b">
                                    <xsl:value-of select="/DATA/PARAM/@qr_label" disable-output-escaping="yes"/>
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

                           <xsl:if test="(/DATA/PARAM/@qr_msg != '')">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">600</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="font">
                                       <xsl:attribute name="size">3</xsl:attribute>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='QR_Msg']"/>
                                       <xsl:text>:</xsl:text>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                       <xsl:element name="b">
                                       <xsl:value-of select="/DATA/PARAM/@qr_msg" disable-output-escaping="yes"/>
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
                           </xsl:if>

                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="font">
                                    <xsl:attribute name="size">4</xsl:attribute>
                                    <xsl:attribute name="color">blue</xsl:attribute>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='QRtext2']"/>
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
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="font">
                                       <xsl:attribute name="size">3</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='QR_Address']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    </xsl:element>
                                    <xsl:element name="INPUT">
                                    <xsl:attribute name="type">text</xsl:attribute>
                                    <xsl:attribute name="name">QR_Address</xsl:attribute>
                                    <xsl:attribute name="id">QR_Address</xsl:attribute>
                                    <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@qr_address"/></xsl:attribute>
                                    <xsl:attribute name="size">40</xsl:attribute>
                                    </xsl:element>
                                    <xsl:element name="INPUT">
                                       <xsl:attribute name="type">button</xsl:attribute>
                                       <xsl:attribute name="id">CopyButton</xsl:attribute>
                                       <xsl:attribute name="data-clipboard-target">#QR_Address</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Copy']"/>
                                       </xsl:attribute>
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
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="font">
                                       <xsl:attribute name="size">3</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='QR_Amount']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    </xsl:element>
                                    <xsl:element name="INPUT">
                                    <xsl:attribute name="type">text</xsl:attribute>
                                    <xsl:attribute name="name">QR_Amount</xsl:attribute>
                                    <xsl:attribute name="id">QR_Amount</xsl:attribute>
                                    <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@qr_amount"/></xsl:attribute>
                                    <xsl:attribute name="size">37</xsl:attribute>
                                    </xsl:element>
                                    <xsl:element name="INPUT">
                                       <xsl:attribute name="type">button</xsl:attribute>
                                       <xsl:attribute name="id">CopyButton</xsl:attribute>
                                       <xsl:attribute name="data-clipboard-target">#QR_Amount</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Copy']"/>
                                       </xsl:attribute>
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
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="INPUT">
                                    <xsl:attribute name="type">button</xsl:attribute>
                                    <xsl:attribute name="value">
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='StartOver']"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onclick">doSubmit(0,"")</xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
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

                        </xsl:if>
                        <xsl:if test="(/DATA/PARAM/@orderprocess = 3)">
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="font">
                                    <xsl:attribute name="size">3</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='ConsumerName']"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                                    <xsl:element name="b">
                                    <xsl:value-of select="/DATA/PARAM/@consumername" disable-output-escaping="yes"/>
                                    </xsl:element>
                                    <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
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
                                 <xsl:attribute name="width">600</xsl:attribute>
                                 <xsl:attribute name="align">center</xsl:attribute>
                                 <xsl:attribute name="valign">center</xsl:attribute>
                                 <xsl:element name="font">
                                    <xsl:attribute name="size">4</xsl:attribute>
                                    <xsl:attribute name="color">blue</xsl:attribute>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SuccessfulOrder']"/>
                                 </xsl:element>
                              </xsl:element>
                           </xsl:element>

                           <xsl:if test="(/DATA/PARAM/@ordertype != 3)">
                              <xsl:if test="(/DATA/PARAM/@redeem != 0)">
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">1</xsl:attribute>
                                       <xsl:attribute name="height">12</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">600</xsl:attribute>
                                       <xsl:attribute name="align">center</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="font">
                                          <xsl:attribute name="size">4</xsl:attribute>
                                          <xsl:attribute name="color">red</xsl:attribute>
                                          <xsl:element name="b">
                                          <xsl:value-of select="/DATA/PARAM/@redeem" disable-output-escaping="yes"/>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='RedeemedRewardPoints']"/>
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:if>

                              <xsl:if test="(/DATA/PARAM/@reward != 0)">
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">1</xsl:attribute>
                                       <xsl:attribute name="height">12</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">600</xsl:attribute>
                                       <xsl:attribute name="align">center</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="font">
                                          <xsl:attribute name="size">4</xsl:attribute>
                                          <xsl:attribute name="color">green</xsl:attribute>
                                          <xsl:element name="b">
                                          <xsl:value-of select="/DATA/PARAM/@reward" disable-output-escaping="yes"/>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='CashbackRewardPoints']"/>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                          (
                                          <xsl:element name="b">
                                          <xsl:value-of select="/DATA/PARAM/@totalreward" disable-output-escaping="yes"/>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='total']"/>
                                          )
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:if>

                              <xsl:if test="(/DATA/PARAM/@award != 0)">
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="colspan">1</xsl:attribute>
                                       <xsl:attribute name="height">12</xsl:attribute>
                                    </xsl:element>
                                 </xsl:element>
                                 <xsl:element name="TR">
                                    <xsl:element name="TD">
                                       <xsl:attribute name="width">600</xsl:attribute>
                                       <xsl:attribute name="align">center</xsl:attribute>
                                       <xsl:attribute name="valign">center</xsl:attribute>
                                       <xsl:element name="font">
                                          <xsl:attribute name="size">4</xsl:attribute>
                                          <xsl:attribute name="color">green</xsl:attribute>
                                          <xsl:element name="b">
                                          <xsl:value-of select="/DATA/PARAM/@award" disable-output-escaping="yes"/>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='SpecialAwardPoints']"/>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                          (
                                          <xsl:element name="b">
                                          <xsl:value-of select="/DATA/PARAM/@totalaward" disable-output-escaping="yes"/>
                                          </xsl:element>
                                          <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                          <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='total']"/>
                                          )
                                       </xsl:element>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:if>

                           </xsl:if>
                           <xsl:if test="(/DATA/PARAM/@ordertype = 3)">
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="colspan">1</xsl:attribute>
                                    <xsl:attribute name="height">12</xsl:attribute>
                                 </xsl:element>
                              </xsl:element>
                              <xsl:element name="TR">
                                 <xsl:element name="TD">
                                    <xsl:attribute name="width">600</xsl:attribute>
                                    <xsl:attribute name="align">center</xsl:attribute>
                                    <xsl:attribute name="valign">center</xsl:attribute>
                                    <xsl:element name="font">
                                       <xsl:attribute name="size">4</xsl:attribute>
                                       <xsl:attribute name="color">red</xsl:attribute>
                                       <xsl:element name="b">
                                       <xsl:value-of select="/DATA/PARAM/@award" disable-output-escaping="yes"/>
                                       </xsl:element>
                                       <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                       <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='RedeemedAwardPoints']"/>
                                    </xsl:element>
                                 </xsl:element>
                              </xsl:element>

                           </xsl:if>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="colspan">1</xsl:attribute>
                                 <xsl:attribute name="height">12</xsl:attribute>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TR">
                              <xsl:element name="TD">
                                 <xsl:attribute name="width">600</xsl:attribute>
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
                                 <xsl:attribute name="colspan">1</xsl:attribute>
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