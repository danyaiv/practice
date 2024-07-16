import java.sql.*;


public class Main {
    private static final String PROTOCOL = "jdbc:postgresql://";
    private static final String DRIVER = "org.postgresql.Driver";
    private static final String URL_LOCALE_NAME = "localhost/";
    private static final String URL_REMOTE = "10.242.65.114:5432/";
    private static final String DATABASE_NAME = "death_ball";

    public static final String DATABASE_URL = PROTOCOL + URL_LOCALE_NAME + DATABASE_NAME;
    public static final String USER_NAME = "postgres";
    public static final String DATABASE_PASS = "postgres";

    public static void main(String[] args) {
        checkDriver();
        checkDB();
        System.out.println("Подключение к базе данных | " + DATABASE_URL + "\n");


        try (Connection connection = DriverManager.getConnection(DATABASE_URL, USER_NAME, DATABASE_PASS)) {
            //TODO show all tables
            getPlayers(connection);
            System.out.println();

            getSwords(connection);
            System.out.println();

            getAuras(connection);
            System.out.println();


            // TODO show with param
            getPlayerSwords(connection, "shay");
            System.out.println();
            auraSearching(connection);
            System.out.println();
            swordSearching(connection);
            System.out.println();


            // TODO correction
//            addPlayer(connection, "KrutoyBobik");
//
//            deletePlayer(connection, "KrutoyBobik");
//
//            addSword(connection, "Slasher", "mythic", 25000, 0, 1000);
//            correctAura(connection, "spirit", 1000);


        } catch (SQLException e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }

    private static void getPlayers(Connection connection) throws SQLException {
        String columnName0 = "id", columnName1 = "nickname";

        String param1 = null, param2 = null;
        Statement statement = connection.createStatement();
        ResultSet rs = statement.executeQuery("SELECT * FROM players");

        System.out.println("id| nickname ");
        while (rs.next()) {
            param1 = rs.getString(columnName0);
            param2 = rs.getString(columnName1);
            System.out.println(param1 + " | " + param2);
        }
    }

    private static void getAuras(Connection connection) throws SQLException {
        String columnName0 = "id", columnName1 = "drop_chance", columnName2 = "player_count", columnName3 = "name";
        String param1, param2, param3, param4;

        System.out.printf("%-5s | %-20s | %-15s | %-15s ", "id", "drop_chance", "player_count", " name");
        System.out.println();
        Statement statement = connection.createStatement();
        ResultSet rs = statement.executeQuery("SELECT * FROM auras");

        while (rs.next()) {
            param1 = rs.getString(columnName0);
            param2 = rs.getString(columnName1);
            param3 = rs.getString(columnName2);
            param4 = rs.getString(columnName3);
            System.out.printf("%-5s | %-20s | %-15s | %-15s ", param1, param2, param3, param4);
            System.out.println();
        }
    }

    private static void getSwords(Connection connection) throws SQLException {
        String columnName0 = "id", columnName1 = "name", columnName2 = "rarity", columnName3 = "price", columnName4 = "player_count", columnName5 = "power";
        String param1 = null, param2 = null, param3 = null, param4 = null, param5 = null, param6 = null;
        Statement statement = connection.createStatement();
        ResultSet rs = statement.executeQuery("SELECT * FROM swords");

        System.out.printf("%-5s | %-20s | %-10s | %-10s | %-12s | %-12s", "id", "name", "rarity", " price", "player_count", "power");
        System.out.println();
        while (rs.next()) {
            param1 = rs.getString(columnName0);
            param2 = rs.getString(columnName1);
            param3 = rs.getString(columnName2);
            param4 = rs.getString(columnName3);
            param5 = rs.getString(columnName4);
            param6 = rs.getString(columnName5);
            System.out.printf("%-5s | %-20s | %-10s | %-10s | %-12s | %-12s", param1, param2, param3, param4, param5, param6);
            System.out.println();
        }
    }



    private static void getPlayerSwords(Connection connection, String name) throws SQLException {
        if (name == null || name.isBlank()) return;
        name = '%' + name + '%';
        long time = System.currentTimeMillis();
        PreparedStatement statement = connection.prepareStatement(
                "SELECT players.nickname, swords.name " +
                        "FROM players " +
                        "JOIN players_swords ON players.id = players_swords.player_id " +
                        "JOIN swords ON swords.id = players_swords.player_id " +
                        "WHERE players.nickname LIKE ?;");
        statement.setString(1, name);
        ResultSet rs = statement.executeQuery();

        while (rs.next()) {
            System.out.println(rs.getString("nickname") + " | " + rs.getString("name"));
        }
        System.out.println("SELECT with WHERE (" + (System.currentTimeMillis() - time) + " мс.)");
    }

    private static void addPlayer(Connection connection, String nickname) throws SQLException {
        if (nickname == null || nickname.isBlank()) return;

        PreparedStatement statement = connection.prepareStatement("INSERT INTO players(nickname) VALUES (?)", Statement.RETURN_GENERATED_KEYS);
        statement.setString(1, nickname);
        int count = statement.executeUpdate();

        ResultSet generatedKeys = statement.getGeneratedKeys();
        if (generatedKeys.next()) {
            System.out.println("Идентификатор игрока: " + generatedKeys.getInt(1));
        }
        System.out.println("INSERTed 1 player");
        getPlayers(connection);
    }

    private static void deletePlayer(Connection connection, String nickname) throws SQLException {
        if (nickname == null || nickname.isBlank()) return;
        PreparedStatement statement = connection.prepareStatement("DELETE from players WHERE nickname=?;");
        statement.setString(1, nickname);

        int count = statement.executeUpdate();
        System.out.println("DELETED " + count + " players");
        getPlayers(connection);
    }

    private static void auraSearching(Connection connection) throws SQLException {
        int param0 = -1;
        String param1 = null, param2 = null;

        System.out.println("id| name   | player_count");
        Statement statement = connection.createStatement();
        ResultSet rs = statement.executeQuery("SELECT id, name, player_count FROM auras WHERE player_count > 1");
        while (rs.next()) {
            param0 = rs.getInt("id");
            param1 = rs.getString("name");
            param2 = rs.getString("player_count");
            System.out.println(param0 + " | " + param1 + " | " + param2);
        }
    }

    private static void swordSearching(Connection connection) throws SQLException {
        int param0 = -1;
        String param1 = null, param2 = null;

        System.out.println("id|      name     | player_count");
        Statement statement = connection.createStatement();
        ResultSet rs = statement.executeQuery("SELECT id, name, player_count FROM swords WHERE player_count=0");

        while (rs.next()) {
            param0 = rs.getInt("id");
            param1 = rs.getString("name");
            param2 = rs.getString("player_count");
            System.out.println(param0 + " | " + param1 + " | " + param2);
        }
    }

    private static void addSword(Connection connection, String name, String rarity, int price, int player_count, int power) throws SQLException {
        PreparedStatement statement = connection.prepareStatement("INSERT INTO swords(name, rarity, price, player_count, power) VALUES (?, ?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
        statement.setString(1, name);
        statement.setString(2, rarity);
        statement.setInt(3, price);
        statement.setInt(4, player_count);
        statement.setInt(5, power);

        int count = statement.executeUpdate();

        ResultSet generatedKeys = statement.getGeneratedKeys();
        if (generatedKeys.next()) {
            System.out.println("Меч " + name + " был добавлен");
            System.out.println("Идентификатор меча: " + generatedKeys.getInt(1));

        }

        System.out.println("Inserted 1 sword");
        getSwords(connection);
    }

    private static void correctAura(Connection connection, String name, int dropChance) throws SQLException {
        if (name == null || name.isBlank()) return;

        String updateSql = "UPDATE auras SET drop_chance = ? WHERE name = ?";
        PreparedStatement statement = connection.prepareStatement(updateSql);
        statement.setInt(1, dropChance);
        statement.setString(2, name);

        int count = statement.executeUpdate();
        System.out.println("Updated " + count + " auras");

        getAuras(connection);
    }

    public static void checkDriver() {
        try {
            Class.forName(DRIVER);
        } catch (ClassNotFoundException e) {
            System.out.println("Нет JDBC-драйвера!");
            throw new RuntimeException(e);
        }
    }

    public static void checkDB() {
        try {
            Connection connection = DriverManager.getConnection(DATABASE_URL, USER_NAME, DATABASE_PASS);
        } catch (SQLException e) {
            System.out.println("Нет базы данных! Проверьте имя базы, путь к базе");
            throw new RuntimeException(e);
        }
    }
}
