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

A flutter package for displaying and releasing images from memory.

## Features

Download and display images from the Internet and keep them in the cache directory.

Display images assets.

Cancel the download if the image widget has been disposed to reduce bandwidth usage.

Remove the image from memory if the image widget has been disposed to reduce device memory usage.

## Usage

### Setting up

Add `scaffoldMessengerKey` to the `MaterialApp`

> you can read more about `scaffoldMessengerKey` on [docs.flutter](https://docs.flutter.dev/release/breaking-changes/scaffold-messenger)

```dart
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Home(),
      scaffoldMessengerKey: scaffoldMessengerKey,
    );
  }
}

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
```

In the main method use `runAppWithDisposableCachedImage` instead of `runApp` and pass it the `scaffoldMessengerKey` to initialize the package

> the `scaffoldMessengerKey.currentContext` is used to precache the image ahead of being request in the ui, [learn more about precacheImage](https://api.flutter.dev/flutter/widgets/precacheImage.html).

```dart
void main() {
  runAppWithDisposableCachedImage(
    const MyApp(),
    scaffoldMessengerKey: scaffoldMessengerKey,
  );
}
```

> If you are already using [flutter_riverpod](https://pub.dev/packages/flutter_riverpod), you can pass `ProviderScope` arguments `observers` and `overrides` to the `runAppWithDisposableCachedImage` function.

Now your app is ready to use the package.

### Displaying images

Use `DisposableCachedImageWidget` to display images form internet.

```dart
DisposableCachedImageWidget(
image: 'https://picsum.photos/id/23/200/300',
);
```

You can also display images form assets by passing the image path.

```dart
DisposableCachedImageWidget(
image: 'images/a_dot_burr.jpeg',
);
```

> The image url must start with http and if it doesn't start with http the package will assume the image is an asset.

You can display your custom widgets while the image is loading, has an error and when it is ready as shown below

```dart
DisposableCachedImageWidget(
 image: imageUrl,
 onLoading: (context) => const Center(
   child: Icon(Icons.downloading),
 ),
 onError: (context, reDownload) => Center(
   child: IconButton(
     onPressed: reDownload,
     icon: const Icon(Icons.download),
   ),
 ),
 onImage: (context, memoryImage) => Container(
   decoration: BoxDecoration(
     borderRadius: BorderRadius.circular(20),
     image: DecorationImage(
       image: memoryImage,
       fit: BoxFit.cover,
     ),
   ),
 ),
);
```

You can Provide a maximum height and width values for image by passing the values to `maxCacheHeight` and `maxCacheWidth` arguments, If the actual height or width of the image is less than the provided value, the provided value will be ignored.

The image will be resized before it's displayed in the UI and saved to the device storage.

```dart
DisposableCachedImageWidget(
 image: imageUrl,
 maxCacheHeight: 300,
 maxCacheWidth: 300,
);
```

## How it works

Stores and retrieves files using [dart:io](https://api.flutter.dev/flutter/dart-io/dart-io-library.html).

Disposing and changing image state using [flutter_riverpod](https://pub.dev/packages/flutter_riverpod) with [state_notifier](https://pub.dev/packages/state_notifier).

Using [http](https://pub.dev/packages/http) to download images from the internet.

### Example app

The [example](https://github.com/7mada123/disposable_cached_images/tree/main/example) directory has a sample application that uses this plugin.

### Roadmap

Improve package documentation

Web support

Further improvements
