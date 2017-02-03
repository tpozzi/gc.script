#!/bin/bash
#

colours=("red" "green" "blue")
declare -A animals
animals=([red]="cardinal" [green]="frog" [blue]="lobster")

read -p "Gibve an number from 1 to ${#colours[@]}: " num
num=$((num - 1))
colour=${colours[$num]}
animal=${animals[$colour]}
num=$((num + 1))
echo "Index $num finds a $colour $animal"

