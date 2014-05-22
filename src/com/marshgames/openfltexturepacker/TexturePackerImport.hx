// Copyright (c) 2014 Wayne Marsh

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

package com.marshgames.openfltexturepacker;

// User types

typedef TexturePackerFrame =
{
	name:String,
	frame:TexturePackerRectangle,
	rotated:Bool,
	trimmed:Bool,
	spriteSourceSize:TexturePackerRectangle,
	sourceSize:TexturePackerSize
}

typedef TexturePackerRectangle = 
{
	x:Int,
	y:Int,
	w:Int,
	h:Int
}

typedef TexturePackerSize = 
{
	w:Int,
	h:Int
}

// Importer
class TexturePackerImport
{
	public static function parseJson(jsonString:String):Array<TexturePackerFrame>
	{
		return parseJsonObject(haxe.Json.parse(jsonString));
	}

	public static function parseJsonObject(json:Dynamic):Array<TexturePackerFrame>
	{
		var structuredJson:SheetJson = json;

		var frames:Array<TexturePackerFrame> = [];

		// Read in frames
		for (key in Reflect.fields(structuredJson.frames)) 
		{
			var frameJson:TexturePackerFrame = Reflect.field(structuredJson.frames, key);
			frameJson.name = key;

			frames.push(frameJson);
		}

		return frames;
	}
}

// JSON parsing type
private typedef SheetJson =
{
	frames:Dynamic,
	meta:Dynamic
}