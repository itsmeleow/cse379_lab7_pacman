
	.data


; GAME BOARD DATA VALUES
; define ANSI Escape Codes
newline:	.byte 0xD, 0xA, 0
reset:		.string 27, "[0m", 0
red:		.string 27, "[38;5;160m", 0
blue:		.string 27, "[38;5;21m", 0
pink:		.string 27, "[38;5;13m", 0
orange:		.string 27, "[38;5;208m", 0
yellow: 	.string 27, "[38;5;220m", 0
white:		.string 27, "[38;5;252m", 0
black_bg:	.string 27, "[48;5;0m", 0
blue_bg:	.string 27, "[48;5;12m", 0
cyan_bg:	.string 27, "[48;5;50m", 0


; define ANSI Cursor positioning
; cursor position format - ESC[LINE;COLUMN H
; LINE = horizontal row
; COLUMN = verital column
cursor_template:
    .byte 0x1B, "[00;00H", 0
cursor_nomove:	.string 27, "[0A", 0
cursor_up:		.string 27, "[1A", 0
cursor_down: 	.string 27, "[1B", 0
cursor_right: 	.string 27, "[1C", 0
cursor_left:	.string 27, "[1D", 0
cursor_save:	.string 27, "[s", 0
cursor_restore: .string 27, "[u", 0
display_erase:	.string 27, "[2J", 0

pacman_cursor:	.string 27, "[14;23H", 0
blinky_cursor:	.string 27, "[4;3H", 0
pinky_cursor:	.string 27, "[20;29H", 0
inky_cursor:	.string 27, "[11;5H", 0
clyde_cursor:	.string 27, "[3;15H", 0

pacman_loc:				.word 631	; pacman current location on board
blinky_loc:				.word 201	; blinky current location on board
pinky_loc:				.word 132	; pinky current location on board
inky_loc:				.word 50	; inky current location on board
clyde_loc:				.word 808	; clyde current location on board


; LOOKUP TABLES [LUT]
; here we use a lookup table to easily change colors
; since our table is word aligned, we can find the color to set
; based on our index from the map
lookup_colors:
	.word 	black_bg 		; index [0] - black space where player CAN move
	.word 	blue_bg			; 		[1] - outside area where player CANNOT move (walls)
	.word 	white			; 		[2] - white character for pellet
	.word 	white			; 		[3] - white character for power pellet
	.word 	yellow			; 		[4] - pacman character
	.word 	cyan_bg			; 		[5] - ghost gate at their spawn

lookup_chars:
	.byte 	" "				; index [0] - black space where player CAN move
	.byte 	" "				; 		[1] - outside area where player CANNOT move (walls)
	.byte 	"."				;		[2] - white character for pellet
	.byte 	"o"				; 		[3] - white character for power pellet
	.byte 	"<"				; 		[4] - pacman character
	.byte 	" "				; 		[5] - ghost gate at their spawn

; here we use a LUT to update pacman's new direction based on pacman_dir
lookup_cursor:
	.word cursor_nomove		; index [0] - don't move cursor (0) space
	.word cursor_up			;  		[1] - move cursor (up 1) space
	.word cursor_down		;  		[2] - move cursor (down 1) space
	.word cursor_right		;  		[3] - move cursor (right 1) space
	.word cursor_left		;  		[4]	- move cursor (left 1) space

; we use a LUT to loop through all the characters on the board
lookup_game_char_loc:
	.word pacman_loc		; index [0] - pacman current location on board
	.word blinky_loc		; 		[1] - blinky current location on board
	.word pinky_loc			; 		[2] - pinky current location on board
	.word inky_loc			; 		[3] - inky current location on board
	.word clyde_loc			; 		[4] - clyde current location on board

; we use a LUT to loop through all the characters cursors
lookup_char_cursors:
	.word pacman_cursor		; index [0] - pacman cursor
	.word blinky_cursor		; 		[1] - blinky cursor
	.word pinky_cursor		; 		[2] - pinky cursor
	.word inky_cursor		; 		[3] - inky cursor
	.word clyde_cursor		; 		[4] - clyde cursor

; we use a LUT to loop through all the characters colors
lookup_game_char_colors:
	.word yellow			; index [0] - pacman color
	.word red				; 		[1] - blinky color
	.word pink				; 		[2] - pinky color
	.word blue				; 		[3] - inky color
	.word orange			; 		[4] - clyde color

; LUT to loop through all character directions
lookup_char_dir:
	.word pacman_dir		; index [0] - pacman dir
	.word blinky_dir		; 		[1] - blinky dir
	.word pinky_dir			; 		[2] - pinky dir
	.word inky_dir			; 		[3] - inky dir
	.word clyde_dir			; 		[4] - clyde dir


; the game board is a 28 x 31 characters
board:
    ; row 0 to 5
    .byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
    .byte 1,2,2,2,2,2,2,2,2,2,2,2,2,1,1,2,2,2,2,2,2,2,2,2,2,2,2,1
    .byte 1,2,1,1,1,1,2,1,1,1,1,1,2,1,1,2,1,1,1,1,1,2,1,1,1,1,2,1
    .byte 1,3,1,1,1,1,2,1,1,1,1,1,2,1,1,2,1,1,1,1,1,2,1,1,1,1,3,1
    .byte 1,2,1,1,1,1,2,1,1,1,1,1,2,1,1,2,1,1,1,1,1,2,1,1,1,1,2,1
    .byte 1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1
    ; row 6 to 11
    .byte 1,2,1,1,1,1,2,1,1,2,1,1,1,1,1,1,1,1,2,1,1,2,1,1,1,1,2,1
    .byte 1,2,1,1,1,1,2,1,1,2,1,1,1,1,1,1,1,1,2,1,1,2,1,1,1,1,2,1
    .byte 1,2,2,2,2,2,2,1,1,2,2,2,2,1,1,2,2,2,2,1,1,2,2,2,2,2,2,1
    .byte 1,1,1,1,1,1,2,1,1,1,1,1,0,1,1,0,1,1,1,1,1,2,1,1,1,1,1,1
    .byte 0,0,0,0,0,1,2,1,1,1,1,1,0,1,1,0,1,1,1,1,1,2,1,0,0,0,0,0
    .byte 0,0,0,0,0,1,2,1,1,0,0,0,0,0,0,0,0,0,0,1,1,2,1,0,0,0,0,0
    ; row 12 to 17 (center - ghost spawn location)
    .byte 0,0,0,0,0,1,2,1,1,0,1,1,1,5,5,1,1,1,0,1,1,2,1,0,0,0,0,0
    .byte 1,1,1,1,1,1,2,1,1,0,1,0,0,0,0,0,0,1,0,1,1,2,1,1,1,1,1,1
    .byte 0,0,0,0,0,0,2,0,0,0,1,0,0,0,0,0,0,1,0,0,0,2,0,0,0,0,0,0 ; gate to keep ghosts in - row 14
    .byte 1,1,1,1,1,1,2,1,1,0,1,0,0,0,0,0,0,1,0,1,1,2,1,1,1,1,1,1
    .byte 0,0,0,0,0,1,2,1,1,0,1,1,1,1,1,1,1,1,0,1,1,2,1,0,0,0,0,0
    .byte 0,0,0,0,0,1,2,1,1,0,0,0,0,0,0,0,0,0,0,1,1,2,1,0,0,0,0,0
    ; row 18 to 23 (pacman spawn location)
    .byte 0,0,0,0,0,1,2,1,1,0,1,1,1,1,1,1,1,1,0,1,1,2,1,0,0,0,0,0
    .byte 1,1,1,1,1,1,2,1,1,0,1,1,1,1,1,1,1,1,0,1,1,2,1,1,1,1,1,1
    .byte 1,2,2,2,2,2,2,2,2,2,2,2,2,1,1,2,2,2,2,2,2,2,2,2,2,2,2,1
    .byte 1,2,1,1,1,1,2,1,1,1,1,1,2,1,1,2,1,1,1,1,1,2,1,1,1,1,2,1
    .byte 1,2,1,1,1,1,2,1,1,1,1,1,2,1,1,2,1,1,1,1,1,2,1,1,1,1,2,1
    .byte 1,3,2,2,1,1,2,2,2,2,2,2,2,0,0,2,2,2,2,2,2,2,1,1,2,2,3,1 ; pacman spawns here - row 23
    ; row 24 to 30
    .byte 1,1,1,2,1,1,2,1,1,2,1,1,1,1,1,1,1,1,2,1,1,2,1,1,2,1,1,1
    .byte 1,1,1,2,1,1,2,1,1,2,1,1,1,1,1,1,1,1,2,1,1,2,1,1,2,1,1,1
    .byte 1,2,2,2,2,2,2,1,1,2,2,2,2,1,1,2,2,2,2,1,1,2,2,2,2,2,2,1
    .byte 1,2,1,1,1,1,1,1,1,1,1,1,2,1,1,2,1,1,1,1,1,1,1,1,1,1,2,1
    .byte 1,2,1,1,1,1,1,1,1,1,1,1,2,1,1,2,1,1,1,1,1,1,1,1,1,1,2,1
    .byte 1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1
    .byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1


; GAME LOGIC DATA VALUES
; pacman direction, lives, scores, game state, etc.
paused:				.byte 0	; stores game pause state
								; 0 - not paused
								; 1 - paused
score:				.byte 0 ; user score
lives:				.byte 0 ; user lives
pwr_tmr:		    .byte 0 ; timer for power pellet
timer_tick:			.byte 0	; used for if timer refresh occurs
								; 0 - no refresh
								; 1 - refresh
pwr_active:			.byte 0 ; stores if pacman ate power pellet
								; 0 = no power pellet
								; 1 = power pellet eaten
pacman_dir:			.byte 0 ; stores pacmans current direction
								; 0 - stationary
								; 1 - up
								; 2 - down
								; 3 - right
								; 4 - left
pacman_next_dir:	.byte 0	; user inputted direction (same states as pacman_dir but may be invalid, use next_dir if movement is valid)

blinky_dir:			.byte 0 ; stores blinky current direction
								; 0 - stationary
								; 1 - up
								; 2 - down
								; 3 - right
								; 4 - left
pinky_dir:			.byte 0 ; stores pinky current direction
								; 0 - stationary
								; 1 - up
								; 2 - down
								; 3 - right
								; 4 - left
inky_dir:			.byte 0 ; stores inky current direction
								; 0 - stationary
								; 1 - up
								; 2 - down
								; 3 - right
								; 4 - left
clyde_dir:			.byte 0 ; stores clyde current direction
								; 0 - stationary
								; 1 - up
								; 2 - down
								; 3 - right
								; 4 - left



	.text
	; imported subroutines from lab 7 library
	.global uart_init
	.global uart_interrupt_init
	.global uart_clear_interrupt
	.global gpio_init
	.global gpio_interrupt_init
	.global switch_clear_interrupt
	.global timer_init
	.global timer_interrupt_init
	.global timer_clear_interrupt
	.global pause_timer
	.global enable_timer
	.global simple_read_character
	.global output_character
	.global read_string
	.global output_string
	.global turn_all_led_off
	.global turn_red_led_on
	.global turn_blue_led_on
	.global turn_green_led_on

	; subroutines in current file
	.global lab7
	.global UART0_Handler
	.global Switch_Handler
	.global Timer_Handler


GPIODATA: 				.equ 0x3FC 	; Read/Write pins
; constants for our game board
board_x_val:			.equ 28		; highest x-coord for our game board
board_y_val:			.equ 31		; highest y-coord for our game board


pacman_start_loc:		.equ 631	; pacman current location on board
blinky_start_loc:		.equ 200	; blinky current location on board
pinky_start_loc:		.equ 132	; pinky current location on board
inky_start_loc:			.equ 50		; inky current location on board
clyde_start_loc:		.equ 808	; clyde current location on board


; ptr to our ANSI LUT's
ptr_to_newline:					.word newline
ptr_to_reset: 					.word reset
ptr_to_display_erase:			.word display_erase
ptr_to_cursor_template:			.word cursor_template
ptr_to_lookup_colors: 			.word lookup_colors
ptr_to_lookup_chars:			.word lookup_chars
ptr_to_lookup_cursor:			.word lookup_cursor
ptr_to_lookup_game_char_loc: 	.word lookup_game_char_loc
ptr_to_lookup_char_cursors:		.word lookup_char_cursors
ptr_to_lookup_game_char_colors:	.word lookup_game_char_colors
ptr_to_board:					.word board


; ptr to pacman and all ghost locations
ptr_to_pacman_loc:		.word pacman_loc
ptr_to_blinky_loc:		.word blinky_loc
ptr_to_pinky_loc:		.word pinky_loc
ptr_to_inky_loc:		.word inky_loc
ptr_to_clyde_loc:		.word clyde_loc


; ptr to our game logic
ptr_to_paused:			.word paused
ptr_to_score:			.word score
ptr_to_lives:			.word lives
ptr_to_pwr_tmr:  		.word pwr_tmr
ptr_to_pwr_active:		.word pwr_active
ptr_to_timer_tick:		.word timer_tick
ptr_to_pacman_dir: 		.word pacman_dir
ptr_to_pacman_next_dir:	.word pacman_next_dir
ptr_to_blinky_dir:		.word blinky_dir
ptr_to_pinky_dir:		.word pinky_dir
ptr_to_inky_dir:		.word inky_dir
ptr_to_clyde_dir:		.word clyde_dir




lab7:
	PUSH {r4-r12, lr}

	BL uart_init
	BL uart_interrupt_init
	BL gpio_interrupt_init
	BL timer_interrupt_init

	; output initial board
	BL output_board

	; Set lives to 4, use Mask
	MOV r4, #0x0F
	LDR r5, ptr_to_lives
	STRB r4, [r5]

	; initialize timer tick = 0 so don't do anything to board yet
	MOV r4, #0
	LDR r5, ptr_to_timer_tick
	STRB r4, [r5]

	; Set power pellet timer to 0, reset power timer
	MOV r10, #0
	LDR r5, ptr_to_pwr_tmr
	STRB r10, [r5]
	LDR r5, ptr_to_pwr_active
	STRB r10, [r5]

	; we initialize pacman to starting x and y location
	BL reset_pacman_and_ghosts


main_loop:

	;  if game is paused, keep looping to wait for unpause
	LDR r4, ptr_to_paused
	LDRB r5, [r4]
	CMP r5, #1
	BEQ main_loop

	; if timer_tick is 0 (timer_handler didn't trigger), keep looping to wait for timer
	LDR r4, ptr_to_timer_tick
	LDRB r5, [r4]
	CMP r5, #0
	BEQ main_loop

	; if timer_tick is 1, reset to 0 to get ready for next refresh
	MOV r5, #0
	STRB r5, [r4]






	POP {r4-r12, lr}
	MOV pc, lr


; reset pacman and ghost locations
; - set pacman and ghost locations to their respective starting locations
reset_pacman_and_ghosts:
	PUSH {r4-r12, lr}

	LDR r4, ptr_to_pacman_loc
	MOV r5, #pacman_start_loc
	STR r5, [r4]

	LDR r4, ptr_to_blinky_loc
	MOV r5, #blinky_start_loc
	STR r5, [r4]

	LDR r4, ptr_to_pinky_loc
	MOV r5, #pinky_start_loc
	STR r5, [r4]

	LDR r4, ptr_to_inky_loc
	MOV r5, #inky_start_loc
	STR r5, [r4]

	LDR r4, ptr_to_clyde_loc
	MOV r5, #clyde_start_loc
	STR r5, [r4]

	BL move_pacman_and_ghosts

	POP {r4-r12, lr}
	MOV pc, lr




; reset ANSI styling (background and foreground coloring)
reset_ansi:
	PUSH {r4-r12, lr}

	LDR r0, ptr_to_reset
	BL output_string

	POP {r4-r12, lr}
	MOV pc, lr




; output pacman and ghost on board
; we build the ANSI cursor positioning string for pacman and each ghost here
move_pacman_and_ghosts:
	PUSH {r4-r12, lr}

	; we retrieve the location of our cursor_pos ANSI string here
	LDR r4, ptr_to_lookup_char_cursors
	LDR r5, ptr_to_lookup_game_char_loc

	MOV r6, #0
move_pacman_ghost_loop:

	; r7 would hold the location we want to calculate
	LSL r7, r6, #2
	LDRB r7, [r5, r7]
	LDR r7, [r7] 			  ; holds the location of our game character

	MOV r10, #board_x_val     ; r10 = 28 (Divisor)
	UDIV r8, r7, r10          ; r8 = location / 28 (Row / Y-value)
	MUL r9, r8, r10           ; r9 = Row * 28
	SUB r9, r7, r9 			  ; gives us location r7 mod 28 = column we are on (r9 - x-value)

	ADD r8, r8, #1            ; Make y start from index 1 for ANSI
	ADD r9, r9, #1            ; Make x start from index 1 for ANSI

	; calculate the ascii value of the x and y positions
	; for y-value
	MOV r10, #10
	UDIV r11, r8, r10			; y / 10 = (r11) tens place
	MUL r10, r11, r10			; multiply the quotient back
	SUB r10, r8, r10			; y - (r11 * 10) = (r10) ones place
	ADD r10, r10, #0x30			; r10 holds the ascii ones value of y-value
	ADD r8, r11, #0x30			; r8 holds the ascii tens value of y-value

	; for x-value
	MOV r11, #10
	UDIV r7, r9, r11			; x / 10 = (r7) tens place
	MUL r11, r7, r11			; multiply the quotient back
	SUB r9, r9, r11				; x - (r7 * 10) = (r9) ones place
	ADD r9, r9, #0x30			; r10 holds the ascii ones value of x-value
	ADD r7, r7, #0x30			; r7 holds the ascii tens value of x-value

	LDR r12, ptr_to_cursor_template
	; ESC[y;xH
	STRB r8, [r12, #2]
	STRB r10, [r12, #3]
	STRB r7, [r12, #5]
	STRB r9, [r12, #6]
	; here we store to the cursor template with ESC[y;xH

	MOV r0, r12 		; first, set the cursor to that position
	BL output_string

	; output color (yellow, pink, red, blue, orange)
	LDR r8, ptr_to_lookup_game_char_colors
	LSL r9, r6, #2
	LDR r0, [r8, r9]					; index 4 in our lookup_colors table
	BL output_string
	; output character (<) or (A)
	CMP r6, #0
	ITE EQ
	MOVEQ r0, #0x3C						; pacman game character (<) if our index is 0
	MOVNE r0, #0x41						; else, just (A) for ghosts
	BL output_character

	ADD r6, r6, #1
	CMP r6, #5
	BNE move_pacman_ghost_loop

move_pacman_ghost_loop_done:
	POP {r4-r12}
	MOV pc, lr




; output the game board to the screen
; we will go through the map array we defined
; and output the style of the individual character
; based on their index in lookup_colors and lookup_chars
output_board:
	PUSH {r4-r12, lr}

	LDR r0, ptr_to_display_erase
    BL output_string               		; Send ESC[2J for clear screen command

	MOV r4, #0 							; holds our actual position in the array, each element is a byte of data
	MOV r5, #0							; holds the current y coord [0-30] in the map
; loop through each row and column
output_check_y:
	CMP r5, #board_y_val
	BEQ output_done
	MOV r6, #0							; holds the current x coord [0-27] in the map

output_check_x:
	CMP r6, #board_x_val
	BEQ output_check_x_done

	; find the index value of our current character
	LDR r7, ptr_to_board				; holds the location of our game board
	LDRB r7, [r7, r4]					; load the character byte at out posiiton in array

	; based on the val of the character byte, set the color based on the lookup tables
	; we stored the colors as words so we need to (x 4) to get the correct location
	LDR r8, ptr_to_lookup_colors
	LSL r9, r7, #2
	LDR r0, [r8, r9]					; we now have the correct color to set in r0 so we can output it to set it
	BL output_string

	; same thing but with character, we stored as bytes so no need to modify our character byte val
	LDR r8, ptr_to_lookup_chars
	LDRB r0, [r8, r7]
	BL output_character					; we now have the correct char to set in r0 so we can output it
										; to display both the color and char

	ADD r4, r4, #1						; increment our position in array
	ADD r6, r6, #1						; increment our x coord
	LDR r0, ptr_to_reset
	BL output_string

	B output_check_x

output_check_x_done:
	; after we finish checking a row, we want to print a newline for the next row

	LDR r0, ptr_to_newline
	BL output_string

	ADD r5, r5, #1						; increment our y coord
	B output_check_y

output_done:
	POP {r4-r12, lr}
	MOV pc, lr




; set pacmans next direction here
; -> simply set pacman_next_dir to (w,a,s,d) to (1,4,2,3) based on r0 set by UART0_Handler
; -> ignore if the users desired direction is valid or not here
set_pacman_next_dir:
	PUSH {r4-r12, lr}

	MOV r4, #0			; r4 will store the temp value for pacman_next_dir

	CMP r0, #0x77		; hex for 'w' or UP
	MOVEQ r4, #1

	CMP r0, #0x73		; hex for 's' or DOWN
	MOVEQ r4, #2

	CMP r0, #0x64		; hex for 'd' or RIGHT
	MOVEQ r4, #3

	CMP r0, #0x61		; hex for 'a' or LEFT
	MOVEQ r4, #4

	; if key was not equal to (w,a,s,d), keep current pacman_next_dir
	CMP r4, #0
	BEQ set_pacman_next_dir_done

	; store r4 in pacman_next_dir
	LDR r5, ptr_to_pacman_next_dir
	STRB r4, [r5]

set_pacman_next_dir_done:
	POP {r4-r12, lr}
	MOV pc, lr




; we only need the UART0 handler to handle setting the direction pacman will go next
UART0_Handler:
	PUSH {r4-r12, lr}
	; clear uart0 interrupt
	BL uart_clear_interrupt

	; read the character passed to our UART0 Data Register
	BL simple_read_character

	; set pacman next direction
	BL set_pacman_next_dir


	POP {r4-r12, lr}
	BX lr




Switch_Handler:
	PUSH {r4-r12, lr}
	; clear switch interrupt
	BL switch_clear_interrupt

	; inverts the paused state (pause -> resume ; resume -> pause)
	LDR r4, ptr_to_paused
	LDRB r5, [r4]
	MOV r6, #1
	EOR r5, r5, r6
	STRB r5, [r4]

	CMP r5, #1
	BNE resume_game

pause_game:
	BL pause_timer
	B switch_done

resume_game:
	BL enable_timer

switch_done:

	POP {r4-r12, lr}
	BX lr




; we only refresh pacman and the ghosts here and use this to implement power pellet time
Timer_Handler:
	PUSH {r4-r12, lr}
	; clear timer interrupt
	BL timer_clear_interrupt

	; set timer_tick so our main_loop knows that a refresh occured
	LDR r4, ptr_to_timer_tick
	MOV r5, #1
	STRB r5, [r4]

	POP {r4-r12, lr}
	BX lr




LOSE_LIFE: ; Checks how many lives, then removes a life
	; Add some sort of pause when life taken

	LDR r4, ptr_to_lives
	LDRB r5, [r4]
	CMP r5, #2				; Check if lives are <= 1
	BLT YOU_LOSE			; If less than 1, lose the game

	LSR r5, r5, #1			; Shift right 1 byte, changes mask for LEDs
	STRB r5, [r4]			; Store the new lives count

	MOV pc, lr

POINTS: ; Point counter

GAIN_POWER: ; Indicate when power pellet is active
	PUSH {r4-r12, lr}

	MOV r4, #0x5000 		; Base address of PORT F
	MOVT r4, #0x4002

	LDR r5, ptr_to_pwr_active
	MOV r6, #1
	STRB r6, [r5]			; Set power to 1, = power activated
	LDR r5, ptr_to_pwr_tmr
	MOV r6, #20
	STRB r6, [r5]			; Set timer to 20 ticks (5 seconds), resets everytime power eaten

	BL turn_blue_led_on

	; After 5 seconds it is red.

	POP {r4-r12, lr}
	MOV pc, lr

DECREMENT_COUNTER:
	PUSH {r4-r12, lr}

	LDR r5, ptr_to_pwr_tmr
	LDRB r10, [r5]				; r10 holds tick count
	MOV r9, #0					; r9 used for LED register mask and cmp tick = 0

POWEROUT:						; If power ran out
	CMP r10, r9
	BNE STILLACTIVE
	BL turn_all_led_off
	LDR r11, ptr_to_pwr_active
	STRB r9, [r11]				; Set power = 0, NO POWER
	B DECREMENT_DONE

STILLACTIVE:					; Decrement power timer
	SUB r6, r10, #1
	STRB r6, [r5]

	CMP r10, #10				; Checks if 5 seconds left (>10 ticks)
	BGT DECREMENT_DONE


	BL turn_red_led_on

DECREMENT_DONE:
	POP {r4-r12, lr}
	MOV pc, lr

YOU_LOSE:
	; lose

NEXT_STAGE:
	; next stage


	.end



