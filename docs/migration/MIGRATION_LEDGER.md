# Monorepo Migration Ledger

Status: inventory baseline only. This is not a completed migration record.

## Canonical destination

BRIDGE-ALLAH/EMPIRE-OF-LIGHT, default branch main.

## Temporary source

bjo163/A-L-L-A-H.COM, default branch main. Keep this source intact until all migration acceptance gates pass. Do not archive, delete, or make it read-only prematurely.

## Verified repository snapshot — 2026-11-06

- Source `main` comparison base: `bf8681c714b9983861664a05f0c6d9df752f7549`.
- Source `dev` is 24 commits ahead of source `main` with 158 changed paths and no commits behind at the time of comparison. Do not treat source `main` as the complete migration baseline; review the `dev` delta and preserve unmerged work before selecting the migration snapshot.
- Destination branch `feat/empire-of-light-installers` is divergent from current `main` (30 commits ahead and 21 behind at the time of comparison) and contains unrelated application changes. Do not merge that branch wholesale. Only the reviewed source-bootstrap and conservative-uninstall behavior was ported selectively to `main`.
- Destination `main` now contains `scripts/install-platform.sh`, `scripts/uninstall.sh`, and `scripts/test-installers.sh`. The bootstrap pins an immutable source commit and installs the existing Compose stack only; it is not the Rust-first ARSY Node installer.
- Local shell syntax and CLI smoke checks were run against the installer/uninstaller behavior. No live Docker deployment, clean-host installation, VPS operation, or production readiness test has been performed by this change.


## Verified source components and Rust-first disposition

| Source area | Current evidence | Target decision | Status |
|---|---|---|---|
| Root pnpm workspace and package.json | pnpm workspace; scripts cover apps/packages | Retain only as frontend/tooling workspace where useful; reconcile with Cargo | Pending |
| apps/arsy | Fastify ARSY Hub backend | Audit routes/domain logic; map to existing Rust; port missing required behavior; retire Fastify after parity | Pending |
| apps/gate | Next.js public entrance | Migrate as frontend app; consume Rust APIs | Pending |
| apps/dock | Next.js home/navigation | Migrate as frontend app; consume Rust APIs | Pending |
| apps/headquarter | Next.js operations/admin experience | Migrate as frontend app; consume Rust APIs | Pending |
| apps/id | Next.js identity experience | Migrate UI; Rust remains auth/access authority | Pending |
| apps/jizz | WORLD OBSERVATORY | Confirm final product name and migrate as app if active | Pending |
| apps/harbor | Harbor app | Confirm ownership and migrate if active | Pending |
| apps/moonsky | MoonSky app | Confirm ownership and migrate if active | Pending |
| apps/server | Excluded from pnpm workspace | Inspect whether active, legacy, or superseded; no assumed backend role | Pending |
| packages/* | Shared UI, SDK, types, extension, lint and other packages | Retain frontend/tooling packages; regenerate/validate API clients from Rust contracts; deduplicate | Pending |
| scripts/* | Workspace checks, generators, build/test tooling | Merge by behavior; keep Node scripts tooling-only; preserve Rust scripts | Pending |
| .plans/* and docs | Product plans, autonomous task plans, contracts, blueprints | Reconcile and preserve active decisions | Pending |
| GitHub workflows | CI and automation | Merge Rust and frontend checks; no Fastify backend release target | Pending |

## Destination components to preserve

| Destination area | Decision |
|---|---|
| Rust/Cargo workspace | Preserve as the sole backend/platform baseline; audit before extending |
| Rust crate names and upstream identifiers | Preserve until individually migrated with compatibility tests |
| Existing deployment manifests | Inventory before changing |
| scripts/install.sh | Treat as upstream Temps installer; do not relabel as ARSY Node |
| scripts/install-platform.sh | Experimental pinned source bootstrap for the current Compose stack only; not ARSY Node |
| scripts/uninstall.sh | Conservative Compose removal; preserves named volumes, images, source, .env, and secrets |
| scripts/test-installers.sh | Syntax and CLI smoke checks; does not replace live installation tests |
| Upstream license, NOTICE, copyright | Preserve required notices and attribution |

## Required inventory fields

For every source path/package/crate, record:
- source repository and branch;
- source path and latest commit;
- target path;
- component owner and bounded responsibility;
- duplicate/conflict findings;
- dependency and environment requirements;
- migration action: keep, move, merge, port-to-Rust, replace, retire, or archive;
- legal/provenance requirements;
- tests and verification result;
- migration commit and acceptance evidence.

## Rules

1. Do not mark an item migrated until the target path exists and tests pass.
2. Do not assume a source path maps one-to-one to a target path.
3. Do not overwrite a destination component without a side-by-side comparison.
4. Do not copy secrets, local databases, customer data, or production environment files.
5. Preserve useful source history where feasible and preserve all legal notices.
6. Resolve package, API, schema, and database ownership before merging code.
7. Map Fastify behavior to Rust before implementing; never blindly port files.
8. Keep each migration batch small, reversible, and independently testable.
9. Retire the source repository only after the full consolidation definition of done passes.

See ../MONOREPO_CONSOLIDATION.md for phases, work packages, and acceptance gates.
