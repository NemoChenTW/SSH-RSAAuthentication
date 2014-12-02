#!/bin/bash

#Auto generate the RSA file.
if [[ -f $HOME/.ssh/id_rsa.pub ]]; then
	echo "id_rsa.pub is already exist."
else
	ssh-keygen -t rsa
fi

#Set the RSA key file and login user name.
localRSAKey=$HOME/.ssh/id_rsa.pub
loginUser="brt"

#Auto set SSH RSA authentication
if [[ -z $1 ]]; then
	ipFileName='IPList'

	exec < $ipFileName
	while read line
	do
		echo $line
		remoteIP=$line
		ssh-copy-id -i $localRSAKey $loginUser@$remoteIP
	done

else
	remoteIP=$1
	ssh-copy-id -i $localRSAKey $loginUser@$remoteIP
fi
