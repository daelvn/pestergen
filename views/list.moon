import Widget from require "lapis.html"
import config from require "pestergen.config"

class List extends Widget
  content: =>
    div class: "container", ->
      -- add FAB to homepage
      div class: "fixed-action-btn", ->
        a id: "home-fab", class: "btn-floating btn-large teal ligthen-1", -> i class: "material-icons", "home"
      -- content
      h1 "All pages"
      import listLogs, pageLogs, countLogs from require "controllers.logs"
      ll = (pageLogs @page-1, config.pestergen.db.perpage)
      -- list pages
      if type(ll) == "table"
        div class: "collection", ->
          for log in *ll
              a href: "/view/#{log.nid}", class: "collection-item", ->
                span class: "badge", log.nid
                span log.title
        div class: "center-align", -> ul class: "pagination", ->
          -- prev
          if @page == 1
            li class: "disabled", -> a href: "#", -> i class: "material-icons", "chevron_left"
          else
            li class: "waves-effect", -> a href: "/list/#{@page-1}", "<"
          -- middle
          for i=1, (countLogs! / config.pestergen.db.perpage) + 1
            log "#{@page} vs #{i}, #{type @page} vs #{type i}"
            if @page == i
              li class: "active teal ligten-1", -> a href: "#!", "#{i}"
            else
              li class: "waves-effect", -> a href: "/list/#{i}", "#{i}"
          -- next
          if @page > (countLogs! / config.pestergen.db.perpage)
            li class: "disabled", -> a href: "#", -> i class: "material-icons", "chevron_right"
          else
            li class: "waves-effect", -> a href: "/list/#{@page+1}", ">"
      -- no pages card
      else
        div class: "card teal accent-3", ->
          div class: "card-content black-text", ->
            span class: "card-title", -> "No pages"
            p "It seems like there are no pages uploaded."
          div class: "card-action", ->
            a class: "btn", href: "/create", "Create new page"