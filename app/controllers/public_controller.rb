class PublicController < ApplicationController
  helper_method :sortable, :sort_column, :sort_direction

  def index
    respond_to do |format|
      format.html do
        @sketches = Sketch.where(:public => true)
          .search(params[:search])
          .order(sort_column + " " + sort_direction)
          .paginate(:per_page => 20, :page => params[:page])
      end
      format.mobile do
        @sketches = Sketch.where(:public => true)
      end
    end
    
  end

  def show
    @sketch = Sketch.find_by_id_and_public(params[:id], true, :include => :user)
    return render_not_found unless @sketch # Make sure the sketch exists
    respond_to do |format|
      format.html # show.html.erb
      # The mobile public page is the same as the regular edit page
      format.mobile { render 'sketch/edit' }
    end
  end

  private

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    view_context.link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end

  def sort_column
    Sketch.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
