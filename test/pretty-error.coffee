require './_prepare'

isFormatted = (exc) ->

	exc.stack.indexOf('  \u001b[0m\u001b[97m\u001b[41m') is 0

error = (what) ->

	if typeof what is 'string'

		return error -> throw Error what

	else if what instanceof Function

		try

			do what

		catch e

			return e

	throw Error "bad argument for error"

PrettyError = mod 'pretty-error'

describe "constructor()"

it "should work", ->

	p = new PrettyError

describe "getObject"

it "should return a string", ->

	p = new PrettyError

	p.getObject(error "hello").should.be.an 'object'

describe "style"

it "should, by default, return the contents in prettyError/defaultStyle", ->

	p = new PrettyError

	defaultStyle = mod 'default-style'

	p.style.should.be.like defaultStyle()

it "should return different contents after appending some styles", ->

	p = new PrettyError

	p.appendStyle 'some selector': 'display': 'block'

	defaultStyle = mod 'prettyError/defaultStyle'

	p.style.should.not.be.like defaultStyle()

describe "render()"

it "should work", ->

	p = new PrettyError

	p.skipNodeFiles()

	p.appendStyle 'pretty-error':

		marginLeft: 4

	e = error -> "a".should.equal "b"

	console.log p.render e, no

	e2 = error -> Array.split(Object)

	console.log p.render e2, no

	e3 = "Plain error message"

	console.log p.render e3, no

	e4 =

		message: "Custom error message"

		kind: "Custom Error"

	console.log p.render e4, no

	e5 =

		message: "Error with custom stack"

		stack: ['line one', 'line two']

		wrapper: 'UnhandledRejection'

	console.log p.render e5, no

	e6 = error -> PrettyError.someNonExistingFuncion()

	console.log p.render e6, no

describe "start()"

it "throws unformatted error when not started", ->

	try

		throw new Error "foo bar"

	catch exc

	expect(isFormatted exc).to.be.false

it "throws formatted the error", ->

	PrettyError.start()

	try

		throw new Error "foo bar"

	catch exc

	expect(isFormatted exc).to.be.true
