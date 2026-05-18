# *Acinetobacter baumannii* AMR Analysis

Comparative analysis of antibiotic resistance genes in complete *Acinetobacter baumannii*
genomes integrating five ABRicate databases.

---

## Background

*Acinetobacter baumannii* is one of the most problematic opportunistic pathogens worldwide. 
The World Health Organization (WHO) classifies it as a **critical priority pathogen**, 
emphasizing the urgent need to develop new antibiotics and/or alternative therapies to 
combat multidrug-resistant strains.

This organism primarily affects patients admitted to intensive care units and can cause 
ventilator-associated pneumonia, bloodstream infections and wound infections. 
Recent studies indicate that rates of multidrug resistance exceed 89% in hospital settings 
and that carbapenem-resistant strains account for approximately 80% of cases of hospital-acquired 
and ventilator-associated pneumonia worldwide, with resistance rates exceeding 90% in Southeast Asia (WHO, 2024). 
In cases of extremely drug-resistant or pan-resistant strains, treatment options are even more limited.

---

## Objectives

- Download and filter complete *A. baumannii* genomes available in NCBI RefSeq
- Annotate antibiotic resistance genes with ABRicate using 5 databases
- Compare coverage and consistency across databases
- Identify the most frequent resistance gene repertoire in the species

---

## Pipeline
```
NCBI RefSeq
    ↓
01_download_and_filter.sh   # Downloads and filters the assembly summary
    ↓
data/raw/genomes/           # 1012 complete genomes (.fna.gz)
    ↓
02_run_abricate.sh          # Annotation with 5 databases (minid=80, mincov=80)
    ↓
results/                    # Results tables per database
    ↓
analysis/notebooks/01_AMR_analysis.ipynb   # Analysis and visualization in Python
```

---

## Databases

| Database | ABRicate version |
|----------|-----------------|
| CARD | 2026-Apr-3 |
| ResFinder | 2026-Apr-3 |
| ARG-ANNOT | 2026-Apr-3 |
| MEGARES | 2026-Apr-3 |
| NCBI AMRFinderPlus | 2026-Apr-3 |

---

## Repository structure

```
A_baumannii_AMR_analysis/
├── README.md
├── data/
│   ├── raw/
│   │   ├── assembly_summary_refseq.txt
│   │   └── genomes/                    # 1012 genomes .fna.gz
│   └── processed/
│       ├── Assembly_Summary_Ab_CG.tsv
│       ├── Assembly_Summary_Ab_CG_clean.tsv
│       └── ftp_links.txt
├── scripts/
│   ├── 01_download_and_filter.sh
│   └── 02_run_abricate.sh
├── results/
│   ├── CARD/
│   ├── ResFinder/
│   ├── ARG-ANNOT/
│   ├── MEGARES/
│   └── NCBIAMRFinderPlus/
├── analysis/
│   └── notebooks/
│       └── 01_AMR_analysis.ipynb
└── figures/
```

---

## Requirements

- Linux / WSL
- `wget`
- `python3` + `pandas`
- `conda` + `abricate` (installed in `abricate_env` environment)
- `jupyter notebook`

---

## Usage

```bash
## Usage

# 1. Clone the repository
git clone https://github.com/HaydeSaracho/A_baumannii_AMR_analysis.git
cd A_baumannii_AMR_analysis

# 2. Download genomes
cd scripts
bash 01_download_and_filter.sh

# 3. Install ABRicate
conda create -n abricate_env -c conda-forge -c bioconda abricate -y
conda activate abricate_env
conda install -c conda-forge jupyter pandas matplotlib seaborn -y

# 4. Run ABRicate
bash 02_run_abricate.sh

# 5. Analysis
jupyter notebook analysis/notebooks/01_AMR_analysis.ipynb
```

---

## Author

**Haydé Saracho**
