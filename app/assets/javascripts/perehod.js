$(document).on('ready',function () {
    var radios = document.getElementsByName("regtype");
// var show = document.getElementsById("show");
    var cardpayment = document.getElementById("Individual_registration_block");
    var internetpayment = document.getElementById("Corporate_registration_block");
    var hiding = document.getElementById("hiding");
    for (var i = 0; i < radios.length; i++) {
        radios[i].onclick = function () {
            var val = this.value;
            if (val == 'fiz') {  // Assuming your value for radio buttons is radio1, radio2 and radio3.
                cardpayment.style.display = 'block';   // show
                hiding.style.display = 'none';// hide
                internetpayment.style.display = 'none';// hide
            }
            else if (val == 'jur') {
                hiding.style.display = 'none';
                cardpayment.style.display = 'none';
                internetpayment.style.display = 'block';
            }

        }
    }
})