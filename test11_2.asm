;               CF  OF  SF  ZF  PF
; sub al,al     0   0   0   1   1
; mov al,10H    0   0   0   1   1
; add al,90H    0   0   1   0   1
; mov al,80H    0   0   1   0   1
; add al,80H    1   1   0   1   1
; mov al,0FCH   1   1   0   1   1
; add al,05H    1   0   0   0   0
; mov al,7DH    1   0   0   0   0
; add al,0BH    0   1   1   0   1
