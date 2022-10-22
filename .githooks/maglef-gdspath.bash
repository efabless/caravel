#!/bin/env bash
staged=($(git diff --name-only --cached))

for file in ${staged[@]}
do
    filename=$(basename -- "$file")
    extension="${filename##*.}"
    filename_no_ext="${filename%%.*}"
    if [[ "$extension" = "mag" ]]; then
        matches=($(sed -E -n 's/string GDS_FILE +(\S+)/\1/p' $file))
        for match in ${matches[@]} 
        do
            if [[ "$(echo "$match" | sed -n "/..\/gds\/${filename_no_ext}/p")" = "" ]]; then
                echo "error: maglef file($file) has string GDS_FILE reference that is not valid"
                echo "the reference used is: $match"
                echo "you can use: 'git commit -n ..' to ignore this check but that's not recommended"
                exit 1
            fi
        done
    fi
done

