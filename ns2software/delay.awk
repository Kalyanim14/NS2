BEGIN {
	seq=0;
}
{
if($4 == "AGT" && $1 == "s"){
	seq=seq+1;
	start_time[$6] = $2;
}else if($4 == "RTR" && $1 == "r"){
	end_time[$6] = $2;
}else if($1 == "D" && $7 == "tcp") {
	end_time[$6] = -1;
} 
}
END {
	for(i=0; i<=seq; i++) {
		if(end_time[i] > 0) {
			delay[i] = end_time[i] - start_time[i];
	                count++;
			printf "%f\t%f\r\n",i, delay[i] >> "delay.xgr"
		}else{
			delay[i] = -1;
			count++;
			delay[i] = end_time[i] - start_time[i];
			printf "%f\t%f\r\n",i, delay[i] >> "delay.xgr"
		}
    }
    for(i=0; i<=seq; i++) {
	if(delay[i] > 0) {
		n_to_n_delay = n_to_n_delay + delay[i];
        }         
    }
    n_to_n_delay = n_to_n_delay/count;
    printf("Packet Delay = %.3f\n",n_to_n_delay);
}
