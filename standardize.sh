
if [ -f $1 ]
then
	echo $1
	#enca -L none -x UTF-8 < $1 > "$1"

	#Do some auto replacement
	sed -i 's/\#include \"stdafx.h\"/ /g' "$1"
	sed -i 's/stdafx.h/stdlib.h/g' "$1"
	sed -i 's/conio.h/stdio.h/g' "$1"
	sed -i 's/getch()/getchar()/g' "$1"
	sed -i 's/int _tmain(int argc, _TCHAR\* argv\[\])/int main()/g' "$1"
	sed -i 's/void main()/int main()/g' "$1"
	sed -i 's/getch()/getchar()/g' "$1"
	sed -i 's/getch()/getchar()/g' "$1"
else
	echo "File does not exist"
fi