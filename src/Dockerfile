FROM ruby:2.6.3-slim AS builder
ENV LANG=C.UTF-8
RUN apt update &&\
    apt install -qq -y\
      build-essential\
      nodejs libpq-dev\
      npm\
    --fix-missing --no-install-recommends

RUN gem install bundler
RUN npm install --global yarn

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
RUN bundle exec rake assets:precompile
RUN rm -rf node_modules tmp/* log/*


FROM ruby:2.6.3-slim

RUN apt update &&\
    apt install -qq -y postgresql-client\
    --fix-missing --no-install-recommends

ENV app /app
ENV INSTALL_PATH $app
ENV RAILS_ENV production

WORKDIR $app

RUN mkdir -p tmp/pids

COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=builder /app/ /app/

CMD bundle exec rails server
