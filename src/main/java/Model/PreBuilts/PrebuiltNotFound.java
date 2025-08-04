package Model.PreBuilts;

public class PrebuiltNotFound extends RuntimeException {
    public PrebuiltNotFound() {
        super("Il prebuilt con l'id specificato non è stato trovato");
    }
}
