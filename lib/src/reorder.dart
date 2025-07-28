mixin ReorderableItemRepositoryMixin<T> {
  DateTime? getOrderedDateTime(T item);
  DateTime getCreatedDateTime(T item);
  DateTime _getDateTimeToOrder(T item) {
    return getOrderedDateTime(item) ?? getCreatedDateTime(item);
  }

  int sort(T a, T b) {
    return _getDateTimeToOrder(a).compareTo(_getDateTimeToOrder(b));
  }

  DateTime reorder(List<T> items, T item) {
    final index = items.indexOf(item);

    final T? previous = index == 0 ? null : items[index - 1];
    final T? next = index == items.length - 1 ? null : items[index + 1];

    final previousOrderDateTime =
        previous == null ? null : _getDateTimeToOrder(previous);
    final nextOrderDateTime = next == null ? null : _getDateTimeToOrder(next);

    final DateTime updatedOrderedDateTime;

    if (previousOrderDateTime == null) {
      updatedOrderedDateTime =
          nextOrderDateTime!.add(const Duration(hours: -1));
    } else if (nextOrderDateTime == null) {
      updatedOrderedDateTime =
          previousOrderDateTime.add(const Duration(hours: 1));
    } else {
      final diff = nextOrderDateTime.difference(previousOrderDateTime);

      updatedOrderedDateTime = previousOrderDateTime.add(diff ~/ 2);
    }

    return updatedOrderedDateTime;
  }
}
