#-----------------------------------------------
# SQL Server load from web api
# Source of information: https://pokeapi.co
# Mauro Imamura - 2022
#-----------------------------------------------

import requests
import pyodbc
import connection as c_s

def Main():
      conn = pyodbc.connect(c_s.Connection_string())
      final_index = 152
      for i in range(1, final_index):
            #request from API
            data = Request(i)
            #query and load to DB
            Load(data, conn)
      conn.close()
      
def Request(i):
      #for i in range(1,2):
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
      query = f'''INSERT INTO stg.pokemon ("id", "name", "height", "weight", "picture")
                       VALUES({data["id"]}, '{data["name"]}', {data["height"]}, {data["weight"]}, '{data["picture"]}')
                     '''
      cursor = conn.cursor()
      cursor.execute(query)
      cursor.commit()
      return

Main()
