$(function(){
    $('.voices').each(function(){
        let voices = $(this);
        let element_width=756;

        $(window).on('load resize',function(){
            set_voices_style(voices,element_width);
            set_voices_ul_style(voices,element_width);
            set_voices_li_style(voices,element_width);
        })

        function set_voices_li_style(el,element_width){
            if(is_small(element_width)){
                el.children('ul').children('li').css({
                    'width':(el.width()/2-4)+'px'
                })
            }else{
                el.children('ul').children('li').css({
                    'width':(el.width()/3-6)+'px'
                }) 
            }
            el.children('ul').children('li').css({
                'float':'left',
                'padding':'5px 20px',
                'margin':'10px 1px',
                'color':'gray',
                'border-radius':'20px',
                'box-sizing':'border-box',
                'border':'solid 2px darkgreen'
            })

            el.children('ul').children('li').each(function(){
                if(is_small(element_width)){
                    if(Math.round($(this).position().left)>100){
                        $(this).css({'float':'right'});
                    }
                }else{
                    if(Math.round($(this).position().left)>756/2){
                        $(this).css({'float':'right'});
                    }
                }
            })
            
        
        }

        function set_voices_ul_style(el,element_width){
            if(is_small(element_width)){

            }else{

            }
            el.children('ul').css({
                'list-style':'none',
                'width':'100%',
                'padding':'0'
            })
        }

        function set_voices_style(el,element_width){
            
            if(is_small(element_width)){
                el.css({'width':'90%'})
            }else{
                el.css({'width':element_width+'px'})
            }
            
            el.css({
                'margin':'0 auto'
            })
            
        }


        function is_small(element_width){
            return $(window).width()<element_width;
        }
    })
})