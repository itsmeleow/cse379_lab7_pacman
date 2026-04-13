



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




lab7:
	PUSH {r4-r12, lr}

	BL uart_init
	BL uart_interrupt_init
	BL gpio_interrupt_init
	BL timer_interrupt_init




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




	.end


