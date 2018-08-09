<% Response.Buffer=true

Response.Write "<BR/> <H2><B>HTTP Server Variables - Request.ServerVariables(<Font color=&quot;blue&quot;>...</Font>)</B></H2>"

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> ALL_HTTP</Font>..." + Request.ServerVariables("ALL_HTTP") + "</B>"
Response.Write "<BR/> *** All HTTP headers sent by the client."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> ALL_RAW</Font>..." + Request.ServerVariables("ALL_RAW") + "</B>"
Response.Write "<BR/> *** Retrieves all headers in raw form. The difference between ALL_RAW and ALL_HTTP is that ALL_HTTP places an HTTP_ prefix before the header name and the header name is always capitalized. In ALL_RAW the header name and values appear as they are sent by the client."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> APPL_MD_PATH</Font>..." + Request.ServerVariables("APPL_MD_PATH") + "</B>"
Response.Write "<BR/> *** Retrieves the metabase path for the Application for the ISAPI DLL."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> APPL_PHYSICAL_PATH</Font>..." + Request.ServerVariables("APPL_PHYSICAL_PATH") + "</B>"
Response.Write "<BR/> *** Retrieves the physical path corresponding to the metabase path. IIS converts the APPL_MD_PATH to the physical (directory) path to return this value."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> AUTH_PASSWORD</Font>..." + Request.ServerVariables("AUTH_PASSWORD") + "</B>"
Response.Write "<BR/> *** The value entered in the client's authentication dialog. This variable is available only if Basic authentication is used."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> AUTH_TYPE</Font>..." + Request.ServerVariables("AUTH_TYPE") + "</B>"
Response.Write "<BR/> *** The authentication method that the server uses to validate users when they attempt to access a protected script."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> AUTH_USER</Font>..." + Request.ServerVariables("AUTH_USER") + "</B>"
Response.Write "<BR/> *** Raw authenticated user name."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> CERT_COOKIE</Font>..." + Request.ServerVariables("CERT_COOKIE") + "</B>"
Response.Write "<BR/> *** Unique ID for client certificate, returned as a string. Can be used as a signature for the whole client certificate."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> CERT_FLAGS</Font>..." + Request.ServerVariables("CERT_FLAGS") + "</B>"
Response.Write "<BR/> *** bit0 is set to 1 if the client certificate is present. bit1 is set to 1 if the cCertification authority of the client certificate is invalid (it is not in the list of recognized CAs on the server)."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> CERT_ISSUER</Font>..." + Request.ServerVariables("CERT_ISSUER") + "</B>"
Response.Write "<BR/> *** Issuer field of the client certificate (O=MS, OU=IAS, CN=user name, C=USA)."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> CERT_KEYSIZE</Font>..." + Request.ServerVariables("CERT_KEYSIZE") + "</B>"
Response.Write "<BR/> *** Number of bits in Secure Sockets Layer connection key size. For example, 128."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> CERT_SECRETKEYSIZE</Font>..." + Request.ServerVariables("CERT_SECRETKEYSIZE") + "</B>"
Response.Write "<BR/> *** Number of bits in server certificate private key. For example, 1024."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> CERT_SERIALNUMBER</Font>..." + Request.ServerVariables("CERT_SERIALNUMBER") + "</B>"
Response.Write "<BR/> *** Serial number field of the client certificate."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> CERT_SERVER_ISSUER</Font>..." + Request.ServerVariables("CERT_SERVER_ISSUER") + "</B>"
Response.Write "<BR/> *** Issuer field of the server certificate."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> CERT_SERVER_SUBJECT</Font>..." + Request.ServerVariables("CERT_SERVER_SUBJECT") + "</B>"
Response.Write "<BR/> *** Subject field of the server certificate."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> CERT_SUBJECT</Font>..." + Request.ServerVariables("CERT_SUBJECT") + "</B>"
Response.Write "<BR/> *** Subject field of the client certificate."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> CONTENT_LENGTH</Font>..." + Request.ServerVariables("CONTENT_LENGTH") + "</B>"
Response.Write "<BR/> *** The length of the content as given by the client."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> CONTENT_TYPE</Font>..." + Request.ServerVariables("CONTENT_TYPE") + "</B>"
Response.Write "<BR/> *** The data type of the content. Used with queries that have attached information, such as the HTTP queries GET, POST, and PUT."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> GATEWAY_INTERFACE</Font>..." + Request.ServerVariables("GATEWAY_INTERFACE") + "</B>"
Response.Write "<BR/> *** The revision of the CGI specification used by the server. The format is CGI/revision"

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> HTTP_&lt;<I>HeaderName</I>&gt;</Font>...</B> "
Response.Write "<BR/> *** The value stored in the header <I>HeaderName</I>. Any header other than those listed in this table must be prefixed by HTTP_ in order for the ServerVariables collection to retrieve its value. The server interprets any underscore (_) characters in <I>HeaderName</I> as dashes in the actual header. For example if you specify HTTP_MY_HEADER, the server searches for a header sent as MY-HEADER."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> HTTP_ACCEPT</Font>..." + Request.ServerVariables("HTTP_ACCEPT") + "</B>"
Response.Write "<BR/> *** Returns the value of the Accept header."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> HTTP_ACCEPT_LANGUAGE</Font>..." + Request.ServerVariables("HTTP_ACCEPT_LANGUAGE") + "</B>"
Response.Write "<BR/> *** Returns a string describing the language to use for displaying content."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> HTTP_USER_AGENT</Font>..." + Request.ServerVariables("HTTP_USER_AGENT") + "</B>"
Response.Write "<BR/> *** Returns a string describing the browser that sent the request."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> HTTP_COOKIE</Font>..." + Request.ServerVariables("HTTP_COOKIE") + "</B>"
Response.Write "<BR/> *** Returns the cookie string that was included with the request."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> HTTP_REFERER</Font>..." + Request.ServerVariables("HTTP_REFERER") + "</B>"
Response.Write "<BR/> *** Returns a string containing the URL of the original request when a redirect has occurred."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> HTTPS</Font>..." + Request.ServerVariables("HTTPS") + "</B>"
Response.Write "<BR/> *** Returns ON if the request came in through secure channel (SSL) or it returns OFF if the request is for a non-secure channel."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> HTTPS_KEYSIZE</Font>..." + Request.ServerVariables("HTTPS_KEYSIZE") + "</B>"
Response.Write "<BR/> *** Number of bits in Secure Sockets Layer connection key size. For example, 128."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> HTTPS_SECRETKEYSIZE</Font>..." + Request.ServerVariables("HTTPS_SECRETKEYSIZE") + "</B>"
Response.Write "<BR/> *** Number of bits in server certificate private key. For example, 1024."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> HTTPS_SERVER_ISSUER</Font>..." + Request.ServerVariables("HTTPS_SERVER_ISSUER") + "</B>"
Response.Write "<BR/> *** Issuer field of the server certificate."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> HTTPS_SERVER_SUBJECT</Font>..." + Request.ServerVariables("HTTPS_SERVER_SUBJECT") + "</B>"
Response.Write "<BR/> *** Subject field of the server certificate."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> INSTANCE_ID</Font>..." + Request.ServerVariables("INSTANCE_ID") + "</B>"
Response.Write "<BR/> *** The ID for the IIS instance in textual format. If the instance ID is 1, it appears as a string. You can use this variable to retrieve the ID of the Web-server instance (in the metabase) to which the request belongs."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> INSTANCE_META_PATH</Font>..." + Request.ServerVariables("INSTANCE_META_PATH") + "</B>"
Response.Write "<BR/> *** The metabase path for the instance of IIS that responds to the request."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> LOCAL_ADDR</Font>..." + Request.ServerVariables("LOCAL_ADDR") + "</B>"
Response.Write "<BR/> *** Returns the Server Address on which the request came in. This is important on multihomed machines where there can be multiple IP addresses bound to the machine and you want to find out which address the request used."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> LOGON_USER</Font>..." + Request.ServerVariables("LOGON_USER") + "</B>"
Response.Write "<BR/> *** The Windows account that the user is logged into."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> PATH_INFO</Font>..." + Request.ServerVariables("PATH_INFO") + "</B>"
Response.Write "<BR/> *** Extra path information as given by the client. You can access scripts by using their virtual path and the PATH_INFO server variable. If this information comes from a URL, it is decoded by the server before it is passed to the CGI script."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> PATH_TRANSLATED</Font>..." + Request.ServerVariables("PATH_TRANSLATED") + "</B>"
Response.Write "<BR/> *** A translated version of PATH_INFO that takes the path and performs any necessary virtual-to-physical mapping."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> QUERY_STRING</Font>..." + Request.ServerVariables("QUERY_STRING") + "</B>"
Response.Write "<BR/> *** Query information stored in the string following the question mark (?) in the HTTP request."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> REMOTE_ADDR</Font>..." + Request.ServerVariables("REMOTE_ADDR") + "</B>"
Response.Write "<BR/> *** The IP address of the remote host making the request."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> REMOTE_HOST</Font>..." + Request.ServerVariables("REMOTE_HOST") + "</B>"
Response.Write "<BR/> *** The name of the host making the request. If the server does not have this information, it will set REMOTE_ADDR and leave this empty."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> REMOTE_USER</Font>..." + Request.ServerVariables("REMOTE_USER") + "</B>"
Response.Write "<BR/> *** Unmapped user-name string sent in by the user. This is the name that is really sent by the user, as opposed to the names that are modified by any authentication filter installed on the server."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> REQUEST_METHOD</Font>..." + Request.ServerVariables("REQUEST_METHOD") + "</B>"
Response.Write "<BR/> *** The method used to make the request. For HTTP, this is GET, HEAD, POST, and so on."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> SCRIPT_NAME</Font>..." + Request.ServerVariables("SCRIPT_NAME") + "</B>"
Response.Write "<BR/> *** A virtual path to the script being executed. This is used for self-referencing URLs."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> SERVER_NAME</Font>..." + Request.ServerVariables("SERVER_NAME") + "</B>"
Response.Write "<BR/> *** The server's host name, DNS alias, or IP address as it would appear in self-referencing URLs."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> SERVER_PORT</Font>..." + Request.ServerVariables("SERVER_PORT") + "</B>"
Response.Write "<BR/> *** The port number to which the request was sent."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> SERVER_PORT_SECURE</Font>..." + Request.ServerVariables("SERVER_PORT_SECURE") + "</B>"
Response.Write "<BR/> *** A string that contains either 0 or 1. If the request is being handled on the secure port, then this will be 1. Otherwise, it will be 0."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> SERVER_PROTOCOL</Font>..." + Request.ServerVariables("SERVER_PROTOCOL") + "</B>"
Response.Write "<BR/> *** The name and revision of the request information protocol. The format is <I>protocol</I>/<I>revision</I>."

Response.Write "<BR/><BR/><B><Font color=&quot;blue&quot;> SERVER_SOFTWARE</Font>..." + Request.ServerVariables("SERVER_SOFTWARE") + "</B>"
Response.Write "<BR/> *** The name and version of the server software that answers the request and runs the gateway. The format is <I>name</I>/<I>version</I>."

%>