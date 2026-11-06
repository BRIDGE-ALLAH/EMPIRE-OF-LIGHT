# A-L-L-A-H.COM — EMPIRE OF LIGHT | Release Readiness & Operator Runbook

> **One ecosystem. One canonical monorepo. Build with clarity. Deploy with sovereignty. Operate with accountability.**

This runbook turns the ARSY product blueprint into verifiable release gates. It deliberately distinguishes repository configuration from proof that a deployment works.

## 1. Readiness statement

**Current status: NOT YET CERTIFIED FOR PRODUCTION.**

The repository contains a substantial Temps-derived Rust workspace, web application, Docker Compose deployment, and multiple GitHub Actions workflow definitions. A successful current build, clean installation, and production operation have not yet been independently demonstrated in this readiness record. This is not evidence that tests fail; it means the required evidence is not recorded here.

Do not advertise a production-ready ARSY release until the gates below have recorded evidence.

## 2. Product identity and compatibility

- Public ecosystem brand: **A-L-L-A-H.COM**.
- Product / vision: **EMPIRE OF LIGHT**.
- Unified platform: **ARSY**.
- Engineering workspace / project context: **MW-DEVPLATFORM** (internal project name, not the public product brand).
- Product principle: **One ecosystem. One canonical monorepo.**
- Current implementation lineage: Temps-derived for the Rust/Cargo portion of this repository.
- Current Compose services, environment variables, Rust crates, executable and many operational identifiers still use `temps`.
- Preserve upstream copyright, license, NOTICE, and third-party attribution.
- Do not rename CLI commands, database identifiers, images, environment variables, or persistent volume names as a cosmetic change. Plan compatibility aliases and tested migration/rollback first.

ARSY is Rust-first with one backend/platform authority. Rust owns APIs, identity and access enforcement, tenant boundaries, orchestration, infrastructure execution, node operations, and platform services. Node.js is limited to frontend development/build tooling, package management, code generation, and developer scripts where needed. Treat the legacy Fastify service as migration input: map its routes and domain behavior to existing Rust crates, port only verified gaps, and retire the Fastify runtime after parity and consumer cutover.

## 3. Deployment prerequisites

Use a dedicated Linux host for a real deployment. Confirm:

- Docker Engine and the Docker Compose plugin are installed and supported.
- `curl`, `tar`, and OpenSSL are installed. Git is not required by the experimental source bootstrap.
- The operator understands that mounting `/var/run/docker.sock` grants effectively host-level control.
- The configured Docker subnets do not overlap the host LAN, VPN, existing Docker networks, or routed networks.
- Firewall policy, ingress exposure, DNS, TLS termination, and administrator access have been reviewed.
- Persistent storage capacity, backup destination, restore destination, and monitoring are available.

## 4. First-install procedure — experimental Compose source bootstrap

**Scope warning:** this installs the repository's current Compose stack from a pinned source commit. It does not install the complete Rust-first ARSY Node profile and is not a signed binary release or production certification.

The bootstrap requires Linux, root privileges, Docker Engine, Docker Compose v2, `curl`, `tar`, OpenSSL, and standard shell utilities. It does not require a local Git clone.

Review the pinned installer before running it:

```bash
curl -fsSLO https://raw.githubusercontent.com/BRIDGE-ALLAH/EMPIRE-OF-LIGHT/a32440de14dba0d14870b308e112476976d62d04/scripts/install-platform.sh
less install-platform.sh
sudo bash install-platform.sh
```

A direct one-line invocation is available after reviewing and trusting that exact pinned script:

```bash
curl -fsSL https://raw.githubusercontent.com/BRIDGE-ALLAH/EMPIRE-OF-LIGHT/a32440de14dba0d14870b308e112476976d62d04/scripts/install-platform.sh | sudo bash
```

The script downloads an immutable source commit archive, refuses to overwrite an existing install path or remove known conflicting containers/networks, creates a mode-restricted `.env` and secret files, generates independent database/admin credentials, validates Compose configuration, and starts the stack unless `--skip-start` is supplied. The initial administrator and ingress passwords are displayed once; store them securely.

To prepare configuration without starting containers:

```bash
sudo bash install-platform.sh --skip-start
```

After startup, inspect the stack:

```bash
cd /opt/empire-of-light
docker compose -p empire-of-light ps
docker compose -p empire-of-light logs --tail=200
```

Confirm service health and the documented readiness endpoint before use. A successful `docker compose up` command is not proof of production readiness.

### Conservative uninstall

```bash
sudo bash /opt/empire-of-light/scripts/uninstall.sh
```

The uninstaller asks for confirmation and removes only the selected Compose project's containers and networks. Named volumes, images, source, `.env`, and secrets are preserved. It does not remove unrelated Docker projects. There is no automatic data-wipe option.

The installer does not install Docker, configure a public domain, configure a reverse proxy, issue TLS certificates, or modify firewall policy. Published ports remain loopback-bound. Those responsibilities require a separate, reviewed operator procedure.

## 5. ARSY installer status and release requirements

The current `scripts/install.sh` remains the upstream Temps binary installer. It downloads `temps-*` release assets and installs the `temps` executable; preserve its upstream behavior and legal provenance.

