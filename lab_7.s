
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
    .byte 0x1B, "[23;13H", 0
cursor_nomove:	.string 27, "[0A", 0
cursor_up:		.string 27, "[1A", 0
cursor_down: 	.string 27, "[1B", 0
cursor_right: 	.string 27, "[1C", 0
cursor_left:	.string 27, "[1D", 0
cursor_save:	.string 27, "[s", 0
cursor_restore: .string 27, "[u", 0
display_erase:	.string 27, "[2J", 27, "[H", 0		; erase display and set cursor to (0,0)

; displayed in middle of the board when ready/pause/blank (game started)
ready_text:		.string 27, "[18;12HREADY!", 0
paused_text:	.string 27, "[18;12HPAUSED", 0
blank_text:		.string 27, "[18;12H      ", 0

score_label:	.string 27, "[33;1HSCORE: 0000", 0


pacman_loc:				.word 657	; pacman current location on board
blinky_loc:				.word 376	; blinky current location on board
pinky_loc:				.word 379	; pinky current location on board
inky_loc:				.word 404	; inky current location on board
clyde_loc:				.word 407	; clyde current location on board

pacman_old_loc:		.word 657
blinky_old_loc:		.word 376
pinky_old_loc:		.word 379
inky_old_loc:		.word 404
clyde_old_loc:		.word 407


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

lookup_dir_change:
	.word 0					; index [0] - don't move
	.word -28				;  		[1] - (up 1) space
	.word 28				;  		[2] - (down 1) space
	.word 1					;  		[3] - (right 1) space
	.word -1				;  		[4]	- (left 1) space

; we use a LUT to loop through all the characters on the board
lookup_game_char_loc:
	.word pacman_loc		; index [0] - pacman current location on board
	.word blinky_loc		; 		[1] - blinky current location on board
	.word pinky_loc			; 		[2] - pinky current location on board
	.word inky_loc			; 		[3] - inky current location on board
	.word clyde_loc			; 		[4] - clyde current location on board

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

; stores the old location of each
lookup_old_char_loc:
    .word pacman_old_loc
    .word blinky_old_loc
    .word pinky_old_loc
    .word inky_old_loc
    .word clyde_old_loc


; board that is preserved throughout levels
board_template:
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



; the game board is a 28 x 31 characters
; this board we update to reflect pellets being eaten
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
score:				.word 0 ; user score
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
pellets_remain:		.word 0	; stores the number of pellets that remain on the board
num_ghost_eaten:	.word 0	; stores the number of ghosts eaten (0-3) that corresponds to how many pts awarded, resets every power pellet

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


pacman_start_loc:		.equ 657	; pacman current location on board
blinky_start_loc:		.equ 376	; blinky current location on board
pinky_start_loc:		.equ 379	; pinky current location on board
inky_start_loc:			.equ 404	; inky current location on board
clyde_start_loc:		.equ 407	; clyde current location on board


; ptr to our ANSI LUT's
ptr_to_newline:					.word newline
ptr_to_reset: 					.word reset
ptr_to_display_erase:			.word display_erase
ptr_to_cursor_template:			.word cursor_template
ptr_to_lookup_colors: 			.word lookup_colors
ptr_to_lookup_chars:			.word lookup_chars
ptr_to_lookup_cursor:			.word lookup_cursor
ptr_to_lookup_dir_change:		.word lookup_dir_change
ptr_to_lookup_game_char_loc: 	.word lookup_game_char_loc
ptr_to_lookup_game_char_colors:	.word lookup_game_char_colors
ptr_to_lookup_old_char_loc:		.word lookup_old_char_loc
ptr_to_board_template:			.word board_template
ptr_to_board:					.word board

ptr_to_ready_text:	.word ready_text
ptr_to_paused_text:	.word paused_text
ptr_to_blank_text:	.word blank_text
ptr_to_score_label:	.word score_label

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
ptr_to_pellets_remain: 	.word pellets_remain
ptr_to_num_ghost_eaten:	.word num_ghost_eaten



lab7:
	PUSH {r4-r12, lr}

	BL uart_init
	BL uart_interrupt_init
	BL gpio_interrupt_init
	BL timer_interrupt_init

	; output initial board
	BL reset_board_and_pellets
	BL output_board

	; print ready text in middle of board
	LDR r0, ptr_to_ready_text
	BL output_string

	LDR r0, ptr_to_score_label
	BL output_string

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

	; delete the ready text
	LDR r0, ptr_to_blank_text
	BL output_string

