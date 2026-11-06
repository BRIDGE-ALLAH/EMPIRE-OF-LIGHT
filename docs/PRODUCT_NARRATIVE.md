# Empire of Light — Product Narrative

> **A sovereign infrastructure foundation for building, delivering, and operating digital products.**

**Canonical repository:** `BRIDGE-ALLAH/EMPIRE-OF-LIGHT`  
**Ecosystem brand:** A-L-L-A-H.COM — Empire of Light  
**Document status:** Canonical product narrative  
**Implementation truth:** This repository is a Temps-derived Rust platform codebase. The repository rename does not itself complete a product rebrand, binary migration, release migration, or production certification.

## 1. The reason this repository exists

Empire of Light is the infrastructure and developer-platform foundation within the wider A-L-L-A-H.COM ecosystem. It exists to make the technical work of creating, delivering, and operating digital products more coherent, inspectable, and controllable.

Modern product teams assemble deployment systems, runtimes, databases, networking, observability, security, automation, and AI capabilities from disconnected tools. The resulting system can be powerful, but it is often difficult to understand as a whole. Configuration is duplicated, operational evidence is scattered, and the responsibility for failures crosses too many boundaries.

This repository develops a self-hostable platform foundation for that infrastructure lifecycle. Its purpose is not to claim ownership of every product, business workflow, identity, or creative experience in the ecosystem. Its purpose is to provide a dependable technical substrate that other products can integrate with through explicit contracts.

**The promise:** make infrastructure capabilities usable without making their behavior opaque.

## 2. Place in the A-L-L-A-H.COM ecosystem

A-L-L-A-H.COM is the ecosystem's product and integration home. Empire of Light is the wider vision and the name of this infrastructure foundation. The repositories and applications around it have distinct responsibilities.

| System | Owns | Does not own |
|---|---|---|
| `A-L-L-A-H.COM` repository | Ecosystem applications, ARSY product APIs, user-facing experiences, product-domain workflows, and integration contracts | Reimplementing a complete infrastructure runtime already provided here |
| `EMPIRE-OF-LIGHT` repository | Infrastructure platform substrate: application delivery, workload execution, nodes, networking, managed infrastructure capabilities, and operational telemetry | Ecosystem-wide identity authority, creative canon, user-facing MoonWitness products, or commercial policy |
| ARSY | Ecosystem application/control integration: product APIs, identity and tenant policy, orchestration decisions, and commercial-domain coordination | A second container runtime, build engine, proxy, or observability backend |
| MoonWitness | Knowledge, research, narrative, and publishing experiences | Infrastructure provisioning or tenant authorization authority |
| ROCKSOUL | Creative and media experiences | Platform runtime or identity authority |
| Empire Economy | Commerce experiences and commercial workflows | Duplicating infrastructure metering or payment execution without an explicit contract |

This table is an ownership contract, not a claim that every target capability is already implemented. Where current code does not yet match the target boundary, record the gap and migrate incrementally; do not create a second implementation to make the diagram look complete.

## 3. Product definition

**Category:** self-hostable developer and infrastructure operations platform.

**Primary users:** independent builders, engineering teams, digital studios, and organizations that need control over their deployment and operational environment.

**Core jobs:**
- connect source code and produce traceable builds and releases;
- deploy and operate workloads on infrastructure the operator controls;
- manage nodes, routing, domains, TLS, and supported data services;
- understand system health through logs, metrics, traces, events, and diagnostics;
- apply explicit access, security, and operational controls;
- automate repeatable workflows while preserving auditability;
- recover through tested backup, restore, upgrade, and rollback procedures.

**Differentiator:** a coherent operational foundation with visible boundaries and portable deployment practices—not a promise that one product replaces every specialized tool.

## 4. Architecture doctrine

The platform is organized around separable responsibilities:

1. **Experience and integration surfaces** — web console, CLI, SDKs, APIs, and supported integration protocols.
2. **Platform control plane** — platform-local configuration and orchestration required to manage infrastructure resources.
3. **Execution plane** — builds, releases, workloads, containers, workers, nodes, and runtime operations.
4. **Network and ingress plane** — routing, domains, certificates, traffic policy, and edge-facing controls.
5. **Observability plane** — logs, metrics, traces, events, analytics, uptime, and diagnostics.
6. **Persistence plane** — relational, analytical, and object storage plus backup and recovery mechanisms.

These are architectural responsibilities, not a mandate to split every module into a separate service. Prefer existing modules and contracts where they already provide the capability. Extract a service only when independent scaling, isolation, ownership, or failure containment justifies the operational cost.

### The ARSY integration boundary

