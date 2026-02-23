import Alpine from 'alpinejs';
import mask from '@alpinejs/mask';
import focus from '@alpinejs/focus';
import combobox from "./combobox";

Alpine.plugin(mask);
Alpine.plugin(focus);
Alpine.plugin(combobox);
window.Alpine = Alpine;
Alpine.start();
