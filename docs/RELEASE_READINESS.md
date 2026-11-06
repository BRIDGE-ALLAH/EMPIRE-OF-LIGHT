# Empire of Light Platform — Release Readiness & Operator Runbook

> **Build with clarity. Deploy with sovereignty. Operate with accountability.**

This runbook turns the product blueprint into verifiable release gates. It deliberately distinguishes repository configuration from proof that a deployment works.

## 1. Readiness statement

**Current status: NOT YET CERTIFIED FOR PRODUCTION.**

The repository contains a substantial Temps-derived Rust workspace, web application, Docker Compose deployment, and multiple GitHub Actions workflow definitions. At the time this document was prepared, the repository API returned no recent workflow runs and no published releases. This is not evidence that tests fail; it means a successful current build, clean installation, and production operation have not been independently demonstrated here.

Do not advertise a production-ready Empire of Light release until the gates below have recorded evidence.

## 2. Identity and compatibility

- Product / public brand: **Empire of Light Platform**.
- Ecosystem: **A-L-L-A-H.COM**.
- Product promise: **A sovereign infrastructure foundation for building, delivering, and operating digital products.**
- Current implementation lineage: Temps-derived.
- Current Compose services, environment variables, Rust crates, executable and many operational identifiers still use `temps`.
- Preserve upstream copyright, license, NOTICE, and third-party attribution.
- Do not rename CLI commands, database identifiers, images, environment variables, or persistent volume names as a cosmetic change. Plan compatibility aliases and tested migration/rollback first.

## 3. Deployment prerequisites

Use a dedicated Linux host for a real deployment. Confirm:

- Docker Engine and the Docker Compose plugin are installed and supported.
- `curl`, `tar`, and OpenSSL are installed. Git is not required by the source bootstrap.
- The operator understands that mounting `/var/run/docker.sock` grants effectively host-level control.
- The configured Docker subnets do not overlap the host LAN, VPN, existing Docker networks, or routed networks.
- Firewall policy, ingress exposure, DNS, TLS termination, and administrator access have been reviewed.
- Persistent storage capacity, backup destination, restore destination, and monitoring are available.

## 4. First-install procedure

The repository now provides an experimental source bootstrap. It is not a signed release installer and does not certify production readiness.

1. Use a dedicated Linux host with Docker Engine, Docker Compose v2, `curl`, `tar`, and OpenSSL. Confirm the Docker daemon is running.
2. Review `.env.example`, `docker-compose.yml`, `Dockerfile`, `Dockerfile.ingress`, and the installer before execution. Check the configured Docker subnets against host, LAN, VPN, and existing Docker routes.
3. Run the one-command bootstrap (or download and inspect the script before running it):

   ```bash
   curl -fsSL https://raw.githubusercontent.com/BRIDGE-ALLAH/EMPIRE-OF-LIGHT/main/scripts/install-empire-of-light.sh | sudo bash -s -- --branch main
   ```

   The bootstrap downloads and extracts the selected GitHub branch archive into `/opt/empire-of-light` without requiring a local Git clone, refuses to overwrite an existing path or known conflicting container names, creates a mode-restricted `.env` and secret files, generates unique database and initial admin credentials, validates Compose configuration, and starts the build unless `--skip-start` is supplied.
4. Store the initial administrator and ingress passwords shown by the installer in a password manager. They are shown once and are not recoverable from the installer output.
5. Review the generated `.env` and every subnet/static IP before allowing public traffic. Do not expose administrative endpoints directly to the internet.
6. Inspect startup:

   ```bash
   cd /opt/empire-of-light
   docker compose -p empire-of-light ps
   docker compose -p empire-of-light logs --tail=200
   ```

7. Confirm that all expected services report healthy. Inspect database initialization, credential synchronization, application startup, and ingress errors. Verify `/readyz` through the documented local/network path.

The installer does not install Docker, configure a public domain, configure a reverse proxy, issue TLS certificates, or modify firewall policy. The Compose file binds published ports to host loopback. Those responsibilities require a separate, reviewed operator procedure.

### Conservative uninstall

Run `sudo bash /opt/empire-of-light/scripts/uninstall.sh` and type `REMOVE` when prompted. The script removes only the Compose project's containers and network. Named volumes, images, source, `.env`, and secrets are intentionally preserved. It has no automatic data-wipe option.

## 5. Engineering validation gates

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

## 6. Security and operations gates

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

## 7. Release acceptance record

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

## 8. Release record template

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

## 9. Definition of production-ready

A release is production-ready only when all applicable acceptance items are checked with reproducible evidence, a supported deployment profile is published, and an operator other than the original developer can install, secure, operate, back up, upgrade, and recover the platform by following the documentation.

Until then, describe the repository accurately as an active, Temps-derived implementation under the Empire of Light Platform brand—not as a fully validated production release.
