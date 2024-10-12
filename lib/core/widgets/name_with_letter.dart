extension NameInitials on String {
  static String getInitialsFromFullName(String fullName) {
    final names = fullName.split(' ');
    final initials = names
        .where((name) => name.isNotEmpty)
        .map((name) => name[0].toUpperCase())
        .take(2)
        .join();

    return initials;
  }
}
