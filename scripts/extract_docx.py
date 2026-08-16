#!/usr/bin/env python3
import zipfile
import xml.etree.ElementTree as ET
from pathlib import Path

W_P = "{http://schemas.openxmlformats.org/wordprocessingml/2006/main}p"
W_T = "{http://schemas.openxmlformats.org/wordprocessingml/2006/main}t"


def docx_to_text(path: Path) -> str:
    with zipfile.ZipFile(path) as z:
        xml = z.read("word/document.xml")
    root = ET.fromstring(xml)
    lines = []
    for p in root.iter(W_P):
        texts = []
        for t in p.iter(W_T):
            if t.text:
                texts.append(t.text)
            if t.tail:
                texts.append(t.tail)
        line = "".join(texts).strip()
        if line:
            lines.append(line)
    return "\n".join(lines)


def main() -> None:
    assets = Path("/mnt/c/Users/aborr/dev/website_perso/docs/assets")
    out_dir = Path("/mnt/c/Users/aborr/dev/website_perso/.extract")
    out_dir.mkdir(exist_ok=True)
    for name in ("resume_Aug2026.docx", "list_publication.docx"):
        text = docx_to_text(assets / name)
        (out_dir / name.replace(".docx", ".txt")).write_text(text, encoding="utf-8")


if __name__ == "__main__":
    main()
