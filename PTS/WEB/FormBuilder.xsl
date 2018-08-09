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
         <xsl:with-param name="pagename" select="/DATA/LANGUAGE/LABEL[@name='FormBuilder']"/>
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
                     <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[
               BuildCode();
            ]]></xsl:text>;doErrorMsg('<xsl:value-of select="concat($errmsg, $errmsgfld)"/>')</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[
               BuildCode();
            ]]></xsl:text>;doErrorMsg('<xsl:value-of select="/DATA/ERROR"/>')</xsl:attribute>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
               <xsl:attribute name="onLoad"><xsl:text disable-output-escaping="yes"><![CDATA[
               BuildCode();
            ]]></xsl:text></xsl:attribute>
            </xsl:otherwise>
         </xsl:choose>

         <!--BEGIN PAGE-->
      <xsl:element name="DIV">
         <xsl:attribute name="id">wrapper750</xsl:attribute>
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
               <xsl:attribute name="name">Prospect</xsl:attribute>
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
                  <xsl:text disable-output-escaping="yes"><![CDATA[ function BuildCode(){ 
               var prospect = document.getElementById('Prospect').value;
               var first = document.getElementById('First').checked;
               var last = document.getElementById('Last').checked;
               var email = document.getElementById('Email').checked;
               var phone = document.getElementById('Phone').checked;
               var phone2 = document.getElementById('Phone2').checked;
               var timezone = document.getElementById('TimeZone').checked;
               var besttime = document.getElementById('BestTime').checked;
               var description = document.getElementById('Description').checked;
               var source = document.getElementById('Source').checked;
               var street = document.getElementById('Street').checked;
               var unit = document.getElementById('Unit').checked;
               var city = document.getElementById('City').checked;
               var state = document.getElementById('State').checked;
               var zip = document.getElementById('Zip').checked;
               var country = document.getElementById('Country').checked;

               var rfirst = document.getElementById('rFirst').checked;
               var rlast = document.getElementById('rLast').checked;
               var remail = document.getElementById('rEmail').checked;
               var rphone = document.getElementById('rPhone').checked;
               var rphone2 = document.getElementById('rPhone2').checked;
               var rtimezone = document.getElementById('rTimeZone').checked;
               var rbesttime = document.getElementById('rBestTime').checked;
               var rdescription = document.getElementById('rDescription').checked;
               var rsource = document.getElementById('rSource').checked;
               var rstreet = document.getElementById('rStreet').checked;
               var runit = document.getElementById('rUnit').checked;
               var rcity = document.getElementById('rCity').checked;
               var rstate = document.getElementById('rState').checked;
               var rzip = document.getElementById('rZip').checked;
               var rcountry = document.getElementById('rCountry').checked;

               var jc, fc;

               jc = unescape('%3Cstyle type="text/css"%3E\n')
               jc = jc + '.formtitle {font-family:Verdana,Arial,Helvetica,Sans-Serif; color:#000080; font-size=14pt;}\n'
               jc = jc + '.formtext {font-family:Verdana,Arial,Helvetica,Sans-Serif; color:#ffffff; font-size=10pt;}\n'
               jc = jc + unescape('%3C/style%3E\n\n')

               jc = jc + unescape('%3CSCRIPT language="JavaScript"%3Efunction sendAJAX(url) {\n');
               jc = jc + '   var xmlhttp;\n'
               jc = jc + '   if (window.XMLHttpRequest) {\n'
               jc = jc + '      // code for IE7+, Firefox, Chrome, Opera, Safari\n'
               jc = jc + '      xmlhttp=new XMLHttpRequest();\n'
               jc = jc + '   }\n'
               jc = jc + '   else {\n'
               jc = jc + '      // code for IE6, IE5\n'
               jc = jc + '      xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");\n'
               jc = jc + '   }\n'
               jc = jc + '   xmlhttp.open("GET",url,true);\n'
               jc = jc + '   xmlhttp.send();\n'
               jc = jc + unescape('}%3C/SCRIPT%3E\n\n');

               jc = jc + unescape('%3CSCRIPT language="JavaScript"%3Efunction AddContact() {\n');
               jc = jc + '   var err = 0, test=0;\n';
               jc = jc + '   var url = "' + document.getElementById("URL").value + '?memberid=' + document.getElementById("MemberID").value
               if( prospect == 1 ) { jc = jc + '&prospect=1' }
               jc = jc + '";\n\n'
               fc = unescape('%3Ctable width="400"%3E\n')
               fc = fc + unescape('   %3Ctbody%3E\n')
               fc = fc + unescape('      %3Ctr%3E\n')
               fc = fc + unescape('         %3Ctd class="formtitle" colspan="2" align="center" width="400"%3ESubmit your contact info below.%3C/td%3E\n')
               fc = fc + unescape('      %3C/tr%3E\n')
               fc = fc + unescape('      %3Ctr%3E%3Ctd colspan="2" height="6" width="400"%3E%3C/td%3E%3C/tr%3E\n')
               if( first == 1 ) {
               jc = jc + '   var first = document.getElementById("First").value;\n'
               jc = jc + '   url = url + "&first=" + first;\n'
               fc = fc + unescape('      %3Ctr%3E\n')
               fc = fc + unescape('         %3Ctd width="200" align="right" class="formtext"%3EFirst')
               if( rfirst == 1 ) {
               jc = jc + '   if(err==0 && first.length == 0) { err=1; Alert("Oops! Please enter your First Name."); }\n'
               fc = fc + unescape('*')
               }
               fc = fc + unescape(': %3C/td%3E\n')
               fc = fc + unescape('         %3Ctd width="200" align="left"%3E%3Cinput id="First" size="20"/%3E%3C/td%3E\n')
               fc = fc + unescape('      %3C/tr%3E\n')
               }
               if( last == 1 ) {
               jc = jc + '   var last = document.getElementById("Last").value;\n'
               jc = jc + '   url = url + "&last=" + last;\n'
               fc = fc + unescape('      %3Ctr%3E\n')
               fc = fc + unescape('         %3Ctd width="200" align="right" class="formtext"%3ELast')
               if( rlast == 1 ) {
               jc = jc + '   if(err==0 && last.length == 0) { err=1; Alert("Oops! Please enter your Last Name."); }\n'
               fc = fc + unescape('*')
               }
               fc = fc + unescape(': %3C/td%3E\n')
               fc = fc + unescape('         %3Ctd width="200" align="left"%3E%3Cinput id="Last" size="20"/%3E%3C/td%3E\n')
               fc = fc + unescape('      %3C/tr%3E\n')
               }
               if( email == 1 ) {
               jc = jc + '   var email = document.getElementById("Email").value;\n'
               jc = jc + '   url = url + "&email=" + email;\n'
               fc = fc + unescape('      %3Ctr%3E\n')
               fc = fc + unescape('         %3Ctd width="200" align="right" class="formtext"%3EEmail')
               if( remail == 1 ) {
               jc = jc + '   if(err==0 && email.length == 0) { err=1; Alert("Oops! Please enter your Email address."); }\n'
               fc = fc + unescape('*')
               }
               fc = fc + unescape(': %3C/td%3E\n')
               fc = fc + unescape('         %3Ctd width="200" align="left"%3E%3Cinput id="Email" size="20"/%3E%3C/td%3E\n')
               fc = fc + unescape('      %3C/tr%3E\n')
               }
               if( phone == 1 ) {
               jc = jc + '   var phone = document.getElementById("Phone").value;\n'
               jc = jc + '   url = url + "&phone=" + phone;\n'
               fc = fc + unescape('      %3Ctr%3E\n')
               fc = fc + unescape('         %3Ctd width="200" align="right" class="formtext"%3EPhone')
               if( rphone == 1 ) {
               jc = jc + '   if(err==0 && phone.length == 0) { err=1; Alert("Oops! Please enter your Phone number."); }\n'
               fc = fc + unescape('*')
               }
               fc = fc + unescape(': %3C/td%3E\n')
               fc = fc + unescape('         %3Ctd width="200" align="left"%3E%3Cinput id="Phone" size="20"/%3E%3C/td%3E\n')
               fc = fc + unescape('      %3C/tr%3E\n')
               }
               if( phone2 == 1 ) {
               jc = jc + '   var phone2 = document.getElementById("Phone2").value;\n'
               jc = jc + '   url = url + "&phone2=" + phone2;\n'
               fc = fc + unescape('      %3Ctr%3E\n')
               fc = fc + unescape('         %3Ctd width="200" align="right" class="formtext"%3EPhone2')
               if( rphone2 == 1 ) {
               jc = jc + '   if(err==0 && phone2.length == 0) { err=1; Alert("Oops! Please enter a 2nd phone number."); }\n'
               fc = fc + unescape('*')
               }
               fc = fc + unescape(': %3C/td%3E\n')
               fc = fc + unescape('         %3Ctd width="200" align="left"%3E%3Cinput id="Phone2" size="20"/%3E%3C/td%3E\n')
               fc = fc + unescape('      %3C/tr%3E\n')
               }
               if( timezone == 1 ) {
               jc = jc + '   var timezone = document.getElementById("TimeZone").value;\n'
               jc = jc + '   url = url + "&timezone=" + timezone;\n'
               fc = fc + unescape('      %3Ctr%3E\n')
               fc = fc + unescape('         %3Ctd width="200" align="right" class="formtext"%3ETime Zone')
               if( rtimezone == 1 ) {
               jc = jc + '   if(err==0 && timezone.length == 0) { err=1; Alert("Oops! Please select your Time Zone."); }\n'
               fc = fc + unescape('*')
               }
               fc = fc + unescape(': %3C/td%3E\n')
               fc = fc + unescape('         %3Ctd width="200" align="left"%3E\n')
               fc = fc + unescape('            %3Cselect id="TimeZone"%3E\n')
               fc = fc + unescape('               %3Coption value="" selected="selected"%3EPlease Select...%3C/option%3E\n')
               fc = fc + unescape('               %3Coption value="-12"%3EGMT-12 Eniwetok%3C/option%3E\n')
               fc = fc + unescape('               %3Coption value="-11"%3EGMT-11 Samoa%3C/option%3E\n')
               fc = fc + unescape('               %3Coption value="-10"%3EGMT-10 US/Hawaii%3C/option%3E\n')
               fc = fc + unescape('               %3Coption value="-9"%3EGMT-9 US/Alaska%3C/option%3E\n')
               fc = fc + unescape('               %3Coption value="-8"%3EGMT-8 US/PST Pacific%3C/option%3E\n')
               fc = fc + unescape('               %3Coption value="-7"%3EGMT-7 US/MST Mountain%3C/option%3E\n')
               fc = fc + unescape('               %3Coption value="-6"%3EGMT-6 US/CST Central%3C/option%3E\n')
               fc = fc + unescape('               %3Coption value="-5"%3EGMT-5 US/EST Eastern%3C/option%3E\n')
               fc = fc + unescape('               %3Coption value="-4"%3EGMT-4 Atlantic, Canada%3C/option%3E\n')
               fc = fc + unescape('               %3Coption value="-3"%3EGMT-3 Brazilia,BuenosAries%3C/option%3E\n')
               fc = fc + unescape('               %3Coption value="-2"%3EGMT-2 Mid-Atlantic%3C/option%3E\n')
               fc = fc + unescape('               %3Coption value="-1"%3EGMT-1 Cape Verdes%3C/option%3E\n')
               fc = fc + unescape('               %3Coption value="0"%3EGMT Greenwich Mean Time%3C/option%3E\n')
               fc = fc + unescape('               %3Coption value="1"%3EGMT+1 Berlin, Rome%3C/option%3E\n')
               fc = fc + unescape('               %3Coption value="2"%3EGMT+2 Israel, Cairo%3C/option%3E\n')
               fc = fc + unescape('               %3Coption value="3"%3EGMT+3 Moscow, Kuwait%3C/option%3E\n')
               fc = fc + unescape('               %3Coption value="4"%3EGMT+4 Abu Dhabi, Muscat%3C/option%3E\n')
               fc = fc + unescape('               %3Coption value="5"%3EGMT+5 Islamabad, Karachi%3C/option%3E\n')
               fc = fc + unescape('               %3Coption value="6"%3EGMT+6 Almaty, Dhaka%3C/option%3E\n')
               fc = fc + unescape('               %3Coption value="7"%3EGMT+7 Bangkok, Jakarta%3C/option%3E\n')
               fc = fc + unescape('               %3Coption value="8"%3EGMT+8 Hong Kong, Beijing%3C/option%3E\n')
               fc = fc + unescape('               %3Coption value="9"%3EGMT+9 Tokyo, Osaka%3C/option%3E\n')
               fc = fc + unescape('               %3Coption value="10"%3EGMT+10 Sydney,Melboure,Guam%3C/option%3E\n')
               fc = fc + unescape('               %3Coption value="11"%3EGMT+11 Magadan, Soloman Is.%3C/option%3E\n')
               fc = fc + unescape('               %3Coption value="12"%3EGMT+12 Fiji,Wellington,Aukland%3C/option%3E\n')
               fc = fc + unescape('            %3C/select%3E\n')
               fc = fc + unescape('         %3C/td%3E\n')
               fc = fc + unescape('      %3C/tr%3E\n')
               }
               if( besttime == 1 ) {
               jc = jc + '   var besttime = document.getElementById("BestTime").value;\n'
               jc = jc + '   url = url + "&besttime=" + besttime;\n'
               fc = fc + unescape('      %3Ctr%3E\n')
               fc = fc + unescape('         %3Ctd width="200" align="right" class="formtext"%3EBest Time')
               if( rbesttime == 1 ) {
               jc = jc + '   if(err==0 && besttime.length == 0) { err=1; Alert("Oops! Please select the Best Time to contact you."); }\n'
               fc = fc + unescape('*')
               }
               fc = fc + unescape(': %3C/td%3E\n')
               fc = fc + unescape('         %3Ctd width="200" align="left"%3E\n')
               fc = fc + unescape('            %3Cselect id="BestTime"%3E\n')
               fc = fc + unescape('               %3Coption value="" selected="selected"%3EPlease Select...%3C/option%3E\n')
               fc = fc + unescape('               %3Coption value="Morning"%3EMorning%3C/option%3E\n')
               fc = fc + unescape('               %3Coption value="Afternoon"%3EAfternoon%3C/option%3E\n')
               fc = fc + unescape('               %3Coption value="Evening"%3EEvening%3C/option%3E\n')
               fc = fc + unescape('               %3Coption value="Weekend"%3EWeekend%3C/option%3E\n')
               fc = fc + unescape('            %3C/select%3E\n')
               fc = fc + unescape('         %3C/td%3E\n')
               fc = fc + unescape('      %3C/tr%3E\n')
               }
               if( description == 1 ) {
               jc = jc + '   var description = document.getElementById("Description").value;\n'
               jc = jc + '   url = url + "&description=" + description;\n'
               fc = fc + unescape('      %3Ctr%3E\n')
               fc = fc + unescape('         %3Ctd width="200" align="right" class="formtext"%3EDescription')
               if( rdescription == 1 ) {
               jc = jc + '   if(err==0 && description.length == 0) { err=1; Alert("Oops! Please enter your Description."); }\n'
               fc = fc + unescape('*')
               }
               fc = fc + unescape(': %3C/td%3E\n')
               fc = fc + unescape('         %3Ctd width="200" align="left"%3E%3Cinput id="Description" size="20"/%3E%3C/td%3E\n')
               fc = fc + unescape('      %3C/tr%3E\n')
               }
               if( source == 1 ) {
               jc = jc + '   var source = document.getElementById("Source").value;\n'
               jc = jc + '   url = url + "&source=" + source;\n'
               fc = fc + unescape('      %3Ctr%3E\n')
               fc = fc + unescape('         %3Ctd width="200" align="right" class="formtext"%3ESource')
               if( rsource == 1 ) {
               jc = jc + '   if(err==0 && source.length == 0) { err=1; Alert("Oops! Please enter how you heard about us."); }\n'
               fc = fc + unescape('*')
               }
               fc = fc + unescape(': %3C/td%3E\n')
               fc = fc + unescape('         %3Ctd width="200" align="left"%3E%3Cinput id="Source" size="20"/%3E%3C/td%3E\n')
               fc = fc + unescape('      %3C/tr%3E\n')
               }
               if( street == 1 ) {
               jc = jc + '   var street = document.getElementById("Street").value;\n'
               jc = jc + '   url = url + "&street=" + street;\n'
               fc = fc + unescape('      %3Ctr%3E\n')
               fc = fc + unescape('         %3Ctd width="200" align="right" class="formtext"%3EStreet')
               if( rstreet == 1 ) {
               jc = jc + '   if(err==0 && street.length == 0) { err=1; Alert("Oops! Please enter your Street address."); }\n'
               fc = fc + unescape('*')
               }
               fc = fc + unescape(': %3C/td%3E\n')
               fc = fc + unescape('         %3Ctd width="200" align="left"%3E%3Cinput id="Street" size="20"/%3E%3C/td%3E\n')
               fc = fc + unescape('      %3C/tr%3E\n')
               }
               if( unit == 1 ) {
               jc = jc + '   var unit = document.getElementById("Unit").value;\n'
               jc = jc + '   url = url + "&unit=" + unit;\n'
               fc = fc + unescape('      %3Ctr%3E\n')
               fc = fc + unescape('         %3Ctd width="200" align="right" class="formtext"%3EUnit')
               if( runit == 1 ) {
               jc = jc + '   if(err==0 && unit.length == 0) { err=1; Alert("Oops! Please enter your Unit #."); }\n'
               fc = fc + unescape('*')
               }
               fc = fc + unescape(': %3C/td%3E\n')
               fc = fc + unescape('         %3Ctd width="200" align="left"%3E%3Cinput id="Unit" size="20"/%3E%3C/td%3E\n')
               fc = fc + unescape('      %3C/tr%3E\n')
               }
               if( city == 1 ) {
               jc = jc + '   var city = document.getElementById("City").value;\n'
               jc = jc + '   url = url + "&city=" + city;\n'
               fc = fc + unescape('      %3Ctr%3E\n')
               fc = fc + unescape('         %3Ctd width="200" align="right" class="formtext"%3ECity')
               if( rcity == 1 ) {
               jc = jc + '   if(err==0 && city.length == 0) { err=1; Alert("Oops! Please enter your City."); }\n'
               fc = fc + unescape('*')
               }
               fc = fc + unescape(': %3C/td%3E\n')
               fc = fc + unescape('         %3Ctd width="200" align="left"%3E%3Cinput id="City" size="20"/%3E%3C/td%3E\n')
               fc = fc + unescape('      %3C/tr%3E\n')
               }
               if( state == 1 ) {
               jc = jc + '   var state = document.getElementById("State").value;\n'
               jc = jc + '   url = url + "&state=" + state;\n'
               fc = fc + unescape('      %3Ctr%3E\n')
               fc = fc + unescape('         %3Ctd width="200" align="right" class="formtext"%3EState')
               if( rstate == 1 ) {
               jc = jc + '   if(err==0 && state.length == 0) { err=1; Alert("Oops! Please enter your State/Region."); }\n'
               fc = fc + unescape('*')
               }
               fc = fc + unescape(': %3C/td%3E\n')
               fc = fc + unescape('         %3Ctd width="200" align="left"%3E%3Cinput id="State" size="20"/%3E%3C/td%3E\n')
               fc = fc + unescape('      %3C/tr%3E\n')
               }
               if( zip == 1 ) {
               jc = jc + '   var zip = document.getElementById("Zip").value;\n'
               jc = jc + '   url = url + "&zip=" + zip;\n'
               fc = fc + unescape('      %3Ctr%3E\n')
               fc = fc + unescape('         %3Ctd width="200" align="right" class="formtext"%3EZip')
               if( rzip == 1 ) {
               jc = jc + '   if(err==0 && zip.length == 0) { err=1; Alert("Oops! Please enter your Postal Code."); }\n'
               fc = fc + unescape('*')
               }
               fc = fc + unescape(': %3C/td%3E\n')
               fc = fc + unescape('         %3Ctd width="200" align="left"%3E%3Cinput id="Zip" size="20"/%3E%3C/td%3E\n')
               fc = fc + unescape('      %3C/tr%3E\n')
               }
               if( country == 1 ) {
               jc = jc + '   var country = document.getElementById("Country").value;\n'
               jc = jc + '   url = url + "&country=" + country;\n'
               fc = fc + unescape('      %3Ctr%3E\n')
               fc = fc + unescape('         %3Ctd width="200" align="right" class="formtext"%3ECountry')
               if( rcountry == 1 ) {
               jc = jc + '   if(err==0 && country.length == 0) { err=1; Alert("Oops! Please enter your Country."); }\n'
               fc = fc + unescape('*')
               }
               fc = fc + unescape(': %3C/td%3E\n')
               fc = fc + unescape('         %3Ctd width="200" align="left"%3E%3Cinput id="Country" size="20"/%3E%3C/td%3E\n')
               fc = fc + unescape('      %3C/tr%3E\n')
               }

               fc = fc + unescape('      %3Ctr%3E\n')
               fc = fc + unescape('         %3Ctd colspan="2" height="6" width="400"%3E%3C/td%3E\n')
               fc = fc + unescape('      %3C/tr%3E\n')
               fc = fc + unescape('      %3Ctr%3E\n')
               fc = fc + unescape('         %3Ctd width="400"%3E%3Cinput id="SubmitButton" onclick="AddContact();" value="Submit" type="button"%3E%3C/td%3E\n')
               fc = fc + unescape('      %3C/tr%3E\n')
               fc = fc + unescape('   %3C/tbody%3E\n')
               fc = fc + unescape('%3C/table%3E\n')

               jc = jc + '\n   if(err==0) {\n'
               jc = jc + '      if(test==0) {\n'
               jc = jc + '         document.getElementById("SubmitButton").disabled=true;\n'
               jc = jc + '         sendAJAX(url);\n'
               jc = jc + '      }\n'
               jc = jc + '      else { alert(url); }\n'
               jc = jc + '   }\n'
               jc = jc + unescape('}%3C/SCRIPT%3E\n');

               document.getElementById('JavaCode').value = jc;
               document.getElementById('FormCode').value = fc;

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
                              <xsl:attribute name="width">200</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">300</xsl:attribute>
                           </xsl:element>
                        </xsl:element>

                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">MemberID</xsl:attribute>
                              <xsl:attribute name="id">MemberID</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@memberid"/></xsl:attribute>
                           </xsl:element>
                           <xsl:element name="INPUT">
                              <xsl:attribute name="type">hidden</xsl:attribute>
                              <xsl:attribute name="name">URL</xsl:attribute>
                              <xsl:attribute name="id">URL</xsl:attribute>
                              <xsl:attribute name="value"><xsl:value-of select="/DATA/PARAM/@url"/></xsl:attribute>
                           </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">200</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">PageHeading</xsl:attribute>
                                 <xsl:element name="IMG">
                                    <xsl:attribute name="src">Images/FormBuilder48.gif</xsl:attribute>
                                    <xsl:attribute name="align">absmiddle</xsl:attribute>
                                    <xsl:attribute name="border">0</xsl:attribute>
                                 </xsl:element>
                                 <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                                 <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FormBuilder']"/>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">2</xsl:attribute>
                              <xsl:attribute name="width">400</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:attribute name="class">prompt</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FormBuilderText']"/>
                           </xsl:element>
                        </xsl:element>

                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="colspan">3</xsl:attribute>
                              <xsl:attribute name="height">1</xsl:attribute>
                              <xsl:attribute name="bgcolor">#000000</xsl:attribute>
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
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">center</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Prospect']"/>
                              <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
                              <xsl:element name="SELECT">
                                 <xsl:attribute name="name">Prospect</xsl:attribute>
                                 <xsl:attribute name="id">Prospect</xsl:attribute>
                                 <xsl:attribute name="onchange"><xsl:text disable-output-escaping="yes"><![CDATA[BuildCode();]]></xsl:text></xsl:attribute>
                                 <xsl:variable name="tmp"><xsl:value-of select="/DATA/PARAM/@prospect"/></xsl:variable>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">0</xsl:attribute>
                                    <xsl:if test="$tmp='0'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AddContact']"/>
                                 </xsl:element>
                                 <xsl:element name="OPTION">
                                    <xsl:attribute name="value">1</xsl:attribute>
                                    <xsl:if test="$tmp='1'"><xsl:attribute name="SELECTED"/></xsl:if>
                                    <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='AddProspect']"/>
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
                              <xsl:attribute name="width">200</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">First</xsl:attribute>
                              <xsl:attribute name="id">First</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[BuildCode();]]></xsl:text></xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@first = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='First']"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">300</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">rFirst</xsl:attribute>
                              <xsl:attribute name="id">rFirst</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[BuildCode();]]></xsl:text></xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@rfirst = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='rFirst']"/>
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
                              <xsl:attribute name="width">200</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">Last</xsl:attribute>
                              <xsl:attribute name="id">Last</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[BuildCode();]]></xsl:text></xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@last = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Last']"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">300</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">rLast</xsl:attribute>
                              <xsl:attribute name="id">rLast</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[BuildCode();]]></xsl:text></xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@rlast = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='rLast']"/>
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
                              <xsl:attribute name="width">200</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">Email</xsl:attribute>
                              <xsl:attribute name="id">Email</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[BuildCode();]]></xsl:text></xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@email = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Email']"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">300</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">rEmail</xsl:attribute>
                              <xsl:attribute name="id">rEmail</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[BuildCode();]]></xsl:text></xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@remail = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='rEmail']"/>
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
                              <xsl:attribute name="width">200</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">Phone</xsl:attribute>
                              <xsl:attribute name="id">Phone</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[BuildCode();]]></xsl:text></xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@phone = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Phone']"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">300</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">rPhone</xsl:attribute>
                              <xsl:attribute name="id">rPhone</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[BuildCode();]]></xsl:text></xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@rphone = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='rPhone']"/>
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
                              <xsl:attribute name="width">200</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">Phone2</xsl:attribute>
                              <xsl:attribute name="id">Phone2</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[BuildCode();]]></xsl:text></xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@phone2 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Phone2']"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">300</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">rPhone2</xsl:attribute>
                              <xsl:attribute name="id">rPhone2</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[BuildCode();]]></xsl:text></xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@rphone2 = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='rPhone2']"/>
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
                              <xsl:attribute name="width">200</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">TimeZone</xsl:attribute>
                              <xsl:attribute name="id">TimeZone</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[BuildCode();]]></xsl:text></xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@timezone = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='TimeZone']"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">300</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">rTimeZone</xsl:attribute>
                              <xsl:attribute name="id">rTimeZone</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[BuildCode();]]></xsl:text></xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@rtimezone = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='rTimeZone']"/>
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
                              <xsl:attribute name="width">200</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">BestTime</xsl:attribute>
                              <xsl:attribute name="id">BestTime</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[BuildCode();]]></xsl:text></xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@besttime = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='BestTime']"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">300</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">rBestTime</xsl:attribute>
                              <xsl:attribute name="id">rBestTime</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[BuildCode();]]></xsl:text></xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@rbesttime = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='rBestTime']"/>
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
                              <xsl:attribute name="width">200</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">Description</xsl:attribute>
                              <xsl:attribute name="id">Description</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[BuildCode();]]></xsl:text></xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@description = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Description']"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">300</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">rDescription</xsl:attribute>
                              <xsl:attribute name="id">rDescription</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[BuildCode();]]></xsl:text></xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@rdescription = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='rDescription']"/>
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
                              <xsl:attribute name="width">200</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">Source</xsl:attribute>
                              <xsl:attribute name="id">Source</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@source = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Source']"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">300</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">rSource</xsl:attribute>
                              <xsl:attribute name="id">rSource</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@rsource = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='rSource']"/>
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
                              <xsl:attribute name="width">200</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">Street</xsl:attribute>
                              <xsl:attribute name="id">Street</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[BuildCode();]]></xsl:text></xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@street = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Street']"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">300</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">rStreet</xsl:attribute>
                              <xsl:attribute name="id">rStreet</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[BuildCode();]]></xsl:text></xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@rstreet = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='rStreet']"/>
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
                              <xsl:attribute name="width">200</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">Unit</xsl:attribute>
                              <xsl:attribute name="id">Unit</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[BuildCode();]]></xsl:text></xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@unit = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Unit']"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">300</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">rUnit</xsl:attribute>
                              <xsl:attribute name="id">rUnit</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[BuildCode();]]></xsl:text></xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@runit = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='rUnit']"/>
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
                              <xsl:attribute name="width">200</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">City</xsl:attribute>
                              <xsl:attribute name="id">City</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[BuildCode();]]></xsl:text></xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@city = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='City']"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">300</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">rCity</xsl:attribute>
                              <xsl:attribute name="id">rCity</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[BuildCode();]]></xsl:text></xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@rcity = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='rCity']"/>
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
                              <xsl:attribute name="width">200</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">State</xsl:attribute>
                              <xsl:attribute name="id">State</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[BuildCode();]]></xsl:text></xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@state = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='State']"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">300</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">rState</xsl:attribute>
                              <xsl:attribute name="id">rState</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[BuildCode();]]></xsl:text></xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@rstate = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='rState']"/>
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
                              <xsl:attribute name="width">200</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">Zip</xsl:attribute>
                              <xsl:attribute name="id">Zip</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[BuildCode();]]></xsl:text></xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@zip = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Zip']"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">300</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">rZip</xsl:attribute>
                              <xsl:attribute name="id">rZip</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[BuildCode();]]></xsl:text></xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@rzip = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='rZip']"/>
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
                              <xsl:attribute name="width">200</xsl:attribute>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">100</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">Country</xsl:attribute>
                              <xsl:attribute name="id">Country</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[BuildCode();]]></xsl:text></xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@country = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Country']"/>
                              </xsl:element>
                           </xsl:element>
                           <xsl:element name="TD">
                              <xsl:attribute name="width">300</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="INPUT">
                              <xsl:attribute name="type">checkbox</xsl:attribute>
                              <xsl:attribute name="name">rCountry</xsl:attribute>
                              <xsl:attribute name="id">rCountry</xsl:attribute>
                              <xsl:attribute name="value">1</xsl:attribute>
                              <xsl:attribute name="onclick"><xsl:text disable-output-escaping="yes"><![CDATA[BuildCode();]]></xsl:text></xsl:attribute>
                              <xsl:if test="(/DATA/PARAM/@rcountry = 1)"><xsl:attribute name="CHECKED"/></xsl:if>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='rCountry']"/>
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
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='JavaCodeText']"/>
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
                              <xsl:attribute name="colspan">3</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TEXTAREA">
                                 <xsl:attribute name="name">JavaCode</xsl:attribute>
                                 <xsl:attribute name="id">JavaCode</xsl:attribute>
                                 <xsl:attribute name="rows">10</xsl:attribute>
                                 <xsl:attribute name="cols">90</xsl:attribute>
                                 <xsl:value-of select="''"/>
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
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='FormCodeText']"/>
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
                              <xsl:attribute name="colspan">3</xsl:attribute>
                              <xsl:attribute name="width">600</xsl:attribute>
                              <xsl:attribute name="align">left</xsl:attribute>
                              <xsl:attribute name="valign">center</xsl:attribute>
                              <xsl:element name="TEXTAREA">
                                 <xsl:attribute name="name">FormCode</xsl:attribute>
                                 <xsl:attribute name="id">FormCode</xsl:attribute>
                                 <xsl:attribute name="rows">10</xsl:attribute>
                                 <xsl:attribute name="cols">90</xsl:attribute>
                                 <xsl:value-of select="''"/>
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
                              <xsl:attribute name="colspan">3</xsl:attribute>
                              <xsl:attribute name="height">12</xsl:attribute>
                           </xsl:element>
                        </xsl:element>
                        <xsl:element name="TR">
                           <xsl:element name="TD">
                              <xsl:attribute name="colspan">3</xsl:attribute>
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
                              <xsl:attribute name="colspan">3</xsl:attribute>
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