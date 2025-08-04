package Model.Accessori;

public class AccessorioNotFound extends RuntimeException {
    public AccessorioNotFound() {
        super("Se questa eccezione viene eseguita, sparati, non hai alternative oramai");
    }
}
