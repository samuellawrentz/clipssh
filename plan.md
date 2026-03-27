# clipssh — GitHub Pages + clipssh.samuellawrentz.com

## Goal

Single static page describing clipssh, served from this repo via GitHub Pages at `https://clipssh.samuellawrentz.com`.

## 1. Add the site files

- Add `index.html` (and optional `style.css` / assets) at the **root** of this repo, **or** under `docs/` if you prefer not to mix site files with scripts at root.
- Content: short pitch, install one-liner from README, usage steps, link to GitHub repo.

## 2. Enable GitHub Pages

- Repo **Settings → Pages**.
- **Source**: Deploy from branch `main`.
- **Folder**: `/ (root)` or `/docs` — match where you put `index.html`.
- Save.

## 3. Custom domain

- In **Settings → Pages → Custom domain**, enter: `clipssh.samuellawrentz.com`.
- Let GitHub create/commit `CNAME` (or add a root file `CNAME` containing exactly that hostname, one line).

## 4. DNS (samuellawrentz.com)

At your DNS provider:

| Type  | Name     | Target                    |
|-------|----------|---------------------------|
| CNAME | `clipssh`| `<your-github-username>.github.io` |

No trailing dot required on most panels. Propagation can take minutes to hours.

## 5. HTTPS

- After DNS resolves, GitHub shows certificate status in Pages settings.
- Enable **Enforce HTTPS** when available.

## 6. Verify

- Open `https://clipssh.samuellawrentz.com` and `https://samuellawrentz.github.io/clipssh/` (project URL) — both should serve the same site once custom domain is active.

## Notes

- User/org site repo (`username.github.io`) is optional; **project Pages** from `samuellawrentz/clipssh` is enough for this subdomain.
- If you add a build step later, use **GitHub Actions** with `actions/upload-pages-artifact` and set Pages source to “GitHub Actions” instead of branch.
