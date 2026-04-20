
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

GPIODATA: .equ 0x3FC 	; Read/Write pins


; LOOKUP TABLES [LUT]
; here we use a lookup table to easily change colors
; since our table is word aligned, we can find the color to set
; based on our index from the map
lookup_colors:
	.word 	black_bg 		; index [0] - black space outside of the player moveable area
	.word 	blue_bg			; 		[1] - player moveable area
	.word 	white			; 		[2] - white character for pellet
	.word 	white			; 		[3] - white character for power pellet
	.word 	yellow			; 		[4] - pacman character
	.word 	cyan_bg			; 		[5] - ghost gate at their spawn

lookup_chars:
	.byte 	" "				; index [0] - black space outside of the player moveable area
	.byte 	" "				; 		[1] - player moveable area
	.byte 	"."				;		[2] - white character for pellet
	.byte 	"o"				; 		[3] - white character for power pellet
	.byte 	"<"				; 		[4] - pacman character
	.byte 	" "				; 		[5] - ghost gate at their spawn

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
paused:		.byte 0			; stores game pause state
									; 0 - not paused
									; 1 - paused
score:				.byte 0 ; user score
lives:				.byte 0 ; user lives
pwr_tmr:		    .byte 0 ; timer for power pellet
pwr_active:			.byte 0 ; 0 = no power, 1 = power pellet eaten
game_active:		.byte 0	; 0 = game is off, 1 = game is active



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


; constants for our game board
board_x_val:			.equ 28		; highest x-coord for our game board
board_y_val:			.equ 31		; highest y-coord for our game board


; ptr to our ANSI LUT
ptr_to_newline:			.word newline
ptr_to_reset: 			.word reset
ptr_to_lookup_colors: 	.word lookup_colors
ptr_to_lookup_chars:	.word lookup_chars
ptr_to_board:			.word board


; ptr to our game logic
ptr_to_paused:			.word paused

ptr_to_lives:		.word lives
ptr_to_score:		.word score
ptr_to_pwr_tmr:  	.word pwr_tmr
ptr_to_pwr_active:	.word pwr_active
ptr_to_gme_active:	.word game_active


lab7:
	PUSH {r4-r12, lr}

	BL uart_init
	BL uart_interrupt_init
	BL gpio_interrupt_init
	BL timer_interrupt_init

	BL output_board
	; Set lives to 4, use Mask
	MOV r4, #0x0F
	LDR r5, ptr_to_lives
	STRB r4, [r5]

	; Set game to ON, for game loop
TURN_GAME_ON:
	MOV r4, #0
	LDR r5, ptr_to_gme_active
	STRB r4, [r5]

	; Set pellet timer to 0, reset power timer
RESET_POWER_PELLET:
	MOV r4, #1
	MOV r10, #11
	LDR r5, ptr_to_pwr_tmr
	STRB r10, [r5]
	LDR r5, ptr_to_pwr_active
	STRB r4, [r5]

game_loop:


	BL CHECK_GHOST				; Checks if player position == ghost position

	LDR r5, ptr_to_pwr_active	; Check if power is active
	LDRB r6, [r5]
	CMP r6, #1
	BEQ DECREMENT_COUNTER		; Decrement counter if it is active


	;LDR r11, ptr_to_gme_active		; Check if the game should continue looping
	;LDRB r12, [r11]
	;CMP r12, #1
	BEQ game_loop

	POP {r4-r12, lr}
	MOV pc, lr

; output the game board to the screen
; we will go through the map array we defined
; and output the style of the individual character
; based on their index in lookup_colors and lookup_chars
output_board:
	PUSH {r4-r12, lr}
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
	BL output_character					; we now have the correct char to set in r0 so we can output it to display both the color and char

	ADD r4, r4, #1						; increment our position in array
	ADD r6, r6, #1						; increment our x coord
	LDR r0, ptr_to_reset
	BL output_string

	B output_check_x

output_check_x_done:
	; after we finish checking a row, we want to skip to a new line to keep outputing

	LDR r0, ptr_to_newline
	BL output_string

	ADD r5, r5, #1						; increment our y coord
	B output_check_y

output_done:
	POP {r4-r12, lr}
	MOV pc, lr




UART0_Handler:
	PUSH {r4-r12, lr}
	; clear uart0 interrupt
	BL uart_clear_interrupt



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




Timer_Handler:
	PUSH {r4-r12, lr}
	; clear timer interrupt
	BL timer_clear_interrupt

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

CHECK_GHOST:					; Checks if the (x,y) position is the same as player
	PUSH {r4-r12, lr}			; Determines what to do next depending on the result
								; If power pellet



	POP {r4-r12, lr}
	MOV pc, lr


YOU_LOSE:
	; lose

NEXT_STAGE:
	; next stage


	.end



