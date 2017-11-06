PDFKit.configure do |config|
	if File.executable? '/app/.apt/usr/local/bin/wkhtmltopdf'
		config.wkhtmltopdf = '/app/.apt/usr/local/bin/wkhtmltopdf'
	else
		wkhtmltopdf_executable = '/usr/bin/wkhtmltopdf'
		config.wkhtmltopdf = Rails.root.join('bin', wkhtmltopdf_executable).to_s
	end
	config.default_options = { page_size: 'A5', print_media_type: true }
end
