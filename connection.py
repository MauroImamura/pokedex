#-----------------------------------------------
# Setup for connection with DB
# Mauro Imamura - 2022
#-----------------------------------------------

import pyodbc 

def Connection_string():
      server_name = ""
      database = ""
      driver = "{SQL Server}"
      conn = f'Driver={driver};Server={server_name};Database={database};Trusted_Connection=yes;'
      return conn
