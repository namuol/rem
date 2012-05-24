rem = require '../rem'
fs = require 'fs'
read = require 'read'

keys = JSON.parse fs.readFileSync __dirname + '/keys.json'

# Twitter
# =======

# Create the API.
tw = rem.load 'twitter', '1',
	key: keys.twitter.key
	secret: keys.twitter.secret

# See oob.coffee for details on OAuth authentication.
rem.oauthConsole tw, (err, user) ->

	# Get your newest tweets.
	console.log 'Latest tweets from your timeline:'
	user('statuses/home_timeline').get (err, json) ->
		for twt in json
			console.log ' -', twt.text
			
		# Then post a status.
		read prompt: "Enter a status to tweet: ", (err, txt) ->
			user('statuses/update').post {status: txt}, (err, json) ->
				console.log err, json
