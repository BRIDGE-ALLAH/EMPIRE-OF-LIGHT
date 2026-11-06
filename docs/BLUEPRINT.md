# MW-DEVPLATFORM — Brand & Product Blueprint

> **Build with clarity. Deploy with sovereignty. Operate with accountability.**

**Status:** Brand and product direction  
**Repository:** `BRIDGE-ALLAH/MW-DEVPLATFORM`  
**Implementation baseline:** Temps-derived Rust workspace and web application  
**Purpose:** Establish one coherent narrative and an actionable path from the current codebase to an MW-branded developer platform.

---

## 1. Executive narrative

MW-DEVPLATFORM is a self-hostable foundation for building, delivering, observing, and operating digital products.

It exists because the modern software builder is asked to depend on an expanding chain of disconnected services: one for deployment, another for databases, another for analytics, another for logs and errors, and still more for automation and AI. Each tool may solve a local problem, but the overall system becomes harder to understand, govern, secure, and afford.

MW-DEVPLATFORM brings those operational capabilities into one coherent environment. It is designed to help people retain control over their code, infrastructure, data, and decisions—while making the state of their systems visible enough to act responsibly.

The platform's ambition is not to make every technical detail disappear. It is to make the important details legible: what is running, what changed, what failed, who can act, where data lives, and what should happen next.

**Core idea:** technology should increase human agency. A platform earns trust when it makes control practical, evidence accessible, and responsibility explicit.

## 2. Meaning of the name

### MoonWitness

The working name combines two ideas:

- **Moon:** perspective, cycles, navigation, and light in changing conditions. It suggests that systems are not static; they evolve through releases, incidents, growth, and recovery.
- **Witness:** observation, evidence, accountability, and the discipline of seeing what is actually happening rather than relying on assumptions.

Together, **MoonWitness** represents a platform that helps its operators see their digital environment clearly and remain accountable for how it is built and run.

### MW-DEVPLATFORM

MW-DEVPLATFORM is the practical expression of that idea: the engineering environment where products are built, deployed, monitored, secured, and improved.

The brand must not imply that software itself is a source of moral authority, nor claim divine endorsement. Its values are expressed through engineering behavior: honesty about system state, care for user data, fair access boundaries, and reliable operation.

## 3. Brand foundation

### Purpose

Give builders and organizations a dependable, understandable, and self-controlled foundation for digital creation.

### Vision

A world where teams can build and operate serious digital products without surrendering visibility, ownership, or operational agency to a fragmented stack.

### Mission

Unify the essential developer and operations lifecycle in a self-hostable platform with transparent controls, useful observability, secure defaults, and extensible workflows.

### Positioning statement

For developers, product teams, and organizations that want control over their delivery infrastructure, MW-DEVPLATFORM is a self-hosted developer platform that unifies application delivery and operations. Unlike a collection of disconnected point tools, it provides one operational surface designed around clarity, sovereignty, and accountability.

### Brand promise

**Your infrastructure. Your visibility. Your responsibility.**

### Brand personality

- **Grounded:** confident without hype; specific about what works today.
- **Illuminating:** explains state, cause, and consequence.
- **Stewardly:** treats access, data, and compute as responsibilities.
- **Capable:** technically deep, practical, and extensible.
- **Open:** respects portability, transparency, and community contribution.

### Voice and language

Prefer clear, direct language. Explain the benefit before the implementation detail, then link to the technical reference.

Use:
- “Keep operational control in your hands.”
- “See what changed and why.”
- “One place to deploy, observe, and operate.”
- “Self-hosted by design; transparent by default.”

Avoid:
- unsupported claims such as “unhackable,” “zero risk,” or “the only platform you need”;
- claiming every feature is production-ready without maturity evidence;
- using spiritual language as a substitute for product proof;
- presenting planned capabilities as already shipped.

## 4. Values translated into engineering

The following vocabulary may be used as an ethical and product lens. It should be presented respectfully and inclusively, not as a claim that the platform represents a faith or speaks on behalf of a religious tradition.

