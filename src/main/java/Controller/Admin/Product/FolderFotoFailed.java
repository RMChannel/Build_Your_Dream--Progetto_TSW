package Controller.Admin.Product;

public class FolderFotoFailed extends RuntimeException {
    public FolderFotoFailed() {
        super("C'è stato un problema nella gestione delle foto per PreBuilt");
    }
}
