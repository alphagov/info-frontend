ARG base_image=ruby:2.7.6-slim-buster

FROM $base_image AS builder
# This image is only intended to be able to run this app in a production RAILS_ENV
ENV RAILS_ENV=production
# TODO: have a separate build image which already contains the build-only deps.
RUN apt-get update -qy && \
    apt-get upgrade -y && \
    apt-get install -y build-essential nodejs && \
    apt-get clean

RUN mkdir -p /app && ln -fs /tmp /app/tmp && ln -fs /tmp /home/app

WORKDIR /app

COPY Gemfile Gemfile.lock .ruby-version /app/
RUN bundle config set deployment 'true' && \
    bundle config set without 'development test' && \
    bundle install --jobs 4 --retry=2
COPY . /app
# TODO: We probably don't want assets in the image; remove this once we have a proper deployment process which uploads to (e.g.) S3.
RUN GOVUK_APP_DOMAIN=www.gov.uk \
    GOVUK_WEBSITE_ROOT=https://www.gov.uk \
    bundle exec rails assets:precompile

FROM $base_image
ENV GOVUK_PROMETHEUS_EXPORTER=true RAILS_ENV=production GOVUK_APP_NAME=info-frontend
# bundler seems to need nodejs installed - or at least a JavaScript runtime
RUN apt-get update -qy && \
    apt-get upgrade -y && \
    apt-get install -y nodejs && \
    apt-get clean 

RUN mkdir -p /app && ln -fs /tmp /app/tmp && ln -fs /tmp /home/app

COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=builder /app /app/

WORKDIR /app

RUN groupadd -g 1001 app && \
    useradd app -u 1001 -g 1001 --home /app

USER app

CMD bundle exec puma
