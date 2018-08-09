var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));

function GATrack(ga, order) {
//	if an account number is specified
	if ( ga.length > 0 ) {
		var gat = _gat._getTracker(ga);
		gat._initData();

//		if an order is not specified, track the page only
		if( order.length == 0 ) {
			gat._trackPageview();
		}

//		if an order is specified, track the order only
		if( order.length > 0 ) {
			var rows = new Array();

//			process each row of order data
			rows = order.split(';');
			for (var x = 0; x < rows.length; x++) {
				var vals = new Array();
				vals = rows[x].split('|');
				if( x == 0) {
//					get the order transaction
					if( vals.length == 8 )
						gat._addTrans(vals[0], vals[1], vals[2], vals[3], vals[4], vals[5], vals[6], vals[7] );
					else 
						x = rows.length;
				}
				else {
//					get the order item
					if( vals.length == 6 )
					gat._addItem(vals[0], vals[1], vals[2], vals[3], vals[4], vals[5] );
				}
			gat._trackTrans();
			}
		}
   }
}
