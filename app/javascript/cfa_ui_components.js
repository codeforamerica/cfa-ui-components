import Alpine from 'alpinejs';
import mask from '@alpinejs/mask';
import focus from '@alpinejs/focus';
import combobox from "./combobox";
import tin_component from "./tin_component";

Alpine.plugin(mask);
Alpine.plugin(focus);
Alpine.plugin(combobox);
Alpine.plugin(tin_component);
window.Alpine = Alpine;
Alpine.start();
