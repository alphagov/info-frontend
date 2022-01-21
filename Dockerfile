
# TODO: make this default to govuk-ruby once it's being pushed somewhere public
# (unless we decide to use Bitnami instead)
ARG base_image=ruby:2.7.2

FROM $base_image AS builder
# This image is only intended to be able to run this app in a production RAILS_ENV
ENV RAILS_ENV=production
# TODO: have a separate build image which already contains the build-only deps.
RUN apt-get update -qy && \
    apt-get upgrade -y && \
    apt-get install -y build-essential nodejs && \
    apt-get clean

RUN mkdir /app
WORKDIR /app
COPY Gemfile Gemfile.lock .ruby-version /app/
RUN bundle config set deployment 'true' && \
    bundle config set without 'development test' && \
    bundle install --jobs 4 --retry=2
COPY . /app

RUN GOVUK_APP_DOMAIN=www.gov.uk \
    GOVUK_WEBSITE_ROOT=http://www.gov.uk \
    bundle exec rails assets:precompile
# QQ:  rake shared_mustache:compile is this app specific?

FROM $base_image
ENV RAILS_ENV=production GOVUK_APP_NAME=info-frontend

# bundler seems to need nodejs installed - or at least a JavaScript runtime
RUN apt-get update -qy && \
    apt-get upgrade -y && \
    apt-get install -y nodejs && \
    apt-get clean

WORKDIR /app
COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=builder /app ./
CMD bundle exec puma