; this will be where our main game logic is and will keep on looping
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

	BL save_old_char_locs
	BL set_pacman_loc
	BL check_ghost_touched
	BL set_all_ghost_locs
	BL check_ghost_touched
	BL output_pacman_and_ghosts
	BL display_score

	B main_loop

	POP {r4-r12, lr}
	MOV pc, lr




; copy board_template into board so board contains pellets/walls for next level
; sets the number of pellets_remain
reset_board_and_pellets:
    PUSH {r4-r12, lr}

    LDR r4, ptr_to_board_template
    LDR r5, ptr_to_board
    MOV r6, #0					; index on the board
    MOV r12, #0					; number of pellets on the board

reset_board_loop:
    CMP r6, #868				; 28 x 31 board gives 868 available spaces
    BEQ reset_board_done

    LDRB r7, [r4, r6]
    CMP r7, #2					; if that space has a pellet, increment number of pellets
    IT EQ
    ADDEQ r12, r12, #1
    CMP r7, #3					; if that space has a power pellet, increment number of pellets
    IT EQ
    ADDEQ r12, r12, #1
    STRB r7, [r5, r6]

    ADD r6, r6, #1
    B reset_board_loop

reset_board_done:
	LDR r10, ptr_to_pellets_remain
	STR r12, [r10]				; store the total pellets in pellets_remain

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

	POP {r4-r12, lr}
	MOV pc, lr




; save current pacman/ghost locations into old locations before setting new location
save_old_char_locs:
	PUSH {r4-r12, lr}

	LDR r4, ptr_to_lookup_game_char_loc
	LDR r5, ptr_to_lookup_old_char_loc
	MOV r6, #0

save_old_char_loc_loop:
	LSL r7, r6, #2

	LDR r8, [r4, r7]		; ptr to characters current loc
	LDR r9, [r8]			; r9 is characters current board index

	LDR r10, [r5, r7]		; ptr to characters old loc
	STR r9, [r10]			; store r9 current at r10 old loc

	ADD r6, r6, #1
	CMP r6, #5
	BNE save_old_char_loc_loop

	POP {r4-r12, lr}
	MOV pc, lr




; set pacman location (pacman_loc) using pacman_next_dir (if valid - NOT WALL) or pacman_dir (keep moving in current direction)
; check if
set_pacman_loc:
	PUSH {r4-r12, lr}

	LDR r4, ptr_to_pacman_loc
	LDR r5, [r4]				; r5 is pacman's current location

	MOV r12, #0					; r12 will store if pacman_next_dir was checked yet
test_valid_loop:
	; here we check if pacman_next_dir is valid first, meaning if the next space is NOT A WALL
	; if not, we use pacman_dir
	; if pacman_dir is also invalid, reset pacman_dir to 0 to make pacman stationary
	CMP r12, #0
	ITTEE EQ
	LDREQ r6, ptr_to_pacman_next_dir
	LDRBEQ r6, [r6]				; if checking pacman_next_dir, r6 is pacman's next direction
	LDRNE r6, ptr_to_pacman_dir
	LDRBNE r6, [r6]				; if checking pacman_dir, r6 is pacman's current direction

	MOV r7, r5					; r7 will hold the temp location we calculate

	CMP r6, #1					; if pacman_next_dir = 1 = UP
	BEQ test_valid_up
	CMP r6, #2					; if pacman_next_dir = 2 = DOWN
	BEQ test_valid_down
	CMP r6, #3					; if pacman_next_dir = 3 = RIGHT
	BEQ test_valid_right
	CMP r6, #4					; if pacman_next_dir = 4 = LEFT
	BEQ test_valid_left

	; if dir was invalid or 0
	B test_dir_failed

test_valid_up:
	SUB r7, r5, #28				; every row is 28 values so -28 will put us on the previous row
	B test_valid_check

test_valid_down:
	ADD r7, r5, #28				; + 28 to move to next row
	B test_valid_check

test_valid_right:
	ADD r7, r5, #1				; + 1 to move right 1 space or column
	B test_valid_check

test_valid_left:
	SUB r7, r5, #1				; -1 to move left 1 space or column
	B test_valid_check

