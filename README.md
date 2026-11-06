<div align="center">

# MOONWITNESS
### MW-DEVPLATFORM

**Build with clarity. Deploy with sovereignty. Operate with accountability.**

*An open, self-hostable developer platform for teams who want to build, ship, observe, and govern their digital work on infrastructure they control.*

[Brand system](docs/BRAND_SYSTEM.md) · [Architecture blueprint](docs/BLUEPRINT.md) · [Architecture map](docs/architecture/overview/page.mdx) · [Security guidance](SECURITY.md) · [Contributing](CONTRIBUTING.md)

</div>

---

## The story behind the platform

Software should give people more agency, not make them dependent on an opaque stack of disconnected services.

**MoonWitness** is the working brand idea behind MW-DEVPLATFORM: *Moon* evokes cycles, perspective, and a light by which change can be observed; *Witness* expresses responsibility, evidence, and the discipline of seeing systems as they really are. Together, the name describes a platform that helps builders create confidently while remaining accountable for what they operate.

MW-DEVPLATFORM turns that idea into infrastructure. It brings application delivery, runtime operations, observability, data services, security controls, and AI-assisted workflows into one self-hostable environment. The goal is not to hide complexity behind a slogan. The goal is to make complexity understandable, inspectable, and manageable.

### Brand promise

> **Your infrastructure. Your visibility. Your responsibility.**

MW-DEVPLATFORM aims to help independent builders, product teams, and organizations move from fragmented tooling to a coherent operating foundation—without giving up control of their code, data, deployment process, or operational decisions.

### Principles

- **Amanah — stewardship:** treat access, data, compute, and user trust as responsibilities.
- **Clarity — observable by design:** make system state, changes, failures, and costs easier to understand.
- **Sovereignty — control stays with the operator:** favor self-hosting, transparent configuration, and portable workflows.
- **Ihsan — quality in execution:** prioritize reliable defaults, careful engineering, and useful failure messages.
- **Adl — fair boundaries:** apply least privilege, explicit permissions, and predictable resource limits.
- **Rahmah — human-centred operations:** reduce toil and avoid designs that punish users for not knowing hidden system rules.

These are product and engineering principles, not claims of religious authority or a substitute for the beliefs of any individual or community.

## What MW-DEVPLATFORM is

The repository currently contains a Rust workspace and web application for a self-hosted developer platform. Its existing implementation provides a broad foundation for:

| Area | What it enables |
|---|---|
| Application delivery | Connect Git repositories, build containerized apps, deploy releases, and manage previews |
| Runtime and networking | Run workloads, route traffic, manage domains, TLS, and worker nodes |
| Data services | Provision and operate PostgreSQL, Redis, MongoDB, MariaDB, and S3-compatible services |
| Observability | Collect analytics, logs, traces, metrics, uptime signals, and application errors |
| Security and governance | Authentication, authorization, API keys, audit events, network controls, and vulnerability scanning |
| AI and automation | AI gateway, agents, sandboxes, CLI, and MCP integration surfaces |
| Extensibility | Plugin SDK and protocol for integrations and additional capabilities |

The technical foundation is substantial: a Rust workspace with more than one hundred crates, alongside the web application, SDKs, scripts, and documentation. The exact module boundaries and maturity are documented in the repository's architecture materials.

## Product positioning

**Category:** self-hosted developer platform / application operations platform.

**For:** independent developers, engineering teams, digital product studios, and organizations that want an integrated delivery and operations layer.

**Problem:** modern teams often assemble deployment, databases, monitoring, error tracking, logs, analytics, and AI tooling from many separate products. That creates fragmented workflows, duplicated configuration, recurring costs, and operational blind spots.

**Approach:** provide a coherent platform that brings these workflows together while keeping deployment and operational control with the operator.

**Differentiator:** not simply “more tools in one dashboard,” but a consistent operational surface built around visibility, ownership, and responsible control.

## Current implementation and attribution

This repository is based on the Temps codebase and still contains upstream implementation names, package identifiers, environment variables, service names, and documentation references. The current executable and Compose services therefore retain the `temps` naming.

MW-DEVPLATFORM is the intended product and brand direction for this repository. A complete technical rebrand—binary names, Rust crate names, container names, environment variables, UI copy, hosted documentation, installer and release artifacts—must be handled as a separate, tested migration. This README does not claim that migration has already happened.

