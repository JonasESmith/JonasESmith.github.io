/// This class is used to generate a list of character combinations from a given
/// list of keywords. This is used to generate a list of keywords that we can
/// use to search for posts, users, groups etc.
class KeywordsUtil {
  /// generate a list of character combinations from a given list of keywords.
  /// This is used to generate a list of keywords that we can use to search
  /// for posts, users, groups etc.
  static List<String> generate({
    required List<String> keyWords,
  }) {
    final keyWordSearchList = <String>[];

    for (var i = 0; i < keyWords.length; i++) {
      keyWordSearchList.addAll(
        _generateCharacterCombinations(
          phrase: keyWords[i].toLowerCase(),
        ),
      );
    }

    // Add all the char
    /// lets remove any of our blank strings produces
    keyWordSearchList.removeWhere((element) => element.isEmpty);

    /// lets take all the keywords and add them as one string
    final allWords = keyWords.map((e) => e.toLowerCase()).join(' ');

    keyWordSearchList.add(allWords);

    // remove duplicates
    keyWordSearchList.toSet().toList();

    /// return the list
    return keyWordSearchList;
  }

  /// generate a list of character combinations from a given phrase.
  static List<String> _generateCharacterCombinations({required String phrase}) {
    final fullName = phrase;
    final combinations = <String>[];

    for (var i = 0; i < fullName.length; i++) {
      for (var j = i + 1; j <= fullName.length; j++) {
        combinations.add(fullName.substring(i, j));
      }
    }

    return combinations;
  }
}
