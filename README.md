stallone
========

Get Urban Justice.


Login Flow
==========

```sh
curl -X POST http://localhost:3939/verifications/new -d phone_number=4157358262

curl -X POST http://localhost:3939/verifications/confirm -d phone_number=4157358262 -d confirmation_token=<XXX>

curl -X POST http://localhost:3939//users/initialize_keys -d auth_token=<YYY> -d passphrase=<ZZZ>

curl -X POST http://localhost:3939//users/spots -d auth_token=<YYY> -d latitude=57.33155983 -d longitude=-122.03479435 -d speed=5.2 -d course=0.9 -d timestamp=1415576671.161609

```