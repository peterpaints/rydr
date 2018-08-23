document.addEventListener('DOMContentLoaded', () => {
  $('.vehicles-nav').focus();
  $('.settings-nav').focus();
  $('.notifications-tile').hide();
  $('.user-rides').hide();
  $('.add-ride').hide();

  $('.vehicles-nav').click(() => {
    $('.vehicle-tile').show();
    $('.add-vehicle').show();
    $('.notifications-tile').hide();
    $('.user-rides').hide();
    $('.add-ride').hide();
    $('.filter-button').show();
  });

  $('.notifications-nav').click(() => {
    $('.notifications-tile').show();
    $('.vehicle-tile').hide();
    $('.add-vehicle').hide();
    $('.user-rides').hide();
    $('.add-ride').hide();
    $('.filter-button').hide();
  });

  $('.ride-history-nav').click(() => {
    $('.user-rides').show();
    $('.add-ride').show();
    $('.vehicle-tile').hide();
    $('.add-vehicle').hide();
    $('.notifications-tile').hide();
    $('.filter-button').show();
  });
});
