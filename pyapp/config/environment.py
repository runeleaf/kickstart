import os
import yaml

def database():
   yaml_path=os.path.join(os.path.dirname(__file__), "database.yml")
   string = open(yaml_path).read()
   string = string.decode('utf8')
   data = yaml.load(string)
   mode = None
   if os.getenv("SERVER_NAME") == 'localhost':
      mode = 'development'
   elif os.getenv("SERVER_NAME") == 'runeleaf.net':
      mode = 'production'
   else:
      mode = 'development'

   return data[mode]

def settings():
   data = dict(
         debug=True,
         title="test",
         template_path=os.path.join(os.path.dirname(__file__), "../views"),
         static_path=os.path.join(os.path.dirname(__file__), "../static"),
   )
   return data

