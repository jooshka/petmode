$ ->
  $(document).on 'click', '.gender-block>ul>li', (e) ->
    $(this).parent().children(':first-child').toggleClass 'active'
    $(this).parent().children(':last-child').toggleClass 'active'
    v = $('#pet_gender').val()
    if v == 'male' then v = 'female' else v = 'male'
    $('#pet_gender').val(v)
    return
  return
