#!/usr/bin/env python

import os.path
import tornado.auth
import tornado.database
import tornado.httpserver
import tornado.ioloop
import tornado.options
import tornado.web
import unicodedata

from tornado.options import define, options

#import user handler(imported resource, model, service, helper)
import config.routes
import config.environment

define("port", default=8888, help="", type=int)

class Application(tornado.web.Application):
   def __init__(self):
      handlers = config.routes.mapping()
      settings = config.environment.settings()
      tornado.web.Application.__init__(self, handlers, **settings)
      con = config.environment.database()
      self.db = tornado.database.Connection(
            host=con['host'],
            database=con['database'],
            user=con['user'],
            password=con['password'])


def main():
    tornado.options.parse_command_line()
    http_server = tornado.httpserver.HTTPServer(Application())
    http_server.listen(options.port)
    tornado.ioloop.IOLoop.instance().start()


if __name__ == "__main__":
    main()

