import java.util.HashMap;
public class SymbolTable {

    HashMap<String, Integer> symbolTable = new HashMap<String, Integer>();
    int index = 0;

    public boolean add(String k){
        if(!symbolTable.containsKey(k)){
            symbolTable.put(k, index);
            index++;
            return true;
        }
        return false;
    }

}