# MadNES PPU fpga source

## Setup
Follow [these](https://github.com/barbedo/vivado-git) instructions for a propper vivado git setup

Put boardfiles into `(Folder where you installed vivado)/Xilinx/Vivado/2020.1/data/boards/board_files/`

## Some guiding steps to simulating and generating a image

1. Generte the vivado project with the tcl console inside vivado. `cd (path to repo)` and then `source ./vivado_project.tcl`
2. Modify `EBI_data_generator.py` with the data you want and run `python3 EBI_data_generate.py > src/testbench/top_test_tb_data`
3. Remove the display_data.txt file (if it exist) before rendering `rm vivado_project/vivado_project.sim/sim_1/behav/xsim/display_data.txt`
4. Run the simulation with the `Run All (F3)` and wait the the simulation of a frame to finish. This takes a couple of min depending on your computer since you need to simulate ~16.7ms (one frame).
5. After that you run `python3 generate_picture.py` to view the result.

Some of these steps are shown in prep/result_simulation.sh