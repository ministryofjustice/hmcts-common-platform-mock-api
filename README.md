# HMCTS Common Platform Mock API

## Setup

This is a standard 6 Rails API application which requires:

Clone the repo, then:

### Database setup
Running the tests and the application server locally with require a local Postgres database running. This can be done using docker
with the following command. This runs the same database image that is used in the CircleCI tests.
```shell
docker run -d --name hmcts-mock-db -p 5432:5432 cimg/postgres:17.4
```

### Populate .env file
There is a template .env file included in the repository which will need to be updated with the required values.

As this file is tracked in the repository it is best to avoid populating it with secrets incase it is committed pushed to GitHub.
Therefore the recommendation is to create new files e.g. `.env.development.local` and `.env.test.local` which are in the gitignore file.
The settings in these env files can be used by prefacing all rails and rspec commands with the `RAILS_ENV` environment variable e.g.

```shell
RAILS_ENV=test rails s
```
The rails environment should be set to `test` for running the test suite or `development` for running/debugging the application server locally

The DEV client id and secret refer to the Court Data Adaptor (DEV) OAuth2.0 credentials. These can be found in the encrypted helm values file.

```shell
LAA_DEV_CLIENT_ID=
LAA_DEV_CLIENT_SECRET=
```

The database url should be setup to point to your local Postgres database e.g.

```shell
DATABASE_URL=postgres://postgres:@localhost:5432/hmcts_common_platform_api_test
```

### Setup the app


Clone this repo, then run:

```shell
bundle install
```
```shell
RAILS_ENV=development rails db:setup
```
You can then start the application server by running:

```shell
RAILS_ENV=development rails s
```

By default, the application will listen on port 3000 as defined in `puma.rb`.
You can verify your setup by sending a request to an endpoint and checking for a HTTP response code of 2xx/Success. The credentials for the HTTP Basic Authentication are defined in `.env`.

```shell
curl -u admin:password --head http://localhost:3000/admin/prosecution_cases
```

### Running the App using docker compose

The application and associated database can be started up using the following docker compose command. By default the base `.env` file will be used however
you can set the `.env.test.local` or `.env.development.local` files using the `--env-file` argument.

```shell
docker-compose --env-file .env.development.local up --build
```

### Running the tests

The RSpec test can be run using the following command:
```shell
RAILS_ENV=test bundle exec rspec
```

### Generate demonstration data
Tasks have been created to facilitate generation of a small specific, rememberable set of demonstration data. This data reflects current understanding of a bare minimum needed to effectively demonstrate the workings of this adaptor and its user interface [View court data](https://github.com/ministryofjustice/laa-court-data-ui).

To generate demo data:
```
rake mock:demodata:load
```

To destroy demo data:
```
rake mock:demodata:unload
```

## Publish HearingResulted to LAA

Run the rake task by passing in the hearing id as an argument

```
bundle exec rails 'publish:hearing[HEARING_ID]'
```

This will trigger a publish to the LAA Adaptor service defined by the environment variable `LAA_DEV_API_URL`

## Pre-commit hooks

We have gitleaks set up on this repo. To make it harder to accidentally leak a secret, have it run as a pre-commit hook:
```
pip install pre-commit
pre-commit install
```

### Secrets
**NOTE:** All secrets are stored in AWS Secret Manager, in a secret with the description "hmcts-mock-api-dev aws-secrets".
It is accessible to anyone who is part of our Github team. For more details,
[see this documentation](https://user-guide.cloud-platform.service.justice.gov.uk/documentation/deploying-an-app/add-secrets-to-deployment.html#configuring-secrets-using-aws-secrets-manager).

