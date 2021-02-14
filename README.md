[screenshot]: https://raw.githubusercontent.com/awkwardpolygons/better-texture-array/master/screenshot.png "BetterTextureArray screenshot"
# BetterTextureArray
Adds support for saving, viewing and editing TextureArray and Texture3D in Godot 3.

![][screenshot]

# Explanation
Godot 3.x has very buggy behaviour when attempting to save a TextureLayered (TextureArray and Texture3D), it also has poor support for TextureLayered (TextureArray and Texture3D) in the editor.

Attempting to save TextureArray and Texture3D inside the scene or as `.res` or `.tres`, produces errors.
This plugin adds support for saving TextureArray and Texture3D as `.texarr` and `.tex3d` files both in the editor and from code.
These are the native Godot importer formats for TextureArray and Texture3D.

This plugin also adds UI so that you can create, view, edit and, save TextureArray and Texture3D in the editor.
The editor UI allows you to edit individual layers, and each RGBA channel on a layer as well. This is very useful when trying to merge multiple PBR material textures into one file.

## Extras
The plugin also provides a custom importer for TextureArray and Texture3D.

The builtin importer requires a large single image with each of the layers as a tile in a grid.

With the BetterTextureArray importer, you can use a simple `JSON` build format to create TextureArray and Texture3D from a list of other image files.

# Guide
## Installation
1. To install copy the `better-texture-array` from the `addons` folder to your project's `addons` folder.
2. Open your project in the edtior and choose Project Settings... -> Plugins from the Project menu and enable BetterTextureArray.

# Importer
Create a `JSON` file with a `.ta-builder` file extension for TextureArray and `.t3d-builder` extension for Texture3D.

The `JSON` object must contain a `size` array property, and a `layers` array property.

The `size` property must have two values for the width and height of each layer.

The `layers` will contain URLs to each image file or resource to use for each layer. You can use a `res://` or a `file://` reference.

A simple example file:
```json
{
  "size": [1024, 1024],
  "layers": [
    "res://assets/textures/rock1.jpg",
    "res://assets/textures/rock2.jpg",
    "res://assets/textures/rock3.jpg",
    "file://home/user/assets/snow1.jpg",
  ],
}
```

The `layers` property can also contain a more complex blending object instead of a simple URL if you want to mix channels from multiple sources into one layer.

A more complex channel mixing example:
```json
{
  "size": [1024, 1024],
  "layers": [
    {
      "rgb": ["res://assets/textures/albedo.jpg", "rgb"],
      "a": ["res://assets/textures/bump.jpg", "r"],
    },
  ],
}
```
