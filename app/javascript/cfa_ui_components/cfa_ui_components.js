import Alpine from 'alpinejs';
import mask from '@alpinejs/mask';
import focus from '@alpinejs/focus';
import combobox from "./combobox";
import select from "./select";
import setupModals from "./modal";

Alpine.plugin(mask);
Alpine.plugin(focus);
Alpine.plugin(combobox);
Alpine.plugin(select);
window.Alpine = Alpine;
Alpine.start();

setupModals();
