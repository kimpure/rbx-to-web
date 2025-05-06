local net = require("@lune/net")
local fs = require("@lune/fs")

local css = require("../css/css")

fs.writeFile("tests/web/view/style.css", [[
html, body {
    height: 100%;
    width: 100%;
    margin: 0;
    padding: 0;
}
.target {
]] .. css .. "}")

net.serve(8080, {
	handleRequest = function(request)
		if request.path == "/" then
			return {
				status = 200,
				headers = {
					["Content-Type"] = "text/html; charset=utf-8",
				},
				body = fs.readFile("tests/web/view/index.html"),
			}
		elseif request.path == "/style.css" then
			return {
				status = 200,
				headers = {
					["Content-Type"] = "text/css; charset=utf-8",
				},
				body = fs.readFile("tests/web/view/style.css"),
			}
		end

		return nil :: any
	end,
})
