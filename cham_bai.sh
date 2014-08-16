test_data=""

binary=""

if [ -d $1 ]
then
	test_data=$1
else
	echo "$1 directory doesn't exist. Please specify test data location? "
	read test_data
fi

if [ -f $2 ]
then
	binary=$2
else
	echo "$2 file doesn't exist. Please specify binary file to test? "
	read binary
fi

echo "######## Testing $binary ########"
flag=1
count=0
for i in $test_data/*.in
do
	#cat $i;
	answer=$(cat ${i%.*}.ans)
	output=$(timeout 15 bash -c "cat $i | $binary")
	#trimmed=$(echo $output |  awk '{print $(NF-1) " " $NF}' | sed 's/[^0-9 ]//g')
	trimmed=$(echo $output |  awk '{print $NF}' | sed 's/[^0-9]//g')
	if [ "$answer" = "$trimmed" ] 
	then
		let "count=count+1"
	else
		#cat $i
		echo $i;
		echo "answer = $answer BUT output = $trimmed"
		flag=0
	fi
done

if [ $flag = 1 ] 
then
	echo "$binary TRUE"
else
	echo "$binary got $count"
fi

