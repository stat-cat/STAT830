# STAT 830: Design and Analysis of Experiments

This repository contains lecture materials, R code, SAS code, example datasets, and supplemental resources for **STAT 830**.

## Software Requirements

Students should have access to:

- R (version 4.0 or later recommended) and/or SAS

## Using GitHub (Optional)

Students who have a GitHub account may wish to create their own copy of this repository. This allows you to save notes, make changes to code, experiment with analyses, and keep track of your work throughout the semester.

### Create a GitHub Account 

If you do not already have a GitHub account:
1. Visit https://github.com/signup
2. Enter your email address and create a username and password.
3. Verify your email address and complete the account setup process.
4. Sign in to your new GitHub account.

### Forking the Repository

1. Navigate to the course GitHub repository.
2. Click the **Fork** button in the upper-right corner of the repository page.
3. Select your GitHub account as the destination.
4. GitHub will create a personal copy of the repository under your account.

### Install and Sign in to GitHub Desktop

For most students, **GitHub Desktop** is the easiest way to work with Git and GitHub without using the command line.

1. Download [GitHub Desktop](https://desktop.github.com/)
2. [Install GitHub Desktop](https://docs.github.com/en/desktop/installing-and-authenticating-to-github-desktop/installing-github-desktop)
3. [Authenticate to GitHub in GitHub Desktop](https://docs.github.com/en/desktop/installing-and-authenticating-to-github-desktop/authenticating-to-github-in-github-desktop)

### Clone Your Fork

1. Open GitHub Desktop.
2. Select **File → Clone Repository**.
3. Choose your fork of the `STAT830` repository from the **GitHub.com** tab.
4. Select a local folder and click **Clone**.

### Command-Line Alternative

Note: GitHub Desktop is recommended for users who are new to Git and GitHub. Students who are comfortable with Git may use the command line or any other Git client they prefer.

### Cloning Your Fork

After creating your fork, the easiest way to download the repository to your computer is with [GitHub Desktop](https://desktop.github.com/download/), which provides a graphical interface for working with Git and GitHub.
After creating a fork, you can download the repository to your computer using GitHub Desktop:
1. Open GitHub Desktop.
2. Select **File → Clone Repository**.
3. Choose your fork of the `STAT830` repository from the GitHub.com tab (or paste the URL of your fork).
4. Select a local folder and click **Clone**.

Alternatively, you can use  to clone the repository without using the command line.
```
git clone https://github.com/YOUR_USERNAME/STAT830.git
```

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
