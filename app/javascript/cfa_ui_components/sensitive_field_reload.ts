// @ts-nocheck

const SENSITIVE_FIELD_SELECTOR = "[data-tin-input]";
const TURBO_CACHE_META_NAME = "turbo-cache-control";

function hasSensitiveField(): boolean {
  return document.querySelector(SENSITIVE_FIELD_SELECTOR) !== null;
}

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
  markPageUncacheableForTurbo();
  document.addEventListener("turbo:load", markPageUncacheableForTurbo);
  window.addEventListener("pageshow", reloadIfRestoredFromBfcache);
}
