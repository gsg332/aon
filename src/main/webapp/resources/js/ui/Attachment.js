function Attachment(id) {
	this.id = id;
	this.model = new AttachmentModel();
	this.view = new SelectView(id);
	this.bClicked = false;
	this.files = new Array();
	this.doClickFile = function() {
		this.bClicked = true;
	}
	this.doAddFile = function(oInput) {
		
		if(oInput.files[0].size>50000000){
			var md = new Modal($(document.body),{'message':i18n.getLang('common','fileSizeExceed'),'title':'Alert','error':function(){}});
			md.show();
			return false;
		}

		// check double event call
		if (!this.bClicked) {
			event.cancelBubble = true;
			return;
		}
		this.bClicked = false;
		this.files[this.files.length] = this.model.nSequence;
		// hide previous button, make and show new upload button
		var oNewInput = oInput.cloneNode(true);
		oInput.style.display = 'none';
		oInput.parentElement.appendChild(oNewInput);
		this.doAdd(new ClientFile(oInput));
	}

	this.doAddServerFile = function(attachments) {
		if(attachments==null || attachments.length == 0)
			return;
		for (var i = 0; i < attachments.length; i++) {
			this.doAdd(new ServerFile(attachments[i]));
		}
	}

	this.doAdd = function(oAttachment) {
		this.model.add(oAttachment);
		if (this.id != null) {
			this.view.add(oAttachment.sFilename, oAttachment.nId);
		}
	}
	this.doDelete = function() {
		var values = this.view.values();

		for (var i = 0; i < values.length; i++) {
			var att = this.model.get(values[i]);
			if (att instanceof ClientFile) {
				this.model.remove(values[i]);
				for (var j = 0; j < this.files.length; j++) {
					if (this.files[j] == values[i]) {
						this.files.splice(j, 1);
					}
				}
			} else {
				// model에 표기만 delete처리 한다.
				var serverAttachment = this.model.get(values[i]);
				serverAttachment.method = "delete";
			}
		}
		this.view.remove();
	}
	this.doSubmit = function(elements) {
		for (var i = 0; i < this.model.files.length; i++) {
			// 클라이언트 파일의 이름을 바꾸낟.
			var client = this.model.files[i];
			if (client instanceof ClientFile) {
				this.model.files[i].submit(elements, this.id + '_file' + i);
				elements.append($('<input type=hidden>').attr('name',
						this.id + '[' + i + ']' + '.filename').attr('value',
						client.sFilename));
				elements.append($('<input type=hidden>').attr('name',
						this.id + '[' + i + ']' + '.path').attr('value',
						this.id + '_file' + i));
				elements.append($('<input type=hidden>').attr('name',
						this.id + '[' + i + ']' + '.type').attr('value', '1'));
				elements.append($('<input type=hidden>').attr('name',
						this.id + '[' + i + ']' + '.method').attr('value',
						'copy'));
			} else {
				elements.append($('<input type=hidden>').attr('name',this.id + '[' + i + ']' + '.id')
						.attr('value',client.id));
				elements.append($('<input type=hidden>').attr('name',this.id + '[' + i + ']' + '.method')
						.attr('value',client.method));
				elements.append($('<input type=hidden>').attr('name',this.id + '[' + i + ']' + '.type')
						.attr('value',client.type));
				elements.append($('<input type=hidden>').attr('name',this.id + '[' + i + ']' + '.path')
						.attr('value',client.path));
			}
		}
	}

}

function AttachmentModel(sId) {
	this.files = new Array();
	this.nSequence = 0;// sequence to generate unique id
	this.add = function(oAttachment) {
		oAttachment.nId = this.nSequence++;
		this.files[this.files.length] = oAttachment;
	}
	this.remove = function(nId) {
		for (var i = 0; i < this.files.length; i++) {
			if (this.files[i].nId == nId) {
				if (this.files[i].remove()) {
					var att = this.files[i];
					var aPre = this.files.slice(0, i);
					var aPost = this.files.slice(i + 1);
					this.files = aPre.concat(aPost);

					return att;
				}
			}
		}
		return null;
	}

	this.get = function(nId) {
		for (var i = 0; i < this.files.length; i++) {
			if (this.files[i].nId == nId) {
				return this.files[i];
			}
		}
		return null;
	}

	this.getFile = function(nId) {
		for (var i = 0; i < this.files.length; i++) {
			if (this.files[i].nId == nId) {
				return this.files[i].oLink.value;

			}
		}
	}
}

