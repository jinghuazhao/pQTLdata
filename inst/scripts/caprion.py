from pathlib import Path
import time
import requests
import pyreadr

RDA = Path.home() / "pQTLdata/data/caprion.rda"
FASTA = Path.home() / "Caprion/analysis/ZWK/caprion_uniprot_sequences.fasta"
AMY1_CANDIDATES = ["P0DUB6", "P0DTE7", "P0DTE8"]

def parse_fasta(text):
    records = {}
    header = None
    seq = []

    def save():
        if header and len(header.split("|")) >= 3:
            acc = header.split("|")[1]
            records[acc] = header + "\n" + "\n".join(
                "".join(seq)[i:i+60] for i in range(0, len("".join(seq)), 60)
            ) + "\n"

    for line in text.splitlines():
        line = line.strip()
        if not line:
            continue
        if line.startswith(">"):
            save()
            header, seq = line, []
        else:
            seq.append(line)
    save()
    return records

def download(accession):
    url = f"https://rest.uniprot.org/uniprotkb/{accession}.fasta"
    for attempt in range(4):
        try:
            response = requests.get(url, timeout=30)
            if response.status_code == 404:
                print(f"WARNING: accession not found: {accession}")
                return None
            response.raise_for_status()
            record = parse_fasta(response.text)
            return record.get(accession)
        except requests.RequestException as exc:
            if attempt == 3:
                print(f"WARNING: failed {accession}: {exc}")
                return None
            time.sleep(2 ** attempt)

def main():
    if not RDA.exists():
        raise FileNotFoundError(f"RDA file not found: {RDA}")

    objects = pyreadr.read_r(str(RDA))
    if "caprion" not in objects:
        raise ValueError(f"No object named 'caprion' in {RDA}")

    df = objects["caprion"]
    if "Accession" not in df.columns:
        raise ValueError("The caprion object has no Accession column.")

    accessions = {
        str(x).strip() for x in df["Accession"].dropna()
        if str(x).strip()
    }
    accessions.discard("P04745")
    accessions.update(AMY1_CANDIDATES)
    accessions = sorted(accessions)

    existing = parse_fasta(FASTA.read_text()) if FASTA.exists() else {}
    missing = [a for a in accessions if a not in existing]

    print(f"Caprion rows: {len(df)}")
    print(f"Unique accessions: {len(accessions)}")
    print(f"Existing FASTA records: {len(existing)}")
    print(f"Downloading: {len(missing)}")

    for i, accession in enumerate(missing, 1):
        record = download(accession)
        if record:
            existing[accession] = record
        if i % 25 == 0 or i == len(missing):
            print(f"Processed {i}/{len(missing)}")
        time.sleep(0.15)

    FASTA.parent.mkdir(parents=True, exist_ok=True)
    tmp = FASTA.with_suffix(".fasta.tmp")
    with tmp.open("w") as out:
        for accession in sorted(existing):
            out.write(existing[accession])
    tmp.replace(FASTA)

    print(f"Saved: {FASTA}")
    print(f"Total FASTA records: {len(existing)}")
    for acc in AMY1_CANDIDATES:
        print(f"{acc}: {'present' if acc in existing else 'MISSING'}")

if __name__ == "__main__":
    main()
