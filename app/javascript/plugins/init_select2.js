import $ from 'jquery';
import 'select2';
import 'select2/dist/css/select2.css';

const initFilter = () => {
  $('.select2').select2({
    placeholder: "filter",
    allowClear: true
  }).on("change", function(e) {
    document.getElementById('filter-submit').click();
  });
};

const initSelect2 = () => {
  $('.select2').select2({
    placeholder: "Search",
    allowClear: true
  })
};

const initSelector = () => {
  $(document).ready(function() {
      $('.js-example-basic-multiple').select2();
  });
}

export { initSelect2, initFilter, initSelector };
