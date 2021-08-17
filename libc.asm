USER_STACK_ADDR .UCONST x7FFF
USER_STACK_SIZE .UCONST x1000
USER_HEAP_SIZE .UCONST x3000	
;;; Reserve space for heap and stack so that assembler will not try to
;;; place data in these regions
	
.DATA
.ADDR x4000
USER_HEAP	.BLKW x3000
.ADDR x7000			
USER_STACK	.BLKW x1000

.CODE
.ADDR x0000	
	.FALIGN
__start
	LC R6, USER_STACK_ADDR	; Init the Stack Pointer
	LEA R7, main		; Invoke the main routine
	JSRR R7
	TRAP x25		; HALT

;;; Wrappers for the traps.  Marshall the arguments from stack to 
;;; registers and return value from register to stack

	.FALIGN
lc4_puts
	;; prologue
	ADD R6, R6, #-2
	STR R5, R6, #0
	STR R7, R6, #1
	
	LEA R7, STACK_SAVER
	STR R6, R7, #0

	;; marshall arguments
	LDR R0, R6, #2

	TRAP x0B

	;; epilogue
	LEA R7, STACK_SAVER
	LDR R6, R7, #0

	LDR R7, R6, #1
	LDR R5, R6, #0
	ADD R6, R6, #2
	RET

		
	.FALIGN
lc4_getc 
	;; prologue
	ADD R6, R6, #-2
	STR R5, R6, #0
	STR R7, R6, #1
	
	TRAP x00
	
	;;  Mask last 7 bits of returned ASCII code
	CONST R2, x7F
	AND R1, R1, R2
	CMPI R0, 0
	BRn lc4_getc_L1
        ;; Check R0 if MSB = 1 return character else R1 = 0xFFFF
	CONST R1, 0xFF
	HICONST R1, 0xFF
	
lc4_getc_L1	
	LDR R7, R6, #1
	;; save TRAP return value on stack
	STR R1, R6, #1
	;; restore user base-pointer
	LDR R5, R6, #0
	ADD R6, R6, #2
	RET

			
	.FALIGN
lc4_set_timer 
	;; prologue
	ADD R6, R6, #-2
	STR R5, R6, #0
	STR R7, R6, #1
	
	;; marshall arguments
	LDR R0, R6, #2

	TRAP x09
	
	LDR R7, R6, #1
	;; restore user base-pointer
	LDR R5, R6, #0
	ADD R6, R6, #2
	RET

		
	.FALIGN
lc4_check_timer 
	;; prologue
	ADD R6, R6, #-2
	STR R5, R6, #0
	STR R7, R6, #1
	
	TRAP x0A
	
	LDR R7, R6, #1
	;; save TRAP return value on stack
	STR R0, R6, #1
	;; restore user base-pointer
	LDR R5, R6, #0
	ADD R6, R6, #2
	RET
	
	.FALIGN
lc4_draw_rect
	;; prologue
	ADD R6, R6, #-2
	STR R5, R6, #0
	STR R7, R6, #1
	;; marshall arguments
	LDR R0, R6, #2		; x
	LDR R1, R6, #3		; y
	LDR R2, R6, #4		; width
	LDR R3, R6, #5		; height
	LDR R4, R6, #6		; color

	LEA R7, STACK_SAVER
	STR R6, R7, #0
	
	TRAP x0C
	
	LEA R7, STACK_SAVER
	LDR R6, R7, #0
	
	;; epilogue
	LDR R7, R6, #1
	LDR R5, R6, #0
	ADD R6, R6, #2
	RET
	
	.FALIGN	
lc4_halt
	;; prologue
	ADD R6, R6, #-2
	LDR R5, R6, #0
	STR R7, R6, #1
	;; no arguments
	TRAP x25
	;; epilogue
	LDR R7, R6, #1
	LDR R5, R6, #0
	ADD R6, R6, #2
	RET			

;;; Other library data will start at x2000
;;; This needs to be here so that subsequent files will have their user data
;;;  placed appropriately
.DATA
.ADDR x2000

;;;  We use this storage location to cache the Stack Pointer so that
;;;  we can restore the stack appropriately after a TRAP. It is only
;;;  needed for traps that overwrite R6
STACK_SAVER .FILL 0x0000