test_valid_check:
	; check if the space is a WALL or value = 1 on board array
	LDR r8, ptr_to_board
	LDRB r8, [r8, r7]
	CMP r8, #1
	BEQ test_dir_failed
	; check if the space is a GHOST GATE or value = 5 on board array
	CMP r8, #5
	BEQ test_dir_failed


	STR r7, [r4]				; since the location is valid, store in pacman_loc

    ; check what pacman will move on to on the board
    LDR r8, ptr_to_board
    LDRB r9, [r8, r7]

    CMP r9, #2					; check if normal pellet
    BEQ ate_normal_pellet
    CMP r9, #3
    BEQ ate_power_pellet		; check if power pellet
    B no_pellets

ate_normal_pellet:
    ; clear the pellet tile
    MOV r10, #0
    STRB r10, [r8, r7]

    ; decrement pellets_remain
    LDR r11, ptr_to_pellets_remain
    LDR r10, [r11]
    SUB r10, r10, #1
    STR r10, [r11]

    BL score_10_points
    CMP r10, #0
    BEQ NEXT_STAGE
    B no_pellets

ate_power_pellet:
    ; clear the power pellet tile
    MOV r10, #0
    STRB r10, [r8, r7]

    ; decrement pellets_remain
    LDR r11, ptr_to_pellets_remain
    LDR r10, [r11]
    SUB r10, r10, #1
    STR r10, [r11]

	BL score_10_points
    BL GAIN_POWER

    CMP r10, #0
    BEQ NEXT_STAGE

no_pellets:
	; if pacman_next_dir was valid, make pacman_dir = pacman_next_dir
	CMP r12, #0
	ITT EQ
	LDREQ r11, ptr_to_pacman_dir
	STRBEQ r6, [r11]			; r6 would still hold our pacman_next_dir

	B set_pacman_loc_done

test_dir_failed:
	CMP r12, #0
	BEQ signal_check_current_dir

	; if both next and current directions are invalid (walls), make pacman stationary
	LDR r11, ptr_to_pacman_dir
	MOV r10, #0
	STRB r10, [r11]
	B set_pacman_loc_done

signal_check_current_dir:
	MOV r12, #1
	B test_valid_loop

set_pacman_loc_done:
	POP {r4-r12, lr}
	MOV pc, lr




; set one ghost location using its current direction first
; if current direction is invalid, try other directions
; do not allow, reverse unless no other direction works
; preserved registers used here
;   r1 = ptr to ghost location
;   r2 = ptr to ghost direction
set_ghost_loc:
	PUSH {r4-r12, lr}

	MOV r4, r1					; r4 = ptr to ghost loc
	MOV r5, r2					; r5 = ptr to ghost dir

	LDR r6, [r4]				; r6 = ghost current location
	LDRB r7, [r5]				; r7 = ghost current direction

	; r12 which direction we are checking we are in:
			; 0 = try ghost current dir
			; 1 = try up
			; 2 = try down
			; 3 = try right
			; 4 = try left
			; 5 = try reverse dir as last resort
	MOV r12, #0

ghost_test_loop:
	; choose direction to test into r8
	CMP r12, #0
	BEQ use_current_dir
	CMP r12, #1
	BEQ use_up
	CMP r12, #2
	BEQ use_down
	CMP r12, #3
	BEQ use_right
	CMP r12, #4
	BEQ use_left
	CMP r12, #5
	BEQ use_reverse
	B ghost_stop

use_current_dir:
	MOV r8, r7
	B ghost_skip_reverse_check

use_up:
	MOV r8, #1
	B ghost_check_reverse

use_down:
	MOV r8, #2
	B ghost_check_reverse

use_right:
	MOV r8, #3
	B ghost_check_reverse

use_left:
	MOV r8, #4
	B ghost_check_reverse

use_reverse:
	; figure out the reverse of current ghost direction
	MOV r8, #0
	CMP r7, #1
	IT EQ
	MOVEQ r8, #2
	CMP r7, #2
	IT EQ
	MOVEQ r8, #1
	CMP r7, #3
	IT EQ
	MOVEQ r8, #4
	CMP r7, #4
	IT EQ
	MOVEQ r8, #3
	B ghost_skip_reverse_check

ghost_check_reverse:
	; when trying alternate directions, skip the reverse direction
	; if up != or cannot move down, down != up, right != left, left != right
	CMP r7, #1
	BEQ rev_from_up
	CMP r7, #2
	BEQ rev_from_down
	CMP r7, #3
	BEQ rev_from_right
	CMP r7, #4
	BEQ rev_from_left
	B ghost_skip_reverse_check

rev_from_up:
	CMP r8, #2
	BEQ ghost_try_next_choice
	B ghost_skip_reverse_check

