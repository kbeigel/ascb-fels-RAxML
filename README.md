The ascb_RAxML_run.sh script performs ascertainment bias correction (felsenstein method) and executes RAxML commands for 
maximum likelihood search (user-specified) and bootstrap replicates (user-specified). 

IMPORTANT NOTE: script uses the ascbias.py script from btmartin721 (https://github.com/btmartin721/raxml_ascbias) to remove 
and quantify the invariant sites from a PHYLIP file. Please see the documentation for this original script from btmartin271
for details on how the ascbias correction works, necessary dependnecies, and other details.

The ascb_RAxML_run.sh script uses the output files from btmartin721's ascbias.py scipt to generate the partition files needed
for running RAxML 8.2.X with the ASC_GTRGAMMA model.

The script can be run with the following command:
```
bash ascb_RAxML_run.sh input.phy
```

The user will be prompted to entered the following information for the run: 
>"Name for this run:" # specify a name for the run, which will be used to prepend the output files
>"How many threads would you like RAxML to use?" # specify parameter for number of threads to be used
>"How many maximum likelihood searches would you like RAxML to perform?" # specify parameter for number of maximum likelihood searches
>"How many bootstrap replicates would you like RAxML to perform?" # specify number of bootstraps

