extension StringExtensions on String {
  String get leadingEmoji {
    final parts = trim().split(' ');
    if (parts.length > 1) return parts.first;
    if (parts.isNotEmpty && parts.first.isNotEmpty) return '💰';
    return '❔';
  }

  String get descriptionTitle {
    final parts = trim().split(' ');
    if (parts.length > 1) return parts.skip(1).join(' ');
    if (parts.isNotEmpty && parts.first.isNotEmpty) return parts.first;
    return 'No Description';
  }
}
