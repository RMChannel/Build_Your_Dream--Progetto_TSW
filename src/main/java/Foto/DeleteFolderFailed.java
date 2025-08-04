package Foto;

public class DeleteFolderFailed extends RuntimeException {
    public DeleteFolderFailed(int id) {
        super("Cancellazione cartella"+id+" fallita");
    }
}
