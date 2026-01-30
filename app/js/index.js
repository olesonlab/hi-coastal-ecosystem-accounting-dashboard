function setTooltipPlacement() {
  if (window.innerWidth < 576) {
    $('[data-toggle="tooltip"]').tooltip('dispose').tooltip({
      placement: 'bottom',
      container: 'body'
    });
  } else {
    $('[data-toggle="tooltip"]').tooltip('dispose').tooltip({
      placement: 'top',
      container: 'body'
    });
  }
}

$(function () {
  setTooltipPlacement();
  $(window).on('resize', setTooltipPlacement);
});