**Release status:** production readiness is not yet certified. The repository contains CI workflow definitions, but a successful current release pipeline, clean-host installation, backup/restore exercise, and upgrade/rollback test must be evidenced before a production-ready claim. Follow [the release readiness runbook](docs/RELEASE_READINESS.md) and do not treat a successful container start as a security or production sign-off.

Upstream attribution, third-party notices, and the applicable MIT OR Apache-2.0 licensing terms must remain intact. See [NOTICE](NOTICE), [LICENSE](LICENSE), and [LICENSE-MIT](LICENSE-MIT).

## Getting started

### Requirements

- Linux host recommended for a self-hosted deployment.
- Docker Engine and Docker Compose plugin.
- Git.
- OpenSSL for generating strong secrets.
- Access to the Docker socket for workload management. Docker socket access is effectively host-level privilege; deploy only on a trusted host.

### Prepare a local deployment

1. Review the deployment variables and security notes in [`.env.example`](.env.example) and [`docker-compose.yml`](docker-compose.yml).
2. Create a private `.env` file and set every required value. Do not commit secrets.
3. Generate independent URL-safe database passwords with `openssl rand -hex 32`.
4. Prepare the initial administrator password files at the paths configured in `.env`; keep their parent directory private and follow the file permission requirements documented in the example.
5. Confirm the Docker socket group ID and network ranges do not conflict with your host, LAN, or VPN.
6. Review the Compose file and its exposed ports before starting services.

The repository's deployment configuration deliberately fails when required credentials are missing. Do not replace those checks with default passwords or expose database ports publicly.

After configuration, start the stack from the repository root:

```bash
docker compose config
docker compose up -d --build
docker compose ps
```

If `docker compose config` reports a missing variable, return to `.env` and complete the required configuration. Check service logs with:

```bash
docker compose logs -f temps
```

> **Operational note:** this is a privileged infrastructure platform. Do not expose its administration interfaces directly to the public internet until TLS, ingress restrictions, administrator credentials, backups, and firewall policy have been reviewed. The commands above are a deployment entry point, not a production security sign-off.

### Development

The backend is a Cargo workspace. Start by reviewing:

- [`AGENTS.md`](AGENTS.md) — repository engineering rules and contributor entry points.
- [`Cargo.toml`](Cargo.toml) — Rust workspace members and shared dependencies.
- [`docs/architecture/crates.md`](docs/architecture/crates.md) — generated crate map.
- [`DESIGN.md`](DESIGN.md) — current web UI design standards.
- [`REVIEW.md`](REVIEW.md) — recurring security and reliability review findings.

Use the repository's pinned Rust toolchain in [`rust-toolchain.toml`](rust-toolchain.toml). Run checks appropriate to the area you change; do not assume a full workspace test has passed unless it has actually been run.

## Documentation

- **[MW-DEVPLATFORM Blueprint](docs/BLUEPRINT.md)** — narrative, positioning, principles, product architecture, roadmap, and acceptance criteria.
- **[Release readiness & operator runbook](docs/RELEASE_READINESS.md)** — first-install steps, engineering/security gates, and evidence required before production.
- [Architecture overview](docs/architecture/overview/page.mdx)
- [Crate map](docs/architecture/crates.md)
- [Documentation index](docs/README.md)
- [Security policy](SECURITY.md)
- [Contributing guide](CONTRIBUTING.md)

## MW identity implementation

The product narrative and identity rules are documented in [the brand system](docs/BRAND_SYSTEM.md) and [the product blueprint](docs/BLUEPRINT.md). The dashboard sidebar, loading shell, browser title, original product mark, and lunar focus accent now carry the MW identity. This is the first shell-level implementation, not a claim that every route, email, CLI output, installer, or release artifact has been rebranded. Continue the UI audit using the acceptance checklist in the brand system.

Do not globally rename the Temps-derived technical identifiers. Preserve upstream attribution and plan any CLI, service, environment-variable, image, database, or deployment rename as a compatibility migration with tested upgrade and rollback paths.

## Community and contributions

Contributions should make the platform more understandable, secure, and dependable. Before proposing a change, read [AGENTS.md](AGENTS.md), [REVIEW.md](REVIEW.md), and [CONTRIBUTING.md](CONTRIBUTING.md).

## License

This repository retains the upstream dual-license model: [MIT](LICENSE-MIT) or [Apache 2.0](LICENSE). Preserve all required copyright, license, and third-party attribution notices in derivative works.
