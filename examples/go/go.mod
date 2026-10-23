module launch-example

go 1.26.0

require (
	golang.org/x/term v0.21.0
	github.com/spf86/licentivo-launch-sdk v0.0.0
)

require golang.org/x/sys v0.41.0 // indirect

replace github.com/spf86/licentivo-launch-sdk => ../..
