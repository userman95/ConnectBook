$(document).ready(function(){
  $(document).on("click", ".comment-button", function(e){
    var post_id = this.id.split("-")[1];
    $('#post-'+post_id+'-comments').toggle();
  });
});