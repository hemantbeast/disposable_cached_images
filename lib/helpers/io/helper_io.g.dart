// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'helper_io.dart';

// **************************************************************************
// IsolateGenerator
// **************************************************************************

class _ThreadOperationIsolate extends ThreadOperationBase {
  final String _cachePath;
  final int _maximumDownload;

  _ThreadOperationIsolate(
    String cachePath,
    int maximumDownload,
  )   : _cachePath = cachePath,
        _maximumDownload = maximumDownload;
  late final SendPort _sender;
  late final Isolate isolate;
  Future<void> init() async {
    final runningSendPort =
        IsolateNameServer.lookupPortByName("_imageshelperisolate");
    if (runningSendPort != null) {
      _sender = runningSendPort;
      isolate = Isolate(IsolateNameServer.lookupPortByName(
          "_imageshelperisolate_controlport")!);
      return;
    }
    final ReceivePort receivePort = ReceivePort();
    final ReceivePort exitRecivePort = ReceivePort();
    isolate = await Isolate.spawn<List<dynamic>>(
      _imageshelperisolate,
      [
        receivePort.sendPort,
        _cachePath,
        _maximumDownload,
      ],
      errorsAreFatal: false,
    );
    _sender = await receivePort.first;
    isolate.addOnExitListener(exitRecivePort.sendPort);
    exitRecivePort.listen((message) {
      IsolateNameServer.removePortNameMapping("_imageshelperisolate");
      IsolateNameServer.removePortNameMapping(
          "_imageshelperisolate_controlport");
      exitRecivePort.close();
    });
    IsolateNameServer.registerPortWithName(_sender, "_imageshelperisolate");
    IsolateNameServer.registerPortWithName(
        isolate.controlPort, "_imageshelperisolate_controlport");
    receivePort.close();
  }

  @override
  Stream<dynamic> getNetworkBytes(
    String url,
    Map<String, String>? headers,
  ) {
    final receivePort = ReceivePort();
    _sender.send([
      'getNetworkBytes',
      receivePort.sendPort,
      url,
      headers,
    ]);
    final StreamController<dynamic> controller = StreamController();
    receivePort.listen(
      (event) {
        if (event is IsolateGeneratorStreamCompleted) {
          controller.close();
          receivePort.close();
          return;
        }
        if (event is IsolateGeneratorError) {
          controller.addError(event.error, event.stackTrace);
          controller.close();
          receivePort.close();
          return;
        }
        controller.add(event);
      },
    );
    return controller.stream;
  }

  @override
  Future<void> cancleDownload(
    String url,
  ) async {
    final receivePort = ReceivePort();
    _sender.send([
      'cancleDownload',
      receivePort.sendPort,
      url,
    ]);
    final res = await receivePort.first;
    receivePort.close();
    if (res is IsolateGeneratorError) {
      Error.throwWithStackTrace(res.error, res.stackTrace);
    }
    return res;
  }

  @override
  Future<Uint8List?> getBytes(
    String key,
  ) async {
    final receivePort = ReceivePort();
    _sender.send([
      'getBytes',
      receivePort.sendPort,
      key,
    ]);
    final res = await receivePort.first;
    receivePort.close();
    if (res is IsolateGeneratorError) {
      Error.throwWithStackTrace(res.error, res.stackTrace);
    }
    return res;
  }

  Future<Uint8List> getLocalFile(
    String path,
  ) async {
    final receivePort = ReceivePort();
    _sender.send([
      'getLocalFile',
      receivePort.sendPort,
      path,
    ]);
    final res = await receivePort.first;
    receivePort.close();
    if (res is IsolateGeneratorError) {
      Error.throwWithStackTrace(res.error, res.stackTrace);
    }
    return res;
  }

  @override
  Future<void> clearData() async {
    final receivePort = ReceivePort();
    _sender.send([
      'clearData',
      receivePort.sendPort,
    ]);
    final res = await receivePort.first;
    receivePort.close();
    if (res is IsolateGeneratorError) {
      Error.throwWithStackTrace(res.error, res.stackTrace);
    }
    return res;
  }

  @override
  Future<void> addToCache({
    required String key,
    required int width,
    required int height,
    required Uint8List bytes,
  }) async {
    final receivePort = ReceivePort();
    _sender.send([
      'addToCache',
      receivePort.sendPort,
      key,
      width,
      height,
      bytes,
    ]);
    final res = await receivePort.first;
    receivePort.close();
    if (res is IsolateGeneratorError) {
      Error.throwWithStackTrace(res.error, res.stackTrace);
    }
    return res;
  }
}

Future<void> _imageshelperisolate(final List<dynamic> message) async {
  final ReceivePort port = ReceivePort();
  final _ThreadOperationIO instance = _ThreadOperationIO(
    message[1],
    message[2],
  );

  void mainPortListener(final message) async {
    final String key = message[0];
    final SendPort sendPort = message[1];
    try {
      switch (key) {
        case 'getNetworkBytes':
          instance
              .getNetworkBytes(
            message[2],
            message[3],
          )
              .listen((event) {
            sendPort.send(event);
          }, onError: (e, s) {
            sendPort.send(IsolateGeneratorError(e, s));
          }, onDone: () {
            sendPort.send(const IsolateGeneratorStreamCompleted());
          });
          break;
        case 'cancleDownload':
          instance.cancleDownload(
            message[2],
          );
          sendPort.send(null);
          break;
        case 'getBytes':
          final res = await instance.getBytes(
            message[2],
          );
          sendPort.send(res);
          break;
        case 'getLocalFile':
          final res = instance.getLocalFile(
            message[2],
          );
          sendPort.send(res);
          break;
        case 'clearData':
          await instance.clearData();
          sendPort.send(null);
          break;
        case 'addToCache':
          await instance.addToCache(
            key: message[2],
            width: message[3],
            height: message[4],
            bytes: message[5],
          );
          sendPort.send(null);
          break;
      }
    } catch (e, s) {
      sendPort.send(IsolateGeneratorError(e, s));
    }
  }

  port.listen(mainPortListener);
  message[0].send(port.sendPort);
}
