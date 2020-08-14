DEPENDENCIES = {
  "lapis", "moonscript", "openssl" -- lapis
  "argon2"                         -- security
  "filekit", "grasp", "serpent"    -- io
  "htmlparser", "discount"         -- parsing
  "inspect"                        -- debugging
  "nanoid"                         -- uuids
}

tasks:
  -- compile
  compile: (...) =>
    print style "%{blue}:%{white} Compiling files"
    flags = toflags ...
    if flags.noskip
      for file in wildcard "**.moon"
        continue if file\match "Alfons"
        moonc file
    else
      build (wildcard "**.moon"), (file) ->
        return if file\match "Alfons"
        moonc file

  -- clean
  clean: =>
    print style "%{blue}:%{white} Cleaning files"
    for file in wildcard "**.lua"
      unless file\match "homepage.lua"
        fs.delete file
    for dir in wildcard "*_temp"
      fs.delete dir
    for dir in wildcard "static/panels/*"
      continue if dir\match "homepage"
      continue if dir\match "%.dnd"
      fs.delete dir
    fs.delete "pestergen.db"
    fs.delete "nginx.conf.compiled"

  -- server
  server: =>
    print style "%{blue}:%{white} Running server"
    sh "lapis server development --trace"

  -- setup
  setup: =>
    print style "%{blue}:%{white} Setting up database"
    sh "moon pestergen/db/setup.moon"

  -- install dependencies
  install: (bin="luarocks") =>
    print style "%{blue}:%{white} Installng dependencies"
    for dep in *DEPENDENCIES
      print "==> installing dependency: #{dep}"
      sh "#{bin} install #{dep}"

  -- slow
  slow: =>
    print style "%{blue}:%{white} Running server (slow)..."
    tasks.clean!
    tasks.setup!
    --tasks.populate!
    tasks.compile "noskip"
    tasks.server!
  
  -- fast
  fast: =>
    print style "%{blue}:%{white} Running server (fast)..."
    tasks.compile!
    tasks.server!