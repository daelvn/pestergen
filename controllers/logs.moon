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
  new: (this) =>
    expect 1, this, {"table"}
    -- create new
    if this.content
      -- set params
      @[k] = v for k, v in pairs this
      @nid      or= nanoid 10
      @location or= "static/logs/#{@nid}.lua"
      -- save messages
      with io.open @location, "w"
        \write dumpTable this.content
        \close!
      -- insert log
      pairs = pairs
      ok = @.update sql -> insert into "logs", -> values: {k, v for k, v in pairs this when k != "content"}
      return @.lastError! unless ok
      --
      return this
    -- get log
    else
      nid = this.nid
      qry = @.squery sql -> select "*", ->
        From "logs"
        where :nid
      error "Log not found" unless "table" == typeof qry
      --
      @[k] = v for k, v in pairs first qry
      @nid      = nid
      @location = "static/logs/#{@nid}.lua"
      @content  = loadfile @location

  -- deletes a log
  delete: =>
    fs.delete @location if fs.exists @location
    fs.delete @panel    if fs.exists @panel
    ok = @.update sql -> delete ->
      From "logs"
      where nid: @nid

-- list all logs
listLogs = -> (grasp.squery database) sql -> select "*", -> From "logs"

-- gets a log page
pageLogs = (pagen, pagesize) -> (grasp.squery database) "SELECT * FROM 'logs' LIMIT #{pagesize} OFFSET #{pagen*pagesize}"

-- count logs
countLogs = -> ((grasp.squery database) "select Count(*) from logs;")[1]["Count(*)"]

{ :Log, :listLogs, :countLogs, :pageLogs }