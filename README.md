RUBY FUNCTIONS
==============

[![View performance data on Skylight](https://badges.skylight.io/status/wwchw2UGlt0N.svg)](https://oss.skylight.io/app/applications/wwchw2UGlt0N)
[![View performance data on Skylight](https://badges.skylight.io/problem/wwchw2UGlt0N.svg)](https://oss.skylight.io/app/applications/wwchw2UGlt0N)
[![View performance data on Skylight](https://badges.skylight.io/typical/wwchw2UGlt0N.svg)](https://oss.skylight.io/app/applications/wwchw2UGlt0N)
[![View performance data on Skylight](https://badges.skylight.io/rpm/wwchw2UGlt0N.svg)](https://oss.skylight.io/app/applications/wwchw2UGlt0N)
[![codecov](https://codecov.io/gh/emad-elsaid/rubyfunctions/branch/master/graph/badge.svg)](https://codecov.io/gh/emad-elsaid/rubyfunctions)
[![DeepSource](https://static.deepsource.io/deepsource-badge-light-mini.svg)](https://deepsource.io/gh/emad-elsaid/rubyfunctions/?ref=repository-badge)

Here is the challenge:

1. Write a useful Ruby function
2. Depends only on Ruby core and standard lib

This is a web application to have a community around this idea,
We participate and share these functions to learn from each other
and use it if we need to.

# Why?

1. It would be nice if you're looking for a function that validate URL/Email for example and you get to a website just to get this function, no external libraries needed, just the function use it.
2. Show your creativity using just ruby to deliver something useful, how far can you get with just that?
3. We can learn a lot from each other just by sharing useful functions we write.
4. You get fast feedback on a small snippet of code.

# Prerequisite

1. Ruby 2.6.3
1. Yarn
1. Postgres server

# Documentation you'll needed

1. Ruby docs https://devdocs.io/ruby~2.5/
1. Rails docs https://devdocs.io/rails~6.0/
1. Bulma documentation https://bulma.io/documentation/
1. Font awesome icons list https://fontawesome.com/icons
1. Undraw illustrations (brand color: #3273dc) https://undraw.co/

# Setting up the project

1. cd to `src`
1. Create a github application for github login feature from [here](https://github.com/settings/developers) and set the callback URL to `http://localhost:3000/github/new`
1. Copy `.env.sample` to `.env` and fill in the non-production variables and remove the rest.
1. Make sure the variables in `.env` file is loaded to your shell, you can use [autoenv](https://github.com/inishchith/autoenv) for that
1. Run `rails db:setup`
1. Make sure `rspec` passes
1. Run the server with `rails s`
1. Have fun developing your feature

# Using Docker

1. Create a github application for github login feature from [here](https://github.com/settings/developers) and set the callback URL to `http://localhost:3000/github/new`
1. Copy `src/.env.sample` to `src/.env` and fill in the non-production variables and remove the rest.
1. Get a shell inside the web service container using docker-compose `docker-compose -f docker-compose-dev.yml run -p 3000:3000 web bash`
1. Run `rails db:setup`
1. Make sure `rspec` passes
1. Run the server with `rails s -b 0.0.0.0`
1. Have run developing your feature

# Things the project is trying to avoid

1. Having unncessary dependencies
1. Javascript
1. Saving user emails or access tokens
1. Uploading files

# How to contibute

1. Fork this repo
1. Clone the fork to your machine
1. Open an issue with the your idea and how you're gonna solve it
1. Agree on a final solution to your idea and start implementing it
1. Create a new branch and commit your changes
1. Open a pull request linking to the issue


# Quality guidelines

1. Write good and readable tests
1. Make sure existing specs passes with `rspec` command
1. Make sure rubocop passes with `rubocop` command
1. Try to be as minimal as possible
