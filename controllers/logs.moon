-- pestergen.controllers.logs
import database      from require "pestergen.db.init"
import sql           from require "grasp.query"
{dump: dumpTable}       = require "serpent"
grasp                   = require "grasp"
nanoid                  = require "nanoid"

first = (t) ->
  expect 1, t, {"table"}
  t[1] or false

unbool = (num) -> num == 1

class Log
  squery:    grasp.squery   database
  update:    grasp.update   database
  lastError: grasp.errorFor database
  close:     => grasp.close database

  -- takes the parsed log content, saves it into a file, stores the location and nid
  -- alternatively, takes a nid, and loads it from a file
  new: (content, thisnid, title, next_, panel, type_, nnid, islog) =>
    expect 1, content, {"string", "table"}
    -- create a new log
    if "table" == type content
      nid       = thisnid or nanoid 10
      @location = "static/logs/#{nid}.lua"
      with io.open @location, "w"
        \write dumpTable content
        \close!
      ok = @.update sql -> insert into "logs", -> values:
        :nid, :title, next: next_, :panel, type: type_, nextid: nnid, islog: (islog and 1 or 0)
      return @.lastError! unless ok
      --
      @nid     = nid
      @content = content
      @title   = title
      @next    = next_
      @panel   = panel
      @type    = type_
      @nextid  = nnid
      @islog   = islog
    -- get log
    else
      nid  = content
      this = @.squery sql -> select "*", ->
        From "logs"
        where :nid
      error "Log not found" unless "table" == typeof this
      --
      this      = first this
      @nid      = nid
      @location = "static/logs/#{@nid}.lua"
      @content  = loadfile @location
      @title    = this.title
      @next     = this.next
      @panel    = this.panel
      @type     = this.type
      @nextid   = this.nextid
      @islog    = this.islog

  -- deletes a log
  delete: =>
    fs.delete @location if fs.exists @location
    fs.delete @panel    if fs.exists @panel
    ok = @.update sql -> delete ->
      From "logs"
      where nid: @nid

-- list all logs
listLogs = -> (grasp.squery database) sql -> select "*", -> From "logs"

{ :Log, :listLogs }