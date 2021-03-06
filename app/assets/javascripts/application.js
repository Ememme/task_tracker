// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require foundation
//= require activestorage
//= require turbolinks
//= require_tree .
//= require_self

$(function(){ $(document).foundation(); });

$(function(){
  $('.js-delete-link').on('click', function(event) {
    event.preventDefault()
    event.stopPropagation()

    if(confirm('Are you sure?')) {
      var url = $(event.target).attr('href')

      $.ajax({
        method: "DELETE",
        dataType: 'json',
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        url: url
      })
      .done(function(  ) {
        $(event.target).closest('tr').remove()
      })

    }


    return false
  })
  $('#query').on('keyup', function(event){
    var input = $(event.target)
    var query = input.val()

    // ==================================================
    // ================  axios version =================
    // ==================================================

    axios.get('/tasks/search', {
      params: {
        query: query
      }
    })
    .then(function (suggestions) {
      var $suggestions = $('#suggestions')
      var $suggestions_table = $suggestions.find('table tbody')

      $suggestions_table.empty()

      suggestions.data.forEach(function(suggestion) {
        $suggestions_table.append('<tr><td>' + suggestion + '</td></tr>')
      });

      $suggestions.show()
    })
    .catch(function (error) {
      console.log(error);
      $('#suggestions').hide()
    })

    // ==================================================
    // ================  fetch version =================
    // ==================================================

    // input = "/tasks/search?query="+query
    // input = new Request("/tasks/search?query="+query);

    // init = {
    //   method: 'GET'
    // }

    // fetch(input)
    // .then(function(response) {
    //   return response.json();
    // })
    // .then(function(suggestions) {
    //   var $suggestions = $('#suggestions')
    //   var $suggestions_table = $suggestions.find('table tbody')

    //   $suggestions_table.empty()

    //   suggestions.forEach(function(suggestion) {
    //     $suggestions_table.append('<tr><td>' + suggestion + '</td></tr>')
    //   });

    //   $suggestions.show()
    // });

    // ==================================================
    // ================  jQuery version =================
    // ==================================================

    // $.ajax({
    //   method: "GET",
    //   url: "/tasks/search",
    //   data: { query: query }
    // })
    // .done(function( suggestions ) {
    //   var $suggestions = $('#suggestions')
    //   var $suggestions_table = $suggestions.find('table tbody')

    //   $suggestions_table.empty()

    //   suggestions.forEach(function(suggestion) {
    //     $suggestions_table.append('<tr><td>' + suggestion + '</td></tr>')
    //   });

    //   $suggestions.show()
    // });
  })

  $('#suggestions table').on('click', function(event){
      $('#suggestions').hide()

      var row = $(event.target)

      $('#query').val(row.html())
      $('#query').closest('form').submit()
  })
})
