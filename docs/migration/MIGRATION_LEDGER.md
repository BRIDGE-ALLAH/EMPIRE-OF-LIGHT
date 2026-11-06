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
- Local shell syntax and CLI smoke checks were run against the installer/uninstaller behavior. The smoke test is wired into the `workflow-contracts` job in `.github/workflows/rust-tests.yml`; the resulting GitHub Actions run still needs to provide evidence. No live Docker deployment, clean-host installation, VPS operation, or production readiness test has been performed by this change.


## Legacy Fastify route inventory — source `dev`

Inspected `apps/arsy/src/app.ts` on source branch `dev` (blob `3302311f472977869d6e3d18e68a176e62c4b6b5`, 1,199 lines). It declares 34 direct Fastify route handlers. It also registers plugin-owned route surfaces for authentication, SDUI, LLM gateway, and storage; those plugin routes are additional inventory work and are not included in the 34 count.

| Domain | Direct routes found | Rust migration disposition |
|---|---|---|
| Health/readiness | `GET /health`, `GET /ready` | Map to existing health/readiness and deployment probes |
| Qorpus | `POST /v1/qorpus/ingest`, `POST /v1/qorpus/search` | Audit knowledge/search and memory crates; pending parity map |
| Threads | `GET/POST /v1/threads` | Audit existing AI-agent/conversation capabilities; pending |
| Audit | `GET /v1/admin/audit-events` | Audit existing audit crate and authorization scope; pending |
| Nexus NAS | `GET/POST /v1/nexus/nas` | Audit existing storage/provider/secret capabilities; pending |
| Nexus pools | `GET /v1/nexus/pools` | Identify owning Rust resource/pool capability; pending |
| Orbit instances | `GET/POST /v1/orbit/instances` | Audit existing sandbox/workload/runtime capabilities; pending |
| Works plans | `GET/POST /v1/works/plans` | Identify commercial/product-policy owner; pending |
| Works subscriptions | `GET/POST /v1/works/subscriptions` | Audit revenue/billing capabilities; pending |
| Works invoices | `GET /v1/works/invoices` | Audit revenue/billing capabilities; pending |
| Public ISP | `GET /v1/public/isp/plans`, `GET /v1/public/isp/coverage` | Identify public catalog/coverage owner and safe projection contract; pending |
| HelioGrid | `POST /v1/heliogrid/telemetry` | Identify telemetry ingestion owner; pending |
| Internationalization | `GET /v1/i18n/languages`, `POST /v1/i18n/terms/sync` | Identify localization/catalog owner; pending |
| Projects | `GET/POST /v1/projects`, `GET/PATCH /v1/projects/:projectId` | Audit existing project/deployment ownership; pending |
| Project tasks | `GET /v1/projects/:projectId/tasks`, `PATCH /v1/projects/:projectId/tasks/:taskId` | Audit project/task ownership and authorization; pending |
| Project operations | `POST /v1/projects/:projectId/sync`, `GET /v1/projects/:projectId/export` | Map sync/export semantics and idempotency; pending |
| Project stages | `GET/POST /v1/projects/:projectId/stages` | Audit workflow/stage capabilities; pending |
| Admin cron | `GET /v1/admin/cron`, `POST /v1/admin/cron/seed/:companyId` | Map scheduling/tenant admin behavior; pending |

Cross-cutting behavior observed in this source file includes exact-method public route rules, per-route rate limits, CORS origin policy, security headers/CSP, a principal guard, tenant scoping, admin-reason hashing, ORM-backed persistence, addon registration, and migration/seed orchestration. The Fastify app uses the source repository's PGlite-based `@allah/arsy-orm`; do not assume its data model or transaction behavior matches the Rust platform.

### Existing Rust capability candidates (not yet proven route parity)

The current generated Rust crate map (`docs/architecture/crates.md`) exposes likely owners that must be inspected before any new implementation is proposed:

| Legacy area | Existing Rust candidates | Evidence gap |
|---|---|---|
| Authentication and authorization | `temps-auth`, `temps-authz` | Route-by-route session, role, tenant, and response parity still required |
| Audit | `temps-audit`, `temps-entities` | Crate map currently shows the audit crate consumed by CLI; HTTP endpoint parity is unproven |
| Threads / AI conversations | `temps-ai-chat`, `temps-ai-agents`, `temps-memory` | Conversation model, thread lifecycle, and user/tenant scoping are not yet compared |
| Qorpus ingest/search | `temps-memory`, `temps-ai-chat`, `temps-blob` | No direct Qorpus owner is identified; inspect indexing, chunking, retrieval, and persistence semantics |
| Nexus NAS / pools | `temps-blob`, `temps-providers-s3`, `temps-backup`, `temps-config` | NAS credential custody, pool lifecycle, and audit semantics need explicit mapping |
| Orbit instances | `temps-sandbox`, `temps-workload-plane`, `temps-nodes`, `temps-deployments` | Map instance lifecycle and ownership to existing workload/sandbox primitives |
| Works plans / subscriptions / invoices | `temps-revenue` | Existing crate is described as project revenue tracking; commercial catalog and subscription parity are not established |
| Projects / tasks / stages | `temps-project-groups`, `temps-projects` | Compare task/stage schemas, workflow transitions, tenant scoping, sync/export behavior |
| HelioGrid telemetry | `temps-otel`, `temps-product-telemetry`, `temps-monitoring` | Existing telemetry products are not evidence of HelioGrid domain-ingestion parity |
| Admin cron | `temps-monitoring`, existing scheduler/worker facilities | Monitoring cron checks are not necessarily equivalent to tenant-scoped scheduled jobs |
| i18n / public ISP catalog | No obvious dedicated crate in the current crate map | Define domain owner and API contract only after searching full source and Rust workspace |

These are search candidates, not approved migrations or evidence of completed behavior. In particular, a crate's existence does not prove that a user-facing HTTP route, authorization policy, data migration, or frontend contract already exists.


**Disposition:** this is a requirements inventory, not a route-parity claim. No Fastify handler has been marked migrated. Each route must be mapped to an existing Rust owner or an evidenced gap, then covered by authorization, tenant-isolation, contract, and behavior-parity tests before consumer cutover.

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
