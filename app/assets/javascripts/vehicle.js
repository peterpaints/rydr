document.addEventListener('DOMContentLoaded', () => {
  $('.tile-container-settings input[type=text]').attr('disabled', true).addClass('input-disabled');
  $('.tile-container-settings .save').parent().hide();
  $('.tile-container-settings').on('click', '.edit', (e) => {
    $(e.delegateTarget).find('input[type=text]')
    .attr('disabled', (_, attr) => { return !attr })
    .toggleClass('input-disabled');
    $(e.delegateTarget).find('.save').parent().show();
    $(e.delegateTarget).find('.edit').parent().hide();
  });
  $('.tile-container-settings').on('click', '.delete', (e) => {
    $('#delete-vehicle-modal form').attr('action', $(e.target).attr('data-href'));
  });
});
