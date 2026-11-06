# A-L-L-A-H.COM / Empire of Light — Unified Monorepo Blueprint

## 1. Canonical decisions

| Concern | Final decision |
|---|---|
| Organization | BRIDGE-ALLAH |
| Canonical repository | BRIDGE-ALLAH/EMPIRE-OF-LIGHT |
| Public ecosystem brand | A-L-L-A-H.COM |
| Vision | Empire of Light |
| Unified platform | ARSY |
| Repository architecture | One monorepo |
| Control/API backend | Node.js + Fastify |
| Infrastructure execution | Rust |
| Web applications | Existing Next.js/app stacks |
| VPS distribution profile | ARSY Node |

There must be one canonical source repository. The separate bjo163/A-L-L-A-H.COM repository is a migration source, not a second long-term platform repository. Its code, plans, contracts, and documentation must be reconciled into this monorepo. Do not claim consolidation complete until files, dependencies, workflows, provenance, and clean-checkout verification are addressed.

## 2. Product definition

A-L-L-A-H.COM is the public ecosystem identity. Empire of Light is the overarching vision. ARSY is the unified platform coordinating ecosystem applications and infrastructure capabilities.

ARSY is not a language-specific service. It is composed of bounded components. Node.js/Fastify and Rust are complementary technologies within the same monorepo and product.

## 3. Target logical layout

    BRIDGE-ALLAH/EMPIRE-OF-LIGHT
    |
    +-- apps/
    |   +-- arsy/                 Node.js + Fastify control/API backend
    |   +-- gate/                 Public ecosystem entrance
    |   +-- dock/                 Main user-facing home
    |   +-- headquarter/          Administrative/operational experience
    |   +-- id/                   Identity and access experience
    |   +-- moonwitness/          Knowledge/research/publishing experience
    |   +-- rocksoul/             Creative/media experience
    |   +-- other verified apps
    |
    +-- platform/
    |   +-- rust-engine/          Existing Rust infrastructure workspace
    |   +-- node-profile/         ARSY Node installation/deployment profile
    |   +-- contracts/            Only contracts without an existing owner
    |
    +-- packages/                 Shared SDKs, UI, schemas, tooling
    +-- docs/                     Narrative, blueprint, ADRs, app docs, plans
    +-- scripts/ and deployment/  CI, release, verification, install, recovery

This is a target logical layout, not an instruction to move the current Cargo workspace blindly. Keep the Rust workspace root if relocation would create needless churn. Cargo and pnpm can coexist in one repository.

## 4. Responsibility boundaries

### ARSY Control — Node.js + Fastify

Owns ecosystem-facing APIs, identity integration, tenant and product policy, orchestration decisions, product workflows, and external integrations.

Does not own container/build/runtime engine internals, a second proxy or scheduler, Rust-private persistence, or duplicate payment execution.

### ARSY Infrastructure Engine — Rust

Owns supported build/deployment execution, workload lifecycle, runtime, workers, nodes, networking, infrastructure resources, platform-local operational state, and infrastructure telemetry.

Does not own ecosystem-wide identity, tenant membership, product catalog, subscription, entitlement, payment policy, or MoonWitness/ROCKSOUL content.

### Applications

Apps own their experiences and domain workflows. They call authoritative ARSY APIs and do not connect directly to private infrastructure-engine databases or bypass tenant authorization.

### ARSY Node

ARSY Node is an installation and runtime profile, not a separate repository or third backend. It packages compatible artifacts and host configuration for a supported VPS/node role.

## 5. Cross-language integration contract

The Node/Rust boundary must be explicit, versioned, authenticated, and testable.

Required properties:
1. Service-to-service identity with scoped credentials and rotation/revocation.
2. Authenticated principal and tenant references; never trust browser-supplied identity.
3. Versioned request/response and event schemas.
4. Idempotency keys for provisioning and lifecycle commands.
5. Durable operation IDs and observable state transitions.
6. Correlation IDs across API, engine, node, logs, and audit.
7. Timeouts, retries, cancellation, reconciliation, and compensation semantics.
8. Secret redaction in logs and telemetry.
9. Compatibility policy and contract tests in CI.
10. No shared private database tables; communicate through APIs, events, SDKs, or local library interfaces.

Do not turn every function into an HTTP service. Choose process/API boundaries only when independent lifecycle, isolation, scaling, or security justifies the cost.

## 6. Single source-of-truth rules

| Domain | Authoritative owner |
|---|---|
| Ecosystem identity and tenant policy | ARSY Control |
| Product authorization/orchestration decision | ARSY Control |
| Build/deploy/runtime execution | Rust Infrastructure Engine |
| Infrastructure node state | Rust Infrastructure Engine |
| Application experience | Owning app |
| Product billing/catalog/entitlements | Ecosystem commercial domain |
| Infrastructure usage facts and limits | Rust reports facts; ARSY applies product policy |
| Platform operational telemetry | Rust Infrastructure Engine |
| Product analytics and business audit | ARSY / owning product domain |
| MoonWitness knowledge and narrative | MoonWitness |
| ROCKSOUL creative/media | ROCKSOUL |
| Communication signal network | ARSY Radio domain through explicit contract |

