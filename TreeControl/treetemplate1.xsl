
&lt;xsl:variable name=&quot;firstparent&quot; select=&quot;{0}&quot;/&gt; 

&lt;!--==================================================================--&gt;
   &lt;xsl:template name=&quot;TreeNode&quot;&gt;
&lt;!--==================================================================--&gt;
      &lt;xsl:param name=&quot;parentid&quot;/&gt;
	
      &lt;!--begin loop--&gt;
      &lt;xsl:for-each select=&quot;{/DATA/TXN/PTSMESSAGES/PTSMESSAGE}[@{parentid}=$parentid]&quot;&gt;

		&lt;xsl:variable name=&quot;nodeid&quot; select=&quot;@{messageid}&quot;/&gt; 
		&lt;xsl:variable name=&quot;children&quot; select=&quot;count({/DATA/TXN/PTSMESSAGES/PTSMESSAGE}[@{parentid}=$nodeid])&quot;/&gt; 
      
         &lt;!--begin the trigger--&gt;
         &lt;xsl:element name=&quot;SPAN&quot;&gt;
			&lt;xsl:attribute name=&quot;class&quot;&gt;Trigger&lt;/xsl:attribute&gt; 
			&lt;xsl:attribute name=&quot;id&quot;&gt;&lt;xsl:value-of select=&quot;concat('H', $nodeid)&quot;/&gt;&lt;/xsl:attribute&gt;

			&lt;xsl:attribute name=&quot;onClick&quot;&gt;showBranch('&lt;xsl:value-of select=&quot;$nodeid&quot;/&gt;', &lt;xsl:value-of select=&quot;$children&quot;/&gt;);&lt;/xsl:attribute&gt;
			&lt;xsl:attribute name=&quot;onMouseOver&quot;&gt;highliteBranch('&lt;xsl:value-of select=&quot;$nodeid&quot;/&gt;', true);&lt;/xsl:attribute&gt;
			&lt;xsl:attribute name=&quot;onMouseOut&quot;&gt;highliteBranch('&lt;xsl:value-of select=&quot;$nodeid&quot;/&gt;', false);&lt;/xsl:attribute&gt;
            
            &lt;xsl:element name=&quot;TABLE&quot;&gt; 
				&lt;xsl:attribute name=&quot;width&quot;&gt;500&lt;/xsl:attribute&gt;
				&lt;xsl:attribute name=&quot;border&quot;&gt;0&lt;/xsl:attribute&gt; 
				&lt;xsl:attribute name=&quot;cellpadding&quot;&gt;0&lt;/xsl:attribute&gt; 
				&lt;xsl:attribute name=&quot;cellspacing&quot;&gt;0&lt;/xsl:attribute&gt; 
				&lt;xsl:element name=&quot;TR&quot;&gt;
					&lt;xsl:element name=&quot;TD&quot;&gt;
						&lt;xsl:attribute name=&quot;width&quot;&gt;12&lt;/xsl:attribute&gt; 
						&lt;xsl:attribute name=&quot;height&quot;&gt;26&lt;/xsl:attribute&gt;
						&lt;xsl:attribute name=&quot;align&quot;&gt;right&lt;/xsl:attribute&gt;
						&lt;xsl:attribute name=&quot;valign&quot;&gt;center&lt;/xsl:attribute&gt; 

						&lt;xsl:choose&gt;
						&lt;xsl:when test=&quot;$nodeid=$firstparent&quot;&gt;&lt;xsl:attribute name=&quot;class&quot;&gt;FirstNode&lt;/xsl:attribute&gt;&lt;/xsl:when&gt;
						&lt;xsl:when test=&quot;position()=last()&quot;&gt;&lt;xsl:attribute name=&quot;class&quot;&gt;LastNode&lt;/xsl:attribute&gt;&lt;/xsl:when&gt;
						&lt;xsl:otherwise&gt;&lt;xsl:attribute name=&quot;class&quot;&gt;MiddleNode&lt;/xsl:attribute&gt;&lt;/xsl:otherwise&gt;
						&lt;/xsl:choose&gt;

						&lt;xsl:if test=&quot;($children &gt; 0)&quot;&gt;
							&lt;xsl:element name=&quot;IMG&quot;&gt;
							   &lt;xsl:attribute name=&quot;id&quot;&gt;&lt;xsl:value-of select=&quot;concat('I', $nodeid)&quot;/&gt;&lt;/xsl:attribute&gt;
							   &lt;xsl:choose&gt;
						       &lt;xsl:when test=&quot;($parentid=$firstparent)&quot;&gt;&lt;xsl:attribute name=&quot;src&quot;&gt;Images/{tree-plus.gif}&lt;/xsl:attribute&gt;&lt;/xsl:when&gt;
						       &lt;xsl:otherwise&gt;&lt;xsl:attribute name=&quot;src&quot;&gt;Images/{tree-minus.gif}&lt;/xsl:attribute&gt;&lt;/xsl:otherwise&gt;
						       &lt;/xsl:choose&gt;		   
							&lt;/xsl:element&gt;
						&lt;/xsl:if&gt;
									
					&lt;/xsl:element&gt;
					&lt;xsl:element name=&quot;TD&quot;&gt;
						&lt;xsl:attribute name=&quot;width&quot;&gt;26&lt;/xsl:attribute&gt; 
						&lt;xsl:attribute name=&quot;height&quot;&gt;26&lt;/xsl:attribute&gt;
						&lt;xsl:attribute name=&quot;align&quot;&gt;left&lt;/xsl:attribute&gt;
						&lt;xsl:attribute name=&quot;valign&quot;&gt;center&lt;/xsl:attribute&gt; 
											
						&lt;xsl:element name=&quot;IMG&quot;&gt;
						   &lt;xsl:attribute name=&quot;id&quot;&gt;&lt;xsl:value-of select=&quot;concat('I', $nodeid)&quot;/&gt;&lt;/xsl:attribute&gt;
						   &lt;xsl:attribute name=&quot;src&quot;&gt;Images/{tree-node.gif}&lt;/xsl:attribute&gt;	   
						&lt;/xsl:element&gt;
						
					&lt;/xsl:element&gt;
					&lt;xsl:element name=&quot;TD&quot;&gt; 
					   &lt;xsl:attribute name=&quot;rowspan&quot;&gt;2&lt;/xsl:attribute&gt;
					   
