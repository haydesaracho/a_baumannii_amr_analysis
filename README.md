# *Acinetobacter baumannii* AMR Analysis

Análisis de genes de resistencia a antibióticos en genomas completos de
*Acinetobacter baumannii* integrando cinco bases de datos de ABRicate.

---

## Background

*Acinetobacter baumannii* es un cocobacilo Gram-negativo oportunista y uno de los
patógenos nosocomiales más problemáticos a nivel mundial. La Organización Mundial de
la Salud (OMS) lo clasifica como patógeno de **prioridad crítica**, destacando la
urgente necesidad de desarrollar nuevos antibióticos frente a cepas resistentes a
carbapenems (CRAB).

El microorganismo afecta principalmente a pacientes críticos en unidades de cuidados
intensivos (UCI), causando neumonía asociada a ventilador, infecciones del torrente
sanguíneo e infecciones de heridas. Actualmente, el 45% de los aislamientos globales
de *A. baumannii* son multidrogorresistentes (MDR), con picos del 70% en Sudamérica,
Asia y Europa. En casos de cepas extensamente resistentes (XDR) o panresistentes (PDR),
las opciones terapéuticas se reducen a colistina y tigeciclina como últimos recursos.

Su capacidad para adquirir y diseminar mecanismos de resistencia — incluyendo
betalactamasas, bombas de eflujo, modificación de aminoglucósidos y transferencia
horizontal de genes — lo convierte en un modelo de estudio fundamental para comprender
la evolución de la resistencia antimicrobiana.

---

## Objetivos

- Descargar y filtrar genomas completos de *A. baumannii* disponibles en NCBI RefSeq
- Anotar genes de resistencia a antibióticos con ABRicate usando 5 bases de datos
- Comparar la cobertura y consistencia entre bases de datos
- Identificar el repertorio de genes de resistencia más frecuentes en la especie

---

## Pipeline

NCBI RefSeq
↓
01_download_and_filter.sh   # Descarga, filtrado y limpieza del assembly summary
↓
data/raw/genomes/           # 1012 genomas completos (.fna.gz)
↓
02_run_abricate.sh          # Anotación con 5 bases de datos (minid=80, mincov=80)
↓
results/                    # Tablas de resultados por base de datos
↓
analysis/notebooks/01_AMR_analysis.ipynb   # Análisis y visualización en Python

---

## Bases de datos utilizadas

| Base de datos | Versión ABRicate | Enfoque |
|---------------|-----------------|---------|
| CARD | 2026-Apr-3 | Resistencia a antibióticos |
| ResFinder | 2026-Apr-3 | Resistencia a antibióticos |
| ARG-ANNOT | 2026-Apr-3 | Resistencia a antibióticos |
| MEGARES | 2026-Apr-3 | Resistencia a antibióticos |
| NCBI AMRFinderPlus | 2026-Apr-3 | Resistencia a antibióticos |

---

## Estructura del repositorio

A_baumannii_AMR_analysis/
├── README.md
├── data/
│   ├── raw/
│   │   ├── assembly_summary_refseq.txt
│   │   └── genomes/                    # 1012 genomas .fna.gz
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

---

## Requisitos

- Linux / WSL
- `wget`
- `python3` + `pandas`
- `conda` + `abricate` (instalado en ambiente `abricate_env`)
- `jupyter notebook`

---

## Uso

```bash
# 1. Clonar el repositorio
git clone https://github.com/HaydeSaracho/A_baumannii_AMR_analysis.git
cd A_baumannii_AMR_analysis

# 2. Descargar genomas
cd scripts
bash 01_download_and_filter.sh

# 3. Correr ABRicate
conda activate abricate_env
bash 02_run_abricate.sh

# 4. Análisis
jupyter notebook analysis/notebooks/01_AMR_analysis.ipynb
```

---

## Autora

**Haydé Saracho**