<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>

<%
    Connection connection = null;
    try {
        String url = "jdbc:mysql://localhost:3306/pokemondb";
        String username = "root";
        String password = "";
        connection = DriverManager.getConnection(url, username, password);
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
