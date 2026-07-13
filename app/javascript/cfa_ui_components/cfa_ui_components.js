import Alpine from 'alpinejs';
import mask from '@alpinejs/mask';
import focus from '@alpinejs/focus';
import combobox from "./combobox";
import select from "./select";
import alpineStoreResync from "./alpine_store_resync";
import installSensitiveFieldReload from "./sensitive_field_reload";

Alpine.plugin(mask);
Alpine.plugin(focus);
Alpine.plugin(combobox);
Alpine.plugin(select);
Alpine.plugin(alpineStoreResync);
window.Alpine = Alpine;
Alpine.start();

installSensitiveFieldReload();
