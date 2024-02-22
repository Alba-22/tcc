import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'network_checker.dart';

class MixedNetworkChecker implements NetworkChecker {
  final InternetConnectionChecker connectionChecker;
  final Connectivity connectivityTypeChecker;
  late StreamSubscription<InternetConnectionStatus> hasConnectionListener;
  late StreamSubscription<ConnectivityResult> connectionTypeListener;

  MixedNetworkChecker(this.connectionChecker, this.connectivityTypeChecker) {
    hasConnectionListener = connectionChecker.onStatusChange.listen((event) {
      switch (event) {
        case InternetConnectionStatus.connected:
          _connectionCheckerController.sink.add(NetworkStatus.connected);
          break;
        case InternetConnectionStatus.disconnected:
          _connectionCheckerController.sink.add(NetworkStatus.disconnected);
          break;
      }
    });
    connectionTypeListener = connectivityTypeChecker.onConnectivityChanged.listen((event) {
      switch (event) {
        case ConnectivityResult.wifi:
          _connectionTypeController.add(ConnectionType.wifi);
          _lastConnectionType = ConnectionType.wifi;
          break;
        case ConnectivityResult.mobile:
          _connectionTypeController.add(ConnectionType.mobile);
          _lastConnectionType = ConnectionType.mobile;
          break;
        default:
          _connectionTypeController.add(ConnectionType.none);
          _lastConnectionType = ConnectionType.none;
          break;
      }
    });
  }

  ConnectionType _lastConnectionType = ConnectionType.none;

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;

  @override
  Future<ConnectionType> get connectionType => _connectionTypeController.stream.last;

  @override
  Future<bool> get isOnWiFi async {
    return _lastConnectionType == ConnectionType.wifi;
  }

  @override
  Future<bool> get isOnMobile async {
    return _lastConnectionType == ConnectionType.mobile;
  }

  final _connectionCheckerController = StreamController<NetworkStatus>.broadcast();

  final _connectionTypeController = StreamController<ConnectionType>.broadcast();

  @override
  Stream<NetworkStatus> get onConnectionChange => _connectionCheckerController.stream;

  @override
  Stream<ConnectionType> get onConnectionTypeChange => _connectionTypeController.stream;

  @override
  void dispose() {
    hasConnectionListener.cancel();
    connectionTypeListener.cancel();
    _connectionCheckerController.close();
    _connectionTypeController.close();
  }
}
