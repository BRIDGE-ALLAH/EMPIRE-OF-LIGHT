# MW-DEVPLATFORM — Release Readiness & Operator Runbook

> **Build with clarity. Deploy with sovereignty. Operate with accountability.**

This runbook turns the product blueprint into verifiable release gates. It deliberately distinguishes repository configuration from proof that a deployment works.

## 1. Readiness statement

**Current status: NOT YET CERTIFIED FOR PRODUCTION.**

The repository contains a substantial Temps-derived Rust workspace, web application, Docker Compose deployment, and multiple GitHub Actions workflow definitions. At the time this document was prepared, the repository API returned no recent workflow runs and no published releases. This is not evidence that tests fail; it means a successful current build, clean installation, and production operation have not been independently demonstrated here.

Do not advertise a production-ready MW-branded release until the gates below have recorded evidence.

## 2. Identity and compatibility

- Product / public brand: **MOONWITNESS — MW-DEVPLATFORM**.
- Product promise: **Your infrastructure. Your visibility. Your responsibility.**
- Current implementation lineage: Temps-derived.
- Current Compose services, environment variables, Rust crates, executable and many operational identifiers still use `temps`.
- Preserve upstream copyright, license, NOTICE, and third-party attribution.
- Do not rename CLI commands, database identifiers, images, environment variables, or persistent volume names as a cosmetic change. Plan compatibility aliases and tested migration/rollback first.

## 3. Deployment prerequisites

Use a dedicated Linux host for a real deployment. Confirm:

- Docker Engine and the Docker Compose plugin are installed and supported.
- Git and OpenSSL are installed.
- The operator understands that mounting `/var/run/docker.sock` grants effectively host-level control.
- The configured Docker subnets do not overlap the host LAN, VPN, existing Docker networks, or routed networks.
- Firewall policy, ingress exposure, DNS, TLS termination, and administrator access have been reviewed.
- Persistent storage capacity, backup destination, restore destination, and monitoring are available.

## 4. First-install procedure

Run from the repository root on the target host.

1. Review `.env.example`, `docker-compose.yml`, `Dockerfile`, and `Dockerfile.ingress` before starting anything.
2. Create a private environment file:

   ```bash
   install -m 600 .env.example .env
   ```

3. Generate independent database passwords:

   ```bash
   openssl rand -hex 32
   openssl rand -hex 32
   ```

   Put one value in `POSTGRES_PASSWORD` and the other in `CLICKHOUSE_PASSWORD`. Do not reuse credentials.

4. Determine the Docker socket group ID:

   ```bash
   stat -c '%g' /var/run/docker.sock
   ```

   Set the result as `DOCKER_GID`. On non-Linux hosts, follow the platform-specific Docker socket guidance rather than assuming this command applies.

5. Set `TEMPS_ADMIN_EMAIL`. Create the password files at the exact paths configured by `TEMPS_ADMIN_PASSWORD_FILE` and `TEMPS_ADMIN_INGRESS_PASSWORD_FILE`. Use two different strong passwords. Keep the parent directory private and follow the file permission requirements documented in `.env.example`.

6. Review every subnet and static IP in `.env`. Change all related values together if any range conflicts with existing networks.

7. Render and validate the deployment configuration:

   ```bash
   docker compose config --quiet
   docker compose config
   ```

   Resolve every missing variable or validation error. Review the rendered output for unexpected public port bindings before proceeding; do not paste rendered secrets into tickets or public logs.

8. Build and start the stack:

   ```bash
   docker compose up -d --build
   docker compose ps
   docker compose logs --tail=200
   ```

9. Confirm that all expected services report healthy. Inspect individual logs for database initialization, credential synchronization, application startup, and ingress errors.

10. Verify the documented application readiness endpoint from the host/network path appropriate to the deployment. Do not assume a running container means the application is ready.

**Important:** the Compose file binds published ports to host loopback. A reverse proxy, firewall policy, DNS and TLS configuration are separate operator responsibilities. Do not expose administrative endpoints directly to the public internet.

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

Until then, describe the repository accurately as an active, Temps-derived implementation and the MW-DEVPLATFORM brand/product direction—not as a fully validated production release.
