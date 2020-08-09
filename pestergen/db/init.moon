-- pestergen.db
import config from require "pestergen.config"
grasp            = require "grasp"

assert config.pestergen.db,          "Database configuration not found"
assert config.pestergen.db.location, "Database location not specified"
db = grasp.Database config.pestergen.db.location

{
  database:    db
  run:         grasp.update db
  close:    -> grasp.close db
}