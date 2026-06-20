package main

import "core:fmt"
import "core:unicode/utf8"
import "core:strings"

Token_Type :: enum {
    Verb,
    Noun,
    Clitic, // like baa in billahi 
    Diacritic, // harakat
    Root,
    Letter
}

Token :: struct {
    rune_: rune,
    type: Token_Type,
    diacritic_arr: []rune
}

process_rune :: proc(codepoint: rune) -> (token_type: Token_Type) {
    switch codepoint {
    case 1570..=1610:
        token_type = .Letter
    case 1611..=1618:
        token_type = .Diacritic
    } 
    return 
}

main :: proc() {
    // A sample Arabic string: "كتاب" (Kitab - Book)
    // UTF-8 bytes: 0xD9 0x83 0xD8 0xAA 0xD8 0xA7 0xD8 0xA8
    arabic_str := " ِكتَابُ "
    
    fmt.printf("Original string: %s\n", arabic_str)
    trimmed_str := strings.trim_space(arabic_str)
    // Task 1 is just the below line.
    master_rune_arr:= utf8.string_to_runes(trimmed_str)
    for codepoint in master_rune_arr {
        token_type := process_rune(codepoint)
        fmt.println(token_type)
    }
    
    // 2. Measuring length correctly
    // 'len()' returns bytes, NOT characters. 
    // Use utf8.rune_count_in_string for character count.
    rune_count := utf8.rune_count_in_string(arabic_str)
    byte_count := len(arabic_str)
    
    fmt.printf("\nTotal Bytes: %d\n", byte_count)
    fmt.printf("Total Characters (Runes): %d\n", rune_count)
}