rev_from_down:
	CMP r8, #1
	BEQ ghost_try_next_choice
	B ghost_skip_reverse_check

rev_from_right:
	CMP r8, #4
	BEQ ghost_try_next_choice
	B ghost_skip_reverse_check

rev_from_left:
	CMP r8, #3
	BEQ ghost_try_next_choice

ghost_skip_reverse_check:
	; direction 0 so stationary
	CMP r8, #0
	BEQ ghost_try_next_choice

	; compute candidate next location into r9
	MOV r9, r6
	CMP r8, #1
	BEQ ghost_test_up
	CMP r8, #2
	BEQ ghost_test_down
	CMP r8, #3
	BEQ ghost_test_right
	CMP r8, #4
	BEQ ghost_test_left
	B ghost_try_next_choice

ghost_test_up:
	SUB r9, r6, #28
	B ghost_test_tile

ghost_test_down:
	ADD r9, r6, #28
	B ghost_test_tile

ghost_test_right:
	ADD r9, r6, #1
	B ghost_test_tile

ghost_test_left:
	SUB r9, r6, #1

ghost_test_tile:
	; check if space is wall
	LDR r10, ptr_to_board
	LDRB r11, [r10, r9]
	CMP r11, #1
	BEQ ghost_try_next_choice

	; if not a wall, the location is valid so we can store new location and new direction
	STR r9, [r4]
	STRB r8, [r5]
	B ghost_done

ghost_try_next_choice:
	ADD r12, r12, #1
	CMP r12, #6
	BLT ghost_test_loop

ghost_stop:
	; no valid direction found, leave ghost where it is
ghost_done:
	POP {r4-r12, lr}
	MOV pc, lr




; set all ghost location
; for blinky, pinky, inky, clyde
set_all_ghost_locs:
	PUSH {r4-r12, lr}

	LDR r4, ptr_to_blinky_loc
	LDR r5, ptr_to_blinky_dir
	MOV r1, r4
	MOV r2, r5
	BL set_ghost_loc

	LDR r4, ptr_to_pinky_loc
	LDR r5, ptr_to_pinky_dir
	MOV r1, r4
	MOV r2, r5
	BL set_ghost_loc

	LDR r4, ptr_to_inky_loc
	LDR r5, ptr_to_inky_dir
	MOV r1, r4
	MOV r2, r5
	BL set_ghost_loc

	LDR r4, ptr_to_clyde_loc
	LDR r5, ptr_to_clyde_dir
	MOV r1, r4
	MOV r2, r5
	BL set_ghost_loc

	POP {r4-r12, lr}
	MOV pc, lr




; check if pacman touches any of the ghosts
; if power pellet is active, the ghost gets eaten and gets reset back to starting location
; if power pellet is NOT active, pacman loses a life
check_ghost_touched:
	PUSH {r4-r12, lr}

	LDR r4, ptr_to_pacman_loc
	LDR r4, [r4]					; r4 will hold pacmans location

	; check pacmans location compared to the ghost locations

	LDR r5, ptr_to_blinky_loc
	LDR r5, [r5]
	CMP r4, r5
	BEQ pacman_touched_blinky

	LDR r5, ptr_to_pinky_loc
	LDR r5, [r5]
	CMP r4, r5
	BEQ pacman_touched_pinky

	LDR r5, ptr_to_inky_loc
	LDR r5, [r5]
	CMP r4, r5
	BEQ pacman_touched_inky

	LDR r5, ptr_to_clyde_loc
	LDR r5, [r5]
	CMP r4, r5
	BEQ pacman_touched_clyde

	B check_ghost_touched_done

; if pacman location = any of the ghost loc
; for each of the ghosts, check if the pwr pellet is active
; if it is, the ghost gets eaten
; if it is not, pacman loses a life then check_ghost_touched finishes
pacman_touched_blinky:
	LDR r6, ptr_to_pwr_active
	LDRB r6, [r6]
	CMP r6, #1
	BEQ eat_blinky
	BL LOSE_LIFE
	B check_ghost_touched_done

eat_blinky:
	LDR r5, ptr_to_blinky_loc
	MOV r6, #blinky_start_loc
	STR r6, [r5]
	LDR r5, ptr_to_blinky_dir
	MOV r6, #0
	STRB r6, [r5]
	BL add_ghost_points
	B check_ghost_touched_done


