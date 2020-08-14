import Widget from require "lapis.html"
util = require "lapis.util"

class Index extends Widget
  content: =>
    div class: "container", ->
      div class: "row", ->
        -- controls
        div class: "col s6", ->
          h2 "Add content"
          -- controls organized as a collapsible
          ul class: "collapsible", ->
            -- logs
            li ->
              -- header
              div class: "collapsible-header", ->
                i class: "material-icons", "message"
                span "Logs"
              -- content
              div class: "collapsible-body", ->
                div class: "row", ->
                  div class: "col s2", ->
                    label for: "log-color", "Color"
                    input style: "margin-top: 15px;", type: "color", id: "log-color"
                  div class: "col s10", ->
                    label for: "log-text", "Message"
                    input class: "input-field", type: "text",  id: "log-text", placeholder: "Put your message here"
                div class: "row", ->
                  div class: "col s12", ->
                    button class: "btn waves-effect waves-light", id: "log-add", "Add message"
            -- paragraphs
            li ->
              -- header
              div class: "collapsible-header", ->
                i class: "material-icons", "reorder"
                span "Paragraphs"
              -- content
              div class: "collapsible-body", ->
                div class: "row", ->
                  div class: "col s2", ->
                    label for: "paragraph-color", "Color"
                    input style: "margin-top: 15px;", type: "color", id: "paragraph-color"
                  div class: "col s10", ->
                    label for: "message-text", "Paragraph"
                    textarea class: "materialize-textarea", id: "paragraph-text", placeholder: "Put your paragraph here"
                div class: "row", ->
                  div class: "col s6", ->
                    button class: "btn waves-effect waves-light", id: "paragraph-add", "Add to paragraph"
                  div class: "col s6", ->
                    button class: "btn waves-effect waves-light", id: "paragraph-new", "Start new paragraph"
            -- panel
            li ->
              -- header
              div class: "collapsible-header", ->
                i class: "material-icons", "image"
                span "Panel"
              div class: "collapsible-body", ->
                -- file input
                div class: "file-field input-field", ->
                  div class: "btn", ->
                    span "File"
                    input type: "file", name: "panel", id: "panel-file", form: "page-form"
                  div class: "file-path-wrapper", ->
                    label for: "panel-filepath", "Panel image"
                    input class: "file-path validate", type: "text", id: "panel-filepath"
            -- other
            li ->
              -- header
              div class: "collapsible-header", ->
                i class: "material-icons", "bubble_chart"
                span "Others"
              div class: "collapsible-body", ->
                -- title for panel
                div class: "input-field", ->
                  label for: "panel-title", "Title"
                  input form: "page-form", type: "text", name: "title", id: "panel-title", required: "true"
                -- next page link
                div class: "input-field", ->
                  label for: "panel-next", "Next page"
                  input form: "page-form", type: "text", name: "next", id: "panel-next"
                -- id for next page
                div class: "input-field", ->
                  label for: "panel-next-nid", "Next page (ID)"
                    -- TODO fill autocomplete with list of page ids
                  input form: "page-form", type: "text", name: "nextid", id: "panel-next-id", class: "autocomplete"
                -- add a line break
                button class: "btn waves-effect waves-light", id: "newline-add", "Add line break"
          -- buttons
          form id: "page-form", action: "", method: "POST", enctype: "multipart/form-data", ->
            input type: "hidden", id: "json-content", name: "content"
            button class: "btn waves-effect waves-light", type: "submit", name: "action", id: "create-panel", "Create"
        -- preview
        div class: "col s6", ->
          h2 "Preview"
          -- title
          h3 id: "preview-title"
          -- image
          div id: "panel", -> img id: "preview-panel"
          -- text
          div class: "grey lighten-4", id: "preview-text"
          -- links
          div id: "preview-next", ->
            span "> "
            a href: "#", id: "preview-next-link"

    -- page js
    script type: "text/javascript", src: "/static/log.js"