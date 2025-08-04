package Model.Carrello;

public class ObjectIsNotAPiece extends RuntimeException {
    public ObjectIsNotAPiece() {
        super("L'oggetto che hai tentato di aggiungere al carrello non è né un pezzo né un accessorio");
    }
}
