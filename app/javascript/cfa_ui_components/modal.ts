// @ts-nocheck
// Native <dialog> behavior for ModalComponent. Deliberately framework-free so
// modals keep working on any browser that runs JavaScript, even one too old for
// Alpine or one where Alpine failed to boot.
//
// Opening is wired two ways:
//   - `[data-cfa-modal-open="<name>"]` clicks (no Alpine needed), and
//   - the legacy `<name>-modal` custom event that `$dispatch('<name>-modal')`
//     bubbles to window — kept for backward compatibility with existing
//     Alpine triggers (tooltips, app delete buttons) during migration.
// Closing is handled natively by the `<form method="dialog">` close button and
// Escape, plus `[data-cfa-modal-close]` clicks and backdrop clicks here.

function modalFor(name) {
  const el = document.getElementById(name);
  return el instanceof HTMLDialogElement ? el : null;
}

function lockScroll() {
  document.documentElement.style.overflow = "hidden";
}

function unlockScroll() {
  document.documentElement.style.overflow = "";
}

function openModal(name) {
  const dialog = modalFor(name);
  if (!dialog || typeof dialog.showModal !== "function" || dialog.open) return;
  dialog.showModal();
  lockScroll();
}

let started = false;

export default function setupModals() {
  if (started) return;
  started = true;

  document.addEventListener("click", (event) => {
    const opener = event.target.closest?.("[data-cfa-modal-open]");
    if (opener) {
      event.preventDefault();
      openModal(opener.getAttribute("data-cfa-modal-open"));
      return;
    }

    const closer = event.target.closest?.("[data-cfa-modal-close]");
    if (closer) {
      event.preventDefault();
      closer.closest("dialog")?.close();
      return;
    }

    // A click whose target is the dialog element itself (not its contents) is a
    // click on the backdrop — close, matching the previous click-away behavior.
    if (event.target instanceof HTMLDialogElement && event.target.dataset.cfaModal) {
      event.target.close();
    }
  });

  document.addEventListener("close", (event) => {
    if (event.target instanceof HTMLDialogElement && event.target.dataset.cfaModal) {
      unlockScroll();
    }
  }, true);

  document.addEventListener("turbo:before-visit", unlockScroll);

  const bridgeLegacyEvents = () => {
    document.querySelectorAll("dialog[data-cfa-modal]").forEach((dialog) => {
      if (dialog.dataset.cfaModalBridged) return;
      dialog.dataset.cfaModalBridged = "true";
      const name = dialog.dataset.cfaModal;
      window.addEventListener(`${name}-modal`, () => openModal(name));
    });
  };

  bridgeLegacyEvents();
  document.addEventListener("turbo:load", bridgeLegacyEvents);
  document.addEventListener("DOMContentLoaded", bridgeLegacyEvents);
}
