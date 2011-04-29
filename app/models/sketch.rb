class Sketch < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  validates_presence_of :name, :user_id
  validates_length_of :name, :maximum => 25

  # Returns the sketches that match the specified search term
  def self.search(search)
    if search
      where(:name.matches => "%#{search}%")
    else
      scoped
    end
  end

  # Exports the sketch to an image with the specified format
  def to_img(format)
    # Create an image from the pdf with RMagick
    img = Magick::Image.from_blob(to_pdf)[0]
    # Return the image in the specified format, ready to be sent to the user
    img.format = format
    img.to_blob
  end

  # Exports the sketch to a PDF documeent
  def to_pdf
    # Create the HTML code and convert it to a PDF with PDFKit

    # Display the sketch name as a header
    options = { :header_center => name }
    # Display the user's plan as a footer unless she's a paid user
    if user.plan != 'paid'
      options[:footer_center] = "Created with the Sketch Lab #{user.plan} plan (sketchlabhq.com)"
    end
    # Set the font size
    options[:header_font_size] = '20'
    # Create a new PDFKit object with the set options
    pdf = PDFKit.new(to_html, options)
    # Add the widget stylesheet
    pdf.stylesheets << "#{Rails.root}/public/stylesheets/widgets.css"
    # Return the created PDF as a blob
    pdf.to_pdf.to_blob
  end

  private

  # Creates an HTML version of the sketch. It is private because it is
  # only meant to be used to generate HTML for PDFKit to convert to PDF format.
  # Therefore it is not made / tested for cross-browser compatibility.
  def to_html
    html = ""
    # Iterate through the widgets
    JSON.parse(content).each do |key, value|
      html += "<div class='widget #{value['class']}' style='#{value['style']}'><div class='text'>#{value['text']}</div></div>"
    end

    # Return the generated html
    html
  end

end
