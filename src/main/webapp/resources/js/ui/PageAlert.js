function PageAlert(style){
	//type의 종류는 success/info/waring/danger
	this.style = style || {};
	this.$widget = $('<div class="alert alert-'+(this.style.type||'info')+' page-alert">\
	        <button type="button" class="close"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>\
	        <strong>'+(this.style.title||'TITLE')+'</strong> '+(this.style.message||' empty message')+'.\
	    </div>');
	this.$widget.hide().appendTo($('#alert-div'));
	this.$widget.slideDown();
    this.$close = this.$widget.closest('.page-alert');
    this.$close.click(function(e) {
        e.preventDefault();
        $(this).closest('.page-alert').slideUp();
    });
    var component = this.$widget;
    this.timeOut;
    var delay = 3000;
    if(delay != undefined)
    {
        delay = parseInt(delay);
        clearTimeout(this.timeOut);
        this.timeOut = window.setTimeout(function() {
                component.slideUp();
        }, delay);
    }
}
