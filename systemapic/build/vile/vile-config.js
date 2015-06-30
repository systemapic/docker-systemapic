// CONFIG FILE FOR [vile] TILESERVER
module.exports = {

	// tileserver port
	port : 3003,

	// kue 
 	kueRedis : {
 		port : 6379,
 		host : 'rkue',
   		auth : 'crlAxeVBbmaxBY5GVTaxohjsgEUcrT5IdJyHi8J1fdGG8KqXdfw3RP0qyoGlLltoVjFjzZCcKHvBVQHpTUQ26W8ql6xurdm0hLIY'
   	},

   	// tokens
	tokenRedis : {
		port : 6379,
		host : 'rtoken',
		auth : '9p7bRrd7Zo9oFbxVJIhI09pBq6KiOBvU4C76SmzCkqKlEPLHVR02TN2I40lmT9WjxFiFuBOpC2BGwTnzKyYTkMAQ21toWguG7SZE'
	},

	// no access
	noAccessMessage : 'No access. Please contact Systemapic.com if you believe you are getting this message in error.',
	noAccessTile : 'public/noAccessTile.png',
	
	// waiting tile
	processingTile : 'public/noAccessTile.png',

	// stylesheets
	defaultStylesheets : {
		raster : 'public/cartoid.xml',
		utfgrid : 'public/utfgrid.xml'
	},

}