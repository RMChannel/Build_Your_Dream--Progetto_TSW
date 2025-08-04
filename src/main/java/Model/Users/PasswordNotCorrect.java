package Model.Users;

public class PasswordNotCorrect extends Exception {
    public PasswordNotCorrect() {
        super("La password inserita non corrisponde a quella dell'utente");
    }
}
