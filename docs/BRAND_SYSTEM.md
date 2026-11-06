# Empire of Light Platform — Brand & Language System

> **Build with clarity. Deploy with sovereignty. Operate with accountability.**

This document governs product-facing language for the infrastructure platform in `BRIDGE-ALLAH/EMPIRE-OF-LIGHT`. It does not change upstream legal attribution or authorize a blind rename of technical identifiers.

## Identity

- **Ecosystem brand:** A-L-L-A-H.COM — Empire of Light.
- **Platform product:** Empire of Light Platform.
- **Repository:** `BRIDGE-ALLAH/EMPIRE-OF-LIGHT`.
- **Category:** Self-hostable developer and infrastructure operations platform.
- **Descriptor:** Infrastructure foundation for building, delivering, and operating digital products.
- **Promise:** Your infrastructure. Your visibility. Your responsibility.

Use **Empire of Light Platform** when referring to this repository's product. Use **A-L-L-A-H.COM** when referring to the wider ecosystem. Use **ARSY** only for the separate ecosystem application/control integration layer defined in the A-L-L-A-H.COM repository. Use **MoonWitness** for its knowledge, research, narrative, and publishing domain—not as the name of this infrastructure platform.

## Narrative and voice

The platform makes infrastructure capabilities coherent and inspectable without hiding operational reality. It should help operators understand what is running, what changed, what failed, who can act, where data lives, and how to recover.

Write in a clear, calm, technically literate, evidence-led voice.

Prefer:
- “Build, deploy, and operate with evidence.”
- “Keep infrastructure control in your hands.”
- “See what changed. Understand what failed.”
- “Self-hosted by design. Transparent by default.”

Avoid:
- unsupported claims such as unhackable, zero-risk, infinitely scalable, or production-ready without evidence;
- presenting planned capabilities as shipped;
- implying divine endorsement, religious authority, or moral certification;
- decorative spiritual language in operational controls, alerts, and error messages;
- using ecosystem names as interchangeable labels for unrelated products.

## Visual direction

The visual system must distinguish the infrastructure console from the A-L-L-A-H.COM public gateway, MoonWitness knowledge experiences, ROCKSOUL creative surfaces, and Empire Economy commerce experiences.

For operational interfaces:
- prioritize information hierarchy, legibility, accessibility, predictable navigation, and fast scanning;
- use semantic status colors consistently; brand accents must never be the only status signal;
- preserve readable density for resource tables, logs, events, and diagnostics;
- use motion only when it explains state or feedback, and respect reduced-motion preferences;
- avoid decorative astronomy motifs behind dense operational data.

### Existing asset status

The repository previously introduced MOONWITNESS / MW-DEVPLATFORM visual assets and copy. Their existence in the current source tree does not make them the approved final Empire of Light identity. Treat any MW-specific mark, browser title, favicon, social image, or UI label as a **legacy asset requiring inventory and deliberate replacement**.

Do not delete or overwrite legacy assets blindly. First find every reference, confirm whether it is used by shipped routes or integrations, provide the replacement asset, update all references, and run visual/accessibility checks. Until that migration is complete, document the residual legacy surfaces honestly.

No final logo artwork, color token set, or complete UI rebrand is certified by this document alone.

## Product language map

| Context | Approved label |
|---|---|
| Ecosystem | A-L-L-A-H.COM — Empire of Light |
| This platform | Empire of Light Platform |
| This repository | `BRIDGE-ALLAH/EMPIRE-OF-LIGHT` |
| Ecosystem integration layer | ARSY |
| Knowledge and research product | MoonWitness |
| Creative/media product | ROCKSOUL |
| Commerce product domain | Empire Economy |
| Legal/upstream lineage | Temps, where technically or legally required |

## Technical naming and provenance

The codebase is derived from Temps. Preserve upstream copyright headers, NOTICE files, license texts, provider attributions, and required third-party notices.

Do not globally replace `temps`. It appears in crate names, binary and service identifiers, environment variables, database objects, migration history, image names, API contracts, installer logic, and persistent storage paths. These are compatibility surfaces, not merely brand copy.

Classify each occurrence before changing it:

1. **User-facing product copy:** use Empire of Light Platform.
2. **Internal implementation identifiers:** retain until a deliberate migration is designed and tested.
3. **Deployment and data compatibility:** retain or provide aliases, migration steps, and rollback.
4. **Legal attribution and upstream provenance:** preserve as required.
5. **Documentation examples:** describe actual `TEMPS_*` variables and commands accurately until their migration is complete.

A technical rename requires an inventory, compatibility plan, migration and rollback tests, upgrade documentation, and an explicit release decision.

## Acceptance checklist

- [ ] Browser title, favicon, metadata, and product shell use the approved platform identity.
- [ ] Login, setup, onboarding, empty, error, notification, and email copy use approved language.
- [ ] CLI, installer, Compose labels, and release metadata are audited.
- [ ] Legacy MW marks and MoonWitness product labels are either replaced or explicitly retained as historical/compatibility references.
- [ ] Semantic status colors and accessibility remain intact.
- [ ] Light/dark, mobile, and responsive states are reviewed.
- [ ] Frontend lint, typecheck, tests, and production build pass where applicable.
- [ ] Upstream legal attribution and technical compatibility are preserved.

A completed documentation update is not evidence that the visual or technical rebrand is complete.
