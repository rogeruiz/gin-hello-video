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
