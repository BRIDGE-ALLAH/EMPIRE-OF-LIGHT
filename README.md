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

## VPS installation bootstrap

For a clean Ubuntu or Debian VPS, `scripts/install-platform.sh` installs Docker Engine and the Docker Compose v2 plugin from Docker's official APT repository when Docker is absent. It downloads an immutable source archive without requiring Git, generates private credentials, validates the Compose configuration, builds the current stack, and waits for the database, application, and ingress health checks.

Review the installer before running it as root:

```bash
curl -fsSLO https://raw.githubusercontent.com/BRIDGE-ALLAH/EMPIRE-OF-LIGHT/main/scripts/install-platform.sh
less install-platform.sh
sudo bash install-platform.sh
```

The installer supports Ubuntu and Debian only. It does not replace an existing Docker installation; if Docker exists but Compose v2 is missing, it stops and asks for manual repair. It refuses to overwrite an existing install directory or stop conflicting containers/networks. The initial administrator and ingress passwords are shown once; store them securely.

This remains an experimental source bootstrap for the current Compose stack, not a signed binary release or the complete Rust-first ARSY Node profile. The Compose listeners are bound to loopback. Public DNS, HTTPS/reverse proxy, and firewall configuration are not automated yet. Do not expose the service publicly until those ingress controls are configured and verified.

Run `bash scripts/test-installers.sh` for installer contract checks. These do not replace a live clean-host VPS installation. The paired `scripts/uninstall.sh` removes only this Compose project's containers and networks; it preserves named volumes, images, source, `.env`, and secret files. It does not uninstall unrelated Docker projects such as Coolify and has no automatic data-wipe option. Verify backups before manually deleting retained data.

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
