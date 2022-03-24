# README

[![repo standards badge](https://img.shields.io/badge/dynamic/json?color=green&style=for-the-badge&logo=github&label=MoJ%20Compliant&query=%24.data%5B%3F%28%40.name%20%3D%3D%20%22/hmcts-common-platform-mock-api%22%29%5D.status&url=https%3A%2F%2Foperations-engineering-reports.cloud-platform.service.justice.gov.uk%2Fgithub_repositories)](https://operations-engineering-reports.cloud-platform.service.justice.gov.uk/github_repositories#/hmcts-common-platform-mock-api "Link to report")


## Set up

This is a standard 6 Rails API application using Postgres 12.1 as a database.

Clone the repo, then run:

```
$ bundle install
$ rails db:setup
```

You can then start the application server by running:

```
$ rails s
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
