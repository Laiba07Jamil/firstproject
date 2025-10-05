Include irvine32.inc
.data
    words BYTE "apple, bread, chair, water, table, plant, light, house, music, dance, smile, laugh, sweet, grass,
    stone, cloud, beach, mount, heart, dream, earth, peace, world, storm, river, field, green, brown, white, black,
    round, glass, fruit, grape, lemon, mango, peach, berry, sound, voice, child, night, sleep, tiger, zebra, horse, 
    sheep, snake, eagle, crowd, happy, angry, brave, clean, clear, quiet, sharp, sweet, smart, proud, large, small, 
    early, later, lucky, crazy, funny, silly, truth, honor, faith, trust, angel, devil, queen, king, crown, sword, 
    flame, light, blaze, shine, spark, train, truck, plane, boats, roads, flour, sugar, spice, honey, bread, drink, 
    water, juice, clock, shirt, pants, dress " , 0


    msg BYTE "Welcome to Wordle Game !" , 0
    msg1 BYTE "You have 6 attempts to guess the 5 -letter word ", 0
    msg2 BYTE "  * Green = correct letter in the right place " , 0
    msg3 BYTE "  * Yellow = letter in the word but wrong place" , 0
    msg4 BYTE "  * Gray = letter not in the word" , 0
    msg5 BYTE "You win if you guess the word correctly within 6 tries.", 0
    msg6 BYTE "Enter your Guess :", 0

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
     mov edx , OFFSET msg6
     call WriteString
     call crlf
     call crlf

     ; Select a random word from the list

     call Randomize 

     mov eax , 100
     call RandomRange
     mov esi , OFFSET words
     mov ecx , eax
     mov eax, ecx
call WriteInt
call Crlf

     findword:
     cmp ecx , 0
     je copyWord
     mov al , [esi]
     cmp al , ','
     jne skipchar
     dec ecx

     skipcomma:
     inc esi 
     jmp findword

     skipchar:
     inc esi
     jmp findword

     copyword:
     mov al , [esi]
     cmp al , ' '
     jne startcopy
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
     call writestring
     call crlf


     mov edx , OFFSET guess1
     mov ecx , SIZEOF guess1
     call ReadString
     call crlf

     exit
main ENDP
END main