<!DOCTYPE html>
<html lang="en">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Objects" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pokedex</title>
    <link rel="shortcut icon" href="PokemonChips/pokeball.png" />
    <style>
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            background-color: #383838;
        }

        .overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 10%;
            z-index: 999; /* assicura che l'overlay sia sopra a tutto */
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #383838;
        }

        .center-image {
            position: absolute;
            top: 50%;
            left: 10%;
            transform: translate(-50%, -50%);
            width: 10%;
            height: auto;
            z-index: -1;
        }
    </style>
    <script src="https://cdn.tailwindcss.com"></script>
    <link
            href="https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap"
            rel="stylesheet"
    />
</head>
<%
    Connection connection = null;
    try {
        String url = "jdbc:mysql://sql8.freesqldatabase.com:3306/sql8705674?useUnicode=true&characterEncoding=UTF-8";
        String username = "sql8705674";
        String password = "WKRpjTTnyY";
        connection = DriverManager.getConnection(url, username, password);
    } catch (SQLException e) {
        e.printStackTrace();
    }
                <div class="mt-1 flex w-full" style="display: flex; align-items: center; margin-top: 20px; margin-left: 25px; justify-items: center">
                    <img src="PokemonChips/<%= type_1 %>.png" alt="type 1" style="width: 100px"/>
                    <% if (!Objects.equals(type_2, "Blank")) { %>
                        <img src="PokemonChips/<%= type_2 %>.png" alt="type 2" style="width: 100px" />
                    <% } %>
                </div>
            </div>

            <div style="display: flex; justify-content: center; margin-top: 20px;margin-left: 350px">
                <p class="text-lg text-center" style="font-size: 20px; font-family: 'Press Start 2P'" >
                    <%
                        String msg;
                        if (pokemonId < 10) {
                            msg = "000" + pokemonId;
                        } else if (pokemonId < 100) {
                            msg = "00" + pokemonId;
                        } else if(pokemonId < 1000){
                            msg = "0" + pokemonId;
                        } else {
                            msg = String.valueOf(pokemonId);
                        }
                    %>
                    #<%= msg %>
                </p>
            </div>

            <div style="width: 480px; height: 50px; position: absolute; margin-top: 350px; margin-left: 150px; border-radius: 20px; font-family: 'Press Start 2P'; font-size: 2px">
                <p style="font-size: 20px; margin-top: 15px; margin-left: 10px">
                    Total: <%= total %>
                </p>
            </div>
            <div style=" display: flex; justify-content: center; margin-top: 260px; ">
                <form action="pokemonInfo.jsp" method="post">
                    <div style="display: flex; align-items: center; justify-items: center; justify-content: center">
                        <button type="submit" name="PokemonID" value="<%= pokemonId%>">
                            <p class="text-lg text-center" style=" font-size: 30px;font-family: 'Press Start 2P'"><%= pokemonName%> </p>
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <%
                }
                resultSet.close();
                statement.close();
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </div>
    </body>
</html>
