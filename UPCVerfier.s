          AREA question, CODE, READONLY
          ENTRY
          MOV R0, #0                            ; initializing register 0 and 1
          MOV R1, #0
          MOV R6, #6                            ; for the counter in the loop, we will loop over two pairs
          LDR R2, =UPC1                          ; point to the start of the UPC as due to a UPC being a 12 character string it converts 12 hexadecimal values which means it needs 3 registers

repeat    LDRB R3, [R2], #1                     ; load byte from address in R2 to R3, then move R2 by #1
          SUB R3, R3, #0x30                     ; turns into integer by removing the 0x30 from ASCII
          ADD R0, R0, R3                        ; for now is the first sum register, so we add the odd index digits to the first sum
          LDRB R3, [R2], #1                     ; move to the next digitBEQ skip
          SUB R3, R3, #0x30                     ; converts ASCII to 
          ADD R1, R1, R3                        ; adds the even index numbers to the second sum
          SUBS R6, R6, #1                       ; one digit is added so you decrement the count and updates flag bits
          BGT repeat                            ; repeat until the counter is 0

          ADD R0, R0, R0, LSL #1                ; multiply the first sum by 3 before adding it (temporary store in R4) 
          ADD R0, R0, R1                        ; adds the check digit to the sum

loop      SUBS R0, R0, #10                      ; used to check if it is divisible by 10
          BGT loop
          
          MOVNE R0, #2                          ; if it is not a valid upc then set R0 to 0
          MOVEQ R0, #1                          ; if valid upc then set R0 to 1
done      B done

          AREA question, DATA, READONLY
UPC       DCB "013800150738"                    ; takes 2 bytes only
UPC1      DCB "060383755577"                    ; same goes for this
UPC2      DCB "065633454712"                    ; same goes for this
          END