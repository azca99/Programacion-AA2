package com.svalero.tienda.db;

import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.sqlobject.SqlObjectPlugin;

public class Database {

    public static Jdbi jdbi;
    public static Handle db;

    public static void connect() throws ClassNotFoundException {
        Class.forName("org.mariadb.jdbc.Driver");
        jdbi = Jdbi.create("jdbc:mariadb://localhost:3306/tienda", "root", "Barcelona99)");
        jdbi.installPlugin(new SqlObjectPlugin());
        db = jdbi.open();
    }

    public static void close() {
        Database.db.close();
    }
}
