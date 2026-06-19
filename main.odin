package main

import "core:fmt"
import "core:unicode/utf8"

main :: proc() {
    // A sample Arabic string: "كتاب" (Kitab - Book)
    // UTF-8 bytes: 0xD9 0x83 0xD8 0xAA 0xD8 0xA7 0xD8 0xA8
    arabic_str := "ٌكتاب"
    
    fmt.printf("Original string: %s\n", arabic_str)
    
    // 1. Correct way to iterate: Decoding UTF-8 runes
    // We cannot use a simple for loop over bytes, as that breaks UTF-8.
    fmt.println("Iterating by rune (code point):")
    
    it := arabic_str
    for len(it) > 0 {
        r, size := utf8.decode_rune_in_string(it)
        
        // Convert the rune to hex to see the underlying Unicode point
        fmt.printf("Rune: %c (U+%04X), Size in bytes: %d\n", r, r, size)
        
        // Move to the next sequence
        it = it[size:]
    }
    
    // 2. Measuring length correctly
    // 'len()' returns bytes, NOT characters. 
    // Use utf8.rune_count_in_string for character count.
    rune_count := utf8.rune_count_in_string(arabic_str)
    byte_count := len(arabic_str)
    
    fmt.printf("\nTotal Bytes: %d\n", byte_count)
    fmt.printf("Total Characters (Runes): %d\n", rune_count)
}