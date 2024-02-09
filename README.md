# README

[![repo standards badge](https://img.shields.io/badge/dynamic/json?color=green&style=for-the-badge&logo=github&label=MoJ%20Compliant&query=%24.data%5B%3F%28%40.name%20%3D%3D%20%22hmcts-common-platform-mock-api%22%29%5D.status&url=https%3A%2F%2Foperations-engineering-reports.cloud-platform.service.justice.gov.uk%2Fgithub_repositories)](https://operations-engineering-reports.cloud-platform.service.justice.gov.uk/github_repositories#hmcts-common-platform-mock-api "Link to report")


## Set up

This is a standard 6 Rails API application using Postgres 12.1 as a database.

Clone the repo, then:

### Database setup
Running the tests and the application server locally with require a local Postgres database running. This can be done using docker
with the following command. This runs the same database image that is used in the CircleCI tests.
```shell
docker run -d --name hmcts-mock-db -p 5432:5432 cimg/postgres:11.12
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

```
$ bundle install
$ RAILS_ENV=development rails db:setup
```

You can then start the application server by running:

```
$ RAILS_ENV=development rails s
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


### Decrypting secrets for deployment

**NOTE:** **git-crypt** is required to store secrets needed for all environments.
To be able to modify those secrets, **git-crypt** needs to be set up according to the following
[guide](https://user-guide.cloud-platform.service.justice.gov.uk/documentation/other-topics/git-crypt-setup.html#git-crypt).

This requires your gpg key to have been added to git-crypt.  Liaise with another developer to action the steps in [git-crypt.md](docs/git-crypt.md)

Once the pull request has been merged, pull master and run

```
git-crypt unlock
```
