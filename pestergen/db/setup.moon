-- pestergen.db.setup
import config               from require "pestergen.config"
import sql                  from require "grasp.query"
import database, run, close from require "pestergen.db.init"
import errorFor             from require "grasp"

statements = {
  -- -- users
  -- sql -> create "users", -> columns:
  --   username: "TEXT NOT NULL UNIQUE"
  --   password: "TEXT NOT NULL"
  --   scope:    "TEXT NOT NULL"

  -- -- tokens
  -- sql -> create "tokens", -> columns:
  --   token: "TEXT NOT NULL UNIQUE"
  --   scope: "TEXT NOT NULL"
  -- sql -> insert into "tokens", -> values:
  --   token: "AAAAA"
  --   scope: "scope:admin"

  -- logs
  sql -> create "logs", -> columns:
    nid:    "TEXT NOT NULL UNIQUE"
    title:  "TEXT"
    next:   "TEXT"
    panel:  "TEXT"
    type:   "TEXT"
    nextid: "TEXT"
    islog:  "INTEGER"
  
  sql -> 
    replace into "logs", -> 
      values:
        nid:    "homepage"
        title:  "Welcome!"
        next:   ""
        panel:  "/static/panels/homepage/homegif.gif"
        type:   "image/gif"
        nextid: ""
        islog:  0
}

for statement in *statements
  print statement
  unless run statement
    code, message = errorFor database
    error "Could not setup: [[#{statement}]] - (#{code}) #{message}"
    close!

close!