app.PetFilter = function() {
  $('.form__input-radio').click(function() {

  });
  this._init();
};

app.PetFilter.prototype = {
  _init : function() {
    this.family = false;
    this.gender = false;
  }

};
