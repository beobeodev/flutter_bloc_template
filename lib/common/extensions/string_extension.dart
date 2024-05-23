extension StringExtension on String? {
  /// Checks if string is URL.
  bool get isUrl => _hasMatch(
        this,
        r"^((((H|h)(T|t)|(F|f))(T|t)(P|p)((S|s)?))\://)?(www.|[a-zA-Z0-9].)[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,7}(\:[0-9]{1,5})*(/($|[a-zA-Z0-9\.\,\;\?\'\\\+&amp;%\$#\=~_\-]+))*$",
      );

  /// Checks if string is email.
  bool get isEmail => _hasMatch(
        this,
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\ "]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
      );

  /// Uppercase first letter inside string and let the others lowercase
  /// Example: your name => Your name
  String? get capitalizeFirst {
    if (isNullOrEmpty) return this;

    return this![0].toUpperCase() + this!.substring(1).toLowerCase();
  }

  /// Remove all whitespace inside string
  /// Example: your name => yourname
  String? get removeAllWhitespace {
    if (isNullOrEmpty) return this;

    return this!.replaceAll(' ', '');
  }

  /// Capitalize only the first letter of each word in a string
  /// Example: this is an example text => This Is An Example Text
  String? get capitalizeAllWordsFirstLetter {
    if (isNullOrEmpty) return this;

    final lowerCasedString = this!.toLowerCase();
    final stringWithoutExtraSpaces = lowerCasedString.trim();

    if (stringWithoutExtraSpaces.isEmpty) {
      return '';
    }
    if (stringWithoutExtraSpaces.length == 1) {
      return stringWithoutExtraSpaces.toUpperCase();
    }

    final stringWordsList = stringWithoutExtraSpaces.split(' ');
    final capitalizedWordsFirstLetter = stringWordsList
        .map(
          (word) {
            if (word.trim().isEmpty) return '';
            return word.trim();
          },
        )
        .where(
          (word) => word != '',
        )
        .map(
          (word) {
            if (word.startsWith(RegExp(r'[\n\t\r]'))) {
              return word;
            }
            return word[0].toUpperCase() + word.substring(1).toLowerCase();
          },
        )
        .toList();
    final finalResult = capitalizedWordsFirstLetter.join(' ');

    return finalResult;
  }

  bool get isNullOrEmpty => this == null || this!.isEmpty;

  static bool _hasMatch(String? value, String pattern) {
    return value == null || RegExp(pattern).hasMatch(value);
  }
}
