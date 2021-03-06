  .text
  .globl main

main:
  LDR r1, =9347991  /* r1 = dividend */
  LDR r2, =2 /* r2= divisor */
  MOVS r3, #0 /* r3 = quocient */
  CMP r1, r2
  BCC end
  BL alignDivisorLeft
compare:
  CMP r5, #0
  BMI end
  BL divide
  BL shiftDivisorRight
  SUB r5, r5, #1
  B compare
end:
  MOV r5, r1 /* r5 = remainder */
  SWI	0x0

alignDivisorLeft:
  CLZ r0, r1
  CLZ r4, r2
  SUB r5, r4, r0 /* r5 = leading 0 of r2 - leading zero of r1 */
  MOV r2, r2, LSL r5
  MOV	pc, lr

divide:
  MOV r10, lr
  CMP r1, r2
  BCC onlyShiftDivisorToLeft
  SUB r1, r1, r2
  MOV r3, r3, LSL #1
  ADD r3, r3, #1
  B endDivide
onlyShiftDivisorToLeft:
  MOV r3, r3, LSL #1
endDivide:
  MOV lr, r10
  MOV	pc, lr

shiftDivisorRight:
  MOV r2, r2, LSR #1
  MOV	pc, lr
