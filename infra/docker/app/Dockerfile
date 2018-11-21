FROM my/ruby:2.5.3

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY . /usr/src/app/

RUN apk add --update --virtual .rails-builddeps \
  build-base \
  && bundle install --no-cache --clean --without development test \
  && apk del .rails-builddeps

EXPOSE 8080

RUN bundle install --without development test
