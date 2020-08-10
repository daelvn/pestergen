import Widget from require "lapis.html"

class Home extends Widget
  content: =>
    -- navbar
    div class: "container", ->
      div class:
    p "Pestergen is a Homestuck page generator and host that supports uploading images, GIFs, and color logs. It uses the Homestuck style sheets so that it looks as close as possible to the original."