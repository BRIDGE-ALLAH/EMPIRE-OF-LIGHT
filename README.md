# A-L-L-A-H.COM — EMPIRE OF LIGHT

> One ecosystem. One canonical monorepo. Node.js and Rust working as complementary parts of ARSY.

- Canonical repository: BRIDGE-ALLAH/EMPIRE-OF-LIGHT
- Public ecosystem brand: A-L-L-A-H.COM
- Vision: Empire of Light
- Unified platform: ARSY
- Repository model: single monorepo
- Application/control backend: Node.js + Fastify
- Infrastructure engine: Rust

## The final repository decision

All A-L-L-A-H.COM / Empire of Light platform development converges into this repository: BRIDGE-ALLAH/EMPIRE-OF-LIGHT.

The former bjo163/A-L-L-A-H.COM repository is a migration source only, not a second long-term platform repository. Its Fastify ARSY Hub, applications, packages, contracts, plans, and documentation must be reconciled and migrated here before that source repository is retired. Migration is not yet complete; this README does not claim that all source files are already present here.

This is a monorepo, not a monolith. Apps and services may build, deploy, scale, and release independently while sharing one source of truth and one coordinated architecture.

## What ARSY is

ARSY is the unified platform composed of bounded components in this repository:

| Component | Technology | Responsibility |
|---|---|---|
| ARSY Control | Node.js + Fastify | Ecosystem APIs, identity/tenant integration, product policy, orchestration, integrations |
| ARSY Infrastructure Engine | Rust | Builds, deployments, workloads, nodes, runtime, networking, infrastructure telemetry |
| ARSY Applications | Existing app stacks | GATE, Dock, Headquarter, ID, MoonWitness and other approved experiences |
| ARSY Node | Deployment profile | Installs and operates compatible platform components on VPS/hosts |

Do not build a second ARSY backend or duplicate infrastructure capabilities. Node.js and Rust are complementary parts of one platform. Their boundary must use explicit versioned APIs, SDKs, events, or process contracts.

## Current source baseline

This repository currently contains a substantial Temps-derived Rust/Cargo workspace, related web/SDK code, deployment configuration, scripts, and technical documentation.

The migration-source repository bjo163/A-L-L-A-H.COM currently contains the pnpm workspace, Node.js/Fastify ARSY Hub, ecosystem applications, and shared packages. Consolidation into this repository remains a tracked migration requirement.

Preserve upstream license, NOTICE, copyright, and third-party attribution. Do not globally rename Rust crates, binaries, environment variables, services, database objects, image names, or persistent paths.

## Critical installer warning

The current scripts/install.sh still targets upstream gotempsh/temps releases, downloads temps-* assets, and installs the temps executable. It is not an Empire of Light or ARSY Node installer.

Do not relabel or promote it as the product installer. ARSY Node requires canonical CI-built, version-pinned artifacts, checksums/signatures, supported OS/architecture profiles, clean-host installation tests, safe configuration, health checks, backup/restore, upgrade, and rollback.

## Documentation

- Product narrative: docs/PRODUCT_NARRATIVE.md
- Unified monorepo blueprint: docs/BLUEPRINT.md
- Brand and language system: docs/BRAND_SYSTEM.md
- Monorepo consolidation plan: docs/MONOREPO_CONSOLIDATION.md
- Technical documentation index: docs/README.md
- Architecture overview: docs/architecture/overview/page.mdx
- Rust crate map: docs/architecture/crates.md
- Release readiness: docs/RELEASE_READINESS.md
- Engineering rules: AGENTS.md
- Security policy: SECURITY.md
- Upstream notices and licenses: NOTICE, LICENSE-MIT, and LICENSE

## Development principles

- Search before adding a package, service, API, table, or worker.
- Reuse existing implementations; do not create parallel sources of truth.
- Keep application, control-plane, and infrastructure execution responsibilities explicit.
- Use Fastify for ecosystem control APIs and Rust for infrastructure execution.
- Keep cross-language contracts versioned and tested.
- Separate current implementation facts from target architecture.
- Never claim a build, test, release, installer, or production check passed unless it was actually run and inspected.

## Upstream provenance

This Rust codebase is derived from Temps. Preserve applicable upstream copyright, license, NOTICE, and third-party attribution. Product identity changes do not change legal provenance.
