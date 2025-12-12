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
      build-essential git libvips pkg-config libpq-dev nodejs npm yarn

COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle "${BUNDLE_PATH}"/ruby/*/cache

COPY . .


RUN bundle exec rails assets:precompile


FROM base

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      curl libvips libpq5 && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Copia as gems e o código (incluindo os assets compilados)
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# Integração do Entrypoint (para rodar db:migrate)
COPY bin/docker-entrypoint /rails/bin/docker-entrypoint
RUN chmod +x /rails/bin/docker-entrypoint

RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp

USER rails:rails

# Define o script Entrypoint que executa db:migrate antes de iniciar o servidor
ENTRYPOINT ["/rails/bin/docker-entrypoint"] 

EXPOSE 3000

CMD ["./bin/rails", "server", "-b", "0.0.0.0"]