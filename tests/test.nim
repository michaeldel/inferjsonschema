import json
import unittest

import inferjsonschema

suite "schema inference":
    test "blank JSON object":
        check infer(parseJson "{}") == parseJson "{}"

    test "null field":
        check infer(%* {"foo": nil}) == %* {"foo": {"type": "null"}}

    test "bool field":
        check infer(%* {"foo": true}) == %* {"foo": {"type": "boolean"}}
        check infer(%* {"foo": false}) == %* {"foo": {"type": "boolean"}}

    test "integer field":
        check infer(%* {"foo": 0}) == %* {"foo": {"type": "integer"}}
        check infer(%* {"foo": 1}) == %* {"foo": {"type": "integer"}}
        check infer(%* {"foo": -1}) == %* {"foo": {"type": "integer"}}

    test "string field":
        check infer(%* {"foo": ""}) == %* {"foo": {"type": "string"}}
        check infer(%* {"foo": "bar"}) == %* {"foo": {"type": "string"}}

