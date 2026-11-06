# Empire of Light Platform — Product & Architecture Blueprint

> **A sovereign infrastructure foundation for building, delivering, and operating digital products.**

| Field | Value |
|---|---|
| Canonical repository | `BRIDGE-ALLAH/EMPIRE-OF-LIGHT` |
| Ecosystem | A-L-L-A-H.COM — Empire of Light |
| Product | Empire of Light Platform |
| Category | Self-hostable developer and infrastructure operations platform |
| Implementation baseline | Temps-derived Rust workspace and web application |
| Document status | Canonical target blueprint; implementation maturity remains evidence-based |
| Companion narrative | [PRODUCT_NARRATIVE.md](PRODUCT_NARRATIVE.md) |

---

## 1. Executive definition

Empire of Light Platform is the infrastructure and developer-platform foundation of the A-L-L-A-H.COM ecosystem. It provides the technical substrate for connecting source code, building and releasing applications, operating workloads, managing supported infrastructure services, and understanding system behavior.

Its purpose is to make infrastructure operations coherent and inspectable while preserving operator control. It does not attempt to become every product in the ecosystem. It provides infrastructure capabilities through explicit contracts so that ecosystem products can build differentiated experiences without reimplementing the runtime.

**Product outcome:** an operator can deploy and operate workloads, understand their state, govern access, and recover from failure using documented and testable procedures.

## 2. Strategic context and ecosystem ownership

A-L-L-A-H.COM is the ecosystem home and integration surface. Empire of Light is the wider vision and the identity of this platform foundation. The following ownership boundaries are normative:

| Capability | Authoritative owner | Integration rule |
|---|---|---|
| Ecosystem users, tenant identity, roles, and product policy | A-L-L-A-H.COM / ARSY | Platform receives explicit mapped principals and scoped permissions; no duplicate ecosystem identity store |
| Product-domain APIs and user-facing workflows | A-L-L-A-H.COM / ARSY and its apps | Use platform APIs/SDKs; do not copy platform internals |
| Build, deploy, workload execution, nodes, runtime | Empire of Light Platform | ARSY requests and coordinates; this platform executes supported infrastructure operations |
| Network routing, ingress, domains, TLS, runtime network policy | Empire of Light Platform, within documented scope | Avoid a second proxy or routing engine in ARSY |
| Platform-local operational telemetry | Empire of Light Platform | Expose events and read APIs; ecosystem analytics may consume them without becoming a second source of runtime truth |
| Ecosystem audit and cross-tenant administrative policy | A-L-L-A-H.COM / ARSY | Platform keeps its own operational audit; map correlation IDs and actor references explicitly |
| Platform-local storage and infrastructure persistence | Empire of Light Platform | Do not share private tables with ARSY |
| Ecosystem commercial catalog, plans, entitlements, and billing policy | A-L-L-A-H.COM / ARSY / Empire Economy | Platform exposes measured usage facts and enforceable resource limits through contracts |
| Payment processing and commerce experience | Empire Economy and its designated providers | Do not embed a second payment or subscription authority in this platform |
| MoonWitness research, corpus, narrative, publishing | MoonWitness product surfaces | Consume platform capabilities; do not move narrative content ownership here |
| ROCKSOUL creative/media products | ROCKSOUL product surfaces | Consume platform capabilities; do not create creative-domain services here |

A feature with unclear ownership is blocked from implementation until an Architecture Decision Record (ADR) names its owner, data source of truth, API boundary, security model, and migration path.

## 3. Problem and target users

### Problem

Teams often assemble application delivery, databases, networking, monitoring, security, and automation from separate products. This fragments configuration and operational evidence, increases integration work, and makes incident ownership difficult to trace.

### Target users

1. Independent developers who need a repeatable self-hosted delivery environment.
2. Engineering teams operating multiple applications and environments.
3. Digital studios and agencies that need consistent operational patterns.
4. Organizations requiring control over workload placement, data location, and operational access.

### Jobs to be done

- Connect a repository and produce a traceable build.
- Deploy, inspect, and roll back a release.
- Operate workloads, nodes, domains, certificates, and supported data services.
- Diagnose behavior using logs, metrics, traces, events, and health signals.
- Apply least-privilege access and inspect privileged operations.
- Automate infrastructure workflows with clear failure and retry semantics.
- Back up, restore, upgrade, and recover a deployment.

## 4. Product scope

### In scope

- Source integration, build orchestration, deployments, previews, and release lifecycle.
- Workload execution, containers, workers, nodes, and runtime health.
- Routing, ingress, domains, TLS, and supported network policy.
- Supported managed data-service provisioning and lifecycle.
- Logs, metrics, traces, analytics, errors, uptime, and diagnostics.
- Platform-local authentication/authorization required to operate the platform.
- API keys, operational audit, security tooling, and policy enforcement within platform scope.
- CLI, SDK, plugin, AI, automation, sandbox, and MCP surfaces already supported by the implementation.
- Operator workflows for configuration, health, backup, restore, upgrade, and rollback.

