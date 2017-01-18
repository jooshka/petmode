$ ->
  $(document).on 'click', '.gender-block>ul>li', (e) ->
    $(this).parent().children(':first-child').toggleClass 'active'
    $(this).parent().children(':last-child').toggleClass 'active'
    v = $('#pet_gender_id').val()
    v = if (parseInt(v, 10)+1) % 2 == 0 then 2; else 1;
    $('#pet_gender_id').val(v)
    return
  return
