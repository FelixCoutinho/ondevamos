$(document).ready(function(){
  $("select#grupo_id").change(function(){
    var grupo_id = $(this).find('option:selected').val();
    if(grupo_id !== ""){
      $('div#area_votacao').load('/votos/jaVotou/'+grupo_id).
        ajaxStart(function() {
          $(this).text('Triggered ajaxStart handler.');
      });
    }
  });
});
