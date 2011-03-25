function percentToPx(widget) {
	if (widget) {
		switch($(widget).attr("class").split(' ')[1]) {
			case "ellipse": {
				borderRadius(this, $(this).width() / 2);
				break;
			}
			case "rounded-rectangle": {
				borderRadius(this, $(this).width() / 10);
				break;
			}
			case "button": {
				borderRadius(this, $(this).width() / (20 / 3));
				break;
			}
		}
	} else {
		$(".elipse, .radio").each(function(index) {
			borderRadius(this, $(this).width() / 2);
		});
		
		$(".rounded-rectangle").each(function(index) {
			borderRadius(this, $(this).width() / 10);
		});
		
		$(".button").each(function(index) {
			borderRadius(this, $(this).width() / (20 / 3));
		});
		
		$(".checkbox").each(function(index) {
			borderRadius(this, $(this).width() / 20);
		});
	}
}

function borderRadius (widget, value) {
	$(widget).css("-moz-border-radius", value);
	$(widget).css("-webkit-border-radius", value);
	$(widget).css("border-radius", value);
}
