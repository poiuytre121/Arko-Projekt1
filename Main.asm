section .text
;--------------------------------------------
;"Main"
;--------------------------------------------
org 100h
start:
call wypisz_zapytanie_1

;TODO: zliczanie znaków pierwszego ciągu

call wypisz_zapytanie_2

;TODO: zliczanie znaków drugiego ciągu

;TODO: porównanie długości ciągów

jmp start ;zaczyna przetwarzać ciągi od początku
;--------------------------------------------
;koniec głównego programu
;--------------------------------------------

;//funkcje

;///ta funkcja kończy pracę programu i wypisuje wiadomość pożegnalną
koniec:
mov dx,napis_koniec_programu
call wypisz
mov ax,4C00h
int 21h

;///wypisuje ciąg znaków z rejestru dx
wypisz:
mov ah,9
int 21h
ret

;///wypisuje prośbe o podanie pierwszego ciągu znaków
wypisz_zapytanie_1:
mov dx,napis_wczytaj_ciag_1
call wypisz
ret

;///wypisuje prośbe o podanie drugiego ciągu znaków
wypisz_zapytanie_2:
mov dx,napis_wczytaj_ciag_2
call wypisz
ret

;///informuje użytkownika o tej samej długości ciągów
wypisz_wynik_rowne:
mov dx,napis_ciagi_rowne
call wypisz
ret

;///informuje użytkownika o różnej długości ciągów
wypisz_wynik_rozne:
mov dx,napis_ciagi_rozne
call wypisz
ret

section .data
napis_ciagi_rowne db "Given strings have equal length$"
napis_ciagi_rozne db "Givem strings have different lengths$"
napis_wczytaj_ciag_1 db "Enter first string, TAB key ends entering",13,"$"
napis_wczytaj_ciag_2 db "Enter second string, TAB key ends entering",13,"$"
napis_koniec_programu db "Return key was hit, thank you for using this program :)$"