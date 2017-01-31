$(document).on('ready',function () {
//jQuery time
    var current_fs, next_fs, previous_fs; //fieldsets
    var left, opacity, scale; //fieldset properties which we will animate
    var animating; //flag to prevent quick multi-click glitches
    // var val=document.getElementById('client_mobile')
    // $('.form').validate({ // initialize plugin
    //     ignore:":not(:visible)",
    //     rules: {
    //         name : "required"
    //     }
    // });

    $(".next").click(function () {
        // var val=document.getElementById('client_mobile');
        // var val1=document.getElementById('client_email');



        // if ($(".form").valid()){
        // (val.value !== "" && val1.value !== ""){
        if (animating) return false;
        animating = true;

        current_fs = $(this).parent();
        next_fs = $(this).parent().next();

        //activate next step on progressbar using the index of next_fs
        $("#progressbar li").eq($("fieldset").index(next_fs)).addClass("active");

        //show the next fieldset
        next_fs.show();
        //hide the current fieldset with style
        current_fs.animate({opacity: 0}, {
            step: function (now, mx) {
                //as the opacity of current_fs reduces to 0 - stored in "now"
                //1. scale current_fs down to 80%
                scale = 1 - (1 - now) * 0.2;
                //2. bring next_fs from the right(50%)
                left = (now * 50) + "%";
                //3. increase opacity of next_fs to 1 as it moves in
                opacity = 1 - now;
                current_fs.css({
                    'transform': 'scale(' + scale + ')',
                    'position': 'absolute'
                });
                next_fs.css({'left': left, 'opacity': opacity});
            },
            duration: 800,
            complete: function () {
                current_fs.hide();
                animating = false;
            },
            //this comes from the custom easing plugin
            easing: 'easeInOutBack'
        });
        // }
        //
        // else
        // {
        //     alert("Поле не может быть пустым ")
        //
        // }

    });

    $(".previous").click(function () {
        if (animating) return false;
        animating = true;

        current_fs = $(this).parent();
        previous_fs = $(this).parent().prev();

        //de-activate current step on progressbar
        $("#progressbar li").eq($("fieldset").index(current_fs)).removeClass("active");

        //show the previous fieldset
        previous_fs.show();
        //hide the current fieldset with style
        current_fs.animate({opacity: 0}, {
            step: function (now, mx) {
                //as the opacity of current_fs reduces to 0 - stored in "now"
                //1. scale previous_fs from 80% to 100%
                scale = 0.8 + (1 - now) * 0.2;
                //2. take current_fs to the right(50%) - from 0%
                left = ((1 - now) * 50) + "%";
                //3. increase opacity of previous_fs to 1 as it moves in
                opacity = 1 - now;
                current_fs.css({'left': left});
                previous_fs.css({'transform': 'scale(' + scale + ')', 'opacity': opacity});
            },
            duration: 800,
            complete: function () {
                current_fs.hide();
                animating = false;
            },
            //this comes from the custom easing plugin
            easing: 'easeInOutBack'
        });
    });

    $(".submit").click(function () {
        return false;
    });
// var radios = document.getElementsByName("regtype");
// // var show = document.getElementsById("show");
// var cardpayment =  document.getElementById("Maxim");
// var internetpayment =  document.getElementById("Omurbek");
// var hiding =  document.getElementById("hiding");
// for(var i = 0; i < radios.length; i++) {
//     radios[i].onclick = function() {
//         var val = this.value;
//         if(val == 'fiz'){  // Assuming your value for radio buttons is radio1, radio2 and radio3.
//             cardpayment.style.display = 'block';   // show
//             hiding.style.display = 'none';// hide
//             internetpayment.style.display = 'none';// hide
//         }
//         else if(val == 'jur'){
//             hiding.style.display = 'none';
//             cardpayment.style.display = 'none';
//             internetpayment.style.display = 'block';
//         }
//
//     }
// }

// document.getElementById("show").onclick = function() {
// document.getElementById("Maxim").style.display = "block";
// document.getElementById("hiding").style.display = "none";}
})

