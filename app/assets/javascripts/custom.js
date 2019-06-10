$(document).ready(function(){
  $('.precious').on('click',function(){
    $.ajax({
      url: 'posts/' + this.parentElement.id
      type: 'POST'
    });
  });
});
