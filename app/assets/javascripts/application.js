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
// = require jquery.turbolinks
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require js-routes
//= require_tree .

//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.en-GB.js
//= require filterrific/filterrific-jquery
//= require chardinjs

//document.getElementById('search_query_box')
'use strict'

let handleTableClass = () => {
    let searchQuery = document.getElementById('search_query_box').value;
    let tableResults = document.getElementById('table-results');
    let entryText = document.getElementById('entry-text');
    let stFilter = document.getElementById('stFilter');
    let grFilter = document.getElementById('grFilter');
    let compReq = document.getElementById('compReq');
    let sortOrder = document.getElementById('sortOrder');

    if (searchQuery.length > 0 || stFilter.value !== '' || grFilter.value !== '' || compReq.value !== '' || sortOrder.value !== 'created_at_desc') {
        tableResults.classList.remove('hidden-table');
        entryText.classList.add('hidden-table');
    }
    else {
        tableResults.classList.add('hidden-table');
        entryText.classList.remove('hidden-table');
    }
}

$(document).ready(function() {
    handleTableClass();
    let sqb = document.getElementById('search_query_box');
    sqb.addEventListener('input', handleTableClass);

    $('#stFilter').change(handleTableClass);
    $('#grFilter').change(handleTableClass);
    $('#compReq').change(handleTableClass);
    $('#sortOrder').change(handleTableClass);  
});
