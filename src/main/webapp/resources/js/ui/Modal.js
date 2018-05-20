function Modal(parent, style){
	this.style = style || {};
	this.$widget = $('<div class="modal fade"  role="dialog">\
		    <div class="modal-dialog">\
		      <div class="modal-content">\
		        <div class="modal-header">\
		          <button type="button" class="close" data-dismiss="modal">&times;</button>\
		          <h4 class="modal-title">'+this.style.title +'</h4>\
		        </div>\
		        <div class="modal-body">\
		          <p>'+this.style.message+'</p>\
		        </div>\
		        <div class="modal-footer">\
		          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>\
		        </div>\
		      </div>\
		    </div>\
		  </div> ');
	this.$widget.appendTo(parent);
	var error = this.style.error;
	this.$widget.on('hidden.bs.modal', function () {
		if(error)
			error();
		else
			history.back();
	});
}
Modal.prototype.show = function(){
	this.$widget.modal();
}
