import json
import unittest

import inferjsonschema

suite "field type inference":
    test "blank JSON object":
        check infer(%* {}) == %* {"type": "object"}

    test "null field":
        check infer(%* nil) == %* {"type": "null"}

    test "bool field":
        check infer(%* true) == %* {"type": "boolean"}
        check infer(%* false) == %* {"type": "boolean"}

    test "integer field":
        check infer(%* 0) == %* {"type": "integer"}
        check infer(%* 1) == %* {"type": "integer"}
        check infer(%* -1) == %* {"type": "integer"}

    test "float field":
        check infer(%* 0.0) == %* {"type": "float"}
        check infer(%* 1.0) == %* {"type": "float"}
        check infer(%* -1.0) == %* {"type": "float"}

    test "string field":
        check infer(%* "") == %* {"type": "string"}
        check infer(%* "bar") == %* {"type": "string"}

    test "empty array field":
        check infer(%* []) == %* {"type": "array"}

