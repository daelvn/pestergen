import Widget from require "lapis.html"

class Index extends Widget
  content: =>
    @content_for "page-title", @title
    @content_for "page-panel", -> img src: @panel, type: @type, class: "mar-x-auto disp-bl"
    @content_for "page-next",  -> a href: "/view/#{@nextid}", @next
    @content_for "page-content", ->
      serialized = dofile "static/logs/#{@nid}.lua"
      for {:color, :message} in *serialized
        span style: "color: #{color};", message
        br!