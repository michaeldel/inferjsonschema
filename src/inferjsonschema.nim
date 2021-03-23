import json

proc infer*(data: JsonNode): JsonNode =
    parseJson("{}")

when isMainModule:
  echo("Hello, World!")
