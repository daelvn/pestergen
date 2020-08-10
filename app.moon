import config     from require "pestergen.config"
import respond_to from require "lapis.application"
import from_json  from require "lapis.util"
lapis                = require "lapis"
nanoid               = require "nanoid"

class App extends lapis.Application
  -- layout
  layout: require "views.layout"
  -- load other apps
  -- for app in *config.pestergen.apps
  --   @include "applications.#{app}"
  -- routes
  "/": =>
    render: "list"
  "/view/:nid": =>
    import Log from require "controllers.logs"
    pesterlog = Log @params.nid
    --
    @nid    = pesterlog.nid
    @title  = pesterlog.title
    @next   = pesterlog.next
    @panel  = pesterlog.panel
    @type   = pesterlog.type
    @nextid = pesterlog.nextid
    @log    = pesterlog.islog == 1
    -- render
    render: "view", layout: "homestuck"
  "/create": respond_to {
    GET: =>
      return render: "create"
    POST: =>
      -- messages              (as json)
      -- panel.content         (panel image data)
      -- panel.filename        (panel image filename)
      -- panel["content-type"] (panel image content type)
      -- title                 (panel title)
      -- next                  (text for next link)
      -- nextid                (next nid)
      -- messages to table
      messages = from_json @params.messages
      -- this nid
      nid = nanoid 10
      -- save panel, if exists
      local fname
      if @params.panel
        path  = "static/panels/#{nid}"
        fname = "#{path}/#{@params.panel.filename}"
        fs.makeDir path --unless fs.exists path
        with io.open fname, "w"
          \write @params.panel.content
          \close!
      -- save log
      import Log from require "controllers.logs"
      pesterlog = Log messages, nid, @params.title, @params.next, ("/"..fname), @params.panel["content-type"], @params.nextid, (@params.islog and 1 or 0)
      @html ->
        div id: "container", ->
          h1 "Your page ID is:"
          a href:"/view/#{pesterlog.nid}", pesterlog.nid
  }