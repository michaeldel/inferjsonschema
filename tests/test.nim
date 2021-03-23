import json
import unittest

import inferjsonschema

suite "schema inference":
    test "blank JSON object":
        check infer(parseJson "{}") == parseJson "{}"

