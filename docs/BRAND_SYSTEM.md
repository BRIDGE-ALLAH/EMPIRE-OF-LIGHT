# A-L-L-A-H.COM / Empire of Light — Rust-First Platform Brand System

## Canonical identity

- Public ecosystem brand: A-L-L-A-H.COM
- Ecosystem vision: Empire of Light
- Unified platform: ARSY
- Canonical repository: BRIDGE-ALLAH/EMPIRE-OF-LIGHT
- Repository model: one monorepo
- Backend/platform authority: Rust
- Web experience: existing Next.js / React apps
- Node.js: frontend tooling only where required

ARSY is the unified Rust-first platform. Do not present it as separate Node and Rust backends. Rust is the sole planned backend authority.

## Product language

| Context | Approved name |
|---|---|
| Ecosystem and public entry | A-L-L-A-H.COM |
| Overall vision | Empire of Light |
| Unified platform | ARSY |
| Backend and platform | ARSY Rust Platform |
| VPS installation profile | ARSY Node |
| Knowledge/research/publishing | MoonWitness |
| Creative/media | ROCKSOUL |
| Commerce | Empire Economy |
| Communication domain | ARSY Radio |

ARSY Node names the host/VPS operating profile, not a Node.js backend. Avoid ambiguous language that suggests it is a separate Node.js service.

## Voice

Use a clear, confident, technically literate, evidence-led voice. Explain what a component does and what it does not own. Avoid exaggerated claims and describing planned work as shipped.

Preferred messages:
- One ecosystem. One Rust-first platform.
- Rust owns the backend and platform authority.
- Node.js is frontend tooling, not a second backend.
- One source of truth. Independently deployable components.

## Visual direction

Keep the ecosystem identity cinematic and distinctive while making operational interfaces readable and accessible. Product experiences may have distinct visual DNA, but must share coherent interaction contracts, accessibility expectations, and platform identity rules.

Operational interfaces prioritize information hierarchy, legibility, clear state, and predictable navigation. Brand accents must not replace semantic status colors. Motion must communicate state and respect reduced-motion preferences.

## Technical naming and provenance

The Rust workspace is Temps-derived. Preserve upstream copyright headers, NOTICE files, license texts, provider attributions, and required third-party notices.

Do not globally rename Temps, crate names, binaries, environment variables, database objects, image names, URLs, or persistent paths. Inventory each occurrence and classify it as user-facing copy, internal identifier, deployment compatibility, or legal attribution before changing it.

The current upstream-specific installer and legacy identifiers must not be cosmetically relabeled as ARSY Node. Technical migrations require tests, aliases or migration instructions, rollback, and release notes.

## Repository and migration rule

BRIDGE-ALLAH/EMPIRE-OF-LIGHT is the one canonical repository. The former bjo163/A-L-L-A-H.COM source must be reconciled into this monorepo; until migration and verification finish, it remains a temporary source of code, not a second long-term platform home. Do not archive or delete it before destination verification.

## Brand acceptance

- [ ] All maintained user-facing surfaces use approved ecosystem and component names.
- [ ] ARSY is consistently presented as one Rust-first platform.
- [ ] No copy suggests a Fastify backend or dual backend architecture.
- [ ] Apps retain distinct product identities without duplicating platform authority.
- [ ] Legacy MoonWitness/MW assets are inventoried before replacement.
- [ ] Browser title, metadata, login, onboarding, CLI, installer, email, and release copy are audited.
- [ ] Accessibility and semantic status contrast remain intact.
- [ ] Upstream legal attribution and technical compatibility are preserved.
