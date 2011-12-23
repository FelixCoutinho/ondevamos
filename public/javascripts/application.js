$(document).ready(function(){
  $("select#grupo_id").change(function(){
    var grupo_id = $(this).find('option:selected').val();
    if(grupo_id !== ""){
      $('div#area_votacao').load('/votos/jaVotou/'+grupo_id).
        ajaxStart(function() {
          $(this).html("<img src='/images/ajax-loader.gif' />");
      });
    }
  });
  //$('.alert-message.block-message.success').fadeOut(5000);
  /**$("span#nao_autorizado.label").hover(function(){
    $(this).html('Autorizar');
    $(this).toggleClass('success');
  },function(){
    $(this).html('Não autorizado');
    $(this).toggleClass('success');
  });
  $("span#nao_autorizado.label").click(function(){

  });
  $("span#autorizado.label").click(function(){

  });**/
});
