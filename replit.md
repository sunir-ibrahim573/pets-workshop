# Pets Workshop — Tailspin Shelter

A fictional dog shelter web app used for guided GitHub workshops.

## Stack

- **Frontend:** Astro 6 (SSR via `@astrojs/node` standalone) + Tailwind CSS 4
- **Backend:** Flask + SQLAlchemy with a SQLite database (`app/server/dogshelter.db`)
- **Languages:** Node.js 22, Python 3.12

## Project Layout

```
app/
  client/    # Astro frontend (port 5000, host 0.0.0.0)
    src/pages, src/components, src/layouts
    astro.config.mjs
  server/    # Flask API (port 8000, host 127.0.0.1)
    app.py, models/, utils/
  scripts/   # Original local-dev shell/PowerShell scripts (not used on Replit)
content/     # Workshop instructional content
start.sh     # Replit entry — boots Flask + Astro together
```

## Replit Setup

- The single `Start application` workflow runs `./start.sh`, which launches
  Flask on `127.0.0.1:8000` and Astro on `0.0.0.0:5000` in parallel.
- Astro is configured with `host: 0.0.0.0`, `allowedHosts: true`, and HMR
  disabled so the proxied iframe preview works correctly.
- The frontend reads `API_SERVER_URL` (set to `http://127.0.0.1:8000` by
  `start.sh`) when fetching dogs from the backend during SSR.
- Python deps are installed via uv into `.pythonlibs`; npm deps live in
  `app/client/node_modules`.
- The SQLite database is committed and already seeded with 20 breeds and
  100 dogs. Re-seed with `python3 app/server/utils/seed_database.py`.

## Local Development (outside Replit)

The original scripts in `app/scripts/` (`start-app.sh`, `seed-database.sh`,
PowerShell equivalents) still work for traditional local setups using a
Python virtual environment.
