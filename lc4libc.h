/*
 * lc4libc.h
 */

typedef int lc4int; 
typedef unsigned int lc4uint;
typedef char lc4char;

#define TRUE  1
#define FALSE 0

#define NULL (void*)0

#define BLACK  0x0000U
#define WHITE  0xFFFFU
#define GRAY8  0x2108U
#define YELLOW 0x7FF0U
#define RED    0x7C00U
#define ORANGE 0xF600U
#define BLUE   0x0033U
#define GREEN  0x3300U
#define CYAN   0x0770U

/* lc4_puts : Prints out the given string on the ASCII display */
void lc4_puts(lc4uint *str);

/* 
 * lc4_draw_rect : x and y specify the coordinates of the upper left corner of the block you will draw in pixels
 * with respect to the upper left corner of the display, width and height specify the size of the block in pixels
 * color denotes the color to draw the block. This is encoded in a 16 bit word as described in the course slides.
 * See the colors defined above for inspiration.
 */

void lc4_draw_rect(lc4int x, lc4int y, lc4int width, lc4int height, lc4uint color);

void lc4_halt();

/*
 * lc4_getc : Check if the user has typed a new character since the last time you checked.
 * If there is no character returns a -ve value else returns the ASCII code in the lower 7 bits
 */
lc4int lc4_getc();

/* lc4_set_timer : Set the duration of the timer in milliseconds */
void lc4_set_timer(lc4uint timer_value);

/* lc4_check_timer(): Returns the Timer status register value which is -ve if timer has gone off */
lc4int lc4_check_timer();
