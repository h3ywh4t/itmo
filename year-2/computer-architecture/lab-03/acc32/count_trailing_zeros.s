    .data
input_addr:      .word  0x80
output_addr:     .word  0x84
n:               .word  0x00
counter:         .word  0x00
const_1:         .word  0x01
const_32:        .word  32

    .text

_start:
    load_ind     input_addr                  ; acc <= mem[ mem[input_addr] ]
    store        n                           ; mem[n] <= acc

    load         n                           ; acc <= mem[n]
    beqz         n_zero                      ; if acc == 0 => n_zero

    load_imm     0                           ; acc <= 0
    store        counter                     ; mem[counter] <= acc

count_loop:
    load         n                           ; acc <= mem[n]
    and          const_1                     ; acc <= acc & mem[const_1]
    bnez         end_loop                    ; if acc != 0  => end_loop

    load         counter                     ; acc <= mem[counter]
    add          const_1                     ; acc <= acc + mem[const_1]
    store        counter                     ; mem[counter] <= acc

    load         n                           ; acc <= mem[n]
    shiftr       const_1                     ; acc <= acc >> mem[const_1]
    store        n                           ; mem[n] <= acc

    jmp          count_loop

end_loop:
    load         counter                     ; acc <= mem[counter]
    store_ind    output_addr                 ; mem[ mem[output_addr] ] <= acc
    halt

n_zero:
    load         const_32                    ; acc <= mem[const_32]
    store_ind    output_addr                 ; mem[ mem[output_addr] ]
    halt