&lt;!-- ********************************insert content here, must create a subtree to define rows******************************** --&gt;						
						
					&lt;/xsl:element&gt;					
				&lt;/xsl:element&gt;
				&lt;xsl:element name=&quot;TR&quot;&gt;
					&lt;xsl:element name=&quot;TD&quot;&gt;		
						&lt;xsl:if test=&quot;position()!=last()&quot;&gt;&lt;xsl:attribute name=&quot;class&quot;&gt;TreeBar&lt;/xsl:attribute&gt;&lt;/xsl:if&gt;
						&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&amp;#160;&amp;#160;&lt;/xsl:text&gt;
					&lt;/xsl:element&gt;
					&lt;xsl:element name=&quot;TD&quot;&gt;
						&lt;xsl:attribute name=&quot;id&quot;&gt;&lt;xsl:value-of select=&quot;concat('S', $nodeid)&quot;/&gt;&lt;/xsl:attribute&gt;
						&lt;xsl:if test=&quot;$parentid=0&quot;&gt;&lt;xsl:attribute name=&quot;class&quot;&gt;SubTreeBar&lt;/xsl:attribute&gt;&lt;/xsl:if&gt;
						&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&amp;#160;&amp;#160;&lt;/xsl:text&gt;
					&lt;/xsl:element&gt;
				&lt;/xsl:element&gt;
            &lt;/xsl:element&gt;
         &lt;/xsl:element&gt;

         &lt;xsl:element name=&quot;DIV&quot;&gt;
			&lt;xsl:if test=&quot;($parentid!=$firstparent) and (position()!=last())&quot;&gt;
			   &lt;xsl:attribute name=&quot;class&quot;&gt;TreeBar&lt;/xsl:attribute&gt;
			&lt;/xsl:if&gt;
			&lt;xsl:element name=&quot;SPAN&quot;&gt;
				&lt;xsl:attribute name=&quot;class&quot;&gt;Branch&lt;/xsl:attribute&gt;
			
				&lt;xsl:choose&gt;
				&lt;xsl:when test=&quot;($parentid=$firstparent)&quot;&gt;&lt;xsl:attribute name=&quot;style&quot;&gt;DISPLAY: block;&lt;/xsl:attribute&gt;&lt;/xsl:when&gt;
				&lt;xsl:otherwise&gt;&lt;xsl:attribute name=&quot;style&quot;&gt;DISPLAY: none;&lt;/xsl:attribute&gt;&lt;/xsl:otherwise&gt;
				&lt;/xsl:choose&gt;

			   &lt;xsl:attribute name=&quot;id&quot;&gt;&lt;xsl:value-of select=&quot;$nodeid&quot;/&gt;&lt;/xsl:attribute&gt;
		
			   &lt;xsl:call-template name=&quot;TreeNode&quot;&gt;
				   &lt;xsl:with-param name=&quot;parentid&quot; select=&quot;$nodeid&quot;/&gt;
			   &lt;/xsl:call-template&gt;			

			&lt;/xsl:element&gt;
		&lt;/xsl:element&gt;   
      &lt;/xsl:for-each&gt;
   &lt;/xsl:template&gt;
   
