// text for panel
var textList = []

// on document ready
$( document ).ready(function() {
  // hide things
  $( "#preview-next" ).hide()

  // live things //
  // set preview title
  $( "#panel-title" ).change(function(ev) {
    $( "#preview-title" ).html(ev.target.value)
  })
  // set next link
  $( "#panel-next" ).change(function(ev) {
    $( "#preview-next" ).show()
    $( "#preview-next-link" ).html(ev.target.value)
  })
  // set panel image
  $( "#panel-file" ).change(function(ev) {
    let f  = ev.target.files[0]
    let fr = new FileReader()

    fr.onload = function(ev2) {
      $( "#preview-panel" ).attr("src", ev2.target.result)
    }

    fr.readAsDataURL(f)
  })

  // text things //
  // add log
  $( "#log-add" ).click(function() {
    let text  = $( "#log-text" ).val()
    let color = $( "#log-color" ).val()

    // add message to list
    let object = {color: color, text: text, kind: "log"}
    textList.push(object)

    // add element to preview
    let entry = $(document.createElement("span"))
      .css("color", color)
      .html(text)
    $( "#preview-text" ).append(entry).append(document.createElement("br"))
    
    // clear textbox
    $( "#log-text" ).attr("value", "")
  })
  // add to paragraph
  $( "#paragraph-add" ).click(function() {
    let text  = $( "#paragraph-text" ).val()
    let color = $( "#paragraph-color" ).val()

    // add paragraph to list
    let object = {color: color, text: text, kind: "paragraph"}
    textList.push(object)

    // add element to preview
    let entry = $(document.createElement("span"))
      .css("color", color)
      .html(text)
    $( "#preview-text" ).append(entry).append(document.createElement("br"))
    
    // clear textbox
    $( "#paragraph-text" ).attr("value", "")
  })
  // add new paragraph
  $( "#paragraph-new" ).click(function() {
    // add element
    textList.push({kind: "noop"})
    // add to preview
    $( "#preview-text" ).append(document.createElement("br"))
  })
  // add line break
  $( "#newline-add" ).click(function() {
    // add linebreak to list
    textList.push({kind: "linebreak"})
    // add to preview
    $( "#preview-text" ).append(document.createElement("br"))
  })

  // others //
  // generate json
  $( "#create-panel" ).click(function() {
    $( "#json-content" ).val(JSON.stringify(textList))
  })

})