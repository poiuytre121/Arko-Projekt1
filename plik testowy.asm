section .text
org 100h
start:
mov ah,8 ;pobiera znak z klawiatury bez echa
int 21h


cmp al,0 ;sprawdza, czy znak pochodzi z rodziny dwuczęściowych kodów
jne dalej
mov ah,8
int 21h
cmp al,79 ;sprawdza czy jest to end, dla home będzie 71
jne dalej
mov dx,napis ;wyświetla napis, jeżeli jest to zadany przycisk
mov ah,9
int 21h
dalej:

mov ax,4C00h
int 21h
;wnioski:
;kod tabulatora = 9
;kod entera = 13
;kod end = (0;79)
;http://brebru.com/asciicodes.html strona z kodami dwuczęściowymi
section .data
napis db "Weszlo$"