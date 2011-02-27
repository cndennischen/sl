PDFKit.configure do |config|
  config.wkhtmltopdf = Rails.root.join('bin', 'wkhtmltopdf-amd64').to_s if RAILS_ENV == 'production'
  config.default_options = {
    :print_media_type => true
  }
end
