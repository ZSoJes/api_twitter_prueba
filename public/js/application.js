$(document).ready(function() {


   var screen_ancho = screen.availWidth;
    if ($(window).width() < screen_ancho/2 )
      $(".head").animate({ opacity: 0 },0);

  $("form").on("submit",function(event){
    if ($("#tuit").val() == ""){
        // event.preventDefault();
        $("#myModal").css("display","block");
    }
    // else{
    //   var url = $("form").attr( "action" );
    //   $.post(url,$("form").serialize().done(function(){
    //     alert("Tuit enviado");
    //   }));
    // }
  });

  $("span.close,body").click(function(){
      $("#myModal").css("display","none");
  });

  $(window).resize(function(){
    //aqui el codigo que se ejecutara cuando se redimencione la ventana
     var ancho=$(window).width();
    if (ancho < screen_ancho/2 ){
      $(".head").animate({ opacity: 0 },0);
    }else{
      $(".head").animate({ opacity: 1 },500);
    }
  })
});