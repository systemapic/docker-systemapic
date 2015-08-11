module.exports = {

	// tileserver port
	port : 3003,

	// kue 
 	kueredis : {
 		port : 6379,
 		host : 'kueredis',
   		auth : '9p7bRrd7Zo9oFbxVJIhI09pBq6KiOBvU4C76SmzCkqKlEPLHVR02TN2I40lmT9WjxFiFuBOpC2BGwTnzKyYTkMAQ21toWguG7SZE',
   		// db   : 4
   	},

   	// tokens
	redis : {
		port : 6379,
		host : 'redis',
		auth : '9p7bRrd7Zo9oFbxVJIhI09pBq6KiOBvU4C76SmzCkqKlEPLHVR02TN2I40lmT9WjxFiFuBOpC2BGwTnzKyYTkMAQ21toWguG7SZE',
		db   : 1
	},

	// mongo
	mongo : {
		url : 'mongodb://mongo/systemapic'
	},

	// no access
	noAccessMessage : 'No access. Please contact Systemapic.com if you believe you are getting this message in error.',
	noAccessTile    : 'public/noAccessTile.png',
	
	// waiting tile
	processingTile : 'public/noAccessTile.png',

	// stylesheets
	defaultStylesheets : {
		raster : 'public/cartoid.xml',
		utfgrid : 'public/utfgrid.xml'
	},

}