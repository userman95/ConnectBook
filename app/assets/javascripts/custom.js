$(document).ready(function(){
  $('.comment-button').on("click", function(){
    var post_id = this.id.split("-")[1];
    $('#post-'+post_id+'-comments').toggle();
  });
});