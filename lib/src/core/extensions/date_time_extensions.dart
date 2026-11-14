extension DateTimeExtensions on DateTime {
  bool operator >(DateTime other) => isAfter(other);
  bool operator <(DateTime other) => isBefore(other);
  bool operator >=(DateTime other) => !isBefore(other);
  bool operator <=(DateTime other) => !isAfter(other);
}
