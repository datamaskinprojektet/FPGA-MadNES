#!/bin/bash

python3 EBI_data_generate.py > src/testbench/top_test_tb_data

rm vivado_project/vivado_project.sim/sim_1/behav/xsim/display_data.txt