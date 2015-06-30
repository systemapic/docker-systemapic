// CONFIG FILE FOR VILE GRIND @ PX
module.exports = {

	// vile-grind port
   	port : 3004,

	// vile kue 
	kueRedis : {
		host : 'rkue',
		port : 6379,
		auth : 'crlAxeVBbmaxBY5GVTaxohjsgEUcrT5IdJyHi8J1fdGG8KqXdfw3RP0qyoGlLltoVjFjzZCcKHvBVQHpTUQ26W8ql6xurdm0hLIY'
	},

	hosts : {
		tx : 		'https://dev.systemapic.com/',
		tx_data_store : 'https://dev.systemapic.com/',
		sx : 		'https://projects.ruppellsgriffon.com/',
	},

	acceptedConnections : [
		'78.46.107.15', // tx (dev.systemapic.com)
		'85.10.202.87', // sx (projects.ruppellsgriffon.com)
	],

	paths : {
		vector          : '/data/grind/vector_tiles/',
		raster          : '/data/raster_tiles/',
		geojson         : '/data/grind/geojson/',
		remoteVectorFolder    : '/data/vector_tiles/',
		remoteRasterFolder    : '/data/raster_tiles/',
		tempFolder      : '/data/grind/vector_tiles/',
		// remoteDoneHook  : 'grind/done',
	},

	keepPoint : 1500000,
  	maxFileSize : 350000000,
   
}
