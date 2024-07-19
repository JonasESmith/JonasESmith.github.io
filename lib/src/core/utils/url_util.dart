class UrlUtil {
  /// replace all spaces with scores
  static String cleanUrlTitle({required String title}) {
    return title.replaceAll(" ", "-");
  }

// recode our clean url title
  static String decodeUrlTitle({required String title}) {
    return title.replaceAll("-", " ");
  }
}
