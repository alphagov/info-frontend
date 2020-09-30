FROM ruby:2.7.1
RUN apt-get update -qq && apt-get upgrade -y

RUN apt-get install -y build-essential nodejs && apt-get clean

ENV GOVUK_APP_NAME info-frontend
ENV PORT 3085
ENV RAILS_ENV development

ENV APP_HOME /app
RUN mkdir $APP_HOME

WORKDIR $APP_HOME
ADD Gemfile* $APP_HOME/
ADD .ruby-version $APP_HOME/
RUN bundle install

ADD . $APP_HOME

HEALTHCHECK CMD curl --silent --fail localhost:$PORT || exit 1

CMD bash -c "rm -f tmp/pids/server.pid && bundle exec rails s -p $PORT -b '0.0.0.0'"
