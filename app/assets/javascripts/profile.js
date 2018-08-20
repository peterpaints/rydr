document.addEventListener('DOMContentLoaded', () => {
  $('.vehicles-nav').focus();
  $('.notifications').hide();
  $('.notifications-tile').hide();
  $('.rides').hide();

  $('.vehicles-nav').click(() => {
    $('.vehicles').show();
    $('.vehicle-tile').show();
    $('.add-vehicle').show();
    $('.notifications').hide();
    $('.notifications-tile').hide();
    $('.rides').hide();
  });

  $('.notifications-nav').click(() => {
    $('.notifications').show();
    $('.notifications-tile').show();
    $('.vehicles').hide();
    $('.vehicle-tile').hide();
    $('.add-vehicle').hide();
    $('.rides').hide();
  });

  $('.rides-nav').click(() => {
    $('.rides').show();
    $('.vehicles').hide();
    $('.vehicle-tile').hide();
    $('.add-vehicle').hide();
    $('.notifications').hide();
    $('.notifications-tile').hide();
  });
});
