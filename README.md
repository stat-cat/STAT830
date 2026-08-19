# STAT 830: Design and Analysis of Experiments

This repository contains lecture materials, R code, SAS code, example datasets, and supplemental resources for **STAT 830**.

## Software Requirements

Students should have access to:

- R (version 4.0 or later recommended)
- RStudio
- SAS
- Any required R packages listed within individual scripts

Commonly used R packages include:

```r
library(tidyverse)
library(emmeans)
library(lme4)
library(lmerTest)
library(multcomp)
library(car)
```

## Using GitHub (Optional)

Students who have a GitHub account may wish to create their own copy of this repository. This allows you to save notes, make changes to code, experiment with analyses, and keep track of your work throughout the semester.

### Forking the Repository

1. Navigate to the course GitHub repository.
2. Click the **Fork** button in the upper-right corner of the repository page.
3. Select your GitHub account as the destination.
4. GitHub will create a personal copy of the repository under your account.

### Cloning Your Fork

After creating a fork, you can download the repository to your computer using Git:

```bash
git clone https://github.com/YOUR_USERNAME/STAT830.git
```

Alternatively, you can use [GitHub Desktop](https://desktop.github.com/download/) to clone the repository without using the command line.

### Keeping Your Fork Updated

If course materials are updated during the semester, you can synchronize your fork with the course repository using GitHub's **Sync Fork** feature or standard Git commands.

### Recommended Workflow

1. Fork the repository.
2. Clone your fork to your computer.
3. Open the project in RStudio or other IDE.
4. Create your own scripts, notes, and practice analyses.
5. Commit changes regularly to maintain a history of your work.
6. Push updates to your GitHub account for backup and version control.

### Benefits of Using GitHub

Using GitHub is entirely optional but can help you:

- Organize course materials and analyses.
- Track changes to code over time.
- Back up your work.
- Develop reproducible research practices.
- Gain experience with version control, an important skill in data science and biostatistics.

Students who prefer not to use GitHub may simply download the repository as a ZIP file and access the materials locally.

## Repository Structure

```
STAT830/
├── Module01/
├── Module02/
├── Module03/
├── ...
├── Resources/
└── README.md
```

Each module folder may contain:
- R scripts
- SAS programs

## Using the Materials

For most examples, datasets are created directly within the R scripts using functions such as `tribble()` from the **tidyverse**. This approach allows students to focus on statistical concepts and analyses without spending time importing data files.

Many topics include both **R** and **SAS** implementations.

## Acknowledgments

Some datasets and example analyses in this repository were adapted from materials accompanying:

Dean, A., Voss, D., & Draguljic, D.
*Design and Analysis of Experiments*.

Data files and supporting materials are available at:
https://corescholar.libraries.wright.edu/design_analysis/8/

Code included in this repository has been modified for instructional use in STAT 830 and may differ from the original examples.

## Academic Use

These materials are intended to support instruction in STAT 830 and to promote reproducible statistical analyses.

Please cite original data sources where appropriate and do not redistribute copyrighted textbook content.
