# tzip / tunzip

Lightweight shell helpers: tar + pigz + pv with a progress bar. Source and use, no install.

## Requirements

```bash
sudo apt install pigz pv   # or: brew install pigz pv
```

## Usage

```bash
source tzip.sh
```

**Compress:** `tzip <dir> [out.tar.gz] [-p <threads>]`  
**Extract:** `tunzip <archive> [target_dir]`

Examples: `tzip data` → `data.tar.gz`; `tunzip data.tar.gz /mnt/data`
