$(function () {
  $("#birds").keyup(function(){
	  $.ajax({
		  url: "/searchs",
		  data: {valor: $(this).val()},
		}).done(function(data) {
			console.log(data.sugestoes);		
			mount_question(data.questions);
		});
	});
})

function mount_question(questions){
	$("#question_list li").remove();
	$(questions).each(function() {
  	$("#question_list").append('<li><a href="https://nameless-sea-78060.herokuapp.com/questions/'+this.id+'"><span class="tab">'+this.title+'</span></a></li>');
	});
}

$(function (){
	$('#birds').autocomplete({
    source: function (request, response) {
      $.getJSON("/searchs?valor=" + request.term, function (data) {
      	console.log(data);
        response($.map(data.sugestoes, function (value, key) {
          return {
            label: request.term + " " + value,
            value: request.term + " " + value
          };
        }));
      });
    },
    minLength: 2,
    delay: 100
	});
});