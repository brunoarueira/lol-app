# LOL

A simple app using Roda to access the League of Legends API with some cache using Redis.

## Development

First, You'll need to git clone this repository:

	git clone https://github.com/brunoarueira/lol-app.git
	
Then:

	cd lol-app/

And run the following commands on the console:

	bundle install
	cp .env.sample .env
	docker-compose build
	docker-compose up

Open your browser at https://localhost:9990! Let's try :)

## Tests

The tests was made using rspec and can be run as following:

	rake spec

Or:

	rspec

## Author

Bruno Arueira