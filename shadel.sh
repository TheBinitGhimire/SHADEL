#!/usr/bin/env bash
# SHADEL | Obtain IP Addresses from a List of Domains!
printf "Binit Ghimire presents...\nSHADEL | Obtain IP Addresses from a List of Domains!\n\n"
usage="Usage:\n./shadel -i domains.txt -o output.txt\n"
thanks="\nThank You for using SHADEL!\n"
outputIPs="output.txt"

while getopts ":i:o:h" args
	do
		case "${args}" in
			i) inputDomains=${OPTARG};;
			o) outputIPs=${OPTARG};;
			h) echo -e $usage$thanks && exit 0;;
			*) echo -e "Please define a valid option!\n\n"$usage$thanks && exit 1;;
		esac
	done

if [[ ${#inputDomains} -lt 1 ]]
then
	echo -e "Please provide a valid input file name!\n\n"$usage$thanks
	exit 1
fi

domainList=0
test -f $inputDomains && domainList=1
if [[ $domainList != 1 ]]
then
	echo -e "Please choose a valid file containing a list of domains!\n\n"$usage$thanks
	exit 1
fi

printf "Reading domains from $inputDomains, and storing results in $outputIPs!\n\n"

printf "" > $outputIPs
while IFS= read -r domain
do
	printf $domain":\n"
	IPs=$(dig +short $domain)
	echo -e $IPs"" | tr " " "\n" | tee -a $outputIPs
	printf "\n"
done < $inputDomains
echo -e $thanks
