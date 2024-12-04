import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.regex.Pattern;

public class Main {
    private static ArrayList<String> readInput(String filename) {
        ArrayList<String> rows = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(filename))) {
            String line;
            while ((line = reader.readLine()) != null) {
                rows.add(line);
            }
        } catch (IOException e) {
            System.err.println("Error reading the file: " + e.getMessage());
        }
        
        return rows;
    }

    
    private static long getXMASCount(String str) {
        final long xmasCount = Pattern.compile("XMAS", Pattern.MULTILINE).matcher(str).results().count();
        final long samxCount = Pattern.compile("SAMX", Pattern.MULTILINE).matcher(str).results().count();
        
        return xmasCount + samxCount;
    }
    
    private static char getAtCoord(ArrayList<String> rows, int x, int y) {
        return rows.get(y).charAt(x);
    }
    
    private static ArrayList<String> transpose(ArrayList<String> rows) {
        int nRows = rows.size();
        int nCols = rows.get(0).length();
        
        ArrayList<String> transposed = new ArrayList<>();
        
        for (int i = 0; i < nCols; i++) {
            StringBuilder sb = new StringBuilder();
            for (int j = 0; j < nRows; j++) {
                sb.append(getAtCoord(rows, j, i));
            }
            transposed.add(sb.toString());
        }
        
        return transposed;
    } 
    
    private static ArrayList<String> getDiagonals(ArrayList<String> rows) {
        
        int nRows = rows.size();
        int nCols = rows.get(0).length();
        
        ArrayList<String> diagonals = new ArrayList<>();
        
        for (int d = -nRows + 1; d < nCols; d++) {
            StringBuilder sb = new StringBuilder();
            for (int i = Math.max(0, d); i < Math.min(nRows, nCols + d); i++) {
                sb.append(rows.get(i).charAt(i - d));
            }
            diagonals.add(sb.toString());
        }
        
        for (int d = 0; d < nRows + nCols - 1; d++) {
            StringBuilder sb = new StringBuilder();
            for (int i = Math.max(0, d - nCols + 1); i < Math.min(nRows, d + 1); i++) {
                sb.append(rows.get(i).charAt(d - i));
            }
            diagonals.add(sb.toString());
        }

        return diagonals;
    }
    
    private static int getX_MASCount(ArrayList<String> rows) {
        int count = 0;
        for (int i = 1; i < rows.size() - 1; i++) {
            for (int j = 1; j < rows.get(i).length() - 1; j++) {
                StringBuilder d1 = new StringBuilder();
                StringBuilder d2 = new StringBuilder();
                char center = getAtCoord(rows, i, j);
                if (center != 'A') continue;

                d1.append(getAtCoord(rows, i - 1, j - 1));
                d1.append(center);
                d1.append(getAtCoord(rows, i + 1, j + 1));
                
                d2.append(getAtCoord(rows, i - 1, j + 1));
                d2.append(center);
                d2.append(getAtCoord(rows, i + 1, j - 1));
                
                if ((d1.toString().equals("MAS") || d1.toString().equals("SAM"))
                    && (d2.toString().equals("MAS") || d2.toString().equals("SAM"))) {
                    count++;
                }
            }
        }
        return count;
    }

    public static void main(String[] args) {
        ArrayList<String> rows = readInput("input.txt");
        ArrayList<String> traversals = new ArrayList<>();
        traversals.addAll(rows);
        traversals.addAll(transpose(rows));
        traversals.addAll(getDiagonals(rows));
        
        long xmasCount = traversals.stream().mapToLong(Main::getXMASCount).sum();
        System.out.println("XMAS count: " + xmasCount);
        
        long x_masCount = getX_MASCount(rows);
        System.out.println("X_MAS count: " + x_masCount);
    }
}