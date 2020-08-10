html = require "lapis.html"

class HomestuckLayout extends html.Widget
  content: =>
    html_5 ->
      head ->
        link rel: "stylesheet", type: "text/css",  href: "/static/manifestui.css"
        script src: "https://code.jquery.com/jquery-1.11.3.min.js"
        script src: "/static/manifestui.js"
        title "Pestergen by kankri."
      body ->
        script [[
$(document).ready(function() {
  // Make content area responsive during preload

  var $content_container = $("#content_container");
  var $anim_container    = $("#animation_container");
  var $_preload_div_     = $("#_preload_div_");
  var w = $anim_container.width(), h = $anim_container.height();
  var iw = $content_container.width(), ih = $content_container.height();
  var pw = $_preload_div_.width(), ih = $_preload_div_.height();
  var pRatio = window.devicePixelRatio || 1, xRatio=iw/w, yRatio=ih/h, sRatio=1, psRatio=1;;

  if ($.browser.mobile === true) {
    $anim_container.width(w*xRatio+'px');
    $anim_container.height(h*xRatio+'px');
  } else {
    $_preload_div_.css('left', ((iw-(pw))/2)+'px');
  }
});
        ]]
        div class: "pos-r", ->
          -- header
          div class: "row bg-hs-gray bg-light-gray--md pad-t-md--md pos-r", ->
            div id: "content_container", class: "mar-x-auto disp-bl bg-hs-gray", style: "max-width: 650px;", ->
              -- title
              h2 class: "pad-t-md pad-x-lg--md type-center type-hs-header line-tight", -> @content_for "page-title"
              -- panel
              div class: "pad-t-md", ->
                @content_for "page-panel"
          -- log/content
          div class: "row bg-hs-gray bg-light-gray--md pad-b-md pad-b-lg--md pos-r", ->
            div class: "mar-x-auto disp-bl bg-hs-gray pad-t-lg", style: "max-width: 650px;", ->
              if @log
                div class: "type-center mar-x-0 mar-x-hs-md--md mar-b-hs-lg o_chat-container", ->
                  button class: "o_chat-log-btn", "Hide Dialoglog"
                  p class: "o_chat-log type-left type-rg type-hs-small--md line-caption line-copy--md mar-t-md mar-t-md--md pad-x-md pad-x-hs-lg--md pad-b-md pad-b-md--md", ->
                    @content_for "page-content"
              else
                p class: "o-story_text type-rg type-hs-small--md type-center line-caption line-copy--md pad-x-0 pad-x-lg--md pad-b-lg", ->
                  @content_for "page-content"
              -- nav
              div class: "o_story-nav type-hs-copy line-tight pad-x-0 pad-x-lg--md mar-b-lg", ->
                div ->
                  if @next
                    span class: "", ">"
                    @content_for "page-next"
              -- gamenav
              footer id: "story-footer", role: "banner", ->
                div id: "story_footer_container", class: "o_story-page-footer flex pad-t-0 pad-x-0 flex-justify", ->
                  div class: "pad-l-lg--md mar-b-md type-hs-small type-hs-bottom--md type-center type-left--md", ->
                    ul class: "o_game-nav", ->
                      li class: "o_game-nav-item", -> a href: "/create", "Create New"
                      li class: "o_game-nav-item", -> a href: "/list/1", "View All"
        -- site footer
        div class: "o_site-footer row pos-r pad-t-rg pad-b-xl pad-b-0--md bg-dark-gray", ->
          div class: "type-center pad-t-md--md", ->
            div class: "float-l",                    -> img src: "https://homestuck.com/assets/footer_logo-a913b68f0efbaed8da48bc0a4f22b35d369f40d0e4db132013acbe6f26b3e37f.gif"
            div class: "float-r disp-n disp-bl--sm", -> img src: "https://homestuck.com/assets/footer_logo-a913b68f0efbaed8da48bc0a4f22b35d369f40d0e4db132013acbe6f26b3e37f.gif"
            ul ->
              li -> a href: "/", "Homepage"
            div -> span "made by daelvn. kindly hosted by ahti.space."