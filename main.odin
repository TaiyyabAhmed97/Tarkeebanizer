package main

import "core:fmt"
import "core:unicode/utf8"
import "core:strings"

Token_Type :: enum {
    Verb,
    Noun,
    Clitic, // like baa in billahi 
    Diacritic, // harakat
    Root
}

Token :: struct {
    rune_arr: []rune,
    type: Token_Type
}

main :: proc() {
    // A sample Arabic string: "كتاب" (Kitab - Book)
    // UTF-8 bytes: 0xD9 0x83 0xD8 0xAA 0xD8 0xA7 0xD8 0xA8
    arabic_str := " ِكتَابُ "
    
    fmt.printf("Original string: %s\n", arabic_str)
    trimmed_str := strings.trim_space(arabic_str)
    master_rune_arr:= utf8.string_to_runes(trimmed_str)
    
    // 1. Correct way to iterate: Decoding UTF-8 runes
    // We cannot use a simple for loop over bytes, as that breaks UTF-8.
    fmt.println("Iterating by rune (code point):")
    
    it := trimmed_str
    
    space_idx := 0
    for r, index in it{
        // Convert the rune to hex to see the underlying Unicode point
        fmt.printf("Rune: %c (U+%04X)\n", r, r)
        
    }
    
    // 2. Measuring length correctly
    // 'len()' returns bytes, NOT characters. 
    // Use utf8.rune_count_in_string for character count.
    rune_count := utf8.rune_count_in_string(arabic_str)
    byte_count := len(arabic_str)
    
    fmt.printf("\nTotal Bytes: %d\n", byte_count)
    fmt.printf("Total Characters (Runes): %d\n", rune_count)
}