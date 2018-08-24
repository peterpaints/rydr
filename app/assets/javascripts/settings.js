document.addEventListener('DOMContentLoaded', () => {
  const tabs = {
    '.vehicles-nav': '#tab1',
    '.notifications-nav': '#tab2',
    '.ride-history-nav': '#tab3',
  };
  const content = {
    '.vehicles-nav': ['.vehicle-tile', '.add-vehicle', '.filter-button'],
    '.notifications-nav': ['.notifications-tile'],
    '.ride-history-nav': ['.user-rides', '.add-ride', '.filter-button']
  };
  const allContent = ['.vehicle-tile', '.add-vehicle', '.filter-button', '.notifications-tile','.user-rides', '.add-ride', '.filter-button']
  const activeTab = localStorage.getItem('tab');
  if (activeTab) {
    $('.tabs input').attr('checked', false);
    $(tabs[activeTab]).attr('checked', true);
    for (let i = 0; i < allContent.length; i++) {
      if (content[activeTab].indexOf(allContent[i]) == -1) {
        $(allContent[i]).hide();
      } else {
        $(allContent[i]).show();
      }
    }
  }
  $('.settings-nav').focus();
  // $('.notifications-tile').hide();
  // $('.user-rides').hide();
  // $('.add-ride').hide();

  $('.vehicles-nav').click(() => {
    localStorage.setItem('tab', '.vehicles-nav');
    $('.vehicle-tile').show();
    $('.add-vehicle').show();
    $('.notifications-tile').hide();
    $('.user-rides').hide();
    $('.add-ride').hide();
    $('.filter-button').show();
  });

  $('.notifications-nav').click(() => {
    localStorage.setItem('tab', '.notifications-nav');
    $('.notifications-tile').show();
    $('.vehicle-tile').hide();
    $('.add-vehicle').hide();
    $('.user-rides').hide();
    $('.add-ride').hide();
    $('.filter-button').hide();
  });

  $('.ride-history-nav').click(() => {
    localStorage.setItem('tab', '.ride-history-nav');
    $('.user-rides').show();
    $('.add-ride').show();
    $('.vehicle-tile').hide();
    $('.add-vehicle').hide();
    $('.notifications-tile').hide();
    $('.filter-button').show();
  });
});
