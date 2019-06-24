$(document).ready(function(){
  $(document).on("click", ".comment-button", function(e){
    var post_id = this.id.split("-")[1];
    $('#post-'+post_id+'-comments').toggle();
  });
  $(document).on("click",'.dropdown',function(e){
    var post_id = this.id.split("-")[1];
    console.log(post_id);
    $('#post-'+post_id+'-menu').toggle();
  });
});
