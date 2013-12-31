 $(function(){
   $('#contacts').selectize({
    plugins: ['remove_button'],
    valueField: '_id',
    labelField: 'email',
    searchField: 'email',
    create: false,
    render: {
      option: function(item, escape) {
        return '<div>' +
        escape(item.email) +
        '<span class="description">' +
        escape(item.first_name) + ' ' + escape(item.last_name) +
        '</span>' +
        '</div>';
      }
    },
    load: function(query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: '/users/find?q=' + encodeURIComponent(query),
        type: 'GET',
        error: function() {
          callback();
        },
        success: function(res) {
          callback(res.slice(0, 10));
        }
      });
    }
  });

});