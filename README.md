# EMPIRE OF LIGHT PLATFORM

> **A sovereign infrastructure foundation for building, delivering, and operating digital products.**

**Ecosystem:** [A-L-L-A-H.COM](https://github.com/bjo163/A-L-L-A-H.COM) — Empire of Light  
**Repository:** `BRIDGE-ALLAH/EMPIRE-OF-LIGHT`  
**Category:** Self-hostable developer and infrastructure operations platform  
**Implementation baseline:** Temps-derived Rust workspace and web application

[Product narrative](docs/PRODUCT_NARRATIVE.md) · [Platform blueprint](docs/BLUEPRINT.md) · [Architecture overview](docs/architecture/overview/page.mdx) · [Release readiness](docs/RELEASE_READINESS.md) · [Security](SECURITY.md) · [Contributing](CONTRIBUTING.md)

---

## What this repository is

Empire of Light Platform is the infrastructure and developer-platform foundation within the wider A-L-L-A-H.COM ecosystem. It brings together the technical capabilities required to build, deploy, run, observe, and govern digital workloads on infrastructure controlled by the operator.

The platform exists to reduce fragmentation without hiding operational reality. Operators should be able to understand what is deployed, where it runs, what changed, what failed, who can act, and how to recover.

This repository is **not the whole A-L-L-A-H.COM ecosystem**. It is not the canonical home for MoonWitness content, ROCKSOUL creative products, ecosystem-wide identity policy, or commercial workflows. Those responsibilities remain with their designated products and repositories.

## Product boundaries

| System | Responsibility |
|---|---|
| A-L-L-A-H.COM repository | Ecosystem applications, ARSY product APIs, identity/tenant policy, user-facing workflows, and integration contracts |
| Empire of Light Platform (this repository) | Infrastructure delivery and execution substrate, nodes, networking, supported data services, and operational telemetry |
| ARSY | Ecosystem-facing control and integration: product-domain APIs, policy mapping, orchestration decisions, and commercial-domain coordination |
| MoonWitness | Knowledge, research, narrative, and publishing experiences |
| ROCKSOUL | Creative and media experiences |
| Empire Economy | Commerce experiences and commercial workflows |

These are ownership boundaries, not a declaration that every target capability is complete. See [the product narrative](docs/PRODUCT_NARRATIVE.md) and [the blueprint](docs/BLUEPRINT.md) before adding a capability that may overlap another repository.

## What the codebase currently contains

The current source is a substantial Temps-derived Rust workspace with more than one hundred crates, a web application, SDKs, scripts, deployment configuration, and technical documentation. Its existing architecture covers or provides foundations for:

- application source integration, builds, deployments, and previews;
- containerized workloads, workers, nodes, and runtime operations;
- domains, TLS, routing, ingress, and network controls;
- supported managed data services;
- logs, metrics, traces, analytics, errors, uptime, and diagnostics;
- authentication, authorization, API keys, audit events, and security tooling;
- AI, automation, sandboxes, CLI, SDK, and MCP integration surfaces.

The list describes source-code capability areas, not a certification that every feature is complete, secure, supported, or production-ready. Consult the source, tests, architecture docs, and [release readiness runbook](docs/RELEASE_READINESS.md) for maturity evidence.

## Installer status

`scripts/install.sh` is now an **experimental source-based bootstrap** for the existing Docker Compose stack. It clones this repository, generates private database/admin credentials, validates the Compose configuration, and can build/start the stack. It does not download the upstream Temps CLI binary.

This is not yet a signed binary/release installer or a production-certified VPS deployment. DNS, TLS, reverse-proxy configuration, firewall policy, backups, restore, upgrades, and rollback remain operator responsibilities. The installer refuses to overwrite an existing installation path and does not remove conflicting containers.

The paired `scripts/uninstall.sh` removes only the Compose project's containers and network. It deliberately preserves named volumes, images, source, `.env`, and secrets. See [release readiness](docs/RELEASE_READINESS.md) and [the blueprint](docs/BLUEPRINT.md#10-arsy-node-and-vps-installation-direction).

## Getting started

The following source bootstrap is experimental and is not a production deployment guarantee. Use a clean, dedicated Linux host and review the security and network implications first.

### Requirements

- Linux host recommended for self-hosted operation.
- Docker Engine and Docker Compose plugin.
- Git and OpenSSL.
- Access to the Docker socket for workload management. Docker socket access is effectively host-level privilege; use a trusted host and review the threat model.

### Bootstrap on a clean Linux host

Prerequisites: Docker Engine, Docker Compose v2, Git, and OpenSSL. The Docker daemon must be running and accessible to the installer.

Review `docker-compose.yml`, `.env.example`, [release readiness](docs/RELEASE_READINESS.md), and the Docker-socket security boundary before installation. The installer creates `/opt/empire-of-light` by default and refuses to overwrite an existing directory.

```bash
git clone https://github.com/BRIDGE-ALLAH/EMPIRE-OF-LIGHT.git
cd EMPIRE-OF-LIGHT
sudo bash scripts/install.sh --branch main
```

To prepare configuration without starting containers:

```bash
sudo bash scripts/install.sh --branch main --skip-start
```

The installer displays the initial administrator and ingress passwords once. Store them in a password manager. The Compose stack publishes its ports on host loopback only; configure and review a separate reverse proxy, DNS, TLS, and firewall before public access. It does not automatically install Docker or configure a public domain.

### Stop and remove the Compose deployment

```bash
sudo bash /opt/empire-of-light/scripts/uninstall.sh
```

The uninstaller asks for confirmation and preserves database/application volumes, images, source, `.env`, and secrets. Data deletion is a separate, manual operator action after verified backups.

## Development

The backend is a Cargo workspace. Begin with:

- [`AGENTS.md`](AGENTS.md) — repository engineering rules and contributor entry points.
- [`Cargo.toml`](Cargo.toml) — workspace members and shared dependencies.
- [`docs/architecture/crates.md`](docs/architecture/crates.md) — generated crate map.
- [`DESIGN.md`](DESIGN.md) — current web UI design standards.
- [`REVIEW.md`](REVIEW.md) — recurring security and reliability review findings.

Use the pinned toolchain in [`rust-toolchain.toml`](rust-toolchain.toml). Run the checks appropriate to the files changed. Never report tests, builds, security reviews, or release checks as passing unless they were actually executed and their results inspected.

## Documentation

- **[Product narrative](docs/PRODUCT_NARRATIVE.md)** — canonical ecosystem role, product purpose, boundaries, naming, and principles.
- **[Platform blueprint](docs/BLUEPRINT.md)** — architecture, ownership boundaries, implementation baseline, roadmap, VPS direction, and acceptance gates.
- [Architecture overview](docs/architecture/overview/page.mdx)
- [Crate map](docs/architecture/crates.md)
- [Documentation index](docs/README.md)
- [Release readiness & operator runbook](docs/RELEASE_READINESS.md)
- [Security policy](SECURITY.md)
- [Contributing guide](CONTRIBUTING.md)
- [Upstream notices and licenses](NOTICE), [MIT](LICENSE-MIT), and [Apache 2.0](LICENSE)

## Upstream provenance and compatibility

This repository is derived from the Temps codebase and retains upstream technical identifiers, history, notices, and the applicable MIT OR Apache-2.0 licensing terms. Product identity changes must not erase that provenance.

Do not globally rename crate names, binaries, environment variables, container services, image names, telemetry keys, URLs, or release assets. Treat each externally consumed identifier as a compatibility migration with inventory, aliases or deprecation where appropriate, tests, upgrade notes, and rollback.

## Release status

<em>Production readiness is not certified by this README.</em> Before calling a release production-ready, the project must provide evidence for:

- clean-host installation and first-admin bootstrap;
- supported OS/architecture and resource matrix;
- TLS, ingress, firewall, and least-privilege configuration;
- authentication and authorization tests;
- backup and restore exercise;
- upgrade and rollback exercise;
- health checks and operational diagnostics;
- artifact checksums/signatures and provenance;
- feature maturity and known-limitations documentation;
- preserved upstream legal attribution.

A container starting successfully is not a production sign-off.

## Contributing

Before proposing a change, read [`AGENTS.md`](AGENTS.md), [`REVIEW.md`](REVIEW.md), and [`CONTRIBUTING.md`](CONTRIBUTING.md). Prefer small, reviewable changes with explicit ownership, tests, and documented operational consequences.

## License

This repository retains the upstream dual-license model: [MIT](LICENSE-MIT) or [Apache 2.0](LICENSE). Preserve all required copyright, license, and third-party attribution notices in derivative works.
