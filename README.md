# Introduction

This is a sample Elixir application built for the purpose of teaching Elixir to those who are interested in learning the language along with Phoenix Framework.

# How to use the code base

This code base was generated using the default phoenix generator `mix phx.new`. Additionally, authentication was added using [Guardian](https://github.com/ueberauth/guardian). Furthermore, basic CRUD operations are coded which allows one to create/update/read "tasks" (sample todo application).

It also integrates [Redix](https://github.com/whatyouhide/redix) and allows interaction with Redis server (note: Redis server needs to be installed and running for it to work, otherwise starting the application can throw error.)

## Authentication modules

1. [Guardian Module](lib/elixir_todo/user_manager/guardian.ex)

This module is responsible for letting Guardian know how to generate a claim (auth/session cookie) i.e. which key to use. It also tells it how to decode the claims back in order to retreive the user entity.

2. [Pipeline](lib/elixir_todo/user_manager/pipeline.ex)

Defines the generic auth pipeline which hooks Guardian workflow in the Phoenix request workflow so that Guardian can extract the session information.

3. [Protected Pipeline](lib/elixir_todo/user_manager/protected_pipeline.ex)

A specific pipeline for those requests which are protected behind a session i.e. user's need to login to access those pages.

See [Router](lib/elixir_todo_web/router.ex) to see the auth pipelines in action

4. [Error Handler](lib/elixir_todo/user_manager/error_handler.ex)

A module which acts as an Error handler for auth related errors raised by Guardian.

## Redix

Check the [redis_client](lib/elixir_todo/redis_client.ex) for implementation details.

Please update the redis dev and prod config in [dev.exs](config/dev.exs) and [prod.exs](config/prod.exs)

## Heroku Deployment

This repo is hosted on heroku. Please click [here](elixir-todo-example.herokuapp.com) to see the live demo.

Check out this [quick guide](https://github.com/dwyl/learn-heroku/blob/master/elixir-phoenix-app-deployment.md) on how to deploy an Elixir/Phoenix applicaiton on Heroku.

Please check [prod.exs](config/prod.exs) for various `HTTP`, `Database` and `Redis` configurations.
