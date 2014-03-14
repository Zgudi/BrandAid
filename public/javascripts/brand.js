$(document).ready(function() {

    $(".pick-a-color").pickAColor();

    $(document).on('click', '.add_brand_optional_element, .add_brand_nested_optional_element', function(){
        var id = $(this).attr("data-id");

        var group_id = ""
        if ($(this).attr("data-group-id")) {
            group_id = $(this).attr("data-group-id")
        }


        var type = $(this).attr("data-type")
        if (type == "colors" || type == "taglines"){
            $(this).hide()
        }

        $.ajax({
            url: '/add_ajax_element',
            data: {group_id:group_id, id:id, type:type}
        }).success(function(data){
            console.warn(data);
            if (data.input_group_id){
                var container = $("body").find(".form_nested_optional_elements_container[data-type='"+data.input_type+"'][data-group-id='"+data.input_group_id+"']");
                var button = $("body").find(".add_brand_nested_optional_element[data-type='"+data.input_type+"'][data-group-id='"+data.input_group_id+"']");
            }else{
                var container = $("body").find(".form_optional_elements_container[data-type='"+data.input_type+"']");
                var button = $("body").find(".add_brand_optional_element[data-type='"+data.input_type+"']");
            }
            container.append(data.input_content);
            button.attr("data-id", parseInt(button.attr("data-id"))+1)

            if (data.input_type == "color") {
                $("#input_brand_colors_"+(parseInt(data.input_id)+1)).pickAColor()
            }
        });
    });

    $(document).on('click', '.remove, .remove_box', function(){
        var array = $(this).attr("id").split("_")
        array.splice(0, 1)
        var id = array.join("_")
        $("#group_"+id).remove()
    });

    $(document).on('click', '#close_colors', function(){
        $(".add_brand_optional_element[data-type='colors']").show();
    });

    $(document).on('click', '#close_taglines', function(){
        $(".add_brand_optional_element[data-type='taglines']").show();
    });
});

