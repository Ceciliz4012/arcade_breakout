# arcade_breakout
A version of the classic arcade game breakout, which will run under PennSim (a virtual environment at UPenn).
There is a single paddle that you can move right or left at the bottom of the screen and a ball which bounces around knocking out the bricks in the game area. If the ball gets past the paddle you lose a life. The more bricks you remove, the higher your score.

### breakout.c: 
The main program file, containing all major game functionalities.

### libc.asm: 
An assembly file containing some utility routines for accessing the operating system.

### lc4lib.h: 
A header file detailing the functions available from libc.asm. 

### os.asm: 
The operating system containing traps that perform various I/O operations.

### breakout_script: 
A PennSim script for assembling  and loading all the gamecode. 


<img width="321" alt="Screen Shot 2021-08-17 at 9 35 05 AM" src="https://user-images.githubusercontent.com/71328646/129649729-5f3dd758-4ecc-4260-89e7-db6f54fc9456.png">