| Value | Product interpretation | Observable engineering behavior |
|---|---|---|
| Amanah — stewardship | Treat trust and entrusted resources seriously | Protect secrets, audit privileged actions, document data handling |
| Ihsan — excellence | Do work carefully and continuously improve | Strong tests, safe defaults, understandable failures |
| Adl — fairness | Apply consistent and explainable boundaries | Least privilege, explicit quotas, predictable authorization |
| Rahmah — care | Reduce avoidable harm and toil | Accessible UX, recoverable workflows, useful error messages |
| Shura — consultation | Build with feedback and shared learning | Open contribution process, ADRs, documented trade-offs |

These are guiding principles for product decisions, not certifications or guarantees.

## 5. Audience and jobs to be done

### Primary audiences

1. **Independent builders:** want to deploy products without assembling and paying for a large stack of services.
2. **Engineering teams:** want a consistent delivery and operations workflow across multiple applications.
3. **Digital studios and agencies:** need repeatable infrastructure patterns for multiple projects and clients.
4. **Organizations with sovereignty requirements:** need control over where workloads and operational data are hosted.

### Core jobs

- Ship a code change safely.
- Understand why a deployment or request failed.
- Know whether services are healthy and how they are performing.
- Manage domains, certificates, data services, and secrets.
- Control who can access projects and infrastructure.
- Automate repetitive work without losing auditability.
- Recover from incidents and restore critical data.

## 6. Product pillars

### 6.1 Build and deliver

Connect source repositories, build applications, create deployments and previews, and manage releases.

**User outcome:** move from a committed change to a running application with a traceable deployment history.

### 6.2 Run and connect

Operate containerized workloads, domains, TLS, routing, worker nodes, and managed data services.

**User outcome:** run applications and dependencies in infrastructure the operator controls.

### 6.3 Observe and understand

Collect application analytics, errors, logs, traces, metrics, uptime checks, and operational events.

**User outcome:** answer what happened, where it happened, and what needs attention.

### 6.4 Secure and govern

Provide identity, authentication, authorization, API keys, audit records, network controls, and security scanning.

**User outcome:** make access and operational boundaries explicit and reviewable.

### 6.5 Extend and automate

Expose SDKs, plugin protocols, CLI workflows, AI gateway and agent surfaces, sandboxes, and MCP integration points.

**User outcome:** extend the platform without fragmenting the operating model.

## 7. Technical architecture — current repository baseline

The repository currently contains a Rust Cargo workspace, a web application, SDKs, scripts, deployment configuration, and extensive documentation. The workspace manifest lists more than 100 crates. The architecture is layered; the generated crate map groups the code into library, foundation, toolkit/runtime/traffic, domain/observability/AI/import, and application concerns.

At a conceptual level, the system can be read as these planes:

```text
Developer / Operator
        |
        v
Web Console + CLI + SDKs + API / MCP
        |
        v
Control Plane
  Identity & Authorization
  Projects & Configuration
  Git & Deployment Orchestration
  Domains, Routing & Providers
  Plugins, AI & Automation
        |
        +---------------------------+
        |                           |
        v                           v
Workload / Runtime Plane       Observability Plane
  Build & Deploy                  Events & Analytics
  Containers / Workers            Logs / Metrics / Traces
  Networking / Ingress            Errors / Uptime
  Managed Services                Audit & Diagnostics
        |                           |
        +-------------+-------------+
                      |
                      v
             Persistence & Storage
       PostgreSQL / ClickHouse / Object Storage
```

This is a conceptual reading of the current repository, not a replacement for the detailed architecture docs or a guarantee that every feature is mature in every deployment mode.

### Architecture boundaries

- **Experience layer:** web console, CLI, SDKs, APIs, and integration surfaces.
- **Control plane:** identity, authorization, projects, configuration, orchestration, and policy.
- **Workload plane:** builds, deployments, containers, networking, nodes, and service providers.
- **Observability plane:** ingestion, event processing, logs, metrics, traces, analytics, and error tracking.
- **Persistence layer:** relational data, analytical storage, file/object storage, and backups.

### Existing source-of-truth documents

