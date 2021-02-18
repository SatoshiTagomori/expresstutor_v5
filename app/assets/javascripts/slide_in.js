$(function(){
    $('.slide_in').each(function(){
        let slide_in = $(this);
        let element_width=756;

        $(window).on('scroll',function(){
            if(is_scroll_nearby(slide_in)){
                slide_in.children('.slide_row').css({
                    'left':'0px'
                })
            }else{
                slide_in.children('.slide_row').css({
                    'left': $(this).width()+'px'
                })
            }
        })

        $(window).on('load resize',function(){
            set_slide_in_style(slide_in,element_width);
            set_slide_row_style(slide_in,element_width);
            set_slide_p_style(slide_in,element_width);
        })

        function set_slide_p_style(el,element_width){
            el.children('.slide_row').children('p').css({
                'transform':'rotate(-2deg)',
                'font-size':'30px',
                'width':el.width()+'px',
                'text-align':'center',
                'font-weight':'bold'
            })
            el.children('.slide_row').children('p').children('strong').css({
                'font-size':'40px',
                'color':'orange'
            })
        }

        function is_scroll_nearby(el){
            return (el.context.offsetTop<$(window).height()+$(window).scrollTop()) 
        }

        function set_slide_row_style(el,element_width){
            el.children('.slide_row').css({
                'width':el.width()*2+'px',
                'position':'relative',
                'left': el.width()+'px',
                'transition':'left 0.5s ease'
            })
        }

        function set_slide_in_style(el,element_width){
            if(is_small(element_width)){
                el.css({
                    'width':'90%'
                })
            }else{
                el.css({
                    'width':element_width+'px'
                }) 
            }
            el.css({
                'margin':'0 auto',
                'overflow':'hidden',
                'padding-bottom':'20px'
            })

        }

        function is_small(element_width){
            return $(window).width()<element_width;
        }

    })
})