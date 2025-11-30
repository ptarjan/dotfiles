#!/bin/bash
# ============================================================================
# apply_sig.sh
# ============================================================================
# Apply Sorbet type signatures from Splunk error logs
# Usage: ./apply_sig.sh <input_file>
#
# Reads input from the specified file and processes it through the
# remote-script to fix type errors reported by Splunk

./scripts/bin/remote-script sorbet/scripts/fix_types_from_splunk.rb < $1
