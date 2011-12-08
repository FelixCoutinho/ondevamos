$(document).ready(function(){
  $("select#grupo_id").change(function(){
    var grupo_id = $(this).find('option:selected').val();
    if(grupo_id !== ""){
      $.getJSON('/restaurantes/search/'+grupo_id,
      function(response) {
        alert(response);
      }
    );
    }
  });
});
