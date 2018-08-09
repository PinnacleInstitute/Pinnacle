
<xsl:variable name="firstparent" select="{0}"/> 

<!--==================================================================-->
   <xsl:template name="TreeNode">
<!--==================================================================-->
      <xsl:param name="parentid"/>
	
      <!--begin loop-->
      <xsl:for-each select="{/DATA/TXN/PTSMESSAGES/PTSMESSAGE}[@{parentid}=$parentid]">

		<xsl:variable name="nodeid" select="@{messageid}"/> 
		<xsl:variable name="children" select="count({/DATA/TXN/PTSMESSAGES/PTSMESSAGE}[@{parentid}=$nodeid])"/> 
      
      <!--begin the trigger-->
      <xsl:element name="SPAN">
			<xsl:attribute name="class">Trigger</xsl:attribute> 
			<xsl:attribute name="id"><xsl:value-of select="concat('H', $nodeid)"/></xsl:attribute>

			<xsl:attribute name="onClick">showBranch('<xsl:value-of select="$nodeid"/>', <xsl:value-of select="$children"/>);</xsl:attribute>
			<xsl:attribute name="onMouseOver">highliteBranch('<xsl:value-of select="$nodeid"/>', true);</xsl:attribute>
			<xsl:attribute name="onMouseOut">highliteBranch('<xsl:value-of select="$nodeid"/>', false);</xsl:attribute>
            
            <xsl:element name="TABLE"> 
				<xsl:attribute name="width">500</xsl:attribute>
				<xsl:attribute name="border">0</xsl:attribute> 
				<xsl:attribute name="cellpadding">0</xsl:attribute> 
				<xsl:attribute name="cellspacing">0</xsl:attribute> 
				<xsl:element name="TR">
					<xsl:element name="TD">
						<xsl:attribute name="width">12</xsl:attribute> 
						<xsl:attribute name="height">26</xsl:attribute>
						<xsl:attribute name="align">right</xsl:attribute>
						<xsl:attribute name="valign">center</xsl:attribute> 

						<xsl:choose>
						<xsl:when test="$nodeid=$firstparent"><xsl:attribute name="class">FirstNode</xsl:attribute></xsl:when>
						<xsl:when test="position()=last()"><xsl:attribute name="class">LastNode</xsl:attribute></xsl:when>
						<xsl:otherwise><xsl:attribute name="class">MiddleNode</xsl:attribute></xsl:otherwise>
						</xsl:choose>

						<xsl:if test="($children &gt; 0)">
							<xsl:element name="IMG">
							   <xsl:attribute name="id"><xsl:value-of select="concat('I', $nodeid)"/></xsl:attribute>
							   <xsl:choose>
						       <xsl:when test="($parentid=$firstparent)"><xsl:attribute name="src">Images/{tree-plus.gif}</xsl:attribute></xsl:when>
						       <xsl:otherwise><xsl:attribute name="src">Images/{tree-minus.gif}</xsl:attribute></xsl:otherwise>
						       </xsl:choose>		   
							</xsl:element>
						</xsl:if>
									
					</xsl:element>
					<xsl:element name="TD">
						<xsl:attribute name="width">26</xsl:attribute> 
						<xsl:attribute name="height">26</xsl:attribute>
						<xsl:attribute name="align">left</xsl:attribute>
						<xsl:attribute name="valign">center</xsl:attribute> 
											
						<xsl:element name="IMG">
						   <xsl:attribute name="id"><xsl:value-of select="concat('I', $nodeid)"/></xsl:attribute>
						   <xsl:attribute name="src">Images/{tree-node.gif}</xsl:attribute>	   
						</xsl:element>
						
					</xsl:element>
					<xsl:element name="TD"> 
					   <xsl:attribute name="rowspan">2</xsl:attribute>
					   
<!-- ********************************insert content here, must create a subtree to define rows******************************** -->						
						
					</xsl:element>					
				</xsl:element>
				<xsl:element name="TR">
					<xsl:element name="TD">		
						<xsl:if test="position()!=last()"><xsl:attribute name="class">TreeBar</xsl:attribute></xsl:if>
						<xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
					</xsl:element>
					<xsl:element name="TD">
						<xsl:attribute name="id"><xsl:value-of select="concat('S', $nodeid)"/></xsl:attribute>
						<xsl:if test="$parentid=0"><xsl:attribute name="class">SubTreeBar</xsl:attribute></xsl:if>
						<xsl:text disable-output-escaping="yes">&amp;#160;&amp;#160;</xsl:text>
					</xsl:element>
				</xsl:element>
            </xsl:element>
         </xsl:element>

         <xsl:element name="DIV">
			<xsl:if test="($parentid!=$firstparent) and (position()!=last())">
			   <xsl:attribute name="class">TreeBar</xsl:attribute>
			</xsl:if>
			
			<xsl:element name="SPAN">
				<xsl:attribute name="class">Branch</xsl:attribute>
			
				<xsl:choose>
				<xsl:when test="($parentid=$firstparent)"><xsl:attribute name="style">DISPLAY: block;</xsl:attribute></xsl:when>
				<xsl:otherwise><xsl:attribute name="style">DISPLAY: none;</xsl:attribute></xsl:otherwise>
				</xsl:choose>

			   <xsl:attribute name="id"><xsl:value-of select="$nodeid"/></xsl:attribute>
		
			   <xsl:call-template name="TreeNode">
				   <xsl:with-param name="parentid" select="$nodeid"/>
			   </xsl:call-template>			

			</xsl:element>
			
		</xsl:element>   
      </xsl:for-each>
   </xsl:template>
   
<!-- ************************************************Javascript*********************************************** -->
<xsl:element name="SCRIPT">
<xsl:attribute name="language">JavaScript</xsl:attribute>
<xsl:text disable-output-escaping="yes"><![CDATA[ 
	var openImg = new Image();
	openImg.src = "Images/{tree-minus.gif}";
	var closeImg = new Image();
	closeImg.src = "Images/{tree-plus.gif}";
	   
	function showBranch(branch, children){
		var objBranch = document.getElementById(branch).style;
		if(children > 0){
			if(objBranch.display=="block"){objBranch.display="none";} else{objBranch.display="block";}
			swapFolder(branch);
		}
	}
	   
	function swapFolder(branch){
	   objImg = document.getElementById('I' + String(branch));
	   objClass = document.getElementById('S' + String(branch));
	   if(objImg.src.indexOf('Images/{tree-plus.gif}')>-1) {
	      objImg.src = openImg.src;
	      objClass.className = '';
	   } else {
	      objImg.src = closeImg.src;
	      objClass.className = 'SubTreeBar';
	   }
	}

	function highliteBranch(branch, show){
	   var objBranch = 
	      document.getElementById('H' + String(branch)).style;
	   if(show==true)
	      objBranch.background="{#FAEFD4}"; <!-- highlite color -->
	   else
	      objBranch.background="{#FFFFFF}";
	}
]]></xsl:text>

<!-- ********************************code to insert the control, starting with parentid=0******************************** -->
<xsl:element name="SPAN">
   <xsl:attribute name="class">TreeView</xsl:attribute>
   <xsl:attribute name="style">WIDTH: {600}; HEIGHT: {400};</xsl:attribute>
   <xsl:call-template name="TreeNode">
      <xsl:with-param name="parentid" select="$firstparent"/>
   </xsl:call-template>
</xsl:element>