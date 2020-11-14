![](logo.png)
# MadNES PPU fpga source

A 480p (VGA) 16 bit sprite rendering processing unit used for the Datamaskinprosjekt 2020 (computerproject) at NTNU. 

## Interfacing

The MadNES PPU consists of sprite, pallet and object memory which can be accessed over a memory bus.
This was made to fit with the efm32gg platform and hence uses EBI with a 16-bit data and address bus.

### EBI Bus

The different memory regions can be accessed by setting the corresponding bits on the `bank_select` line.

| Memory Bank                     | bank_select |
|---------------------------------|-------------|
| Object Atribute Memory          | 0           |
| Sprite Memory                   | 1           |
| Tile Memory (not used)          | 2           |
| Pallet Memory                   | 3           |
| Tile Atribute Memory (not used) | 4           |

Every memory bank start from address 0

Please see Silicon Labs [AN0034](https://www.silabs.com/documents/public/application-notes/an0034-efm32-ebi.pdf) for specific details about EBI.

### Object Attribute Memory (OAM)

Defines the attributes of each object drawn on the screen. This is where the external device can change an objects position and sprite referance which is drawn to the screen.

Each object consist of a 32-bit structure which consists of the following ascending ordre from 0:

| Bit Size | Name             | Description                                       |
|----------|------------------|---------------------------------------------------|
| 8 bit    | Sprite Referance | 0-255 sprite reference which points to sprite ram |
| 10 bit   | x position       | 0-479 are valid values                            |
| 10 bit   | y position       | 0-639 are valid values                            |
| 1 bit    | priority         | Should be used on collision between two objects   |
| 1 bit    | x flip           | Flips the sprite with the x axis                  |
| 1 bit    | y flip           | Flips the sprite with the y axis                  |
| 1 bit    | enable           | Controles if the object is drawn or not           |


### Sprite Memory

Stores the spriteobjects which is drawn to the screen.
Each sprite memory object consists of a 16x16 pixels and each pixles can have a value from 0-255 where 0 is transparent and 1-255 referse to the different pallets which define color.

TODO: document memory layout

### Pallet memory

Used to define the different colors which each sprite receives when it is drawn to the screen. It consists of 256 pallets that have 3 different colors with 8 bits of the value. Note that the first pallet is used for the background color to the screen since 0 in sprite memory refers to transparent

Pallet:
- red 8-bit
- green 8-bit
- blue 8-bit

TODO: document memory layout

## Setup
Follow [these](https://github.com/barbedo/vivado-git) instructions for a propper vivado git setup

Put boardfiles into `(Folder where you installed vivado)/Xilinx/Vivado/2020.1/data/boards/board_files/`

## Some guiding steps to simulating and generating a image

1. Generte the vivado project with the tcl console inside vivado. `cd (path to repo)` and then `source ./vivado_project.tcl`
2. Modify `EBI_data_generator.py` with the data you want and run `python3 EBI_data_generate.py > src/testbench/top_test_tb_data`
3. Run the simulation with the `Run All (F3)` and wait the the simulation of a frame to finish. This takes a couple of min depending on your computer since you need to simulate ~16.7ms (one frame).
4. After that you run `python3 generate_picture.py` to view the result.

Some of these steps are shown in prep/result_simulation.sh