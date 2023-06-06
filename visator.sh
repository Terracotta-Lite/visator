#!/bin/bash

cat /usr/share/vis/themes/solarized.lua

cat $1 | egrep -v '^ {0,}"' | grep 'hi ' | egrep -v '^ ' | grep -n -o -e "hi \w*\w " -e "\w*guifg=#\w*" -e "\w*guibg=#\w*" > "${1%.vim}.lua"

line=$(tail -1 "${1%.vim}.lua" | cut -d : -f 1)
for ((i=1 ; i < $((line + 1)) ; i++ ))
do
	string=""
	name=$(grep "^$i:" "${1%.vim}.lua" | sed "s/hi //g" | head -1 | cut -d : -f 2 | tr -d ' ' )
	fg=$(grep "^$i:" "${1%.vim}.lua" | sed "s/hi //g" | grep guifg | cut -d : -f 2 | cut -d = -f 2 | tr -d ' ' )
	bg=$(grep "^$i:" "${1%.vim}.lua" | sed "s/hi //g" | grep guibg | cut -d : -f 2 | cut -d = -f 2 | tr -d ' ' )
	case $name in
		Comment)
		  string="lexers.STYLE_COMMENT"
		  ;;
		Constant)
		  string="lexers.STYLE_CONSTANT"
		  ;;
		Define)
		  string="lexers.STYLE_PREPROCESSOR"
		  ;;
		ErrorMsg)
		  string="lexers.STYLE_ERROR"
		  ;;
		Function)
		  string="lexers.STYLE_FUNCTION"
		  ;;
		Keyword)
		  string="lexers.STYLE_KEYWORD"
		  ;;
		Number)
		  string="lexers.STYLE_NUMBER"
		  ;;
		Operator)
		  string="lexers.STYLE_OPERATOR"
		  ;;
		String)
		  string="lexers.STYLE_STRING"
		  ;;
		Tag)
		  string="lexers.STYLE_TAG"
		  ;;
		Type)
		  string="lexers.STYLE_TYPE"
		  ;;
	esac

	color=""
	if [[ -n $string ]]
	then
		if [[ -n $fg ]]
		then
			color+="fore:${fg},"
		fi
		if [[ -n $bg ]]
		then
			color+="back:${bg},"
		fi
		echo $string = \'$color\'
	fi
done
