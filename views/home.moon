import Widget from require "lapis.html"

class Home extends Widget
  content: =>
    -- navbar
    html_5 ->
      head ->
        link rel: "stylesheet", type: "text/css",  href: "/static/manifestui.css"
      body ->
        h2 class: "type-center", ->
          img src: "static/homegif.gif"
          p "Pestergen is a Homestuck page generator and host that supports uploading images, GIFs, and color logs. It uses the Homestuck style sheets so that it looks as close as possible to the original."