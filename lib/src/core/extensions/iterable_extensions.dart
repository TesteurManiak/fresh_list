extension IterableExtensions<T> on Iterable<T> {
  Iterable<T> separatedWith(T separator) sync* {
    for (int i = 0; i < length; i++) {
      final elem = elementAt(i);
      yield elem;
      if (i < length - 1) {
        yield separator;
      }
    }
  }
}
