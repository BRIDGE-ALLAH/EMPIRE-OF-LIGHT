# Empire of Light Platform Documentation

This directory contains the product narrative and target blueprint for the Empire of Light Platform, together with implementation-oriented technical documentation inherited from the Temps codebase.

## Product and architecture

- [Product narrative](PRODUCT_NARRATIVE.md) — canonical purpose, ecosystem role, product boundaries, naming, and principles.
- [Platform blueprint](BLUEPRINT.md) — scope, architecture, ARSY integration contract, VPS/ARSY Node direction, roadmap, and acceptance gates.
- [Brand and language system](BRAND_SYSTEM.md) — approved product naming, voice, legacy asset status, and identity migration rules.
- [Architecture overview](architecture/overview/page.mdx) — implementation-oriented architecture.
- [Crate map](architecture/crates.md) — generated Rust workspace inventory and dependency layers.

## Operations and release readiness

- [Release readiness and operator runbook](RELEASE_READINESS.md) — evidence required before production claims.
- [Security policy](../SECURITY.md) — vulnerability reporting and security expectations.
- [Engineering rules](../AGENTS.md) — contributor and coding-agent constraints.
- [Review checklist](../REVIEW.md) — recurring security and reliability findings.

## Upstream-derived technical references

Some documentation files retain Temps terminology, upstream URLs, service names, environment variables, and technical identifiers because this repository is derived from the Temps codebase. Do not interpret those identifiers as the current ecosystem brand. Do not rename them globally: first verify their runtime, deployment, legal, and data-compatibility implications.

The upstream documentation tree remains useful for implementation details and operational procedures. Product-level direction and ownership boundaries are defined by the Empire of Light [narrative](PRODUCT_NARRATIVE.md) and [blueprint](BLUEPRINT.md).

## Documentation rules

- Describe current behavior only when supported by source, tests, or runtime evidence.
- Mark planned and experimental capabilities explicitly.
- Keep one authoritative owner for each product domain and source of truth.
- Link to existing technical documentation instead of duplicating it.
- Preserve upstream licenses, NOTICE files, and third-party attribution.
- Update narrative, blueprint, and implementation docs together when an accepted architecture decision changes.
