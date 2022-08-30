#!/bin/bash
date
source ~/.bashrc
input_phylip=("$1")
echo $input_phylip

echo "Name for this run: "
read run_name

python ascbias.py -p "$1" -o "$run_name.phy"


## make partition file

ascb_aln_len=$(awk 'NR==1 {print $2; exit}' $run_name.phy)

echo "[asc~$run_name.phy.felsenstein], ASC_DNA, p1=1-" > part.txt
truncate -s-1 part.txt
echo -n $ascb_aln_len >> part.txt



## ask for user input to specify RAxML parameters
echo "How many threads would you like RAxML to use? "
read thread_num

echo "How many maximum likelihood searches would you like RAxML to perform? "
read ML_num

echo "How many bootstrap replicates would you like RAxML to perform? "
read BS_num

## run maximum likelihood search using RAxML
raxmlHPC-PTHREADS-SSE3 -T $thread_num -f d -# $ML_num -p 12345 -m ASC_GTRGAMMA --asc-corr=felsenstein -q part.txt -s $run_name.phy -n $run_name.ML$ML_num.txt

## run boostraps
raxmlHPC-PTHREADS-SSE3 -# $BS_num -T $thread_num -x 12345 -p 23445 -e 0.001 -m ASC_GTRGAMMA --asc-corr=felsenstein -q part.txt -s $run_name.phy -n $run_name.BS$BS_num.txt

raxmlHPC-PTHREADS-SSE3 -T $thread_num -f b -p 12234 -m ASC_GTRGAMMA -t RAxML_bestTree.$run_name.ML$ML_num.txt -z RAxML_bootstrap.$run_name.BS$BS_num.txt -n $run_name.ML$ML_num.BS$BS_num