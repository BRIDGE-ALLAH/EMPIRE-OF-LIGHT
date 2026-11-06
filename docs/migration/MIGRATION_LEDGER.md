# Monorepo Migration Ledger

Status: inventory baseline only. This is not a completed migration record.

## Canonical destination

BRIDGE-ALLAH/EMPIRE-OF-LIGHT, default branch main.

## Temporary source

bjo163/A-L-L-A-H.COM, default branch main. Keep this source intact until all migration acceptance gates pass. Do not archive, delete, or make it read-only prematurely.

## Verified source components

| Source area | Current evidence | Target decision | Status |
|---|---|---|---|
| Root pnpm workspace and package.json | pnpm workspace; scripts cover ARSY and multiple apps/packages | Reconcile into canonical root without breaking Cargo workspace | Pending |
| apps/arsy | Fastify ARSY Hub backend | Canonical ARSY Control app | Pending |
| apps/gate | Next.js public entrance | Migrate after app/dependency inventory | Pending |
| apps/dock | Next.js home/navigation | Migrate after app/dependency inventory | Pending |
| apps/headquarter | Next.js operations/admin experience | Migrate after app/dependency inventory | Pending |
| apps/id | Next.js identity experience | Migrate with auth/tenant contract review | Pending |
| apps/jizz | WORLD OBSERVATORY | Confirm final product name and migrate | Pending |
| apps/harbor | Harbor app | Confirm ownership and migrate | Pending |
| apps/moonsky | MoonSky app | Confirm ownership and migrate | Pending |
| apps/server | Excluded from pnpm workspace | Inspect before deciding whether it is active, legacy, or superseded | Pending |
| packages/* | Shared UI, SDK, types, extension, lint and other packages | Inventory owners and deduplicate against destination | Pending |
| scripts/* | Workspace checks, generators, build/test tooling | Merge by behavior; preserve existing Rust scripts | Pending |
| .plans/* and docs | Product plans, autonomous task plans, contracts, blueprints | Reconcile duplicates and preserve active decisions | Pending |
| GitHub workflows | CI and automation | Merge checks without dropping Rust or Node coverage | Pending |

## Destination components to preserve

| Destination area | Decision |
|---|---|
| Rust/Cargo workspace | Preserve as the infrastructure engine baseline |
| Rust crate names and upstream identifiers | Preserve until individually migrated with compatibility tests |
| Existing deployment manifests | Inventory before changing |
| scripts/install.sh | Treat as upstream Temps installer; do not relabel as ARSY Node |
| Upstream license, NOTICE, copyright | Preserve required notices and attribution |

## Required inventory fields

For every source path/package/crate, record:
- source repository and branch;
- source path and latest commit;
- target path;
- component owner and bounded responsibility;
- duplicate/conflict findings;
- dependency and environment requirements;
- migration action: keep, move, merge, replace, retire, or archive;
- legal/provenance requirements;
- tests and verification result;
- migration commit and reviewer/acceptance evidence.

## Rules

1. Do not mark an item migrated until the target path exists and tests pass.
2. Do not assume a source path maps one-to-one to a target path.
3. Do not overwrite a destination component without a side-by-side comparison.
4. Do not copy secrets, local databases, customer data, or production environment files.
5. Preserve useful source history where feasible and preserve all legal notices.
6. Resolve package, API, schema, and database ownership before merging overlapping code.
7. Keep each migration batch small, reversible, and independently testable.
8. Retire the source repository only after the full consolidation definition of done passes.

See ../MONOREPO_CONSOLIDATION.md for phases, work packages, and acceptance gates.