The new `scripts/install-platform.sh` is an experimental, source-based bootstrap for the existing Compose stack. It uses an immutable source commit and does not require a local Git clone, but it is not a signed binary release, does not install the Rust-first ARSY Node profile, and does not certify production readiness. Do not describe it as the ARSY Node installer.

An ARSY Node installer is not release-ready until all of the following exist and are verified:

- Canonical, CI-produced, version-pinned ARSY artifacts for each supported OS and CPU architecture.
- SHA-256 checksums and a verifiable signing/provenance strategy.
- A documented, non-root-by-default installation model with explicit privilege boundaries.
- Preflight checks for OS, architecture, disk, ports, dependencies, and conflicting services.
- Idempotent installation, safe configuration and secret handling.
- Health/readiness checks with actionable diagnostics.
- Backup, upgrade, rollback, and uninstall behavior that preserves user data unless deletion is explicitly requested.
- Automated clean-host tests and documented support matrix.
- A minimal HTTPS bootstrap path (for example, a reviewed `curl` entry point) that downloads a pinned, verified release artifact rather than executing unverified remote content.

Until those gates pass, do not claim that one-command ARSY Node installation is available. The experimental Compose bootstrap above is a separate deployment path and must retain its explicit limitations.

## 6. Engineering validation gates

Run checks in the repository's pinned Rust toolchain and supported development environment.

### Baseline checks

```bash
rustc --version
cargo --version
cargo fmt --all -- --check
cargo check --workspace
```

The workspace is large. If a full workspace check is not feasible on the available machine, record the exact crates checked and the reason; never report a partial check as a full pass.

### Targeted tests

For every changed Rust crate, run its tests:

```bash
cargo test -p <crate-name>
```

For frontend changes, use the package manager and scripts declared by the relevant app's manifest. Run its lint, typecheck, unit tests, and production build. Do not guess package scripts: inspect the manifest first.

### Repository-specific requirements

- Follow `AGENTS.md` and `REVIEW.md`.
- Preserve source attribution and run `python3 scripts/source_attribution.py check` when required by the repository rules.
- Run relevant integration and end-to-end workflows from `.github/workflows/`.
- Validate Compose using a real, private deployment environment.
- Record command, commit SHA, environment, date, exit status, and any skipped tests.

## 7. Security and operations gates

Before production:

- Review authentication, authorization, project scoping, API key lifecycle, session handling, and audit coverage.
- Review secrets in environment, files, logs, CI, images, and backups.
- Confirm databases are not publicly reachable and admin ingress is restricted.
- Review Docker socket exposure and host privileges as a critical trust boundary.
- Scan dependencies and container images; triage findings and record accepted risks.
- Verify TLS certificates, renewal, DNS, firewall rules, and reverse proxy behavior.
- Exercise backup creation and restore into a separate test environment.
- Exercise upgrade and rollback from the previous supported version.
- Test restart behavior, disk-full behavior, failed dependency startup, and recovery after host reboot.
- Establish monitoring, alert routing, retention, incident ownership, and a security disclosure contact.
- Publish data-flow, telemetry, external-service, retention, and deletion documentation.

## 8. Release acceptance record

A release owner should attach evidence for each item. Mark a box only after the test has actually passed.

- [ ] Pinned toolchain installed and recorded.
- [ ] Formatting, linting, typechecking, and relevant builds pass.
- [ ] Unit and integration tests pass for changed areas.
- [ ] CI workflows for the release commit complete successfully.
- [ ] Dependency and container security reviews completed.
- [ ] Clean install on a supported host succeeds.
- [ ] Initial administrator bootstrap succeeds with non-default credentials.
- [ ] Sample app connects, builds, deploys, and serves HTTPS traffic.
- [ ] Logs, deployment status, health checks, and observability are verified.
- [ ] Authentication, authorization, audit, and ingress restrictions are verified.
- [ ] Backup restore succeeds in a separate environment.
- [ ] Upgrade and rollback succeed from the previous supported version.
- [ ] Documentation matches actual commands, images, environment variables, and ports.
- [ ] Known limitations, support matrix, and release notes are published.
- [ ] Legal notices and upstream attribution are intact.

## 9. Release record template

Copy this section into each release record:

| Field | Evidence |
|---|---|
| Release version | |
| Commit SHA | |
| Release owner | |
| Supported OS / architecture | |
| Rust toolchain | |
| CI run links | |
| Build and test summary | |
| Security scan summary | |
| Install test environment | |
| Sample deployment URL / evidence (no secrets) | |
| Backup and restore evidence | |
| Upgrade / rollback evidence | |
| Known limitations | |
| Approval date | |

## 10. Definition of production-ready

A release is production-ready only when all applicable acceptance items are checked with reproducible evidence, a supported deployment profile is published, and an operator other than the original developer can install, secure, operate, back up, upgrade, and recover the platform by following the documentation.

Until then, describe the repository accurately as an active, Temps-derived implementation being consolidated into the A-L-L-A-H.COM / Empire of Light ecosystem and ARSY platform—not as a fully validated production release.
