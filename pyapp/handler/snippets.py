#!/usr/bin/env python

import handler.base

class SnippetsHandler(handler.base.BaseHandler):
   def get(self, snippet_id):
      self.write("You requested the snippet " + snippet_id)


