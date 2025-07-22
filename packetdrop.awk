BEGIN {
       pktdrp = 0;
  }
{
 if($1=="D")
{
 pktdrp++;
}
}
END {
        printf "the number of packet dropped is %d \n", pktdrp;
}

