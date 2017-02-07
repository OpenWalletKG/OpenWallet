//Объявим переменную
var stopTimer;
//Функция для старта 
function testTimer(startTime) {
//для повторного запуска очистим rezult
document.getElementById("rezult").innerHTML = '';
//выключим кнопку запуска
var bot = document.getElementById("bot");
bot.setAttribute("disabled","");
//сколько будет длится обратный отчет
var time = startTime;
//определим сколько минут
var min = parseInt(time / 60);
if ( min < 1 ) min = 0;
  time = parseInt(time - min * 60);
if ( min < 10 ) min = '0'+min;
//определим сколько секунд
var seconds = time;
if ( seconds < 10 ) seconds = '0'+seconds;
//отрисовываем время
document.getElementById("time").innerHTML='<span>Осталось времени- '+min+' мин '+seconds+' секунд</span>';
//уменьшаем общее время на одну секунду
startTime--;
//смотрим время не закончилось
if ( startTime  >= 0 ) {
    //если нет то повторяем процедуру заново
       stopTimer  =  setTimeout(function(){testTimer(startTime); }, 1000);
     //если закончилось, то выводим сообщение на экран, и делаем кнопку запуска активной
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
//Функция для остановки обратного отчета
function stop(){
  //очистим переменную с таймером
  clearTimeout(stopTimer);
  //и включим кнопку запуска
  var bot = document.getElementById("bot");
  bot.removeAttribute("disabled","disabled");
}