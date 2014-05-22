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

import openfl.display.Tilesheet;

import com.marshgames.openfltexturepacker.TexturePackerImport;

class TexturePackerTests extends haxe.unit.TestCase 
{
	private var frames:Array<TexturePackerFrame>;

	override public function setup() 
	{
		frames = TexturePackerImport.parseJson(
			haxe.Resource.getString("sheetJson")
		);
    }

    public function testFrameCount()
    {
    	assertEquals(3, frames.length);
    }

    public function testFrame1()
    {
    	// "Sprite1.png":
		// {
		// 	"frame": {"x":70,"y":92,"w":36,"h":86},
		// 	"rotated": false,
		// 	"trimmed": true,
		// 	"spriteSourceSize": {"x":108,"y":87,"w":36,"h":86},
		// 	"sourceSize": {"w":256,"h":256}
		// },

		var frame:TexturePackerFrame = frames[0];

		// Name
		assertEquals(frame.name, "Sprite1.png");
		
		// Frame dimensions
		assertEquals(frame.frame.x, 70);
		assertEquals(frame.frame.y, 92);
		assertEquals(frame.frame.w, 36);
		assertEquals(frame.frame.h, 86);

		// Rotation
		assertFalse(frame.rotated);

		// Trimmed
		assertTrue(frame.trimmed);

		// Sprite source size
		assertEquals(frame.spriteSourceSize.x, 108);
		assertEquals(frame.spriteSourceSize.y, 87);
		assertEquals(frame.spriteSourceSize.w, 36);
		assertEquals(frame.spriteSourceSize.h, 86);

		// Source size
		assertEquals(frame.sourceSize.w, 256);
		assertEquals(frame.sourceSize.h, 256);
    }
}

// Runner
class Tests 
{
    static function main()
    {
        var r = new haxe.unit.TestRunner();
        r.add(new TexturePackerTests());

        r.run();
    }
}