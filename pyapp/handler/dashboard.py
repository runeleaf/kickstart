#!/usr/bin/env python

import handler.base

class DashboardHandler(handler.base.BaseHandler):
   def get(self):
      self.render("dashboard.html")

