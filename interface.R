install.packages("RPostgreSQL")
require ("RPostgreSQL")
install.packages("shiny")
install.packages("shinythemes")
library(shiny)
library(shinythemes)

drv <- dbDriver ("PostgreSQL")
pw <- {
  "oreo"
}
con <- dbConnect ( drv , dbname = "postgres",
                   host = "localhost", port = 5432,
                   user = "postgres", password = pw )

spr_dost <- dbGetQuery ( con , "SELECT * FROM spr_dost('1/02/2019', '7/02/2019');")

server <- function ( input , output ){}

ui <-fluidPage(
  theme=shinytheme("darkly"),
  titlePanel("One Way Ticket - Biuro Podróży", ),
  tabsetPanel(tabPanel("HOTELE",
                       sidebarLayout(
                         sidebarPanel(
                           actionButton(inputId = "pokaz_hotele", label = "OFERTA HOTELI"),
                           actionButton(inputId = "spr_szczegóły", label = "SPRAWDŹ SZCZEGÓŁY", icon("paper-plane"), style="color: #fff; background-color: #337ab7")
                         ),
                         mainPanel(
                           dataTableOutput(outputId = 'hotele1'),
                           dataTableOutput(outputId = 'spr_szczegóły1')
                         )
                       )),
              tabPanel("POKOJE",
                       sidebarLayout(
                         sidebarPanel(
                           actionButton(inputId = "pokaz_pokoje", label="WERSJE POKOJÓW"),
                           actionButton(inputId = "pokaz_dostepnosc", label="DOSTĘPNOŚĆ POKOJÓW"),
                           actionButton(inputId = "spr_dost", label="SPRAWDŹ DOSTĘPNOŚĆ", icon("paper-plane"), style="color: #fff; background-color: #337ab7")
                         ),
                         mainPanel(
                           dataTableOutput(outputId = "pokoje1"),
                           dataTableOutput(outputId = "dostępność1"),
                           dataTableOutput(outputId = "spr_dost1")
                         )
                       )),
              tabPanel("KLIENCI",
                       sidebarLayout(
                         sidebarPanel(
                           actionButton(inputId = "pokaz_klientów", label="DANE KLIENTÓW"),
                           actionButton(inputId = "pokaz_płatności", label="FORMY PŁATNOŚCI"),
                           actionButton(inputId = "nowy_klient", label="NOWY KLIENT", icon("paper-plane"), style="color: #fff; background-color: #337ab7"),
                           actionButton(inputId = "update_user", label="ZAKTUALIZUJ DANE", icon("paper-plane"), style="color: #fff; background-color: #337ab7")
                         ),
                         mainPanel(
                           dataTableOutput(outputId = "klienci1"),
                           dataTableOutput(outputId = "płatności1"),
                           textOutput(outputId = "nowy_klient1"),
                           textOutput(outputId = "update_user1")
                         )
                       )),
              tabPanel("SZCZEGÓŁY OFERTY",
                       sidebarLayout(
                         sidebarPanel(
                           actionButton(inputId="pokaz_transport", label="TRANSPORT"),
                           actionButton(inputId="pokaz_wyżywienie", label="WYŻYWIENIE")
                         ),
                         mainPanel(
                           dataTableOutput(outputId = "transport1"),
                           dataTableOutput(outputId = "wyżywienie1")
                         )
                         )
                       ))
                         )


hotele <- dbGetQuery(con , "SELECT * FROM hotel;")
spr_szczegoly <- dbGetQuery(con, "CREATE OR REPLACE FUNCTION spr_szczegoly(nazwa_hotelu TEXT)
                            RETURNS TABLE (id_oferty TEXT, wyzywienie TEXT, cena INTEGER)
                            AS $$
                              BEGIN
                            RETURN QUERY SELECT szczegoly_oferty.id_oferty, szczegoly_oferty.wyzywienie, szczegoly_oferty.cena
                            FROM szczegoly_oferty
                            WHERE szczegoly_oferty.id_oferty LIKE nazwa_hotelu;
                            END; $$
                              LANGUAGE plpgsql;")
pokoje <- dbGetQuery(con, "SELECT * FROM pokoje;")
dostępność <- dbGetQuery(con, "SELECT * FROM dostepnosc;")
spr_dost <- dbGetQuery(con, "CREATE OR REPLACE FUNCTION spr_dost (data_p DATE, data_k DATE)
                       RETURNS TABLE (id_pokoju TEXT, nazwa_hotelu TEXT, cena_pokoju INTEGER) AS $$
                         BEGIN
                       RETURN QUERY SELECT id_pokoju, pokoje.nazwa_hotelu, pokoje.cena_pokoju
                       FROM pokoje NATURAL JOIN dostepnosc
                       WHERE poczatek = data_p AND koniec = data_k AND czy_dostepne='y';
                       END; $$
                         LANGUAGE plpgsql;")
klient <- dbGetQuery(con, "SELECT * FROM klient;")
płatności <- dbGetQuery(con, "SELECT * FROM platnosc;")
nowy_klient <- dbGetQuery(con, "CREATE OR REPLACE FUNCTION Nowy_klient (id_klienta INT, nazwisko TEXT, nr_telefonu VARCHAR(9), nazwa_hotelu TEXT)
                          RETURNS TEXT AS $$
                            BEGIN
                          INSERT INTO klient VALUES(id_klienta, nazwisko, nr_telefonu, nazwa_hotelu);
                          RETURN 'Dodano nowego klienta';
                          END;
                          $$LANGUAGE 'plpgsql';")
update_user <- dbGetQuery(con, "CREATE OR REPLACE FUNCTION update_user (podaj_id_klienta INTEGER, nowe_nazwisko TEXT, nowy_nr_telefonu CHARACTER VARYING,nowy_hotel TEXT)
                          RETURNS TEXT AS $$
                            BEGIN 
                          UPDATE klient 
                          SET nazwisko=nowe_nazwisko,
                          nr_telefonu=nowy_nr_telefonu,
                          nazwa_hotelu=nowy_hotel
                          WHERE klient.id_klienta=podaj_id_klienta;
                          RETURN 'Zaktualizowano informacje';
                          END; 
                          $$LANGUAGE plpgsql;")
transport <- dbGetQuery(con, "SELECT * FROM transport;")
wyżywienie <- dbGetQuery(con, "SELECT * FROM szczegoly_oferty;")

server <- function(input, output) { 
  output$hotele1 = renderDataTable({
    hotele
  })
  output$spr_szczegóły1 = renderDataTable({
    spr_szczegoly
  })
  output$pokoje1 = renderDataTable({
    pokoje
  })
  output$dostępność1 = renderDataTable({
    dostępność
  })
  output$spr_dost1 = renderDataTable({
    spr_dost
  })
  output$klienci1 = renderDataTable({
    klient
  })
  output$płatności1 = renderDataTable({
    płatności
  })
  output$nowyklient1 = renderText({
    nowy_klient
  })
  output$update_user1 = renderText({
    update_user
  })
  output$transport1 = renderDataTable({
    transport
  })
  output$wyżywienie1 = renderDataTable({
    wyżywienie
  })
  }




shinyApp(ui=ui, server=server)

