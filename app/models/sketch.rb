class Sketch < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :name
  validates_length_of :name, :minimum => 3, :maximum => 25

  def to_img(format)
    # create an image from the pdf with RMagick
    img = Magick::ImageList::new(to_pdf)
    #TODO: return the image in the specified format, ready to be sent to the user
  end

  def to_pdf
    # create the html and convert it to a pdf with pdfkit
    options = { :header_center => name }
    if user.plan == 'free'
      options[:footer_center] = 'Created with the Sketch Lab free plan (sketchlabhq.com)'
    end
    options[:header_font_size] = '30'
    # create a new PDFKit object with the set options
    pdf = PDFKit.new(to_html, options)
    pdf.stylesheets << "#{Rails.root}/public/stylesheets/widgets.css"
    pdf.to_pdf
  end

  private

  # This mehod creates an HTML version of the sketch. It is private because it it only meant to be used to generate
  # HTML for PDFKit to convert to PDF format. Therefore it is not made / tested for cross-browser compatibility.
  def to_html
    html = ""
    # iterate through widgets
    JSON.parse(content).each do |key, value|
      html += "<div class='widget #{value['class']}' style='#{value['style']}'><div class='text'>#{value['text']}</div></div>"
    end

    # return the generated html
    html
  end

end
