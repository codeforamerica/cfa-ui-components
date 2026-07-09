// @ts-nocheck

// Sensitive fields (currently TinComponent) render a server-computed, obfuscated
// summary (•••-••-1234) on a clean revisit and never emit the raw value into the
// DOM. That guarantee only holds for a *fresh server render* — the kind you get
// from a refresh or a normal forward navigation.
//
// The browser's Back button short-circuits a fresh render. Both Turbo Drive and
// the browser's native back/forward cache (bfcache) restore the DOM snapshot the
// user left behind, which can still contain the raw value they typed and skips
// the server's obfuscation. A full page reload re-renders the masked summary and
// keeps the raw value off the client, so we force a fresh server render on any
// page that contains a sensitive field:
//
//   - Turbo Drive: a `turbo-cache-control: no-cache` meta tells Turbo not to
//     cache this page's snapshot, so a Back/Forward restoration visit re-fetches
//     it from the server instead of restoring the stale DOM.
//   - Native bfcache (Turbo absent, or a non-Turbo navigation): `pageshow` fires
//     on restore with `event.persisted === true`; we reload. A fresh load
//     (including the reload we trigger) fires `pageshow` with
//     `persisted === false`, so this cannot loop.
//
// Everything is scoped to pages that actually contain a sensitive field, so Back
// navigation elsewhere in the host app is untouched.

const SENSITIVE_FIELD_SELECTOR = "[data-tin-input]";
const TURBO_CACHE_META_NAME = "turbo-cache-control";

function hasSensitiveField(): boolean {
  return document.querySelector(SENSITIVE_FIELD_SELECTOR) !== null;
}

// Turbo reads this meta from <head> when it caches the page (turbo:before-cache),
// so it must be present before the user navigates away. Idempotent.
function markPageUncacheableForTurbo(): void {
  if (!hasSensitiveField()) {
    return;
  }
  if (document.querySelector(`meta[name="${TURBO_CACHE_META_NAME}"]`)) {
    return;
  }
  const meta = document.createElement("meta");
  meta.name = TURBO_CACHE_META_NAME;
  meta.content = "no-cache";
  document.head.appendChild(meta);
}

function reloadIfRestoredFromBfcache(event: PageTransitionEvent): void {
  if (event.persisted && hasSensitiveField()) {
    window.location.reload();
  }
}

export default function installSensitiveFieldReload(): void {
  // Module scripts run after the document is parsed, so the current page can be
  // marked immediately; `turbo:load` re-marks it after each Turbo navigation,
  // since Turbo swaps <head> on every visit.
  markPageUncacheableForTurbo();
  document.addEventListener("turbo:load", markPageUncacheableForTurbo);
  window.addEventListener("pageshow", reloadIfRestoredFromBfcache);
}
