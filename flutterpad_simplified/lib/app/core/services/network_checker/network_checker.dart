import 'dart:async';

enum NetworkStatus {
  connected,
  disconnected,
}

enum ConnectionType {
  wifi,
  mobile,
  none,
}

abstract class NetworkChecker {
  Future<bool> get isConnected;
  Future<ConnectionType> get connectionType;
  Future<bool> get isOnWiFi;
  Future<bool> get isOnMobile;
  Stream<NetworkStatus> get onConnectionChange;
  Stream<ConnectionType> get onConnectionTypeChange;
  void dispose();
}
