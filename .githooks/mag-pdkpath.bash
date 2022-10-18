#!/bin/env bash
staged=($(git diff --name-only --cached))

for file in ${staged[@]}
do
    filename=$(basename -- "$file")
    extension="${filename##*.}"
    if [[ "$extension" = "mag" ]]; then
        matches=($(sed -n 's/^use\b \+\S\+\ \+\S\+ \+\(\S\+\)/\1/p' $file))
        for match in ${matches[@]} 
        do
            if [[ "$(echo "$match" | sed -n '/PDKPATH\b\|PDK\b\|PDK_ROOT\b/p')" = "" ]]; then
                echo "error: mag file $file has a <use> statment with a pdk path that's not PDKPATH|PDK|PDK_ROOT"
                echo "the path used is: $match"
                echo "you can use: 'git commit -n ..' to ignore this check but that's not recommended"
                exit 1
            fi
        done
    fi
done

