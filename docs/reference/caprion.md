# Caprion panel

Information based on Caprion pilot studies

## Usage

``` r
data(caprion)
```

## Format

A data frame with 987 rows and 19 variables:

-   `Gene`:

    HGNC symbols, simplified in four instances

-   `Gene.orig`:

    Original HGNC symbol

-   `Protein`:

    Protein name as recorded in the original Caprion annotation

-   `Accession`:

    Original UniProt accession, retained for compatibility

-   `Protein.Description`:

    Detailed protein information

-   `GO.Cellular.Component`:

    Gene Ontology cellular component annotation

-   `GO.Function`:

    Gene Ontology molecular function annotation

-   `GO.Process`:

    Gene Ontology biological process annotation

-   `ensGenes`:

    Ensembl gene identifiers

-   `chrom`:

    Chromosome annotation

-   `starts`:

    Start positions

-   `ends`:

    End positions

-   `chr`:

    Chromosome annotation

-   `start`:

    Minimum start position

-   `end`:

    Maximum end position

-   `Accession.original`:

    Original UniProt accession, explicitly preserved

-   `Accession.current`:

    Current UniProt accession where resolved; `NA` for the demerged AMY1
    entry

-   `Accession.status`:

    Accession resolution status, including `unchanged` and `demerged`

-   `Accession.candidates`:

    List-column of candidate current UniProt accessions for historical
    entries; AMY1 has P0DUB6, P0DTE7 and P0DTE8

## Source

Caprion pilot-study annotations and UniProt accession information.

## Details

The original Caprion annotations and accession identifiers are
preserved. UniProt marks the historical AMY1 accession P04745 as
demerged. The candidate current accessions P0DUB6, P0DTE7 and P0DTE8 are
recorded for subsequent peptide-level evaluation. These candidates do
not establish that all three sequences contributed to the original
protein quantification. See the Caprion repository for details of its
use.
