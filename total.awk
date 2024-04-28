BEGIN {
    FS = ","
    OFS = ","    
}
NR == 1 {
    print $0
}
NR >= 2 {
    i = NF
    sum=0
    for (j = 3; j <= NF; j++) {
       sum += $j
    }
    print $0,sum
}