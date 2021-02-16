$(function(){
    let element_width=756;
    
    $('.carousel').each(function(){
        
        let interval_id;
        let carousel = $(this);
        //最大ページ数を取得
        let max_page=carousel.children('ul').children('li').length;

        //現在のページを属性として設定
        carousel.attr('current_page',0);     
        //クリックしたらスライドする
        carousel.on('click',function(){
            if(typeof interval_id !== 'undefined'){
                clearInterval(interval_id);
            }
            slide_out(carousel,max_page)
        })
        //自動スライド
        auto_slide_out(carousel,max_page);


        $(window).on('load resize',function(){
            //カルーセルのスタイルを指定
            set_carousel_style(carousel,element_width,max_page);
            carousel_text(carousel);
        })
        
    })

    function carousel_text(el){
        setTimeout(function(){
            let current_page = Number(el.attr('current_page'));
            el.children('ul').children('li').eq(current_page).children('pre').css({
                'top':'50px'
            })
        },200)
        
    }

    function auto_slide_out(el,max_page){
        interval_id = setInterval(function(){
            slide_out(el,max_page)
        },2500);
    }

    function slide_out(el,max_page){
        el.find('pre').css({'top':'-100px'});
        el.attr('current_page',Number(el.attr('current_page'))+1);
        if(is_last_page(el,max_page)){
            el.attr('current_page',0);
        }
        el.children('ul').css('left',-el.width()*el.attr('current_page'));
        if(is_last_pre_page(el,max_page) && typeof interval_id !== 'undefined'){
            clearInterval(interval_id);
        }
        carousel_text(el);
    }

    function is_last_pre_page(el,max_page){
        return Number(el.attr('current_page')) === max_page-1;
    }

    function is_last_page(el,max_page){
        return Number(el.attr('current_page')) >= max_page;
    }

    function set_carousel_style(el,element_width,max_page){
        set_carousel_div_style(el,element_width);
        set_carousel_ul_style(el,element_width,max_page);
        set_carousel_li_style(el,element_width,max_page);
        set_carousel_pre_style(el);
    }

    function set_carousel_pre_style(el){
        el.children('ul').children('li').each(function(){
            $(this).children('pre').css({
                'position':'relative',
                'top':'-100px',
                'transition':'top 0.5s ease',
                'font-size':'40px',
                'left':'20px',
                'transform':'rotate(-10deg)',
                'color':'yellow',
                'mix-blend-mode':'color-dodge'
            });
        })
    }

    function set_carousel_li_style(el,element_width,max_page){
        el.children('ul').children('li').css({
            'overflow':'hidden',
            'flex':'1',
            'height':'300px',
            'background-size':'cover',
            'background-position':'50%',
            'overflow-y':'hidden'
        })
    }

    function set_carousel_ul_style(el,element_width,max_page){
        el.children('ul').css({
            'padding':'0',
            'list-style':'none',
            'display':'flex',
            'width': el.width()*max_page+'px',
            'position':'relative',
            'left': -Number(el.attr('current_page'))*el.width()+'px',
            'transition': 'left 0.5s ease'
        })
    }

    function set_carousel_div_style(el,element_width){
        if($(window).width()<element_width){
            el.css({
                'width':'90%'
            })
        }else{
            el.css({
                'width':element_width+'px'
            })
        }
        el.css({
            'clear':'both',
            'margin':'0 auto',
            'overflow':'hidden'
        })  
    }


})