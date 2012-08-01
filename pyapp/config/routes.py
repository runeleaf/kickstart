import handler.dashboard
import handler.snippets

def mapping():
   lists = [
         (r"/", handler.dashboard.DashboardHandler),
         (r"/snippets/([0-9]+)", handler.snippets.SnippetsHandler),
   ]
   return lists

