#!/bin/bash
# Wilson McCormack - Fall Term 2021 - Linux Administration (CIS-245-O1A) 


red=`tput setaf 1`      #Allows the use of the color red with the variable red
green=`tput setaf 2`    #Allows the use of the color green with the variable green
reset=`tput sgr0`       #Allows the color to be reset to default with the variable reset


 function networkinfo
 {
 read -p "To see information about your current network, press enter."
 ifconfig -a | tee -a NetworkDump_"`date +"%m-%d-%Y"`".txt
 }
 
 function speedtest
 {
 read -p "To test your upload and download speed, press enter"
 speedtest-cli | tee -a NetworkDump_"`date +"%m-%d-%Y"`".txt
 }
 
 function ports
 {
 read -p "To display all open ports on your network, press enter."
 netstat -a -n | tee -a NetworkDump_"`date +"%m-%d-%Y"`".txt
 }
 
 function trace
{
 echo "Please input a domain or IP to trace its pathway."
 read trace
 traceroute -m 10 $trace | tee -a NetworkDump_"`date +"%m-%d-%Y"`".txt
}


 function DNS
{
 echo "To look up DNS information related to server, input a domain. "
 read dns
 nslookup $dns | tee -a NetworkDump_"`date +"%m-%d-%Y"`".txt
}
 
function pingserver
{
 echo "Please input an IP or domain to send send a ping to."
 read ping
 ping -c 5 $ping | tee -a NetworkDump_"`date +"%m-%d-%Y"`".txt
}


function packets
{
 echo "To capture 15 packets of network traffic, press enter:"
 read tcpdump
 sudo tcpdump -c 15 | tee -a NetworkDump_"`date +"%m-%d-%Y"`".txt
}
 

function end
{
 echo -e "\e[1;31mDONE. If you would like to review the output, check the file NetworkDump_"`date +"%m-%d-%Y"`".txt"
}

function menu
{
MSG='Choose an option to test network information'
echo -e "${red}Choose a networking tool to run${reset}"
options=("Obtain network info" "Run a speed test" "Display open ports" "Trace a domain or IP" "Capture packets" "Ping a domain or IP" "Quit Network Dump")
select option in "${options[@]}"; do
    case $option in
        "Obtain network info")
            networkinfo
            echo -e "${red}Choose a networking tool to run${reset}"
            ;;
        "Run a speed test")
            speedtest
            echo -e "${red}Choose a networking tool to run${reset}"
            ;; 
        "Display open ports")
            ports
            echo -e "${red}Choose a networking tool to run${reset}"
            ;;  
        "Trace a domain or IP")
            trace
            echo -e "${red}Choose a networking tool to run${reset}"
            ;;
        "Capture packets") 
            packets
            echo -e "${red}Choose a networking tool to run${reset}"
            ;;
        "Ping a domain or IP")
            pingserver
            echo -e "${red}Choose a networking tool to run${reset}"
            ;;
        "Quit Network Dump")
            end
            exit
            ;;
        *) echo "invalid option $REPLY";;
        esac
        done

}

menu
