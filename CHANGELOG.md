# Changelog

All notable changes to this project will be documented in this file.

This project follows semantic versioning.

## 0.2.0 - 2026-08-13

- Renamed the plugin from `pulse-skills` to `joompulse-skills` to match the
  repository and the JoomPulse brand. Skills are now invoked as
  `/joompulse-skills:<skill>`.
- Fixed `homepage` and `repository` URLs, which still pointed at the old
  `joomcode/pulse-skills` path.
- Bundled `.mcp.json` so installing the plugin configures the JoomPulse MCP
  connector; users only need to sign in.
- Added product skills: `ml-product-analysis`, `product-change-monitor`,
  `my-product-vs-catalog`.
- Added category skills: `category-monitor`, `category-opportunity-index`,
  `growing-leaf-category-tracker`, `uncontested-niche-finder`,
  `high-demand-low-quality-finder`, `unbranded-products-in-category`,
  `new-growing-products-in-category`, `top-keywords-in-my-category`.
- Added seller and brand skills: `seller-overview-tracker`,
  `top-sellers-in-category`, `top-brand-position-tracker`.
- Added international skills: `fast-growing-international-products`,
  `popular-international-products`.
- Removed `international-product-matcher`.
- Shortened all `SKILL.md` descriptions to the 1024-character limit.

## 0.1.0 - 2026-06-16

- Initial public JoomPulse skills catalog.
- Added `pulse-find-exact-same-product`.
