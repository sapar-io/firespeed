<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

This package allow you to use short way of CRUD commands with Firebase Firestore Database.

## Features

You can:
* Create document
* Update document
* Fetch one document
* Fetch many documents
* Listen document
* Listen documents

## Getting started

Use static functions in RestAPI class.

## Usage

Use static functions in RestAPI class.

```dart
RestAPI.listenModel(FirestoreRef.user(uid), FireUser.fromFirestore).listen((event) {
    // work with data - event
})
```

## Additional information

If you have questions or ideas, feel free to contact me at https://t.me/saparfriday
