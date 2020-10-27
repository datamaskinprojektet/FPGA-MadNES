MadNES Memory Module Specifications
------------------------------------

## Addressing the Memory Modules
Selecting a memory module is done by sending a Bank ID through the EBI\_CS pins.

### Memory Module ID's
- 1: OAM ( Object Attribute Memory)
- 2: Sprite ( Spritesheet)
- 3: Tile ( Tilesheet)
- 4: Palette (Palette banks)
- 5: TAM (Tile Attribute Memory)

## Palette Memory

| Description           | Value           |
| -------------------   | -------------   |
| Read Address Width    | 9 bits          |
| Write Address Width   | 8 bits          |
| Write Data Width      | 16 bits         |
| Serial Write          | No (see below ) |
| Read Data Width       | 24 bits         |
| Write Enable Required | Yes             |
| Read Enable Required  | No              |

### Write Operations
Color n starts at write address 2n.

Writing a full RGB triplet requires first writing the 16 bits for Red-Green followed by another write for Blue.

#### Example Write
Writing color #AABBCC to palette index 27.

First write address: 27\*2 = 54

Write @ 54: 0xAABB

Second write address: 27\*2 + 1 = 55

Write @ 55: 0x00CC


The memory module buffers the RG-pair and concatenates it with the second write.

#### CAREFUL
Always write to an even-numbered location first (2n), followed by its successor (2n+1).

Palette memory does not support fully serial writing at 16-bits per write. Every palette entry must be filled with two write operations.


## Object Attribute Memory (OAM)
| Description           | Value     |
| :------------------   | :-------- |
| Read Address Width    | 6 bits    |
| Write Address Width   | 7 bits    |
| Write Data Width      | 16 bits   |
| Serial Write          | Yes       |
| Read Data Width       | 32 bits   |
| Write Enable Required | Yes       |
| Read Enable Required  | No        |


### Write Operations
OAM Entry _n_ lies at write address 2*n*.

An OAM entry spans 32 bits.

Always write to an even-numbered location followed by its successor.

## Tile Attribute Memory (TAM)

| Description           | Value     |
| :------------------   | :-------- |
| Read Address Width    | 11 bits   |
| Write Address Width   | 11 bits   |
| Write Data Width      | 16 bits   |
| Serial Write          | Yes       |
| Read Data Width       | 16 bits   |
| Write Enable Required | Yes       |
| Read Enable Required  | No        |

## Sprite Memory 
| Description           | Value     |
| :------------------   | :-------- |
| Read Address Width    | 12 bits   |
| Write Address Width   | 15 bits   |
| Write Data Width      | 16 bits   |
| Serial Write          | Yes       |
| Read Data Width       | 256 bits  |
| Write Enable Required | Yes       |
| Read Enable Required  | No        |

## Tile Memory
| Description           | Value     |
| :------------------   | :-------- |
| Read Address Width    | 12 bits   |
| Write Address Width   | 15 bits   |
| Write Data Width      | 16 bits   |
| Serial Write          | Yes       |
| Read Data Width       | 256 bits  |
| Write Enable Required | Yes       |
| Read Enable Required  | No        |

