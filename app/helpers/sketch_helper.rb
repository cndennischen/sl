module SketchHelper
  def public_or_private
    if @sketch.public
      'Public'
    else
      'Private'
    end
  end
end
