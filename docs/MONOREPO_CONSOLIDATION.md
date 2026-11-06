# Monorepo Consolidation — A-L-L-A-H.COM into Empire of Light

Destination: BRIDGE-ALLAH/EMPIRE-OF-LIGHT  
Source: bjo163/A-L-L-A-H.COM  
Decision: one canonical monorepo; source repository is temporary until verified migration and retirement.

## Objective

Consolidate the existing Node.js/Fastify ARSY Hub, pnpm workspace, ecosystem applications, shared packages, plans, contracts, and product documentation into the existing Rust/Cargo platform repository. Preserve both technology stacks as complementary components of one ARSY platform. Do not rewrite the Rust engine in JavaScript or rewrite ARSY Control in Rust.

## Verified starting point

- Destination contains a substantial Temps-derived Rust/Cargo workspace, deployment assets, scripts, SDKs, and technical documentation.
- Source contains a pnpm workspace, apps/arsy Fastify backend, Next.js apps, shared packages, scripts, and ecosystem documentation/plans.
- The source package manifest currently points repository/homepage/bugs metadata at bjo163/A-L-L-A-H.COM; update these references after migration is actually complete.
- Destination scripts/install.sh currently downloads gotempsh/temps release assets and installs temps; it is not an ARSY Node installer.
- These facts establish the migration need, not completion.

## Migration rules

1. Never overwrite destination paths without comparing both versions.
2. Preserve the existing Rust workspace and Cargo metadata.
3. Preserve the pnpm workspace and package boundaries; reconcile root manifest collisions deliberately.
4. Inventory every app, package, crate, script, workflow, contract, schema, migration, secret name, deployment target, and active plan.
5. Detect duplicates by behavior and ownership, not merely by directory/package name.
6. Choose one authoritative implementation per capability; record retained, merged, replaced, or retired decisions.
7. Preserve useful commit history where feasible, and always preserve legal notices, license files, copyright, and attribution.
8. Do not move secrets or environment values into Git.
9. Keep the source repository intact until acceptance gates pass.
10. Make each migration batch small, independently verifiable, and reversible.

## Work packages

### MC-001 — Repository and source inventory
- Enumerate destination and source trees.
- Capture branch/default-branch and recent commit baselines.
- Inventory Cargo crates and pnpm workspace packages.
- Inventory apps, runtime ports, scripts, CI workflows, deployment manifests, schemas, migrations, docs, plans, ADRs, and open issues.
- Produce docs/migration/MIGRATION_LEDGER.md with source path, target path, owner, decision, status, test, and commit reference.
- Identify binary/large assets and license constraints.

Acceptance: every maintained top-level component and critical integration has an inventory entry.

### MC-002 — Workspace integration design
- Identify root manifest conflicts and existing workspace assumptions.
- Decide whether Cargo remains at repository root and pnpm workspace coexists there; prefer coexistence over moving Cargo unless tooling forces a move.
- Define non-conflicting script names and CI job boundaries.
- Define shared contract ownership and code-generation direction.
- Document local development profiles that do not require starting every app.

Acceptance: a tested workspace design exists before source moves.

### MC-003 — Rust baseline preservation
- Record existing Cargo toolchain, build/test commands, feature flags, and CI.
- Preserve crate names, database migrations, runtime identifiers, and upstream compatibility.
- Run baseline checks where environment permits and record failures as baseline facts.
- Do not use global Temps replacement.

Acceptance: existing Rust build/test paths remain available and regression checks are documented.

### MC-004 — Fastify ARSY Control migration
- Migrate the Fastify app and its owned packages into non-conflicting paths.
- Preserve auth, tenant, RBAC, audit, ORM, plugin, and API contracts.
- Reconcile package names and repository metadata only after paths and imports are stable.
- Ensure no Fastify app imports private Rust storage or bypasses engine authorization.
- Add a clean-checkout Fastify smoke test.

Acceptance: ARSY Control installs, tests, and starts from the canonical monorepo.

### MC-005 — Application and shared package migration
- Migrate apps in small ownership batches.
- Reconcile shared UI, types, SDK, linting, config, and build tooling.
- Detect duplicate UI/contracts and keep one owner.
- Preserve each app's README, blueprint, plans, assets, and tests.
- Ensure each app can be built independently.

Acceptance: all maintained apps have one canonical path and independently verifiable build commands.

### MC-006 — Cross-language contract
- Define Node-to-Rust authentication and service identity.
- Define versioned request/response/event schemas.
- Add idempotency, operation IDs, correlation IDs, timeouts, retry, cancellation, and reconciliation semantics.
- Add contract tests and integration fixtures.
- Keep private databases separate; no shared private tables.

Acceptance: a representative authorized operation can be issued by ARSY Control, executed by Rust, and reconciled with durable status.

### MC-007 — CI, release, and deployment
- Reconcile GitHub Actions without dropping existing checks.
- Add affected-component checks plus a full release verification path.
- Map required secrets and environment variables without committing values.
- Coordinate compatible Rust/Node artifact versions.
- Add SBOM, checksums, signatures/provenance, release notes, and rollback policy.
- Update deployment manifests and repository links after source migration.

Acceptance: canonical CI builds and tests changed workspaces and produces traceable compatible artifacts.

### MC-008 — ARSY Node installer
- Inventory and quarantine the current upstream Temps installer from product-facing use.
- Define supported VPS OS/architecture profiles.
- Build version-pinned canonical artifacts.
- Implement preflight, safe configuration, install, health, upgrade, rollback, backup, restore, and uninstall.
- Test clean host, retry, interruption, and recovery.
- Never download an upstream Temps binary under an ARSY name.

Acceptance: clean VPS install and recovery evidence exists for every declared supported profile.

### MC-009 — Documentation and plan reconciliation
- Move current product narratives, app blueprints, autonomous rules, plans, ADRs, and runbooks.
- Detect contradictory or superseded documents.
- Keep one canonical doc per subject; link to it instead of cloning.
- Update all repository links and ownership references.
- Preserve useful historical context as superseded records.

Acceptance: agents and developers can identify one authoritative entrypoint and no active plan points to a competing repository.

### MC-010 — Cutover and source retirement
- Run full clean-checkout install/build/test verification.
- Verify app routes, API contracts, Rust engine operations, and deployment profiles.
- Confirm active branches/plans/issues have been reconciled or explicitly deferred.
- Update source repository README with canonical destination and migration status.
- Make source repository read-only/archive only after acceptance and no active dependency remains.

Acceptance: all active work uses BRIDGE-ALLAH/EMPIRE-OF-LIGHT; source repository is no longer required.

## Non-goals

- Do not create a third repository.
- Do not rewrite Rust engine in Node.js.
- Do not rewrite Fastify ARSY Control in Rust.
- Do not force every component into one process.
- Do not split every module into a microservice.
- Do not globally rename Temps identifiers.
- Do not delete source repository or its history before verified cutover.
- Do not claim consolidation, production readiness, or installer readiness based on documentation alone.

## Definition of done

A clean checkout of the canonical repository contains both workspaces and all maintained applications; the Rust and Node stacks have independent local build/test commands; shared contracts are tested; all capabilities have a single owner; canonical CI and releases work; ARSY Node has clean-host evidence; and no active development or deployment depends on the source repository.
