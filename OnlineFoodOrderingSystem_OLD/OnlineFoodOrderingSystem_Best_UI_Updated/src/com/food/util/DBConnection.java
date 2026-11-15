package com.food.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public final class DBConnection {
    private static final String DEFAULT_URL =
            "jdbc:mysql://localhost:3306/food_ordering_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=Asia/Kolkata";
    private static final String DEFAULT_USER = "root";
    private static final String DEFAULT_PASSWORD = "root";

    private DBConnection() {}

    public static Connection getConnection() throws SQLException {
        String url = value("FOOD_DB_URL", "food.db.url", DEFAULT_URL);
        String user = value("FOOD_DB_USER", "food.db.user", DEFAULT_USER);
        String password = value("FOOD_DB_PASSWORD", "food.db.password", DEFAULT_PASSWORD);
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC driver was not found. Check WEB-INF/lib/mysql-connector-j-9.6.0.jar.", e);
        }
        return DriverManager.getConnection(url, user, password);
    }

    public static Diagnostic diagnose() {
        String url = value("FOOD_DB_URL", "food.db.url", DEFAULT_URL);
        String user = value("FOOD_DB_USER", "food.db.user", DEFAULT_USER);
        try (Connection c = getConnection()) {
            String database = c.getCatalog();
            String server = c.getMetaData().getDatabaseProductName() + " " + c.getMetaData().getDatabaseProductVersion();
            return Diagnostic.success(url, user, database, server);
        } catch (SQLException e) {
            return Diagnostic.failure(url, user, classify(e), safeMessage(e));
        }
    }

    private static String classify(SQLException e) {
        String m = e.getMessage() == null ? "" : e.getMessage().toLowerCase();
        if (m.contains("communications link failure") || m.contains("connection refused") || m.contains("connect timed out"))
            return "MYSQL_NOT_RUNNING_OR_PORT_UNAVAILABLE";
        if (m.contains("access denied")) return "WRONG_USERNAME_OR_PASSWORD";
        if (m.contains("unknown database")) return "DATABASE_NOT_FOUND";
        if (m.contains("no suitable driver") || m.contains("driver")) return "JDBC_DRIVER_PROBLEM";
        return "DATABASE_CONNECTION_ERROR";
    }

    private static String safeMessage(SQLException e) {
        String m = e.getMessage();
        if (m == null || m.trim().isEmpty()) return "No database error message was returned.";
        return m.replaceAll("(?i)(password=)[^& ]*", "$1***");
    }

    private static String value(String envName, String propertyName, String defaultValue) {
        String value = System.getenv(envName);
        if (value == null || value.trim().isEmpty()) value = System.getProperty(propertyName);
        return (value == null || value.trim().isEmpty()) ? defaultValue : value.trim();
    }

    public static final class Diagnostic {
        private final boolean connected;
        private final String url, user, database, server, category, message;
        private Diagnostic(boolean connected, String url, String user, String database, String server, String category, String message) {
            this.connected = connected; this.url = url; this.user = user; this.database = database;
            this.server = server; this.category = category; this.message = message;
        }
        static Diagnostic success(String url, String user, String database, String server) {
            return new Diagnostic(true, url, user, database, server, "OK", "Connection successful.");
        }
        static Diagnostic failure(String url, String user, String category, String message) {
            return new Diagnostic(false, url, user, "-", "-", category, message);
        }
        public boolean isConnected(){return connected;} public String getUrl(){return url;} public String getUser(){return user;}
        public String getDatabase(){return database;} public String getServer(){return server;} public String getCategory(){return category;} public String getMessage(){return message;}
    }
}
