app.Cities = function() {
  this._input = $('#cities-search-txt');
  this._input_field = $('#user_city_id');
  this._initAutocomplete();
};

app.Cities.prototype = {
  _initAutocomplete: function() {
    this._input
      .autocomplete({
        source: '/cities/search',
        appendTo: '#cities-search-results',
        focus: function() { return false; },
        change: $.proxy(this._change, this),
        select: $.proxy(this._select, this)
      })

      .autocomplete('instance')._renderItem = $.proxy(this._render, this);
  },

  _render: function(ul, item) {
    var markup = [
      '<strong>' + item.name + '</strong>',
      '<div class="ui-item-description">' + item.description + '</div>'
    ];
    return $('<li>')
      .append(markup.join(''))
      .appendTo(ul);
  },

  _select: function(e, ui) {
    this._input.val(ui.item.description);
    this._input_field.val(ui.item.id);
    return false;
  },

  _change: function( e, ui ) {
    this._input_field.val( ui.item ? ui.item.id : null );
  }
};
