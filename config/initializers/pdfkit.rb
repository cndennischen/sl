# Set up PDFKit for exporting sketches
PDFKit.configure do |config|
  # Set the path to PDFKit, adjust depending on host
  config.wkhtmltopdf = Rails.root.join('bin', 'wkhtmltopdf-amd64').to_s if Rails.env == 'production'
  config.default_options = {
    :print_media_type => true, # So that css can detect it
    :encoding => 'utf-8' # So check marks come out ok
  }
end
