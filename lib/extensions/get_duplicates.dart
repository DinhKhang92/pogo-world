extension ListExtensions<E> on List<E> {
  List<E> removeAll(Iterable<E> allToRemove) {
    for (E element in allToRemove) {
      remove(element);
    }
    return this;
  }

  List<E> getDuplicates() {
    List<E> duplicates = List.from(this);
    duplicates.removeAll(toSet().toList());
    return duplicates;
  }
}