### Explicitly out of scope

- Becoming the canonical user-facing ecosystem portal; that belongs to A-L-L-A-H.COM apps.
- Owning ecosystem-wide identity, tenant membership, role policy, or cross-tenant administration.
- Owning product plans, commercial catalog, subscriptions, entitlements, invoices, or payment processing.
- Implementing a second general-purpose container runtime, proxy, observability backend, or database platform inside ARSY.
- MoonWitness corpus, research, story canon, or publishing workflows.
- ROCKSOUL media creation, distribution, and entertainment workflows.
- A general-purpose operating system.
- Claiming a fully supported ARSY Node installer before independent artifacts and installation evidence exist.

## 5. Architecture

The existing repository is a large Rust workspace with a web application, SDKs, scripts, deployment configuration, and documentation. Keep the detailed crate map and architecture overview as the source of truth for actual modules. The following is the product-level logical model:

```text
A-L-L-A-H.COM Apps / ARSY
  Identity • Tenant Policy • Product APIs • Commercial Policy
                    |
           Versioned API / SDK
                    |
                    v
+----------------------------------------------+
|        EMPIRE OF LIGHT PLATFORM              |
|                                              |
|  Platform Control Plane                     |
|  Projects • Platform Config • Orchestration  |
|                    |                         |
|  Execution Plane  |  Network / Ingress       |
|  Builds • Releases|  Routes • TLS • Domains  |
|  Workloads • Nodes|  Traffic Policy          |
|                    |                         |
|  Observability Plane                         |
|  Logs • Metrics • Traces • Events • Health   |
|                    |                         |
|  Platform Persistence & Backup               |
+----------------------------------------------+
                    |
             Operator Infrastructure
```

This is a logical responsibility diagram, not a deployment topology. Do not split modules into new services solely to match the boxes.

### 5.1 Platform control plane

Owns platform-local resource configuration and orchestration required to operate infrastructure. It must expose stable, documented interfaces for ecosystem integration.

### 5.2 Execution plane

Owns the supported build and workload lifecycle: scheduling/dispatch, execution, deployment state, workers, nodes, and runtime health. It must report durable state transitions and meaningful failure reasons.

### 5.3 Network and ingress plane

Owns supported routing, ingress, domains, certificates, and traffic policy. Security-sensitive changes require explicit validation, safe defaults, and audit evidence.

### 5.4 Observability plane

Owns platform operational telemetry and diagnostics. Events must have stable identifiers and correlation metadata. Do not conflate platform telemetry with ecosystem product analytics.

### 5.5 Persistence and recovery

Owns platform-local persistence and supported storage integrations. Backup and restore are product capabilities only when exercised in tests against supported versions.

## 6. Integration contract with ARSY

ARSY is the ecosystem-facing product/control integration layer. It owns ecosystem identity, tenant policy, product-domain APIs, and commercial coordination. Empire of Light Platform owns infrastructure execution and platform-local operational state.

Required integration rules:

1. **No shared private database:** communicate through documented API, SDK, event, or adapter contracts.
2. **No duplicate authority:** one owner per identity, tenant, billing, runtime, routing, and telemetry domain.
3. **Explicit principal mapping:** map ecosystem actor and tenant references to scoped platform permissions; never infer authority from a client-supplied tenant ID.
4. **Least privilege:** use dedicated service credentials with narrowly scoped capabilities and revocation.
5. **Correlation:** propagate request, actor, tenant-reference, and operation identifiers where appropriate; avoid leaking secrets or sensitive payloads.
6. **Idempotency:** provisioning and lifecycle commands must safely handle retries and duplicate delivery.
7. **Observable outcomes:** return operation IDs, durable status, and actionable errors.
8. **Versioning:** document compatibility and deprecation policy for API/SDK/event contracts.
9. **Failure isolation:** define timeout, retry, cancellation, compensation, and reconciliation behavior.
10. **No source copying:** integrate with platform capabilities; do not fork internal modules into ARSY.

### Ownership examples

- ARSY decides whether a tenant may request a deployment; the platform executes the authorized deployment.
- The platform reports resource usage facts; ARSY/Empire Economy applies product plan, entitlement, and billing policy.
- The platform records infrastructure operations; ARSY records ecosystem-level administrative and business audit events. Correlate them without merging ownership.
- The platform may have platform-local operator accounts; those accounts do not replace ecosystem users or tenant membership.

## 7. Current implementation truth