pacman_touched_pinky:
	LDR r6, ptr_to_pwr_active
	LDRB r6, [r6]
	CMP r6, #1
	BEQ eat_pinky
	BL LOSE_LIFE
	B check_ghost_touched_done

eat_pinky:
	LDR r5, ptr_to_pinky_loc
	MOV r6, #pinky_start_loc
	STR r6, [r5]
	LDR r5, ptr_to_pinky_dir
	MOV r6, #0
	STRB r6, [r5]
	BL add_ghost_points
	B check_ghost_touched_done


pacman_touched_inky:
	LDR r6, ptr_to_pwr_active
	LDRB r6, [r6]
	CMP r6, #1
	BEQ eat_inky
	BL LOSE_LIFE
	B check_ghost_touched_done

eat_inky:
	LDR r5, ptr_to_inky_loc
	MOV r6, #inky_start_loc
	STR r6, [r5]
	LDR r5, ptr_to_inky_dir
	MOV r6, #0
	STRB r6, [r5]
	BL add_ghost_points
	B check_ghost_touched_done


pacman_touched_clyde:
	LDR r6, ptr_to_pwr_active
	LDRB r6, [r6]
	CMP r6, #1
	BEQ eat_clyde
	BL LOSE_LIFE
	B check_ghost_touched_done

eat_clyde:
	LDR r5, ptr_to_clyde_loc
	MOV r6, #clyde_start_loc
	STR r6, [r5]
	LDR r5, ptr_to_clyde_dir
	MOV r6, #0
	STRB r6, [r5]
	BL add_ghost_points
	B check_ghost_touched_done


check_ghost_touched_done:
	POP {r4-r12, lr}
	MOV pc, lr




; reset ANSI styling (background and foreground coloring)
reset_ansi:
	PUSH {r4-r12, lr}

	LDR r0, ptr_to_reset
	BL output_string

	POP {r4-r12, lr}
	MOV pc, lr




; output pacman and ghost on board based on their current LOC and erase from old LOC (replace with board value)
; we build the ANSI cursor positioning string for pacman and each ghost here
output_pacman_and_ghosts:
	PUSH {r4-r12, lr}

	MOV r4, #0				; holds where we erased old LOC yet (0) - no (1) - yes
erase_loop:
	CMP r4, #0
	ITE EQ
	LDREQ r5, ptr_to_lookup_old_char_loc
	LDRNE r5, ptr_to_lookup_game_char_loc		; if we erased the old LOC, move on to outputting the new location

	MOV r6, #0				; loop variable to go through the game_char_loc lookup table
output_pacman_ghost_loop:

	; r7 would hold the location we want to calculate
	LSL r7, r6, #2
	LDR r7, [r5, r7]
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

	; check if we're erasing or outputting
	CMP r4, #1
	BEQ new_position

	; no branch = erase
	LSL r7, r6, #2
	LDR r7, [r5, r7]
	LDR r7, [r7] 			  ; holds the location of our game character
	LDR r8, ptr_to_board		; find what is at that location on board
	LDRB r7, [r8, r7]			; r7 holds value on board

	; output background
	LDR r8, ptr_to_lookup_colors
	LSL r9, r7, #2
	LDR r0, [r8, r9]
	BL output_string

	LDR r8, ptr_to_lookup_chars
	LDRB r0, [r8, r7]
	BL output_character

	B continue_erase_or_output


new_position:
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

continue_erase_or_output:
	BL reset_ansi
	ADD r6, r6, #1
	CMP r6, #5
	BNE output_pacman_ghost_loop

erase_or_output_done:
	CMP r4, #1
	BEQ output_pacman_ghost_loop_done
	MOV r4, #1
	B erase_loop

output_pacman_ghost_loop_done:
	POP {r4-r12, lr}
	MOV pc, lr




