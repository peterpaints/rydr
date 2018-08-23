$(() => {
  $('.tile input[type=text]').attr('disabled', true).addClass('input-disabled');
  $('.save').parent().hide();
  $('.tile-container-settings').on('click', '.edit', (e) => {
    $(e.delegateTarget).find('input')
    .attr('disabled', (_, attr) => { return !attr})
    .toggleClass('input-disabled');
    $(e.delegateTarget).find('.save').parent().show();
    $(e.delegateTarget).find('.edit').parent().hide();
  });
});
