#!/bin/bash
# Number of room (x)   | 1 | 3 | 4 | 6  |
# House price (y)      | 5 | 7 | 9 | 11 |
#
xtotal=0
ytotal=0
xytotal=0
xtotalsquared=0
count=0

y_values=($(awk 'NR==2' $1))
x_values=($(awk 'NR==1' $1))

for ((i=0 ; i<${#y_values[*]} ; i++ ))
do
    ytotal=$(echo "$ytotal+${y_values[i]}" | bc)
    xtotal=$(echo "$xtotal+${x_values[i]}" |bc)
    xtotalsquared=$(echo "$xtotalsquared+(${x_values[i]}^2)" | bc)
    xytotal=$(echo "$xytotal+(${x_values[i]}*${y_values[i]})" | bc)
    count=$[$count+1]
done
#echo "xtotal=$xtotal ytotal=$ytotal xtotalsquared=$xtotalsquared xytotal=$xytotal "
#echo "count=$count"

m_value=$(echo "scale=4 ;(($count * $xytotal) - ($xtotal * $ytotal)) / (($count * $xtotalsquared) - ($xtotal ^ 2))" | bc)
#echo "m_value=$m_value"

b_value=$(echo "scale=4 ;($ytotal - ($m_value * $xtotal)) / $count" | bc)
#echo "b_value=$b_value"

read -p "Which value you want to calculate? " find_value

result=$(echo "scale=4 ;($m_value * $find_value) + $b_value" | bc)
echo "The result is $result"
