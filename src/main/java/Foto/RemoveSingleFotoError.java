package Foto;

public class RemoveSingleFotoError extends RuntimeException {
    public RemoveSingleFotoError() {
        super("Rimozione di singola foto da Prebuilt fallita");
    }
}
