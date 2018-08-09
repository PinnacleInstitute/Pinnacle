<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
   <xsl:output omit-xml-declaration="yes"/>

   <xsl:template match="/">

      <xsl:element name="link">
         <xsl:attribute name="rel">stylesheet</xsl:attribute>
         <xsl:attribute name="type">text/css</xsl:attribute>
         <xsl:attribute name="href">Include/Certificate.css</xsl:attribute>
      </xsl:element>
      
      <xsl:element name="HEAD">
			<xsl:element name="TITLE">
				<xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Certificate']"/>
			</xsl:element>

		</xsl:element>

      <!--BEGIN BODY-->
      <xsl:element name="BODY">
         <xsl:attribute name="topmargin">0</xsl:attribute>
         <xsl:attribute name="leftmargin">0</xsl:attribute>
		
         <!--BEGIN PAGE-->
         <xsl:element name="TABLE">
            <xsl:attribute name="border">0</xsl:attribute>
            <xsl:attribute name="cellpadding">0</xsl:attribute>
            <xsl:attribute name="cellspacing">0</xsl:attribute>
            <xsl:attribute name="width">100%</xsl:attribute>
            <xsl:attribute name="height">100%</xsl:attribute>
            <xsl:attribute name="align">center</xsl:attribute>
            <xsl:attribute name="valign">center</xsl:attribute>
            <!--<xsl:attribute name="style">BACKGROUND-IMAGE: url(Images/course_cert.jpg);</xsl:attribute>-->
             <!--<xsl:attribute name="class">TableStyle</xsl:attribute> -->

            <xsl:element name="TR">
               <xsl:element name="TD">
				      <xsl:attribute name="colspan">3</xsl:attribute>
                  <xsl:attribute name="height">9%</xsl:attribute>
                  <xsl:attribute name="width">100%</xsl:attribute>
                  <xsl:element name="IMG">
						   <xsl:attribute name="src">Images/cert_top.jpg</xsl:attribute>
						   <xsl:attribute name="height">100%</xsl:attribute>
						   <xsl:attribute name="width">100%</xsl:attribute>
						</xsl:element>
               </xsl:element>
            </xsl:element>
            
            <xsl:element name="TR">
               <xsl:element name="TD">
                  <xsl:attribute name="height">82%</xsl:attribute>
                  <xsl:attribute name="width">9%</xsl:attribute>
                  <xsl:element name="IMG">
						   <xsl:attribute name="src">Images/cert_left.jpg</xsl:attribute>
						   <xsl:attribute name="height">100%</xsl:attribute>
						   <xsl:attribute name="width">100%</xsl:attribute>
						</xsl:element>
               </xsl:element>   
               
				   <xsl:element name="TD">
                  <xsl:attribute name="height">82%</xsl:attribute>
                  <xsl:attribute name="width">82%</xsl:attribute>
                  
                  <xsl:element name="TABLE">
							<xsl:attribute name="border">0</xsl:attribute>
							<xsl:attribute name="cellpadding">0</xsl:attribute>
							<xsl:attribute name="cellspacing">0</xsl:attribute>
							<xsl:attribute name="width">100%</xsl:attribute>
							<xsl:attribute name="height">100%</xsl:attribute>
            
							<xsl:element name="TR">
			               <xsl:element name="TD">
			                  <xsl:attribute name="height">4%</xsl:attribute>
			               </xsl:element>
			               <xsl:element name="TD">
			                  <xsl:attribute name="height">4%</xsl:attribute>
			               </xsl:element>
			            </xsl:element>

							<xsl:variable name="tmpHeader">
								<xsl:if test="/DATA/PARAM/@companyid = 0">Images/CertificateHeader.gif</xsl:if>
								<xsl:if test="/DATA/PARAM/@companyid > 0"><xsl:value-of select="concat('Images/Company/', /DATA/PARAM/@companyid, '/CertificateHeader.gif')"/></xsl:if>
							</xsl:variable>

			             <xsl:element name="TR">
			               <xsl:element name="TD">
			                  <xsl:attribute name="colspan">2</xsl:attribute>
			                  <xsl:attribute name="align">center</xsl:attribute>
			                  <xsl:attribute name="valign">center</xsl:attribute>
			                  <xsl:attribute name="class">Title</xsl:attribute>
			                  <xsl:attribute name="height">15%</xsl:attribute>
									<xsl:element name="IMG">
										<xsl:attribute name="src"><xsl:value-of select="$tmpHeader"/></xsl:attribute>
										<xsl:attribute name="height">100%</xsl:attribute>
									</xsl:element>
				            </xsl:element>
			            </xsl:element>
			               
							<xsl:element name="TR">
			               <xsl:element name="TD">
			                  <xsl:attribute name="colspan">2</xsl:attribute>
			                  <xsl:attribute name="height">3%</xsl:attribute>
			               </xsl:element>
			            </xsl:element>

			             <xsl:element name="TR">
			               <xsl:element name="TD">
			                  <xsl:attribute name="colspan">2</xsl:attribute>
			                  <xsl:attribute name="align">center</xsl:attribute>
			                  <xsl:attribute name="valign">center</xsl:attribute>
			                  <xsl:attribute name="class">Achievement</xsl:attribute>
			                  <xsl:attribute name="height">11%</xsl:attribute>
							  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Certification']"/>
			               </xsl:element>
			            </xsl:element>

			            <xsl:element name="TR">
			               <xsl:element name="TD">
			                  <xsl:attribute name="colspan">2</xsl:attribute>
			                  <xsl:attribute name="height">3%</xsl:attribute>
			               </xsl:element>
			            </xsl:element>
			               
			            <xsl:element name="TR">
			               <xsl:element name="TD">
			                  <xsl:attribute name="colspan">2</xsl:attribute>
			                  <xsl:attribute name="align">center</xsl:attribute>
			                  <xsl:attribute name="valign">center</xsl:attribute>
			                  <xsl:attribute name="class">DateText</xsl:attribute>
			                  <xsl:attribute name="height">5%</xsl:attribute>
			                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Certify']"/>
			               </xsl:element>
			            </xsl:element> 

			            <xsl:element name="TR">
			               <xsl:element name="TD">
			                  <xsl:attribute name="colspan">2</xsl:attribute>
			                  <xsl:attribute name="height">3%</xsl:attribute>
			               </xsl:element>
			            </xsl:element>

			            <xsl:element name="TR">
			               <xsl:element name="TD">
			                  <xsl:attribute name="colspan">2</xsl:attribute>
			                  <xsl:attribute name="align">center</xsl:attribute>
			                  <xsl:attribute name="valign">center</xsl:attribute>
			                  <xsl:attribute name="class">StudentName</xsl:attribute>
			                  <xsl:attribute name="height">5%</xsl:attribute>
			                  <xsl:value-of select="/DATA/PARAM/@studentname"/>
			               </xsl:element>
			            </xsl:element>
			            <xsl:element name="TR">
			               <xsl:element name="TD">
			                  <xsl:attribute name="colspan">2</xsl:attribute>
			                  <xsl:attribute name="height">4%</xsl:attribute>
			               </xsl:element>
			            </xsl:element>
							
			            <xsl:element name="TR">
			               <xsl:element name="TD">
			                  <xsl:attribute name="colspan">2</xsl:attribute>
			                  <xsl:attribute name="align">center</xsl:attribute>
			                  <xsl:attribute name="valign">center</xsl:attribute>
			                  <xsl:attribute name="class">DateText</xsl:attribute>
			                  <xsl:attribute name="height">4%</xsl:attribute>
			                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Completed']"/>
			               </xsl:element>
			            </xsl:element>
			               
			             <xsl:element name="TR">
			               <xsl:element name="TD">
			                  <xsl:attribute name="colspan">2</xsl:attribute>
			                  <xsl:attribute name="align">center</xsl:attribute>
			                  <xsl:attribute name="valign">center</xsl:attribute>
			                  <xsl:attribute name="class">CourseName</xsl:attribute>
			                  <xsl:attribute name="height">20%</xsl:attribute>
			                  <xsl:value-of select="/DATA/TXN/PTSORG/@orgname"/>
			               </xsl:element>
			            </xsl:element>

			            <xsl:element name="TR">
			               <xsl:element name="TD">
			                  <xsl:attribute name="colspan">2</xsl:attribute>
			                  <xsl:attribute name="height">5%</xsl:attribute>
			               </xsl:element>
			            </xsl:element>
			               
			            <xsl:element name="TR">
			               <xsl:element name="TD">
			                  <xsl:attribute name="align">center</xsl:attribute>
			                  <xsl:attribute name="valign">center</xsl:attribute>
			                  <xsl:attribute name="class">DateText</xsl:attribute>
			                  <xsl:attribute name="height">10%</xsl:attribute>
									<xsl:attribute name="width">70%</xsl:attribute>
			                  <xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;&amp;#160;</xsl:text>
			                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='Presented']"/>
			                  <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
			                  <xsl:value-of select="/DATA/PARAM/@day"/>
			                  <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
			                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name='DayOf']"/>
			                  <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
			                  <xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=/DATA/PARAM/@month]"/>
			                  <xsl:text disable-output-escaping="yes">,&amp;#160;</xsl:text>
			                  <xsl:value-of select="/DATA/PARAM/@year"/>
			               </xsl:element>
			               <xsl:element name="TD">
			                  <xsl:attribute name="align">right</xsl:attribute>
			                  <xsl:attribute name="valign">center</xsl:attribute>
			                  <xsl:attribute name="height">10%</xsl:attribute>
									<xsl:attribute name="width">30%</xsl:attribute>
			                  <xsl:element name="IMG">
										<xsl:attribute name="src"><xsl:value-of select="/DATA/PARAM/@signature"/></xsl:attribute>
										<xsl:attribute name="height">100%</xsl:attribute>
									</xsl:element>
			               </xsl:element>
			            </xsl:element>

			            <xsl:element name="TR">
			               <xsl:element name="TD">
			                  <xsl:attribute name="colspan">2</xsl:attribute>
			                  <xsl:attribute name="height">4%</xsl:attribute>
			               </xsl:element>
			            </xsl:element>

						</xsl:element>
						<!-- END inner table -->
					</xsl:element>
					<!-- END inner cell -->
				
					<xsl:element name="TD">
                  <xsl:attribute name="height">82%</xsl:attribute>
                  <xsl:attribute name="width">9%</xsl:attribute>
                  <xsl:element name="IMG">
							<xsl:attribute name="src">Images/cert_right.jpg</xsl:attribute>
							<xsl:attribute name="height">100%</xsl:attribute>
							<xsl:attribute name="width">100%</xsl:attribute>
						</xsl:element>
					</xsl:element>  
					
            </xsl:element>
            
            <xsl:element name="TR">
               <xsl:element name="TD">
				      <xsl:attribute name="colspan">3</xsl:attribute>
                  <xsl:attribute name="height">9%</xsl:attribute>
                  <xsl:attribute name="width">100%</xsl:attribute>
                  <xsl:element name="IMG">
							<xsl:attribute name="src">Images/cert_bottom.jpg</xsl:attribute>
							<xsl:attribute name="height">100%</xsl:attribute>
							<xsl:attribute name="width">100%</xsl:attribute>
						</xsl:element>
               </xsl:element>
            </xsl:element>

         </xsl:element>
         <!--END PAGE-->
			
      </xsl:element>
      <!--END BODY-->

   </xsl:template>
</xsl:stylesheet>