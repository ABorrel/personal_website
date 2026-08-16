# Dr. Alexandre Borrel — personal website

Academic CV site built with [MkDocs](https://www.mkdocs.org/) and [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/). Content is migrated from the previous Google Sites site at [https://www.alexborrel.com/](https://www.alexborrel.com/).

## Local preview (WSL + conda)

From Ubuntu in WSL, in this repository:

```bash
conda activate website_perso
mkdocs serve
```

Open [http://127.0.0.1:8000/](http://127.0.0.1:8000/).

Create or update the environment with:

```bash
bash scripts/setup_wsl_conda.sh
# or: conda env create -f environment.yml
# later: conda env update -f environment.yml --prune
```

`requirements.txt` is kept for GitHub Actions, which installs packages with pip.

## CV PDF

The home page links to [`docs/assets/resume_Aug2026.pdf`](docs/assets/resume_Aug2026.pdf). Replace that file when you have a newer resume.

## Publish on GitHub Pages

1. Create a **public** GitHub repository (for example `ABorrel/website_perso` or `ABorrel/ABorrel.github.io`) and push this project to `main`.
2. The workflow in `.github/workflows/ci.yml` builds the site and deploys it to the `gh-pages` branch on every push.
3. In the repository: **Settings → Pages**
   - Source: **Deploy from a branch**
   - Branch: `gh-pages` / `/ (root)`
   - Custom domain: `www.alexborrel.com`
   - Enable **Enforce HTTPS** after DNS has been verified

`docs/CNAME` contains `www.alexborrel.com` so MkDocs deploys do not wipe the custom domain.

## DNS cutover for alexborrel.com

Keep Google Sites live until GitHub Pages shows the new site (for example at `https://aborrel.github.io/website_perso/` or `https://aborrel.github.io/`). Then update DNS at the domain registrar:

| Host | Type | Value |
| --- | --- | --- |
| `www` | CNAME | `ABorrel.github.io` |
| `@` (apex) | A | `185.199.108.153` |
| `@` | A | `185.199.109.153` |
| `@` | A | `185.199.110.153` |
| `@` | A | `185.199.111.153` |
| `@` | AAAA | `2606:50c0:8000::153` |
| `@` | AAAA | `2606:50c0:8001::153` |
| `@` | AAAA | `2606:50c0:8002::153` |
| `@` | AAAA | `2606:50c0:8003::153` |

If the repository is a project site (`username.github.io/repo`), the `www` CNAME still points at `ABorrel.github.io`; GitHub routes the custom domain to the Pages site configured in that repository.

After DNS propagates, confirm HTTPS in **Settings → Pages**.
