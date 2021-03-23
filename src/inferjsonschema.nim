import json

proc infer*(node: JsonNode): JsonNode =
    result = %* {}

    result["type"] = case node.kind:
        of JNull: %* "null"
        of JBool: %* "boolean"
        of JInt: %* "integer"
        of JFloat: %* "float"
        of JString: %* "string"
        of JObject: %* "object"
        of JArray: %* "array"

when isMainModule:
  echo("Hello, World!")

