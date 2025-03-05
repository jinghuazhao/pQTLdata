#!/usr/bin/bash

function readme_chembl()
{
  wget -qO- ftp://ftp.ebi.ac.uk/pub/databases/chembl/ChEMBLdb/latest/README
}
