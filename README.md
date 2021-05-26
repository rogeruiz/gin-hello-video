# Gin Framework Hello Video

This is a sample application that catalogs and validates Videos. It stores
things in memory and doesn't have a database at the moment. Most of the work is
taken from the [YouTube playlist about Gin HTTP
Framework](https://www.youtube.com/playlist?list=PL3eAkoh7fypr8zrkiygiY1e9osoqjoV9w).

There are a few things I've added here myself. It's mostly documentation or some
additional quirks here and there such as tooling.

This project has been started as my web application skill set has been dormant
because of my SRE / DevOps work.

## Getting started

To run the development server, use the `run-dev` target.

```sh
>_ make run-dev
```

To read from or write to the application, leverage the other targets that are
mentioned in the `help` target.

```sh
>_ make help
```

### Dependencies

This project leverages a few different tools which must be installed manually.
Not having these tools installed will cause some commands that have the tools as
dependencies to fail with a helpful message on how to install these tools.

These dependencies are compatible across multiple systems and package managers.

#### jq

The CLI tool `jq` is used to create JSON data files from the data templates
files found in the `migrations/` directory. [You can install the tool by
clicking here](https://stedolan.github.io/jq/download/).

#### httpie

The CLI tool `httpie` is used as a user-friendly replacement for `cURL` to make
`GET` and `POST` requests to the API endpoints. [You can install the tool by
clicking here](https://httpie.io/docs#installation).

#### fd

The CLI tool `fd` is used as a replacement for `find` to list vendor files to
unzip. [You can install the tool clicking here](https://github.com/sharkdp/fd#installation).
