import Widget from require "lapis.html"
util = require "lapis.util"

class Index extends Widget
  content: =>
    div class: "container", ->
      div class: "row", ->
        -- insert part
        div class: "col s6", ->
          h2 "Add content"
          -- adder form
          div class: "section", ->
            h4 "Add messages"
            div class: "row", ->
              div class: "col s2", ->
                label for: "message-color", "Color"
                input style: "margin-top: 15px;", type: "color", id: "message-color"
              div class: "col s10", ->
                label for: "message-text", "Message"
                input class: "input-field", type: "text",  id: "message-text", placeholder: "Put your message here"
            div class: "row", ->
              div class: "col s12", ->
                button class: "btn waves-effect waves-light", id: "message-add", "Add message"
          -- divider
          div class: "divider"
          -- control form
          div class: "section", ->
            form action: "", method: "POST", enctype: "multipart/form-data", ->
              -- panel
              h4 "Add a panel"
              div class: "file-field input-field", ->
                div class: "btn", ->
                  span "File"
                  input type: "file", name: "panel", id: "panel-file"
                div class: "file-path-wrapper", ->
                  label for: "panel-filepath", "Panel image"
                  input class: "file-path validate", type: "text", id: "panel-filepath"
              -- messages as json
              input type: "hidden", id: "messages", name: "messages"
              -- title, next and such
              div class: "input-field", ->
                label for: "panel-title", "Title"
                if @next
                  input type: "text", name: "title", id: "panel-title", required: "true", value: util.unescape @next
                else
                  input type: "text", name: "title", id: "panel-title", required: "true"
              div class: "input-field", ->
                label for: "panel-next", "Next page"
                input type: "text", name: "next", id: "panel-next"
              div class: "input-field", ->
                label for: "panel-next-nid", "Next page (ID)"
                input type: "text", name: "nextid", id: "panel-next-id"
              -- log or paragraph
              label ->
                input type: "checkbox", name: "islog"
                span "Is this a log?"
                br!
                br!
              -- submit
              button class: "btn waves-effect waves-light", type: "submit", name: "action", id: "create-panel", "Create"
        -- log
        div class: "col s6", ->
          h2 "Preview log"
          h3 id: "preview-panel-title"
          div id: "panel", ->
            img id: "panel-image"
          div class: "grey lighten-4", id: "log"
          span "> "
          a href: "#", id: "preview-panel-next"
    -- page js
    script type: "text/javascript", src: "/static/log.js"