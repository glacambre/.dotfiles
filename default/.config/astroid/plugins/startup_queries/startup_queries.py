import subprocess
import functools
import gi
gi.require_version ('Astroid', '0.2')
from gi.repository import GObject, Astroid

print ("startupqueries: plugin loading..")

def zip_flatten (l1, l2):
    return [t for tuple in (zip(l1, l2)) for t in tuple]

def tags_as_queries (tags):
    return map(lambda t : "tag:" + t, tags)

def tags_and_queries (tags):
    return zip_flatten(tags, tags_as_queries(tags))

class StartupQueriesPlugin (GObject.Object, Astroid.Activatable):
  object = GObject.property (type=GObject.Object)

  def do_activate (self):
    print ('activated startup queries')

  def do_deactivate (self):
    print ('deactivated startup queries')

  def do_get_queries (self):
    notmuch = subprocess.run(["notmuch", "search", "--output=tags", "*"], capture_output=True)
    
    important_tags= ["unread"]
    notmuch_tags = list(map(lambda s: s.decode("ascii"), notmuch.stdout.strip().split(b"\n")))
    uninteresting_tags = ["archive", "attachment", "replied", "signed", "unread"]
    
    normal_not_important = list(filter(lambda x: x not in important_tags, notmuch_tags))
    normal_not_uninteresting = list(filter(lambda x: x not in uninteresting_tags, normal_not_important))
    
    result = []
    result += ["untagged"] + ["not (" + functools.reduce(lambda acc, t: acc + " or " + t, tags_as_queries(normal_not_uninteresting)) + ")"]
    result += tags_and_queries(important_tags)
    result += tags_and_queries(normal_not_uninteresting)
    result += tags_and_queries(uninteresting_tags)

    print(result)
    return result

