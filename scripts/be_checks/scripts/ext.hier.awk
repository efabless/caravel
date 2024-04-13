BEGIN {
        top = TOP;
}
FILENAME != last_file {
        split(FILENAME, path, "/");
        sub(/.ext$/, "", path[length(path)]);
        subckt = path[length(path)];
        last_file = FILENAME;
}
/^use / {
        subcells[subckt, $2] += 1;
}
END {
        print top;
        PrintHierarchy(top, "");
}
function PrintHierarchy(subckt, prefix) {
        for ( instance in subcells ) {
                split(instance, tokens, SUBSEP);
                if ( tokens[1] == subckt ) {
                        print prefix, tokens[2], subcells[instance];
                        PrintHierarchy(tokens[2], prefix " ");
                }
        }
}
