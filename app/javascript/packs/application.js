import "bootstrap";
import { initSelect2, initFilter, initSelector } from '../plugins/init_select2';
import { removeRow } from '../components/init_remove_row';
// import { onScroll } from '../components/scroll';

if (document.querySelector('.filter')) {
  initFilter();
}

if (document.querySelector('.search')) {
  initSelect2();
}

if (document.querySelector('.js-example-basic-multiple')) {
  initSelector();
}

if (document.querySelector('.item-rm')) {
  removeRow();
}

window.onscroll = () => {
  if(document.body.scrollTop > 70 || document.documentElement.scrollTop > 70) {
    document.getElementById("i-animation").className = "recent-products-heading d-flex scroll";
  } else document.getElementById("i-animation").className = "recent-products-heading d-flex";
};

// window.onscroll = () => {
//   if(document.body.scrollTop > 300 || document.documentElement.scrollTop > 300) {
//     document.getElementById("divider-animation").className = "featurette-divider divider-scroll";
//   } else document.getElementById("divider-animation").className = "featurette-divider";
// };
