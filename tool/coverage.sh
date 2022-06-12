#!/bin/bash
# Shows a preview of code coverage locally

dart run coverage:format_coverage \
--pretty-print \
--in coverage
