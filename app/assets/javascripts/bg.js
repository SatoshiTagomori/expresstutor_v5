$(function(){
    let interval_id;
    $(window).on('load resize',function(){
        clearInterval(interval_id);
        bg_wave($(window).width());
    })
    function bg_wave(size){
        let back_svg = $('#back_svg');
        let path = $('#back_path');
        let seed = 0;
        let d = "M 0 0 L 0 400 C 200 350 , 300 350 ,500 400 S 800 450 ,1000 400 L 1000 0";
        let h = 100;

        let base=400;
        if(size<756){
            base=800;
        }
        interval_id = setInterval(function(){
            seed++;
            sin = Math.sin(seed/10/Math.PI);
            //console.log(Math.sin(seed/Math.PI));
            d = "M 0 0 L 0 "+(base+h*sin)+" C 200 "+(base-h*sin)+" , 300 "+(base-h*sin)+" ,500 "+(base)+" S 800 "+(base+h*sin)+" ,1000 "+(base-h*sin)+" L 1000 0"
            back_svg.get(0).setAttribute("viewBox",'0 0 1000 '+base*2);
            path.attr('d',d);
        },40)
    }
})