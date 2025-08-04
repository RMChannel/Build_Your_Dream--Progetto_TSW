package Model.Pezzi;

public class PezzoNotFound extends RuntimeException {
    public PezzoNotFound() {
        super("Se questa eccezione viene eseguita, sparati, non hai alternative oramai");
    }
}
