# HMCTS Common Platform Mock API

## Set up

This is a standard 6 Rails API application which requires:

- Postgres 14 database - [Brew formula for PostgreSQL@14](https://formulae.brew.sh/formula/postgresql@14#default)
- [Yarn](https://yarnpkg.com/) - [Brew formula for Yarn](https://formulae.brew.sh/formula/yarn#default)
- libpq - [Brew Formula for libpq](https://formulae.brew.sh/formula/libpq#default)


Clone this repo, then run:

```shell
bundle install
```
```shell
rails db:setup
```
You can then start the application server by running:

```shell
rails server
```

By default, the application will listen on port 3000 as defined in `puma.rb`.
You can verify your setup by sending a request to an endpoint and checking for a HTTP response code of 2xx/Success. The credentials for the HTTP Basic Authentication are defined in `.env`.
```shell
curl -u admin:password --head http://localhost:3000/admin/prosecution_cases
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
