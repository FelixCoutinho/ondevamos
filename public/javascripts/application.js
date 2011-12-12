$(document).ready(function(){
  $("select#grupo_id").change(function(){
    var grupo_id = $(this).find('option:selected').val();
    if(grupo_id !== ""){
      $.getJSON('/votos/jaVotou/'+grupo_id,
        function(response){
          if(response !== true){
            $.getJSON('/restaurantes/search/'+grupo_id,
              function(response) {
                $("div#area_votacao").html(response);
              }
            );
          } else {

          }
        });
    }
  });
});
