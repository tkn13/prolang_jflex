public class Token {
    enum Type {
      operator,
      parentheses,
      semicolon,
      keyword,
      integers,
      identifiers,
      string,
      comments,
      etc
    }

    Type type;
    String value;

    public Token(Type type, String value) {
      this.type = type;
      this.value = value;
    }

    @Override
    public String toString() {
      return type + ": " + value;
    }
  }