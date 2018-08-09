/* ---------------------------------------------------------------------- *\
  Function    : scorm-api
  Description : API object for SCORM 1.2
\* ---------------------------------------------------------------------- */

var API = new scorm_api()

function scorm_api() {
	this.ErrorCode = 0;
	this.Init = 0;	
	this.Done = 0;	

	this.LMSInitialize = scorm_LMSInitialize;
	this.LMSFinish = scorm_LMSFinish;
	this.LMSGetValue = scorm_LMSGetValue;
	this.LMSSetValue = scorm_LMSSetValue;
	this.LMSCommit = scorm_LMSCommit;
	this.LMSGetLastError = scorm_LMSGetLastError;
	this.LMSGetErrorString = scorm_LMSGetErrorString;
	this.LMSGetDiagnostic = scorm_LMSGetDiagnostic;
}

/* ---------------------------------------------------------------------- */
function scorm_LMSInitialize(param) {
	this.ErrorCode = 0;
	if( this.Done == 1 ) {
		return "true";
	}
	else if( this.Init == 1 ) {
		this.ErrorCode = 101;
		return "false";
	}
	else if( param != "" ) {
		this.ErrorCode = 201;
		return "false";
	}
	else {
		this.Init = 1;
		return "true";
	}
}

/* ---------------------------------------------------------------------- */
function scorm_LMSFinish(param) {
	this.ErrorCode = 0;
	if( this.Done == 1 ) {
		return "true";
	}
	else if( param != "" ) {
		this.ErrorCode = 201;
		return "false";
	}
	else if( this.Init != 1 ) {
		this.ErrorCode = 301;
		return "false";
	}
	else {
		this.Done = 1;
		return "true";
	}
}

/* ---------------------------------------------------------------------- */
function scorm_LMSCommit(param) {
	this.ErrorCode = 0;
	if( this.Done == 1 ) {
		return "true";
	}
	else if( param != "" ) {
		this.ErrorCode = 201;
		return "false";
	}
	else if( this.Init != 1 ) {
		this.ErrorCode = 301;
		return "false";
	}
	else {
		return "true";
	}
}

/* ---------------------------------------------------------------------- */
function scorm_LMSGetValue(name) {
	var obj, val;
	this.ErrorCode = 0;
	if( this.Init != 1 ) {
		this.ErrorCode = 301;
		return "false";
	}
	switch(name) {
		case "cmi.core._children":
			return "cmi.core.student_id,cmi.core.student_name,cmi.core.lesson_location,cmi.core.credit,cmi.core.lesson_status,cmi.core.entry,cmi.core.score._children,cmi.core.score_raw,cmi.core.total_time,cmi.core.exit,cmi.core.session_time";
			break;
		case "cmi.core.student_id":
			obj = document.getElementById('ScormStudentID');
			break;
		case "cmi.core.student_name":
			obj = document.getElementById('ScormStudentName');
			break;
		case "cmi.core.lesson_location":
			obj = document.getElementById('ScormLessonLocation');
			break;
		case "cmi.core.credit":
			return "credit";
			break;
		case "cmi.core.lesson_status":
			obj = document.getElementById('ScormLessonStatus');
			break;
		case "cmi.core.entry":
			return "";
			break;
		case "cmi.core.score._children":
			return "cmi.core.score_raw";
			break;
		case "cmi.core.score_raw":
			obj = document.getElementById('ScormScoreRaw');
			break;
		case "cmi.core.total_time":
			obj = document.getElementById('ScormTotalTime');
			break;
		case "cmi.core.exit":
			return "";
			break;
		case "cmi.core.session_time":
			return "";
			break;
		case "cmi.suspend_data":
			return "";
			break;
		case "cmi.launch_data":
			return "";
			break;
		default:
			this.ErrorCode = 401;
			return "";
	}		
	if ( obj != null )
		return obj.value;
	else 
		return "";
}

/* ---------------------------------------------------------------------- */
function scorm_LMSSetValue(name,val) {
	var obj;
	this.ErrorCode = 0;
	if( this.Init != 1 ) {
		this.ErrorCode = 301;
		return "false";
	}
	switch(name) {
		case "cmi.core.lesson_location":
			obj = document.getElementById('ScormLessonLocation');
			break;
		case "cmi.core.lesson_status":
			obj = document.getElementById('ScormLessonStatus');
			break;
		case "cmi.core.score_raw":
			obj = document.getElementById('ScormScoreRaw');
			break;
		case "cmi.core.total_time":
			obj = document.getElementById('ScormTotalTime');
			break;
		default:
			//this.ErrorCode = 401;
			//return "false";
			return "true";
	}
	if ( obj != null ) {
		obj.value = val;
		return "true";
	}	
	else {
		this.ErrorCode = 101;
		return "false";
	}	
}

/* ---------------------------------------------------------------------- */
function scorm_LMSGetLastError() {
	return this.ErrorCode.toString();
}

/* ---------------------------------------------------------------------- */
function scorm_LMSGetErrorString(error) {
	switch(error) {
		case "0":
			return "No Error";
			break;
		case "101":
			return "General Exception";
			break;
		case "201":
			return "Invalid Argument Error";
			break;
		case "202":
			return "Element cannot have children";
			break;
		case "203":
			return "Element not an array - cannot have count";
			break;
		case "301":
			return "Not initialized";
			break;
		case "401":
			return "Not implemented error";
			break;
		case "402":
			return "Invalid set value, element is a keyword";
			break;
		case "403":
			return "Element is read only";
			break;
		case "404":
			return "Element is write only";
			break;
		case "405":
			return "Incorrent Data Type";
			break;
		default:
			return "Unknown";
	}		
}

/* ---------------------------------------------------------------------- */
function scorm_LMSGetDiagnostic(error) {
	return scorm_LMSGetErrorString( error );
}
