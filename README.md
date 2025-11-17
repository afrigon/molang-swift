# A Swift implementation of Molang

A parser and runtime for the Molang language used in Minecraft resources.

> This implementation is not fully compliant with the specification. It's in a good enough state to parse and execute simple expressions used in animations.

## Usage Example

```swift
import Molang

guard let program = Molang.parse("1 + 2") else {
    fatalError("Failed to parse expression")
}

let runtime = Molang.createRuntime()
let result = runtime.execute(program)

print(result) // 3
```

