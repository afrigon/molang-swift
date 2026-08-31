# molang-swift

Parser and runtime for [Molang](https://bedrock.dev/docs/stable/Molang), the expression language used throughout Minecraft Bedrock resources to drive animations, particles, and entity behavior. This package parses Molang source into an abstract syntax tree and evaluates it against an environment of structs holding variables and functions, so Swift applications can load Bedrock content that embeds Molang expressions.

> [!WARNING]
> This implementation is not fully compliant with the Molang specification. It parses and executes the expression subset commonly found in animations.

## Install

Add the package as a dependency in `Package.swift`:

```swift
.package(url: "https://github.com/afrigon/molang-swift.git", branch: "main")
```

Then add `Molang` to the dependencies of the target that uses it:

```swift
.target(name: "MyTarget", dependencies: ["Molang"])
```

## Usage

Parse an expression and execute it:

```swift
import Molang

guard let program = Molang.parse(code: "math.cos(45) * 10") else {
    fatalError("failed to parse expression")
}

let runtime = Molang.createRuntime()
let result = runtime.execute(program)

print(result.floatValue)
```

The runtime ships with the `math` library and empty `variable`, `array`, `temp`, and `context` structs. Values passed as context are visible to a single execution:

```swift
let program = Molang.parse(code: "context.speed * 2")!
let result = runtime.execute(program, context: ["speed": 1.5])
```

Expose custom structs — a `query` namespace, for example — with `setEnvironment`:

```swift
let query = MoStruct(functions: [
    "health": { _ in .float(20) }
])

runtime.setEnvironment("query", value: query)
```

To inspect parse errors instead of getting `nil`, drive the parser directly:

```swift
var parser = Molang.createParser(code: "1 +")
let program = parser.parse()

for error in parser.errors {
    print(error)
}
```

## Development

```sh
swift build
swift test
```
