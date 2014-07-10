function by_size(){
	local filename=$1
	size=`wc -c $filename | awk '{print $1}'`
	if [ "$size" -lt 200 ]; then
		echo 200
	elif [ "$size" -lt 500 ]; then
		echo 500
	elif [ "$size" -lt 1000 ]; then
		echo 1000
	elif [ "$size" -lt 2000 ]; then
		echo 2000
	elif [ "$size" -lt 4000 ]; then
		echo 4000
	else
		echo oversize
	fi
	return $size
}



if [ -d $1 ]
then
	sub_dirs=$1
else
	echo "$1 directory doesn't exist. copy from where? "
	read sub_dirs
fi

if [ -d $2 ]
then
	dest_dirs=$2
else
	echo "$2 directory doesn't exist. copy to where? "
	read dest_dirs
fi

#set field seperator to newline
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

#echo "Copy"
list=`find $sub_dirs`;
#echo $list

TKDIR=`mktemp -d`

for i in $list
do
	#echo $i
	a=`echo $i | grep -o "[0-9][0-9]52[0-9][0-9][0-9][0-9]" `;
	#echo $a;


	if [ "$a" != "" ]
	then

		#Guess encoding and convert them into UTF-8
		#put the converted file in temp dir
		enca -L none -x UTF-8 < $i > "$TKDIR/$a.cpp"

		#Do some auto replacement
		sed -i 's/\#include \"stdafx.h\"/ /g' "$TKDIR/$a.cpp"
		sed -i 's/int _tmain(int argc, _TCHAR\* argv\[\])/int main()/g' "$TKDIR/$a.cpp"
		sed -i 's/void main()/int main()/g' "$TKDIR/$a.cpp"
		sed -i 's/conio.h/stdio.h/g' "$TKDIR/$a.cpp"
		sed -i 's/getch()/getchar()/g' "$TKDIR/$a.cpp"
		
		#Get the size of the converted file
		sized=$(by_size "$TKDIR/$a.cpp")
		b="$dest_dirs/$sized";
		if  [ ! -d "$b" ]
		then
			mkdir "$b"
		fi
		
		#move converted file to approriate directory
		echo "Copy $i to $b/$a.cpp"
		mv "$TKDIR/$a.cpp" "$b/$a.cpp"

	else
		echo "ignore $i"
	fi
done
