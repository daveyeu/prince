require "rubygems"
require "sinatra"
require "haml"
require "sass"

get "/" do
  redirect "/index.html"
end

get "/index.:format" do |format|
  @format = format
  @styles = sass :prince

  html = haml :index

  if format == "pdf"
    IO.popen("prince -v -i html -s views/pdf.css - output/index.pdf", "w") { |f| f.write(html) }
    send_file("output/index.pdf")
  else
    html
  end
end
