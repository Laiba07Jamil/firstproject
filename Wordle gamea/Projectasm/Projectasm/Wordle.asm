Include irvine32.inc

BUFFER_SIZE = 4096        ; big enough for words file

.data
    fileName   BYTE "words.txt",0
    fileHandle HANDLE ?
    buffer     BYTE BUFFER_SIZE DUP(?)
    bytesRead  DWORD ?

    msg BYTE "Welcome to Wordle Game!",0
    msg1 BYTE "You have 6 attempts to guess the 5 -letter word",0
    msg2 BYTE "  * Green = correct letter in the right place",0
    msg3 BYTE "  * Yellow = letter in the word but wrong place",0
    msg4 BYTE "  * Gray = letter not in the word",0
    msg5 BYTE "You win if you guess the word correctly within 6 tries.",0
    msg6 BYTE "Enter your Guess :",0

    guess1 BYTE 6 DUP(?)
    guess2 BYTE 6 DUP(?)
    guess3 BYTE 6 DUP(?)
    guess4 BYTE 6 DUP(?)
    guess5 BYTE 6 DUP(?)
    guess6 BYTE 6 DUP(?)
    secretword BYTE 6 DUP(?)

.code
     main PROC
     call Clrscr
     mov edx , OFFSET msg
     call WriteString
     call crlf
     mov edx , OFFSET msg1
     call WriteString
     call crlf
     mov edx , OFFSET msg2
     call WriteString
     call crlf
     mov edx , OFFSET msg3
     call WriteString
     call crlf
     mov edx , OFFSET msg4
     call WriteString
     call crlf
     mov edx , OFFSET msg5
     call WriteString
     call crlf
     call crlf
     

     ;-----File Handling-----

     mov edx, OFFSET fileName
    call OpenInputFile
    mov fileHandle, eax
    cmp eax, INVALID_HANDLE_VALUE
    je FileError

    mov eax, fileHandle
    mov edx, OFFSET buffer
    mov ecx, BUFFER_SIZE
    call ReadFromFile
    mov bytesRead, eax

    mov eax, fileHandle
    call CloseFile

     ;-------- Select a random word from the list--------

     call Randomize 
     mov eax , 100
     call RandomRange
     mov ecx , eax
     mov esi , OFFSET buffer

     findword:
     cmp ecx , 0
     je copyWord
     mov al , [esi]
     cmp al , ','
     jne skipchar
     dec ecx
     inc esi 
     jmp findword

     skipchar:
     inc esi
     jmp findword

     copyword:
     mov al , [esi]
     cmp al , ' '
     je skipspace
     jmp startcopy

     skipspace:
     inc esi
     jmp copyword

     startcopy:

     mov edi , OFFSET secretword
     copyloop:

     mov al , [esi]
     cmp al , 0
     je endcopy
     cmp al , ','
     je endcopy
     mov [edi] , al
     inc esi
     inc edi
     jmp copyloop

     endcopy:
     mov byte ptr [edi] , 0

     mov edx , OFFSET secretword
     call WriteString
     call crlf

    FileError:
    exit
main ENDP
END main