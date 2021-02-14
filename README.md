[screenshot]: https://raw.githubusercontent.com/awkwardpolygons/better-texture-array/master/screenshot.png "BetterTextureArray screenshot"
# BetterTextureArray
Adds support for saving, viewing and editing TextureArray and Texture3D in Godot 3.

![][screenshot]

# Explanation
Godot 3.x has very buggy behaviour when attempting to save a TextureLayered (TextureArray and Texture3D), it also has poor support for TextureLayered (TextureArray and Texture3D) in the editor.

Attempting to save TextureArray and Texture3D inside the scene or as `.res` or `.tres`, produces errors.
This plugin adds support for saving TextureArray and Texture3D as `.texarr` and `.tex3d` files both in the editor and from code.
These are the native Godot importer formats for TextureArray and Texture3D.

This plugin also adds UI so that you can create, edit and, save TextureArray and Texture3D in the editor as well.
The editor UI allows you to edit not just individual layers, but each RGBA channel on a layer as well. This is very useful when trying to merge multiple PBR material textures into one file.

## Extras
The plugin also provides a custom importer for TextureArray and Texture3D.

The builtin importer requires a large single image with each of the layers as a tile in a grid.

With the BetterTextureArray importer, you can use a simple `JSON` build format to create TextureArray and Texture3D from a list of other image files.

# Guide
## Installation
1. To install copy the `better-texture-array` from the `addons` folder to your project's `addons` folder.
2. Open your project in the edtior and choose Project Setting... -> Plugin from the Project menu and enable BetterTextureArray.
