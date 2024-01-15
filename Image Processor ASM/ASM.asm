.data

.code

;void ASMAdjustBrightness(
;	unsigned char* bmpDataScan0, = RCX
;	unsigned char* bmpOrignial,  = RDX
;	short value,                 = R8W
;	int imageSizeinBytes         = R9D
;);

ASMAdjustBrightness proc
	mov r10, 0          ; Set the offset pointer to 0
	cmp r8w, 0          ; Check if if we - or +
	jl SubtractBrightness

	mov r11w, 0ffffh    ; Set my overflow value to 255
MainLoopAdd:
	mov al, byte ptr [rdx + r10] ; Read the next byte from original
	add al, r8b                 ; Add the Brightness
	cmovc ax, r11w              ; Set to 255 on overflow
	mov byte ptr [rcx + r10], al ; Store the answer in Scan0

	inc r10                     ; Move to next byte in arrays
	dec r9d                     ; Decrement our counter
	jnz MainLoopAdd             ; Jump if there is more left
	ret                         ; Return to C++

SubtractBrightness:
	mov r11w, 0                 ; Move 0 into the underflow
	neg r8w                     ; Negate the value to subtract

MainLoopSubtract:
	mov al, byte ptr [rdx + 10] ; Read the next byte from original
	sub al, r8b                 ; Subtract the Brightness
	cmovc ax, r11w              ; Set to 255 on overflow
	mov byte ptr [rcx + 10], al ; Store the answer in Scan0

	inc r10                     ; Move to next byte in arrays
	dec r9d                     ; Decrement our counter
	jnz MainLoopSubtract        ; Jump if there is more left	
	ret

ASMAdjustBrightness endp
end
