class Notifier {
  List<Function()> listeners = [];

  addListener(Function() newListener) {
    listeners.add(newListener);
  }

  removeListener(Function() listenerToRemove) {
    listeners.remove(listenerToRemove);
  }

  notifyListeners() {
    for (final listener in listeners) {
      listener();
    }
  }
}
