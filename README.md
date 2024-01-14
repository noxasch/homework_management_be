# README


## Prerequisites
- Ruby 3+
- Postgresql 15

## Development Setup in local

1. `git clone` this repo
2. Make sure postgres is running

```sh
# prepare database
bundle exec rails db:create db:migrate db:seeds

# run dev server
bundle exec rails server

# run test
bundle exec rspec
```

## Development Setup with docker

```sh
docker-compose up

# running rails console for debugging
docker exec -it homework-be_dev bash
```


## Deployment (docker)




<!-- This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ... -->
