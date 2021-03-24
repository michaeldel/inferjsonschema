import json
import os

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
    elif node.kind == JArray and node.len != 0:
        result["items"] = %* {}

        var last: JsonNode
        for item in node.items:
            let current = infer item

            # TODO: properly handle
            if last != nil: doAssert current == last
            last = current

        result["items"] = last

when isMainModule:
    doAssert paramCount() == 1
    echo paramStr(1).parseFile().infer().pretty()

