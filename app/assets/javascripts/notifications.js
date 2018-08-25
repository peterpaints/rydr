$(() => {
  $('.notifications-tile input[type=text]').attr('disabled', true);
  $('.notifications-tile .save').parent().hide();
  $('.phone-number').on('click', '.edit', (e) => {
    $(e.delegateTarget).find('input[type=text]')
    .attr('disabled', (_, attr) => { return !attr })
    .toggleClass('input-disabled');
    $(e.delegateTarget).find('.save').parent().show();
    $(e.delegateTarget).find('.edit').parent().hide();
  });
  $('.slack-handle').on('click', '.edit', (e) => {
    $(e.delegateTarget).find('input[type=text]')
    .attr('disabled', (_, attr) => { return !attr })
    .toggleClass('input-disabled');
    $(e.delegateTarget).find('.save').parent().show();
    $(e.delegateTarget).find('.edit').parent().hide();
  });
});
