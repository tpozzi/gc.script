#!/bin/bash
#This script will do all 5 aritimetic operations
echo "This script will do some aritimetic operations"
read -p "Please type the first number: " num1
read -p "Please type the first number: " num2

sum=$((num1 + num2))
sub=$((num1 - num2))
div=$((num1 / num2))
mult=$(expr $num1 \* $num2)
mod=$((num1 % num2))
echo $((num1 * mum2))

echo ""
echo "#####################################################################"
echo "| The sum of the numbers $num1 and $num2 is equal: $sum"
echo "| The subtration of the numbers $num1 and $num2 is equal: $sub"
echo "| The division of the numbers $num1 and $num2 is equal: $div"
echo "| The multiplication of the numbers $num1 and $num2 is equal: $mult"
echo "| The mod of the numbers $num1 and $num2 is equal: $mod"
echo "#####################################################################"
