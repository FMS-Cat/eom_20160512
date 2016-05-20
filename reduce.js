var exec = require( 'child_process' ).exec;

var zerofill = function( _num, _wid ) {
	var str = String( _num );
	if ( _wid <= str.length ) {
		return str;
	} else {
		return new Array( _wid - str.length + 1 ).join( '0' ) + str;
	}
};

for ( var iFrame = 0; iFrame < 200; iFrame ++ ) {
	var infile = 'blur' + zerofill( iFrame, 5 ) + '.png';
	var outfile = 'out' + zerofill( iFrame, 5 ) + '.png';
	exec( 'convert ' + infile + ' -crop 640x640+80+80 -resize 320x320 ' + outfile );
}
