#!/bin/bash

mode="$1"

if [[ "$mode" == "run" ]]; then
    echo "2" > .peso1; cp .peso1 .peso2
    abinit_check.sh 1
    abinit_check.sh 2
    odd_rank.sh
    rklist.sh 15 15 2 abinit
    rlayer.sh 4.788090 1 4 1 1
    chose_layers.sh half-slab
    #run_tiniba.sh -r setkp -k 40 -g 2 -G 2 
    run_tiniba.sh -r run -k 40 -N half-slab -x 2 -C 4 -P 200 -w -e -p
    run_tiniba.sh -r run -k 40 -N half-slab -x 2 -c
    all_responses.sh -w total -m 40_5-nospin -s 0.0 -o 1 -v 13 -c 17 -r 1 -t "xx"
    all_responses.sh -w total -m 40_5-nospin -s 0.0 -o 1 -v 13 -c 17 -r 21 -t "xxx"
    all_responses.sh -w layer -m 40_half-slab_5-nospin -s 0.0 -o 1 -v 13 -c 17 -r 44 -t "xxx"
elif [[ "$mode" == "clean" ]]; then
    run_tiniba.sh -r erase
    run_tiniba.sh -r erasescf
    rm -rf .ab_layers.d .acell.d .back.layers back.layers.xy eigen_* .fnval .front.layers front.layers.xy half_slab.* hoy* .i* layers.d* .lista_layers logfiles/ .machines_pmn .machines_scf .machines_latm .machines_res me_* mtita opt.dat .peso* si_as_6_* *.klist* si_as_6.xyz.original spin_info symmetries/ .trueMachines
fi