ARSY is the ecosystem-facing application/control integration layer. It may request infrastructure actions, reconcile desired state, map ecosystem identity and tenant policy to platform permissions, and expose product-level workflows. This repository remains responsible for performing its supported infrastructure operations and reporting verifiable results.

The integration must use documented APIs, SDKs, events, or adapters. It must not share private database tables, copy internal implementation code, or create parallel sources of truth. Platform-local identities and permissions remain scoped to platform operation; ecosystem identity and tenant authorization remain owned by the A-L-L-A-H.COM/ARSY side. Every cross-system mapping must be explicit, least-privileged, auditable, and revocable.

## 5. Naming and compatibility

The GitHub repository name is `EMPIRE-OF-LIGHT`. The product-facing identity is **Empire of Light Platform**, within **A-L-L-A-H.COM — Empire of Light**.

The current source tree is derived from the Temps codebase and still contains upstream identifiers in crate names, binaries, environment variables, container services, URLs, release assets, installer logic, and documentation. Those identifiers are implementation and compatibility facts—not permission to erase upstream attribution.

Rules:
- Do not perform a blind global replacement of `temps`, crate names, service names, environment variables, or URLs.
- Preserve upstream copyright, license, NOTICE, and third-party attribution.
- Separate user-facing copy changes from technical identifier migrations.
- Rename externally consumed identifiers only with compatibility aliases, migration notes, tests, and rollback paths.
- Never publish an Empire of Light release or installer that silently downloads an upstream Temps binary.

## 6. What is true today

The repository currently contains a substantial Temps-derived Rust workspace (more than one hundred crates), a web application, SDKs, scripts, deployment configuration, and extensive technical documentation. Existing source describes application delivery, workload/runtime operations, networking, managed data services, observability, security, AI/automation, and extension surfaces.

The current root README and blueprint were still written for MOONWITNESS / MW-DEVPLATFORM before this reconciliation. The installer at `scripts/install.sh` explicitly resolves releases from `gotempsh/temps`, downloads `temps-*` assets, and installs the `temps` executable. It is therefore an upstream installer, not an Empire of Light / ARSY Node installer.

A successful repository rename or a running development stack does not prove that the platform has been rebranded, independently released, safely installable on a clean VPS, or production-ready.

## 7. VPS and ARSY Node direction

The eventual self-hosted installation experience may be called **ARSY Node** at the ecosystem level, but it must be a deliberate, versioned distribution built from verified Empire of Light platform artifacts and the A-L-L-A-H.COM integration components.

The installer must not build the entire Rust workspace on an ordinary production VPS unless that is an explicitly supported installation mode. Prefer signed or checksum-verified, version-pinned release artifacts with a published provenance record. Installation must be reproducible, idempotent, least-privileged, and safe to retry.

Before an ARSY Node installer is considered usable, the release pipeline must publish platform-specific artifacts; checksums and preferably signatures; a supported OS/architecture matrix; a first-run configuration flow; secret-safe setup; health checks; upgrade and rollback behavior; backup/restore procedures; and a clean-host test report. Until then, the existing upstream installer must be clearly labeled and must not be promoted as the product installer.

## 8. Product principles

- **Truth before polish:** distinguish implemented, partial, experimental, planned, and unsupported capabilities.
- **Sovereignty with evidence:** document outbound calls, telemetry, storage locations, backups, and operator responsibilities.
- **Secure by default:** least privilege, protected secrets, private service networks, explicit ingress, and auditable privileged actions.
- **Recoverability:** design and test backup, restore, upgrade, rollback, and failure recovery.
- **Interoperability:** prefer stable contracts and adapters over shared private internals.
- **Operational restraint:** do not split services or introduce dependencies without a demonstrated need.
- **Preserve provenance:** retain upstream licenses, notices, history, and compatibility where required.
- **Human agency:** explain consequential actions and provide operators with enough evidence to make informed decisions.

## 9. What this product is not

- It is not a general-purpose operating system or a replacement for Linux.
- It is not the entire A-L-L-A-H.COM ecosystem in one repository.
- It is not the canonical home for MoonWitness stories, research corpus, or ROCKSOUL media.
- It is not the ecosystem's sole identity, tenant, billing, or commercial-policy authority.
- It is not production-ready merely because its source tree is large or a Compose stack starts.
- It is not an ARSY Node installer until independently built, versioned, verified artifacts and installation tests exist.

## 10. Decision rule

When a proposed feature appears to overlap another repository, do not immediately implement it. First identify the authoritative owner, the data source of truth, the API contract, the security boundary, and the failure/recovery behavior. Reuse or integrate with the owner. If ownership is unclear, record an architecture decision before coding.

**The measure of success is not the number of services or features. It is whether the ecosystem can deliver useful products through a coherent, secure, understandable, and recoverable infrastructure foundation.**
