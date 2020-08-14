import Widget from require "lapis.html"

class Index extends Widget
  content: =>
    @content_for "page-title", @title
    @content_for "page-panel", -> img src: @panel, type: @type, class: "mar-x-auto disp-bl"
    @content_for "page-next",  -> a href: "/view/#{@nextid}", @next
    @content_for "page-content", ->
      serialized = dofile "static/logs/#{@nid}.lua"
      for group in *serialized
        switch group.kind
          when "log"
            div class: "type-center mar-x-0 mar-x-hs-md--md mar-b-hs-lg o_chat-container", ->
              button class: "o_chat-log-btn", "Hide Dialoglog"
              p class: "o_chat-log type-left type-rg type-hs-small--md line-caption line-copy--md mar-t-md mar-t-md--md pad-x-md pad-x-hs-lg--md pad-b-md pad-b-md--md", ->
                for {:color, :text} in *group
                  span style: "color: #{color};", text
                  br!
          when "paragraph"
            p class: "o-story_text type-rg type-hs-small--md type-center line-caption line-copy--md pad-x-0 pad-x-lg--md pad-b-lg", ->
              for {:color, :text} in *group
                span style: "color: #{color};", text
                br!
          when "linebreak"
            br!
          when "noop"
            (->)!