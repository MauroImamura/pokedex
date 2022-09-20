# POKEDEX DATABASE
Pokemon database based on data from web API.

This set of scripts are a sample method for data acquisition from web api. The information is saved in a SQL Server DB.
The source of information about Pokemons is the PokeAPI, avaliable at <a href="https://pokeapi.co/">https://pokeapi.co/</a>

## Initial Setup

First of all, you need to install the libs using pip. For this project I'm using pip version 21.3.1
Run the installation command for requests and pyodbc as following:

>pip install requests==2.27.1

>pip install pyodbc==4.0.34

After installing it, you must create a new DB on SQL Server. Once you have it, you can run the queries in db_queries.sql file for creating the schema, tables and procedures that will be used. Although all the commands are in the same file, you might need to run them separately.

## Connection String

As you create the DB and tables, you'll be able to edit the connection.py file and fill the server and database names. Further information about authentication are not required here because the project was build for Windows Authentication on SQL Server. If you desire to use other options, set the connection string to provide all information needed.

## Running data load

Finally, after all the files and DB are ready, you can execute the main script DB-load. But, before doing it, it's important to pinpoint that the range of index is set to cover only the first generation of Pokemons (151). If you want to fill your DB with more species, you must edit the final_index parameter inside function Main.
