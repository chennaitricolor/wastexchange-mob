[![Codemagic build status](https://api.codemagic.io/apps/5d541ac05ce262001e7fe21f/5d541ac05ce262001e7fe21e/status_badge.svg)](https://codemagic.io/apps/5d541ac05ce262001e7fe21f/5d541ac05ce262001e7fe21e/latest_build)

# wastexchange_mobile

## Getting Started

Install Flutter by following the steps at https://flutter.dev/docs/get-started/install

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Install [Docker](https://docs.docker.com/install/) and [Docker Compose](https://docs.docker.com/compose/install/).

## Starting Local API Server

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

API will run on port `7000` and Postgres database will run on port `5432`.

To seed test data in to the database refer the [backend readme](https://github.com/chennaitricolor/wastexchange-be#dev-machine-setup).

## Create the .env file

Copy the .env.sample and rename as .env file. Contact the team to get the actual values of the keys.

## Running the application

``flutter run``

## Running Tests

``flutter test``

Always run the tests before pushing in. 

## Running Lint

``flutter analyze``

## Releasing the app?

- Create a file ``key.properties` inside project android root folder.

- Paste the following contents and save it

```
storePassword="ENTER_THE_STORE_PASSWORD"
keyPassword="ENTER_THE_KEY_PASSWORD"
keyAlias=key
storeFile="PATH_WHERE_SECURE_KEY_EXISTS"
(Eg: /Users/USER_NAME/Desktop/Flutter/opensource/wastexchange_mobile/android/wasteexchange.jks)
```

Keep running analyzer periodically and before pushing code. 

### References:
1. [Linter for Dart](https://dart-lang.github.io/linter/lints/)
2. [Rules from Flutter repo](https://github.com/flutter/flutter/blob/master/analysis_options.yaml) 

For viewing Lint rules, refer  **analysis_options.yaml** file in project root.

For disabling a lint rule inline use (not recommended)
``// ignore: prefer_single_quotes``

## Test Coverage

To run tests and view coverage, run the following command from project root directory (wastexchange_mobile/)

``./test/coverage_lcov.sh``


## Contributing

Follow this convention while committing

``git commit -m "[Sayeed] Simplify drawer logic" --author "Sayeed <sayeedhussain19@gmail.com>"``
