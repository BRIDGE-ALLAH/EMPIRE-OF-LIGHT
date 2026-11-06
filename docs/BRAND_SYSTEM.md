# MOONWITNESS — MW-DEVPLATFORM Brand System

> **Build with clarity. Deploy with sovereignty. Operate with accountability.**

This document is the product-facing identity standard for the MW-DEVPLATFORM edition of this repository. It is intentionally separate from upstream engineering attribution and internal compatibility identifiers.

## Identity

- **Master brand:** MOONWITNESS
- **Product name:** MW-DEVPLATFORM
- **Short product label:** MW Platform
- **Descriptor:** Self-hosted developer platform
- **Promise:** Your infrastructure. Your visibility. Your responsibility.
- **Primary domain:** `moonwitnessxv` brand ecosystem; deployment hostnames are operator-configured.

Use **MOONWITNESS** for the parent identity and **MW-DEVPLATFORM** when describing the product or its technical capabilities. Do not alternate randomly among Moon Witness, MoonWitnessX, MW Dev Platform, or Temps in user-facing copy.

## Narrative

MOONWITNESS is built around the idea that technology should increase human agency. The Moon represents perspective, cycles, navigation, and illumination through change. Witness represents observation, evidence, and accountability. MW-DEVPLATFORM turns those ideas into practical infrastructure: a place to build, deploy, observe, secure, and operate digital products while retaining control over code, data, and operational decisions.

The platform should make complexity legible rather than pretend it does not exist. Users should be able to understand what is running, what changed, what failed, who can act, where data lives, and what to do next.

## Voice

Write in a clear, calm, capable, technically literate voice.

Prefer:
- “See what is running. Understand what changed.”
- “Deploy with confidence. Operate with evidence.”
- “Your infrastructure. Your visibility. Your responsibility.”
- “Self-hosted by design. Transparent by default.”

Avoid:
- exaggerated claims such as unhackable, zero-risk, or infinitely scalable;
- presenting planned features as shipped;
- implying religious authority, divine endorsement, or moral certification;
- decorative spiritual language in operational controls, alerts, or error messages.

Values such as Amanah (stewardship), Ihsan (careful excellence), Adl (fairness), and Rahmah (human-centred care) are engineering lenses. Express them through security, reliability, accessibility, and transparent product behavior—not slogans in every screen.

## Visual direction

The interface is an operations console, not a marketing landing page. Prioritize dense but readable information, clear hierarchy, predictable navigation, fast scanning, and calm feedback.

- **Foundation:** neutral surfaces, strong contrast, restrained borders, compact resource lists.
- **Primary ink:** deep midnight navy `#111827`.
- **Lunar accent:** muted gold `#D6B36A`; use sparingly for focus, highlights, and brand moments, never as the only status signal.
- **Light surfaces:** white and cool near-white.
- **Dark surfaces:** deep charcoal/navy with accessible foreground contrast.
- **Typography:** retain the existing Geist / Geist Mono system unless a tested, repository-wide typography migration is proposed.
- **Iconography:** consistent Lucide line icons for controls; use the original MW mark only for product identity.
- **Motion:** functional and subtle; respect reduced-motion preferences.

The original product mark is `web/public/svg/mw-icon.svg`. Do not replace it with an upstream logo or use the mark as a decorative watermark behind operational data.

## Product language map

| Context | Approved label |
|---|---|
| Browser title | MOONWITNESS — MW-DEVPLATFORM |
| Sidebar brand | MOONWITNESS |
| Product descriptor | MW-DEVPLATFORM |
| Loading state | Loading MW-DEVPLATFORM |
| Documentation | MW-DEVPLATFORM |
| Internal lineage / legal attribution | Temps, where technically or legally required |

## Technical naming and upstream compatibility

The codebase is derived from Temps. Preserve upstream copyright headers, NOTICE files, license texts, provider attributions, and required third-party notices.

Do not perform a blind global replacement of `temps`. The string appears in crate names, binary and service identifiers, environment variables, database objects, migration history, image names, API contracts, and persistent storage paths. Those are compatibility surfaces, not merely brand copy.

Classify every occurrence before changing it:

1. **User-facing brand/copy:** use MOONWITNESS or MW-DEVPLATFORM.
2. **Internal implementation identifiers:** retain until a deliberate migration is designed and tested.
3. **Deployment compatibility:** retain current names or provide aliases and migration steps.
4. **Legal attribution and upstream provenance:** preserve exactly as required.
5. **Documentation examples:** use MW product language while accurately documenting existing `TEMPS_*` variables and commands.

A future technical rename requires an inventory, compatibility plan, migration and rollback tests, upgrade documentation, and a release decision. Cosmetic rebranding must never make existing installations undiscoverable or unrecoverable.

## UI acceptance checklist

- [ ] Sidebar and loading shell use the MW product mark and MOONWITNESS name.
- [ ] Browser title identifies MOONWITNESS — MW-DEVPLATFORM.
- [ ] Login, setup, onboarding, empty, error, and notification copy use approved product language.
- [ ] No upstream product logo or unqualified “Temps” remains in user-facing surfaces, except explicit attribution or documented compatibility.
- [ ] Brand accent does not replace semantic success, warning, danger, or neutral status colors.
- [ ] Light and dark themes retain accessible contrast.
- [ ] Mobile, collapsed-sidebar, and loading states show the same identity.
- [ ] Source attribution, licenses, and legal notices remain intact.
- [ ] Frontend lint, typecheck, unit tests, E2E smoke tests, and production build pass.

## Scope note

A brand system and the first shell-level identity updates do not certify a complete UI rebrand. Every route, auth state, email template, generated page, CLI output, installer, Compose service, and release artifact must be audited and validated before claiming full brand completion.