- [Crate map](architecture/crates.md) — generated workspace inventory and dependency layers.
- [Architecture overview](architecture/overview/page.mdx) — current product-level architecture.
- [Multi-node and build dispatch](architecture/multi-node-and-build-dispatch.md) — distributed execution context.
- [Design standard](../DESIGN.md) — current web UI conventions.
- [Agent and engineering rules](../AGENTS.md) — contributor and coding-agent constraints.
- [Security review checklist](../REVIEW.md) — recurring security and reliability risks.

## 8. Product experience principles

1. **Resource first:** lead with the user's resource and its primary action, not configuration noise.
2. **One coherent surface:** avoid nested panels and inconsistent interaction patterns.
3. **Truthful states:** distinguish loading, empty, filtered, failed, unavailable, and unconfigured states.
4. **Explain consequences:** show what a change affects before a user commits it.
5. **Recoverability:** make retries, rollback, backup, and restore discoverable.
6. **Secure by default:** least privilege, private service networks, protected secrets, and auditable actions.
7. **Accessible operations:** support keyboard use, readable labels, clear contrast, and actionable errors.

These principles align with the existing UI standard in `DESIGN.md`; they should guide future MW-specific changes without implying that every legacy screen has already been migrated.

## 9. Brand system direction

### Visual concept

The visual identity should communicate night-sky clarity and technical precision without turning the product into a decorative astronomy theme.

Suggested direction:
- deep ink / midnight base for focus and operational calm;
- moonlight or silver as a neutral highlight;
- one restrained signal accent for status and primary actions;
- subtle orbital/grid geometry only in brand surfaces, not behind dense operational data;
- typography optimized for long technical sessions and high information density.

### Logo concept

The first MW mark is implemented as a **lunar witness mark**: a restrained crescent and point of light inside a midnight-navy field, paired in the full lockup with the MOONWITNESS wordmark and MW-DEVPLATFORM descriptor. Source assets live in `web/public/svg/mw-icon.svg`, `mw-logo-dark.svg`, and `mw-logo-light.svg`; the favicon is `web/public/favicon.svg`. Legacy SVG asset paths are retained as compatibility aliases to the MW artwork. The mark is a navigation and product-identity device, not a religious symbol or a surveillance claim.

### UI distinction

Keep the brand layer separate from semantic status colors. Success, warning, failure, and neutral states must remain accessible and consistent regardless of theme.

## 10. Roadmap: from brand to usable product

### Phase 0 — Establish truth

- [x] Publish this narrative and link it from the root README.
- [x] State clearly that the current codebase is Temps-derived.
- [x] Preserve upstream notices, licenses, and legal attribution.
- [x] Establish a compatibility policy separating product copy from internal identifiers.

**Exit criteria:** README and blueprint agree about the current implementation and remaining work.

### Phase 1 — Brand alignment (in progress)

- [x] Define the initial MW logo family, neutral/lunar-gold palette, typography direction, icon usage, and writing style in `docs/BRAND_SYSTEM.md`.
- [x] Add MW product identity to the browser title, favicon, shared sidebar, loading shell, login screen, setup copy, and package description.
- [x] Add application metadata and social-preview descriptions to the HTML shell.
- [x] Keep upstream legal attribution and implementation identifiers intact; legacy SVG logo paths now resolve to MW artwork.
- [ ] Review every route, auth state, email template, notification, CLI surface, and generated page for user-visible upstream branding.
- [ ] Run frontend lint, typecheck, unit tests, and production build; review light/dark and mobile screenshots.
- [ ] Align any public landing page and documentation navigation that is shipped by this repository.

**Exit criteria:** all shipped public surfaces consistently use MW identity, remain accessible, and pass frontend validation without changing upstream behavior.

### Phase 2 — Safe technical rebrand

- Inventory CLI commands, crate names, environment variables, service/container names, image names, telemetry keys, URLs, and installer references.
- Decide which identifiers must remain compatible and which can change.
- Add aliases/deprecation windows before renaming external interfaces.
- Update deployment templates, upgrade scripts, tests, and operational docs together.

**Exit criteria:** a clean install and an upgrade from the previous naming scheme both work in automated tests.

### Phase 3 — Operational readiness

