.data

buf:         .byte '____________________________________'
output_addr: .word 0x84
input_addr:  .word 0x80

.text
.org 0x100

_start:
    @p input_addr b!
    lit buf
    lit 1 +
    a!

    lit 0x20
    lit 0
    over

read_input:
    dup
    if overflow

    over
    @b
    lit 255
    and

    dup
    lit -10
    +
    if end_of_input

    check_symbol

    over
    lit 0x5f5f5f00
    +
    !+

    over
    lit -1
    +
    read_input ;

end_of_input:
    drop
    drop

    dup
    lit -32
    +
    if overflow

    lit 0x1f
    xor
    lit 1
    +

    lit buf
    a!
    @
    lit 0xffffff00
    and
    +
    !

go_to_output:
    @p output_addr
    b!

    lit buf
    a!

    @+
    lit 255
    and

output_1:
    dup
    if end

    @+
    lit 255
    and
    !b

    lit -1
    +
    output_1 ;

end:
    halt

overflow:
    @p output_addr
    b!
    lit -858993460
    !b
    end

check_symbol:
    dup
    lit -32
    +
    if space

    over
    if need_to_capitalize

decapitalize:
    dup
    lit -65
    +
    -if upper_than_A
    ret_with_1_flag ;

upper_than_A:
    dup
    lit -91
    +
    -if ret_with_1_flag
    lit 32
    +
    ret_with_1_flag ;

need_to_capitalize:
    dup
    lit -97
    +
    -if upper_than_a
    ret_with_1_flag ;

upper_than_a:
    dup
    lit -123
    +
    -if ret_with_1_flag
    lit -32
    +
    ret_with_1_flag ;

space:
    over
    drop
    lit 0
    ;

ret_with_1_flag:
    lit 1
    ;