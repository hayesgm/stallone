stallone
========

Get Urban Justice.


Login Flow
==========

```sh
curl -X POST http://localhost:3939/verifications/new -d phone_number=4157358262

curl -X POST http://localhost:3939/verifications/confirm -d phone_number=4157358262 -d confirmation_token=<XXX>

curl -X POST http://localhost:3939/users/new -d auth_token=<YYY>

```