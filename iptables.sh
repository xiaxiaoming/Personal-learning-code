#!/bin/bash
/usr/sbin/iptables -F
/usr/sbin/iptables -t nat -F
/usr/sbin/iptables -P FORWARD ACCEPT
/usr/sbin/iptables -P INPUT DROP
/usr/sbin/iptables -P OUTPUT  ACCEPT
#Office
/usr/sbin/iptables -A INPUT -s 127.0.0.1 -j ACCEPT      #TechZ-Office
/usr/sbin/iptables -A INPUT -s 172.16.0.0/16 -j ACCEPT     #Pravite
/sbin/iptables  -A INPUT -m iprange --src-range  192.168.1.122-192.168.1.126 -j ACCEPT   #TechZ-Office
/sbin/iptables  -A INPUT -m iprange --src-range  192.168.2.225-192.168.2.254 -j ACCEPT   #HK-CU
/sbin/iptables  -A INPUT -m iprange --src-range    192.168.3.17-192.168.3.30 -j ACCEPT   #HK-CTC
#service port#
/usr/sbin/iptables -A INPUT -p tcp -m tcp --dport 2017 -j ACCEPT
/usr/sbin/iptables -A INPUT -p tcp -m tcp --dport 10050 -j ACCEPT
##seo##
/usr/sbin/iptables -A INPUT -p tcp -m tcp --tcp-flags SYN,ACK SYN,ACK -m state --state NEW -j REJECT --reject-with tcp-reset
/usr/sbin/iptables -A INPUT -p tcp -m tcp ! --tcp-flags FIN,SYN,RST,ACK SYN -m state --state NEW -j REJECT --reject-with tcp-reset
/usr/sbin/iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
/usr/sbin/iptables -A INPUT -p icmp -m icmp --icmp-type 8 -m limit --limit 1/sec --limit-burst 10 -j ACCEPT
##save restart##
/etc/init.d/iptables save
/etc/init.d/iptables restart
##show iptables##
iptables -nL

