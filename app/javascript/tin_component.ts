// @ts-nocheck
import type { Alpine, ElementWithXAttributes } from "alpinejs";

export default function (Alpine: Alpine) {
    Alpine.directive('tin', (el, directive) => {
        if (directive.value === 'input') tinInput(el, Alpine)
        else if (directive.value === 'desc') tinDesc(el, Alpine)
        else if (directive.value === 'label') tinLabel(el, Alpine)
        else if (directive.value === 'show-checkbox') tinCheckbox(el, Alpine)
        else if (directive.value === 'show-label') tinCheckboxLabel(el, Alpine)
        else tinRoot(el, Alpine)
    })

    Alpine.magic('tin', el => {
        const $data = Alpine.$data(el)

        return {
            get isLoaded() {
                return $data.isLoaded
            }
        }
    })
}

const tinRoot = (el: ElementWithXAttributes<HTMLElement>, Alpine: Alpine) => {
    Alpine.bind(el, {
        'x-id'() {
            return ['tin-label', 'tin-input', 'tin-desc', 'tin-show-checkbox', 'tin-show-checkbox-label']
        },
        'x-init'() {
            this.isLoaded = true;
        },
        'x-data'() {
            return {
                inputEl: undefined as HTMLElement,
                inputValue: "",
                isLoaded: false,
                showTin: false,
                hideValue() {
                    this.inputEl.value = this.inputValue.replaceAll(/\d/g, "*");
                },
                showValue() {
                    this.inputEl.value = this.inputValue;
                },
                hideHandler() {
                    if(this.showTin) {
                        this.showValue()
                    } else {
                        this.hideValue();
                    }
                },
                formatMask(str: string, inputType: string){
                    //can we use alpine mask here? there's a bug if we backspace to a hyphen breakpoint and then type again.
                    if (inputType == "insertText") {
                        if(str.length == 3) {
                            str = str.slice(0, 3) + "-"
                        }
                        else if(str.length == 6) {
                            str = str.slice(0, 6) + "-"
                        }
                        else if(str.length > 11) {
                            str = str.slice(0, 11)
                        }
                    }
                    return str
                }
            }
        },
    })
}

const tinInput = (el: ElementWithXAttributes<HTMLElement>, Alpine: Alpine) => {
    Alpine.bind(el, {
        ':type'() {
            return 'text'
        },
        ':autocapitalize'() {
            return 'off'
        },
        ':autocomplete'() {
            return 'off'
        },
        ':id'() {
            return this.$id('tin-input')
        },

        ':aria-labelledby'() {
            return this.$id('tin-label')
        },
        ':aria-describedby'() {
            if(this.comboboxDesc) {
                return this.$id('tin-desc')
            }
        },
        'x-init'() {
            this.inputEl = el;
        },
        '@input'(event) {
            if(event.inputType == "insertText") {
                if (event.data.match(/\d/)) {
                    this.inputValue = this.inputValue + event.data
                }
            }
            else if (event.inputType == "deleteContentBackward") {
                this.inputValue = this.inputValue.slice(0, -1);
            } else {

            }
            this.inputValue = this.formatMask(this.inputValue, event.inputType);
            console.log(this.inputValue);
            this.hideHandler()
        }
     })
}

const tinDesc = (el: ElementWithXAttributes<HTMLElement>, Alpine: Alpine) => {
    Alpine.bind(el, {
        ':id'() {
            return this.$id('tin-desc')
        },
        'x-init'() {
        },
    })
}

const tinCheckbox = (el: ElementWithXAttributes<HTMLElement>, Alpine: Alpine) => {
    Alpine.bind(el, {
        ':id'() {
            return this.$id('tin-show-checkbox')
        },
        'x-init'() {
        },
        '@click'() {
            this.showTin = !this.showTin
            this.hideHandler();
        },
    })
}

const tinLabel = (el: ElementWithXAttributes<HTMLElement>, Alpine: Alpine) => {
    Alpine.bind(el, {
        ':id'() {
            return this.$id('tin-label')
        },
        ':for'() {
            return this.$id('tin-input')
        },
        'x-init'() {
        },
    })
}

const tinCheckboxLabel = (el: ElementWithXAttributes<HTMLElement>, Alpine: Alpine)=> {
    Alpine.bind(el, {
        ':id'() {
            return this.$id('tin-show-checkbox-label')
        },
        ':for'() {
            return this.$id('tin-show-checkbox')
        },
        'x-init'() {
        },
    })
}
