// @ts-nocheck

// Provider-agnostic analytics emitter for shared components.
//
// Components opt in by rendering two data attributes on the element the user
// interacts with:
//
//   data-analytics-event="reveal_clicked"   // the event name to report
//   data-analytics-id="what_is_permanent_home"
//
// On the appropriate DOM interaction this dispatches a bubbling `cfa:analytics`
// CustomEvent carrying `{ event, id }`. The gem deliberately knows nothing about
// Mixpanel (or any provider) or credentials — the consuming app listens for
// `cfa:analytics` and routes it wherever it likes, enriching with page/context.
//
// Two interaction models are supported:
//   - <details> reveals fire on OPEN only (the `toggle` event, `el.open === true`),
//     so collapsing does not report and content clicks inside the panel do not
//     false-fire.
//   - Everything else (e.g. tooltip <button>s) fires on `click`.

const MARKER = "[data-analytics-event]";

function emit(el: Element): void {
  // Prefer the explicit analytics id; fall back to the element's HTML id when
  // one is present. Never emit an unidentifiable (null/empty id) event.
  const id = el.getAttribute("data-analytics-id") || el.id || null;
  if (!id) return;
  el.dispatchEvent(
    new CustomEvent("cfa:analytics", {
      bubbles: true,
      detail: {event: el.getAttribute("data-analytics-event"), id},
    })
  );
}

// `toggle` does not bubble, so listen in the capture phase to reach any
// marked <details> from the document root. Report opens only.
function onToggle(event: Event): void {
  const el = event.target as HTMLElement;
  if (!(el instanceof HTMLDetailsElement) || !el.open) return;
  if (!el.matches(MARKER)) return;
  emit(el);
}

// `click` bubbles, so a single delegated listener covers all marked controls.
// <details> is handled by onToggle, so ignore clicks that resolve to one
// (e.g. clicking a reveal's <summary>) to avoid double-reporting.
function onClick(event: Event): void {
  const el = (event.target as HTMLElement).closest(MARKER);
  if (!el || el instanceof HTMLDetailsElement) return;
  emit(el);
}

export default function installAnalyticsEmitter(): void {
  document.addEventListener("toggle", onToggle, true);
  document.addEventListener("click", onClick);
}
