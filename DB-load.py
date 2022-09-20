#-----------------------------------------------
# SQL Server load from web api
# Source of information: https://pokeapi.co
# Mauro Imamura - 2022
#-----------------------------------------------

import requests
import pyodbc
import connection as c_s

def Main():
      final_index = 152
      conn = pyodbc.connect(c_s.Connection_string())
      ClearSTG(conn)
      for i in range(1, final_index):
            #request from API
            data = Request(i)
            #query and load to DB
            Load(data, conn)
      RunProc(conn)
      conn.close()
      
def Request(i):
      url = f'https://pokeapi.co/api/v2/pokemon/{i}/'
      response = requests.get(url)
      if(response.status_code == 200):
            response_json = response.json()
            name = response_json['name']
            print(name)
            i_id = response_json['id']
            types = []
            height = response_json['height'] #int
            weight = response_json['weight'] #int
            for j_type in response_json['types']:
                  types.append(j_type['type']['name'])
            sprite = response_json['sprites']['front_default']
      return dict({'id': i_id, 'name': name, 'height': height, 'weight': weight, 'types': types, 'picture': sprite})

def Load(data, conn):
      query_pok = f'''INSERT INTO stg.pokemon ("id_pokemon", "name", "height_dm", "weight_hg", "picture")
                       VALUES({data["id"]}, '{data["name"]}', {data["height"]}, {data["weight"]}, '{data["picture"]}')
                     '''
      cursor = conn.cursor()
      cursor.execute(query_pok)
      for t in data["types"]:
            query_types = f'''INSERT INTO stg.types ("id_pokemon", "type")
                 VALUES({data["id"]}, '{t}')
               '''
            cursor.execute(query_types)
      cursor.commit()
      return

def ClearSTG(conn):
      trunc_pok = f'TRUNCATE TABLE stg.pokemon'
      trunc_types = f'TRUNCATE TABLE stg.types'
      cursor = conn.cursor()
      cursor.execute(trunc_pok)
      cursor.execute(trunc_types)
      cursor.commit()
      return

def RunProc(conn):
      proc_pok = f'EXEC dbo.pokemon_load'
      proc_types = f'EXEC dbo.types_load'
      cursor = conn.cursor()
      cursor.execute(proc_pok)
      cursor.execute(proc_types)
      cursor.commit()
      return

Main()
