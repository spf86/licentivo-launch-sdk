module launch-web-example

go 1.26.0

require (
	github.com/spf86/licentivo-launch-sdk v0.0.0
)

require golang.org/x/sys v0.41.0 // indirect

replace github.com/spf86/licentivo-launch-sdk => ../..

