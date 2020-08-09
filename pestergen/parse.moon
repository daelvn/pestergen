-- parses pesterlogs
import compile from require "re"
inspect = require "inspect"

-- PESTERLOG FORMAT
-- (header)
--   PERSON A: #ffffff
--   PERSON B: #000000
-- (end of header)
--   *** *** ***
-- (log)
--   PERSON A: yo whats up
--   PERSON B: not much you?
-- (log: links)
--   PERSON A: check this out, ((text///link))
-- (log: coloring)
--   PERSON B: the {{#xxxxxx}}TIMELINE{{#000000}}

shorthand = (s) ->
  s = s\gsub "$(%S+)", [[{:tag: "" -> "%1" :}]]
  return s

grammar = compile shorthand [[
  log       <- {| line+ |}
  line      <- {| linestart {:line: {| normal+ |} :} %nl |}
  normal    <- {| {:text: colortag? [^%s]+  :} |}
  linestart <- character ":" ws
  character <- {:character: [A-Z]+ :}

  colortag <- "{{" ws {:color: color :} ws "}}"
  color    <- "#" %x%x%x%x?%x?%x?

  ws <- %s*
  nl <- %nl
]]

match = (str) -> grammar\match str

print inspect match [[
DAVE: {{#fff}}wassup
]]