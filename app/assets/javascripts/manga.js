$(function(){
    $('.manga').each(function(){

        let manga = $(this);
        manga.children('ul').append($('<div>').css({'clear':'both'}));
        let element_width=756;
        manga.attr('current_page',0);

        set_manga_style(manga,element_width);



        $(this).on('click',function(e){
            if(manga.width()<element_width){
                if(e.clientX<manga.width()/2){
                    slide_left(manga);
                }else{
                    slide_right(manga);
                }
            }
        })

        $(window).on('load resize',function(){
            set_manga_style(manga,element_width);
            manga.show();
        });

        function slide_left(el){
            if(current_page(el)>0){
                set_current_page(el,false);
                slide_out(el);
            }
        }
        function slide_right(el){
            if(current_page(el)<el.children('ul').children('li').length-1){
                set_current_page(el,true);
                slide_out(el);
            }
        }

        function slide_out(el){
            el.children('ul').css({'left':-(current_page(el)*el.width())+'px'})
        }
        function set_current_page(el,flag){
            el.attr('current_page',flag ? Number(el.attr('current_page'))+1: Number(el.attr('current_page'))-1);
        }

        function current_page(el){
            return Number(el.attr('current_page'));
        }


        function set_manga_style(manga,element_width){
            manga.attr('current_page','0');
            let w_width=$(window).width();
            set_manga_div_style(manga,element_width,w_width);
            set_manga_ul_style(manga,element_width,w_width);
            set_manga_li_style(manga,element_width,w_width);  
            set_manga_arrow_style(manga,element_width,w_width);
        }

        function set_manga_arrow_style(el,element_width,w_width){
            el.children('ul').children('li').each(function(){
                let li_height = $(this).height();
                $(this).children('img').each(function(){
                    $(this).css({"width":"70px",'position':'relative','top':(li_height-50)+'px'})
                    if(w_width<element_width){
                        $(this).show();
                    }else{
                        $(this).hide();
                    }
                })
            })
        }

        function set_manga_li_style(el,element_width,w_width){
            let ul_width = el.children('ul').width();
            console.log(ul_width<element_width);
            if(el.width()<element_width){
                el.children('ul').children('li').css({
                    'flex':'1',
                    'float':'none',
                    'height':el.width()/1.85+'px',
                    'margin':'0'
                })
            }else{
                el.children('ul').children('li').css({
                    'width':(ul_width/2-10)+'px',
                    'height':el.width()/(1.85*2)+'px',
                    'margin':'10px'
                })
                el.children('ul').children('li:nth-child(2n)').css({
                    'margin-right':'0',
                    'float':'right'
                })
                el.children('ul').children('li:nth-child(2n+1)').css({
                    'margin-left':'0',
                    'float':'left'
                })
            }
            
            el.children('ul').children('li').css({
                'background-repeat':'no-repeat',
                'background-size':'contain',
            })
        }

        function set_manga_ul_style(el,element_width,w_width){
            if(w_width<element_width){
                el.children('ul').css({
                    'width':el.width()*el.children('ul').children('li').length+'px',
                    'display':'flex'
                });
            }else{
                el.children('ul').css({
                    'width':element_width+'px',
                    'display':'block',
                    'background-image':'url(./static/z.png)',
                    'background-size':'25%',
                    'background-position':'50%',
                    'background-repeat':'no-repeat'
                })
            }
            el.children('ul').css({
                'list-style':'none',
                'padding':'0',
                'position':'relative',
                'left':'0px',
                'transition':'left 0.5s ease'
            })
        }

        function set_manga_div_style(el,element_width,w_width){
            if(w_width<element_width){
                el.css({'width':'90%'});
            }else{
                el.css({'width':element_width+'px'});
            }
            el.css({
                'overflow':'hidden',
                'margin':'0 auto'
            })
        }
    })
})