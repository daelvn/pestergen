var messageList = []

$(document).ready(function() {
  // add message
  $( "#message-add" ).click(function() {
    let message = $( "#message-text" ).val()
    let color   = $( "#message-color" ).val()

    // add message to list
    let object = {color: color, message: message}
    messageList.push(object)

    // add element to preview
    let entry  = $(document.createElement("span"))
      .css("color", color)
      .html(message)

    $( "#log" ).append(entry).append(document.createElement("div"))
  })

  // add panel
  $( "#panel-file" ).change(function(ev) {
    let f  = ev.target.files[0]
    let fr = new FileReader()

    fr.onload = function(ev2) {
      $( "#panel-image" ).attr("src", ev2.target.result)
    }

    fr.readAsDataURL(f)
  })

  // set title
  $( "#panel-title" ).change(function (ev) {
    $( "#preview-panel-title" ).html(ev.target.value)
  })

  $( "#panel-next" ).change(function (ev) {
    $( "#preview-panel-next" ).html(ev.target.value)
  })

  // generate json
  $( "#create-panel" ).click(function() {
    $( "#messages" ).val(JSON.stringify(messageList))
  })
})