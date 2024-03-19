#!/bin/bash

# Check if the correct number of arguments are passed
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 PROJECT_ROOT MACRO RUN_TAG"
    exit 1
fi

# Assign arguments to variables
PROJECT_ROOT=$1
MACRO=$2
RUN_TAG=$3

# Create directory for timing reports
mkdir -p "${PROJECT_ROOT}/signoff/${MACRO}/openlane-signoff/timing-reports"

# Copy CSV files
cp "${PROJECT_ROOT}/openlane/${MACRO}/runs/${RUN_TAG}/final/metrics.csv" "${PROJECT_ROOT}/signoff/${MACRO}/"

# Copy DEF files
cp "${PROJECT_ROOT}/openlane/${MACRO}/runs/${RUN_TAG}/final/def/${MACRO}.def" "${PROJECT_ROOT}/def/${MACRO}.def"

# Copy SDC files
# cp "${PROJECT_ROOT}/openlane/${MACRO}/runs/${RUN_TAG}/final/sdc/${MACRO}.sdc" "${PROJECT_ROOT}/sdc/${MACRO}.sdc"

# Copy GDS files
cp "${PROJECT_ROOT}/openlane/${MACRO}/runs/${RUN_TAG}/final/gds/${MACRO}.gds" "${PROJECT_ROOT}/gds/${MACRO}.gds"

# Copy LEF files
cp "${PROJECT_ROOT}/openlane/${MACRO}/runs/${RUN_TAG}/final/lef/${MACRO}.lef" "${PROJECT_ROOT}/lef/${MACRO}.lef"

# Copy MAG files
cp "${PROJECT_ROOT}/openlane/${MACRO}/runs/${RUN_TAG}/"*"magic-streamout/${MACRO}.mag" "${PROJECT_ROOT}/mag/${MACRO}.mag"

# Copy Verilog files
cp "${PROJECT_ROOT}/openlane/${MACRO}/runs/${RUN_TAG}/final/pnl/${MACRO}.pnl.v" "${PROJECT_ROOT}/verilog/gl/${MACRO}.v"


# Copy SPEF files (nominal, minimum, maximum)
cp "${PROJECT_ROOT}/openlane/${MACRO}/runs/${RUN_TAG}/final/spef/nom/"* "${PROJECT_ROOT}/spef/multicorner/${MACRO}.nom.spef"
cp "${PROJECT_ROOT}/openlane/${MACRO}/runs/${RUN_TAG}/final/spef/nom/"* "${PROJECT_ROOT}/spef/${MACRO}.spef"
cp "${PROJECT_ROOT}/openlane/${MACRO}/runs/${RUN_TAG}/final/spef/min/"* "${PROJECT_ROOT}/spef/multicorner/${MACRO}.min.spef"
cp "${PROJECT_ROOT}/openlane/${MACRO}/runs/${RUN_TAG}/final/spef/max/"* "${PROJECT_ROOT}/spef/multicorner/${MACRO}.max.spef"

# Copy LIB files
cp "${PROJECT_ROOT}/openlane/${MACRO}/runs/${RUN_TAG}/final/lib/nom"*"tt"*"/"* "${PROJECT_ROOT}/lib/${MACRO}.lib"

# Copy resolved.json
cp "${PROJECT_ROOT}/openlane/${MACRO}/runs/${RUN_TAG}/resolved.json" "${PROJECT_ROOT}/signoff/${MACRO}/"

# Copy DRC, LVS reports, and logs
cp "${PROJECT_ROOT}/openlane/${MACRO}/runs/${RUN_TAG}/"*"magic-drc/reports/"* "${PROJECT_ROOT}/signoff/${MACRO}/openlane-signoff/"
cp "${PROJECT_ROOT}/openlane/${MACRO}/runs/${RUN_TAG}/"*"netgen-lvs/reports/"*".rpt" "${PROJECT_ROOT}/signoff/${MACRO}/openlane-signoff/"
cp "${PROJECT_ROOT}/openlane/${MACRO}/runs/${RUN_TAG}/"*"netgen-lvs/netgen-lvs.log" "${PROJECT_ROOT}/signoff/${MACRO}/openlane-signoff/"

# Copy STA post PnR summary report
cp -r "${PROJECT_ROOT}/openlane/${MACRO}/runs/${RUN_TAG}/"*"openroad-stapostpnr/summary.rpt" "${PROJECT_ROOT}/signoff/${MACRO}/openlane-signoff/timing-reports/"