; output the game board to the screen
; we will go through the board array we defined
; and output the style of the individual character
; based on their index in lookup_colors and lookup_chars
output_board:
	PUSH {r4-r12, lr}

	LDR r0, ptr_to_display_erase
    BL output_string               		; Send ESC[2J for clear screen command and reset cursor to (0,0)

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
	IT EQ
	MOVEQ r4, #1

	CMP r0, #0x73		; hex for 's' or DOWN
	IT EQ
	MOVEQ r4, #2

	CMP r0, #0x64		; hex for 'd' or RIGHT
	IT EQ
	MOVEQ r4, #3

	CMP r0, #0x61		; hex for 'a' or LEFT
	IT EQ
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
	LDR r0, ptr_to_paused_text
	BL output_string
	BL pause_timer
	B switch_done

resume_game:
	LDR r0, ptr_to_blank_text
	BL output_string
	BL enable_timer

switch_done:

	POP {r4-r12, lr}
	BX lr




; we only use this to update timer_tick so we know when our game needs to be refreshed
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




; scoring subroutines
score_10_points:
	PUSH {r4-r12, lr}

	LDR r4, ptr_to_score
	LDR r5, [r4]
	ADD r5, r5, #10
	STR r5, [r4]

	POP {r4-r12, lr}
	MOV pc, lr




; add points from eating ghosts based on how many ghosts have been eaten
add_ghost_points:
	PUSH {r4-r12, lr}

	LDR r4, ptr_to_num_ghost_eaten
	LDRB r5, [r4]			; how many ghosts already eaten during this power pellet

	MOV r6, #100
	CMP r5, #1
	BEQ add_200
	CMP r5, #2
	BEQ add_400
	CMP r5, #3
	BEQ add_800
	B ghost_add_score

add_200:
	MOV r6, #200
	B ghost_add_score

add_400:
	MOV r6, #400
	B ghost_add_score

add_800:
	MOV r6, #800

ghost_add_score:
	LDR r7, ptr_to_score
	LDR r8, [r7]
	ADD r8, r8, r6
	STR r8, [r7]

	ADD r5, r5, #1
	STRB r5, [r4]

	POP {r4-r12, lr}
	MOV pc, lr




; display score on putty
display_score:
	PUSH {r4-r12, lr}

	LDR r4, ptr_to_score
	LDR r5, [r4]			; r5 holds the total score

	; thousands
	MOV r6, #1000
	UDIV r7, r5, r6
	MUL r8, r7, r6
	SUB r5, r5, r8
	ADD r7, r7, #0x30

	; hundreds
	MOV r6, #100
	UDIV r8, r5, r6
	MUL r9, r8, r6
	SUB r5, r5, r9
	ADD r8, r8, #0x30

	; tens
	MOV r6, #10
	UDIV r9, r5, r6
	MUL r10, r9, r6
	SUB r5, r5, r10
	ADD r9, r9, #0x30

	; ones
	ADD r5, r5, #0x30

	LDR r10, ptr_to_score_label
	STRB r7, [r10, #14]
	STRB r8, [r10, #15]
	STRB r9, [r10, #16]
	STRB r5, [r10, #17]

	MOV r0, r10
	BL output_string

	POP {r4-r12, lr}
	MOV pc, lr




LOSE_LIFE: ; Checks how many lives, then removes a life
	; Add some sort of pause when life taken

	LDR r4, ptr_to_lives
	LDRB r5, [r4]
	CMP r5, #2				; Check if lives are <= 1
	BLT YOU_LOSE			; If less than 1, lose the game

	LSR r5, r5, #1			; Shift right 1 byte, changes mask for LEDs
	STRB r5, [r4]			; Store the new lives count

	BL reset_pacman_and_ghosts

	MOV pc, lr




GAIN_POWER: ; Indicate when power pellet is active
	PUSH {r4-r12, lr}

	MOV r4, #0x5000 		; Base address of PORT F
	MOVT r4, #0x4002

	LDR r5, ptr_to_num_ghost_eaten		; reset the number of ghosts eaten
	MOV r6, #0
	STRB r6, [r5]


	LDR r5, ptr_to_pwr_active
	MOV r6, #1
	STRB r6, [r5]			; Set power to 1, = power activated
	LDR r5, ptr_to_pwr_tmr
	MOV r6, #60
	STRB r6, [r5]			; Set timer to 60 ticks (15 seconds), resets everytime power eaten

	BL turn_blue_led_on

	; After 5 seconds it is red.

	POP {r4-r12, lr}
	MOV pc, lr




; decrement the power pellet timer
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

	BL turn_all_led_off
	BL turn_red_led_on

DECREMENT_DONE:
	POP {r4-r12, lr}
	MOV pc, lr




; game ends when all 4 lives are lost
YOU_LOSE:
	; lose




; move on to next level
; ADD LATER - decrement the refresh rate here
NEXT_STAGE:
	; next stage
	PUSH {r4-r12, lr}

	BL reset_board_and_pellets
	BL reset_pacman_and_ghosts
	BL output_board
	BL output_pacman_and_ghosts

	POP {r4-r12, lr}
	MOV pc, lr




	.end



