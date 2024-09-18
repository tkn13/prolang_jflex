import java.io.File;
import java.io.FileNotFoundException;
import java.io.StringReader;

import java.util.Scanner;

public class Main {

  private String testFile = "test.txt";

  public static void main(String[] args) {

    Main main = new Main();

    String input = main.readFromFile();
    StringReader reader = new StringReader(input);
    MyLex myLex = new MyLex(reader);
    Token token = null;
    SymbolTable symbolTable = new SymbolTable();

    try {
      while ((token = myLex.yylex()) != null) {

        if (token.type == Token.Type.identifiers) {
          boolean added = symbolTable.add(token.value);
          if (added) {
            System.out.println(token);
          } else {
            System.out.println("This identifier is already in the symbol table: " + token);
          }
        } else {
          System.out.println(token);
        }
      }

    } catch (Exception e) {
      System.out.println("Error: " + e.getMessage());
    }

  }

  public String readFromFile() {
    String currentPath = System.getProperty("user.dir");
    String separated = System.getProperty("file.separator");

    String file = currentPath + separated + "test" + separated + testFile;
    String content = "";

    try {
      File myFile = new File(file);
      Scanner myReader = new Scanner(myFile);
      while (myReader.hasNextLine()) {
        content += myReader.nextLine() + "\n";
      }
      myReader.close();
    } catch (FileNotFoundException e) {
      System.out.println("An error occurred.");
    }

    return content;
  }
}