function ClientFile(oLink) {
	this.nId = 0;
	this.sFilename = jcontext.getFileName (oLink.value);
	this.oLink = oLink;
	this.remove = function() {
		this.oLink.remove();
		return true;
	}
	this.submit = function(oForm, sName) {
		this.oLink.name = sName;
	}
}

function ServerFile(attachment) {
	this.nId = 0;
	this.id = attachment.id;
	this.sFilename = attachment.filename;
	this.method = '';
	this.type = attachment.type;
	this.path = attachment.path;
}

function SelectView(sId) {
	this.sId = sId;// id of the <select> tag

	this.add = function(sText, sValue, bSelect) {
		var sel = $('#' + this.sId).get(0);// document.getElementById(this.sId);
		sel.options.add(new Option(sText, sValue));
		if (bSelect) {
			sel.selectedIndex = sel.options.length - 1;
		}
	}

	this.contains = function(sValue) {
		var sel = $('#' + this.sId).get(0);// document.getElementById(this.sId);
		for (var i = 0; i < sel.options.length; i++) {
			if (sel.options[i].value == sValue) {
				sel.selectedIndex = i;
				return true;
			}
		}
		return false;
	}

	this.values = function() {
		var values = new Array();
		var sel = $('#' + this.sId).get(0);// document.getElementById(this.sId);

		for (var i = 0; i < sel.options.length; i++) {
			if (sel.options[i].selected) {
				values[values.length] = sel.options[i].value;
			}
		}
		return values;
	}

	this.getValue = function() {
		var sel = $('#' + this.sId).get(0);// document.getElementById(this.sId);
		for (var i = 0; i < sel.options.length; i++) {
			if (sel.options[i].selected) {
				return sel.options[i].value;
			}
		}
		return null;
	}

	this.remove = function() {
		var sel = $('#' + this.sId).get(0);// document.getElementById(this.sId);
		for (var i = sel.options.length; i > 0; i--) {
			if (sel.options[i - 1].selected) {
				sel.options.remove(i - 1);
			}
		}
	}

	this.getText = function(sValue) {
		var sel = $('#' + this.sId).get(0);// document.getElementById(this.sId);
		for (var i = 0; i < sel.options.length; i++) {
			if (sel.options[i].value == sValue) {
				return sel.options[i].text;
			}
		}
		return null;
	}

	this.removeAll = function() {
		var sel = $('#' + this.sId).get(0);// document.getElementById(this.sId);
		for (var i = sel.options.length; i > 0; i--) {
			sel.options.remove(i - 1);
		}
	}

	this.select = function(sValue) {
		var sel = $('#' + this.sId).get(0);// document.getElementById(this.sId);
		for (var i = 0; i < sel.options.length; i++) {
			if (sel.options[i].value == sValue) {
				sel.options[i].selected = true;
			}
		}
	}

	this.moveUp = function() {
		var sel = $('#' + this.sId).get(0);// document.getElementById(this.sId);
		for (var i = 1; i < sel.options.length; i++) {
			if (sel.options[i].selected && !sel.options[i - 1].selected) {
				var oUp = sel.options[i - 1];
				var oDown = sel.options[i];
				this._swap(oUp, oDown);
			}
		}
	}

	this.moveDown = function() {
		var sel = $('#' + this.sId).get(0);// document.getElementById(this.sId);
		for (var i = sel.options.length - 1; i > 0; i--) {
			if (!sel.options[i].selected && sel.options[i - 1].selected) {
				var oUp = sel.options[i - 1];
				var oDown = sel.options[i];
				this._swap(oUp, oDown);
			}
		}
	}

	this._swap = function(oUp, oDown) {
		var tempValue = oUp.value;
		var tempText = oUp.text;
		var tempSelected = oUp.selected;
		oUp.value = oDown.value;
		oUp.text = oDown.text;
		oUp.selected = oDown.selected;
		oDown.value = tempValue;
		oDown.text = tempText;
		oDown.selected = tempSelected;
	}
}
