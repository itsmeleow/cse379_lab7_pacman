
GPIODATA: .equ 0x3FC 	; Read/Write pins


score:				.byte 0 ; user score
lives:				.byte 0 ; user lives


	.text
	.global uart_init
	.global uart_interrupt_init
	.global uart_clear_interrupt
	.global gpio_init
	.global gpio_interrupt_init
	.global switch_clear_interrupt
	.global timer_init
	.global timer_interrupt_init
	.global timer_clear_interrupt
	.global simple_read_character
	.global output_character
	.global read_string
	.global output_string

	.global UART0_Handler
	.global Switch_Handler
	.global Timer_Handler

ptr_to_lives:		.word lives
ptr_to_score:		.word score

lab7:
	PUSH {r4-r12, lr}

	BL uart_init
	BL uart_interrupt_init
	BL gpio_interrupt_init
	BL timer_interrupt_init

	; Set lives to 4, use Mask
	MOV r4, #0x0F
	LDR r0, ptr_to_lives
	STRB r4, [r0]




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

	LDRB r4, ptr_to_lives
	CMP r4, #2				; Check if lives are <= 1
	BLT YOU_LOSE			; If less than 1, lose the game

	LSR r4, r4, #1			; Shift right 1 byte, changes mask for LEDs
	STRB r4, ptr_to_lives	; Store the new lives count

	MOV pc, lr

POINTS: ; Point counter

RGB_LED: ; Indicate when power pellet is active

	MOV r4, #0x5000 		; Base address of PORT F
	MOVT r4, #0x4002

	LDRB r5, [r4, #GPIODATA]; Data Register
	ORR r5, r5, #0x004
	STRB r5, [r4, #GPIODATA]

	MOV pc, lr

YOU_LOSE:
	; lose


	.end


