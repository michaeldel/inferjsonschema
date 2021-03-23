import json
import unittest

import inferjsonschema

suite "schema inference":
    test "blank JSON object":
        check infer(parseJson "{}") == parseJson "{}"

    test "string field":
        check infer(%* {"foo": ""}) == %* {"foo": {"type": "string"}}
        check infer(%* {"foo": "bar"}) == %* {"foo": {"type": "string"}}

