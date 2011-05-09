# More info at https://github.com/guard/guard#readme

guard 'bundler' do
  watch('Gemfile')
  # Uncomment next line if Gemfile contain `gemspec' command
  # watch(/^.+\.gemspec/)
end

guard 'passenger', :standalone => false, :ping => true do
  watch(/^lib\/.*\.rb$/)
  watch(/^config\/.*\.rb$/)
end

guard 'jammit' do
  watch(/^public\/javascripts\/(.*)\.js/)
  watch(/^public\/stylesheets\/(.*)\.css/)
end

guard 'rspec', :version => 2 do
  watch(%r{^spec/.+_spec\.rb})
  watch(%r{^lib/(.+)\.rb})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb') { "spec" }
  watch(%r{^spec/.+_spec\.rb})
  watch(%r{^app/(.+)\.rb})     { |m| "spec/#{m[1]}_spec.rb" }
end
