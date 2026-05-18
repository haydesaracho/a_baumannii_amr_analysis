# *Acinetobacter baumannii* AMR Analysis

Comparative analysis of antibiotic resistance genes in complete *Acinetobacter baumannii*
genomes integrating five ABRicate databases.

---

## Background

*Acinetobacter baumannii* is an opportunistic Gram-negative coccobacillus and one of the
most problematic nosocomial pathogens worldwide. The World Health Organization (WHO)
classifies it as a **critical priority pathogen**, highlighting the urgent need to develop
new antibiotics against carbapenem-resistant strains (CRAB).

The organism primarily affects critically ill patients in intensive care units (ICUs),
causing ventilator-associated pneumonia, bloodstream infections, and wound infections.
Currently, 45% of global *A. baumannii* isolates are multidrug-resistant (MDR), with
peaks of 70% in South America, Asia, and Europe. In cases of extensively drug-resistant
(XDR) or pandrug-resistant (PDR) strains, therapeutic options are limited to colistin
and tigecycline as last-resort antibiotics.

Its ability to acquire and disseminate resistance mechanisms — including beta-lactamases,
efflux pumps, aminoglycoside-modifying enzymes, and horizontal gene transfer — makes it
a fundamental model for studying the evolution of antimicrobial resistance.

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
# 1. Clone the repository
git clone https://github.com/HaydeSaracho/A_baumannii_AMR_analysis.git
cd A_baumannii_AMR_analysis

# 2. Download genomes
cd scripts
bash 01_download_and_filter.sh

# 3. Run ABRicate
conda activate abricate_env
bash 02_run_abricate.sh

# 4. Analysis
jupyter notebook analysis/notebooks/01_AMR_analysis.ipynb
```

---

## Author

**Haydé Saracho**