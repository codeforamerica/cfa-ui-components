// @ts-nocheck
import type { Alpine } from "alpinejs";

// RadioButtonsComponent and CheckboxesComponent seed their Alpine store once,
// via `x-init="Alpine.store(key, currentValue)"`, from the value baked into the
// server-rendered HTML. Each input is then two-way bound with
// `x-model="$store.<key>"`.
//
// On history navigation (e.g. the browser Back button) the browser restores the
// checked state of those inputs, but Alpine's `x-init` re-seeds the store from
// the STALE value in the original HTML, and the browser's control restoration
// does not fire the `input` events that `x-model` listens to. The store and the
// visible radio/checkbox therefore diverge, so a `ConditionalComponent` whose
// `x-effect` reads that store stays hidden even though the answer that should
// reveal it is selected.
//
// `pageshow` fires after the browser has restored form state (on both bfcache
// restores and re-parsed history navigations), so re-seeding each store from the
// actually-checked inputs here keeps the store and the DOM in sync. This mirrors
// the store contract defined in radio_buttons_component.html.erb and
// checkboxes_component.html.erb — keep the `$store.<key>` binding and the scope
// suffix in `store_key` in sync with the selector/parsing below.

const STORE_MODEL_PATTERN = /^\$store\.([\w-]+)$/;

function resyncAlpineStores(Alpine: Alpine): void {
  if (!Alpine || typeof Alpine.store !== "function") {
    return;
  }

  // Checkbox stores are arrays, so collect every checked value per key before
  // writing; radios are scalar and can be written as soon as the checked one is
  // found. Keys with only unchecked checkboxes must still be reset to [].
  const checkboxValues: Record<string, string[]> = {};

  document
    .querySelectorAll<HTMLInputElement>('input[x-model^="$store."]')
    .forEach((input) => {
      const match = input.getAttribute("x-model")?.match(STORE_MODEL_PATTERN);
      if (!match) {
        return;
      }
      const storeKey = match[1];

      if (input.type === "radio") {
        if (input.checked) {
          Alpine.store(storeKey, input.value);
        }
      } else if (input.type === "checkbox") {
        const values = (checkboxValues[storeKey] ||= []);
        if (input.checked) {
          values.push(input.value);
        }
      }
    });

  Object.entries(checkboxValues).forEach(([storeKey, values]) => {
    Alpine.store(storeKey, values);
  });
}

export default function (Alpine: Alpine): void {
  window.addEventListener("pageshow", () => resyncAlpineStores(Alpine));
}
