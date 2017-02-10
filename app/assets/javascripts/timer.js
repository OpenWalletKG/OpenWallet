var stopTimer;
function testTimer(startTime) {
document.getElementById("rezult").innerHTML = '';
var bot = document.getElementById("bot");
bot.setAttribute("disabled","");
var time = startTime;
	var min = parseInt(time / 60);
	if ( min < 1 ) min = 0;
	  time = parseInt(time - min * 60);
	if ( min < 10 ) min = '0'+min;
	var seconds = time;
	if ( seconds < 10 ) seconds = '0'+seconds;
	document.getElementById("time").innerHTML='<span>Осталось времени- '+min+' мин '+seconds+' секунд</span>';
	startTime--;
		if ( startTime  >= 0 ) {
		       stopTimer  =  setTimeout(function(){testTimer(startTime); }, 1000);
		  } else {
		     document.getElementById("time").innerHTML='<span>Осталось времени- 00 мин 00 секунд</span>';
		     var rezult = document.getElementById("rezult");
		     rezult.innerHTML ="Время вышло";
		     clearTimeout(stopTimer);
		     var bot = document.getElementById("bot");
		     bot.removeAttribute("disabled","disabled");
		     bot.removeChild(bot.childNodes[0]);
		     var text = document.createTextNode("Отправить повторно");
		     bot.appendChild(text);
   }
}
function stop(){
  clearTimeout(stopTimer);
  var bot = document.getElementById("bot");
  bot.removeAttribute("disabled","disabled");
}