The current codebase is derived from Temps and retains a Rust workspace of more than one hundred crates, web UI, SDKs, scripts, Compose configuration, and upstream technical documentation.

The source tree includes capability areas for delivery, runtime, networking, managed services, observability, security, AI/automation, and extensibility. Capability presence does not establish feature completeness or production maturity. The crate map, source, tests, ADRs, release workflow, and runbooks remain authoritative for implementation detail.

### Known identity and installer gap

- The root README and existing blueprint previously described MOONWITNESS / MW-DEVPLATFORM and required reconciliation after the repository rename.
- The installer at `scripts/install.sh` still targets `gotempsh/temps`, downloads `temps-*` release assets, and installs the `temps` binary.
- Technical identifiers remain upstream-derived. No blind global rename is authorized.
- No claim is made here that an independent Empire of Light release artifact, ARSY Node installer, clean VPS install, or production upgrade/rollback has been validated.

Treat these as explicit migration gaps, not cosmetic documentation details.

## 8. Naming and source provenance

- **Ecosystem:** A-L-L-A-H.COM — Empire of Light.
- **Platform product:** Empire of Light Platform.
- **Repository:** `BRIDGE-ALLAH/EMPIRE-OF-LIGHT`.
- **Ecosystem application/control integration:** ARSY in the A-L-L-A-H.COM repository.
- **Future self-hosted node/distribution experience:** ARSY Node, only after release and installer gates are met.

This repository is Temps-derived. Preserve all upstream copyright statements, NOTICE files, license texts, and third-party attribution. Keep implementation identifiers compatible until each migration is planned and tested. A product rename does not change legal provenance.

## 9. ARSY Node and VPS installation direction

ARSY Node is the intended ecosystem-facing name for a self-hosted installation profile that combines verified Empire of Light platform artifacts with the required A-L-L-A-H.COM integration components. It is a distribution and installation contract, not a new runtime to build in parallel.

### Required installer properties

- Version-pinned, platform-specific release artifacts.
- SHA-256 checksums and preferably verifiable signatures/provenance.
- Supported Linux distributions and CPU architectures documented.
- Preflight checks for privileges, disk, memory, ports, DNS, firewall, and Docker/runtime prerequisites.
- Explicit configuration and secret generation; no default production credentials.
- Idempotent installation and safe re-execution.
- Health checks and actionable failure diagnostics.
- Least-privilege service execution and documented host-level permissions.
- Backup, restore, upgrade, rollback, and uninstall behavior.
- No silent migration or destructive data operation.
- Clean-host integration tests for each supported profile.

### Installer implementation sequence

1. Inventory the current upstream installer, release workflows, binaries, assets, Compose services, and environment variables.
2. Define the supported product distribution and version compatibility matrix.
3. Establish an independent release pipeline that builds and publishes the intended artifacts.
4. Add artifact checksums/signatures and provenance verification.
5. Implement ARSY Node preflight, configuration, install, health, and recovery commands.
6. Test clean install, interrupted install, rerun/idempotency, upgrade, rollback, backup, and restore.
7. Publish operator documentation and known limitations.
8. Only then replace or wrap upstream installer entry points, preserving attribution and a documented compatibility path.

**Hard stop:** until steps 1–7 have evidence, `scripts/install.sh` must remain clearly identified as the upstream Temps installer. Do not tell users to run it to install Empire of Light or ARSY Node.

## 10. Security, reliability, and trust requirements

- Never commit secrets, private customer data, production identifiers, or host-specific credentials.
- Treat Docker socket access and host-level execution as high-risk capabilities.
- Apply least privilege and private service networking.
- Keep secrets out of logs, command output, URLs, browser state, and telemetry.
- Document external network calls, telemetry, data residency, backup destinations, and retention.
- Audit privileged actions with actor, operation, target, correlation ID, and timestamp; redact sensitive values.
- Require review for authentication, authorization, cryptography, migrations, resource limits, cancellation, and cleanup.
- Define resource quotas and safe defaults for multi-tenant or shared environments.
- Test failure paths, retries, duplicate commands, partial upgrades, and restore procedures.
- Preserve upstream licenses and notices.

## 11. Roadmap and exit gates

### Phase 0 — Identity and truth alignment

- [x] Confirm repository identity as `BRIDGE-ALLAH/EMPIRE-OF-LIGHT`.
- [x] Establish the platform's role within A-L-L-A-H.COM.
- [x] Separate platform execution from ARSY ecosystem policy and product workflows.
- [x] Document the upstream installer limitation and provenance requirement.
- [ ] Audit all user-facing surfaces, docs navigation, CLI output, email templates, installer messages, and release metadata for remaining legacy product copy.
- [ ] Record all residual overlap findings as owned migration tasks or ADRs.

