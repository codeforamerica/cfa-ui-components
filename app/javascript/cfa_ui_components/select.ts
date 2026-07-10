// @ts-nocheck
import type { Alpine } from "alpinejs";

type Option = { value: string; label: string };

type CfaSelectOpts = {
  options: Option[];
  value?: string;
  label?: string;
  activeIndex?: number;
  disabled?: boolean;
  buttonId: string;
  listboxId: string;
};

export default function (Alpine: Alpine) {
  Alpine.data("cfaSelect", (opts: CfaSelectOpts) => ({
    open: false,
    disabled: !!opts.disabled,
    value: opts.value ?? "",
    label: opts.label ?? "",
    options: opts.options ?? [],
    activeIndex: opts.activeIndex ?? -1,
    keyboardActive: false,
    typeahead: "",
    typeaheadTimer: null as ReturnType<typeof setTimeout> | null,
    buttonId: opts.buttonId,
    listboxId: opts.listboxId,

    init() {
      // A native form.reset() only clears the bound hidden <input>; it does not
      // touch this component's Alpine state, so the button label and the
      // submitted value would desync. Restore the initial (server-rendered)
      // selection when the surrounding form is reset.
      const initial = {
        value: opts.value ?? "",
        label: opts.label ?? "",
        activeIndex: opts.activeIndex ?? -1,
      };
      this.$root.closest("form")?.addEventListener("reset", () => {
        this.value = initial.value;
        this.label = initial.label;
        this.activeIndex = initial.activeIndex;
        this.closeList();
      });
    },

    optionId(i: number) {
      return `${this.buttonId}-option-${i}`;
    },

    openList() {
      if (!this.disabled) this.open = true;
    },
    closeList() {
      this.open = false;
      this.keyboardActive = false;
    },
    toggleList() {
      this.open ? this.closeList() : this.openList();
    },

    moveActive(delta: number) {
      if (!this.options.length) return;
      const start = this.activeIndex < 0 ? (delta > 0 ? -1 : 0) : this.activeIndex;
      this.activeIndex = (start + delta + this.options.length) % this.options.length;
      this.keyboardActive = true;
    },

    selectAt(i: number) {
      if (this.disabled) return;
      const opt = this.options[i];
      if (!opt) return;
      this.value = String(opt.value);
      this.label = opt.label;
      this.activeIndex = i;
      this.closeList();
      this.$refs.button?.focus();
    },

    onTypeahead(char: string) {
      if (this.typeaheadTimer) clearTimeout(this.typeaheadTimer);
      this.typeaheadTimer = setTimeout(() => {
        this.typeahead = "";
      }, 500);
      this.typeahead += char.toLowerCase();
      const buf = this.typeahead;
      const allSame = buf.length > 1 && buf.split("").every((c) => c === buf[0]);
      const search = allSame ? buf[0] : buf;
      const start = allSame ? (this.activeIndex + 1) % this.options.length : 0;
      for (let i = 0; i < this.options.length; i++) {
        const idx = (start + i) % this.options.length;
        if (this.options[idx].label.toLowerCase().startsWith(search)) {
          this.activeIndex = idx;
          this.keyboardActive = true;
          if (!this.open) this.openList();
          return;
        }
      }
    },

    onButtonKeydown(e: KeyboardEvent) {
      if (this.disabled) return;
      switch (e.key) {
        case "ArrowDown":
        case "ArrowUp": {
          e.preventDefault();
          this.moveActive(e.key === "ArrowDown" ? 1 : -1);
          if (this.open) break;
          const opt = this.options[this.activeIndex];
          if (opt) {
            this.value = String(opt.value);
            this.label = opt.label;
          }
          break;
        }
        case "Enter":
        case " ":
          e.preventDefault();
          this.open && this.activeIndex >= 0 ? this.selectAt(this.activeIndex) : this.openList();
          break;
        case "Escape":
          if (this.open) {
            e.preventDefault();
            this.closeList();
          }
          break;
        case "Home":
          if (this.open) {
            e.preventDefault();
            this.activeIndex = 0;
          }
          break;
        case "End":
          if (this.open) {
            e.preventDefault();
            this.activeIndex = this.options.length - 1;
          }
          break;
        case "Tab":
          if (this.open) {
            if (this.activeIndex >= 0) {
              const opt = this.options[this.activeIndex];
              this.value = String(opt.value);
              this.label = opt.label;
            }
            this.closeList();
          }
          break;
        default:
          if (e.key.length === 1 && !e.ctrlKey && !e.metaKey && !e.altKey) {
            e.preventDefault();
            this.onTypeahead(e.key);
          }
      }
    },
  }));
}
