module HomeHelper
  def getSketch(id)
    # get the users sketches
    data = JSON.parse(current_user.sketches)
    if result.has_key? "id"
      return data["id"]
    end
  end
  
end