**Exit gate:** repository narrative, README, and blueprint agree; no unsupported maturity claims remain.

### Phase 1 — Platform boundary and API contract

- [ ] Inventory current public APIs, SDKs, events, auth models, and platform-local resource domains.
- [ ] Define ARSY-to-platform service authentication and principal/tenant mapping.
- [ ] Define API/event versioning, idempotency, correlation, retry, timeout, and reconciliation behavior.
- [ ] Identify duplicate or conflicting implementations in ARSY and assign one owner per capability.
- [ ] Add contract tests and integration test fixtures.

**Exit gate:** an end-to-end provisioning operation can be authorized by ARSY, executed by the platform, and reconciled with auditable outcomes without shared private storage.

### Phase 2 — Independent release foundation

- [ ] Define supported release targets and version policy.
- [ ] Build reproducible platform artifacts in CI.
- [ ] Publish checksums, signatures/provenance, SBOM, and release notes.
- [ ] Separate product artifacts from upstream release URLs and names without erasing attribution.
- [ ] Validate upgrade compatibility and rollback policy.

**Exit gate:** a pinned release can be installed and verified without downloading an upstream Temps binary.

### Phase 3 — ARSY Node and operator readiness

- [ ] Implement installer preflight and safe configuration.
- [ ] Implement idempotent install, health, upgrade, rollback, backup, restore, and uninstall workflows.
- [ ] Test clean-host installs on every supported OS/architecture profile.
- [ ] Validate firewall, TLS, secrets, permissions, data persistence, and failure recovery.
- [ ] Publish operator runbooks and support matrix.

**Exit gate:** an operator can install, secure, inspect, back up, upgrade, roll back, and recover using published instructions.

### Phase 4 — Product maturity and ecosystem integration

- [ ] Publish feature maturity and known limitations.
- [ ] Publish API/SDK examples and integration contracts.
- [ ] Validate metering facts and resource-limit enforcement with ARSY/Empire Economy.
- [ ] Establish release, vulnerability disclosure, and support processes.
- [ ] Add operational SLOs and incident/recovery exercises.

**Exit gate:** ecosystem products integrate through stable contracts, and platform releases have repeatable operational evidence.

## 12. Definition of done

A feature is complete only when:

- its authoritative owner and non-overlap boundary are documented;
- behavior is implemented and covered by relevant tests;
- security, permissions, resource limits, and failure paths are reviewed;
- API/configuration changes are documented and versioned;
- observability and actionable diagnostics exist;
- upgrade, rollback, and data compatibility are considered;
- the README and blueprint describe actual behavior, not aspirations.

A release is production-ready only when the release readiness runbook's applicable checks pass with recorded evidence. Documentation alone is not evidence of implementation.

## 13. Anti-overlap rules for contributors and AI agents

Before creating a service, crate, package, database table, API, worker, or UI surface:

1. Search the existing workspace and architecture docs for an equivalent capability.
2. Search the A-L-L-A-H.COM repository's documented ownership contracts.
3. Name the authoritative owner and source of truth.
4. Prefer extension or integration over duplication.
5. If two existing implementations overlap, document the observed overlap and propose a migration; do not add a third.
6. Keep a capability in this repository only when it is part of the infrastructure platform's execution responsibility.
7. Keep ecosystem identity, tenant policy, product billing, and creative/knowledge domains outside this repository.
8. Add an ADR for any new cross-repository boundary or change of ownership.

### Prohibited shortcuts

- Global search-and-replace of upstream identifiers.
- Rebranding the installer without changing and testing its actual download source.
- Claiming a service, API, billing flow, installer, or release is complete based only on a plan or diagram.
- Creating a second runtime, proxy, identity provider, billing authority, or observability backend to avoid integration work.
- Splitting modules into microservices without a scaling, isolation, ownership, or reliability justification.
- Removing upstream notices or rewriting history to imply original authorship.

## 14. Source-of-truth documents

- [Product narrative](PRODUCT_NARRATIVE.md) — purpose, ecosystem role, ownership boundaries, and product voice.
- [Architecture overview](architecture/overview/page.mdx) — implementation-oriented architecture.
- [Crate map](architecture/crates.md) — workspace inventory.
- [Release readiness](RELEASE_READINESS.md) — evidence required for safe operation.
- [AGENTS.md](../AGENTS.md) — engineering and agent rules.
- [REVIEW.md](../REVIEW.md) — recurring security and reliability findings.
- [NOTICE](../NOTICE), [LICENSE](../LICENSE), and [LICENSE-MIT](../LICENSE-MIT) — upstream provenance and licensing.

When documents disagree, implementation and tests establish current behavior; this blueprint establishes intended ownership and target direction. Update both when a verified architectural decision changes.
