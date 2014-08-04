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

flag=1
for i in $test_data/*.in
do
	answer=$(cat ${i%.*}.ans)
	output=$(cat $i | ./$binary)
	trimmed=$(echo $output |  awk '{print $NF}' | sed 's/[^0-9]//g')
	if [ "$answer" != "$trimmed" ] 
	then
		#echo "TRUE"
	#else
		cat $i
		echo "answer = $answer BUT output = $output"
		flag=0
	fi
done

if [ $flag = 1 ] 
then
	echo "$binary TRUE"
fi

