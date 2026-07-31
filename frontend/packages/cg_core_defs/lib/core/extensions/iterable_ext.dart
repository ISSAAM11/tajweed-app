extension IterableSecond<E> on Iterable<E> {
  E get second {
    Iterator<E> it = iterator;
    if (!(it.moveNext() && it.moveNext())) {
      throw StateError("No second element");
    }
    return it.current;
  }

  E get third {
    Iterator<E> it = iterator;
    if (!(it.moveNext() && it.moveNext() && it.moveNext())) {
      throw StateError("No third element");
    }
    return it.current;
  }

  Iterable<E> keepWhere(
    bool Function(E element) filterCondition, {
    required bool Function(E element) onlyIf,
  }) =>
      any(onlyIf) ? where(filterCondition) : this;
}
