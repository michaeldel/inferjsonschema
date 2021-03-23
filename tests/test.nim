import json
import unittest

import inferjsonschema

suite "schema inference":
    test "blank JSON object":
        check infer(parseJson "{}") == parseJson "{}"

    test "integer field":
        check infer(%* {"foo": 0}) == %* {"foo": {"type": "integer"}}
        check infer(%* {"foo": 1}) == %* {"foo": {"type": "integer"}}
        check infer(%* {"foo": -1}) == %* {"foo": {"type": "integer"}}

    test "string field":
        check infer(%* {"foo": ""}) == %* {"foo": {"type": "string"}}
        check infer(%* {"foo": "bar"}) == %* {"foo": {"type": "string"}}

