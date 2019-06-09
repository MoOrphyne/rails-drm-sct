import "bootstrap";
import { initSelect2, initFilter, initSelector } from '../plugins/init_select2';

if (document.querySelector('.filter')) {
  initFilter();
}

if (document.querySelector('.search')) {
  initSelect2();
}

if (document.querySelector('.js-example-basic-multiple')) {
  initSelector();
}
