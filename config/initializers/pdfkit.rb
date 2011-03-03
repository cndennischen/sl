PDFKit.configure do |config|
  config.wkhtmltopdf = '/usr/local/bin/wkhtmltopdf'
  config.default_options = {
    :print_media_type => true,
    :encoding => 'utf-8'
  }
end
