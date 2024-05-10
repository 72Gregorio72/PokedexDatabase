<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="Scuola.Type" %>
<%@ page import="Scuola.DatabaseConnection" %>
<%@ page import="java.util.Objects" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="java.io.File" %>
<%@ page import="java.awt.*" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="PokemonChips/pokeball.png" />
    <title>Dettagli Pokemon</title>
</head>
    <body>
    <script>
        import React from 'react';
        import DisableZoom from './DisableZoom';

        const App = () => {
            return (
                <div>
                    <DisableZoom />
                    // Your app content goes here
                </div>
            );
        };

        export default App;
    </script>
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

            Connection connection = DatabaseConnection.getConnection();
            int pokemonId = Integer.parseInt(request.getParameter("PokemonID"));
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM prova WHERE number = " + pokemonId + ";");
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                String pokemonName = resultSet.getString("name");

                String type_1 = resultSet.getString("type_1");


                String type_2 = resultSet.getString("type_2");

                int hp = resultSet.getInt("hp");

                int attack = resultSet.getInt("attack");
                int defence = resultSet.getInt("defense");
                int speed = resultSet.getInt("speed");
                int specialATK = resultSet.getInt("Sp_Atk");
                int specialDEF = resultSet.getInt("Sp_Def");
                int total = resultSet.getInt("total");
                String image = resultSet.getString("image_url");
                int next = resultSet.getInt("next");
                int max = 150;
                float hpPerc = (hp * 100)/ max;
                float attackPerc = (attack * 100)/ max;
                float defencePerc = (defence * 100)/ max;
                float speedPerc = (speed * 100)/ max;
                float specialATKPerc = (specialATK * 100)/ max;
                float specialDEFPerc = (specialDEF * 100)/ max;
                %>
                    <style>
                        body{
                            background-image: url("TypeBackground/<%= type_1 %>BG.png");
                            background-size: cover;
                            background-repeat: no-repeat;
                        }

                        .progress-bar {
                            margin-top: 20px;
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
                        .stats{
                            background-color: white;
                            border-radius: 5px;
                            width: 350px;
                            height: 350px;
                            display: flex;
                            flex-direction: column;
                            justify-content: center;
                            color: rgba(0, 0, 0, 0.7);
                            align-items: center;
                        }

                        .PokeImg{
                            margin-left: 250px;
                            border-radius: 50%;
                            background-color: black;
                            height: 300px;
                            display: flex;
                            justify-content: center;
                            align-items: center;
                        }

                        .PokeText{
                        }
                    </style>
                <div style="display: flex; flex-flow: row; justify-items: center;">
                    <div style="display: flex; flex-flow: column;padding: 200px; justify-items: center">
                        <div style="background-color: white; border-radius: 5px; width: 400px; height: 200px; margin-bottom: 70px; display: flex; justify-items: center; align-items: center; overflow: hidden">
                            <h1 class="PokeText" style="margin-top: -90px; margin-left: 10px; position: absolute"><%= pokemonName %> <br> <%
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
                            </h1>
                            <div class="mt-1 flex w-full" style="display: flex; align-items: center; margin-top: 20px; margin-left: 25px; justify-items: center; position: absolute">
                                <img src="PokemonChips/<%= type_1 %>.png" alt="type 1" style="width: 100px"/>
                                <% if (!Objects.equals(type_2, "Blank")) { %>
                                <img src="PokemonChips/<%= type_2 %>.png" alt="type 2" style="width: 100px" />
                                <% } %>
                            </div>
                            <div class="PokeImg">
                                <img src="<%= image %>" alt="<%= pokemonName %>" width="200" height="200" style="margin-top: -100px">
                            </div>
                        </div>

                        <div class="stats">
                            <div class="progress-bar">
                                <div class="first-half">
                                    <p class="PokeText">Hp</p>
                                </div>

                                <div class="progress-barHp-fill">
                                    <p class="valueN"><%= hp %></p>
                                </div>

                            </div>


                            <div class="progress-bar">
                                <div class="first-half">
                                    <p class="PokeText">Atk</p>
                                </div>
                                <div class="progress-barAttack-fill">
                                    <p class="valueN"><%= attack %></p>
                                </div>

                            </div>

                            <div class="progress-bar">
                                <div class="first-half">
                                    <p class="PokeText">Def</p>
                                </div>
                                <div class="progress-barDefence-fill">
                                    <p class="valueN"><%= defence %></p>
                                </div>
                            </div>

                            <div class="progress-bar">
                                <div class="first-half">
                                    <p class="PokeText">Speed</p>
                                </div>
                                <div class="progress-barSpeed-fill">
                                    <p class="valueN"><%= speed %></p>
                                </div>
                            </div>

                            <div class="progress-bar">
                                <div class="first-half">
                                    <p class="PokeText">Sp_Atk</p>
                                </div>
                                <div class="progress-barSpecialATK-fill">
                                    <p class="valueN"><%= specialATK %></p>
                                </div>
                            </div>

                            <div class="progress-bar">
                                <div class="first-half">
                                    <p class="PokeText">Sp_Def</p>
                                </div>
                                <div class="progress-barSpecialDEF-fill">
                                    <p class="valueN"><%= specialDEF %></p>
                                </div>
                            </div>
                            <h1 class="PokeText">Total <%= total %></h1>
                        </div>
                    </div>
                    <%
                        Connection connection1 = DatabaseConnection.getConnection();
                        PreparedStatement statement1;
                        ResultSet resultSet1;
                        if(next != -1){
                            statement1 = connection1.prepareStatement("SELECT * FROM prova WHERE number = " + next + ";");
                            resultSet1 = statement1.executeQuery();
                            if (resultSet1.next()) {
                                String pokemonName1 = resultSet1.getString("name");

                                String type_11 = resultSet1.getString("type_1");


                                String type_21 = resultSet1.getString("type_2");

                                int hp1 = resultSet1.getInt("hp");

                                int attack1 = resultSet1.getInt("attack");
                                int defence1 = resultSet1.getInt("defense");
                                int speed1 = resultSet1.getInt("speed");
                                int specialATK1 = resultSet1.getInt("Sp_Atk");
                                int specialDEF1 = resultSet1.getInt("Sp_Def");
                                int total1 = resultSet1.getInt("total");
                                String image1 = resultSet1.getString("image_url");
                                int max1 = 150;
                                float hpPerc1 = (hp * 100)/ max;
                                float attackPerc1 = (attack * 100)/ max;
                                float defencePerc1 = (defence * 100)/ max;
                                float speedPerc1 = (speed * 100)/ max;
                                float specialATKPerc1 = (specialATK * 100)/ max;
                                float specialDEFPerc1 = (specialDEF * 100)/ max;
                    %>
                    <div style="background-color: white; border-radius: 5px; width: 400px; height: 200px; display: flex; justify-items: center; align-items: center; overflow: hidden; margin-top: 200px; margin-left: 500px">
                        <h1 class="PokeText" style="margin-top: -90px; margin-left: 10px; position: absolute"><%= pokemonName1 %> <br> <%
                            String msg1;
                            if (next < 10) {
                                msg1 = "000" + next;
                            } else if (pokemonId < 100) {
                                msg1 = "00" + next;
                            } else if(pokemonId < 1000){
                                msg1 = "0" + next;
                            } else {
                                msg1 = String.valueOf(next);
                            }
                        %>
                            #<%= msg1 %>
                        </h1>
                        <div class="mt-1 flex w-full" style="display: flex; align-items: center; margin-top: 20px; margin-left: 25px; justify-items: center; position: absolute">
                            <img src="PokemonChips/<%= type_11 %>.png" alt="type 1" style="width: 100px"/>
                            <% if (!Objects.equals(type_2, "Blank")) { %>
                            <img src="PokemonChips/<%= type_21 %>.png" alt="type 2" style="width: 100px" />
                            <% } %>
                        </div>
                        <form action="pokemon.jsp" method="post">
                            <button type="submit" name="PokemonID" value="<%= next%>">
                                <div class="PokeImg">
                                    <img src="<%= image1 %>" alt="<%= pokemonName1 %>" width="200" height="200" style="margin-top: -100px">
                                </div>
                            </button>
                        </form>

                    </div>
                </div>
                            <%
                            }
                        }
                        %>
                            <img src="TypeBackground/<%= type_1 %>BG.png" alt="<%= type_1 %>" width="100" height="100" crossorigin id="PokemonImage" style="display: none">
                            <%
                        } else {

                        }
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>

    <script src="script.js">
        document.addEventListener('gesturestart', function (e) {
            e.preventDefault();
        });

        window.addEventListener('wheel', function(e) {
            e.preventDefault();
        }, { passive: false });
    </script>
    <p><a href="index.jsp">Torna al pokedex</a></p>
    </body>
</html>
