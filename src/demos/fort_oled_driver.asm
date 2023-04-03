;----------------------------------------------------------------------
; OLED driver 1802 Mini System to call OLED routines from Fortran II
;
; Copyright 2023 by Bernard Murphy
;
; Copyright 2023 by Gaston Williams
;
; Based on code from the Elf-Elfos-OLED library
; Written by Tony Hefner
; Copyright 2022 by Tony Hefner
;
; Based on code from Adafruit_SH110X library
; Written by Limor Fried/Ladyada for Adafruit Industries  
; Copyright 2012 by Adafruit Industries
;
; SPI Expansion Board for the 1802/Mini Computer hardware
; Copyright 2022 by Tony Hefner 
;
;
;
;-----------------------------------------------------------------------


#include ../include/bios.inc
#include ../include/kernel.inc
#include ../include/ops.inc
#include ../include/sh1106.inc
#include ../include/oled.inc
#include ../include/gfx_oled.inc



;#define    debug                      ; uncomment to turn on debug

; Load the driver at 9000h. Note that Fortran II call needs to match!
           org     9000h               ; load program out in unused RAM area
           br      entry
           eever
           db      '(c) Bernard Murphy see https://github.com/BernieMurphy',0 
                   

entry:     equ     $  
           glo     rf
           smi     1                   ; rf.0 = 1 is oled_init
           lbz     oled_init
           smi     1                   ; rf.0 = 2 indicates oled_clear
           lbz     oled_clear
           smi     1
           lbz     oled_pixel          ; rf.0 = 3 indicates oled_pixel 
           smi     1     
           lbz     oled_display        ; rf.0 = 4 indicates oled_display
           smi     1
           lbz     oled_line           ; rf.0 = 5 indicates oled_line 
           smi     1
           lbz     oled_text           ; rf.0 = 6 indicate oled text         
           call    o_inmsg
           db      'OLED driver: bad command parameter',10,13,0
           smi     0
           rtn

oled_init: equ     $
#ifdef     debug
           call    o_inmsg
           db      'OLED driver: init request',10,13,0
#endif
 
           ldi     V_OLED_INIT
           CALL    O_VIDEO          
                      
           clc                         ; success return   
           rtn

oled_clear: equ    $
#ifdef     debug
           call    o_inmsg
           db      'OLED driver: clear request',10,13,0
#endif 
           ldi   V_OLED_CLEAR        ; clear buffer
           call  O_VIDEO
           clc                          ; success return   
           rtn

oled_pixel: equ    $ 
           push    rd
           call    o_inmsg
           db      '.',0             
           push    r7                   ; save Fortran expression reg
           mov     r7,rd                ; copy callers x,y co-ordinates
           mov     rf,buffer            ; point rf to display buffer 
           call    draw_pixel
           pop     r7                   ; restore Fortran expression reg
           pop     rd
           lbdf    error
           clc                           ; success return   
           rtn

error:     equ     $
           mov     rf,cbuffer              
           call    f_hexout4            ; value still in rd for hexout4 
           ldi     0
           str     rf                   ; store terminatorin buffer
           dec     rf
           dec     rf
           dec     rf
           dec     rf                    ; back up pointer for o_msg
           call    o_msg
           call    o_inmsg
           db      'OLED driver: draw_pixel/draw_line/draw_string co-ordinate error',10,13,0
           smi     0                   ; error return
           rtn


oled_display: equ $
#ifdef     debug 
           call  o_inmsg
           db      'OLED driver: display request',10,13,0
#endif
           mov     rf,buffer            ; point rf to display buffer                
           ldi     V_OLED_SHOW
           CALL    O_VIDEO
            
           clc
           rtn


oled_line: equ     $                    ; rc = start line co-ordinates
           push    rd                   ; rd = end line co-ordinates
           call    o_inmsg
           db      '-',0
           push    r8
           mov     r8,rc                ; end x,y co-ordinates             
           push    r7                   ; save Fortran expression reg
           mov     r7,rd                ; start x,y co-ordinates
           mov     rf,buffer            ; point rf to display buffer 
           call    draw_line
           pop     r7                   ; restore Fortran expression reg
           pop     r8                   ; restore R8
           pop     rd                   ; and RD
           lbdf    error
           clc                     ; success return   
           rtn
;
; Inputs: rd = cordinates to draw text
;         rc = -> text string ending in a null
oled_text: equ     $
           push    rd
           call    o_inmsg              ; give feedback 
           db      'T',0
           push    r9
           push    r8
           push    r7
           mov     r7,rd                ; set R7 to beginning of line 
           mov     r8,rc                ; set string buffer address
           ldi     GFX_BG_OPAQUE        ; background cleared
           phi     r9               
           mov     rf,buffer            ; point rf to display buffer                 
           call    draw_string          ; draw character   
           pop     r7
           pop     r8
           pop     r9
           pop     rd
           lbdf    error
           clc                          ; success return   
           rtn

           
buffer:    ds      1024
cbuffer:   ds      32
endrom:    equ     $
           end     entry
