# README

### random-phrases.txt
Place a file `random-phrases.txt` in the lib folder

### Running the app
    bundle exec rackup

URLs

Returns a random phrase:

    GET localhost:9292/phrase?token=12345

Add a phrase to the phrases file:

    POST localhost:9292/phrase/add?token=12345

with the JSON body:

    "phrase": "The is an example phrase"