$(() => {
  $('.alert')
    .clearQueue()
    .slideDown(1000);
  setTimeout(() => {
    $('.alert').slideUp(1000);
  }, 3000);
});
