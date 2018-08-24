$(() => {
  $('.tile-container-rides input[type=text], \
  .tile-container-rides input[type=datetime-local], \
  .tile-container-rides select')
  .attr('disabled', true)
  .addClass('input-disabled');
  $('select').addClass('disabled-select');
  $('input[type=datetime-local]').addClass('disabled-time-picker');
  $('.tile-container-rides .save').parent().hide();
  $('.tile-container-rides').on('click', '.edit', (e) => {
    $(e.delegateTarget).find('input[type=text], input[type=datetime-local], select')
    .attr('disabled', (_, attr) => { return !attr })
    .toggleClass('input-disabled');
    $(e.delegateTarget).find('select').toggleClass('disabled-select');
    $(e.delegateTarget).find('input[type=datetime-local]')
    .toggleClass('disabled-time-picker');
    $(e.delegateTarget).find('.save').parent().show();
    $(e.delegateTarget).find('.edit').parent().hide();
  });
  $('.tile-container-rides').on('click', '.delete-ride', (e) => {
    $('#delete-ride-modal form').attr('action', $(e.target).attr('data-href'));
  });
});
