

int calculateReadingTime(String contenu) {
  final totalMots = contenu.split(RegExp(r'\s+')).length;
  final readingTime = totalMots / 200;
  return readingTime.ceil();
}
