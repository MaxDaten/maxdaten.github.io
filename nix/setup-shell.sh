#!/usr/bin/env bash

text1=$(tput setaf 21)
text2=$(tput setaf 57)
text3=$(tput setaf 93)
text4=$(tput setaf 129)
text5=$(tput setaf 165)
text6=$(tput setaf 201)
textHighlight=$(tput setaf 231)
cat <<EOF
${text1}+-${text1}+-${text2}+-${text2}+-${text3}+-${text3}+-${text4}+-${text4}+-${text5}+-${text5}+-${text6}+-${text6}+
${text1}|m${text1}|a${text2}|x${text2}|d${text3}|a${text3}|t${text4}|e${text4}|n${text5}|.${text5}|i${text6}|o${text6}|
${text1}+-${text1}+-${text2}+-${text2}+-${text3}+-${text3}+-${text4}+-${text4}+-${text5}+-${text5}+-${text6}+-${text6}+
${textHighlight}Shell Environment
EOF
