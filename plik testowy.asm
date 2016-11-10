section .text
org 100h

mov ah,1
int 21h

add al,"0"
mov dl,al

mov ah,2
int 21h
mov ax,4C00h
int 21h
;wnioski:
;kod tabulatora = 9
;kod entera = 13