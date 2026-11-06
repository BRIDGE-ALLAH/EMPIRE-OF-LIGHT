# A-L-L-A-H.COM — EMPIRE OF LIGHT

> One ecosystem. One canonical monorepo. Rust-first ARSY platform.

- Canonical repository: BRIDGE-ALLAH/EMPIRE-OF-LIGHT
- Public ecosystem brand: A-L-L-A-H.COM
- Vision: Empire of Light
- Unified platform: ARSY
- Repository model: single monorepo
- Backend/platform authority: Rust
- Web experience: existing Next.js / React applications
- Node.js: frontend tooling and build tools only where needed; not a second backend authority

## Canonical decision

All A-L-L-A-H.COM / Empire of Light development converges into this repository. The former bjo163/A-L-L-A-H.COM repository is a temporary migration source, not a second long-term platform home.

ARSY is Rust-first. Rust is the authoritative backend and platform implementation for APIs, identity and access enforcement, tenant boundaries, orchestration, infrastructure operations, node management, and platform services. Existing Rust capabilities must be audited and reused before adding new crates or services.

The legacy Fastify implementation in the source repository is migration input only. Audit its routes, business rules, auth/RBAC, tenant model, data model, integrations, jobs, and tests. Preserve requirements and useful domain behavior, but do not preserve Fastify as a parallel production backend. Reimplement or integrate required capabilities into the Rust architecture after checking existing Rust crates. Do not blindly port code or duplicate capabilities.

This is a monorepo, not a monolith. Rust services and applications may build, deploy, scale, and release independently while sharing one source of truth.

## ARSY technology boundaries

| Area | Direction |
|---|---|
| ARSY backend and platform authority | Rust |
| API/service layer | Rust |
| Identity, authorization, tenant enforcement | Rust-owned authoritative services/contracts |
| Infrastructure/runtime/build/deployment | Existing Rust platform capabilities; extend only after audit |
| Node/VPS agent and host operations | Rust |
| Web applications | Existing Next.js / React stacks |
| Node.js | Frontend build/dev tooling only where required; no Fastify backend authority |
| Shared contracts and SDKs | Versioned, generated or validated against Rust-owned contracts |

Do not create a second backend in Node.js/Fastify. Do not rewrite existing Rust capabilities in another language. Do not assume every feature needs a microservice; use crate/library boundaries by default and separate processes only where isolation, lifecycle, scaling, or security justify them.

## One repository, clear boundaries

The canonical repository must ultimately contain the Rust workspace, approved web applications, shared packages, contracts, deployment profiles, CI/release automation, and product documentation. The source repository migration is not yet complete; this README does not claim all applications or packages are already present here.

## Current source baseline

This repository currently contains a substantial Temps-derived Rust/Cargo workspace, deployment assets, scripts, SDKs, and technical documentation. The migration-source repository bjo163/A-L-L-A-H.COM contains a pnpm workspace, Fastify ARSY Hub, Next.js applications, shared packages, scripts, and plans/docs.

Preserve upstream license, NOTICE, copyright, and third-party attribution. Do not globally rename Rust crates, binaries, environment variables, services, database objects, image names, or persistent paths.

## Critical installer warning

The current scripts/install.sh still targets upstream gotempsh/temps releases, downloads temps-* assets, and installs the temps executable. It is not an Empire of Light or ARSY Node installer.

Do not relabel or promote it as the product installer. ARSY Node requires canonical CI-built, version-pinned Rust artifacts, checksums/signatures and provenance, supported OS/architecture profiles, clean-host installation tests, safe configuration, health checks, backup/restore, upgrade, and rollback.

## Documentation

- Product narrative: docs/PRODUCT_NARRATIVE.md
- Unified monorepo blueprint: docs/BLUEPRINT.md
- Brand and language system: docs/BRAND_SYSTEM.md
- Monorepo consolidation plan: docs/MONOREPO_CONSOLIDATION.md
- Migration ledger: docs/migration/MIGRATION_LEDGER.md
- Technical documentation index: docs/README.md
- Architecture overview: docs/architecture/overview/page.mdx
- Rust crate map: docs/architecture/crates.md
- Release readiness: docs/RELEASE_READINESS.md
- Engineering rules: AGENTS.md
- Security policy: SECURITY.md
- Upstream notices and licenses: NOTICE, LICENSE-MIT, and LICENSE

## Development principles

- Rust is the only planned backend/platform authority.
- Node.js is tooling for frontend work only where required; do not add Fastify backend services.
- Search the existing Cargo workspace before adding a crate, service, API, table, or worker.
- Reuse existing Rust implementations; avoid parallel sources of truth.
- Treat legacy Fastify as a requirements and migration source, not a target runtime.
- Keep current implementation facts separate from target architecture.
- Never claim a build, test, release, installer, or production check passed unless it was actually run and inspected.

## Upstream provenance

This Rust codebase is derived from Temps. Preserve applicable upstream copyright, license, NOTICE, and third-party attribution. Product identity changes do not change legal provenance.
