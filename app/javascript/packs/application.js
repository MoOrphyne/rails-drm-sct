import "bootstrap";
import { initSelect2, initFilter } from '../plugins/init_select2';

if (document.querySelector('.filter')) {
  initFilter();
}

if (document.querySelector('.search')) {
  initSelect2();
}
