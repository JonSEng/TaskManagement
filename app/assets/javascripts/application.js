// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .
//= require flat-ui


// Provides validation (ensures the text field has at least one character, not counting spaces)
function checkvalue(id) {
    var textfield = document.getElementById(id).value;
    if(!textfield.match(/\S/)) {
      alert ('Please fill in ' + document.getElementById(id).placeholder);
      return false;
    } else {
      return true;
    }
  }

function importTasks() {
    var save_url = window.location.toString().split(/\/tasks.*/)[0] + "/import/" + $("#import_task_set").val();
    window.location = save_url;
}

$(document).ready(function() {
    $("#bug_report").bind("mouseenter", function() {
        $(".bug_report_text").removeClass("bug_report_hidden");
    });
    $("#bug_report").bind("mouseleave", function() {
        $(".bug_report_text").addClass("bug_report_hidden");
    });
});
