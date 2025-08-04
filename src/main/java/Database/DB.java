package Database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DB {
    private static Connection conn = null;

    public static Connection getConn() throws SQLException { //fa in modo che non si perde mai la connessione al database, tranne alcuni casi particolari fuori dalla portata del programmatore
        if(conn == null || conn.isClosed() || !conn.isValid(1)) {
            setConnection();
        }
        return conn;
    }

    private static void setConnection() {
        String driver = "com.mysql.cj.jdbc.Driver";
        String username = "rc82";
        String password="Legion7@";

        // URL corretto per MySQL
        String url = "jdbc:mysql://URL_DB?autoReconnect=true";

        try {
            Class.forName(driver);
            conn = DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException e) {
            throw new DriverNotFound();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }
}
