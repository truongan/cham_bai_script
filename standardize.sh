
if [ -f $1 ]
then
	TKDIR=`mktemp -d`
	echo $1
	enca -L none -x UTF-8 < $1 > "$TKDIR/$1"

	#Do some auto replacement
	sed -i 's/\#include \"stdafx.h\"/ /g' "$TKDIR/$1"
	sed -i 's/stdafx.h/stdlib.h/g' "$TKDIR/$1"
	sed -i 's/conio.h/stdio.h/g' "$TKDIR/$1"
	sed -i 's/getch()/getchar()/g' "$TKDIR/$1"
	sed -i 's/int _tmain(int argc, _TCHAR\* argv\[\])/int main()/g' "$TKDIR/$1"
	sed -i 's/void main()/int main()/g' "$TKDIR/$1"
	sed -i 's/getch()/getchar()/g' "$TKDIR/$1"
	sed -i 's/getch()/getchar()/g' "$TKDIR/$1"
	sed -i 's/gets_s/gets/g' "$TKDIR/$1"
	sed -i 's/scanf_s/scanf/g' "$TKDIR/$1"
	sed -i 's/printf_s/print/g' "$TKDIR/$1"

	mv "$TKDIR/$1" "$1"
else
	echo "File does not exist"
fi