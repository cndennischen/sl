module HomeHelper
  def sketch_name_validation_errors
    # create the html validation errors
    html = <<HTML
<div id="nullError" class="validationError">Please enter a name</div>
<div id="lengthError" class="validationError">Sketch name cannot be more than 25 characters</div>
HTML
    html.html_safe
  end

  def validates_sketch_names(type = "new")
    # create js validations for the sketch name
    html = <<HTML
<script type="text/javascript">
function validate() {
  if ($("#name").val() == "") {
    $("#name").addClass("field_with_errors");
    $("#lengthError").hide();
    $("#nullError").show();
    return false;
  } else if ($("#name").val().length > 25) {
    $("#name").addClass("field_with_errors");
    $("#nullError").hide();
    $("#lengthError").show();
    return false;
  } else {
HTML
    if type == 'rename'
      html += <<HTML
    rename();
    return false;
  }
}
HTML
    else
      html += <<HTML
    return true;
  }
}
HTML
    end
    html += "</script>"
    html.html_safe
  end

end
