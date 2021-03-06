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

suite "array items":
    test "single type":
        check infer(%* [0]) == %* {
            "type": "array", "items": {"type": "integer"}
        }
        check infer(%* [1, 2, 3]) == %* {
            "type": "array", "items": {"type": "integer"}
        }
        check infer(%* [nil, nil, nil]) == %* {
            "type": "array", "items": {"type": "null"}
        }
        check infer(%* [false, true]) == %* {
            "type": "array", "items": {"type": "boolean"}
        }

    test "multiple types":
        check infer(%* [0, true]) == %* {
            "type": "array", "items": {"oneOf": [
                {"type": "boolean"},
                {"type": "integer"}
            ]}
        }

suite "object inference":
    test "2D point":
        check infer(%* {"x": 0.0, "y": 0.0}) == %* {
            "type": "object",
            "properties": {
                "x": {"type": "float"},
                "y": {"type": "float"}
            }
        }

    test "basic profile":
        check infer(%* {
            "firstName": "John",
            "lastName": "Doe",
            "age": 21
        }) == %* {
            "type": "object",
            "properties": {
                "firstName": {"type": "string"},
                "lastName": {"type": "string"},
                "age": {"type": "integer"}
            }
        }

    test "geo coordinates":
        check infer(%* {"latitude": 48.858093, "longitude": 2.294694}) == %* {
            "type": "object",
            "properties": {
                "latitude": {"type": "float"},
                "longitude": {"type": "float"}
            }
        }

    test "array of things":
        check infer(%* {
            "fruits": [ "apple", "orange", "pear" ],
            "vegetables": [{
                "veggieName": "potato",
                "veggieLike": true
            }, {
              "veggieName": "broccoli",
              "veggieLike": false
            }]
        }) == %* {
            "type": "object",
            "properties": {
                "fruits": {"type": "array", "items": {"type": "string"}},
                "vegetables": {"type": "array", "items": {
                    "type": "object",
                    "properties": {
                        "veggieName": {"type": "string"},
                        "veggieLike": {"type": "boolean"}
                    }
                }}
            }
        }

