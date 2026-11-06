# Monorepo Consolidation — A-L-L-A-H.COM into Empire of Light

Destination: BRIDGE-ALLAH/EMPIRE-OF-LIGHT  
Source: bjo163/A-L-L-A-H.COM  
Decision: one canonical monorepo; Rust-first backend; source repository is temporary until verified migration and retirement.

## Objective

Consolidate the ecosystem applications, shared packages, contracts, plans, and documentation into the existing Rust/Cargo platform repository. Establish Rust as the sole backend/platform authority. The legacy Fastify ARSY Hub is a migration reference: inventory its behavior, reuse existing Rust capabilities, port only missing required behavior, cut consumers over, and retire the Fastify backend after verified parity.

Do not preserve two backend implementations. Do not rewrite the existing Rust platform in Node.js.

## Verified starting point

- Destination contains a substantial Temps-derived Rust/Cargo workspace, deployment assets, scripts, SDKs, and technical documentation.
- Source contains a pnpm workspace, Fastify ARSY Hub, Next.js apps, shared packages, scripts, and ecosystem documentation/plans.
- The source package manifest points repository/homepage/bugs metadata at bjo163/A-L-L-A-H.COM; update these references after migration is complete.
- Destination scripts/install.sh currently downloads gotempsh/temps release assets and installs temps; it is not an ARSY Node installer.
- These facts establish migration work, not completion or Rust feature parity.

## Migration rules

1. Never overwrite destination paths without comparing both versions.
2. Preserve the existing Rust workspace and Cargo metadata.
3. Keep pnpm only for frontend workspace and tooling where needed; do not add Fastify as a backend.
4. Inventory every app, package, crate, route, API, schema, migration, workflow, secret name, deployment target, and active plan.
5. Map legacy Fastify behavior to Rust capabilities before writing code.
6. Reuse existing Rust capability; port only missing behavior to its correct Rust owner.
7. Choose one authoritative implementation per capability and record retained, merged, replaced, or retired decisions.
8. Preserve useful commit history where feasible, and always preserve legal notices, license files, copyright, and attribution.
9. Do not move secrets or environment values into Git.
10. Keep the source repository intact until acceptance gates pass.
11. Make each migration batch small, independently verifiable, and reversible.

## Work packages

### MC-001 — Repository and capability inventory
- Enumerate destination and source trees.
- Inventory Cargo crates, pnpm packages, apps, Fastify routes, APIs, schemas, migrations, workflows, deployment manifests, docs, plans, ADRs, and open issues.
- Capture source branch/default-branch and commit baselines.
- Map each legacy Fastify capability against Rust code, tests, docs, and feature flags.
- Produce docs/migration/MIGRATION_LEDGER.md with source path, target owner, action, status, test, and commit reference.

Acceptance: every maintained app and backend capability has a documented disposition.

### MC-002 — Rust backend authority design
- Identify the existing Rust API/service entrypoints and crate ownership.
- Map identity, authorization, tenant isolation, audit, orchestration, jobs, and domain persistence.
- Identify genuine gaps only after searching the full Rust workspace.
- Define versioned API/event contracts and compatibility policy.
- Add or extend Rust crates only where a verified gap exists.

Acceptance: one documented Rust backend authority with tested contracts and no parallel Fastify target.

### MC-003 — Preserve and verify Rust baseline
- Record existing Cargo toolchain, workspace commands, feature flags, and CI.
- Preserve crate names, migrations, runtime identifiers, and upstream compatibility.
- Run baseline checks where environment permits and record failures as baseline facts.
- Do not globally replace Temps identifiers.

Acceptance: existing Rust build/test paths remain available and regression checks are documented.

### MC-004 — Reconcile legacy Fastify ARSY Hub
- Inventory routes, handlers, schemas, auth/RBAC, tenant model, persistence, integrations, jobs, events, and tests.
- Classify each capability as already covered by Rust, extend existing Rust owner, port missing behavior, or retire.
- Port domain behavior into Rust by bounded capability; do not translate files line-by-line.
- Add parity tests and security tests.
- Migrate consumers to Rust APIs and preserve compatibility where required.
- Retire Fastify runtime only after verified parity and consumer cutover.

Acceptance: no production app or deployment depends on Fastify as a backend.

### MC-005 — Frontend and shared package migration
- Migrate approved Next.js apps and shared UI packages into non-conflicting paths.
- Keep Node.js/pnpm scoped to frontend builds, code generation, and developer tooling.
- Generate or validate SDKs against Rust-owned contracts.
- Remove obsolete Fastify clients only after consumer cutover.
- Preserve app blueprints, plans, assets, and tests.

Acceptance: maintained frontends build independently and consume Rust-owned APIs.

### MC-006 — CI, security, release, and deployment
- Reconcile GitHub Actions without dropping Rust checks.
- Add Rust backend, frontend build, API contract, and integration tests.
- Reconcile secrets and environment variables without committing values.
- Publish traceable Rust artifacts, SBOM, checksums, signatures/provenance, and release notes.
- Implement ARSY Node preflight, install, health, upgrade, rollback, backup, restore, and uninstall.

Acceptance: canonical CI and release checks are reproducible; ARSY Node has clean-host evidence.

### MC-007 — Documentation and plan reconciliation
- Move current product narratives, app blueprints, autonomous task plans, ADRs, and runbooks.
- Detect contradictory or superseded documents.
- Keep one canonical doc per subject; link to it instead of cloning.
- Update repository links and ownership references.
- Preserve useful historical context as superseded records.

Acceptance: agents and developers can identify one authoritative entrypoint and no active plan points to a competing repository.

### MC-008 — Cutover and source retirement
- Run full clean-checkout Rust tests and frontend build verification.
- Verify API parity, auth/tenant boundaries, app routes, and deployment profiles.
- Confirm active branches/plans/issues have been reconciled or explicitly deferred.
- Update source repository README with canonical destination and migration status.
- Archive or make source repository read-only only after no active dependency remains.

Acceptance: all active work uses BRIDGE-ALLAH/EMPIRE-OF-LIGHT; source repository is no longer required.

## Non-goals

- Do not create a third repository.
- Do not build or retain Fastify as a parallel production backend.
- Do not rewrite Rust capabilities in Node.js.
- Do not force every Rust crate into a separate process.
- Do not split every module into a microservice.
- Do not globally rename Temps identifiers.
- Do not delete source repository or its history before verified cutover.
- Do not claim Rust feature parity, consolidation, production readiness, or installer readiness without evidence.

## Definition of done

A clean checkout of the canonical repository contains the authoritative Rust backend/platform, approved applications, frontend packages, Rust-owned contracts, and documentation. Rust tests and frontend builds are reproducible; legacy Fastify capabilities have explicit parity/disposition evidence; each capability has one owner; canonical CI and releases work; ARSY Node has clean-host evidence; and no active development or deployment depends on the source repository.