If a capability appears in multiple places, identify the source of truth and migrate toward one owner. Do not add a third implementation.

## 7. Current implementation and migration truth

The destination repository currently holds the substantial Rust/Cargo platform workspace and its technical assets. The source repository bjo163/A-L-L-A-H.COM holds the pnpm workspace, Fastify ARSY Hub, ecosystem apps, shared packages, and associated plans/docs.

The target is one monorepo, but source consolidation is not complete. Required migration work includes source/destination inventory, duplicate detection, dependency/workspace reconciliation, CI and secret mapping, app/package/contract ownership, docs/plans/ADR preservation, release/deployment reconciliation, and clean-checkout verification.

The Rust source is Temps-derived. Preserve applicable licenses, NOTICE, copyright, and third-party attribution. The existing scripts/install.sh still targets upstream Temps release assets and is not an ARSY Node installer.

## 8. Monorepo migration sequence

### Phase A — Freeze architecture and inventory
- Declare this repository the only long-term canonical destination.
- Inventory tracked files in both repositories.
- Inventory Cargo crates, pnpm packages, apps, APIs, schemas, migrations, workflows, secrets, deployment targets, docs, plans, ADRs, and open issues.
- Build a path/package ownership map and detect duplicate implementations.
- Create a migration ledger with source path, target path, owner, decision, status, verification, and commit.

Exit: every maintained component and critical contract is classified.

### Phase B — Workspace and source integration
- Preserve the existing Rust workspace and tests.
- Bring the pnpm workspace and Fastify ARSY app into the canonical repository without overwriting Rust paths.
- Resolve root manifest collisions deliberately.
- Reconcile package names and aliases only where safe.
- Consolidate shared schemas and SDKs; do not duplicate contract ownership.
- Preserve legal notices and source provenance.

Exit: clean checkout can install dependencies and discover both workspaces.

### Phase C — CI, contracts, and security
- Reconcile GitHub Actions without dropping existing checks.
- Add coordinated Rust and Node workspace checks.
- Add cross-language contract validation and integration fixtures.
- Reconcile secrets and environment variables without committing values.
- Verify supply-chain, license, vulnerability, and secret-scanning controls.

Exit: required tests run on canonical branches and cross-language contracts are enforced.

### Phase D — Applications and operations
- Integrate apps and packages in small ownership batches.
- Reconcile docs, plans, ADRs, and runbooks.
- Define local development profiles without forcing every app to run together.
- Define deployment profiles and compatible component releases.
- Validate health checks, observability, backup, restore, and rollback.

Exit: maintained components have one authoritative source path and executable development/deployment contracts.

### Phase E — VPS installer and source retirement
- Build canonical release artifacts for Rust and Node components.
- Publish checksums, signatures/provenance, SBOM, and compatibility manifest.
- Implement ARSY Node preflight, install, configuration, health, upgrade, rollback, backup, restore, and uninstall.
- Test clean VPS install, retry, interruption, upgrade, rollback, and restore.
- Only after acceptance, mark the old source repository read-only/archive it and point it to the canonical destination.

Exit: no active build, deployment, release, or product workflow depends on the old repository.

## 9. ARSY Node requirements

- Version-pinned artifacts built by canonical CI.
- Supported OS/architecture matrix.
- SHA-256 checksums and verifiable signatures/provenance.
- Least-privilege service accounts and explicit host permissions.
- Safe secret generation and configuration.
- Idempotent install and recovery from interrupted operations.
- Health checks and actionable diagnostics.
- Version compatibility across Fastify Control, Rust Engine, and node agents.
- Backup/restore, upgrade/rollback, and uninstall.
- Clean-host test evidence.

Hard stop: do not rename the current upstream Temps installer and do not claim ARSY Node is ready until these gates pass.

## 10. Anti-overlap rules for humans and AI agents

1. Search both source repositories and all monorepo paths.
2. Search manifests, imports, APIs, schemas, migrations, tests, and active plans.
3. Name the authoritative owner and source of truth.
4. Prefer reuse, extension, or migration over duplication.
5. Do not move a package while another active package owns its contracts or data.
6. Do not create separate repositories as a workaround for workspace integration.
7. Do not create a service just to mirror an architecture diagram.
8. Record cross-domain changes in an ADR and migration ledger.
9. Keep tasks small, autonomous, testable, and safe to retry.
10. Update README, narrative, blueprint, contracts, and tests when ownership changes.

## 11. Definition of done

A clean checkout of the canonical repository contains both workspaces and all maintained applications; Rust and Node stacks build/test from a clean checkout; cross-language contracts are versioned and tested; each capability has one owner; canonical CI and release automation work; ARSY Node has clean-host evidence; and no active development or deployment depends on the source repository.

One ecosystem. One canonical monorepo. Multiple independently deployable components. No duplicated platform authority.
