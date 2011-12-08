$(document).ready(function(){
  $("select#grupo").change(function(){
    var grupo_id = $(this).find('option:selected').val();
    if(grupo_id !== ""){
      $.getJSON('/votos/jaVotou/'+grupo_id,
        function(response){
          if(response !== true){
            $.getJSON('/restaurantes/search/'+grupo_id,
              function(response) {
                $("ul.opcoes").html('');
                $.each(response, function() {
                    $('votacao').append(
                        "<li class=\"optionRadio opcao\">" +
                        "<input type=\"radio\" value=\""+this.restaurante.id+"\""+
                        "name=\"voto[restaurante_id]\"" +
                        "id=\"voto_restaurante_id_"+this.restaurante.id+"\">" +
                        this.restaurante.nome +
                        "</li>"
                    );
                });
              }
            );
            $("input#voto_grupo_id").val(grupo_id);
          } else {
            $("html body div.container div.hero-unit ").append(
              "<div class=\"alert-message block-message success\">"+
                "<p>Você já votou para 'Onde vamos' no dia de hoje. Obrigado.</p>"+
              "</div>");

          }
        });
    }
  });
});
