# A-L-L-A-H.COM / Empire of Light — Canonical Product Narrative

> One ecosystem. One monorepo. One Rust-first ARSY platform.

## Canonical decision

- Organization: BRIDGE-ALLAH
- Canonical repository: BRIDGE-ALLAH/EMPIRE-OF-LIGHT
- Public ecosystem brand: A-L-L-A-H.COM
- Ecosystem vision: Empire of Light
- Unified platform: ARSY
- Repository model: one monorepo
- Backend/platform authority: Rust
- Web applications: existing Next.js / React stacks
- Node.js: frontend tooling only where required; not a backend authority

All A-L-L-A-H.COM / Empire of Light platform development converges into BRIDGE-ALLAH/EMPIRE-OF-LIGHT. The former bjo163/A-L-L-A-H.COM repository is a temporary migration source, not a second long-term platform home.

## What ARSY means

ARSY is the unified Rust-first platform. Rust owns the authoritative backend and platform capabilities: APIs, identity/access enforcement, tenant boundaries, orchestration, infrastructure execution, node operations, and platform services. The existing Rust workspace is the baseline to audit and extend.

ARSY is not split into a Node backend and a Rust backend. There is one backend authority: Rust. Use internal Rust crates and libraries for modularity; introduce separate Rust processes only when independent lifecycle, isolation, scaling, or security requires them.

## Legacy Fastify disposition

The source repository contains a Fastify ARSY Hub. It is not the target production backend and must not be migrated as a parallel service.

Treat it as a source of requirements and domain knowledge:
- inventory routes, handlers, business rules, auth/RBAC, tenant logic, data models, integrations, jobs, events, and tests;
- map each capability against existing Rust crates and services;
- reuse Rust capabilities where they already exist;
- port only missing required behavior into the appropriate Rust owner;
- preserve API compatibility deliberately where consumers depend on it;
- retire the Fastify runtime only after equivalent Rust capability and migration verification.

Do not blindly translate files line-by-line. Reconcile domain behavior and contracts first. Node.js may remain for Next.js tooling, package management, frontend builds, and developer scripts, but not as a competing backend.

## Ecosystem ownership

| Domain | Responsibility |
|---|---|
| A-L-L-A-H.COM | Public ecosystem brand, entry, product integration, overall experience |
| ARSY Rust platform | Authoritative APIs, identity/access, tenant policy, orchestration, platform services |
| Rust infrastructure capabilities | Build/deploy/runtime execution, nodes, networking, infrastructure telemetry |
| GATE | Public entrance and ecosystem gateway |
| Dock | Main user-facing home |
| Headquarter | Administrative and operational command experience |
| ID | Identity and access experience; enforcement and authority remain in Rust |
| MoonWitness | Knowledge, research, narrative, publishing |
| ROCKSOUL | Creative and media products |
| Empire Economy | Commerce and business workflows |
| ARSY Radio | Communication and signal-network domain through explicit contracts |

These are logical ownership boundaries, not a requirement that every domain become a microservice or repository. Apps may be packages or independently deployable components inside the monorepo.

## One repository, clear internal boundaries

The canonical repository must ultimately contain the Rust workspace, approved web applications, shared packages, contracts, deployment profiles, CI/release automation, and product documentation. Keep the existing Cargo workspace stable unless a measured technical reason justifies relocation.

The exact layout must be reconciled with the source tree before moving files. Do not blindly copy directories or overwrite destination files. Inventory paths, packages, dependencies, duplicate capabilities, workflows, contracts, plans, and licenses. Select one authoritative Rust implementation per backend capability.

## Non-overlap rules

- One canonical repository for ecosystem and platform source.
- One backend authority: Rust.
- One authoritative owner for each data domain and policy.
- No Fastify backend running beside Rust as a second authority.
- No porting capability already implemented in the Rust workspace.
- Applications call documented APIs and never bypass authorization or access private platform tables.
- Commercial policy belongs to the ecosystem commercial domain; platform reports usage facts and enforces explicit resource limits.
- Platform operational telemetry is distinct from product analytics and business audit.
- MoonWitness and ROCKSOUL own their content domains, not infrastructure primitives.
- Shared packages contain genuinely shared contracts or utilities, not duplicated business logic.

Before adding a crate, service, package, table, API, worker, or UI, search the whole monorepo and migration inventory. Extend the authoritative implementation instead of creating another.

## Current migration truth

The destination repository currently contains a substantial Temps-derived Rust/Cargo platform workspace and technical assets. The migration-source repository bjo163/A-L-L-A-H.COM contains the pnpm workspace, Fastify ARSY Hub, ecosystem applications, shared packages, and related plans/docs.

Consolidation is not complete. The Fastify code must be audited for domain requirements and mapped to Rust; it must not be treated as a second backend to retain. Do not claim all applications are in the canonical repository until migration and clean-checkout verification finish.

Preserve Rust upstream licenses, NOTICE files, copyright, and third-party attribution. The current scripts/install.sh still resolves upstream Temps releases and installs a temps executable; it is not an ARSY Node installer.

## VPS direction

ARSY Node is the supported Rust-first host/VPS installation and operating profile. It must install compatible, version-pinned artifacts built by canonical CI, verify checksums/signatures and provenance, check host prerequisites, configure secrets safely, be idempotent, expose health diagnostics, and support backup, restore, upgrade, rollback, and uninstall.

Do not relabel an upstream Temps installer as ARSY Node. Define deployment profiles only when actual operational needs justify them.

## Success definition

A clean checkout of BRIDGE-ALLAH/EMPIRE-OF-LIGHT contains the authoritative Rust backend/platform, approved applications, shared packages, contracts, deployment profiles, and documentation. Required Rust checks and frontend builds are reproducible; backend contracts and access boundaries are tested; each capability has one owner; canonical CI/releases work; ARSY Node has clean-host evidence; and no active development or deployment depends on a second repository.

One ecosystem. One canonical monorepo. One Rust-first backend authority.
