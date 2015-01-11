var isOpen = false;
$(document).ready(function(){
    $("#btnToggle").click(function(){
        if (isOpen == true)
        {
            //close it
            $("#slidingDiv").slideUp();
            isOpen = false;
        }  else
        {
            //open it
            $("#slidingDiv").slideDown();
            isOpen = true;
        }
    });
});


