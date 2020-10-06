extension StringUtils on String {
  String capitalizeFirstLitter() {
    if (isEmpty) {
      return this;
    }
    else if (length == 1) {
      return toUpperCase();
    }
    else {
      return '${this[0].toUpperCase()}${substring(1)}';
    }
  }
}