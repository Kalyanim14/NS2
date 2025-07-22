{
  strEvent = $1;  rTime = $2;   from_node = $3; to_node = $4;
  pkt_type = $5;    pkt_size = $6;  flgStr = $7;    flow_id = $8;
  src_addr = $9;    dest_addr = $10;    seq_no = $11;   pkt_id = $12;

 if(pkt_type == "tcp" || pkt_type == "cbr") {

  if (pkt_id > idHighestPacket) idHighestPacket = pkt_id;
  if (pkt_id < idLowestPacket) idLowestPacket = pkt_id; 

  if(rTime>rEndTime) rEndTime=rTime;
  if(rTime<rStartTime) rStartTime=rTime;

  if ( strEvent == "+" ) {

    nSentPackets += 1 ; 
    rSentTime[ pkt_id ] = rTime ;
    send_flag[pkt_id] = 1;
  }

  if ( strEvent == "r" ) {
     nReceivedPackets += 1 ;        nReceivedBytes += pkt_size;

     rReceivedTime[ pkt_id ] = rTime ;
     rDelay[pkt_id] = rReceivedTime[ pkt_id] - rSentTime[ pkt_id ];
     rTotalDelay += rDelay[pkt_id]; 
  }
  if(strEvent == "d"){
    if(rTime>rEndTime) rEndTime=rTime;
    if(rTime<rStartTime) rStartTime=rTime;
    nDropPackets += 1;
  }
 }  
}

END {
 rTime = rEndTime - rStartTime ;
 rThroughput = nReceivedBytes*8 / rTime;
 rPacketDeliveryRatio = nReceivedPackets / nSentPackets * 100 ;
 rPacketDropRatio = nDropPackets / nSentPackets * 100;

 if ( nReceivedPackets != 0 ) {
    rAverageDelay = rTotalDelay / nReceivedPackets ;
 }
printf("Throughput = %15.5f\n",rThroughput);
printf("Averagedelay = %15.5f\n",rAverageDelay);
printf("Sentpackets = %15.5f\n",nSentPackets);
printf("ReceivedPackets = %15.5f\n",nReceivedPackets);
printf("Packetdrop = %15.5f\n", nDropPackets);
printf("PacketDeliveryRatio = %15.5f\n",rPacketDeliveryRatio);
printf("PacketDropRatio = %15.5f\n",rPacketDropRatio);
printf("T = %15.5f\n",rTime);
printf("Total Delay = %15.5f\n",rTotalDelay);
}

