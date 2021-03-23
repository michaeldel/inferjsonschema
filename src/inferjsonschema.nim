import json

proc infer*(data: JsonNode): JsonNode =
    assert data.kind == JObject

    result = %* {}

    for key, value in data.pairs():
        result[key] = case value.kind:
            of JNull: %* {"type": "null"}
            of JBool: %* {"type": "boolean"}
            of JInt: %* {"type": "integer"}
            of JFloat: %* {"type": "float"}
            of JString: %* {"type": "string"}
            else: %* {}

when isMainModule:
  echo("Hello, World!")

