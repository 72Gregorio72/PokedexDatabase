<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Objects" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
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
        String url = "jdbc:mysql://localhost:3306/pokemondb";
        String username = "root";
        String password = "";
        connection = DriverManager.getConnection(url, username, password);
    } catch (SQLException e) {
        e.printStackTrace();
    }

    String searchName = request.getParameter("searchName");
    String searchType = request.getParameter("searchType");
    String gen = request.getParameter("gen");
    String ordName = request.getParameter("OrdName");
    String ordTot = request.getParameter("OrdTot");
%>
    <body>
    <form action="index.jsp" method="post" style="display: none;" name="searchName" value="">
        <!-- Puoi aggiungere eventuali campi necessari qui -->
    </form>
    <div class="overlay">
        <img src="PokemonChips/pokemonLogo.png" alt="pokedex background" class="center-image">

        <form action="index.jsp" method="post" style="margin-top: 10px">
            <div style="display: flex; align-items: center;">
                <input type="text" name="searchName" placeholder="Search by name" style="border: 1px solid black; border-radius: 5px; margin-right: 10px;">
                <select name="searchType" id="searchType" style="border: 1px solid black; border-radius: 5px; background-color: white; color: black;">
                    <option value="">Types</option>
                    <option value="Water" style="background-color: blue; color: white;">Water</option>
                    <option value="Ghost" style="background-color: #5252a8; color: white;">Ghost</option>
                    <option value="Dragon" style="background-color: #7a7aff; color: white;">Dragon</option>
                    <option value="Ice" style="background-color: #00a6ff; color: white;">Ice</option>
                    <option value="Flying" style="background-color: #7a7aff; color: white;">Flying</option>
                    <option value="Fairy" style="background-color: pink; color: white;">Fairy</option>
                    <option value="Psychic" style="background-color: #ff00dd; color: white;">Psychic</option>
                    <option value="Poison" style="background-color: purple; color: white;">Poison</option>
                    <option value="Fighting" style="background-color: #691010; color: white;">Fighting</option>
                    <option value="Rock" style="background-color: #5b2400; color: white;">Rock</option>
                    <option value="Ground" style="background-color: #a6573a; color: white;">Ground</option>
                    <option value="Bug" style="background-color: #536b0b; color: white;">Bug</option>
                    <option value="Grass" style="background-color: green; color: white;">Grass</option>
                    <option value="Normal" style="background-color: gray; color: white;">Normal</option>
                    <option value="Dark" style="background-color: #340e00; color: white;">Dark</option>
                    <option value="Steel" style="background-color: gray; color: white;">Steel</option>
                    <option value="Electric" style="background-color: #ffcc00; color: white;">Electric</option>
                    <option value="Fire" style="background-color: red; color: white;">Fire</option>
                </select>
            </div>
            <div style="display: flex; align-items: center; margin-top: 10px;">
                <select name="gen" id="gen" style="border: 1px solid black; border-radius: 5px; background-color: white; color: black; margin-right: 10px;">
                    <option value="">Gens</option>
                    <option value="1">Gen 1</option>
                    <option value="2">Gen 2</option>
                    <option value="3">Gen 3</option>
                    <option value="4">Gen 4</option>
                    <option value="5">Gen 5</option>
                    <option value="6">Gen 6</option>
                    <option value="7">Gen 7</option>
                    <option value="8">Gen 8</option>
                    <option value="9">Gen 9</option>
                </select>
                <select name="OrdName" style="border: 1px solid black; border-radius: 5px; background-color: white; color: black; margin-right: 10px;">
                    <option value="-1">Order By Name</option>
                    <option value="1">↑</option>
                    <option value="2">↓</option>
                </select>
                <select name="OrdTot" style="border: 1px solid black; border-radius: 5px; background-color: white; color: black; margin-right: 10px;">
                    <option value="-1">Order By Total</option>
                    <option value="1">↑</option>
                    <option value="2">↓</option>
                </select>
                <button type="submit" onmouseover="changeImage()" onmouseout="restoreImage()" style="border: 1px solid black; border-radius: 5px; background-color: white;">
                    <img src="PokemonChips/pokeball.png" style="width: 50px; height: 50px; position: absolute; margin-top: -35px; margin-left: 0px;" id="pokeballImg">
                </button>
            </div>
        </form>
        <form action="confronto.html" style="margin-left: 60px; margin-top: 8px">
        <button type="submit" style="border: 1px solid black; border-radius: 10px; background-color: white; height: 30px">
            <p style="color: black">Confronta Due Pokemon</p>
        </button>
    </form>
    </div>
    <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
     %>
    <script>
        function changeImage() {
            document.getElementById('pokeballImg').src = 'PokemonChips/pokeball_red.png';
        }

        function restoreImage() {
            document.getElementById('pokeballImg').src = 'PokemonChips/pokeball.png';
        }
    </script>

    <style>
        #searchType{
            height: 44px;
            border: none;
            overflow: hidden;
        }
        #searchType::-moz-focus-inner {
            border: 0;
        }
        #searchType:focus {
            outline: none;
        }
        #searchType option{
            width: 160px;
            height: 10px;
            font-size: 1em;
            padding: 10px 0;
            text-align: center;
            margin-right: 20px;;
            cursor: pointer;
            border: rgb(0, 0, 0) solid 2px;
            border-radius: 5px;
            color: rgb(255, 255, 255);
            font-family: 'Press Start 2P';
        }
    </style>



        <%

        PreparedStatement statement;

        if (searchName != null && !searchName.isEmpty()) {
            statement = connection.prepareStatement("SELECT * FROM prova WHERE name LIKE '%" + searchName + "%'");
        } else if( searchType != null && !searchType.isEmpty()) {
            statement = connection.prepareStatement("SELECT * FROM prova WHERE type_1 LIKE '" + searchType + "' OR type_2 LIKE '" + searchType + "'");
        } else if(gen != null && !gen.isEmpty()){
            statement = connection.prepareStatement("SELECT * FROM  prova  JOIN gen" + gen + " ON gen" + gen + ".id = prova.number");
        } else if(!Objects.equals(ordTot, "-1")){
            if(ordTot.equals("1")){
                statement = connection.prepareStatement("SELECT * FROM prova ORDER BY total");
            } else {
                statement = connection.prepareStatement("SELECT * FROM prova ORDER BY total DESC");
            }
        } else if(!Objects.equals(ordName, "-1")){
            if(ordName.equals("1")){
                statement = connection.prepareStatement("SELECT * FROM prova ORDER BY name");
            } else {
                statement = connection.prepareStatement("SELECT * FROM prova ORDER BY name DESC");
            }
        } else {
            statement = connection.prepareStatement("SELECT * FROM prova");
        }

        ResultSet resultSet = statement.executeQuery();
    %>
    <div class="flex flex-row flex-wrap justify-center items-center gap-10" style="margin-top: 100px">
        <%
            while (resultSet.next()) {
                int pokemonId = resultSet.getInt("number");
                String pokemonName = resultSet.getString("name");
                String type_1 = resultSet.getString("type_1");
                String type_2 = resultSet.getString("type_2");
                int hp = resultSet.getInt("hp");
                int attack = resultSet.getInt("attack");
                int defence = resultSet.getInt("defense");
                int speed = resultSet.getInt("speed");
                int special = resultSet.getInt("sp_atk");
                int total = resultSet.getInt("total");
                //String gif = resultSet.getString("gif");
                String image = resultSet.getString("image_url");
                //String description = resultSet.getString("description");
        %>

        <div class="m-5 flex flex-col rounded-lg border border-gray-100 bg-white shadow-md bg-[url('PokemonChips/pokedexBG.png')] bg-cover bg-no-repeat" style="width: 510px; height: 630px; box-shadow: -20px 20px 1px rgba(0, 0, 0, 0.2); display: flex; justify-items: center;">
            <div class="flex h-40 overflow-hidden rounded-xl relative">
                <img src="<%= image %>" alt="product image" style="margin-top: 0px; margin-left: 25px; width: 130px; height: 130px;"/>
            </div>
            <div class="mt-1 flex w-full">
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
