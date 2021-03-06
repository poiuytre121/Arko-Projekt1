section .text
;--------------------------------------------
;"Main"
;--------------------------------------------
org 100h
start:
call wypisz_zapytanie_1

call zliczaj
push cx ;wrzuca na stos długość ciągu

call wypisz_zapytanie_2

call zliczaj
push cx ;wrzuca na stos długość ciągu

call porownaj

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

;///porównuje długość dwóch ostatnich ciągów znaków
porownaj:
push bp
mov bp,sp
mov bl,[bp+4]
mov bh,[bp+6]
pop bp
cmp bl,bh
je rowne
call wypisz_wynik_rozne
jmp return
rowne:
call wypisz_wynik_rowne
return:
ret

;///wczytuje znak z klawiatury do rejestru al i wyświetla go na ekranie
wczytaj_znak:
mov ah,1
int 21h
ret

;///funkcja zliczająca znaki
zliczaj:
mov cx,0
petla:
call wczytaj_znak ;znak jest w al

cmp al,13
je koniec ;jeżeli to enter wyjdź z programu

call sprawdzenie_znaku ;obsługa niepoprawnych wciśnięć
cmp bl,1
je petla

add cx,1 ;zwiększ wartość licznika długości ciągu

cmp al,9 
jne petla ;jeżeli to nie TAB to pobierz kolejny znak

mov ah,2 ;przenosi kursor do nowej linii
mov dl,10
int 21h
ret
;///funkcja sprawdza, czy podany znak ma kod ascii z przedziału <20;126>
;///jeżeli tak, zwraca 0 do rejestru bl, jeżeli nie zwraca 1 do rejestru bl
sprawdzenie_znaku:
cmp al,9
je dobry_znak

cmp al,0
je znak_zero
cmp al,32
jb zly_znak

cmp al,126
ja zly_znak

dobry_znak:
mov bl,0
ret
znak_zero:
call wczytaj_znak
zly_znak:
mov bl,1
call wypisz_blad
ret

;///wypisuje ciąg znaków z rejestru dx
wypisz:
mov ah,9
int 21h
ret

;///wypisuje informację o błędzie na ekran
wypisz_blad:
mov dx,napis_bledny_znak
call wypisz
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
napis_ciagi_rowne db "Given strings have equal length",10,"$"
napis_ciagi_rozne db "Givem strings have different lengths",10,"$"
napis_wczytaj_ciag_1 db "Enter first string, TAB key ends entering",10,"$"
napis_wczytaj_ciag_2 db "Enter second string, TAB key ends entering",10,"$"
napis_koniec_programu db "Return key was hit, thank you for using this program :)$"
napis_bledny_znak db "This key doesn't match any number, letter or visible sign, please continue entering string using proper characters",10,"$"