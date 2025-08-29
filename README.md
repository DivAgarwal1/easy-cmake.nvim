# easy-cmake.nvim

A simple Neovim plugin to streamline your CMake workflow.

## Features

- Run CMake generate, build, and install commands from inside Neovim.
- Reads configuration from a JSON file (`.easy-cmake/config.json`) in your project root.
- Customizable CMake executable, generator, build directory, and variables.

## Installation

Use your favorite plugin manager.

### With [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  'DivAgarwal1/easy-cmake.nvim',
  opts = {}
}
```

## Configuration

Create a `.easy-cmake/config.json` file in your project root.

Example:

```json
{
  "cmakeExe": "cmake",
  "generator": "Unix Makefiles",
  "buildDirectory": "build",
  "variables": {
    "CMAKE_BUILD_TYPE": "Debug",
    "MY_CUSTOM_VAR": "foo"
  }
}
```

If no `.easy-cmake/config.json` is provided, or if a field is left blank, the plugin uses:

```json
{
  "cmakeExe": "cmake",
  "generator": "Unix Makefiles",
  "buildDirectory": "build",
  "variables": {}
}
```
You can choose to fill in only the fields you find necessary.

## Usage

The plugin creates the following commands:

- `:CMakeGenerate` — Run CMake generate step.
- `:CMakeBuild` — Build the project.
- `:CMakeInstall` — Install the project.

## Example Workflow

1. Create or update `.easy-cmake/config.json` as needed.
2. Inside Neovim, run `:CMakeGenerate` to configure your project.
3. Run `:CMakeBuild` to build.
4. Run `:CMakeInstall` to install.

## License

MIT

## Contributing

Pull requests and feedback are welcome!
