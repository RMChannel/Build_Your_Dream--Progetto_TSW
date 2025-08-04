package Foto;

public class FolderDoesntExist extends RuntimeException {
    public FolderDoesntExist(String path) {
        super("La cartella che hai cercato di aprire non esiste: "+path);
    }
}
