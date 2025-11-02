# pUG-analysis

This repository contains the custom scripts used to identify poly(UG)-tailed RNAs in small RNA sequencing data.

## :round_pushpin: Cite us
If you use these scripts in your research, we kindly ask that you cite our paper: 
```
Title: poly(UG)-tailed RNAs in genome protection and epigenetic inheritance

Author: Shukla A, Yan J, Pagano D, Dodson A, Fei Y, Gorham J, Seidman J, Wickens M, Kennedy S

Journal: Nature, 582, 283-288 (2020)
```

## :bell: Usage
```python
#1. Example for filter_barcodes.py:

python filter_barcodes.py -i input.fastq -o output.fastq

#2. Example for filter_22G_reads.py:

python filter_22G_reads.py -i input.fastq -o output.fastq

#3. Example for filter_protein_coding.sh:

sh filter_protein_coding.sh
```
