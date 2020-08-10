html = require "lapis.html"

class DefaultLayout extends html.Widget
  content: =>
    html_5 ->
      head ->
        -- load things
        link rel: "stylesheet", type: "text/css", href: "/fend/materialize-css/dist/css/materialize.min.css"
        link rel: "stylesheet", type: "text/css", href: "/static/other.css"
        link rel: "stylesheet", type: "text/css", href: "https://fonts.googleapis.com/icon?family=Material+Icons"
        script type: "text/javascript", src: "/fend/jquery/dist/jquery.min.js"
        -- meta tags
        meta name: "viewport", content: "width=device-width, initial-scale=1.0"
        -- title
        title "Pestergen by kankri."
      body ->
        -- content
        @content_for "inner"
        -- scripts
        script type: "text/javascript", src: "/fend/materialize-css/dist/js/materialize.min.js"
        script type: "text/javascript", src: "/static/index.js"