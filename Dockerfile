FROM node:24.4-alpine AS node
FROM ruby:3.4.4-alpine3.20
LABEL Organisation="Ministry of Justice"
LABEL Team="LAA Access Court Data"
LABEL Contact="<access-court-data-team@digital.justice.gov.uk>"

# fail early and print all commands
RUN set -ex

# Get node 20.19 from the node image into the ruby image
COPY --from=node /usr/lib /usr/lib
COPY --from=node /usr/local/share /usr/local/share
COPY --from=node /usr/local/lib /usr/local/lib
COPY --from=node /usr/local/include /usr/local/include
COPY --from=node /usr/local/bin /usr/local/bin

# build dependencies:
# - virtual: create virtual package for later deletion
# - build-base for alpine fundamentals
# - yarn for js dependency management
# - postgresql-dev for pg/activerecord gems
# - tzdata for timezone data
# - git for installing gems referred to use a git:// uri
#
RUN apk --no-cache add --virtual build-dependencies \
                    build-base \
                    yarn \
                    postgresql-dev \
                    tzdata \
                    git \
                    yaml-dev \
                    libffi-dev

# add non-root user and group with alpine first available uid, 1000
RUN addgroup -g 1000 -S appgroup \
&& adduser -u 1000 -S appuser -G appgroup

# create app directory in conventional, existing dir /usr/src
RUN mkdir -p /usr/src/app && mkdir -p /usr/src/app/tmp/pids
WORKDIR /usr/src/app

######################
# DEPENDENCIES START #
######################
# Env vars needed for dependency install and asset precompilation

COPY Gemfile* ./

RUN gem install bundler -v 2.4.22
RUN bundle config set --local deployment 'true' without 'development:test' && bundle install --jobs 4

####################
# DEPENDENCIES END #
####################

ENV RAILS_ENV=production
ENV NODE_ENV=production
ENV RAILS_SERVE_STATIC_FILES=true
ENV RAILS_LOG_TO_STDOUT=true
ENV NODE_OPTIONS=--openssl-legacy-provider
EXPOSE 3000

COPY . .

RUN yarn install
RUN SECRET_KEY_BASE=fake-key-base bundle exec rails assets:precompile

# non-root/appuser should own only what they need to
RUN chown -R appuser:appgroup app config log tmp db

USER 1000
CMD ["./docker/run"]
