package Model.Users;

import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Date;

public class User {
    private String username;
    private String password;
    private String nome;
    private String cognome;
    private String email;
    private String nTelefono;
    private Date dataDiNascita;
    private boolean isAdmin;

    public User(String username, String password, String nome, String cognome, String email, String nTelefono, Date dataDiNascita, boolean isAdmin) {
        this.username = username;
        this.password = calculateHashPassword(password);
        this.nome = nome;
        this.cognome = cognome;
        this.email = email;
        this.nTelefono = nTelefono;
        this.dataDiNascita = dataDiNascita;
        this.isAdmin = isAdmin;
    }

    public User(String username, String password, String nome, String cognome, String email, String nTelefono, Date dataDiNascita, boolean isAdmin, boolean login) {
        this.username = username;
        this.password = password;
        this.nome = nome;
        this.cognome = cognome;
        this.email = email;
        this.nTelefono = nTelefono;
        this.dataDiNascita = dataDiNascita;
        this.isAdmin = isAdmin;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) throws PasswordNotLongEnough {
        if(password.length() < 8) {
            throw new PasswordNotLongEnough();
        }
        this.password = calculateHashPassword(password);
    }

    public String calculateHashPassword(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-1");
            digest.reset();
            digest.update(password.getBytes(StandardCharsets.UTF_8));
            return String.format("%040x", new BigInteger(1, digest.digest()));
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCognome() {
        return cognome;
    }

    public void setCognome(String cognome) {
        this.cognome = cognome;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getnTelefono() {
        return nTelefono;
    }

    public void setnTelefono(String nTelefono) {
        this.nTelefono = nTelefono;
    }

    public Date getDataDiNascita() {
        return dataDiNascita;
    }

    public void setDataDiNascita(Date dataDiNascita) {
        this.dataDiNascita = dataDiNascita;
    }

    public boolean isAdmin() {
        return isAdmin;
    }

    public void setAdmin(boolean admin) {
        isAdmin = admin;
    }
}
