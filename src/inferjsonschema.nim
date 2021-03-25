import json
import os
import sequtils
import sets

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
        let schemas = node.elems.map(infer).toHashSet
        assert schemas.len != 0

        if schemas.len == 1:
            result["items"] = schemas.toSeq[0]
        else:
            result["items"] = %* {"oneOf": toSeq schemas}

when isMainModule:
    doAssert paramCount() == 1
    echo paramStr(1).parseFile().infer().pretty()

