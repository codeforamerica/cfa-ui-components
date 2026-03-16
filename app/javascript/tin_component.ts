import type { Alpine, ElementWithXAttributes } from "alpinejs";

export default function (Alpine: Alpine) {
    Alpine.directive('tin', (el, directive) => {
        if (directive.value === 'input') tinInput(el, Alpine)
        else if (directive.value === 'desc') tinDesc(el, Alpine)
        else if (directive.value === 'label') tinLabel(el, Alpine)
        else if (directive.value === 'show-checkbox') tinCheckbox(el, Alpine)
        else if (directive.value === 'alert') tinAlert(el, Alpine)
        else if (directive.value === 'show-label') tinCheckboxLabel(el, Alpine)
        else tinRoot(el, Alpine)
    })
}

const tinRoot = (el: ElementWithXAttributes<HTMLElement>, Alpine: Alpine) => {
    Alpine.bind(el, {
        'x-id'() {
            return ['tin-label', 'tin-input', 'tin-desc', 'tin-show-checkbox', 'tin-show-checkbox-label']
        },
        'x-data'() {
            return {
                inputEl: undefined as HTMLElement,
                alertEl: undefined as HTMLElement,
                inputValue: "",
                showTin: false,
                hideValue() {
                    this.inputEl.value = this.inputValue.replaceAll(/\d/g, "*");
                },
                showValue() {
                    this.inputEl.value = this.inputValue;
                },
                showHideHandler() {
                    if(this.showTin) {
                        this.showValue()
                    } else {
                        this.hideValue();
                    }
                },
                setAlertText() {
                    if(this.showTin) {
                        this.alertEl.innerHTML = "TIN visible"
                    } else {
                        this.alertEl.innerHTML = "TIN hidden"
                    }
                },
                formatMask(str: string, inputType: string){
                    if (inputType == "insertText") {
                        if(str.length >= 3 && str[3] != "-") {
                            str = str.slice(0, 3) + "-" + str.slice(3)
                        }
                        if(str.length >= 6 && str[6] != "-") {
                            str = str.slice(0, 6) + "-" + str.slice(6)
                        }
                        if(str.length > 11) {
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
            if (event.inputType == "insertText") {
                if (event.data.match(/\d/)) {
                    this.inputValue = this.inputValue + event.data
                }
            }
            else if (event.inputType == "deleteContentBackward") {
                this.inputValue = this.inputValue.slice(0, -1);
            }
            this.inputValue = this.formatMask(this.inputValue, event.inputType);
            this.showHideHandler()
        }
     })
}

const tinDesc = (el: ElementWithXAttributes<HTMLElement>, Alpine: Alpine) => {
    Alpine.bind(el, {
        ':id'() {
            return this.$id('tin-desc')
        },
    })
}

const tinCheckbox = (el: ElementWithXAttributes<HTMLElement>, Alpine: Alpine) => {
    Alpine.bind(el, {
        ':id'() {
            return this.$id('tin-show-checkbox')
        },
        '@click'() {
            this.showTin = !this.showTin
            this.showHideHandler();
            this.setAlertText();
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
    })
}


const tinAlert = (el: ElementWithXAttributes<HTMLElement>, Alpine: Alpine)=> {
    Alpine.bind(el, {
        ':id'() {
            return this.$id('tin-alert')
        },
        'x-init'() {
            this.alertEl = el;
        },

    })
}