&lt;!-- ************************************************Javascript*********************************************** --&gt;
&lt;xsl:element name=&quot;SCRIPT&quot;&gt;
	&lt;xsl:attribute name=&quot;language&quot;&gt;JavaScript&lt;/xsl:attribute&gt;
	&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&lt;![CDATA[ 
	var openImg = new Image();
	openImg.src = &quot;Images/{tree-minus.gif}&quot;;
	var closeImg = new Image();
	closeImg.src = &quot;Images/{tree-plus.gif}&quot;;
	   
	function showBranch(branch, children){
		var objBranch = document.getElementById(branch).style;
		if(children &gt; 0){
			if(objBranch.display==&quot;block&quot;){objBranch.display=&quot;none&quot;;} else{objBranch.display=&quot;block&quot;;}
			swapFolder(branch);
		}
	}
	   
	function swapFolder(branch){
	   objImg = document.getElementById('I' + String(branch));
	   objClass = document.getElementById('S' + String(branch));
	   if(objImg.src.indexOf('Images/{tree-plus.gif}')&gt;-1) {
	      objImg.src = openImg.src;
	      objClass.className = '';
	   } else {
	      objImg.src = closeImg.src;
	      objClass.className = 'SubTreeBar';
	   }
	}

	function highliteBranch(branch, show){
	   var objBranch = document.getElementById('H' + String(branch)).style;
	   if(show==true)
	      objBranch.background=&quot;{#FAEFD4}&quot;; &lt;!-- highlite color --&gt;
	   else
	      objBranch.background=&quot;{#FFFFFF}&quot;;
	}
]]&gt;&lt;/xsl:text&gt;

&lt;!-- ********************************code to insert the control, starting with parentid=0******************************** --&gt;
&lt;xsl:element name=&quot;SPAN&quot;&gt;
   &lt;xsl:attribute name=&quot;class&quot;&gt;TreeView&lt;/xsl:attribute&gt;
   &lt;xsl:attribute name=&quot;style&quot;&gt;WIDTH: {600}; HEIGHT: {400};&lt;/xsl:attribute&gt;
   &lt;xsl:call-template name=&quot;TreeNode&quot;&gt;
      &lt;xsl:with-param name=&quot;parentid&quot; select=&quot;$firstparent&quot;/&gt;
   &lt;/xsl:call-template&gt;
&lt;/xsl:element&gt;