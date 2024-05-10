<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Objects" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="java.io.File" %>
<%@ page import="java.awt.*" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="PokemonChips/pokeball.png" />
    <title>Dettagli Pokemon</title>

    <style>
        :root {
            --red: #dd082f;
            --green: hsl(109, 99%, 49%);
            --yellow: #ffcc02;
            --sky: #01fbfb;
            --orange: #ffcc02;
            --blue: #519afb;
            font-size: 16px;
        }

        body {
            display: flex;
            align-items: center;
            height: 100vh;
            overflow: auto;
            margin: 0;
            color: white;
            font-family: system-ui;
        }

        .pokedex {
            perspective: 1000px;
            height: 40rem;
            width: 30rem;
            margin: 0 auto;
            position: relative;
        }

        .pokedex:hover .pokedex-right-front,
        .pokedex .pokedex-right-front {
            transform: rotateY(180deg);
        }

        .pokedex:hover .pokedex-right-back,
        .pokedex .pokedex-right-back {
            transform: rotateY(0);
        }

        .pokedex-left {
            background: var(--red);
            height: inherit;
            width: inherit;
            border-radius: 10px 0 0 10px;
            border: 1px solid black;
            border-right: 10px solid black;
            box-sizing: border-box;
            padding: 30px;
        }

        .pokedex-right-front {
            background: var(--red);
            height: calc(100% - 6rem);
            width: inherit;
            position: absolute;
            left: 0;
            right: 0;
            bottom: 0;
            transition: 1s;
            transform-origin: right center;
            z-index: 2;
            backface-visibility: hidden;
            border: 1px solid black;
            box-sizing: border-box;
            border-radius: 10px 0 0px 10px;
            border-left: 10px solid #9b0a21;
        }

        .pokedex-right-front:before {
            height: 5rem;
            position: absolute;
            bottom: 100%;
            background: var(--red);
            width: calc(100% - 9rem);
            right: 0;
            border-top: 1px solid black;
            content: '';
        }

        .pokedex-right-front:after {
            content: '';
            border-right: 2.5rem solid var(--red);
            border-bottom: 2.5rem solid var(--red);
            border-left: 2.5rem solid transparent;
            border-top: 2.5rem solid transparent;
            position: absolute;
            right: calc(100% - 9rem);
            bottom: 100%;
            filter: drop-shadow(0 -1px 0 black);
        }

        .pokedex-right-back {
            background: var(--red);
            height: calc(100% - 6rem);
            width: inherit;
            position: absolute;
            backface-visibility: hidden;
            transform: rotateY(-180deg);
            right: 0;
            bottom: 0;
            transition: 1s;
            left: 100%;
            transform-origin: left top;
            z-index: 1;
            border-width: 1px;
            border-style: solid;
            border-color: black;
            border-radius: 0 10px 10px 0;
            border-left: none;
            padding: 20px;
            box-sizing: border-box;
            display: flex;
        }


        .pokedex-right-back:before {
            width: calc(100% - 9rem);
            height: 5rem;
            position: absolute;
            bottom: 100%;
            background-color: var(--red);
            left: 0;
            border-top: 1px solid black;
            content: '';
        }

        .pokedex-right-back:after {
            content: '';
            border-left: 2.5rem solid var(--red);
            border-bottom: 2.5rem solid var(--red);
            border-top: 2.5rem solid transparent;
            border-right: 2.5rem solid transparent;
            display: block;
            width: 0;
            position: absolute;
            left: calc(100% - 9rem);
            bottom: 100%;
            filter: drop-shadow(0 -1px 0 black)
        }


        .light {
            border: 1px solid black;
            box-shadow: -2px 2px 0 rgba(255,255,255, .5);
            width: 20px;
            height: 20px;
            background: gray;
            border-radius: 50%;
        }

        .light.is-animated {
            animation: .3s light linear infinite;
        }

        @keyframes light {
            0% {
                background-color: white;
            }
            50% {
                background-color: var(--sky);
            }
            100% {
                background-color: white;
            }
        }

        .light.is-big {
            width: 50px;
            height: 50px;
        }

        .light.is-medium {
            width: 40px;
            height: 40px;
        }
        .light.is-large {
            width: 80px;
            border-radius: 20px;
        }

        .light.is-red {
            background-color: var(--red);
        }
        .light.is-blue {
            background-color: var(--blue);
        }
        .light.is-green {
            background-color: var(--green);
        }
        .light.is-sky {
            background-color: var(--sky);
        }
        .light.is-orange {
            background-color: var(--orange);
        }

        .light.is-yellow {
            background-color: var(--yellow);
        }

        .pokedex-left-top {
            display: flex;
            align-items: flex-start;
        }

        .pokedex-left-top > * {
            margin-right: .7em;
        }

        .pokedex-left-center {
            background: #b0b0b0;
            border-radius: 10px 10px 10px 10px;
            border: 1px solid black;
            margin: 40px 0;
            padding: 1em;
        }

        .pokedex-left-bottom-lights {
            display: flex;
            align-items: flex-start;

        }

        .pokedex-left-bottom {
            margin-top: 1em;
        }

        .pokedex-left-bottom-lights  > * {
            margin-right: .8em;
        }

        .nameHolder p {
            font-family: 'Press Start 2P';
            padding: 10px;
            background-color: white;
            color: black;
            border: none;
            border: 1px solid black;
            border-radius: 10px;
            outline: 0;
            font-size: 1em;
            flex-grow: 1;
            transition: .2s;
        }


        .pokedex-stats {
            background-color: white;
            padding: 10px; /* Riduci il padding per rendere il grafico più piccolo */
            flex-grow: 0; /* Impedisci al contenitore di espandersi */
            width: 420px; /* Imposta una larghezza fissa */
            height: 205px; /* Imposta un'altezza fissa */
            position: absolute; /* Imposta la posizione assoluta */
            top: 25px; /* Sposta il grafico in alto */
            left: 10px; /* Sposta il grafico a sinistra */
            border: 3px solid black;
            border-radius: 10px;
        }
    </style>
