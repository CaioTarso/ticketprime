# syntax = docker/dockerfile:1

ARG RUBY_VERSION=3.3.5
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

WORKDIR /rails

ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development test"

FROM base as build

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      build-essential git libvips pkg-config libpq-dev

COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle "${BUNDLE_PATH}"/ruby/*/cache

COPY . .


FROM base

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      curl libvips libpq5 && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp

USER rails:rails

ENTRYPOINT []

EXPOSE 3000
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
