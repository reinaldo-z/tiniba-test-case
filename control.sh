#!/bin/bash

mode="$1"

if [[ "$mode" == "run" ]]; then
    abinit_check.sh 1
    abinit_check.sh 2
    rklist.sh 13 13 2 abinit
    rlayer.sh 4.788090 1 4 1 1
    chose_layers.sh half-slab
    run_tiniba.sh -r setkp -k 19 -g 2 -G 2 
    run_tiniba.sh -r run -k 19 -N half-slab -x 2 -w
    run_tiniba.sh -r run -k 19 -N half-slab -x 2 -e
    run_tiniba.sh -r run -k 19 -N half-slab -x 2 -p
    run_tiniba.sh -r run -k 19 -N half-slab -x 2 -c
    all_responses.sh -w total -m 19_5-nospin -s 0 -o 1 -v 13 -c 17 -r 1 -t "xx"
elif [[ "$mode" == "clean" ]]; then
    run_tiniba.sh -r erase
    run_tiniba.sh -r erasescf
    rm -rf .ab_layers.d .acell.d .back.layers back.layers.xy eigen_* .fnval .front.layers front.layers.xy half_slab.* hoy* .i* layers.d* .lista_layers logfiles/ .machines_pmn .machines_scf .machines_latm .machines_res me_* mtita opt.dat .peso* si_as_6_* *.klist* si_as_6.xyz.original spin_info symmetries/ .trueMachines
fi
