.model small
.stack 100h

.data
; Dati del veicolo
modello_macchina db "Ferrari F430", 0
anno_produzione dw 2007
motore_cilindrata db "V8 4.3L", 0
potenza_massima dw 490 ; CV
coppia_massima dw 465 ; Nm
massa db 1450 ; kg

; Sensori e attuatori
NUM_SENSORI equ 10
NUM_ATTUATORI equ 6

dati_sensori db 8500, 280, 4, 95, 1013, 14.7, 0, 50, 80, 85  ; RPM, Velocità, Marcia, Temp. Acqua, Pressione, Lambda, Battito, Olio, Benzina, Liquido Raffreddamento
dati_attuatori db 0, 0, 0, 0, 0, 0 ; Farfalla, Iniettori, Bobine, EGR, Pompa Benzina, Ventola

tabella_tipi_sensori db "RPM", 0, "Velocità", 0, "Marcia", 0, "Temp. Acqua", 0, "Pressione", 0, "Lambda", 0, "Battito", 0, "Olio", 0, "Benzina", 0, "Liquido Raffreddamento", 0
tabella_tipi_attuatori db "Farfalla", 0, "Iniettori", 0, "Bobine", 0, "EGR", 0, "Pompa Benzina", 0, "Ventola", 0

; Mappe Motore (semplificate)
mappa_coppia dw 300, 350, 400, 450, 480, 460, 420, 380, 340, 300 ; Coppia per RPM (x10)
mappa_anticipo db 10, 15, 20, 25, 30, 35, 30, 25, 20, 15 ; Anticipo per RPM (gradi)

; Variabili di controllo
richiesta_coppia dw 0
temperatura_target dw 90 ; Gradi Celsius
pressione_target dw 1013 ; hPa (pressione atmosferica standard)
lambda_target db 14.7 ; Rapporto stechiometrico aria/carburante

; Costanti
MAX_RPM equ 9000

.code

; Funzioni per la gestione dei sensori e degli attuatori (uguali a prima)
; ...

; Funzione per il calcolo della coppia richiesta (aggiornata)
calcola_coppia_richiesta proc
    ; Leggi RPM e posizione farfalla (non mostrata)
    ; ...

    ; Calcola l'indice nella mappa in base a RPM e farfalla
    ; ... (logica più complessa)

    ; Leggi coppia dalla mappa
    mov esi, offset mappa_coppia
    add esi, eax ; Indice nella mappa
    mov ax, [esi] ; Leggi coppia (x10)
    mov richiesta_coppia, ax
    ret
calcola_coppia_richiesta endp

; Funzioni per il controllo del motore (aggiornate)
; ...

; Controllo Bobine (aggiornato)
controlla_bobine proc
    ; Leggi RPM
    mov eax, 0 ; Indice del sensore RPM
    call leggi_sensore

    ; Limita RPM a MAX_RPM
    cmp ax, MAX_RPM
    jle rpm_ok
    mov ax, MAX_RPM

    rpm_ok:
    ; Calcola l'indice nella mappa anticipo
    mov bx, 100
    div bx

    ; Leggi anticipo dalla mappa
    mov esi, offset mappa_anticipo
    add esi, eax ; Indice nella mappa
    mov al, [esi] ; Leggi anticipo (gradi)

    ; Applica l'anticipo alle bobine (non mostrato)
    ; ...
    ret
controlla_bobine endp

; Controllo Anticipo (aggiornato)
controlla_anticipo proc
    ; Leggi sensore battito
    mov eax, 6
    call leggi_sensore

    ; Se battito rilevato, ritarda leggermente l'anticipo
    cmp ax, 0
    je no_battito
    ; ... (logica per ritardare l'anticipo)

    no_battito:
    ret
controlla_anticipo endp

; Funzione principale
inizio:
    ; Inizializzazione (non mostrata)
    ; ...

    ciclo_principale:
        ; Leggi sensori e calcola attuatori
        call calcola_coppia_richiesta
        call controlla_temperatura
        call controlla_pressione
        call calcola_iniezione
        call controlla_bobine
        call controlla_anticipo

        ; ... (altri controlli: limitatore di velocità, controllo trazione, ecc.)

        jmp ciclo_principale

fine inizio
