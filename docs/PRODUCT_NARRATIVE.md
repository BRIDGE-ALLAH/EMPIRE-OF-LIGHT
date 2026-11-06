# A-L-L-A-H.COM / Empire of Light — Canonical Product Narrative

> One ecosystem. One monorepo. Multiple bounded applications and execution components.

## Canonical decision

- Organization: BRIDGE-ALLAH
- Canonical repository: BRIDGE-ALLAH/EMPIRE-OF-LIGHT
- Public ecosystem brand: A-L-L-A-H.COM
- Ecosystem vision: Empire of Light
- Unified platform: ARSY
- Repository model: one monorepo
- Control/API technology: Node.js + Fastify
- Infrastructure execution technology: Rust

All A-L-L-A-H.COM / Empire of Light platform development converges into one canonical repository: BRIDGE-ALLAH/EMPIRE-OF-LIGHT. The former bjo163/A-L-L-A-H.COM repository is a migration source, not a second long-term platform home. Its maintained applications, packages, contracts, plans, and documentation must be reconciled into the canonical monorepo before the source repository is retired.

This is a monorepo decision, not a monolith-process decision. Components may build, deploy, scale, and release independently while sharing one source of truth and one coordinated architecture.

## What ARSY means

ARSY is the unified platform, not one language, executable, or repository. It consists of bounded components:

- ARSY Control — Node.js + Fastify. Owns ecosystem APIs, identity and tenant integration, product policy, orchestration decisions, integrations, and application workflows.
- ARSY Infrastructure Engine — Rust. Owns build execution, deployment machinery, workload/runtime operations, node and resource management, networking, and infrastructure telemetry.
- ARSY Applications — user-facing experiences such as GATE, Dock, Headquarter, ID, MoonWitness, and other approved applications.
- ARSY Node — the supported host/VPS installation and operating profile. It is not a separate repository or a third backend.

Node.js and Rust are complementary implementation domains of one platform. Do not build a second ARSY backend or duplicate infrastructure capabilities in Fastify.

## Why retain both technologies

The existing application/control code uses Node.js, Fastify, and a pnpm workspace. The infrastructure repository contains a substantial Rust/Cargo workspace derived from Temps. Both represent meaningful implementation and should be reconciled, not discarded or rewritten.

Use Node.js + Fastify for ecosystem APIs, product workflows, identity/tenant policy integration, orchestration, and external integrations. Use Rust for infrastructure execution, runtime-sensitive operations, resource management, networking, and capabilities already implemented in the Rust platform.

Choose technology by responsibility, not fashion. The Node/Rust boundary must use explicit versioned APIs, SDKs, events, or process contracts. Do not create a network service for every internal function.

## Ecosystem ownership

| Domain | Responsibility |
|---|---|
| A-L-L-A-H.COM | Public ecosystem brand, entry, product integration, overall experience |
| ARSY Control | Platform API, identity/tenant integration, product policy, orchestration |
| Rust Infrastructure Engine | Build, deployment, workload execution, nodes, runtime, networking, infrastructure telemetry |
| GATE | Public entrance and ecosystem gateway |
| Dock | Main user-facing home |
| Headquarter | Administrative and operational command experience |
| ID | Identity and access experience; server-side authority remains in ARSY Control |
| MoonWitness | Knowledge, research, narrative, publishing |
| ROCKSOUL | Creative and media products |
| Empire Economy | Commerce and business workflows |
| ARSY Radio | Communication and signal-network domain through explicit contracts |

These are logical ownership boundaries, not a requirement that every domain become a microservice or repository. Apps may be packages or independently deployable services inside the monorepo.

## One repository, clear internal boundaries

The canonical repository must contain the Rust workspace, Node.js/Fastify ARSY Control, web applications, shared packages, SDKs, contracts, deployment profiles, CI/release automation, and product documentation.

The exact directory layout must be reconciled with both existing source trees before moving files. Do not blindly copy directories or overwrite destination files. Inventory paths, packages, dependencies, duplicate capabilities, workflows, contracts, plans, and licenses. Select one authoritative implementation for each capability, preserve required history and attribution, and migrate in verifiable batches.

## Non-overlap rules

- One canonical repository for the ecosystem and platform source.
- One authoritative owner for each data domain and policy.
- ARSY Control owns ecosystem identity integration, tenant policy, and product orchestration decisions.
- Rust engine owns infrastructure execution and platform-local runtime state.
- Applications use documented APIs; they do not access private engine or ARSY database tables.
- Commercial policy belongs to the ecosystem commercial domain; infrastructure reports usage facts and enforces explicit resource limits.
- Platform operational telemetry is distinct from product analytics and business audit.
- MoonWitness and ROCKSOUL own their content domains, not infrastructure primitives.
- Shared packages contain genuinely shared contracts or utilities, not duplicated business logic.
- Independently deployable components are allowed; competing source repositories are not the target architecture.

Before adding a service, crate, package, table, API, worker, or UI, search the entire monorepo and active migration plans. Extend or integrate with the authoritative implementation instead of creating another.

## Current migration truth

The destination repository currently contains the substantial Rust/Cargo infrastructure workspace and its technical assets. The migration-source repository bjo163/A-L-L-A-H.COM contains the pnpm workspace, Fastify ARSY Hub, ecosystem applications, shared packages, and related plans/docs.

Therefore, the target is one monorepo, but code consolidation is not yet complete. Do not claim that the canonical repository already contains all A-L-L-A-H.COM applications or that a single checkout builds every component until migration and clean-checkout verification are complete.

The Rust codebase is Temps-derived. Preserve upstream licenses, NOTICE files, copyright, and third-party attribution. The current scripts/install.sh still resolves upstream Temps releases and installs a temps executable; it is not an ARSY Node installer.

## VPS direction

ARSY Node is the host installation and operating profile of the unified platform. It must install compatible, version-pinned artifacts built by canonical CI, verify checksums/signatures and provenance, check host prerequisites, configure secrets safely, be idempotent, expose health diagnostics, and support backup, restore, upgrade, rollback, and uninstall.

Do not relabel an upstream Temps installer as ARSY Node. A single repository does not require one process or one giant installer. Define deployment profiles only when actual operational needs justify them.

## Migration safeguards

- Preserve upstream licenses, NOTICE, copyright, and third-party attribution.
- Do not rewrite history to imply original authorship.
- Do not globally replace Temps identifiers, crate names, binaries, environment variables, or persistent paths.
- Do not move or overwrite files before inventory and conflict resolution.
- Preserve useful plans, decisions, issue references, and application contracts.
- Record obsolete plans as superseded rather than silently deleting useful context.
- Maintain a migration ledger with source path, destination path, owner, decision, verification, and commit.
- Keep the source repository intact until the destination passes migration verification.

## Success definition

A clean checkout of BRIDGE-ALLAH/EMPIRE-OF-LIGHT contains the authoritative Rust engine, Fastify ARSY Control, approved applications, shared packages, contracts, deployment profiles, and documentation. Both workspaces have reproducible checks, cross-component contracts are tested, and no active product capability depends on a second repository as its source of truth.

One ecosystem. One canonical monorepo. Node.js and Rust as complementary parts of ARSY.
