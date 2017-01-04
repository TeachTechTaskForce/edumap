// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery

//= require bootstrap-sprockets
//= require jquery_ujs

//= require js-routes
//= require_tree .

//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.en-GB.js
//= require filterrific/filterrific-jquery
//= require chardinjs

'use strict'

function getUrlParameter(name) {
    name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
    var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
    var results = regex.exec(location.search);
    return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
};

function handleTableClass() {
    let entryText = document.getElementById('entry-text');
    let tableResults = document.getElementById('table-results');

    entryText.classList.add('hidden-table');
    tableResults.classList.remove('hidden-table');
}

$(document).ready(function() {
    let filterForm = document.getElementById('filterrific-no-ajax-auto-submit');
    let entryText = document.getElementById('entry-text');
    let tableResults = document.getElementById('table-results');

    tableResults.classList.add('hidden-table');

    let pageParam = getUrlParameter('page');
    if (!isNaN(parseInt(pageParam))) {
      tableResults.classList.remove('hidden-table');
      entryText.classList.add('hidden-table');
    }

    filterForm.addEventListener('submit', handleTableClass);
});