- Validate install, first-admin bootstrap, TLS/ingress, backups, restore, upgrade, rollback, and disaster recovery.
- Add smoke tests for the supported deployment profile.
- Publish feature maturity and supported environment matrices.
- Verify security controls and document the threat model.

**Exit criteria:** a new operator can install, secure, back up, upgrade, and recover an instance using only the published guide.

### Phase 4 — Ecosystem and trust

- Publish plugin and SDK examples under the MW narrative.
- Establish a public roadmap and decision record process.
- Publish security disclosure and release practices.
- Build a contributor and user feedback loop.

**Exit criteria:** external contributors can understand the product direction and safely extend it.

## 11. Non-negotiable trust requirements

- Never commit secrets, real customer identifiers, private hostnames, or production payloads.
- Preserve upstream copyright, licenses, and third-party notices.
- Do not claim data sovereignty without documenting telemetry, external calls, backups, and storage boundaries.
- Do not claim production readiness without test evidence and an explicit support matrix.
- Treat Docker socket access and host-level privileges as high risk.
- Require review for authorization, secret handling, migrations, resource limits, cancellation, and cleanup.
- Keep user-facing product names separate from internal compatibility identifiers until migration is proven.

## 12. Definition of done

A release can be described as **MW-DEVPLATFORM usable** only when all applicable checks pass:

- [ ] A clean installation succeeds from the published instructions.
- [ ] Initial administrator setup works without shipping default credentials.
- [ ] A sample application can be connected, built, deployed, and reached over HTTPS.
- [ ] Logs, deployment status, and at least one observability workflow are usable.
- [ ] Authentication and authorization boundaries are tested.
- [ ] Backup and restore have been exercised, not merely documented.
- [ ] Upgrade and rollback paths are tested for the supported release.
- [ ] Public documentation matches the actual binaries, images, commands, and environment variables.
- [ ] Legal attribution and third-party notices remain complete.
- [ ] The release has a published feature maturity and known-limitations section.

## 13. External narrative references and verification status

The requested references were `moonwitnessxv` and `A-L-L-AH.COM`. They could not be reliably retrieved during this documentation update: the first did not resolve to a verifiable source and the second returned a gateway error. Search results also surfaced unrelated namesakes. Therefore, this blueprint does **not** attribute any specific quotation, doctrine, manifesto, or official statement to those sources.

The MoonWitness interpretation and values in this document are an original working brand synthesis for MW-DEVPLATFORM. Before treating them as the definitive founder narrative, verify the intended source URLs and review their original content with the project owner.

## 14. Release readiness — evidence-based status

The brand and product direction are documented, but documentation completion is not equivalent to software completion.

At the time of this update:
- The repository contains multiple GitHub Actions workflow definitions.
- The GitHub repository API returned no recent workflow-run records and no published release records.
- The only branch returned by the repository API was `main`; no open pull requests or issues were returned.
- The current deployment manifests and Cargo workspace retain Temps identifiers.
- No independent clean-host install, sample-app deployment, restore drill, or upgrade/rollback result was available as evidence in this review.

Accordingly, the release is **not certified production-ready**. This is an evidence status, not a claim that the software is broken.

The operational acceptance process is now documented in [Release Readiness & Operator Runbook](RELEASE_READINESS.md). A release owner must attach reproducible CI, build, security, installation, sample deployment, backup/restore, and upgrade/rollback evidence before checking off the Definition of Done in this blueprint.

The next engineering sequence is:
1. Run the existing CI and test workflows against the exact release commit; fix failures and retain run links.
2. Validate the Compose stack on a clean supported Linux host using private, unique credentials.
3. Deploy a sample application and verify ingress, TLS, logs, health, and observability end to end.
4. Exercise backup/restore and upgrade/rollback on disposable test environments.
5. Publish the supported OS/architecture matrix, known limitations, release notes, and operator support guidance.
6. Only then make a production-readiness claim or publish a stable MW-branded release.

---

**One-line narrative:**  
*MW-DEVPLATFORM is the clear, self-hostable foundation for people who build and operate with ownership—bringing delivery, visibility, and responsible control into one place.*
