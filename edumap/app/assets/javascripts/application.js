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
//= require turbolinks
//= require js-routes
//= require_tree .

//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.en-GB.js
//= require filterrific/filterrific-jquery
//= require chardinjs

//document.getElementById('search_query_box')

function handleTableClass(){
    var searchQuery = document.getElementById('search_query_box').value;
    var tableResults = document.getElementById('table-results')
    var entryText = document.getElementById('entry-text')
    if(searchQuery.length > 0){
        tableResults.classList.remove('hidden-table');
        entryText.classList.add('hidden-table');
    }
    else{
        tableResults.classList.add('hidden-table');
        entryText.classList.remove('hidden-table');
    }
}

$(document).ready(function(){
    handleTableClass();
    $('#search_query_box').change(handleTableClass);
})