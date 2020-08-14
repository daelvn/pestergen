import config     from require "pestergen.config"
import respond_to from require "lapis.application"
import from_json  from require "lapis.util"
import database   from require "pestergen.db.init"
import query, update from require "grasp"
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
    redirect_to: "/view/homepage"
  "/list": =>
    redirect_to: "/list/0"
  "/list/:page": =>
    @page = tonumber @params.page or 0
    render: "list"
  "/view/:nid": =>
    import Log from require "controllers.logs"
    pesterlog = Log nid: @params.nid
    --
    @nid    = pesterlog.nid
    @title  = pesterlog.title
    @next   = (if pesterlog.next == "" then nil else pesterlog.next)
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
      --
      -- content to table
      content = from_json @params.content
      -- check whether there is a panel or not
      hasPanel = @params.panel.content != ""
      -- this nid
      nid = nanoid 10
      -- save panel, if exists
      local fname
      if hasPanel
        path  = "static/panels/#{nid}"
        fname = "#{path}/#{@params.panel.filename}"
        fs.makeDir path --unless fs.exists path
        with io.open fname, "w"
          \write @params.panel.content
          \close!
      -- save log
      import Log from require "controllers.logs"
      -- create log
      pesterlog = Log {
        :nid
        -- content
        :content
        title:   @params.title
        islog:   if @params.islog == "on" then 1 else 0
        -- next
        next:    @params.next
        nextid:  @params.nextid
        -- panel
        panel:   if hasPanel then ("/" .. fname)                else nil
        type:    if hasPanel then @params.panel["content-type"] else nil
      }
      -- render created page
      @html ->
        div id: "container", ->
          div style: "margin: 50px;", class: "card teal accent-3", ->
            div class: "card-content black-text", ->
              span class: "card-title", -> "Page created"
              p "Your page ID is: #{pesterlog.nid}"
            div class: "card-action", ->
              a class: "btn", href: "/view/#{pesterlog.nid}", "View"
              a class: "btn", href: "/create",                "Create"
              a class: "btn", href: "/list/1",                "See all"
  }