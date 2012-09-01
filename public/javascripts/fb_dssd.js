function add_like(id,user_id){

    var text = document.getElementById('like'+id).innerHTML;
    var url = "";
    if (text.search("Like") != -1)
    {
        url = '/users/like_content?user_id='+user_id+'&post_id='+id;
    }
    else
    {
        url = '/users/unlike_content?user_id='+user_id+'&post_id='+id;
    }
    $.ajax({
        url: url,
        success: function(data){
            if (text.search("Like") != -1)
            {
                if (data != 0)
                {
                    
                    document.getElementById('numlikes'+id).innerHTML = data+' Likes';
                }
                else
                {
                    document.getElementById('numlikes'+id).innerHTML = '';
                }
                document.getElementById('like'+id).innerHTML = 'Unlike';
            }
            else
            {
                if (data != 0)
                {

                    document.getElementById('numlikes'+id).innerHTML = data+' Likes';
                }
                else
                {
                    document.getElementById('numlikes'+id).innerHTML = '';
                }
                document.getElementById('like'+id).innerHTML = 'Like';
            }
        }
    });
}
function add_comment_like(id,user_id){

    var text = document.getElementById('comment_like'+id).innerHTML;
    var url = "";
    if (text.search("Like") != -1)
    {
        url = '/users/like_comment?user_id='+user_id+'&comment_id='+id;
    }
    else
    {
        url = '/users/unlike_comment?user_id='+user_id+'&comment_id='+id;
    }
    $.ajax({
        url: url,
        success: function(data){
            if (text.search("Like") != -1)
            {
                if (data != 0)
                {

                    document.getElementById('numcommentlikes'+id).innerHTML = data+' Likes';
                }
                else
                {
                    document.getElementById('numcommentlikes'+id).innerHTML = '';
                }
                document.getElementById('comment_like'+id).innerHTML = 'Unlike';
            }
            else
            {
                if (data != 0)
                {

                    document.getElementById('numcommentlikes'+id).innerHTML = data+' Likes';
                }
                else
                {
                    document.getElementById('numcommentlikes'+id).innerHTML = '';
                }
                document.getElementById('comment_like'+id).innerHTML = 'Like';
            }
        }
    });
}
function unsubscribe(post_id,user_id,feed_type){

    if (feed_type == 'all')
    {
        var text = document.getElementById('unsub_all'+post_id).innerHTML;
        var url = "";
        if (text.search("Unsubscribe all updates") != -1)
        {
            url = '/users/unsubscribe_all?user_id='+user_id;
        }
        else
        {
            url = '/users/subscribe_all?user_id='+user_id;
        }
        $.ajax({
            url: url,
            success: function(data){
                if (text.search("Unsubscribe all updates") != -1)
                {
                    document.getElementById('unsub_all'+post_id).innerHTML = 'Subscribe all updates';
                }
                else
                {
                    document.getElementById('unsub_all'+post_id).innerHTML = 'Unsubscribe all updates';;
                }
            }
        });
    }
    else if (feed_type == 'status')
    {
        var text = document.getElementById('unsub_status'+post_id).innerHTML;
        var url = "";
        if (text.search("Unsubscribe status updates") != -1)
        {
            url = '/users/unsubscribe_status?user_id='+user_id;
        }
        else
        {
            url = '/users/subscribe_status?user_id='+user_id;
        }
        $.ajax({
            url: url,
            success: function(data){
                if (text.search("Unsubscribe status updates") != -1)
                {
                    document.getElementById('unsub_status'+post_id).innerHTML = 'Subscribe status updates';
                }
                else
                {
                    document.getElementById('unsub_status'+post_id).innerHTML = 'Unsubscribe status updates';;
                }
            }
        });
    }
    else if (feed_type == 'photo')
    {
        var text = document.getElementById('unsub_photo'+post_id).innerHTML;
        var url = "";
        if (text.search("Unsubscribe photo updates") != -1)
        {
            url = '/users/unsubscribe_photo?user_id='+user_id;
        }
        else
        {
            url = '/users/subscribe_photo?user_id='+user_id;
        }
        $.ajax({
            url: url,
            success: function(data){
                if (text.search("Unsubscribe photo updates") != -1)
                {
                    document.getElementById('unsub_photo'+post_id).innerHTML = 'Subscribe photo updates';
                }
                else
                {
                    document.getElementById('unsub_photo'+post_id).innerHTML = 'Unsubscribe photo updates';;
                }
            }
        });
    }
    else if (feed_type == 'video')
    {
        var text = document.getElementById('unsub_video'+post_id).innerHTML;
        var url = "";
        if (text.search("Unsubscribe video updates") != -1)
        {
            url = '/users/unsubscribe_video?user_id='+user_id;
        }
        else
        {
            url = '/users/subscribe_video?user_id='+user_id;
        }
        $.ajax({
            url: url,
            success: function(data){
                if (text.search("Unsubscribe video updates") != -1)
                {
                    document.getElementById('unsub_video'+post_id).innerHTML = 'Subscribe video updates';
                }
                else
                {
                    document.getElementById('unsub_video'+post_id).innerHTML = 'Unsubscribe video updates';;
                }
            }
        });
    }

}
function add_unfollow(id,user_id){

    var text = document.getElementById('unfollow'+id).innerHTML;
    var url = "";
    if (text.search("Unfollow") != -1)
    {
        url = '/users/unfollow_content?user_id='+user_id+'&post_id='+id;
    }
    else
    {
        url = '/users/follow_content?user_id='+user_id+'&post_id='+id;
    }
    $.ajax({
        url: url,
        success: function(data){
            if (text.search("Unfollow") != -1)
            {
                document.getElementById('unfollow'+id).innerHTML = 'Follow';
            }
            else
            {
                document.getElementById('unfollow'+id).innerHTML = 'Unfollow';
            }
        }
    });
}
function insert_comment(post_id){
    var comment = document.getElementById('insert_comment'+post_id).value;
    if (comment == '')
    {
        return 0;
    }
    var url = "/users/add_comment?&post_id="+post_id+"&comment="+comment;

    $.ajax({
        url: url,
        success: function(data){
            var comments_obj = document.getElementById('existingcomments'+post_id);
            var new_element = document.createElement("div");
            var comm_id = "commentabc";
            var innerhtml = data+"<br/>"+comment+"<br/><a>Like</a><hr/>";
            new_element.id = comm_id;
            new_element.innerHTML = innerhtml;
            document.getElementById('insert_comment'+post_id).value = "";
            comments_obj.appendChild(new_element);
        }
    });

}