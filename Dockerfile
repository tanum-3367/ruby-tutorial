FROM ruby:3.2.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs vim postgresql-client

WORKDIR /myapp

COPY Gemfile Gemfile.lock /myapp/

RUN bundle install

COPY . /myapp

EXPOSE 3001

CMD ["rails", "server", "-b", "0.0.0.0"]
