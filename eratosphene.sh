#!/bin/bash
declare -a ARRAY
declare -r TRUE=0 #standard for shell return codes
declare -r FALSE=1

parse_cmd() {
	if [[ "$1" == "" ]] ; then
		echo "need number"
		exit 1
	elif ! [[ "$1" =~ ^[+]?[0-9]+$ ]] ; then
		echo "$1 is not number"
		exit 1
	fi
	declare -g -r N="$1"
}

prepare_array() {
	local I=2
	(( ARRAY[0]=FALSE ))
	(( ARRAY[1]=FALSE ))
	while (( I <= N )) ; do
		(( ARRAY[I]=TRUE ))
		(( I++ ))
	done
}

sieve() {
	local I=3
	while (( ( I * I ) < N )) ; do
		if (( ARRAY[I] == TRUE )) ; then
			echo "$I" 1>&2
			(( J = I * I ))
			while (( J < N )) ; do
				(( ARRAY[J]=FALSE ))
				(( J += I ))
			done
		fi
		(( I += 2 ))
	done
}

print_primes() {
	local I=3
	while (( I < N )) ; do
		if (( ARRAY[I] == TRUE )) ; then
			echo "$I"
		fi
		(( I += 2 ))
	done
}
#######
#start#
#######
parse_cmd "$1"
prepare_array
sieve
print_primes

exit 0


#test comment
