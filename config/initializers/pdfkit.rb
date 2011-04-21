# Set up PDFKit for exporting sketches
PDFKit.configure do |config|
  # Set the path to PDFKit, adjust depending on host
  config.wkhtmltopdf = '/usr/local/bin/wkhtmltopdf'
  config.default_options = {
    :print_media_type => true, # So that css can detect it
    :encoding => 'utf-8' # So check marks come out ok
  }
end
