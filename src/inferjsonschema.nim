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

    if node.kind == JObject and node.len != 0:
        result["properties"] = %* {}
        for key, value in node.pairs:
            result["properties"][key] = infer value

when isMainModule:
  echo("Hello, World!")

