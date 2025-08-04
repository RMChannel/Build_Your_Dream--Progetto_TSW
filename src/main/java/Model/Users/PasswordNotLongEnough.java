package Model.Users;

public class PasswordNotLongEnough extends Exception {
    public PasswordNotLongEnough() {
        super("La password non è di almeno 8 caratteri");
    }
}
