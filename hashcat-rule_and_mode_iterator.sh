#!/bin/bash

HASH="REPLACE_VALUE"

WORDLIST="/path/to/wordlist/"

RULES_DIR="/path/to/ruleset(s)"

# single mode or array
MODES=(0 1000 900 9900 70)

for mode in "${MODES[@]}"; do
    for rule in "$RULES_DIR"/*; do
        echo "Trying mode $mode with rule $(basename "$rule")..."
        
        # alter run for kernel tuning or attack type
        hashcat -a 0 -m "$mode" --potfile-disable -o cracked.txt -w 3 "$HASH" "$WORDLIST" -r "$rule"
        
        # Check if Hashcat successfully cracked the hash
        if [ -s cracked.txt ]; then
            echo "Winner :) Found the password with mode $mode and rule $(basename "$rule")"
            cat cracked.txt
            exit 0
        fi
    done
done

echo "Finished trying all combinations without success."

