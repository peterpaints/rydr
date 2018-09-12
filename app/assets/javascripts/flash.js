document.addEventListener('DOMContentLoaded', () => {
  $('.alert')
    .clearQueue()
    .slideDown(1000);
  setTimeout(() => {
    $('.alert').slideUp(1000);
  }, 5000);
});
