module HomeHelper
	def getSketch(id)
    # get the sketch with the specified id
    sketch = Sketch.find(id)
    # check if the sketch exists
    if sketch
      # make sure the sketch belongs to the current user
      if sketch.user_id = current_user.id
        return sketch.content
      else
        flash[:error] = "You don't own the selected sketch"
        return nil
      end
    else
      flash[:error] = "The selected sketch doesn't exist"
      return nil
    end
  end
=begin
    # get the user's sketches
    data = current_user.sketches
		if data[id]
      return data[id].content
    else
      flash[:error] = "The selected sketch doesn't exist"
      return nil
    end
  end
=end
end
