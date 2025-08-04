package Model.ContactUs;

public class ContactUs {
    private int ID;
    private String name;
    private String email;
    private String message;

    public ContactUs(int ID, String name, String email, String message) {
        this.ID = ID;
        this.name = name;
        this.email = email;
        this.message = message;
    }

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
