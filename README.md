# wastexchange_mobile

## Getting Started

Install Flutter by following the steps at https://flutter.dev/docs/get-started/install

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Install [Docker](https://docs.docker.com/install/) and [Docker Compose](https://docs.docker.com/compose/install/).

## Starting local API server

This setup assumes that the [backend](https://github.com/chennaitricolor/wastexchange-be) repository is present in the same directory as this project. For example:
```
chennaitricolor
├── wastexchange-be
└── wastexchange_mobile
```

Run:

```
docker-compose up

# OR to rebuild the docker images before starting the services
docker-compose up --build
```

API is started in port `7000` and Postgres database is started in port `5432`.

## Create the .env file

Copy the .env.sample and rename as .env file. Contact the team to get the actual values of the keys.

## Running the application

``flutter run``

## Running Tests

``flutter test``

Always run the tests before pushing in. 

## Running Lint

``flutter analyze``

Keep running analyzer periodically and before pushing code. 

#####References:#####
1. [Linter for Dart](https://dart-lang.github.io/linter/lints/)
2. [Rules from Flutter repo] (https://github.com/flutter/flutter/blob/master/analysis_options.yaml) 

For viewing Lint rules, refer  **analysis_options.yaml** file in project root.

For disabling a lint rule inline use (not recommended)
``// ignore: prefer_single_quotes``