</head>
<body>
<div style="position: absolute; top: 0; left: 0;">
        <button style="width: 300px; height: 100px; border: none; background-color: transparent;">
            <a href="index.html">
                <img src="PokemonChips/pokemonLogo.png" alt="pokedex background" style="max-width: 100%; max-height: 100%; background-color: transparent;">
            </a>
    </div>
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
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String searchName1 = request.getParameter("searchName1");
        String searchName2 = request.getParameter("searchName2");

        PreparedStatement statement = connection.prepareStatement("SELECT * FROM prova WHERE name LIKE '%" + searchName1 + "%';");
        ResultSet resultSet = statement.executeQuery();

        if (resultSet.next()) {
            String pokemonName = resultSet.getString("name");

            String type_1 = resultSet.getString("type_1");
            String type_2 = resultSet.getString("type_2");

            int hp = resultSet.getInt("hp");
            int pokemonId = resultSet.getInt("number");
            int attack = resultSet.getInt("attack");
            int defence = resultSet.getInt("defense");
            int speed = resultSet.getInt("speed");
            int specialATK = resultSet.getInt("Sp_Atk");
            int specialDEF = resultSet.getInt("Sp_Def");
            int total = resultSet.getInt("total");
            String image = resultSet.getString("image_url");
            int next = resultSet.getInt("next");
            int max = Math.max(hp, Math.max(attack, Math.max(defence, Math.max(speed, Math.max(specialATK, specialDEF)))));
            float hpPerc = (hp * 100)/ max;
            float attackPerc = (attack * 100)/ max;
            float defencePerc = (defence * 100)/ max;
            float speedPerc = (speed * 100)/ max;
            float specialATKPerc = (specialATK * 100)/ max;
            float specialDEFPerc = (specialDEF * 100)/ max;

            PreparedStatement statement1;
            ResultSet resultSet1;

                statement1 = connection.prepareStatement("SELECT * FROM prova WHERE name LIKE '%" + searchName2 + "%';");
                resultSet1 = statement1.executeQuery();

                if (resultSet1.next()) {
                    String pokemonName1 = resultSet1.getString("name");

                    String type_11 = resultSet1.getString("type_1");


                    String type_21 = resultSet1.getString("type_2");

                    int hp1 = resultSet1.getInt("hp");
                    int pokemonId1 = resultSet1.getInt("number");
                    int attack1 = resultSet1.getInt("attack");
                    int defence1 = resultSet1.getInt("defense");
                    int speed1 = resultSet1.getInt("speed");
                    int specialATK1 = resultSet1.getInt("Sp_Atk");
                    int specialDEF1 = resultSet1.getInt("Sp_Def");
                    int total1 = resultSet1.getInt("total");
                    String image1 = resultSet1.getString("image_url");
%>
<div style="display: flex; flex-flow: row; justify-content: center; align-content: center;">
    <div class="pokedex" style="margin-right: 600px">
        <div class="pokedex-left">
            <div class="pokedex-left-top">
                <div class="light is-sky is-big" id="light"></div>
                <div class="light is-red"></div>
                <div class="light is-yellow"></div>
                <div class="light is-green"></div>
            </div>
            <div class="pokedex-left-center">
                <div class="pokedex-screen" id="screen">
                    <img src=" <%= image%>" alt="" id="image" style="width: 200px; height: 200px; margin-top: -50px">
                </div>
            </div>
            <div class="mt-1 flex w-full" style="display: flex; align-items: center; margin-top: 20px; margin-left: 25px; justify-items: center; position: absolute">
                <img src="PokemonChips/<%= type_1 %>.png" alt="type 1" style="width: 100px; margin-top: -30px; margin-left: 20px"/>
                <% if (!Objects.equals(type_2, "Blank")) { %>
                <img src="PokemonChips/<%= type_2 %>.png" alt="type 2" style="width: 100px; margin-top: -30px;"/>
                <% } %>
            </div>
            <div class="pokedex-left-bottom">
                <div class="pokedex-left-bottom-lights">
                    <div class="light is-blue is-medium"></div>
                    <div class="light is-green is-large"></div>
                    <div class="light is-orange is-large"></div>
                </div>
                <div class="nameHolder">
                    <p class="PokeText"> <%= pokemonName %> </p>
                </div>


                <div style="display: flex; justify-content: center; margin-top: 20px;">
                    <p class="text-lg text-center" style="font-size: 30px; font-family: 'Press Start 2P'" >
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
            </div>
        </div>
        <div class="pokedex-right-front">
        </div>
        <div class="pokedex-right-back">

            <div class="pokedex-description">

            </div>

            <div class="stats">
                <table>
                    <tr>
                        <td>Hp</td>
                        <%
                            String color = "green";
                            if (hp < hp1){
                                color = "red";
                            } else {
                                color = "green";
                            }
                        %>
                        <td style="color: <%= color%>"><%= hp %></td>
                    </tr>
                    <tr>
                        <td>Attack</td>
                        <%
                            if (attack < attack1){
                                color = "red";
                            } else {
                                color = "green";
                            }
                        %>
                        <td style="color: <%= color%>"><%= attack %></td>
                    </tr>
                    <tr>
                        <td>Defense</td>
                        <%
                            if (defence < defence1){
                                color = "red";
                            } else {
                                color = "green";
                            }
                        %>
                        <td style="color: <%= color%>"><%= defence %></td>
                    </tr>
                    <tr>
                        <td>Speed</td>
                        <%
                            if (speed < speed1){
                                color = "red";
                            } else {
                                color = "green";
                            }
                        %>
                        <td style="color: <%= color%>"><%= speed %></td>
                    </tr>
                    <tr>
                        <td>Special Attack</td>
                        <%
                            if (specialATK < specialATK1){
                                color = "red";
                            } else {
                                color = "green";
                            }
                        %>
                        <td style="color: <%= color%>"><%= specialATK %></td>
                    </tr>
                    <tr>
                        <td>Special Defense</td>
                        <%
                            if (specialDEF < specialDEF1){
                                color = "red";
                            } else {
                                color = "green";
                            }
                        %>
                        <td style="color: <%= color%>"><%= specialDEF %></td>
                    </tr>
                </table>
                <%
                    if (total < total1){
                        color = "red";
                    } else {
                        color = "green";
                    }
                %>
                <h1 class="PokeText" style="font-size: 30px; margin-top: 5px;">Total <span style="color: <%= color%>"> <%= total %> </span></h1>
            </div>
        </div>
    </div>
    <div class="pokedex" id="pokedex">
        <div class="pokedex-left">
            <div class="pokedex-left-top">
                <div class="light is-sky is-big" class="light"></div>
                <div class="light is-red"></div>
                <div class="light is-yellow"></div>
                <div class="light is-green"></div>
            </div>
            <div class="pokedex-left-center">
                <div class="pokedex-screen" class="screen" style="background: white url('TypeBackground/<%= type_11 %>BG.png'   ) center;">
                    <img src="<%= image1%>" alt="" class="image" style="width: 200px; height: 200px; margin-top: -50px">
                </div>
            </div>
            <div class="mt-1 flex w-full" style="display: flex; align-items: center; margin-top: 20px; margin-left: 25px; justify-items: center; position: absolute">
                <img src="PokemonChips/<%= type_11 %>.png" alt="type 1" style="width: 100px; margin-top: -30px; margin-left: 20px"/>
                <% if (!Objects.equals(type_21, "Blank")) { %>
                <img src="PokemonChips/<%= type_21 %>.png" alt="type 2" style="width: 100px; margin-top: -30px;"/>
                <% } %>
            </div>
            <div class="pokedex-left-bottom">
                <div class="pokedex-left-bottom-lights">
                    <div class="light is-blue is-medium"></div>
                    <div class="light is-green is-large"></div>
                    <div class="light is-orange is-large"></div>
                </div>
                <div class="nameHolder">
                    <p class="PokeText"> <%= pokemonName1 %> </p>
                </div>


                <div style="display: flex; justify-content: center; margin-top: 20px;">
                    <p class="text-lg text-center" style="font-size: 30px; font-family: 'Press Start 2P'" >
                        <%
                            String msg1;
                            if (pokemonId1 < 10) {
                                msg1 = "000" + pokemonId1;
                            } else if (pokemonId1 < 100) {
                                msg1 = "00" + next;
                            } else if(pokemonId1 < 1000){
                                msg1 = "0" + pokemonId1;
                            } else {
                                msg1 = String.valueOf(pokemonId1);
                            }
                        %>
                        #<%= msg1 %>
                    </p>
                </div>
            </div>
        </div>
        <div class="pokedex-right-front">
        </div>
        <div class="pokedex-right-back">

            <div class="pokedex-description">

            </div>

            <div class="stats">
                <table>
                    <tr>
                        <td>Hp</td>
                        <%
                            if (hp > hp1){
                                color = "red";
                            } else {
                                color = "green";
                            }
                        %>
                        <td class="<%= color %>"><%= hp1 %></td>
                    </tr>
                    <tr>
                        <td>Attack</td>
                        <%
                            if (attack > attack1){
                                color = "red";
                            } else {
                                color = "green";
                            }
                        %>
                        <td class="<%= color %>"><%= attack1 %></td>
                    </tr>
                    <tr>
                        <td>Defense</td>
                        <%
                            if (defence > defence1){
                                color = "red";
                            } else {
                                color = "green";
                            }
                        %>
                        <td class="<%= color %>"><%= defence1 %></td>
                    </tr>
                    <tr>
                        <td>Speed</td>
                        <%
                            if (speed > speed1){
                                color = "red";
                            } else {
                                color = "green";
                            }
                        %>
                        <td class="<%= color %>"><%= speed1 %></td>
                    </tr>
                    <tr>
                        <td>Special Attack</td>
                        <%
                            if (specialATK > specialATK1){
                                color = "red";
                            } else {
                                color = "green";
                            }
                        %>
                        <td class="<%= color %>"><%= specialATK1 %></td>
                    </tr>
                    <tr>
                        <td>Special Defense</td>
                        <%
                            if (specialDEF > specialDEF1){
                                color = "red";
                            } else {
                                color = "green";
                            }
                        %>
                        <td class="<%= color %>"><%= specialDEF1 %></td>
                    </tr>
                </table>
                <%
                    if (total > total1){
                        color = "red";
                    } else {
                        color = "green";
                    }
                %>
                <h1 class="PokeText" style="font-size: 30px; margin-top: 5px;">Total <span style="color: <%= color%>"> <%= total1 %> </span></h1>
            </div>
        </div>
    </div>
</div>

<style>
    table {
        width: 100%;
        border-collapse: collapse;
    }

    th, td {
        padding: 12px; /* Aumento del padding per adattarsi al testo più grande */
        text-align: left;
    }

    th {
        background-color: #f2f2f2;
    }

    td {
        font-weight: bold;
        font-size: 25px; /* Aumento della dimensione del testo */
    }

    h1.PokeText {
        font-size: 36px; /* Aumento della dimensione del testo */
        margin-top: 10px;
    }

    /* Colori per i valori rossi e verdi */
    td.red {
        color: red;
    }

    td.green {
        color: green;
    }

    /* Rimuovi i bordi esterni */
    table {
        border: none;
    }

    /* Aggiungi bordi interni */
    table tr:not(:last-child) td {
        border-bottom: 1px solid #ddd;
    }

</style>

<%
        }
%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js"></script>
<script src="script.js"></script>
<style>
    body{
        background-image: url("TypeBackground/pokemonConfrontoBG.png");
        background-size: cover;
        background-repeat: no-repeat;
    }

    .progress-bar {
        margin-top: 5px;
        width: 300px;
        height: 25px;
        border-radius: 5px;
        background-color: RGB(0,0,0,0);
        color: rgba(0, 0, 0, 0.7);
        display: flex;
    }

    .valueN{
        margin-right: 10px;
    }

    .progress-barHp-fill {
        width: <%= hpPerc %>%;
        display: flex;
        justify-content: right;
        align-items: center;
        height: 100%;
        border-radius: 0px 10px 10px 0px;
    }

    .progress-barAttack-fill {
        width: <%= attackPerc %>%;
        display: flex;
        justify-content: right;
        align-items: center;
        height: 100%;
        border-radius: 0px 10px 10px 0px;
    }

    .progress-barDefence-fill {
        width: <%= defencePerc %>%;
        display: flex;
        justify-content: right;
        align-items: center;
        height: 100%;
        border-radius: 0px 10px 10px 0px;
    }

    .progress-barSpeed-fill {
        width: <%= speedPerc %>%;
        display: flex;
        justify-content: right;
        align-items: center;
        height: 100%;
        border-radius: 0px 10px 10px 0px;
    }

    .progress-barSpecialATK-fill {
        width: <%= specialATKPerc %>%;
        display: flex;
        justify-content: right;
        align-items: center;
        height: 100%;
        border-radius: 0px 10px 10px 0px;
    }

    .progress-barSpecialDEF-fill {
        width: <%= specialDEFPerc %>%;
        display: flex;
        justify-content: right;
        align-items: center;
        height: 100%;
        border-radius: 0px 10px 10px 0px;
    }

    .first-half{
        width: 60px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 10px 0px 0px 10px;
    }
    .stats {
        background-color: white;
        border-radius: 10px;
        border: 3px solid black;
        width: 440px;
        height: 500px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        color: rgba(0, 0, 0, 0.7);
        align-items: center;
        margin-left: -10px;
    }

    .PokeText{
        font-weight: bold;
    }

    .pokedex-screen {
        border: 2px solid black;
        border-radius: 10px;
        height: 160px;
        display: flex;
        align-items: center;
        justify-content: center;
        background-size: cover;
        background: white url("TypeBackground/<%= type_1 %>BG.png") center;
        padding: 15px;
    }
</style>

<img src="TypeBackground/pokemonConfrontoBG.png" alt="<%= type_1 %>" crossorigin id="PokemonImage" style="display: none">
<%
        } else {

        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</body>
</html>
