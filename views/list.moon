import Widget from require "lapis.html"

class List extends Widget
  content: =>
    div class: "container", ->
      h1 "All pages"
      import listLogs from require "controllers.logs"
      ll = (listLogs!)
      -- list pages
      if type(ll) == "table"
        for log in *ll
          div class: "collection", ->
            a href: "/view/#{log.nid}", class: "collection-item", ->
              span class: "badge", log.nid
              span log.title
      -- no pages card
      else
        div class: "card teal accent-3", ->
          div class: "card-content black-text", ->
            span class: "card-title", -> "No pages"
            p "It seems like there are no pages uploaded."
          div class: "card-action", ->
            a class: "btn", href: "/create", "Create new page"