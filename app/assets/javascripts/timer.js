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
// ++
var stopTimer; 
function testTimer1(startTime1) {
document.getElementById("rezult1").innerHTML = '';
var bot = document.getElementById("bot1");
bot.setAttribute("disabled","");
var time = startTime1;
var min = parseInt(time / 60);
	if ( min < 1 ) min = 0;
	  time = parseInt(time - min * 60);
	if ( min < 10 ) min = '0'+min;
	var seconds = time;
	if ( seconds < 10 ) seconds = '0'+seconds;
	document.getElementById("time1").innerHTML='<span>Осталось времени- '+min+' мин '+seconds+' секунд</span>';
	startTime1--;
		if ( startTime1  >= 0 ) {
		       stopTimer1  =  setTimeout(function(){testTimer1(startTime1); }, 1000);
		  } else {
		     document.getElementById("time1").innerHTML='<span>Осталось времени- 00 мин 00 секунд</span>';
		     var rezult1 = document.getElementById("rezult1");
		     rezult1.innerHTML ="Время вышло";
		     clearTimeout(stopTimer1);
		     var bot1 = document.getElementById("bot1");
		     bot1.removeAttribute("disabled","disabled");
		     bot1.removeChild(bot1.childNodes[0]);
		     var text = document.createTextNode("Отправить повторно");
		     bot1.appendChild(text);
   }
}
function stop(){
  clearTimeout(stopTimer1);
  var bot1 = document.getElementById("bot1");
  bot1.removeAttribute("disabled","disabled");
}