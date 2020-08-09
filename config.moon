config = require "lapis.config"

config {"development", "production"}, ->
  bind_host    "0.0.0.0"
  session_name "pestergen_session"
  port          8080

  pestergen ->
    db ->
      backend  "grasp"
      location "pestergen.db"
    apps { "app" }

config "production", ->
  num_workers  4
  code_cache   "on"