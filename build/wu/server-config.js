module.exports = {
	"serverConfig": {
		"token": {
			"accessTokenLength": "256",
			"refreshTokenLength": "256",
			"expiresIn": "3600"
		},
		"port": 3001,
		"mongo": {
			"url": "mongodb://mongo/systemapic"
		},
		"kueRedis": {
			"port": 6379,
			"host": "redis",
			"auth": "9p7bRrd7Zo9oFbxVJIhI09pBq6KiOBvU4C76SmzCkqKlEPLHVR02TN2I40lmT9WjxFiFuBOpC2BGwTnzKyYTkMAQ21toWguG7SZE",
			"db": 3
		},
		"tokenRedis": {
			"port": 6379,
			"host": "redis",
			"auth": "9p7bRrd7Zo9oFbxVJIhI09pBq6KiOBvU4C76SmzCkqKlEPLHVR02TN2I40lmT9WjxFiFuBOpC2BGwTnzKyYTkMAQ21toWguG7SZE",
			"db": 1
		},
		"temptokenRedis": {
			"port": 6379,
			"host": "redis",
			"auth": "9p7bRrd7Zo9oFbxVJIhI09pBq6KiOBvU4C76SmzCkqKlEPLHVR02TN2I40lmT9WjxFiFuBOpC2BGwTnzKyYTkMAQ21toWguG7SZE",
			"db": 2
		},
		"slack": {
			"webhook": "https://hooks.slack.com/services/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",
			"token": "xoxb-3868763863-SGufYHEt7crFub8BoWpNNsHy",
			"channel": "#systemapic-bot",
			"errorChannel": "#dev-error-log",
			"botname": "systemapic-bot",
			"icon": "http://systemapic.com/wp-content/uploads/systemapic-color-logo-circle.png",
			"baseurl": "https://dev.systemapic.com/"
		},
		// "vile": {
		// 	"uri": "http://vile:3003/",
		// 	"link": "vile",
		// 	"port": "3003"
		// },
		// "vile_grind": {
		// 	"remote_ssh": "px_vile_grind",
		// 	"remote_url": "http://5.9.117.212:3004/",
		// 	"sender_ssh": "tx_data_store",
		// 	"sender_url": "https://dev.systemapic.com/"
		// },
		// "vileosm": {
		// 	"uri": ""
		// },
		// "grind": {
		// 	"host": "http://5.9.117.212:3004/",
		// 	"ssh": "tx"
		// },
		"portalServer": {
			"uri": "https://dev.systemapic.com/"
		},
		"defaultMapboxAccount": {
			"username": "systemapic",
			"accessToken": "pk.eyJ1Ijoic3lzdGVtYXBpYyIsImEiOiJQMWFRWUZnIn0.yrBvMg13AZC9lyOAAf9rGg"
		},
		"phantomJS": {
			"user": "info@systemapic.com",
			"auth": "08d1f2a817d1daf86b54db76530615b7"
		},
		"nodemailer": {
			"service": "gmail",
			"auth": {
				"user" : "knutole@systemapic.com",
				"pass" : "o1bbxb1q@systemapic"
			},
			"bcc": [
				"knutole@systemapic.com"
			],
			"from": "Systemapic.com <info@systemapic.com>"
		},
		"path": {
			"file": "/data/files/",
			"image": "/data/images/",
			"temp": "/data/tmp/",
			"cartocss": "/data/cartocss/",
			"tools": "../tools/",
			"legends": "/data/legends/",
			"geojson": "/data/geojson/"
		},
		"portal": {
			"roles": {
				"superAdmin": "role-bbe9ea50-d99a-4291-9a16-5196c4561f94",
				"portalAdmin": "role-48e3a8e2-79e9-44a2-9652-a6a97add557f"
			}
		}
	},
	"loginConfig": {
		"autoStart": true,
		"accessToken": "pk.eyJ1Ijoic3lzdGVtYXBpYyIsImEiOiJkV2JONUNVIn0.TJrzQrsehgz_NAfuF8Sr1Q",
		"layer": "systemapic.kcjonn12",
		"logo": "css/images/login-logo.png",
		"wrapper": false,
		"speed": 1000,
		"position": {
			"lat": 59.942,
			"lng": 10.716,
			"zoom": [
				4,
				14
			]
		},
		"circle": {
			"radius": 120,
			"color": "rgba(247, 175, 38, 0.3)",
			"border": {
				"px": 4,
				"solid": "solid",
				"color": "white"
			}
		},
		"ga": {
			"id": "UA-57572003-2"
		}
	},
	"clientConfig": {
		"id": "app",
		"portalName": "systemapic",
		"portalLogo": false,
		"portalTitle": "[tx] Systemapic Secure Portal",
		"panes": {
			"clients": true,
			"options": true,
			"documents": true,
			"dataLibrary": true,
			"users": true,
			"share": true,
			"mediaLibrary": false,
			"account": true
		},
		"logos": {
			"projectDefault": "/css/images/grinders/BG-grinder-small-grayDark-on-white.gif"
		},
		"settings": {
			"chat": true,
			"colorTheme": true,
			"screenshot": true,
			"socialSharing": true,
			"print": true
		},
		"defaults": {
			"project": {
				"position": {
					"lat": 54.213861000644926,
					"lng": 6.767578125,
					"zoom": 4
				}
			}
		},
		"providers": {
			"mapbox": [
				{
					"username": "systemapic",
					"accessToken": "pk.eyJ1Ijoic3lzdGVtYXBpYyIsImEiOiJkV2JONUNVIn0.TJrzQrsehgz_NAfuF8Sr1Q"
				}
			]
		},
		"servers": {
			"portal": "https://dev.systemapic.com/",
			"tiles": {
				"uri": "https://{s}.systemapic.com/r/",
				"subdomains": "efgh"
			},
			"proxy" : {
				"uri" : "",
				"subdomains" : ["proxy-tx-a", "proxy-tx-b", "proxy-tx-c", "proxy-tx-d"]
			},
			"utfgrid": {
				"uri": "https://{s}.systemapic.com/u/",
				"subdomains": "efgh"
			},
			"osm": {
				"base": "https://m.systemapic.com/",
				"uri": "https://{s}.systemapic.com/r/",
				"subdomains": "mnop"
			}
		},
		"ga": {
			"id": "UA-57572003-4"
		}
	}
}