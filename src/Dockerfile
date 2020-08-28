FROM ruby:2.6.3-slim
ENV LANG=C.UTF-8
RUN apt update && apt install -qq -y curl gnupg
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update && apt install -qq -y build-essential nodejs libpq-dev postgresql-client yarn --fix-missing --no-install-recommends
RUN gem install bundler

ENV app /app
RUN mkdir -p $app
ENV INSTALL_PATH $app
ENV RAILS_ENV production

COPY Gemfile* /tmp/
WORKDIR /tmp
RUN bundle install --without="development test" -j8

WORKDIR $app
COPY package.json yarn.lock $app/
RUN yarn install --production --frozen-lockfile

ADD . $app
RUN bundle outdated --strict
RUN mkdir -p tmp/pids
RUN bundle exec rake assets:precompile

CMD bundle exec rails server
