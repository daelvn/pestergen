import Widget from require "lapis.html"

class List extends Widget
  content: =>
    div class: "container", ->
      h1 "All pages"
      div class: "collection", ->
        import listLogs from require "controllers.logs"
        ll = (listLogs!)
        if type(ll) == "table"
          for log in *ll
            a href: "/view/#{log.nid}", class: "collection-item", ->
              span class: "badge", log.nid
              span log.title 
        else
          p "No pages."